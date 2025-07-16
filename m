Return-Path: <linux-kernel+bounces-733874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7E2B07A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017BAA410F9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EB82F3C2F;
	Wed, 16 Jul 2025 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLwgbfXu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FDC481CD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680266; cv=none; b=AHWeuX1OmAvZjr7kt761w3sad51xU8FVUFlpBhVa0hKmunjkb+aI8+ClN3b+d39/ISxT+SXK+amMdpquvqDln9SGhg9UDJJlWQ8RAMPDFRafY1i/6LAoI4EFPgUE70n5NOEXFTXC4PPPuXeJH4J3943i1ifTHOJfLPZuEYQ9Ncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680266; c=relaxed/simple;
	bh=kREwtPjCgKfqsTgv5NM0Mvvtgu8NBDUf/T41rzVZ/eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXN85Nfs2oXUs/mgomSiiaeGw2jrj1fsQGrhVY6PXJMRQRseqOVa/xGKsRplASmC8uTXEzpnUtEQ/iIRavkB8kb0nAoQClTvq3GDTL4Yv9P9bXLrKiUqmb4rn3MU7fLWqG0uJD3rqXS8S/i7ObqdVPimxpD78PD3OnXsdmt9ruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLwgbfXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A91C4CEF7;
	Wed, 16 Jul 2025 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752680266;
	bh=kREwtPjCgKfqsTgv5NM0Mvvtgu8NBDUf/T41rzVZ/eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BLwgbfXuexHaW+TPNa+a6iWrfr4C93SXyFNP1m6zjdbchQIQjSDQN2bPIFxq8BOpe
	 3Y4LzFtdIUdhJXmJbTn203g5qdg44tOZHIiKBjGVH/5wnPgme7Tctz2W+/IpaDnKLe
	 8BH6cepPRo11/392JBcaABYWXwIdAxzxeBnssoB5sZ9TDXipnQosvkIEHom5c/u7FR
	 D5nq5bg/vTcOff2xiwUMeSzoEHZJ+oD85tH7KUakcBcdGy7jLA6BdqiTOB742SS7aD
	 cPI1ykzdDf1e9s8V5rHlN8rkVCKkwk/zgI6tMkbncjd8p53Y7Ww2OULF2uyhky8RTf
	 UqoBVX+/4gwsg==
From: Maxime Ripard <mripard@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Casey Connolly <casey.connolly@linaro.org>,
	Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
	Anusha Srivatsa <asrivats@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/14] drm/panel: Use refcounted allocation in place of devm_kzalloc() - Part5
Date: Wed, 16 Jul 2025 17:37:42 +0200
Message-ID: <175268024705.1893267.8357084891720845996.b4-ty@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250710-b4-driver-convert-last-part-july-v1-0-de73ba81b2f5@redhat.com>
References: <20250710-b4-driver-convert-last-part-july-v1-0-de73ba81b2f5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 10 Jul 2025 23:31:11 -0500, Anusha Srivatsa wrote:
> Use the new API devm_drm_panel_alloc() for panel allocations.
> A major chunk of driver conversion was sent in a 3 part series
> which is already merged. The coccinelle patch that was used to
> identify unsafe panel allocations didnt flag about 20 drivers.
> 
> Not using any semantic patch for the remaining drivers.
> This series does the conversion by not passing explicit type
> to the helper and maintaining type safety suggested by Geert.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

