Return-Path: <linux-kernel+bounces-843655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E5CBBFEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74D1C34C5A5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E855B1A9FA8;
	Tue,  7 Oct 2025 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XncjnnSB"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28244129A78
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800143; cv=none; b=Yb0+5ySlRDeceKSzQ3ZI/lEM3RUcW10VjZw7OZeFSQDpHbvhfhe6581WKXOguqCFF/g/KcKSM+SjPx5bN/EGe4EZIYQlaL6/novvNV18x7nxaJ4lEOC4xQq65yeQAG3BR5OmXmRQ+km2ZbeieWw2IUv2ys39QCzSnu/Fq0LpURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800143; c=relaxed/simple;
	bh=H/Vde5fSyegTVrxDL779b0Ekl1TqghJb8VzoeMUW5sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6dmn/rEADW+PxLjjyH9eiCT5r5xmf+W91dwUu/QS5M5/vx28WlRnh8HnduUQZf6EptUfUF97gDrBNLlz6obBpUg+3vDNluTv7honLp1mQNEgjSXJEYCtpxmUEzH66m9Q797FiWGnsXDDm3F4CMlcl18zCCggHQY1+JZqX4SvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XncjnnSB; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8e8163d94bbso4080520241.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 18:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759800137; x=1760404937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oeZtd1lS2iAL5Eb5txNbBPZr6F+hk2iic2qSNfSBlxc=;
        b=XncjnnSB2+L1F4/tJ8mSC8SG4h/oSIvs7toO039nd5FdscCP2C/rDKR1v0tEB/O20y
         f2CjZ1M04v9k5A4pcEyHSWgtEfzTnJpaAmNI001gtaNQiPtq+I1WzaMPse6RtfkJLg+b
         RW0ac9W6hRUw/b54tpR6IsZ7THsw6ol/d+tfv8tH8aU1aicHprE8jc1QyRbXo6g3Xdu/
         3CcccBd+MVYtakcehaMCi0lBPSxHGBrd12eIfHwUc2+KtRXZlsXa4c5ceCGiphpe+mnT
         hmA2oLhZ3Au9c/lvTlzhkdEB5yCZ5Sr2I6Qca9I3c7MAsgfsrTyDuvfDDkrHa2++7YRi
         n3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759800137; x=1760404937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeZtd1lS2iAL5Eb5txNbBPZr6F+hk2iic2qSNfSBlxc=;
        b=po4qity6mwx02QsqdcXNgK/cSNyrEvTLOfaP33ufF+X8d1bfWS5EYvtQ81exygg99i
         OJEognf8vya6zUsh8iV1j2jj+Ntgb0APqQxyivQjVBle6ozwa9mimjt0p4bbQDuZLxi+
         1hIVR0F08ZteFLE95zDErXa8FKE9ZP+6bSsKXEg2XWIaJcwFjieVZMPkYsD8eH/XTtRz
         o9H4+UQvFwVOeCIS0d8EDwz7U+F05YKKE2nl9yw7q/JxRIqe4u6F5rI6JfDtR3hYn2xu
         tzZGq+ODpq646VMCm0QczlKvW5FDavcb29jAQSP8Stbhw7V0Vkv3suExp53gsIqhAhPp
         ScBg==
X-Forwarded-Encrypted: i=1; AJvYcCXjcAk0VIPxXw5rN/TClaNj+0I2G+BwMe7JFl82gPnZaogB3bCEH1Rd9FMiPiTq/Uk9/o94ayyrbnnU4K4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrk1exSWDFo1Uja9siVEj6FIAuhqULeqAGlXt3lsVYfcnC6r4H
	+6IB2EXqEpd3sTd+SCek2UodHWtCeMgU38bxhIDm1U7gEJpIdtYIYFGD
X-Gm-Gg: ASbGnctKltBLfBkkt2gnbqPuj933TPD80+l1oP4uZ52GO0GmlIYKAf9NT7+VqPDfQGh
	dwBfJ41cxTrBo7IXOXBcLMa2aDjOTDvJP8FKOpw3QUFukBh4m6QEP+aNgtZJFuVbb0ZyYuNdCeg
	sBt3hdT/c76xS0gQFX67pyUsG1cYN+Wcu8YviPFmVcHbh7AE2PNDLmEEbOX5beKsCelcrmAkkUP
	K3Pa9TD6YK7bzOpqlOkRTXOl0LenrCAwIAgRuMxVuV3iwfKwY6/GjNrMnvIsnsIYw0bLxmJzukO
	6j9x9YwK2b7ygcLBkAzIBA7bJbK5D78UYkjtp5Qh6siQ4qxZmEvRRr+ANy4/baItpeHnT11hZcI
	xtmuiuhiZMzQ8t0fYGxkhyfMcmkxqjIhi9JoStYq3pNF8nEuOQ4IBV55Igr4j93A=
X-Google-Smtp-Source: AGHT+IFmBzhKhtg5t4PSLIdciapJfvhjo0L3FJBJCxbNlT3KY5aZygpXM3hCFzRlcEVz+ZGVmyRtfQ==
X-Received: by 2002:a05:6122:514:b0:54b:bc60:93f8 with SMTP id 71dfb90a1353d-5524ea2517fmr5491547e0c.9.1759800137067;
        Mon, 06 Oct 2025 18:22:17 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523cf6558esm3444393e0c.22.2025.10.06.18.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 18:22:16 -0700 (PDT)
Message-ID: <4124e1a5-fcd9-4ce3-9d97-5ebe8018207e@gmail.com>
Date: Mon, 6 Oct 2025 21:22:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: usb: lan78xx: fix use of improperly initialized
 dev->chipid in lan78xx_reset
To: I Viswanath <viswanathiyyappan@gmail.com>, Thangaraj.S@microchip.com,
 Rengarajan.S@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
References: <20251001131409.155650-1-viswanathiyyappan@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20251001131409.155650-1-viswanathiyyappan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/25 09:14, I Viswanath wrote:
> dev->chipid is used in lan78xx_init_mac_address before it's initialized:
> 
> lan78xx_reset() {
>     lan78xx_init_mac_address()
>         lan78xx_read_eeprom()
>             lan78xx_read_raw_eeprom() <- dev->chipid is used here
> 
>     dev->chipid = ... <- dev->chipid is initialized correctly here
> }

Please describe the testing you performed.

