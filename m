Return-Path: <linux-kernel+bounces-639349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91297AAF644
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 11:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8491BC56F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D675623BD09;
	Thu,  8 May 2025 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpAHxus9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7A256D;
	Thu,  8 May 2025 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695014; cv=none; b=KcNBS5MESqMeoYngGktqC8QPL59oc/lcnduhEvowPGM2jeElLLyPHqWNEI9Y1eARwpg6fqFhJv4tYPFWudz1krNAoFk1IpovSReiWvJvucu5vACVkVfB1HMcyewFJHE8793fkcHhObvErwfAAA8DWoXMWR1mp+aMU5lCaFS6i+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695014; c=relaxed/simple;
	bh=krItT6I4bxFVehf1B+09My7y/ZbPSgpXJkTUMpmp9Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxlNY4DlC0snKWLrXzdEjD7TzMDqtOC8hWwJrU4XaZXzEb3v3bVvZuAvopJFwD5oDHUObNl1dd2sLPYvTWf1FNQxVimVBVcIE+BSZ4C4TYr20+5kjQq3T8WTqw9xgKK8ae2ySJKsne1anN83/2sjB/HdFs1WAiLigQIa1bUxzog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpAHxus9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF01DC4CEE7;
	Thu,  8 May 2025 09:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746695013;
	bh=krItT6I4bxFVehf1B+09My7y/ZbPSgpXJkTUMpmp9Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpAHxus9YaUrH3sVmSVbztk3AagG0wXcH15swk6a1k/LZ+fID8F4YVOpU9FOylaNu
	 0aB2ZcVoqtXtJ8h/0rSlaJIWeidpPIEH/c9TaB6Zx51/lNc+hxOee6DlDxREk6qI3t
	 YHyWjqe2unQ+C9YKERvg59Dr0RkPgKsJkg2FH73VxfDDpl0OlRqc+Wt4jD0fYeZR/t
	 OHFWuJhbtFLsD4aLmILTlvBuuRIl4sGldrc81SCHTe7knekzE+A3aofaiu4yowW96z
	 n94bnkQEeTUbjLlACl/FWA0m5O738D+xIy7eGe33jtxcacdrhYfMYkFoiK8f5jy9uu
	 u0TVNBad/4tlw==
Date: Thu, 8 May 2025 11:03:29 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	lkp <lkp@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH -v2] accel/habanalabs: Don't build the driver on UML
Message-ID: <aBxzYZoPyATllU9c@gmail.com>
References: <202505080003.0t7ewxGp-lkp@intel.com>
 <174664324585.406.10812098910624084030.tip-bot2@tip-bot2>
 <007a7132d1396912b1381e96cc4401a10071ed24.camel@sipsolutions.net>
 <aBxyDyVT5QbOlhPq@gmail.com>
 <709b486f4cfb93e0feac12300e4f06a34f49fd27.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <709b486f4cfb93e0feac12300e4f06a34f49fd27.camel@sipsolutions.net>


* Johannes Berg <johannes@sipsolutions.net> wrote:

> On Thu, 2025-05-08 at 10:57 +0200, Ingo Molnar wrote:
> > > 
> > > I dunno. I guess we can put rdtsc() into UML on x86 as I suggested about
> > > the file placement, or we can also just fix the Kconfig there.
> > 
> > The Kconfig solution looks much simpler to me too :)
> > 
> > Patch attached, does this look good to you?
> 
> Yeah looks good to me. Common gotcha really.
> 
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

Thanks, applied to tip:x86/msr.

> If anyone _really_ needs to have this driver built on UML (say for 
> simulations/testing, we do build iwlwifi for all the time), then 
> they'd probably want to replace the rdtsc() anyway with something 
> else there.

Yeah.

	Ingo

