Return-Path: <linux-kernel+bounces-720302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE117AFBA01
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10837AD5B8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0B223027C;
	Mon,  7 Jul 2025 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b="jzZAXPQK"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A0C1531D5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751909906; cv=none; b=Jt/9pMH6Gt42k2fvIknl/dq9JMA50Vzhx/eoEi9YPFXU5PZ7YXd2xXRb06zOota3A5j+qK+1DE68oITKpJNVVd5oY6f8x+F+jbs006QXoniT0vBGvpn1TztG0+BBD5J3zRe7y0yc3VlPWFutnq4hTlUTGDiYLLqPzNTvyzVfl94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751909906; c=relaxed/simple;
	bh=nVDkaUfKo3r4J+x2tvT9MRT1HddQxYFEW8i1YBoXzQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qmt3vFQa+Neqw6mXdciAV6Ztans4sWg/CFZSfADgIUaoe7h2FRLNpswH23+AoX4dFR98P9cLWvBRBzHswUdc4b4BWnHOIO88xGoRjz9pfDIllfceG16AhhjoROKyrcRR//Beiebj3fGWiqzbE1xZv5HAUpSinotmO6jaX7UCeV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us; spf=pass smtp.mailfrom=gmx.us; dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b=jzZAXPQK; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.us
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.us;
	s=s31663417; t=1751909891; x=1752514691; i=len.bao@gmx.us;
	bh=M/R9PLJBJYuOUjT8ZMwGj7nkYG6TVpUT7FXWdZjV6ZE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jzZAXPQKQNW/wGESODtspOsnjMhsoxmh9Ot1EQB7mPepZITXmLNNU98gvWY5STsv
	 vuVfc9yF+NZIxyHLzod+T+P9ZONhdtoV6vg8QJi9BNA85Brs8z+gsqBpLzGKkx+OE
	 rOazV4KKJYt9HpIs7iBzefuDZ4aVUvSJdZzzlsMMJumTecemALcafsKeYa++xAb1b
	 sI6R5USytS1ZsHF1kI0iSrI/IkKltA62pw8+0yoP6w6VRCzbz/m3pVyc5ws7sDHqV
	 XA0W7LmYbdKtbcd/+VF0jH0L7e37QmstqXH6GNEQGsXD15eRtKkIkwOgc2YZegUGF
	 0VHyp+XqODx3Z040WA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ubuntu ([79.159.188.137]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCpb-1v7tED2n3P-00lozv; Mon, 07
 Jul 2025 19:38:11 +0200
From: Len Bao <len.bao@gmx.us>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Len Bao <len.bao@gmx.us>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/dp: Remove dead code after return statement
Date: Mon,  7 Jul 2025 17:37:34 +0000
Message-ID: <20250707173736.13743-1-len.bao@gmx.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3CTQjgmwRVdVmDjx4HGYavnyrdnxebsFFlGi7tDWRcZvYkiEniq
 1LM1I5kS3Zo1bX2wp3h7HvwBEJ59ZD+wKrA8slmc19fhSSxIkHusmcdc4lQ2C4yC9rD6Q0C
 0tpuiMeJfP7dfLtGw2PsEtRODt4KCREphWSLc/cOYSHW/vapsXNWg9wu97za/TWJUpVAChZ
 vPlEVqPydoWZ50vywndNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WsczdQz7jgc=;X3icrgLILKzbIvyv+3kmSrXscXJ
 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
 mDQqSrxA+4bSXDJPknGQ==

Coverity noticed that the code after the return statement in the
"drm_dp_pcon_frl_configure_2" function is never reached. So, it can be
safely removed.

Coverity-id: 1648885
Fixes: af67978ee37e5 ("drm/display: dp: use new DCPD access helpers")
Signed-off-by: Len Bao <len.bao@gmx.us>
=2D--
Changes in v2:
 - Remove the variable definition (kernel test robot)

v1 -> https://lore.kernel.org/all/20250706162431.15029-1-len.bao@gmx.us/
=2D--
 drivers/gpu/drm/display/drm_dp_helper.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/dis=
play/drm_dp_helper.c
index dc622c78d..fcff51b6e 100644
=2D-- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -3577,7 +3577,6 @@ EXPORT_SYMBOL(drm_dp_pcon_frl_configure_1);
 int drm_dp_pcon_frl_configure_2(struct drm_dp_aux *aux, int max_frl_mask,
 				u8 frl_type)
 {
-	int ret;
 	u8 buf =3D max_frl_mask;
=20
 	if (frl_type =3D=3D DP_PCON_FRL_LINK_TRAIN_EXTENDED)
@@ -3586,10 +3585,6 @@ int drm_dp_pcon_frl_configure_2(struct drm_dp_aux *=
aux, int max_frl_mask,
 		buf &=3D ~DP_PCON_FRL_LINK_TRAIN_EXTENDED;
=20
 	return drm_dp_dpcd_write_byte(aux, DP_PCON_HDMI_LINK_CONFIG_2, buf);
-	if (ret < 0)
-		return ret;
-
-	return 0;
 }
 EXPORT_SYMBOL(drm_dp_pcon_frl_configure_2);
=20
=2D-=20
2.43.0


