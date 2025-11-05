Return-Path: <linux-kernel+bounces-887001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC44C36EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C761A34E92A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E60337BA5;
	Wed,  5 Nov 2025 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oO9YJ7nI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE1930CD85
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362400; cv=none; b=RGR95WF9PQj+evHNbV4UXpqsKoxfvXUkay4ug/7GOJ5t7/3pPwCBY2lihTSThyN28HzihXVcLjnCg5EBYVs9yOJ8OUQM+0giLe4Zgjp5YfDm4mW7MC8amblvAcc46tA635gx4vD4IDItyuqX501Ut4RkpI5jzUsFLLwaxinnzjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362400; c=relaxed/simple;
	bh=1LUj7su4xPMYbrvHK6K6NSCu16PDQZRzoLnHOvgv9s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDasKD1OR7l4HUNXqHllYdy+DFmBVEtFBT01EbYcTAGJZJchaPLKontM+2ttGMH2TzV9gHxhT4OI03k9HoFAL41EU6GrQpHVTLu8kAOnpHl1ksrrHZ2SVAXBX7exgrawI7vboMm6ibFj3kVoQr6weVpVgEAGfpaXJif2WUMww5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oO9YJ7nI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5575DC4CEF5;
	Wed,  5 Nov 2025 17:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762362399;
	bh=1LUj7su4xPMYbrvHK6K6NSCu16PDQZRzoLnHOvgv9s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oO9YJ7nIOjBkp0OVAp1nHHq/6WqrHDr4NtJR0Y2j0R7m19ypjvVMLPp7ciPWtO03e
	 XQzl/7r4tKDVQlL5v3iu0Y4DrZsPYYZ+trxXW1g9HTpOtD++7Ox/+JZHraF4H8aP2T
	 v10eoPEpvF9RzLYREYNxlWM5eouwXxC0gisKRANQ17hVI4DjNGaDoAg00H8YS4Wxcd
	 pOVopHu4c+R3Gw6A3R9eBnMuQNkYQoqLvFQVzEuQDVlp2V+fkn3NP/YhK6pSciONv/
	 ktMskWCbK3UcdIJ0S2MAQYnQsSG8gwQ+GDpNYzM9gOJtSQ8mxQ05ZcMqC+zBuvtjmY
	 HdwLqefeI0shg==
Date: Wed, 5 Nov 2025 09:06:36 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 05/56] x86/bugs: Reset spectre_v2 mitigations
Message-ID: <b7xcrqkx4ouye4ayqkkvmpoirpqydhf663uim63w7nt3xwbgyc@kytyca6dgztu>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-6-david.kaplan@amd.com>
 <20251103193130.GQaQkDEquEnEwb_cwC@fat_crate.local>
 <LV3PR12MB92655CEB1AF94875901E700C94C7A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251103202811.GMaQkQW54Gml6i1jQy@fat_crate.local>
 <j2mds5vdblnhpha6oyejqcj2fgmveylgaudzzljvfwwl3fgvnw@xgmsl4f7jzv4>
 <20251105110318.GAaQsu9vGkzSxGbzzx@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105110318.GAaQsu9vGkzSxGbzzx@fat_crate.local>

On Wed, Nov 05, 2025 at 12:03:18PM +0100, Borislav Petkov wrote:
> On Tue, Nov 04, 2025 at 06:29:20PM -0800, Josh Poimboeuf wrote:
> > Separate functions allows each reset function to stay close to its
> > select/update/apply counterparts.  That makes it easier to tell that
> > it's undoing all the right things.  Plus it preserves the existing
> > logical code layout/separation between mitigations.
> 
> ... with a forward declaration for each one?

Nope, these patches don't add any forward declarations because they
sanely put the caller below the callees.

We should put cpu_select_mitigations() at the bottom too, then all those
existing forward declarations can go away.

> Because we don't have enough functions in this file already?

I don't see how the solution to "too many functions" is to start
squirreling away some arbitrary parts of (otherwise logically separated)
code in a hidden uber-function away from the rest?

> And even if the code structure is begging for
> us to turn it a OOO design, we're not doing it?

If "functions bad" then why not make cpu_select_mitigations() one big
happy function with a ton of comments?  Just think of all the function
savings ;-)

-- 
Josh

