Return-Path: <linux-kernel+bounces-749067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BF4B1499A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797D53A99A6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC726B74E;
	Tue, 29 Jul 2025 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RklG3KhH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891312192FC;
	Tue, 29 Jul 2025 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775819; cv=none; b=cUwjye6DvcYiou/A8sE6jpEtY2HT6nDaHSE5V8sX5GeQLyZtOJV+m55ltEhj5YFDf6ASjTxYCckp7cCU0iQ+DllylU8c5g9w7e9vzsWUj6WKSrDRSv1xsMEeQ5jqBmVcpC/SCRHHoKVTBg8DWZq9sQhy82H7L7/A+3sOKutVQyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775819; c=relaxed/simple;
	bh=npIOaJvSmi4YJZFOcIiWmLWYcrUrACiFT+JLNhShhpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6NYA8k4Qp0pHBZi3pjQLzhGvw36krsN7a7xyOaV2GcABsbx1hHXYKvG65Bu4SecZ5dfeuvMbwt/x5o7LywwI5qNBXUBcAvyYk7oNy6T2AuI2jXif1mym/NLYogVPi/qB2Ym2iucy3KMzHNItrPhml6Yya3+P+IIp81i9ox335E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RklG3KhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92C6C4CEF5;
	Tue, 29 Jul 2025 07:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753775819;
	bh=npIOaJvSmi4YJZFOcIiWmLWYcrUrACiFT+JLNhShhpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RklG3KhHZTFCqLPorPMDBul+T2GPoK2u43fN5gzfOTSc22B9B8/vI42ZNkL1HFlqF
	 VoaEsrys3tmcjbpEGjxCH7r5IjW3ajpus39uXx+wibBoMRLPfequjLP3MWgpbAZSem
	 cOamrINbM28sFSRepzSLoFDLFtr5KYRydGD2KPgA=
Date: Tue, 29 Jul 2025 09:56:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, darwi@linutronix.de,
	sohil.mehta@intel.com, peterz@infradead.org, ravi.bangoria@amd.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/intel: Fix always false range check in x86_vfm
 model matching
Message-ID: <2025072931-recount-stifling-73e8@gregkh>
References: <20250729042621.6403-1-suchitkarunakaran@gmail.com>
 <2025072925-lint-agreement-77e8@gregkh>
 <CAO9wTFg_jCUZ+DxXVDM11_715r6ALJ=HyRXkcBxhGrBUo4iVUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9wTFg_jCUZ+DxXVDM11_715r6ALJ=HyRXkcBxhGrBUo4iVUg@mail.gmail.com>

On Tue, Jul 29, 2025 at 12:23:27PM +0530, Suchit Karunakaran wrote:
> On Tue, 29 Jul 2025 at 10:58, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jul 29, 2025 at 09:56:21AM +0530, Suchit Karunakaran wrote:
> > > Fix a logic bug in early_init_intel() where a conditional range check:
> > > (c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE)
> > > was always false due to (PRESCOTT) being numerically greater than the
> > > upper bound (WILLAMETTE). This triggers:-Werror=logical-op:
> > > logical ‘and’ of mutually exclusive tests is always false
> > > The fix corrects the constant ordering to ensure the range is valid:
> > > (c->x86_vfm >=  INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_CEDARMILL)
> > >
> > > Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural
> > > constant_tsc model checks")
> > >
> > > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > >
> > > Changes since v1:
> > > - Fix incorrect logic
> > > ---
> > >  arch/x86/kernel/cpu/intel.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> > > index 076eaa41b8c8..6f5bd5dbc249 100644
> > > --- a/arch/x86/kernel/cpu/intel.c
> > > +++ b/arch/x86/kernel/cpu/intel.c
> > > @@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
> > >       if (c->x86_power & (1 << 8)) {
> > >               set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> > >               set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
> > > -     } else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
> > > +     } else if ((c->x86_vfm >=  INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_CEDARMILL) ||
> > >                  (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
> > >               set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> > >       }
> > > --
> > > 2.50.1
> > >
> > >
> >
> > Hi,
> >
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> >
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> >
> > - You have marked a patch with a "Fixes:" tag for a commit that is in an
> >   older released kernel, yet you do not have a cc: stable line in the
> >   signed-off-by area at all, which means that the patch will not be
> >   applied to any older kernel releases.  To properly fix this, please
> >   follow the documented rules in the
> >   Documentation/process/stable-kernel-rules.rst file for how to resolve
> >   this.
> >
> > If you wish to discuss this problem further, or you have questions about
> > how to resolve this issue, please feel free to respond to this email and
> > Greg will reply once he has dug out from the pending patches received
> > from other developers.
> >
> > thanks,
> >
> > greg k-h's patch email bot
> 
> Hi Greg,
> I've a question regarding backporting this fix. Can this fix be
> backported to stable kernel version 6.15.8? Also, should I send the
> backport patch only after the initial patch has been merged in
> mainline or linux-next?

Did you read the document that my bot linked to above?  It should answer
those questions :)

thanks,

greg k-h

