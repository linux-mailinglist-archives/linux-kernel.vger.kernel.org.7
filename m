Return-Path: <linux-kernel+bounces-885723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBC5C33C57
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE4F462169
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F75221F13;
	Wed,  5 Nov 2025 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD7cZvDN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2270621FF48
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 02:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309764; cv=none; b=bWtx+2UordPEWPjE1zsqwMfcgSamnnWSs8WnQrTgBN+W6csXsF3VAkav9tRKg5fQqoE9CA+z3VJ8gHSNcebFS/TeNoQse2cL0bUghhYFoziHu4iUFxT4FpnaWAtoMVF7RuR6x1OKz9XAAPNey4odzYQgZy2IlAD+LVzH5aPcVxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309764; c=relaxed/simple;
	bh=mn58vpiShjjiSpWElNvKBxUY55kNZr0LGLdr5KI3fho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgwhtCOhD9zqi3D9zIy3EgESSYpyAMPN3/IlfBd1XbW+oZY+8Oq+EJBUBGDy+Lr4NwyhJGljtAeULptRYWmig82+KVoKR45kzbIvZ2zb8YaNtteTwKaBoMhZBRYMPAQNfeUoVbV7Z4bQQ0bQjf1lXN5UxpuT8P/O8MlU8Dc7T+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD7cZvDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C49DC4CEF7;
	Wed,  5 Nov 2025 02:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762309763;
	bh=mn58vpiShjjiSpWElNvKBxUY55kNZr0LGLdr5KI3fho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fD7cZvDNvIoaszYiw58MqZARHqND+j3LSVBm1RxdjvknoIwgrnf7CE7gxC0G4ytel
	 /tj+FpP742HIw3eLuLjcrkQyqkxHE0dPD8yrJSvjOkWEr4+Atby+AxC+jZzBddeB/Z
	 IRXruYNBS0AoTlQ7j/0GOTG91vetacBB6UbfrBwwmxKrm007m17qUwO4IXOSmdJFvb
	 9Mp4HIOVB8YtpfVF3HQSJ5MwLw+8FXjfz/dmhUG4+whAOM2IktoyszlxvHdmXi9HPg
	 ghdCLgXv2OWU+a0RZusxcYglPT0n9w+qQfpLWpVjWZft6AT+uOQXjVxascfamd7Zlu
	 SoweEcXOP2kng==
Date: Tue, 4 Nov 2025 18:29:20 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 05/56] x86/bugs: Reset spectre_v2 mitigations
Message-ID: <j2mds5vdblnhpha6oyejqcj2fgmveylgaudzzljvfwwl3fgvnw@xgmsl4f7jzv4>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-6-david.kaplan@amd.com>
 <20251103193130.GQaQkDEquEnEwb_cwC@fat_crate.local>
 <LV3PR12MB92655CEB1AF94875901E700C94C7A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251103202811.GMaQkQW54Gml6i1jQy@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103202811.GMaQkQW54Gml6i1jQy@fat_crate.local>

On Mon, Nov 03, 2025 at 09:28:11PM +0100, Borislav Petkov wrote:
> On Mon, Nov 03, 2025 at 08:10:39PM +0000, Kaplan, David wrote:
> > Do you really want it all in one big function?  Or just to relocate all the
> > *_reset_mitigation() functions to a single place so they can all go under
> > one ifdef?
> > 
> > I can do it in one big function, but it'd probably look something like:
> > 
> > /* Reset spectre_v1 */
> > setup_clear_cpu_cap(X86_FEATURE_FENCE_SWAPGS_USER);
> > setup_clear_cpu_cap(X86_FEATURE_FENCE_SWAPGS_KERNEL);
> > spectre_v1_mitigation = SPECTRE_V1_MITIGATION_AUTO;
> > /* Reset mds */
> > setup_clear_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
> > static_branch_disable(&cpu_buf_idle_clear);
> > mds_mitigation = IS_ENABLED(CONFIG_MITIGATION_MDS) ?
> >                 MDS_MITIGATION_AUTO : MDS_MITIGATION_OFF;
> > /* Reset spectre_v2 */
> > Etc.
> 
> Yap, that's what I thought too.
> 
> Since there's no point to have separate functions, the comment separation is
> perfectly sufficient, I'd say.

Separate functions allows each reset function to stay close to its
select/update/apply counterparts.  That makes it easier to tell that
it's undoing all the right things.  Plus it preserves the existing
logical code layout/separation between mitigations.

-- 
Josh

