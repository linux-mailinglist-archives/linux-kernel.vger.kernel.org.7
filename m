Return-Path: <linux-kernel+bounces-763504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A926CB2156A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB36622EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD931FAC42;
	Mon, 11 Aug 2025 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="u2LsIQxp"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BEA26ACB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940982; cv=none; b=gHECH3qX+u2uayqcJnKDpCZGlLpOgDN8NxbBRHUA17pbHOZy2Blh7LvkvkDcFKndh+KWGeyoMx2yPJuxxNULJRNE4HxIIOG/b6k50OHTMYeNmToAity4pv/kOY+L/cekgF2GndzzDa4AAVTkBVUsaYpyCTPXwSoMNcHkHL1+8+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940982; c=relaxed/simple;
	bh=8K73JX6zEP6SRAyan6dWes1ext4gzAa3shsQ068bliA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=utnAKlXqtl94RiFJu0+fLCWOJ6hf4M6U4TwcyOR9RzZG4f3GR7IHPH8UpUFGSONQYRzuXZ5pcW8DiVgHBXrrpL67quQWFk+m+1qJZJoHB2K2g088q6iH0lOU3gWv5gJwXlbLwrNnC/TtltxjNqbQrKyP7kbbpgrKt73a8abTQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=u2LsIQxp; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-881a16741b2so317447339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754940979; x=1755545779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=72XMIxp5MKX6tXyD3i1bkwM+jKCX1HApq4l+CzM3U/k=;
        b=u2LsIQxptMtm7cO7TOY82mqNFmpD4eKgKsQ4MAEZlYvfRWzr7MwscoMqq+snDXM1jF
         9sT34V+hPHj0RWu9hHqh5qmybotjRObIsVLdWxZRVA0g99kBBZvZVjALowKNfmQqkh+/
         r0meKQ92sv3Xn9dZSC9zZ1/F4N7LqyuEPyuKSr8VfYMcnDe3fahGCzErCfAgtUTP+XcR
         2EnCDwu74K9CMIyPTLi0fDoXEfeG8gGJp9hn3KViECbIPt9GNuE4Hy8TP3KSFNjwIa0R
         vLrAmxactOEDNNBtNdHiawwF7Q4LDyGNygKSVySuF/zBpOorUL9e7ojuVR1lAGSfAURi
         CXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754940979; x=1755545779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72XMIxp5MKX6tXyD3i1bkwM+jKCX1HApq4l+CzM3U/k=;
        b=eeUACMpx4TFy+bhiDUO9j42EQ62x/thzKdJmrqKRXByvY6m9t0tBiMQwR6Vb9wXaUa
         ZahjjzNfUP/AXAClawWYW1JDf1B1LcDq6eduZSL45HOwxsPCNa+ZDSxWVCLHMaqpWUWn
         Wv9vVoOVhbXpMz4dCy19dXGZOSSlkI7JNvt71qYnetkl1i40BHH7mG3L2yCKtbUvZAzx
         nQ+aa5Ru8qYR5pEz5YREUz12rqeFVWKEm+vuvVLsDWz6HVRMJ3Ff0OR/feFhNxAST0Sx
         paGY3Sy8TvWXaEkS5hNtV6FgZl+D1UjnvqcPsKue3rKQHOyyD3QclLzQqRWI0yrgejQ3
         K7yg==
X-Forwarded-Encrypted: i=1; AJvYcCXo2FiDs+4uuwWpOiKjWFBvue4dIR7W3lxpx9M0xtUGbmMkmlbO9epZRIxdsNb5aK/TqLerXUpEFiy8unI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYNG2zooa7FtgmeMFfzATD4UrrBppPChU57//tFOo/dPXwIC6X
	nBFZkaDvpAARpzX5GPWrrTGzpss3Zz2m/2tF3J2RElAS+uuz39K5tVEh2yCtgGjyGMqeqSFovt6
	gieyw
X-Gm-Gg: ASbGncsHYE4GCpwc/uhTUdrFOB42CWrPFGGiAQiYumHF3RjgVIQ75fY+SvlMmAetcN1
	3Dc5NXD7RNlOsifGdisTe5tyV5l+96wHoyu8qQ7jX3YuNBcS8kNUohM8PWmIMceHXb0NhS8w7e8
	y50FvTGWlIeOfhE9Qd4YWqzwZe+YidaYWEBSnWGGqkw3LfKG0X+dwI8I/LAqrdR8WICU1uW+y05
	p7hEH+Z7J0ivxnWkwX2eJzk35qqs/TEiUm32ZrGCDxScOYAuqjpyMmivUh3BGVuCe0NoVS9dfHP
	lVYQZib/fT01oW2WYVKULskXCSmszOuSXJC1g7QqbMIikntuLZgn2qY+s45vmpakmxKv+HdSMTz
	5ncTITKF4woxrDIam/Io=
X-Google-Smtp-Source: AGHT+IFI7bcnv/xozr8FYwjYJ1+aBup0n49ZFQ4pkjS2LiRwJyXw7cO/+sILBX3oZiOsLnPV8ioakg==
X-Received: by 2002:a05:6e02:12e7:b0:3e5:4a07:e6f with SMTP id e9e14a558f8ab-3e55af460bcmr11076985ab.9.1754940979208;
        Mon, 11 Aug 2025 12:36:19 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e53e336735sm27720455ab.16.2025.08.11.12.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 12:36:18 -0700 (PDT)
Message-ID: <8cdcb529-54a9-427f-afd6-108207bbbe0e@kernel.dk>
Date: Mon, 11 Aug 2025 13:36:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] WARNING in vmap_small_pages_range_noflush
To: syzbot <syzbot+7f04e5b3fea8b6c33d39@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <689a2e53.050a0220.51d73.00a1.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <689a2e53.050a0220.51d73.00a1.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz dup "[syzbot] [io-uring?] WARNING in __vmap_pages_range_noflush"

This is the same issue reported last week, a fix already went into the
current upstream tree (and is in 6.17-rc1).

-- 
Jens Axboe


