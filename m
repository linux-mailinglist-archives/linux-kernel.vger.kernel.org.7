Return-Path: <linux-kernel+bounces-750408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D552EB15B08
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AA917635C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FAD292B2E;
	Wed, 30 Jul 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hyl9tMrt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED660293457
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865839; cv=none; b=nbJNoIiV8sNObShZkCqmaAF+S+3QLQlvhfytw4xAHJZTct+paCdYwXiKGRaKaRvs9emRW4e/xXBlTsbSllm4GPHsaDv4rGjjKYM7vYreqA3ZCwo8eoc4fCoftsU3XGs2/5rKJisITvamItDlTUAml+Ty1RaIgZQI641v/O4tCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865839; c=relaxed/simple;
	bh=bkLVe2XldDNNSNpRPNT/dLJIjNP/DhhAJl1lPaX/SsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LihLBaTz5rjNhoxUsYukgIuZjJ9M2pqsxauzg1srpr8iR/xToVaEHB4hXSaRcGtbQyDLerwzcfHbNJ2R+0usuT4MfKcuw19GnAcfGsX9tL8hkMFgbmbj+g10qYXNdx74hovAknaBUPJ8fkGcB6kHX5CPI6T5aBNWPxEnGoQ6ZrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hyl9tMrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3C3C4CEE7;
	Wed, 30 Jul 2025 08:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753865838;
	bh=bkLVe2XldDNNSNpRPNT/dLJIjNP/DhhAJl1lPaX/SsQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Hyl9tMrt6H46igkWQMrC4KuPDiVeh53jAxZsEZ3MD5VsSbblYHRlmBq+cce4DlYMC
	 1Z2tQbS8TLexrsILrcjCVaGwib7AXdmb3XELo8FVMtEvLaKwaxowlPGpW3Az9+OVM+
	 CdO4g/k8HOlvSvbrt12XKytowS43sCTKtX+j9kCgpG4PGuH9eWf4gUOpRSxNbbHTYP
	 t8ASYrE0uNizjGiNlYS8ovcsHimMp5LGLEi9ozyrRAUjDduouDVOHoltb6rHz1+9Hn
	 MHNHO1At+ejsTpd67wP1NkOnzIA8WGYbXt3ZCiAtMnh+NqAakFyEtzknbnJZ24wYZh
	 DjpZs7ahOKuiQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 30 Jul 2025 10:57:02 +0200
Subject: [PATCH 02/14] drm/tidss: dispc: Switch to GENMASK instead of
 FLD_MASK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-drm-tidss-field-api-v1-2-a71ae8dd2782@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=mripard@kernel.org;
 h=from:subject:message-id; bh=bkLVe2XldDNNSNpRPNT/dLJIjNP/DhhAJl1lPaX/SsQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBmd9xKmbpyxo8Ih/+jppS8TWVa8X9m67c/9RUqKhWeyv
 ALjpk2b2TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmsrWQsU7NWtfQu/nvceag
 C/Yvgsrrpq/b8Z733NTlVapu/+I1Le5zrgmWEfCxaKxheLPHO2hfNGPD3hfiK3+yvn1pNPW9Unz
 +Ga/Tv3Nm/rzskZlxOUnVykYpw6S1MVgkz1/2N5NoTEH0jx4A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The dispc FLD_MASK function is an exact equivalent of the GENMASK macro.
Let's convert the dispc driver to the latter.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 8ec06412cffa71512cead9725bb43440258eb1ec..5a0904acbed279506df2edad559dfe06f25cd7b5 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -607,28 +607,23 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 /*
  * TRM gives bitfields as start:end, where start is the higher bit
  * number. For example 7:0
  */
 
-static u32 FLD_MASK(u32 start, u32 end)
-{
-	return ((1 << (start - end + 1)) - 1) << end;
-}
-
 static u32 FLD_VAL(u32 val, u32 start, u32 end)
 {
-	return (val << end) & FLD_MASK(start, end);
+	return (val << end) & GENMASK(start, end);
 }
 
 static u32 FLD_GET(u32 val, u32 start, u32 end)
 {
-	return (val & FLD_MASK(start, end)) >> end;
+	return (val & GENMASK(start, end)) >> end;
 }
 
 static u32 FLD_MOD(u32 orig, u32 val, u32 start, u32 end)
 {
-	return (orig & ~FLD_MASK(start, end)) | FLD_VAL(val, start, end);
+	return (orig & ~GENMASK(start, end)) | FLD_VAL(val, start, end);
 }
 
 static u32 REG_GET(struct dispc_device *dispc, u32 idx, u32 start, u32 end)
 {
 	return FLD_GET(dispc_read(dispc, idx), start, end);

-- 
2.50.1


