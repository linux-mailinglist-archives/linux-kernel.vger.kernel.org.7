Return-Path: <linux-kernel+bounces-849664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA53BD09BE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A3E3B8400
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB162ECE97;
	Sun, 12 Oct 2025 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM2ElECy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136234BA41;
	Sun, 12 Oct 2025 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760293472; cv=none; b=TLBj9rVxySirI/C39IDTKvimfIEn7q/ORZKMLb9il6v/f0g9KU3ZBn5ELhdWmi9swaHktfIzpudlj160f8z65XkXnld39HEdOPPrItSIF087JOMB8T5jx1Fhs0mz6d1PsDDMADijEO+ymdozPgvJzurybjEiFFF/3KM/aO319ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760293472; c=relaxed/simple;
	bh=jNQMPq5aHPw4UwMfE4/hvuN3ivslT2Wdd5P0OwmUHgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kih3srttM+DQUHnSI2sFZ4rqC3Pdbr8rHUhvtG7f1fR1gbaqGfB5pN+CDu7+l/GcQXCv+iMdG6fsuAgnnJvqb1X7PPJ7DSRyge32r+m6PSYY9hOVwk3rvatZ6ciz61QgrMYu57F67t7cP2vX0a6sQr953mk2IEBTRscfp/eHWPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM2ElECy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE24C4CEF1;
	Sun, 12 Oct 2025 18:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760293472;
	bh=jNQMPq5aHPw4UwMfE4/hvuN3ivslT2Wdd5P0OwmUHgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eM2ElECya3orR0xr9EftJ7TQ9BqZoahTwmsb75SOFovYEf+NGbL+SOv5TLYP1+FRB
	 cQQvCuihohSRFEHE3xmJBhExrUoXSDKxiVVqVDoS+1MDmsWZykLnwkCkOL54zz36Ts
	 XLpgcVL/DhSQWd8wi2QEYtCF1TCRJmfaAanDEj+2q6yClkEtjKy2NSEP5AacYxGAUE
	 R/nncmAyWTm5gEkmAntzn3XlmyNJG1MP1su8ont6UWlswqDkxMNb3lyLgyM5CMovQX
	 vvCxRhHumAPLPixoIqeVvLyKw/TDh9EaJkggN9rdM/dMkvzyw2UTHNue5L4WxuWOc7
	 Sze3A7+bpUUIw==
Date: Sun, 12 Oct 2025 11:23:02 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	Daniel Dadap <ddadap@nvidia.com>
Subject: Re: [PATCH v10 2/4] PCI/VGA: Replace vga_is_firmware_default() with
 a screen info check
Message-ID: <20251012182302.GA3412@sol>
References: <20250811162606.587759-1-superm1@kernel.org>
 <20250811162606.587759-3-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811162606.587759-3-superm1@kernel.org>

Hi,

On Mon, Aug 11, 2025 at 11:26:04AM -0500, Mario Limonciello (AMD) wrote:
> vga_is_firmware_default() checks firmware resources to find the owner
> framebuffer resources to find the firmware PCI device.  This is an
> open coded implementation of screen_info_pci_dev().  Switch to using
> screen_info_pci_dev() instead.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

I'm getting a black screen on boot on mainline, and it bisected to this
commit.  Reverting this commit fixed it.

Please revert.

- Eric

