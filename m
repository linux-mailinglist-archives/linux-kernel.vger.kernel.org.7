Return-Path: <linux-kernel+bounces-722978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411E0AFE152
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917983AD886
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F99270557;
	Wed,  9 Jul 2025 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqA8CTtN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC7A22A7FC
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046240; cv=none; b=oM5M84v+zI5HZGUlIdg+Q+y43Pbf9/Lb6o5Br9TlSFGaO3Pdp/zDUGfUbBBAdFIF1ftorezSs6OblYigjIISRB69dlcJuqOtYY9cH2THsp8gWH0KF1UQ6jDLluV05qUPJRGl7m/k+7lcHcbv8C+HndGRPxyY7ped/S4/QQrlVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046240; c=relaxed/simple;
	bh=/vwN5BWjTGOjFPP3j3cXPN3r/Q9oFqRrwLR4WmpHrDk=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=gBAiPDRhzqRhxCrq2mwk36NPRq/FeTn3r1jd8iwlZkkb9ksf5bDeAHMwk0NxlPaKG23wlLinRF9H34AFkA6CmDvGJ8LN8qdDue4XvZKPvC/1x8Zrh2qk13mBLkYQRaND48C+QqKuDCwLze0OuDTue6aQge1wYgX4sBaXAKOOqE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqA8CTtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D779C4CEF1;
	Wed,  9 Jul 2025 07:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752046239;
	bh=/vwN5BWjTGOjFPP3j3cXPN3r/Q9oFqRrwLR4WmpHrDk=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=cqA8CTtN9wSJ9EH6zpZU0iBEWTL5PfNeFx2yPUqPdDKCiSL9/kUE0EnW2F9rcBl7T
	 D7YB3REFVtw3KggdfwfrsGhP4cIboaJFKPpRPtwOwNAoc0w5vjEpf7ZPy3FVtGLlzF
	 KYHh1bs7LYg47rE/Dq74B/I9GuBk2c8S6abYlhCc2x/MdnULXw0GvF04UQb8gsCX8Q
	 4W6q6soEqQu5mSN4wOoXEYNvHL55AzQBZY5KEE+DC69yDWd/o5OpanZRu7EYmiiKJe
	 mjB7iUbbIsXareDyyIhIypP9WQ+16jcb9tmlhQeGNoRY2l9vQ0og4qWoqExvgtOqUZ
	 6c3n2U6ssLvCg==
Message-ID: <c3fe3daf0a1e91d6ed8153a3a043eb5f@kernel.org>
Date: Wed, 09 Jul 2025 07:30:37 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 1/2] drm/sti: hdmi: convert to devm_drm_bridge_alloc()
 API
In-Reply-To: <20250708-drm-bridge-convert-to-alloc-api-leftovers-v1-1-6285de8c3759@bootlin.com>
References: <20250708-drm-bridge-convert-to-alloc-api-leftovers-v1-1-6285de8c3759@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Alain
 Volmat" <alain.volmat@foss.st.com>, "David Airlie" <airlied@gmail.com>, "Hui
 Pu" <Hui.Pu@gehealthcare.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Maxime Ripard" <mripard@kernel.org>, "Raphael
 Gallais-Pou" <rgallaispou@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Tue, 8 Jul 2025 17:24:42 +0200, Luca Ceresoli wrote:
> devm_drm_bridge_alloc() is the new API to be used for allocating (and
> partially initializing) a private driver struct embedding a struct
> drm_bridge.
> 
> This driver was missed during the automated conversion in commit
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

