Return-Path: <linux-kernel+bounces-803514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DDFB461A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8EB1C824AC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903E831B80E;
	Fri,  5 Sep 2025 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g5UnQh6Y"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1668B2F7AC1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095345; cv=none; b=ihkjIgwLSkoxs8WUZVAR3xSPgPqlHGUoChC/7mwivHGqGhfevLqun3JwBWxjMwoTVjmanYDyaR+wiPQYACCPZMbvYa+1/xzN5e9gGRfpnhXf1OfcMI9+Ph1SFAV14Rd2P+NAsCBhsDdICDa+CR6e6Z3SOt25oStR95DL1+Zx/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095345; c=relaxed/simple;
	bh=HHUMJT5X/rnIaiINaqKNWDCsxrdXNa9Q3fXaueHO4wE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XmFg5kSGLUNCvPSF0owUH/FMIM460ZM7MCGgjK6q2Yp/glu1pTRwMcAmyflbz+SFG9gjYVVFZnz4p+5/2qiQrB9AlNqmStCk0Y/t7Z5Eo2ATdE4ar0FGV45XeSu5tjavLS6H2zKIrKbWoqeHIMXMFaoLHwoy5QZw/ahNissFXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g5UnQh6Y; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 78BB14E40C74;
	Fri,  5 Sep 2025 18:02:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 396876060B;
	Fri,  5 Sep 2025 18:02:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27AFE102F27E4;
	Fri,  5 Sep 2025 20:02:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757095339; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MaeYscuMJCiRmlgwHZuKHQSm4n39zj+fX5GjAObjjc4=;
	b=g5UnQh6YJsy8b/GOYiaa9SQhKl5pfC8xDvXucBjOH9doLYeKt9Gc9/9qROEMxk7PBsxWJL
	Zd1lmmL9/J+LckIeJabA5jiYbbgs+Oip4VRDQ1ql9AmStt2MUpgJLjkXx7tZDbDesMKrW7
	hz/7NCfFWWSQb+6HYfVb5o0mbwfSVXnudj7CrAgaq+e3PKf1XcncYUvo93NRejMuQtNK/R
	RvUznSfomC2yYi+4VqDW20GBjSX1EDZjiLRRCpe1spADEgbVPtDYilW6ii0loXFY7SN/U3
	j1lB79nPJvd2Af9R0wIvnHnPb/9wlbd7gCPoYmeMH+gbvnh8el9PhpUF7tjAxw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20250703-b4-new-color-formats-v7-0-15fd8fd2e15c@bootlin.com>
References: <20250703-b4-new-color-formats-v7-0-15fd8fd2e15c@bootlin.com>
Subject: Re: [PATCH v7 0/8] drm/vkms: Add support for multiple plane
 formats
Message-Id: <175709533293.1275590.10117645940954604570.b4-ty@bootlin.com>
Date: Fri, 05 Sep 2025 20:02:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3


On Thu, 03 Jul 2025 09:56:56 +0200, Louis Chauvet wrote:
> @maíra: For the patch 6/8 I just removed the comment about yuv input
> size, is it good for you?
> 
> This series introduce a macro to generate a function to read simple
> formats. It avoid duplication of the same logic for similar formats.
> 
> In addition, it also introduce multiple "easy" formats (rgb888 variants)
> and also 16 bits yuv support (P01* formats).
> 
> [...]

Applied, thanks!

[1/8] drm/vkms: Create helpers macro to avoid code duplication in format callbacks
      commit: 544f161a88af0370ced87783246418aed63b619c
[2/8] drm/vkms: Add support for ARGB8888 formats
      commit: 985769b8b5c42666be91f5e60aeb93365c934b88
[3/8] drm/vkms: Add support for ARGB16161616 formats
      commit: bac5c590d42ce8a930950da716b7537e60153196
[4/8] drm/vkms: Add support for RGB565 formats
      commit: 39d80cee4207d937daf58179ae3c572bcf541f8a
[5/8] drm/vkms: Add support for RGB888 formats
      commit: 50c58f4f0562504256477ad153463d86500aa337
[6/8] drm/vkms: Change YUV helpers to support u16 inputs for conversion
      commit: 7766ae8de472be3e0167cf3652e6ae8d74ef0221
[7/8] drm/vkms: Create helper macro for YUV formats
      commit: 9e6600e9d3683cdf0196fde7439dba4c50946906
[8/8] drm/vkms: Add P01* formats
      commit: 9cd6b43a0f7fc0dfb779c73f4aeb4d3fe8820698

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


