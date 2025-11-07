Return-Path: <linux-kernel+bounces-891000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA3DC418CF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A45E84EE974
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54D30AABC;
	Fri,  7 Nov 2025 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="vaitNBo9"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FC43090E8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546356; cv=none; b=tayXwqQx7Eb6jllFfpNlXSGkdESM30vBCUNFhFhtRYe9zWSOF9ULAyahbjLaPqheWRFdkU/oSkezGOkFegJEPrWRUS3CuSuGNJeDpgYpMkAKI6RwJqvZs85Ur8OSeU+ilxhDI0X5HRdMXsnrYteVymaEdMLgM3S8t4IivA6bT+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546356; c=relaxed/simple;
	bh=xhuY738tZl353Xy0fNRI/QG1yk1TSCZTX05qyNUVL30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+FbFJ7qH7XiAwBSf9QrNB6Y/t/Z7JAr+tmp6XzcjfzmATAhf8VSWPQ64E+pbJlVulsJMQvzyKv+WaygO1/P6MSBoOMf303MuZMWrWatf31U48CNnnLrljbtCwfgW62Zsmg4NQOfdYGBupfmS/DYbVhl8slF9D3c+YD2cVB7Pwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=vaitNBo9; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b22efd44d8so128868985a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 12:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1762546353; x=1763151153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPIKY3pDWsZYiW/KD6AWR+JZdgeQXYTbfkJenmEgskU=;
        b=vaitNBo9rBs66HultLferXYUElO/jsbDUQ8OEDAsnkQTpHqaQ22X9HIFivEMgAQ9Dt
         q8X2xwWIdafUEBfqsiIVy9QFFTMsSc2uN1fX0YrAm46qRZhKJzbUz2XLVbUhgI+e+JXR
         FGl67rDPCCt2X87JgJqSKeBI0xK7156IYdcfOCWV3BwyNSyILGiVXb3YRrv8mGlcmkLr
         11codF3F3zHBxGti0S/bO3wObBNodnfo709ap2+odXUCe5hNXtXuczfLgzctGc1il5eX
         kdk2lPC/O39Up/PTnq2lkz0cXLUgJ4qBbXmVYMVx7a0pUpX2UO9Nmyjlt1WKixTXsE4a
         LMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546353; x=1763151153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPIKY3pDWsZYiW/KD6AWR+JZdgeQXYTbfkJenmEgskU=;
        b=jp3O7Od5CT/AtB3FT813mC3jdmJUacMy7AI4rYscQs2Ezu9RXOYXaHxJ90e7svWVD5
         j4EXNKi4hUIiKWAonjEIx4aLXu9bJ/3ZYO5ZiHOaYNC+0KXM7Rzc216Bac314URgKSHE
         OxELZqXG1w1Z4IoUcvaTwII+UREUBxmT4NuyFckjHBW7C4Emqa2VC7OPU78Tgwttt9Qd
         YyUOd/OVkhZk4l2hDa6zoKsyI00f51FDy/FFd7mfwGunSz7tX/6GlgO+68sD75okh/5K
         svzrVfStqD8F5tbN3E6VgmIJScU3EZScUHWTSur9Hw59kV9v6ntLWnKl9KUV7cOPWSQK
         lDyg==
X-Gm-Message-State: AOJu0YyC7NG4OPsBmtYDvV/OTURsQV3CMuaJD10NHoAC9QEOhsJVcDve
	kEMOmmfFFMZ2XDjR1S9GRLmEXhCyUiLKSkigfDN+5gGKeVcu2BT+18R9Nspjz9yKzBIcQd77Unc
	QyK0k/hw=
X-Gm-Gg: ASbGncsKLyRaR4rTTF9BlRkFMTPfpPdk+m1Sv4Mb8MuH6dMrnwtYptJtADc9E1kohQM
	APy9vhOCLdZmpbslu6EzNOHa8atNSZNVCzIgW+5sVvuqahO6WCOvCI+2J2DjuEN9Smj+b1/aPtH
	HvQA/4nKNW7l1kgm2PdXa/H5c+QRTN/h5Rpx/4eOLmOamFWQ8Skqs5W1j6DVyjYWZZf+WoKt8Ol
	M2NZ2d1Lc6TXVMP7vJs9CfFwLkZw6Y1ShWtAQf8jJ3EWOMe1/zlp0fKL2ZgGiUM76m/B43oG5Dq
	eiSdozG5gTxFi9XWPb286N4XzB5b1ieoFGEQ9gWv4zQN+Te4DkdPP/L4RBUTIoJWIYeik8GTzFQ
	AfL00qc6E+vl8aidOonmslmcL8Wp/aZpEbAbyYwQMZ3x4r1cKQ50A3Cb6udr/5xvvDUE6wo6K/r
	c3P/+H3wTX21719MI/LU6AMJO58bu4sA==
X-Google-Smtp-Source: AGHT+IFsLLiomLTVAKf0UK7Kqv+I/lwIiIqePUIuZ3D8VSGGRtsZSWpNNzYLl1SSmqIrjJUQd1Y7Lg==
X-Received: by 2002:a05:620a:44ce:b0:8b2:33bd:7331 with SMTP id af79cd13be357-8b257f68729mr69675385a.83.1762546353068;
        Fri, 07 Nov 2025 12:12:33 -0800 (PST)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-8b2355e9bb6sm476602085a.22.2025.11.07.12.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:12:32 -0800 (PST)
Date: Fri, 7 Nov 2025 15:12:31 -0500
From: Nick Bowler <nbowler@draconx.ca>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: PROBLEM: boot hang on Indy R4400SC (regression)
Message-ID: <ea6p4efuwbrlqjiwkgjcd7ofj7aahfnnvnkooo2il36ggzrlcj@n6mcofpb2jep>
References: <g3scb7mfjbsohdszieqkappslj6m7qu3ou766nckt2remg3ide@izgvehzcdbsu>
 <e4ed75c7-b108-437f-b44b-69a9b340c085@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4ed75c7-b108-437f-b44b-69a9b340c085@app.fastmail.com>

On Fri, Nov 07, 2025 at 07:29:25PM +0000, Jiaxun Yang wrote:
> Unfortunately my Indy won't go over ARCS prom so I'm not in a position
> to debug this on my side. I have inspected the code again and I can't
> see anything preventing it to work on R4000 family.

I'll try adding some extra prints to at least figure out where it is
actually hanging.

Thanks,
  Nick

