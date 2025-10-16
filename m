Return-Path: <linux-kernel+bounces-856002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B25CBE2CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2604D1A62487
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E23298991;
	Thu, 16 Oct 2025 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="GZW4dUfa"
Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE08521CFF7
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610719; cv=none; b=ALzsPFwTaiLiL1ZBIvGtC/FoDwYSnTStR7N2C6wQva68oUYTNmAp1xpQSKiz2gh/hog8a37b0as2+YzE52WBFFUfwAhDHhBh0fS0qw52xL/asnRlhERCEFpuOTexPM/nQhSE0niNMeChQIxECOrpPMytLN3xq4JWNQ1aEt9OTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610719; c=relaxed/simple;
	bh=lK91tCbsaJ9Y3ttFqc+5eXgajBo78fs3ryVwmNK/gqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmWE22C4Yx6cd7BwbPbee2P4gArhfXAFKL3SSTPIGsGqaIQgV9iWt/uqAiWgTaeI2EbgUB5WJbEJaXableFBOTzPwvOXSuVdPryrSNIuY7s6DFxlOgqkMxNS5hyl13M9dBYSnBgx9K7dG/AljUyhwBxyhnTvWOhMPtk7yEUh1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=GZW4dUfa; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tZadX9KsXjvqyl2I8mIRhFodWDQdiLWzoGy/khrUZKg=; b=GZW4dUfa+uMzK9pr7zj19xovrP
	X+3TKnv6gLi5OF7zq4ods9gxZVkz9lpbllf4w+B/LEow+mrHpw2HZhMLIVKAZYhLNRL/DKWiZXZf7
	4zKe4B/z49CjBCx9MWFPz6n2diDNVQsSC8IumAAkpcrjFsp5T+jkn+1UlH+lvek4IX99n9Z106F90
	eY0tsjG3PSrmHDemSGPtB32+YrnXgo+15LbdV7/dsXauGC+NNtMkVuVdImjlEo4/6+Mmth4Utsbxc
	6OZvB/IznmBXs4NUyK+iOGuMSrlUEWPvSyrrsnuC022TRBqY1sA4Xn8v5U95NP8wRyklN78POQC3c
	KqNeNYdA==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:43958 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1v9KmW-0000000EAyo-1HJ5;
	Thu, 16 Oct 2025 12:00:22 +0200
Date: Thu, 16 Oct 2025 12:00:16 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, 
	Aaron Rainbolt <arraybolt3@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Xiujianfeng <xiujianfeng@huawei.com>, xiujianfeng@huaweicloud.com
Subject: Re: [RFC PATCH 00/56] Dynamic mitigations
Message-ID: <lpv2uouli7b4zi4up5434mfdjngbvwbnn72vgyz47b76h2ac7b@uqlaa6mh7dfa>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251014231039.6d23008f@kf-m2g5>
 <LV3PR12MB926564CC5E88E16CE373185694E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <cnwawavsdedrp6yyylt2wqiglekwsgrofimkvh32fknj676xsh@4vyzzoky5hzd>
 <LV3PR12MB9265837FA51DFD9D2F11474D94E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <a5kvnas7cttg3pxqdxye7qhyesbtyulhhdiunl2hr5tfmecpbz@y4ggjfafqawn>
 <LV3PR12MB926513717F67A02278659F5094E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV3PR12MB926513717F67A02278659F5094E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi David,

> > > > On Wed, Oct 15, 2025 at 01:53:31PM +0000, Kaplan, David wrote:
> > > > > > If `root` is capable of setting `mitigations=off` via this interface,
> > > > > > doesn't that somewhat defeat the purpose of denying `/proc/kcore`
> > > > > > access in lockdown confidentiality mode? Assuming one is running on a
> > > > > > CPU with some form of side-channel memory read vulnerability (which they
> > > > > > very likely are), they can turn off all mitigations, then read kernel
> > > > > > memory via one of those exploits.
> > > > > >
> > > > > > There should be a one-way switch to allow denying all further writes to
> > > > > > this interface, so that once the system's mitigations are set properly,
> > > > > > any further attempts to change them until the next reboot can be
> > > > > > prevented.
> > > > > >
> > > > >
> > > > > That's a good idea, there could be a separate mitigation_lock file
> > > > > perhaps that once written to 1 denies any further changes.
> > > >
> > > > Wouldn't the enablement of lockdown mode effectively function as that
> > > > one way switch?
> > > >
> > >
> > > I'm not too familiar with lockdown mode, but that gets enabled (with
> > > right cmdline options) during boot right?  I guess the question is
> > > would we want to allow any window for userspace to reconfigure things
> > > and then lock things down, or say that if you enable lockdown then
> > > this interface is completely disabled and you need to specify your
> > > mitigation options on the cmdline only.
> >
> > Yeah, I would say the latter, otherwise it defeats the point of lockdown
> > mode.  Note that lockdown mode can also be enabled at runtime.
> >
> 
> Ok.  So that's using the security_locked_down() API presumably.  And what reason would we want to check for?  Should it be LOCKDOWN_DEV_MEM (since we're potentially leaking arbitrary memory)?  Or a new lockdown reason?
> 
> --David Kaplan

LOCKDOWN_DEV_MEM is an integrity reason and should not be used for this
scenario.
I'd rather like to add a new Lockdown reason in the confidentiality set,
maybe LOCKDOWN_CPU_MITIGATION ?

Thank's

Nicolas

