Return-Path: <linux-kernel+bounces-750409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82948B15B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77F947B0B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A362A293B75;
	Wed, 30 Jul 2025 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5GdIDge"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F8F293457
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865842; cv=none; b=VSUB85xu/f09KPLaKT0yD16I9sFWzToz5SpcrdTclI4+/aD+S54HRv02p9c4vUZwY/tBwTamai/4fdupqIDdAMn95ec23PlKyjtrBVnAA+MZcyzVwF4fkUWfGK5KweVU44z+E0gz91tnkUu2Beg4BTyWMEVznxHqtxWDsSo449g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865842; c=relaxed/simple;
	bh=H/6/5bAJLbAq+nuixRMqwlb5Gusenrm0K1/fZ3hIW4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MJrLN5BhSQHyEWF7iAQpF0JTFyUUXIgBqKVaNbaKEDxGAdzIgFLLlm6ZDxSWySuU4xEwD2Z90KW+L/y8ARzl2HEz3NGUXG5+kmYWCx8wST2nKZ84YxSqVzFrY+0EhwpQ5yLdSSvUZQxPwCx4ENwO5joUpuxpXZz7agZoS0aEa50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5GdIDge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54412C4CEF5;
	Wed, 30 Jul 2025 08:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753865841;
	bh=H/6/5bAJLbAq+nuixRMqwlb5Gusenrm0K1/fZ3hIW4I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i5GdIDgeuGlIiIA3wR9Rs9JJnKFpuc2eviF1jmVGo64vVIpEi5ApdBe9Trj3hRX46
	 quFS0hzcVYDwjYjjmzHwL6EpTdRPxmS6TaDN1j3TWfibcAr4lWnRkTtHj8JXat+QLu
	 Cpu7KCS7TjaoUA9RpAS2OhM7dmZpd1pBDpiH/dUWgJYV6emhtC+ivs2S0LHOfKn9jP
	 PtFpZjTcNbOecNrsnFUA4hFtoZnc3MuVnymuOOG2dMQfFNvNRSHS9O+8JFSn/vA/te
	 fj7uoXBGTlL3g6D+eJ6/9LoWMvCAaIQU7NugogaPaoBNDxeoMHLWxXMiZrnOYd8vMh
	 PcOw08aS84e1Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 30 Jul 2025 10:57:03 +0200
Subject: [PATCH 03/14] drm/tidss: dispc: Switch to FIELD_PREP for FLD_VAL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-drm-tidss-field-api-v1-3-a71ae8dd2782@kernel.org>
References: <20250730-drm-tidss-field-api-v1-0-a71ae8dd2782@kernel.org>
In-Reply-To: <20250730-drm-tidss-field-api-v1-0-a71ae8dd2782@kernel.org>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=mripard@kernel.org;
 h=from:subject:message-id; bh=H/6/5bAJLbAq+nuixRMqwlb5Gusenrm0K1/fZ3hIW4I=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBmd9xJCLIrEl5pk5V7bMq9SzTOwcO/3+f6nj7zYpOmin
 9pQ5BbQMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZyV4exYXvx38ur0t9eyLyn
 wm1zXV91wbm0TaUbe5zkdVymzVyjysruahURqxAy98LfnstnGb7LMdZHTp296NKV0NKMO78rp65
 fu25zZ1JUpkxS5KL/E2L+u01f4fHF4I5I85dz+yrbPbjYLpoCAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The FLD_VAL function in the dispc driver hand-rolls what the FIELD_PREP
macro provides. Let's switch to the latter.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 5a0904acbed279506df2edad559dfe06f25cd7b5..7e36f5af666342dc4f5fa9159d829d88362de18c 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -609,11 +609,11 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
  * number. For example 7:0
  */
 
 static u32 FLD_VAL(u32 val, u32 start, u32 end)
 {
-	return (val << end) & GENMASK(start, end);
+	return FIELD_PREP(GENMASK(start, end), val);
 }
 
 static u32 FLD_GET(u32 val, u32 start, u32 end)
 {
 	return (val & GENMASK(start, end)) >> end;

-- 
2.50.1


