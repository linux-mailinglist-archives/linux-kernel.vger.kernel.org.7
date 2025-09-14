Return-Path: <linux-kernel+bounces-815542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13220B567EE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9FC3A8E2E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D18A261393;
	Sun, 14 Sep 2025 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zyq+5QBF"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443382571DE
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757849392; cv=none; b=rgOgNo0uSjik2jPzR4W2UAC6e4FeIHwOJM90rmfbYAwK6FjO1Krs9SIRr7P7UAe6pglEHUt5I6cPfUVLjd+9L8xqSYkAvojTf31ouWCPCXDlOJMBe4D79W8S6PhyrcZwu8x0QCWyWFtq+JivofXtKeJaVeQCymoHe2yhTNSy2Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757849392; c=relaxed/simple;
	bh=eGhvv9/N66YsxzDcDqEg58aZlG9m/MLJsOnFOeq3D8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l++lymIC6D2EaN2TbrTkR9MmmGFV0LRM6LIoayMu9PtbAOhc/I3ewB1/9SeI9LFmJMjDC9GsHizOUKzcAPj8kCoXMbS/VRjfKZPhOmWTbubJuZtpVqn3FmUYOfpyQtXWrYmo3QKcK8FLLyOMvU/i+XRcASDRP7T94RfnWRNdPrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zyq+5QBF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45ed646b656so24210185e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 04:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757849390; x=1758454190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vsQY4Dw+NKWkDueuyiKs+vcdnaBKygRmkUmRr7JUuk=;
        b=Zyq+5QBF5hC+ZTkBwgK9TPRZ90TD9wnHf8TOy9nCbJFiyTDPc9uGAWShZlA9I4evU2
         EpmncFCJZtFPNvCRXnNmaPqxKq5TqR7lCobsFZlqxd7oaWVj03WYIGQLpetSsMP50Wqz
         96mioUN2ADah1apBDjrdpwJJtfRxfOo9CZrg8WXR6Nbgk4XRuf/6koK8aD1+41L1Q+91
         F+hvGmrYy+IUUFSxtdvdSg7YDh4JuNd5mrcuF1ceYJmOxTiJkoadtLk3m8UFvK5qjjOZ
         ua1UKEFlTqa8Uv1ARJOjo8ASgVLTkdaMBlxz8gMEcKVxX1R35UTQWneSewEZWO3JT8my
         TDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757849390; x=1758454190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vsQY4Dw+NKWkDueuyiKs+vcdnaBKygRmkUmRr7JUuk=;
        b=RVEqTLrXj/gzAiT9xjUDuZqUuzMdAZ8Ia8N3pmUquOhGbWhbJQobr+vgkKm6SeEUcX
         Pm3gx/4XEKcLnBky5sr25vrkSQs0VrRZUZHv+M5wzh4VfSi4mfgOi/TpfBZB3BHY9cpz
         yNEY2Xmlhf7TyPmuFbmpoKTh6wWNbpgKMhLCazTpu4tgkH8mJQqgCVuLqTMKS/u3Ry55
         HZ4coDsRzg4CWDaKZhL3wmJIh8PU21lFvtdsV0p7On7SUozK9ipJ7u2LEXd5lgK0YhvS
         BpQVcNkOblVVMfXZGCyG2yOhgzUttyJzuR/QLoPwXk9pvgJb5HfQxZx1aLMgIqkItmoL
         2wGA==
X-Forwarded-Encrypted: i=1; AJvYcCU7TfDfZDAvE57eVn4L51RAnLdjjtaGasOa/q0LCe8THOL+mOsrmt1ABCJ+4LotFo3eCiJciBJpnkzkHiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynjNIuleT27YRBrlkR1Hk7MUGfA5RXMxKl4Xualb/83BOtih64
	XdNWWcehebelH0+mEQ3e2bx6x1YyJ7hO3hhkZbWlwhitEDNFwqf7RX8byGwhJA==
X-Gm-Gg: ASbGncskxGjTrE3vRN5ked1GONbKkwqPGlyIK0FwGDYE7a4tIly6Cqoebup8bL1nOdS
	MsLU5lAX+p9HCDXOJ13uUt/e4mO8hBDZfq9xpcMDC/m6YpEJfxOyIawcH8RwVOyC8FgiMUOTV7U
	HqZnP1Yn8p3BpAYrW1MgPL4pefRG3hVILRWUAmlmH/kt434tRBIPz8JY0tBaGn24lXIO/4/SPVK
	7Fl8h9JBvJzfjZTogcP4oSG6nKzhEDTP3epZuF7hDiyCXuEzwg4CKxo/B2EAwo6uFLOwrNTRo4N
	GPDyXIl//edAR+mK2lDAXuqAdLVaWE7sY6luPKG544QPl47M9BpFIyoeZRCEi66NvQINh+lNfnl
	syGSdGmWDw6UJ0y4Hc2eF8jSXN6v7YvaBe28g6Bid2FByak1FFGl5eSAl6SIHO+f9ccgMoprBmQ
	==
X-Google-Smtp-Source: AGHT+IG7cUFQKEKzCWjaXCRFkeDZbrdH3vz4KY4We/ahlJdKQNXRJ0ZP4meSLxgeXXNpvydWJj/Jiw==
X-Received: by 2002:a05:6000:2584:b0:3e7:5edd:ce07 with SMTP id ffacd0b85a97d-3e7659f3bc0mr9180559f8f.40.1757849389608;
        Sun, 14 Sep 2025 04:29:49 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8346defd3sm6591268f8f.1.2025.09.14.04.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 04:29:49 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] soc: samsung: exynos-chipid: add exynos8890 SoC support
Date: Sun, 14 Sep 2025 14:29:42 +0300
Message-ID: <20250914112942.2604194-4-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914112942.2604194-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250914112942.2604194-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add exynos8890 information to soc_ids tables. This SoC product id
is "0xE8890000".

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 drivers/soc/samsung/exynos-chipid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index c86f1058c..02466f916 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -57,6 +57,7 @@ static const struct exynos_soc_id {
 	{ "EXYNOS5800", 0xE5422000 },
 	{ "EXYNOS7420", 0xE7420000 },
 	{ "EXYNOS7870", 0xE7870000 },
+	{ "EXYNOS8890", 0xE8890000 },
 	/* Compatible with: samsung,exynos850-chipid */
 	{ "EXYNOS2200", 0xE9925000 },
 	{ "EXYNOS7885", 0xE7885000 },
-- 
2.43.0


