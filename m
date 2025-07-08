Return-Path: <linux-kernel+bounces-722121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AECAFD58E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E4C543AE3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26B12E88B1;
	Tue,  8 Jul 2025 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wvUWkg3F"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47C52E7F1E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996152; cv=none; b=IZtonlfUJxyBT9H2E+puultZbFhal5UxK33GyPkW7GqNQ+8hC3jSAxvXywGolXwyE+WsEKLOACN55PQL6frA0hD2Ao0rJ0iMZ1yPu2i7y01YaYAKVziPmSQE4HNVjHjmg6v4vYX3nD/ONZP5XToKhBunt8cYaBLBANCHUAsKn4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996152; c=relaxed/simple;
	bh=y7nngF/uIIoDU11cKIybNqdTKaReBBxh3t+dvtDHLds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIlDYWzx12InsU7OP6fMgTyex7SnNlwvOjLh0gHZxwYOXsx3wfGyCFkkk73/e8eeLtUpC/hkT+TnIWl4kKCPnWNGb7TZnFWYvzKK8PDfacad2QgfwevzCbBi3OZ9WR96fptlU72TQm9XtkjvmQ4/MJMkL5DNKo1ZHh5kV6z43F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wvUWkg3F; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=UsrAewYdxCOw7meyNu9Dxfatxc14gQYGLBU0rmsxSXI=; b=wvUWkg3FkW0jkJVolAjco2fGUu
	e2sbQ0rIKJLerF6maTBPwGeip1j6T7f2pvNpS90enolEnhNMCBIHkMjFGj1ZLGKPG67FOBOFGRfOS
	VHnjeAtbkAH0u1KKj//tyRfM+vb2aEov6XExzXwOfeqeEbOJ3v77ajzGvhPCLtoKKi39mxK5+0MPJ
	ayP8CGHSIslNeZUtFZ+q1I01UXdxx34uWs3ETy738UirGof9X323x8y6VcnB1jpDcd89j/9DHoMc+
	sLXRU6N4rO0TtHjL1ve2JLWn0AmxqKMJ0MLZyP0B/RuB9KZz2qx2sB0nz/soxYk0zjhIS3iSbojIy
	RfWQC2Kg==;
Received: from i53875a8d.versanet.de ([83.135.90.141] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZCE7-0005cC-6g; Tue, 08 Jul 2025 19:35:31 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Chaoyi Chen <kernel@airkyi.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: [PATCH v4] drm/rockchip: cdn-dp: Convert to drm bridge
Date: Tue,  8 Jul 2025 19:35:16 +0200
Message-ID: <175199006057.1731917.377817003707865970.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250529071334.441-1-kernel@airkyi.com>
References: <20250529071334.441-1-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 29 May 2025 15:13:34 +0800, Chaoyi Chen wrote:
> Convert it to drm bridge driver, it will be convenient for us to
> migrate the connector part to the display driver later.
> Considering that some code depend on the connector, the following
> changes have been made:
> - Only process edid in &drm_bridge_funcs.edid_read(), so no need to
> store additional edid info.
> - Now cdn_dp_get_sink_capability() only focused on reading DPCD_REV.
> - Update bpc info in cdn_dp_bridge_atomic_enable() instead of
> cdn_dp_encoder_mode_set(). Actually, the bpc data will be used in
> cdn_dp_bridge_atomic_enable().
> - Switch to use DRM_BRIDGE_OP_DP_AUDIO helpers.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: cdn-dp: Convert to drm bridge
      commit: afbbca25d06e2d361016da43dbb90f3a6034913b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

