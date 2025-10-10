Return-Path: <linux-kernel+bounces-848688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E433BCE57A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB9DC4E757E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F149B213236;
	Fri, 10 Oct 2025 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ3O5AGq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED7EEC0
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760123955; cv=none; b=A1MfXlosKnkM+VEDy9QAPhRAocV9GjQm+85Mg8jRPZ+BcIE2JBBCbxPSnQpIqBXdsxnFg+gE1bkOqA59JQANaGc4BSiB0jRadR+kEsbN42f8G+/VBMSV/Hz3woxVbsaKhwNSlS2NokExYpE/jdyPlYWZKgPQCyPr44Kj+GnyeTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760123955; c=relaxed/simple;
	bh=aACgXjzSDvmo4j2GgqwhOZagJVKMYCu4neZ1m27w0qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd+tNNFSzSzhNMv54h+OcquA4jdNo+7oAgNhVtSbHEsBl01aEYp1Md22UL5q+EITSMnNuAyqn7tI2/MR8eVmTlt+u9qGP4NM53C7E73Wf5WaC18QxRNJIwsbs9tqD0d47P+pRgiJfX8OogDmkd+/OwrFALjbWfVgDpyM+g67JIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ3O5AGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1DBC4CEF1;
	Fri, 10 Oct 2025 19:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760123954;
	bh=aACgXjzSDvmo4j2GgqwhOZagJVKMYCu4neZ1m27w0qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MZ3O5AGq6oiOoAs0LC6HG9GBuV7tFcJwtNKzPLTelERl9oJNgWMZpybte3923KHGL
	 rzK320S3kqfLiP03CWsnwEuqFFP8a9YOm9V/yK6X6swPB1i3f9WoTLAL4VWbwkfVpJ
	 s+ptvpGqV2ec7LkOym6pwS20uBAme6uZy/Txi+BFytKOHUKwIsYEca8qbY6G3eRHjM
	 W2BcPpkDg/NFbh+0K68udWSb3Xs/Amk+g1oW0MBMKKvWgeFzqiL7o6pYQw6MW61pyJ
	 2E0orXxcLg8fcxm2Hu1+kuOb3i5GHtncU04AvznbnozTXgga5rv0DJK28puvKsp0iZ
	 an3Z4JzuQ7/5g==
Date: Fri, 10 Oct 2025 12:19:12 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, "Kaplan, David" <David.Kaplan@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, 
	Klaus Kusche <klaus.kusche@computerix.info>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <zrbzofjxeuioxhbruhaoacbyfbpclkbntiblg6jjirr4v2c2uu@aeyo5bdb44et>
References: <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
 <20251009053336.ghcmhgsprtkgydas@desk>
 <xhxfkzrrn62xkd6moiapfueookui5f63x4lmzgkmnf3mbxilb5@kk4rylukegii>
 <jlwwd3ohjr7a6lnd4ehu4lp7ys7tm7f6rlaxyc75725thvil4k@pf3bm243ncys>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jlwwd3ohjr7a6lnd4ehu4lp7ys7tm7f6rlaxyc75725thvil4k@pf3bm243ncys>

On Fri, Oct 10, 2025 at 11:47:25AM -0700, Pawan Gupta wrote:
> > Instead, CONFIG_MITIGATION_SPECTRE_V2 could enable a submenu which then
> > allows the user to enable retpoline, IBRS on entry, etc, with each
> > having help text describing what generations of CPUs it would be the
> > default for, to help guide the user to choose sane defaults depending on
> > their CPU:
> > 
> >   * CONFIG_MITIGATION_SPECTRE_V2
> >     * CONFIG_MITIGATION_SPECTRE_V2_RETPOLINE
> >       select CONFIG_BUILD_INDIRECT_THUNKS
> >     * CONFIG_MITIGATION_SPECTRE_V2_IBRS
> >       select CONFIG_BUILD_IBRS_ENTRY
> 
> That would be good if a kernel is built for certain specific CPU(s). This
> may not be ideal for distro kernels.

Why not?  A distro can just enable everything:

  CONFIG_MITIGATION_SPECTRE_V2=y
  CONFIG_MITIGATION_SPECTRE_V2_RETPOLINE=y
  CONFIG_MITIGATION_SPECTRE_V2_IBRS=y

and then if/when some older HW ages out of being supported by the
distro, they can start disabling things.

-- 
Josh

