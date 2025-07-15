Return-Path: <linux-kernel+bounces-732242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D158BB063EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8A2188E76C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227C924A046;
	Tue, 15 Jul 2025 16:09:40 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F40248F7E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595779; cv=none; b=LDxu3A0zgmShoWD8PTqSuI/NFF6D0SFvnN1qy12hA0a1iBmPS9zb2yt4ShmguYlA9ZBGqD4TGZAxv29RazQ0xhVnnXuv3HL0BkGUb68nxGHLSmBODZl+LXvVw2f4sXfDdXewVE1vkR4IGtwgMdlSr470vGs3P0guD10Fb4gF2bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595779; c=relaxed/simple;
	bh=hXQmcekkUptiZlFElQxdMyzsM831my4o8zwAjfUs5k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMd6/m4EJhDdxXY+gFWOm+UcuR6Rs0ArLf6n4XkydBhLAeZ+ipeomvFgFoLUubHZ5/UnYipfoM5fwxqSa1ysjeypX+dI2MKtKC0ftdlTuO1mY0i1/4xtG8qWYDg2XL0HzlVUiMWjUJIUhQ8lEj3Tup3qSs6DUtLEJKcC4LTaaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae3c5f666bfso1001476166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752595775; x=1753200575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL4wSRtPtkNOyj5ARmviH3RFGE0B4hQu0q3BGeMkrXY=;
        b=mBxTeZdMbiFeqtTbaDOHANOqcN8Ik/afCnx9IW7hcGHhTkIvQDvccTmrDV2qmBUR6h
         ksmdoz4EatgV/qejH5sPohH9uh4X+g2Hk5evYGmMk9qvJceye4GkvMvDqm/x87yIpIHm
         rvg1jrkFEA9q19Y0F13eF0+j/dmV76TNQ9H6PkWbheFUbnFngoiX/0tvla6u/17FH0fz
         pntrBH24Vz/qiJlhhnnRam6w+hxtXc4LW++mY2wv+mQz552Q/L8vxV59eNLCi/neothH
         aTCU3Lm+SOLO/CjMZN2pwOp4V8XfI1BaumPu0y7Du721ahYUibXjpGM0gGpEaXrrziZA
         MRBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP/f3tLgnugGW7boWsaIp7WMGTMTRuqGfEIasdUyccHbowM50QKyAL4dHmcDEkRbMZsj80aNfpzIF5lJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwleP8tX/yPBRLC6yXRtXCXR8B+1/rTTC2q2L1L63uzxjsKYiyg
	mwyjo7L8yVcGmb13uXw18lkmvx5Ymvn6yH/9faYb5srefY+zUSlttwf1
X-Gm-Gg: ASbGnctAexGpvEKAo3DK20i1+DhQLcpes9lek30IUB2GFD4dyVhDCgvSbBqjNxH4xQD
	25jtKqSqrY1ZK6R009BYWUOzO5/VTWVM9HJsprrkSQzjPcg2ed+NgSMAwgdslOlOXZE24uFKYUN
	qCvKKNJFMxnn6SsjDD+//PWONflZCTyIRv5Qaeecltvo5iIdXRaNfC+k2yQnqe6AhXTXElXJ/uO
	QH1wwD5dW7aqNohZj6zwDjjvufQGGdKADBvzOyBIsTS/JZ1n/G8+SKngrnoWOr7CbBa/ZeJFZ+u
	kP83I+xjhbgVPlB37eAXGjf4fMjTP06zFEZi3/ZJ8iG/TwESLm5Fa8Dxj4bZ8ocULfiABRvXkXU
	KJokTru/IhEDai7ME95wwb4E=
X-Google-Smtp-Source: AGHT+IE1uu7wwwSQuObs3SyvQf1CQnWwPhqS50eFzItnbnbLMZnj4W2EefIlYTGUtl2pAQDm0q9ODA==
X-Received: by 2002:a17:907:944c:b0:ae0:b3be:f214 with SMTP id a640c23a62f3a-ae9c994a31emr8267466b.9.1752595774660;
        Tue, 15 Jul 2025 09:09:34 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82962acsm1025469666b.139.2025.07.15.09.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 09:09:34 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:09:32 -0700
From: Breno Leitao <leitao@debian.org>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	osandov@fb.com, leo.yan@arm.com, rmikey@meta.com
Subject: Re: [PATCH] arm64: traps: Mark kernel as tainted on SError panic
Message-ID: <dswbcfrlrrhikpjjrr2aluipb7qn4stfmrept27nr2b4egeg3x@pgt73zwmfm7x>
References: <20250710-arm_serror-v1-1-2a3def3740d7@debian.org>
 <aHQ3Lu27_mLfR8Ke@willie-the-truck>
 <t3v2xvjal67bl5dwyatwgf46tnr2ikxnq62iqmda544llcd7oh@ws3nnrfp7r5p>
 <aHZfZbxLGyFjJpNo@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHZfZbxLGyFjJpNo@willie-the-truck>

On Tue, Jul 15, 2025 at 03:02:13PM +0100, Will Deacon wrote:
> On Mon, Jul 14, 2025 at 05:26:43AM -0700, Breno Leitao wrote:
> > On Sun, Jul 13, 2025 at 11:46:06PM +0100, Will Deacon wrote:
> > > On Thu, Jul 10, 2025 at 03:46:35AM -0700, Breno Leitao wrote:
> > 
> > > > --- a/arch/arm64/kernel/traps.c
> > > > +++ b/arch/arm64/kernel/traps.c
> > > > @@ -931,6 +931,7 @@ void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigne
> > > >  
> > > >  void __noreturn arm64_serror_panic(struct pt_regs *regs, unsigned long esr)
> > > >  {
> > > > +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
> > > >  	console_verbose();
> > > >  
> > > >  	pr_crit("SError Interrupt on CPU%d, code 0x%016lx -- %s\n",
> > > 
> > > If we're going to taint for SError, shouldn't we also taint for an
> > > unclaimed SEA?
> > 
> > Yes. I was not very familiar with SEA errors, given I haven't seen on in
> > production yet, but, reading about it, that is another seems to crash
> > the system due to hardware errors, thus, we want to taint MACHINE_CHECK.
> > 
> > What about this?
> > 
> > 	Author: Breno Leitao <leitao@debian.org>
> > 	Date:   Mon Jul 14 05:16:55 2025 -0700
> > 
> > 	arm64: Taint kernel on fatal hardware error in do_sea()
> > 
> > 	This patch updates the do_sea() handler to taint the kernel with
> > 	TAINT_MACHINE_CHECK when a fatal hardware error is detected and
> > 	reported through Synchronous External Abort (SEA). By marking
> > 	the kernel as tainted at the point of error, we improve
> > 	post-mortem diagnostics and make it clear that a machine check
> > 	or unrecoverable hardware fault has occurred.
> > 
> > 	Suggested-by: Will Deacon <will@kernel.org>
> > 	Signed-off-by: Breno Leitao <leitao@debian.org>
> > 
> > 	diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > 	index 11eb8d1adc84..f590dc71ce99 100644
> > 	--- a/arch/arm64/mm/fault.c
> > 	+++ b/arch/arm64/mm/fault.c
> > 	@@ -838,6 +838,7 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
> > 			*/
> > 			siaddr  = untagged_addr(far);
> > 		}
> > 	+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
> > 		arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
> > 
> > 		return 0;
> 
> Yeah, I reckon so. Probably just fold these into a single patch, though.

Thanks. I test it better tomorrow, then send it.

Thanks for the suggestions,
--breno

