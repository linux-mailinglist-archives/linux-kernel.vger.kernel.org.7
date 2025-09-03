Return-Path: <linux-kernel+bounces-798685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B04CB421A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4880CB60640
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E577D304BC4;
	Wed,  3 Sep 2025 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzikW03p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3717E301016
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905856; cv=none; b=DubLWoR5D9/cHjMZQR+sElMEvyCpLKQCp58dQiRsPGtWKCJhAQqQQ0aOtaqcSaz8IP2wqol/fDh+pkqgeoUKZlIisVSlTHt2uiMxqW4uY1KxMoARmmITN6R08ANQ/IylxK/8FMA3cBy5YiZS2UZxVJR8hpVGRTjJEMJkmF6o3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905856; c=relaxed/simple;
	bh=tYCVLLasVPv+rtofR60cmLZ6jdnQ9W2mIG2UxCDcaFE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VVzWQ/MvKuRUIXJdh4f+FLlVgg2gEyaAt/EvBUuNjeasdB05+gtIPXa3eq6F4yC2c/eJC1bl/XpEC4rIL/N2KurMeKi70arGcUO8ZLlIvzTQlK10I52wB+4SyIoletR3+cM3grVmPRaep0yUve1EntRMZszvOWtWsWvooCpz8MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzikW03p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85405C4CEF0;
	Wed,  3 Sep 2025 13:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756905855;
	bh=tYCVLLasVPv+rtofR60cmLZ6jdnQ9W2mIG2UxCDcaFE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GzikW03pVgb+WfeXvfsSXCIGtma183YGgwgL9iaOpZ8KUjK7d5k2G4rnVe0Rfs3CF
	 +wjJT6vhQuQOl79kUbkoUnxcmdq0TS3vGaihV6xKlKFEc15kR83J7qdLeUHc06HIu6
	 cY6gXW61KdVD/+2cQinOjXrTMJu0WfLLrvuN32AbzdPMLlfXcS0odDj9xHOygZNIc4
	 YGkQ7Kex3CzzZWvFeZtv1nN6gZZVTVSUc0g0Mip495bY6yFraGr02wIqaonU6JB+Iw
	 dI0RbR3nv25FBb4kB4XIXcv3pi0UimrgjqQoyg9nxKfPu9C3K6/nR/5Y9rPlx8349X
	 6q2/ZYI1zjxng==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Cheng Ming Lin <linchengming884@gmail.com>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-kernel@vger.kernel.org
In-Reply-To: <20250820-mfd-refcount-v1-1-6dcb5eb41756@bootlin.com>
References: <20250820-mfd-refcount-v1-1-6dcb5eb41756@bootlin.com>
Subject: Re: (subset) [PATCH] mfd: core: Increment of_node's refcount
 before linking it to the platform device
Message-Id: <175690585428.2761740.13323923312367543247.b4-ty@kernel.org>
Date: Wed, 03 Sep 2025 14:24:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Wed, 20 Aug 2025 16:21:13 +0200, Bastien Curutchet wrote:
> When an MFD device is added, a platform_device is allocated. If this
> device is linked to a DT description, the corresponding OF node is linked
> to the new platform device but the OF node's refcount isn't incremented.
> As of_node_put() is called during the platform device release, it leads
> to a refcount underflow.
> 
> Call of_node_get() to increment the OF node's refcount when the node is
> linked to the newly created platform device.
> 
> [...]

Applied, thanks!

[1/1] mfd: core: Increment of_node's refcount before linking it to the platform device
      commit: 5fb7a985997b56eb600a0accfb3b54c05687e7ea

--
Lee Jones [李琼斯]


