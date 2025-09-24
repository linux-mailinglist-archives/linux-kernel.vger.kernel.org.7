Return-Path: <linux-kernel+bounces-831304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFDFB9C509
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA3F3BD05C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332D5288C8B;
	Wed, 24 Sep 2025 21:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="ipFvi0I1"
Received: from sonic308-55.consmr.mail.gq1.yahoo.com (sonic308-55.consmr.mail.gq1.yahoo.com [98.137.68.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A4A15E5BB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.68.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758751114; cv=none; b=Utce9p16KQ7EjiaX6ZFOIYlDsbktvU62hYeHqQDmyUge62I6/kJnI156lKYh9ho50FyLVHdfFT7uMoQtU1667p/Zzos2K5h/hhUI56++x3c9wxQdH/LUZZDP9L1390eVpy0PzNsWhRAl6jPGSdcAQtIpRH5wjmMFsdrLNpagYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758751114; c=relaxed/simple;
	bh=r1vJ54PpSjSS8+lx4LeAIjSMmN1R6dNDEs4CzXxwzmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=CpwSQP5KaVg/Psusm9Li5FvlDsWBdvnHi6Ohijnha8afU4+gDFgpgp4SFJReNXfgdEszdW4TWHc661lj0xHXAnDRBYVqwh3fzzy2AqsmVcTkOEi/oPHAwRDgVnQFKo5iX9ihXO+dawwzv1Zo/OzzHXFUzYys0eURifkAQBwxuZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=ipFvi0I1; arc=none smtp.client-ip=98.137.68.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1758751112; bh=jN6DJ2DabP1eWXd2ZCkfZBFfvBMceXgI8xVTpnKQZYw=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=ipFvi0I1MiOIsA4Di02TYpqhwvOleOGCmWs9KyhJIuxeJRy+bevuOa5WfeOHAjFeb47US2SDNVqd8xfkmlqgg8vDBWK9lLMiDNvAFp81WF2nl7W8UhoB7FofDxDKgtH2fCbfjMeWUMJd60VGjxOCWAASFZsBjt85o/F2FuYuKGAdXmpqpBoy0TjcnIVYd5lsVH1NfmmPaOBbjckCCov3d22O7SbbjM0wj9L2EVtnRkTrOfVfPzkRm0DVmZmC9De3VcQIvpnUohTncaJbY5gtd9T0EwVdt7vpDi8OMRm4k9nG6eijLVAca7gjKiRYSRIYbDT0PokBzV2pWx0hRuqmfw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758751112; bh=7+RC0agBPx2vHqENxiQxKNYT17dC++XQegpQTvn3h9e=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=OOFruUWZx0NXnm22qrJtHU/ddVjgiQ2R532QHJz6QdmSIO3K+IxWMZkIjp6epcU+tTY/hgEPiqF4TtLUJ3aXHYlHfjq5onk9cYIQr+6OAxYUuvkE/9IOiY1ScoQKCdEQROfGZI7CcmBGXmtdnQvn+fFoEkAwbMIQ4yEputiPWa6iMboCJqLJFgUxWwACVgWlLmSM4wO+gn9YEO9q12OyOsYxh/e/AR2pWKEfSzi+c7DYJekX9mRmlp7UyqEpQCGUKbSZK8/M3kyhwbOKpShzCzq+OZ2Cye79N3Ij9XVJqM6Wrrote4S0EoTiQayVRZp61RI+Ge2fbMO9fIXvMr0HGw==
X-YMail-OSG: 2dBLu60VM1lJVqh50nKaV56YeAVyVCPNXE66YagbxIVXoh1G1S8D1idYGtJXYkH
 TgYOsDejngV9UiVivoJYyoPwyC1gzPLUOOYxoF1wbNvkEvkgxdDwLuB9_uAaQXePv6MARiQE8BY5
 gxroKge40p19X0FKrUtXIx_szkSbl2vT9.oq8WOLUkxJa3MwlsaL.GXM8V2Nz7Dqfo6M7E9Yf_Jm
 zFrk0ocb79cLRO4ku_ghoes_cJqN2BWyqtRS_OcHg7FyUahhGmiBSZu4cIZvT.eQODAvm2OHbeCN
 .UdnAcYjuGEuU_34mjiZRplOmDye8gT2btJ4eM0pQbIcINrVfzn54J4JS_USdO._7DDo5P4M7Kh8
 GAT_o58RCG9u1kp3g14uy8DPeNQaAF8opnddue1wMwVi5irbjPhThXEu0B8g5Or1GD9ekwGRLHbu
 aiHwIrIhHGJ4qV0WKCMrVLkrJ8zdBcKR0UwSjWeVIOvi3elQcYZC2ew7EhkRABoxy02QdjDtezEb
 4oucTpDSKmd7YYnAJwsaFI890GR9OtuFmxFKJ8HJQB_g5hsVy8NXPwdozJ9rloRfmDN0tYdo8viz
 .BrT80Qy6KOgOyAxjQBxW6McSZbjRwOjIwtH2KCQ_SAhn1bSp0ahtYVur7fuZMKrgvR_lMOxo.OJ
 V_aR6QWFanP8sCv7KI64bVHez74vYCwwZCLBypOq9Ajj81nuAXzLleVSDqMwNRCRNvpcJ0WhyGcZ
 TOOxqdbg89aXOr2Hw0Cq.u0S18ujW1dQnWsoL8ArpZflaqZ..qJIC_WbDosJ6uKl2ziinW49VY6D
 2VArOuoQEXyShA61I8682R78y938UeCW5zZE00USCD1MUTU8i3K9kf9qxFH0kYn5GzIVj89WGsVa
 9SGwT0xSzqFukWRWB0GPwqPw4bZ1C38wlpoupEStRvQBjzDpbSrb19QjoVCql5MhAAt4NWA6tWSw
 rSn2o_I_aPKF7gqS.pzAKDTS3JpcMIZBPPXwSjzpoGh__ATVO_s_JTfKBU62Q00VSUIXygDm1tmF
 RyXedbyI1iRP5NkYHLTcMzi.DmIXTXKF1hl1BC8jeCeb6LppEZasn5vswvXqXCgSOFqrQJ4UhWO9
 bP6IzKbfu1Z9xiHWhRyTrugebJddheNevYsfizrFULi_Zm93.EXVKBUzHevJ7cGTXBKA94hHWP2t
 rvLfsvTPxRILtmjrX82AsOSj_iAcBudjZ1yFR_OqTzpXXhSeuflXIcaVCZXYfEORh3_LgmvxOFo0
 VIVFl4cIg_geSPJlmijpYKHB7fHFjHUdsVZ9xrQrwSO1sEU4EX7BKaiuU0U_NAL_QtianMB93LSt
 N9fpK3oaY7VDHqBqieI1CqG5nM6WtY2ZfuxjHU4Sxh_dBOakvJ8eIoKT0SHPZGkECWK0Hhkjj0dT
 ubbI2500NrqHpUBkvtrsNFS3sApCB_s42e5VXJpz2fSpNHzmJgHp_JsJ1mEuLfJThonZCfB0xp56
 c19F21DNMrVO2TQl5zZYlrufLQ3w5PRqkrFqfgA15AEegVea6EC4LErd8AR32tYb24QqqRi_LCYs
 s.NlGLCdLfSr86Vv1kYvB_lmYdF3EfVwDVnrQMOdozgPlCD0kdLcL2Re8Y29Y5v1IvItgtZNKVwz
 PSJ7P_5FZZoM4BuC0kWHwaZs7Di.yXbyPLBsVrONAQzYjghRgxqYoXYRXws8PAIA2Rm4rD7h40fA
 P8AYy0HzCCZVnStCXB7xcn8_OtxYdf4YSlP5f3RzV7BgkLD1xsbJvotrRmZnrEvN0a8P9N7tCUMw
 85F6_Lzel3xwffFynOcNoI6mnbNwtbbe.N0c8vU0RfS9FByHviQ4SgTem2hBNGVgNA2xq9FeWflR
 mn5xmcdWcifvIVGsWH1ZfUtCiR0PIQ2SzMnk8O8rj1mC57ss2OGaORxlbVyWpCNmP6ahzFclUfrE
 kgRiPk2K3FQUEoNL1.U2sqt4UwHznh7DlueO3YdQx9UHBnG.wWNcu71RCHPTWPVUnvHxqlkMtg6e
 M_1nzdrHQX1xIiE154WxLA_VZ0jBwvvxejrQGD05PhMeG7jSdkDtB8Q5eRBbFHbPmYqd5H.M3cbW
 dEgPDaJFSAUuXXUgFRixeTFH9QQgBvVY0xK3S23MbLXLqSBX7txhBI2GXl39MvHph0_Oe5fX3RkU
 7uQ_g_aNZkoMXtJ7CzTpf7K71_y3g0Cy1nKzQ_3LPVUyEL2m6RNdA0fUpQr6aIUNODtk0WFwG9da
 s5zWNtxHWSmsQXKCTgcdIGw3RvB8Qb_HcFPMmAwLkaMWf_Z3_GLkdvE_bWOYCLMCgHEKmSro-
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 25109569-baaa-48e3-a0f6-d2d9d39b81a3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Wed, 24 Sep 2025 21:58:32 +0000
Received: by hermes--production-ir2-74585cff4f-twrgb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c81868d836ce73f83f7e719b570d17ab;
          Wed, 24 Sep 2025 21:18:02 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Ruben Wauters <rubenru09@aol.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add myself as maintainer for GUD
Date: Wed, 24 Sep 2025 22:10:32 +0100
Message-ID: <20250924211557.6687-2-rubenru09@aol.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250924211557.6687-2-rubenru09.ref@aol.com>

Since GUD has been without a maintainer for some time, and I have been
working on it, This patch adds myself as maintainer for the GUD driver.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 16f6013580e9..3fbeb41f8792 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7744,7 +7744,8 @@ F:	Documentation/devicetree/bindings/display/panel/panel-edp.yaml
 F:	drivers/gpu/drm/panel/panel-edp.c
 
 DRM DRIVER FOR GENERIC USB DISPLAY
-S:	Orphan
+M:	Ruben Wauters <rubenru09@aol.com>
+S:	Maintained
 W:	https://github.com/notro/gud/wiki
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/gud/
-- 
2.49.1


