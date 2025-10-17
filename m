Return-Path: <linux-kernel+bounces-858371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C80BEAE1E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AAD964474
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6247925744D;
	Fri, 17 Oct 2025 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaX/3V5O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19E219F121
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716991; cv=none; b=qPE8Oz3JIVaUGgmwbhSv9MK+F3yetvGXBB1twgoy+jHlxISlBrzALVEQVenLDgvzxMdH+ZDmd+Zr4is/d54RvyGJKjnbVtFDKHZIMBqVCgpYdwYvjVz6AKt3hs4t59jmwqeefoFVAGibJXcxHo2WNk4t17mz8gcVDksPrXgwqiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716991; c=relaxed/simple;
	bh=6vFG6WI7taiW5nsoiE3TFRN2Y1H5m66A5DBtZRZ4Ewg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ge0QX7vTnQzi04f2CCK1eA4KFjiW1F2GBFiX45iB99djnaNvsNc8UoD7wYL16g/IhDM57EM2NJPJ1KunlywTZ+Iz0TIK2pQSV3jbGVJmmxh2bJvw6k9A3//MvGghOOl7yJvyytehXzHxee9tdFnkoVeEfEYFmtmMscKEfyrwp9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaX/3V5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C330C4CEE7;
	Fri, 17 Oct 2025 16:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760716991;
	bh=6vFG6WI7taiW5nsoiE3TFRN2Y1H5m66A5DBtZRZ4Ewg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LaX/3V5O6AD3R9KJv0Ci2FuhEJ5uWAGag+KcgsDbrPKtymsvBYiW8BtP/3hVYN9Rx
	 Btec76LDttklXNKDaERWdjjFUUk0P7kV76BUIEFxMdxf2kmmjQBpBCnQ6etFYIC7DK
	 LFrORwu6WdjnhwfYIdiQMDeIcumoicxDwkX8tVtrVoUvh6ES3KXAr6AcbCg8s/e/7E
	 SOiNRj4ZdQdwyiV3MkXEmxlgFzYvDIHbXZzidegCiAVG/X4FsVj/Gr9M3MTthamEjw
	 sCB7XEFwxiN+a4FbeOCyGeXFN+KZeDs9rn0htmXtSYWm3wuCrwX5/vT8HfemWJMNRx
	 cHwoPfHsi7VYg==
Date: Fri, 17 Oct 2025 09:03:08 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, 
	Alexander Graf <graf@amazon.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 03/56] cpu: Reset global mitigations
Message-ID: <lrwbwfedilu4x3rizxn4i7pg3nuvoolbsnpfyb3ijbtf4ttjet@amyxglszq2fi>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-4-david.kaplan@amd.com>
 <fxgzzp3yokq24swgfkokdnqb7jf53s3na2wjitr5koiamfizgm@d7uvxnuzkebd>
 <LV3PR12MB926591EA45E7186AA3BD2A7E94F6A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <LV3PR12MB92656CCC8F8776F50FE92B8894F6A@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB92656CCC8F8776F50FE92B8894F6A@LV3PR12MB9265.namprd12.prod.outlook.com>

On Fri, Oct 17, 2025 at 02:19:43PM +0000, Kaplan, David wrote:
> > > Considering this will have no effect on other arches (or even on x86 at
> > > this point in the series), should CONFIG_DYNAMIC_MITIGATIONS depend on
> > > an arch-specific CONFIG_HAVE_DYNAMIC_MITIGATIONS?
> > >
> > > Then the weak function can be removed (and weak functions should be
> > > avoided anyway, IMO).
> > >
> >
> > Ok.  I agree, the feature doesn't make sense without arch-specific support anyway,
> > so that seems reasonable.
> 
> Well, so right now CONFIG_DYNAMIC_MITIGATIONS is only defined in
> arch/x86/Kconfig so it's already arch-specific.  It's part of the CPU
> mitigations menu there.
> 
> So I guess these weak functions aren't actually needed in the first
> place.
> 
> Alternatively I suppose I could make CONFIG_DYNAMIC_MITIGATIONS a
> generic feature (which requires an arch to support it).

I'd say generic is probably the way to go, as the sysfs files and
mitigations= interfaces are already generic, and users might want this
on other arches eventually.

-- 
Josh

