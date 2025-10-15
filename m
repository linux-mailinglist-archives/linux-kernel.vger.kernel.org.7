Return-Path: <linux-kernel+bounces-854811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ECABDF741
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 396B64F988B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EBA32BF42;
	Wed, 15 Oct 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnqxZPG8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C874E2D0627
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542990; cv=none; b=PyWWXlgNNj0XQw7SpGvisScBVOkb7kEoPIvypLdZ9H4Axo/yRZAABklpIgaL8k76IDsk3XaGtufVkcSrj0HT3DMU4JKbrXRzNno11EKfTW/qVptJ3ogPg0c/vcaDHCAeb8A+xJMBgLAF/cqfcCtQz4ydMXb4kOrdv8m39CYkSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542990; c=relaxed/simple;
	bh=BNpHRqR4GbTEse650qIdnuq9QZ7pYiqmhSUPoGQwgS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRyzKstCKV8H4oWkek83m/LXFgiHrL3sUINakBhIhixnJewyV7tJXN+FrQI4zTVwOPwWM9cArgk9QPrEhkLYE85GGIc3+MZjqa02jhfjV+cCclGq6+UmWWjDWy/wUxIiWiicu9+q+td+dNGqU2kylG3unKDlrf7xYt40y3T27so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnqxZPG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7830AC4CEF9;
	Wed, 15 Oct 2025 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760542990;
	bh=BNpHRqR4GbTEse650qIdnuq9QZ7pYiqmhSUPoGQwgS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnqxZPG88UagjvSkhx6BAznPv3cmzZ89vfV7J46qJtlHO47uyMiXsrdx8/tn3TuCI
	 t+EPRZkNaCvZ1jUVxJxWyIhwMC/rIxGUf6yS7QL8O4z3vu2lWYfumOBXjteoHDoSGX
	 B6Wq+GiAyXGiRUUzUIb3l2JN459EhNMLo6eIiTpSXwCrIKi44rlhM+dpEb1DCGOwzg
	 lGut/yf+TD4z6GX/KFd3qbOYxH/xj2jsMqVfGjhDXTLnUsRBzJOpyFW4oRFZBzgab4
	 B2IXGj76rrA88h5KZyj3bHrJF0bHjmc6/NM/+iHi4wYVP6gq/ARPOlBPusb8W0XSpf
	 E2O/8tSETHnMw==
Date: Wed, 15 Oct 2025 08:43:07 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Aaron Rainbolt <arraybolt3@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, 
	Alexander Graf <graf@amazon.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/56] Dynamic mitigations
Message-ID: <cnwawavsdedrp6yyylt2wqiglekwsgrofimkvh32fknj676xsh@4vyzzoky5hzd>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251014231039.6d23008f@kf-m2g5>
 <LV3PR12MB926564CC5E88E16CE373185694E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB926564CC5E88E16CE373185694E8A@LV3PR12MB9265.namprd12.prod.outlook.com>

On Wed, Oct 15, 2025 at 01:53:31PM +0000, Kaplan, David wrote:
> > If `root` is capable of setting `mitigations=off` via this interface,
> > doesn't that somewhat defeat the purpose of denying `/proc/kcore`
> > access in lockdown confidentiality mode? Assuming one is running on a
> > CPU with some form of side-channel memory read vulnerability (which they
> > very likely are), they can turn off all mitigations, then read kernel
> > memory via one of those exploits.
> >
> > There should be a one-way switch to allow denying all further writes to
> > this interface, so that once the system's mitigations are set properly,
> > any further attempts to change them until the next reboot can be
> > prevented.
> >
> 
> That's a good idea, there could be a separate mitigation_lock file
> perhaps that once written to 1 denies any further changes.

Wouldn't the enablement of lockdown mode effectively function as that
one way switch?

-- 
Josh

