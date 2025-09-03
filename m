Return-Path: <linux-kernel+bounces-798002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD642B41842
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587741BA3B84
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5869B2E8B9B;
	Wed,  3 Sep 2025 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ5tnxv7"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD92D97A0;
	Wed,  3 Sep 2025 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887668; cv=none; b=HnY0dEe/TVooRuMOQD1MRNPeMxH5c5pMeLDQcZtX4BNmRR5JnfVf2NKVIUxEND7ayOpnZGqUMvVInZr9w0UXdpiLQT8ZjWEZHcLpu0tg6w8MQNcTr3CI/QdBPfooSNw2mMiDUpk/zShPY6Stmgf3IKIWs0fG9AGjIZDEEkvQMIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887668; c=relaxed/simple;
	bh=xim5li8SvF8O92Sgp1SiYWv5cuXvHlYpT5yKDTxBwXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pbZfvxAhh+GfYYwbNnbNOOhQ8jn+Xp5nBWlrPa22g8IIE97rfKx7UU+ax42P3K+5YBaB/XiHuRgmJ2sJaAmrizD9MBeKXg6GfBZ6jO8K2XBOqF5D8t2+eCF4XbCKBmXcQlrQRj497b2TMCXDYkG5V3W8eQeDBOswKgTsiNIwqLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ5tnxv7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3d19699240dso431082f8f.1;
        Wed, 03 Sep 2025 01:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756887665; x=1757492465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V+oQBUiR0fs5f1jGdxGBuHkx9I/qpPK1NnThL15aM4w=;
        b=kJ5tnxv7V/QpGrrAg7WS9ZdeErTuTqnxId6fa93emhQ0t2cl4IQniFcl16lXGH/e5C
         kYAB0bYHDwgDj0VdspFqpN6AETwQCGxVbM4oZlhzB5mKPYCQamB6FYqeQZg/KD4/FfH0
         AU6nqNdjL36E0J4QQsBaeXfuhZ6ySmnGL+5kDML1vk1ZbTd1GIFgekWfloVHFfMPwfX5
         Wg5R8gvKkUP1r849c38f6Psu2Okx3YPhrj/Jc5WKKYXdsZ6y9S4s9z9hlbxWKUDiEzH5
         0fUkhrqufaYGGH9pP0rVNKSAyE6+GuSdIpNsuOQkErCHE/efAxS33WFsc7PM2L5B0MU2
         LGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756887665; x=1757492465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+oQBUiR0fs5f1jGdxGBuHkx9I/qpPK1NnThL15aM4w=;
        b=f8Rl0T+yKueQyhhAKCeXd3aHicYV0fksDYsssXliG6tG5ubdi+QeNswqbhMqE/L2Pw
         RVdBLEMZ7hKN7EbIXo6dKaR2otB5eCwXUeb0l/xjgBUxTIyKcoRLZ1+sOBoY8gf/KQJG
         +bqV48rDrK39bghAWdPpRY5ua501fBY3z2gmsX4iQuz9gqr6vnuQ/P370FT88Dmk1lU1
         k8wZ87N03uN3K+VlmQjBEidBjwVAc9vB15CqnSG/jvtLufD9MRxK+6qu9ISO95jroULk
         GyPRjMgpwd/83N0gn2BhJfIHCt4CErLtJhP8S61JtF51jT5JFmxbVxaCBlks0Et10e33
         4djw==
X-Forwarded-Encrypted: i=1; AJvYcCWy6zOVi0vXixCredyZmHzB/MLdSywKk+sqHH1AUpkOualWaYgval6pyyg5LzUpnIaAEWuLcYrkPgGL97I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSMLAO6ObSifLKqOinCLQYckIzDuOumKW5FpLeauYZPdir4Jr9
	ZHaOcnWZtXkpm78Qm/OuEZz21t+h6elYz5z36ApUb6dcGa0JLop9Fzbn
X-Gm-Gg: ASbGncu24e2kKj0MRSAuY5F0x9uv4fOCh6AoEb+aoe9fhj3sLZ5ZI4Gosq+qTrV4jmd
	mRZmjuMqhoI0Y6NnzsZ/HZpsbs1t17ZnriDCZZR+lVyManmOiB/sccoa732dwoWDYuRU32eTWXA
	sfD8LoQRdANmjpqJTKgycImOTXtCtgYuofjGipsL6qeO4dQiG8FojhlW0J4FjXxKfDFP+Sn51Bi
	a4gb6+oqkR6Str3SPYg/GCpLcsuZwrEIy+69wSyouRb+2TRRYh2Bz9lArYL3uqowZMgnZmO6i5U
	IlybFcqtW6rHGIFJku/C4TEsVOfNZ+WttwnpAhztUvEs+UrB4BaofSrQF9SR/mfzC2Lk4OpoQnp
	9NtU45l6wnlildkO6H/HE
X-Google-Smtp-Source: AGHT+IEHvf7b/CRSNGcUf7t++ZZJaW7tRGbsmvmOkYlRwH6ByjCb2owYmmiEGN45nff71XkD6CxVgw==
X-Received: by 2002:a05:6000:420f:b0:3c4:2f45:1503 with SMTP id ffacd0b85a97d-3d1b16f0bd5mr14924110f8f.16.1756887665095;
        Wed, 03 Sep 2025 01:21:05 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3db72983560sm4115452f8f.1.2025.09.03.01.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 01:21:04 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/amdgpu: Fix a less than zero check on a uint32_t struct field
Date: Wed,  3 Sep 2025 09:20:18 +0100
Message-ID: <20250903082018.2702769-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the error check from the call to mes_v12_inv_tlb_convert_hub_id
is always false because a uint32_t struct field hub_id is being used to
to perform the less than zero error check. Fix this by using the int
variable ret to perform the check.

Fixes: 87e65052616c ("drm/amd/amdgpu : Use the MES INV_TLBS API for tlb invalidation on gfx12")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index cd5c966cee95..ff5df28b57ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -899,6 +899,7 @@ static int mes_v12_0_inv_tlbs_pasid(struct amdgpu_mes *mes,
 				    struct mes_inv_tlbs_pasid_input *input)
 {
 	union MESAPI__INV_TLBS mes_inv_tlbs;
+	int ret;
 
 	memset(&mes_inv_tlbs, 0, sizeof(mes_inv_tlbs));
 
@@ -911,9 +912,10 @@ static int mes_v12_0_inv_tlbs_pasid(struct amdgpu_mes *mes,
 	mes_inv_tlbs.invalidate_tlbs.inv_sel_id = input->pasid;
 
 	/*convert amdgpu_mes_hub_id to mes expected hub_id */
-	mes_inv_tlbs.invalidate_tlbs.hub_id = mes_v12_inv_tlb_convert_hub_id(input->hub_id);
-	if (mes_inv_tlbs.invalidate_tlbs.hub_id < 0)
+	ret = mes_v12_inv_tlb_convert_hub_id(input->hub_id);
+	if (ret < 0)
 		return -EINVAL;
+	mes_inv_tlbs.invalidate_tlbs.hub_id = ret;
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_KIQ_PIPE,
 			&mes_inv_tlbs, sizeof(mes_inv_tlbs),
 			offsetof(union MESAPI__INV_TLBS, api_status));
-- 
2.51.0


