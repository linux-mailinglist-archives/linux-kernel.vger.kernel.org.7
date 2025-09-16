Return-Path: <linux-kernel+bounces-818929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E65EB59842
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD7F4628DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DE23203B4;
	Tue, 16 Sep 2025 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="s17WA7Jc"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9932C3272
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030798; cv=none; b=JIp/J81tXzMGwLeEbFA/50wP+JtDfx1+GqL+hM1/ZNTehG55HMluXaaYDgLf1LS2we01UJ0depHhjmz0HVRPfMw8Qzbpw/F6o1c4fddz177sNxVTwvyY+LyyGAhIUmT89WJGrSRcwcWY/S9UlYHNHId00q3iqUV9Fh+Di5iFG3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030798; c=relaxed/simple;
	bh=Yp2R/g2fNFa7ZfSs8Nn4Lcs6PIIA5o3oDLaRuu+UsqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q2+fe5o8ak5TT8mUKP0tt4IWq2NMner5afHrPeYnKQbxqAa/t+7KaE+IQ/fnp9BEbPj5KxgTSfv9rhevCO8sVy6tbxZrFfhlcREikMESw86CqV7I8DH4MCL3eIHsAijNQop5OwSDYXc/B0Nk9YGndpTLY8srZhznX4Ql+Y50CxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=s17WA7Jc; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C17F51A0DB3;
	Tue, 16 Sep 2025 13:53:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 94F586061E;
	Tue, 16 Sep 2025 13:53:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41726102F170B;
	Tue, 16 Sep 2025 15:52:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758030792; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YOfBlPUim/a57KH/xWF3eDOAgXrdeRdSWvKWpWJnLho=;
	b=s17WA7JcvsyW6R+Jeuy+Zt6CeDzINJoogPCTRZJLV86SxvpFuNHG3UJvwYor6fRIsW6QEI
	aW/6NJkfTat8KFpEDRmJwnyHtpBrZ/FLNh8Uxmf6/VmLHHQyjnmg+Qg/veQw6CEL+IuJQb
	IAq7YTJ3xdQJ6EP53dIcWXRy8873WRaSRVUZa8v1wcZPqDaqITaT7wBw2tu6bBxTy3kBA2
	CluRH2yaaT0kxv7angWI4WXIfjHe9uAe8/CcWpK6NFcwKQ4ahSB07RDmR1GFeqKmAUezyG
	IGtIOApWb1udIkwrdBEO8bWrtuicMVPDGtyZEVEHvGX9d63iT9xuc3LKNVHrqA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: bobo.shaobowang@huawei.com, andrzej.hajda@intel.com, 
 neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 lumag@kernel.org, dianders@chromium.org, lyude@redhat.com, 
 andy.yan@rock-chips.com, viro@zeniv.linux.org.uk, mordan@ispras.ru, 
 amishin@t-argos.ru, dri-devel@lists.freedesktop.org, 
 Qi Xi <xiqi2@huawei.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250904034447.665427-1-xiqi2@huawei.com>
References: <20250904034447.665427-1-xiqi2@huawei.com>
Subject: Re: [PATCH] drm: bridge: cdns-mhdp8546: Fix missing mutex unlock
 on error path
Message-Id: <175803077334.454670.15469913360427831912.b4-ty@bootlin.com>
Date: Tue, 16 Sep 2025 15:52:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3


On Thu, 04 Sep 2025 11:44:47 +0800, Qi Xi wrote:
> Add missing mutex unlock before returning from the error path in
> cdns_mhdp_atomic_enable().
> 
> 

Applied, thanks!

[1/1] drm: bridge: cdns-mhdp8546: Fix missing mutex unlock on error path
      commit: 288dac9fb6084330d968459c750c838fd06e10e6

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


