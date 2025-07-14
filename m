Return-Path: <linux-kernel+bounces-729983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 597AAB03EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C67E3B98D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB57E248867;
	Mon, 14 Jul 2025 12:26:49 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D1A2505AF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496009; cv=none; b=lu/RKB/L7Xg4IVQK+IkxmM5tgoUugCN6dzgF2dMf0S4ff6xSqwe4LssgEyciCiF8ICvuADvuYq6cnb6Muuz9iJ571o96mpSsibGKgj109kU6RlhsqmxPTmXg+R0MQpCGMgNkK/CaRCqVsNg2i2aX2XbOTDfCCphln+Mu3w5Bx9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496009; c=relaxed/simple;
	bh=geCWWwH0arpA22DnwfMxhPTu5sKZa9xKz8Yr67PxRKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhmhz74feOS4gyUadmy18559Yb+FpO3onysAswrmA/NLY1KacaQo5lI20Pe/vBQ12g6CZStnfotkemdrPEHR9/yktnXnJ/YDJ/MeFj5S3sEw1sEQm8Y5ObhHgZVEEnPcX6FZ+dg8LAyHtr5ls+tRUMfjj2iXf5iqaqhTgkw2RPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae708b0e83eso472068666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752496006; x=1753100806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXM71qb1m31nhbK/n/pQAgPefokwfSf5HDbhfJws+L8=;
        b=UzBJ8yO00rBih/353UjKeUglbghNtwKA8ZFVYXcMUF1Lg9N2aBSBzFfppliERwUuv1
         /TGBicii6E0I7duJRMScZ2DuJBY3SwZc01C/TWHyfMPm2ZMbQ32bemTPJDOtuOhXFnoG
         8TsUZGT+IyObrOj+5Ftm+fnNZJXe+6bBXsEl3W/7nyGtaNZklT78hKTTVt5NUB9CX6sn
         STH0ZidyHXHr8pSBw2E+4fsWimg2ZcYN4Mg4EnfNEANVZXewJnz9Azkiqw80PIdKjP9o
         6a/N7l2eos9L/jM8jBoBkZg0IRmZpAhMiX8yL2PbxbcdusDEtRn3kha0OPgvnX9+ZNGe
         2egQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpC7jWxRwNIQwrpAfbrfyNWDYYS4S7myx3UkcdmTgis6n40f7U3w2SmCDZifyf5+22lOnTKILhhlrGSns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDt8H6cTEB87mDfy6R8fNdaXVhbqFE8n7rqJ1cb5fU6uCN5Miy
	ezWGYD3NVWqjSRLbvJ+dhVUMSJdD8jEPMs5sL98yQ9fodg7xA9AU8LwX
X-Gm-Gg: ASbGncscdbeh87at0AiIhm2gA4IqEuTrmOaxE6dBXhyvVwwqzRGawvSj6DYRmiJVdOA
	EzzcxLyt5w49hN8jIx/xa7YhYkMRXGPyIVlb553CeXnyBVPyOWnramwaRbewmAhpeXGS3/ylLI6
	hxGKRcvSS2AWuV+XaDTUxgrlREtdvbnZBYlTela9c7oHAzpm90qv9sd2dGlLlo9xLmDNPTNUv+t
	DjXPNeU/dgOfJoc8xyekkp95WbzZtTuUORkWYzgNGMDpGfZPMmPLBY0O7JfwA5L9V/wlfNdHHTl
	cOF8EMy9VLBSKXN3DWrDMx6946YSyHeZWS+e+9mVvt3ybUn6mT9MWXgOuhsWP6sq/WkyzRaPmnd
	QBQaWjohMpRWc
X-Google-Smtp-Source: AGHT+IEoLgaDTKdxcttV8XzUYG/9ga2nLNSfR1c0WihvMvxKRTbmzBUroVW9/c2rdS7BKkmgYDCKXQ==
X-Received: by 2002:a17:906:fe0c:b0:ae3:5212:c906 with SMTP id a640c23a62f3a-ae6fbe13960mr1432723166b.10.1752496005605;
        Mon, 14 Jul 2025 05:26:45 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91a1bsm811147066b.29.2025.07.14.05.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:26:45 -0700 (PDT)
Date: Mon, 14 Jul 2025 05:26:43 -0700
From: Breno Leitao <leitao@debian.org>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	osandov@fb.com, leo.yan@arm.com, rmikey@meta.com
Subject: Re: [PATCH] arm64: traps: Mark kernel as tainted on SError panic
Message-ID: <t3v2xvjal67bl5dwyatwgf46tnr2ikxnq62iqmda544llcd7oh@ws3nnrfp7r5p>
References: <20250710-arm_serror-v1-1-2a3def3740d7@debian.org>
 <aHQ3Lu27_mLfR8Ke@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHQ3Lu27_mLfR8Ke@willie-the-truck>

Hello Will,

On Sun, Jul 13, 2025 at 11:46:06PM +0100, Will Deacon wrote:
> On Thu, Jul 10, 2025 at 03:46:35AM -0700, Breno Leitao wrote:

> > --- a/arch/arm64/kernel/traps.c
> > +++ b/arch/arm64/kernel/traps.c
> > @@ -931,6 +931,7 @@ void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigne
> >  
> >  void __noreturn arm64_serror_panic(struct pt_regs *regs, unsigned long esr)
> >  {
> > +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
> >  	console_verbose();
> >  
> >  	pr_crit("SError Interrupt on CPU%d, code 0x%016lx -- %s\n",
> 
> If we're going to taint for SError, shouldn't we also taint for an
> unclaimed SEA?

Yes. I was not very familiar with SEA errors, given I haven't seen on in
production yet, but, reading about it, that is another seems to crash
the system due to hardware errors, thus, we want to taint MACHINE_CHECK.

What about this?

	Author: Breno Leitao <leitao@debian.org>
	Date:   Mon Jul 14 05:16:55 2025 -0700

	arm64: Taint kernel on fatal hardware error in do_sea()

	This patch updates the do_sea() handler to taint the kernel with
	TAINT_MACHINE_CHECK when a fatal hardware error is detected and
	reported through Synchronous External Abort (SEA). By marking
	the kernel as tainted at the point of error, we improve
	post-mortem diagnostics and make it clear that a machine check
	or unrecoverable hardware fault has occurred.

	Suggested-by: Will Deacon <will@kernel.org>
	Signed-off-by: Breno Leitao <leitao@debian.org>

	diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
	index 11eb8d1adc84..f590dc71ce99 100644
	--- a/arch/arm64/mm/fault.c
	+++ b/arch/arm64/mm/fault.c
	@@ -838,6 +838,7 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
			*/
			siaddr  = untagged_addr(far);
		}
	+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
		arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);

		return 0;

Thanks for the suggestion,
--breno

