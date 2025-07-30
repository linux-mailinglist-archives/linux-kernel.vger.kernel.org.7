Return-Path: <linux-kernel+bounces-750407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF49B15B04
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AE018C05C0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98E1292B58;
	Wed, 30 Jul 2025 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kS7Lxf7W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3883F23741
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865837; cv=none; b=to7BEOsq9bJrIHJ/APesUVUxwg2PtGEKj78yi5TCzxTUbKMYvLTR2JE29vCeI1Ez0NCM9wL0bWJBRtaoT8q93FBUWBIJXxfQW/zILjCJX6YmA9CzYEamyFDzck8nqtLCLK53nJAtwa+tk/I/DI50fPRmyZsI16/8d8P0sxEuPW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865837; c=relaxed/simple;
	bh=7M8WQ93AaEVDFJvrP9tpFEBFhyFY0X5kFY5fADadnZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qwVD2EgrXAZTzoq2UaVm+wzXRsVRKqT6jFIr66SSqRrPEX7f2eS5hAGOpEt72T56D415g196mZDBHIQymr/0PxjEx+/5hUCKB2VlmxNHJurBQl09qIUo60DXjTu95Z9drwZmW22xJk2bljgq9h5kR3/4LVM4ixmrbIAhXTI5xn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kS7Lxf7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A563CC4CEE7;
	Wed, 30 Jul 2025 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753865836;
	bh=7M8WQ93AaEVDFJvrP9tpFEBFhyFY0X5kFY5fADadnZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kS7Lxf7WKc3ULnfBuTrkt7Wb+v46BmyQvieQnusgIYqCjX8FiwcsiTla7QSs4GfOg
	 UEO0I+Wwlp9swsUV5K47l64x5JIV7BJyawp8PJGpUtCkqBiWmQcGuMqOURm+NB0foD
	 46bMjN2xlnT8c0HpM0/pvoz5H88maCcr0PeegO0Sib+CbWj/EqOG7NIUx1o5xIaVGJ
	 kyfSvYSDVtqVwJ8sLbnHv1EdUEV4o+LV7vxCAYdPqKbWAGSu4YiiK9OhGgVZ5l8maK
	 vxF2ZdFRwM6AljzTudUa40XwYynFgvTOxFPNTKbgwY9qN7In34C84mueN3l3Sw9jJk
	 A0fvrlJJ/DK7w==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 30 Jul 2025 10:57:01 +0200
Subject: [PATCH 01/14] drm/tidss: dispc: Remove unused OVR_REG_GET
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-drm-tidss-field-api-v1-1-a71ae8dd2782@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=mripard@kernel.org;
 h=from:subject:message-id; bh=7M8WQ93AaEVDFJvrP9tpFEBFhyFY0X5kFY5fADadnZw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBmd9xIsGLcZn3htqnv9KuPZp85BrEqz89JDEzZem+Pc6
 6GUftq5YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEykw52xhkfhT4jl6jX7jDeZ
 b4nr6EhND0278PXbM8d7866f2NjVOnsb/1WBOb9Uv0bX7/I6KHfPjrE+eH3ApcC56a9WuE503aJ
 qsvnhw+kckkc7IgvOZgp3P9y7svvy9693s/QvNui9Z/k1gXcSAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The OVR_REG_GET function in the dispc driver is not used anywhere. Let's
drop it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 975d94547c3f9d5e9ad61aefd4eeb8ada8874cb0..8ec06412cffa71512cead9725bb43440258eb1ec 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -666,17 +666,10 @@ static void VP_REG_FLD_MOD(struct dispc_device *dispc, u32 vp, u32 idx, u32 val,
 {
 	dispc_vp_write(dispc, vp, idx, FLD_MOD(dispc_vp_read(dispc, vp, idx),
 					       val, start, end));
 }
 
-__maybe_unused
-static u32 OVR_REG_GET(struct dispc_device *dispc, u32 ovr, u32 idx,
-		       u32 start, u32 end)
-{
-	return FLD_GET(dispc_ovr_read(dispc, ovr, idx), start, end);
-}
-
 static void OVR_REG_FLD_MOD(struct dispc_device *dispc, u32 ovr, u32 idx,
 			    u32 val, u32 start, u32 end)
 {
 	dispc_ovr_write(dispc, ovr, idx,
 			FLD_MOD(dispc_ovr_read(dispc, ovr, idx),

-- 
2.50.1


