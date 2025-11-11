Return-Path: <linux-kernel+bounces-895992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A045DC4F73B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D354189D626
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D696027F010;
	Tue, 11 Nov 2025 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="wBgetCe0"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3327BF93
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886033; cv=none; b=raPkyOmeO0H3T+NZNkrvLY5pXDKkQB6EsdBR41V5iL4200sZuIOvaCGmSHST/pH9lYPwa1Ev3xRv/LGRvpp7fyIBJwoWRFg07jt1sfVbkdHkIIYON2Zi0KEprNeg2eSXEfaTFTYfmzsCeAB/7TUg8On+9FF0na5Y2yCQntuCfag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886033; c=relaxed/simple;
	bh=pBVOS/SepbH40xJUmfX0ZVqtQ0pPFCREKy8C0yb+qsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ew1v6FwFRahrMmE7rBaLTYHcBeq78aufsosqftFGEN8C4gUUICz+nfe0Ie5jQMxhSoOk8dIi+K5ULL32M/qts23B2gx4w7C7VRQZMRHFQZlXrpLRLpljvCbr3Ft/Vdbb0cxj9ymLBKbRuRL5bCTwxnt+dt7zElBPg/zsqi68lRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=wBgetCe0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so8159366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1762886030; x=1763490830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AcER7olAeM4Hg35J9yaU4mQhqPClLIDJZWM1CqRDI7A=;
        b=wBgetCe00aDdfNpVsZe4f/iMNtN9x2rCfxHPkEYmQ5QLMsPFAUvXgRKK7VOihXIovD
         kmlAaDM427J2mQiWViaz9wv6d1DBJ7md0OmqiUrCsMx+NG0aNSfrEXgNk1f93cmUO4Sc
         /Yig0fCwVd+5JGYG+XS0kJ7l1sel1rPbmCgCYV96UgfkHJL0nu10VHGoq2OdQwnTyJou
         5sgJ+aPd/gItF/Ite+6iyHUMPM3Lcguso1JWgqPU4XDXyVri5+WDoLQ0Vw4QWDlInf8j
         xhMXxsWgLmbzLY5+OyFR8Nf3RiPZ7n6blzHwkqb7Gm4khlT3wRxP5+h5EpUkQkiEL7h5
         Fu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762886030; x=1763490830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcER7olAeM4Hg35J9yaU4mQhqPClLIDJZWM1CqRDI7A=;
        b=r7+3LjO5kDxJRMrx1dbTAmGzO5IBuxfBqXXvSwjMFJAnnxDovHAAKK3hrRcrcdLM1O
         JDy3QP3FgObW7JMYXvGh/qn/mkRwLl8lpmKo/unjr3Jfy/xYsokO8CsnRmg/dwB0NRtR
         7BKhaq771gkUZbBTsKPaHMszxT/0MnzIAjaYsz6SoluiJrRAkjU4DST2BScSjMKAGMpE
         XQGQ3cVvr9dEpfoMX/6vxvIX/mgouCcYUhhub75KEis+oraTpB7nsoM5nm8kW0SdGqTv
         MbEnCPOMmhY/tX1CC3m6Qe1i0cIITL92Lh3IO1f7ZZCqxaZ2a9rM4Unu0A++S2IJ/1jl
         D2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCU5ndbR3PUla235TXdQna2ceQDclA9LbS6UNVigG2Yf8ah0HcYh3C9nnSULJKkRLEoBGJkJhm2Gw+rASTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv1SVBf88vdV6rlCeWv5jM6ADt7pONB9SZRhaV8CBRGl2XTJXB
	QSQpHtWWf1rE92a8jIZ8kqTIwdlVdllTDPUIBn8K1dv+uykLjuVbdF78b7YTo5c2fcnIER4Bba6
	dxK3mohpRCLRE9omLWk/s9+fXKJqxbsZtx6yD2wICEw==
X-Gm-Gg: ASbGncsd8qNtTF5aZOwjDNFWfRN4RmK709AgKX/iB3BrH80kscxfmTN1Iy+j7+JFCYy
	P+OjK/giHtdmRi+/5U8ezB5wufD7uNqFlSJt1A7TZMqLvsbEPU+2a0F+xhyJVFN5cT4rwE8f1za
	+8p507f6HdaYqpaPO2uREEmoGOKS9f/byml6RtJwbBbW//eQCwNzBuHx/3lPR/rqX3UfqGkDfed
	lI+mJ10jwCSMQ3liSJc4Nqdsu8h6nvbiBJ9NL+0Fy52FxxdMN6YiXPIYlPtVBlCVy0pbYrivw==
X-Google-Smtp-Source: AGHT+IGW3rnwRPb8WEwNqTyz1wwfAn5KHqqYxBaDlV78zmJCWuayX9a8ksHIrQUncY5Ow5tnnTpTxNuBcC0v9xLmqNI=
X-Received: by 2002:a17:907:3e93:b0:b73:2299:b891 with SMTP id
 a640c23a62f3a-b7331a048ddmr11999466b.8.1762886030014; Tue, 11 Nov 2025
 10:33:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111004536.460310036@linuxfoundation.org>
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 12 Nov 2025 00:03:13 +0530
X-Gm-Features: AWmQ_bmgKdP63t7tWapnOHZkHv4fUMORWDcztPTMRDI9ccR9qOGODxwLC1UKFvk
Message-ID: <CAG=yYwk7yJ3M+RhhQfUoPnCMBJyThff-8zGFq4Q7MmsB4hb8fA@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

 Compiled and booted  6.17.8-rc1+

NO new regression and issue from dmesg

As per dmidecode command.
Version: AMD Ryzen 3 3250U with Radeon Graphics

Processor Information
        Socket Designation: FP5
        Type: Central Processor
        Family: Zen
        Manufacturer: Advanced Micro Devices, Inc.
        ID: 81 0F 81 00 FF FB 8B 17
        Signature: Family 23, Model 24, Stepping 1

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

