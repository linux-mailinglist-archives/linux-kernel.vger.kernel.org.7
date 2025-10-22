Return-Path: <linux-kernel+bounces-865656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 156A7BFDAF8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD330501F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7612E11BC;
	Wed, 22 Oct 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6HqbWSX"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97D2EBB89
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155141; cv=none; b=mCs7u68jke7BVW64M9nagtmAnVz48wpfxDO9OqKH71VMPGkf8yQHRFzTUrZlSYPk6ACzElsQzJ/Kcv722LTDDL531joGRTOIoMtIxXoe/C4D5PatmOzR5bxdlV5594ytgDFj9C36E4dYV2UysAruUpmZTQJ0sDjGBT/8l8l1DC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155141; c=relaxed/simple;
	bh=hcgBLrm5AprMmq6STEBsvMEfTZaW4+SauQoocHKpEbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WCWXgCP+1hbSie9fedUl6IkrtOVcWTuHKIAGPxthFmhKii5EPi75XyRcUS9+rDW+Oe7N5/GRQYLelP98QgiTsaY9AlkILhnKkYdg8SuvpqaUE/HT36Vo7ORvtFvVQl4BoxMrUDcGOfMHLorfL2BrMSj6zyV4zRtnC3kZ4Q8TGjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6HqbWSX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2698384978dso49621825ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761155139; x=1761759939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oM0pDJBRrStQb9KnLg+RsNAWtHLuWFkw3NawKCjlW2g=;
        b=E6HqbWSXGdqLfDADmMHoS8KW5wT0gm4gyfwgY/hv2AVZQRergTXpYCIBZe17NSe92E
         kpbHq8CD6uwDzLycMjKOpGbYsJAKODDmeEdIE5KQ+gxs/TAHOykG6EGT7OB/EtKoWtSE
         YTfxlGC+BMcVnyg/2lOQBhSp0cYTBUB5PJxF2i6TZ76G9GzzJ9NkEkqRjKT2r64Zv9zc
         KbeJU6WO8t+REq5ZUceQ2xuAG/zm9IJao0CmgUKXyy76jl0MIvLxrjkKcn5bpw7lCKeP
         3RhW98QRM3o0DlSl6LgrAwULMbRGqUeqtV50LW11c+BfZH20fuKhxczDgLxOG29frWEi
         WGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155139; x=1761759939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oM0pDJBRrStQb9KnLg+RsNAWtHLuWFkw3NawKCjlW2g=;
        b=ix9Sz3+NKnWe+IDMefyjdWj2HJdXhiFMT+hF3RpKHhHDAD8Uy4Cjj4DiNEVgZZ+K8c
         2NV39FFxIjOeqj023VfhfRIpS2Be5gQMZwduHFGZTI9KGm+B0quQ8CUcnrcu2iFC9nsw
         npx3lsFK98d0Q6RJE4DUmhYM24LjgJ+Jx5/Lwm+pYRLT+RQUZaLwrHNl4Z2jl+WlYu9t
         WWxXw/1CUU6kq3DTw/E5K90MbFxkviSdUDfeo7GkuOdyfj1xELD41eX1/v+jaeMNEjS+
         u21/euOTsyvFKhC9bKEbOz1c/tEqu6Gd7C3Uaw7wVc4y6smGv6d20eQs0iFTD8wQIG69
         1SEg==
X-Forwarded-Encrypted: i=1; AJvYcCXdQcjelmPgh0n4CaXiDPHxq85IE+yul+WQ/r6/0SkTxgZlP6JB5DIdcyqDIPxCoeJwLW3nP8KCeX8O1M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOCJ3WrXNQfbIh5kCBrZpyuwWG7+4LAU66EMaYX8ksdOr+/vBI
	/hv6s9UoPErNOooaE8B/zWLPaLc1m4canQYCA6wMuVNnvtWL3Gbaidkr
X-Gm-Gg: ASbGnct0qWyTdsfzZ5D3I+sjdLQp5le4X3LdHrFant0d9HIQQP8pE6JUp8Dv4iblvgl
	Ax6/tWteK5i46wHgiTA3nIJRDnog+vXzeogWwfJTiQ6En03m66AFRA7dgvVT20rG/pvkGabPTLH
	M5DnPzcBvHvLvdtGNSFr7HVSzFjihNpWelYxgvee9+tnlc65N1cQE0UnDi2TGy9Puh1/EQ/tX1f
	FTaEE7/qm7y57qVTTRewQ92lZiMeJyVHFs9q2YOnuVCgRmbb4u+N1H5+THVj55JHtTo5ss+19fn
	8uApEKoUcUGto6ATPFiY5te2APBRgIScVN7uEvIaQq2HArdsnoEOyMHpmMWEMlC+CuYvSFmHiKy
	HaB65qPWP7Dac/hgrUNNSRjj4WQ/iunFgyU1VTdTFenY8WI6sJgavYBawpGGH656i/ak8GyYU6f
	Oetfk+jQM0zZFKgT8B
X-Google-Smtp-Source: AGHT+IHb4UIqxNyAS0ncT48o4IKsYNim5/1u1ybLcIRuulzDwqqLijuUsEqmvETulRw3f1HrLT1irA==
X-Received: by 2002:a17:902:f552:b0:269:ae5a:e32b with SMTP id d9443c01a7336-290c9ca741bmr272886775ad.13.1761155138969;
        Wed, 22 Oct 2025 10:45:38 -0700 (PDT)
Received: from hilb.. ([170.254.111.1])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29246ebd7b8sm145298905ad.6.2025.10.22.10.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:45:38 -0700 (PDT)
From: =?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>
To: 
Cc: =?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] soc/tegra: Resolve a spelling error in the tegra194-cbb.c
Date: Wed, 22 Oct 2025 17:45:24 +0000
Message-ID: <20251022174531.1751-1-brunofrancadevsec@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, this commit resolves a spelling error in the tegra194-cbb.c.

Signed-off-by: Bruno Sobreira França <brunofrancadevsec@gmail.com>
---
Changes in v2
  - Really fix the spelling error
---
 drivers/soc/tegra/cbb/tegra194-cbb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/cbb/tegra194-cbb.c b/drivers/soc/tegra/cbb/tegra194-cbb.c
index 846b17ffc2f9..e1deda188fdb 100644
--- a/drivers/soc/tegra/cbb/tegra194-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra194-cbb.c
@@ -1836,7 +1836,7 @@ print_errlog1_2(struct seq_file *file, struct tegra194_cbb *cbb,
 }
 
 /*
- * Print transcation type, error code and description from ErrLog0 for all
+ * Print transaction type, error code and description from ErrLog0 for all
  * errors. For NOC slave errors, all relevant error info is printed using
  * ErrLog0 only. But additional information is printed for errors from
  * APB slaves because for them:
-- 
2.43.0


