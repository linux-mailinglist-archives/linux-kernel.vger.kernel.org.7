Return-Path: <linux-kernel+bounces-864881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD90BFBC3D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE3934FBA3F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E9F340A73;
	Wed, 22 Oct 2025 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="u1/DgKoO"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A69341665
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134549; cv=none; b=W1MgML84iwn5x5wm5MUeIJ2xKJLRe00gNzNRIatkx/7Papf6cfKP9a7//6O/MVVbqMR3nT7HvIegIb/MzT99QQXcM431TYTcoEdUJpept67p75ivCpPcsPhjZPZc/5dxMZ2DoVwcuJg1NmC9ZVxd3zPWxKf7O2sZbD9kqJciaNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134549; c=relaxed/simple;
	bh=Xg9zum0JkYFm+Mf6Zk0H4rMBEJOV3In/rTcJRxHSB7Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=THKUrd0s9lzktZqfY11Qw5oDx8FhSpb8iHIoSOa3pRb3t6NLeCfXXbhCjwmBeXHl7B6l3TX6fCXeteGkXtKHQ431hE9+Y4yropz33WEhPSHXQxlgcdnQhlAjdM1aGsUZjVSa9Q9EkxSVC9aqU30iaMGcrhEw/ScNccKrGjvR5z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=u1/DgKoO; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1F5E1C0B8BE;
	Wed, 22 Oct 2025 12:01:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CBAEA606DC;
	Wed, 22 Oct 2025 12:02:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2BCB102F23A9;
	Wed, 22 Oct 2025 14:02:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761134536; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pPxJMHRq1l2rmXPvs2hWIXztWS7OsJftqAuKJvbSq2A=;
	b=u1/DgKoOMDae0wpLByNIw1iXCHZaEPUH/CPq3mejkEtMKyQrMFrT3+OVkGCMBo98uaShXI
	PUnqmjvS6/BlHsHKS5jVQQQkFIvjetly+eQTvmIec7ksLPoTrTqUfd0K9XOofGgXIZqGQk
	ckNpX59vM0pr9vwH9qJAhwigxIAwTB78QFe/pAKMzYqFbLGZBYUA68BDyAj/1XIVX5usOw
	SxXJEUCaVIWmB1+O8ZGtKkFxBkYX3uih6/6RImgQTmHwVXkAerkZR447TEBoULV14m2DUM
	pe9MabgNRcGuAxwEY7J3tKYMJ16J3m/8iZtxeSHAJcqWnRwuz4pu04qjpBRAuA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: louis.chauvet@bootlin.com, 
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, sebastian.wick@redhat.com, xaver.hugl@kde.org, 
 victoria@system76.com, a.hindborg@kernel.org, leitao@debian.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251016175618.10051-1-jose.exposito89@gmail.com>
References: <20251016175618.10051-1-jose.exposito89@gmail.com>
Subject: Re: [PATCH v7 00/16] drm/vkms: Add configfs support
Message-Id: <176113452848.3036504.515555677643836936.b4-ty@bootlin.com>
Date: Wed, 22 Oct 2025 14:02:08 +0200
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


On Thu, 16 Oct 2025 19:56:02 +0200, José Expósito wrote:
> This series allow to configure one or more VKMS instances without having
> to reload the driver using configfs.
> 
> The process of configuring a VKMS device is documented in "vkms.rst".
> 
> In addition, I created a CLI tool to easily control VKMS instances from the
> command line: vkmsctl [1].
> 
> [...]

Applied, thanks!

[01/16] drm/vkms: Expose device creation and destruction
        commit: 7965d1c5354a868063f61eb101f892480ede892f
[02/16] drm/vkms: Add and remove VKMS instances via configfs
        commit: 13fc9b9745cc5dbf38c4d559114cf98f8179b95f
[03/16] drm/vkms: Allow to configure multiple planes via configfs
        commit: 2f1734ba271bb98d582b02f72d77d1c7710a8d7a
[04/16] drm/vkms: Allow to configure the plane type via configfs
        commit: 187bc30625f3e0ee8d0b3694592c4b8ff771c845
[05/16] drm/vkms: Allow to configure multiple CRTCs via configfs
        commit: 3e4d5b30d2b262c6db84773cafe9097f7ec61ff5
[06/16] drm/vkms: Allow to configure CRTC writeback support via configfs
        commit: ee5c2c7d4bb6998ff11778436acbdc3154ce74ef
[07/16] drm/vkms: Allow to attach planes and CRTCs via configfs
        commit: 95fa73787a7947a8fdfbb1ad310c3f11b26065d3
[08/16] drm/vkms: Allow to configure multiple encoders via configfs
        commit: 67d8cf92e13ec05e64745ae7b63545de5d8e867a
[09/16] drm/vkms: Allow to attach encoders and CRTCs via configfs
        commit: fad1138b2377aa094b1c80fad852eadbcf3a85c3
[10/16] drm/vkms: Allow to configure multiple connectors via configfs
        commit: 272acbca96a3c6f43414e10d433befe2bb906d7c
[11/16] drm/vkms: Allow to attach connectors and encoders via configfs
        commit: 64229b846a7e5b54cc076092475280888f74c92c
[12/16] drm/vkms: Allow to configure the default device creation
        commit: 8c29107a6119289b57d2a80a9db849c4bda66a74
[13/16] drm/vkms: Remove completed task from the TODO list
        commit: 085dadb3101d7c37d8296580c946f5f1a2153628
[14/16] drm/vkms: Allow to configure connector status
        commit: 6f00987f5ce39bfbc01af7230d3939149b006f74
[15/16] drm/vkms: Allow to update the connector status
        commit: 466f43885ac0b75efe8107d82f7c60d7daf64f54
[16/16] drm/vkms: Allow to configure connector status via configfs
        commit: f97180f094aed00bae9776f00ae61c7c020b4d79

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


