Return-Path: <linux-kernel+bounces-894178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7D7C496C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D0C188F3D3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBD132ED41;
	Mon, 10 Nov 2025 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mGgvZe7H"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAC32FE59A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810469; cv=none; b=kGQb7vIV+cxjXDiqRB2oYRAb4yzEpyrOVCa9kt0R3+o3vIAeUQJHY5Tm5ZJAHuXVXyoQ5uvgLzW6FYZHCuvIKZFnRCiuikiVty12AXqjy5l9+vBlshrrpGFVs8xppTpMpjlzRhtMwZ3VKwwlAp96EOajlHETqEZFRRVXO1QpTsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810469; c=relaxed/simple;
	bh=szXidnfSHp/ow84h94BRGf8QEsQDbBaKUG46IDLxhUs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=Gek5LjKBKzAGl+2F2sKZCxfkE3PiBz9v5wVCCfG2Z61qISoJ1ubs2iZCfa5Vs2mzpw1fQNDzaAF/9BvTsKHZ/4uKFj5SMBAg7pa6kIF+l6rsh9ItFYY00mKR4U6p2+dN3KLFXhOZT3yRj3LxTr5bOC8hOwUyXIS9Xv1T52cmz98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mGgvZe7H; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-94895f6b144so95073839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762810465; x=1763415265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szXidnfSHp/ow84h94BRGf8QEsQDbBaKUG46IDLxhUs=;
        b=mGgvZe7HV5wPQgQ20lPLVdR7VFp9qYlH4aDQrkoYE4RDBDymV9iO90rFGrQaCqtx9G
         dFdKivTcYRIU5+wXUJSokiHdoVU2Yb81wVSN1tAI3eohfcMnBpjuxKVUerNhYFkaEQKK
         zUzUJC36jEj96dwh5vsnC7SaIDr/tfQWH5W0ORTWtcV1h+ClhITLS481pynB5ut3Ju5E
         PgIiRriFIXF/Nkfg+LwOQ1bU0BO+t18Pb50mWXuJbE8oYr2Rh51Ta/btJJY2E3bT5X3g
         teAcfONbq/P+NBFLq1nFQmrvlmVrFAmTC52ui9Ni3PwzI0qNDHLbT1epQxZ+O4c1POHZ
         T8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762810465; x=1763415265;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szXidnfSHp/ow84h94BRGf8QEsQDbBaKUG46IDLxhUs=;
        b=TqMg22GYqbtX75aayqbPpYfiRAJNazeK12J0V4/TY8E+KRGE68gnEExV4gDT/oJzVW
         IRzNyklNXNil5k2MIlGBQ1pthOlGxZuqpw4Twue4Ryf8pzgICRUzl4MHM6zW/H72qSzx
         EJI4wLZDmBejv/3h/pROlNRyApdkL0SG01cckiwSzDqr5HRf1xoMBuYL5n1xIMqgEvLc
         QtKZdXHqUaOgt+TSGVEecs8NZz72/0W3IjtqoMM4EzpwFTJdV5V7gfsF6WKxf8a/0qHo
         GNUeZHbYR35UzFWRs1O9MG0hhUeYFM6VkpYGRn5Ki+F0w4mc5kTR8twtSRXI9OCFcOUi
         RNCw==
X-Forwarded-Encrypted: i=1; AJvYcCUyYJIpheWPAvmHkDAv3b4GQRgdXV11TaOfU9wL0CkSOfYk9Bl+8C/eonGRq1g7Gkgy78V26j0hJtIv55o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzK4Q54UNRi9HEq29LVGji08aZWmA+qZVtmDHhmIy9w5WIo2br
	zXOeSjqNsgH6NL+yX6pENHcWNgMwRu3R/Zm4oQSZZfXGkYNWRO/LvuJcFrzkxAT9iZWDpavX/RV
	A7Gln
X-Gm-Gg: ASbGncvXZux6F7tVcqSMznH2ZjlPvQBFjJOHBJWTblACs9mJ5KOi0k0V1fUdNWyppS9
	kDOcdVYoQl2Y6u37BIl/pUMWpLyYVVfxMQXO8bR8une/m2n0njGbCJZ+XnI4A6GfH6jQKwjb3no
	OLZA6ifxmoFE4eTCrP1ZTWntbVKJLwOcWYsIkd1Cf91Xwxb565zTlNV7PdcVzZTwYfyurdb1zb+
	c6BMG49WjJVrym2FDuQ1vwZui21mD33HipHPs/7nkjvCrjPSyEK4MKQZpPZ8RgrfzgVgoJGk8Pc
	rNBFOaRh8OaM/5XAePTaQ57U1CO7Ppy3sysWy94Coz6OaHgR3ngQ8lpjARXdvCIgxMgCVqeFQJE
	7jcrqT2ZT4uFnyTVQee8ceSKEg2ksGB29o2S+sV/crYOYc1l3dbXYmgLR22NzP4aHoKTdPOnUDt
	kgZlL51tE=
X-Google-Smtp-Source: AGHT+IE0TV2i9Xac0yWSg0XTjz2YaCL69PoVAkX/+DCduYMIl8DU/riyRFfLs42dKGATdWiTSQDxvg==
X-Received: by 2002:a92:d28c:0:b0:433:6fe2:6b00 with SMTP id e9e14a558f8ab-4336fe26c15mr86442765ab.5.1762810464979;
        Mon, 10 Nov 2025 13:34:24 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43375501326sm28907245ab.5.2025.11.10.13.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 13:34:23 -0800 (PST)
Message-ID: <d9753537-b2d6-450e-bd7f-7bd86dfbb7fe@kernel.dk>
Date: Mon, 10 Nov 2025 14:34:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] [io-uring?] memory leak in iovec_from_user (2)
To: syzbot <syzbot+3c93637d7648c24e1fd0@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <69122a59.a70a0220.22f260.00fd.GAE@google.com>
 <bb64cc89-194f-4626-a048-0692239f65dd@kernel.dk>
 <dc9790ff-70de-470a-b4a1-d85dc5b1cb23@kernel.dk>
Content-Language: en-US
In-Reply-To: <dc9790ff-70de-470a-b4a1-d85dc5b1cb23@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git io_uring-6.18

--
Jens Axboe


