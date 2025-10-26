Return-Path: <linux-kernel+bounces-870453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AFDC0AD9C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FD6189D75B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606A7242D79;
	Sun, 26 Oct 2025 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FReRi25K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F4F199E94;
	Sun, 26 Oct 2025 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761496373; cv=none; b=mAPWNyNKZ0xdLXLFmIXhJQCKs+13nkrPJsNbC9FaWYs17dmhYpv44jgtePPDMCvVn/9lwwzTIKB+bRqGhYtO68wgzR75cZWrRvhcZgyTmd3Vyinf6KYCvx7Baa3Yx6raKBFSTbRDM2CZ62CT2y/9hJrntv8sx/+gTEqitUdSpdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761496373; c=relaxed/simple;
	bh=TLoSRzFkmVrwgpjKLeey5fVAXkXkjkmPb8voffDY+HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONoMZAfjAkCJzfXx88Nz5VgXS2AWPCua1EOqBv7BCvnlSM4RYM55TQIS8gt5z0R8ekQ6Rc7OVimIECZbhRt7HMmn8AhMS1t0py0iLOcNfX0FfbPygJc7EN8yippTHCJheGLzO+1vIQGIBLvNokLZedrjzS0MWh++uE8Bn03mE+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FReRi25K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99F3C4CEE7;
	Sun, 26 Oct 2025 16:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761496373;
	bh=TLoSRzFkmVrwgpjKLeey5fVAXkXkjkmPb8voffDY+HI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FReRi25K/f+KSaosgYM1ay6UWpxX7lF5Eq8dVT8Mm1vZxatuQeSSSKe46o2h4C5P8
	 kvWdFVgRG/3MRT47JjoBJGaVd8hyr81OlcauaNfdu4oA2j9sFcQq7iaD6b7lRNrM4C
	 h7213YEZiH2wch9bQQcTzN2Ulx2wWpcaSLxmA88IYW76wGzBCS59YnuiyXyPLszMdz
	 53Zl2pgwsiHxbX7F3bLrgImltnHnZsqo9b+afYNwa6cH2oGtQm83Mgyl9vP4eHAqyC
	 6vuxdaNLuO3tV1AOgi+zrJIrtX9WiNvsSCd9tk6HMpdIlwhBh27Jgd4oppcInZfMnz
	 Smi3cPsUAKppA==
Date: Sun, 26 Oct 2025 18:32:44 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org
Subject: Re: [PATCH v8 7/8] liveupdate: kho: move kho debugfs directory to
 liveupdate
Message-ID: <aP5NLJoSfKTVnsQV@kernel.org>
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
 <20251024161002.747372-8-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024161002.747372-8-pasha.tatashin@soleen.com>

On Fri, Oct 24, 2025 at 12:10:01PM -0400, Pasha Tatashin wrote:
> Now, that LUO and KHO both live under kernel/liveupdate, it makes

And they still don't :/

> sense to also move the kho debugfs files to liveupdate/ in order to
> keep current and upcoming LUO/KHO features organized.
> 
> The old names:
> /sys/kernel/debug/kho/out/
> /sys/kernel/debug/kho/in/
> 
> The new names:
> /sys/kernel/debug/liveupdate/kho_out/
> /sys/kernel/debug/liveupdate/kho_in/
> 
> Also, export the liveupdate_debufs_root, so future LUO selftests,
> kexec telemtry, and other users could use it as well.

No, this is backwards. If anything it will be kho_debugfs_root.
But I don't see why we can't have /sys/kernel/debug/liveupdate alongside
/sys/kernel/debug/kho.
 
@Andrew, please drop this patch for now.

-- 
Sincerely yours,
Mike.

