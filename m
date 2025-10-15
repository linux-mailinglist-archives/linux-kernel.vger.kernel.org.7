Return-Path: <linux-kernel+bounces-854893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F41BDFB2A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4861519C71E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5439E3376B8;
	Wed, 15 Oct 2025 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENybR6Bm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2DC2F25E8;
	Wed, 15 Oct 2025 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546349; cv=none; b=PGJayApRkzIDf/UGL2rzIIuIdfMYAfn9YqIskJwqfYTLA8XK+hC3joiDTEvjHb+dkqze2knnt0nAnC8wLRrMwdzWt+z7n2aDAmHAQmKdWKD3XyaWHzPiuycnDJdb5RrRYSr0kJx1DNzYe+dV8tpdEaBbzWKbRg3k8LWBfZ2UVWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546349; c=relaxed/simple;
	bh=uY/ri/R/uptObQp5pFssQiLcxUk4JQh2NMKsHkdSeFg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=XAWmTQupkr/oidLsTFZwyCRevNKUuGFC6fQJeA6DP56uyi2bbvL+MlZuGtewIKM4kBeFBFZLjMeE/68K8Up9mCs0KGNgrY+hpSxusm5SLDu9Im/nlAB5jlgC3hiEAiSOJ5u9ZwdYLXnL/2lDcLC/AB0uXEDGvpEcX9u9B0T1+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENybR6Bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFC5C4CEF8;
	Wed, 15 Oct 2025 16:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760546347;
	bh=uY/ri/R/uptObQp5pFssQiLcxUk4JQh2NMKsHkdSeFg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ENybR6BmBQieuG19sBiCFY7ya2zl+CjQYCLBGehWPGTMdLDjTMUldKXsD2Wt9bQ7G
	 gQzqWJuRSrzFQgEjQILVAoJ2aliqcx39W/cj/pwdre5P7YSc4H4XvZAP4TBfZVVKCY
	 OjxM5WAm8r+nj2W0tXwYaYOlFQEqp2FqGeZqHrs18ekBhLGjTQ9y7agXqDX9MWbw35
	 r7MfVXSY4+9vml8uzn8C/OLgU3ntLvZNbGwmA+4ECVlk0Dgjfb/HV+RXu0Wr2Kg1hK
	 P6524sTIfQ/hNOyueaqPgNbuPcv7c3tfwiObltpOCMMXQmInVAuRJ63CgV38YVDpCr
	 W9wohz3gf0vEw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 18:39:01 +0200
Message-Id: <DDJ1LC1XM765.33V1SPVZAIKP5@kernel.org>
Subject: Re: [PATCH v3] drm/gpuvm: Fix kernel-doc warning for
 drm_gpuvm_map_req.map
Cc: <bbrezillon@kernel.org>, <himal.prasad.ghimiray@intel.com>,
 <matt.coster@imgtec.com>, <robin.clark@oss.qualcomm.com>,
 <matthew.brost@intel.com>, <aliceryhl@google.com>,
 <thomas.hellstrom@linux.intel.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <simona@ffwll.ch>,
 <skhan@linuxfoundation.org>, <khalid@kernel.org>,
 <david.hunter.linux@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-kernel-mentees@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 "Stephen Rothwell" <sfr@canb.auug.org.au>
To: "Ankan Biswas" <spyjetfayed@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251015152543.24368-1-spyjetfayed@gmail.com>
In-Reply-To: <20251015152543.24368-1-spyjetfayed@gmail.com>

On Wed Oct 15, 2025 at 5:20 PM CEST, Ankan Biswas wrote:
> The kernel-doc for struct drm_gpuvm_map_req.map was added as '@op_map'
> instead of '@map', leading to this warning during htmldocs build:
>
> WARNING: include/drm/drm_gpuvm.h:1083 struct member 'map' not described i=
n 'drm_gpuvm_map_req'
>
> Fixes: 000a45dce7ad ("drm/gpuvm: Pass map arguments through a struct")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20250821133539.03aa298e@canb.auug.org=
.au/
> Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>

Applied to drm-misc-fixes, thanks!

