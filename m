Return-Path: <linux-kernel+bounces-898619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFDDC5599E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9112F4E31EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C26A2877DC;
	Thu, 13 Nov 2025 03:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="GeVD/1ru"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50147E0E4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763006011; cv=none; b=bqxVOw6P8nJsO/CFpEkq9dV9Wl16Cd2Rmvzho1IyU7+lSia1n50azPxtWhz126/0UrXQ6E6UTD+FUQnwobmwQTVtd46WNTkVrxt1uI0+8Ge1O7QnPIdKpDI2ZiCjeik4uHQGMWPL/xJbnRWrpuKQWbi0peMxwpPzgkvPJMUOqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763006011; c=relaxed/simple;
	bh=y1LSPNobZQla9NMwQ5IY+yLjCJ+5sj+5zGOH9ueavJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/oMhbmwyVJSOU4KsUmA5PHaq1qVsAKvtqr96ZQsDpR54QxHaGEl8Lxy/LjHjGaK0YCDa816rpSk8xfSWn82PTo8MfyKmhoa5HPY8+LC6hpMLFHzX5EQCjanmzOvPFG2mmvfh0eTKdWw7XpwR+OVqEAoM+7HxWp0zXcueuOjxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=GeVD/1ru; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-88f2aebce7fso38124285a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1763006008; x=1763610808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CatzzopAdgFr+BsmM7xa/JPPEprIWTodqEFVEQgfQnQ=;
        b=GeVD/1ruUJRtJaqo5hmHR545FqUuXkmsGg92bLA4f/ORMTiC70RRihbQa72/KDD/Ql
         jUmCEa8Ek7bG5bPCIs733ZVPvLn+tX0v8MPgChGeSgXWyWbVbhq8u1+gdC602JzwkNMD
         fmsYJJUy1Q4yFOExPo5qJtQbXSx6g68qL3SHgg94An0RFLNFgDnxnd/2zzC+NxXLmDUW
         0/v3VdvClgqfBDTcrh9/DzqX+3A2tYWSRKDdAV10grbtnwuSxjErFKg3fBGdVxWrMNiu
         nQM6Y9AMCTMy1G+uzSh7FzIePJymtUoWf8+F/5rJtvqW4dIxYzuOthH54zPIXd5ERgG7
         fUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763006008; x=1763610808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CatzzopAdgFr+BsmM7xa/JPPEprIWTodqEFVEQgfQnQ=;
        b=qOvIPJIhv4nMpCjszkozn15XtKdoxbJt1lAHM5q/bA7gDK8Vqo88eK8XadYlsdhDWa
         /BER6O/1wQRA/hoyb5h4g4qGzTpM2do/P8YhpPcwgjqeE1b3MlmkmEjfEiGrkoZkZn3y
         yoNWQ691tdhHBuHsQAmekilwkLvEoXIKFXOCs2kKuqYIp6rdpS0oB+RixJkKpQJbi4tX
         JN1pgOSaJAPsCFbgji1N2jkRPZeRkY+9XlkOX8sz7YbQFVkmsYyFuSqt637ap5hw+ecp
         r2SqGu7Jw5Po3CZGyhJsQ+dlfTlplYcmyUiuilj9dEFcufSuGYJYyTEpHKdu8sK3evSW
         po0A==
X-Forwarded-Encrypted: i=1; AJvYcCU4hbLCfx6VyqfSHAxPdieSiCiVizTVcIKfnPGdvkBqt0IA8w7/18EBKMUZYURqNRvOeh3ot/2CC1BqOm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/iZAWUtBqQYh7bQs5o6IzJDvC9OlCmjkwMx2c0safZp8WACmH
	dnkFunsAi1OmYW5A/3nexdg1JLWFTokTQJcWzGO6cfXpjDJeFfXtEYKGoMsFhyS6Ek/1KLu7uH4
	Kd3Ei
X-Gm-Gg: ASbGncvva1/kIAG+LUEoeH+CRXERGzNVG8GaMhL5Flj5fy2jGe0/kW/TYXXWfqRK9y4
	HFJBJ8pHjRrrO4N/fozDEFmmZKV9uENtfWqy5jT1qnGrnmpB5mIsSVGLVWFuNRHVOLI3lUTRani
	/3GOQlWNBqFRkgho3Q407zJxb2IEYLpJqWBk7D79NBY8rQnumWjpiASyYkbRIDWrvkkZ5SpNji9
	D4zDRHAhGF8yZwpPR9DMifEIaq2hmLJ1DUsiQODV4oZ8Aiw4d3MFO4U/8C8PXDrzjNlOUqtJTr2
	3E26ZTlPvSWCBj7QlWD21DnP16az7Thbfxkw6p5lFaGSohMDMJqzflZOu8L0OK3gLt20ydYiI8g
	IlWxPlLKXLj5HG/U8AFmY73lPz/WsLxx2ErbRJX9TelY6BJrw4BVrxhG2sSa9GARZn73h5Hs6In
	PjojseDM+c6gWDsd7v7llcNneyNCTnRQ==
X-Google-Smtp-Source: AGHT+IGpleopjM4MDAheJaXpT7eQ+N9O9y3pHUJlCfRc6efZHo8evHnkFSfXUU+sWtqzH8WQFDcJgQ==
X-Received: by 2002:a05:620a:2902:b0:8a3:7567:bde6 with SMTP id af79cd13be357-8b29b84c1dfmr782009285a.84.1763006008363;
        Wed, 12 Nov 2025 19:53:28 -0800 (PST)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-8b2aee9e4c8sm53627285a.12.2025.11.12.19.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 19:53:28 -0800 (PST)
Date: Wed, 12 Nov 2025 22:53:26 -0500
From: Nick Bowler <nbowler@draconx.ca>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: mm: Prevent a TLB shutdown on initial
 uniquification
Message-ID: <tsok52tdbt3z5j3i6ht22iko3mdqeom2ojcvvb52pwfbjnzzyy@mcwnzfpvksee>
References: <alpine.DEB.2.21.2511122032400.25436@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2511122032400.25436@angie.orcam.me.uk>

On Wed, Nov 12, 2025 at 11:42:11PM +0000, Maciej W. Rozycki wrote:
> This fixes (at least) R4x00 cores if TLBP hits multiple matching TLB 
> entries (SGI IP22 PROM for examples sets up all TLBs to the same virtual 
> address).
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Fixes: 35ad7e181541 ("MIPS: mm: tlb-r4k: Uniquify TLB entries on init")

I tried this one too and it also appears to work fine on my R4400SC
Indy.  The system is booting normally again.

Thanks,
  Nick

