Return-Path: <linux-kernel+bounces-839614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC607BB2043
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927131924490
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50B5296BBC;
	Wed,  1 Oct 2025 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oqkqjgbc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B623505E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759358841; cv=none; b=oLadQfZD8dcjeraJoojUWLuhoU7U+bt5UYBmIkUOKLOMAXmC5mVNBnYCz8k8uY9DGB0FSgU8sPMxLDhXrMJqPEHtKSZXQM9X5XwB0PyDDj7aNHGuvXNxNcqOxDa8akbOs1tlE8D3flP8s4FFSXxJxNEq2dr0LsW1esKSaBbamCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759358841; c=relaxed/simple;
	bh=2qZB0ni7Fvhg4uRbLCfgNeNE61C+wuKEOR0kyVqMCxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBsAEXMN5tir00MokMMxUGma5hlk33CsZT6yd2GmeOf5VRlMNdl1fijI65SpKEr8w1kGcljjW8SbOItqTnO5dDra4BENzaakTyTHCp7NjzVd48rxxa7SV4l0DUPqRq03CwG02MGfJjVi3MQdxPXTKl2vuUIkQZQD1YbACEUQmVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oqkqjgbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E015EC4CEF1;
	Wed,  1 Oct 2025 22:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759358841;
	bh=2qZB0ni7Fvhg4uRbLCfgNeNE61C+wuKEOR0kyVqMCxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OqkqjgbcOU4TLePof5qhfYipvFwL9CCMthpgjow1eZpr+c+ZqYUY2WGq77uxrqq8u
	 4YipbIlHora0/RNFDdRlfx7EuNJ0nYDyiyify2PZhMh5eMJe7CLmQkNsD2aehw/Cxh
	 jHgoDLvFY6Gp1U4HxKRdlZMOC+hUS61h1EJqzXq21OP+9H+gDLfyLa2vdSPFQ/O3Lc
	 zLMcib65cRqWgKPwm/RbnEdYzamfRZocVIOC3+kyOPeT5VoVXlsuU31/nkWLQMWMwb
	 /nVHQR7lTWkfr+wJfd26S1Mtpo3I6qcPrChY6IlgawolnroYAt6rZxHKcriyEb4ya9
	 7DT/wo6kQsswQ==
Date: Wed, 1 Oct 2025 15:47:19 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-kernel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 0/2] minor fixes to faddr2line
Message-ID: <w736yxbmteloh3ic5vwzslfqbwzlxqkle4scpcrx3jn5scgzel@ovmv5cqgbt6g>
References: <20250921100358.19986-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250921100358.19986-1-kernel@pankajraghav.com>

On Sun, Sep 21, 2025 at 12:03:56PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> The first commit fixes the issue I am facing in NixOS.
> 
> The second commit uses a tempfile instead of shell variable while trying
> to read the elf file.
> 
> Pankaj Raghav (2):
>   scripts/faddr2line:use /usr/bin/env bash for portability
>   scripts/faddr2line:fix "Argument list too long" error
> 
>  scripts/faddr2line | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Queued, thanks!

-- 
Josh

