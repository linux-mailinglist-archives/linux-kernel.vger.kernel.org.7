Return-Path: <linux-kernel+bounces-837754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C841BAD1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88681926F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A362FE599;
	Tue, 30 Sep 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="NzRhiqGU"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FB3265CAB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240639; cv=none; b=AzEP8ZHu53LMLy9b8HLa6W5zHtfHBPMlD/1GDfyT1hH8GEFeEQbAfk6vgq+UrcYc8ALCKBilXS04/GGDdAEocohSued9UedlDjtt/Bs5yKbUxItYm53StujZHCFwr96M5yHIs0y16jAHYHSRz8Qzj6KwzVr4vVOwZU9t90pvYQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240639; c=relaxed/simple;
	bh=LvoK/fU0u4wr6mRtgdT7avBiMc754iRAL/avyJ7a/+o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iDNtZZrsEcNu9wWdUO82kJq0wfiE36LPhi8t33mJTgKhBYvY953iXqjbw8u8vnJaa7MOR7sOO3EoEtWg0B+knkQ/2A5xb6+OH4Kl6askyudS149mfvmQjJfSPScw6hbiIq2bM+PprpRwhFbwpz6m4u05C4LnyqfXrmpURk0keoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=NzRhiqGU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso12154176a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759240636; x=1759845436; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eUr7vsKJmPNDRIs20r13nEz41hFknG/qraXbAKvVO/o=;
        b=NzRhiqGUDh498dEWpEe7rKJ8/3G5f0O45Ju5nXQu28UNz6wUWgZc32wWrw6ZCerq9A
         VftOqfCYplEWDsrfelFkcMxptOPlsxZX71A6pTaXtiZmSZD0D9WZFJtPgM6LURLCGS9e
         XJ1xZ7wDZN3Kvq2/WYK3dw2flt52Flzv7ybWZyHluobf4GfaNSHM/AtQ7js5CIz8gtU0
         EMHC75owQcZRd6YVhQlfbkf1aR+ff76LiGZ121W+Xhuk/ow4QAG68FNLkTMWT3T/SZNI
         yGgKrlgpN3vedgN5OdTFm0nUSHsYNIKNg52h5fzFgHvhI0tFaRHZhBKPMKrtvaYjNb71
         zQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759240636; x=1759845436;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUr7vsKJmPNDRIs20r13nEz41hFknG/qraXbAKvVO/o=;
        b=MV5EC0XrCAdEAzRcbVJgrC4jOXNlKsVGP2Q/KWhhMZpJ+KvxdLTM+zir3/n67QDFIz
         gqZyScd6itIke2p/QjgnfVrQp/MnsuXjcDEyrpaSoXhy8jGLs72zkQ2180ECE4RDyD3i
         MCuVXCQUoLejNSR5CO64Vc9lb2j/ieIwoobXzLCDeiLWCdydO7dhxHOSHeLl6VhvrfeJ
         +01pfRxIUvwMSH6t66QNup0r3VXqavuUfLBZzDj1HHPtrOLBJbUom1kYUNX4OgEVI4LQ
         3OI9b1fN3o5/EjYkpBSvV4POXlXNm6m/vzudlD/oeZlArJ8kPf5aYrLSw3Y7+jduftpB
         1aOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeG9xy3tUXiAaT3LyG5mvuz18+N7tffHeggaIP5ogCFWcTLT9Pq36QhJjvmr7Rx89K4OQWrMnb61oLCvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT6h9KfqfarPxq0AWyHnPRDnO/8Kafvw4Jbh07GQCcsEdyMCcw
	AAZEW9LuGyH2JZJKSKc0P/mKQJ1I4NNZBP789iBB9KpUNb9JtuIr04o4HZBUotDwztB/C+/opu9
	rCDcQZGg=
X-Gm-Gg: ASbGncvisoMiUvuJrrflRlbnjizWW7t3EGvY4kQD4Lstv2/qe90DasNKkLSEQX8xWif
	UYypTp49K4ZlcpboNXH7fQBf2qwvla+t/FzeJ+xzD0rFGAFcsT+w7CPK+BUA46DrtK8xmR7eqiz
	lVMZTiF0erGM2qv01+Kvc2NcJ9gUs8lcaBSSSgn7pMq7I8SpPGSg9k2DCHlAtHx/bmCHXkpuPEg
	gsfawvWMi2AVHD9Kzi3BSN4+6Eo+S4AKWLkCNq/GlIOyL6wnYx9O0eJ3xQPzA9vDbn+8FxaCcLa
	Q/53Dyi+Z6YZH1nzrbp53P2qW3kwBxyt4bF9jsdM1/O505OqSPXGw7YnGpqwNAl0vJaiXsIZ2Rm
	aFlbW8e34qHQ1ant9gFpqQ7udfHLXeT2RXGUaCUmDNt1F7YjmAcpxpbxrsckZyXQR8U1M/raz4i
	8ddgLRWL9fbyNB0dLJsw==
X-Google-Smtp-Source: AGHT+IFYeOgKWJT7YPQFm0YeDty93OJbZCiOvEyhMTrBgicIfyRCh7ByvycGfhKCy0N/oNg9ro2maw==
X-Received: by 2002:a17:907:948e:b0:b3f:1028:a86a with SMTP id a640c23a62f3a-b3f1028b47dmr844768966b.3.1759240635975;
        Tue, 30 Sep 2025 06:57:15 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3fb818fb90sm370234866b.63.2025.09.30.06.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 06:57:15 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/5] Mix of dts fixes and improvements for qcm6490/sm7325
 devices
Date: Tue, 30 Sep 2025 15:57:00 +0200
Message-Id: <20250930-sc7280-dts-misc-v1-0-5a45923ef705@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKzh22gC/x3MOQqAQAxA0atIagNxVFyuIhaSyWgKFyYignh3B
 8tX/P+ASVQx6LMHolxqum8JRZ4BL9M2C6pPBkeupq4kNG5cS+hPw1WNkWvvqQocmoohVUeUoPd
 /HMb3/QCizpx1YQAAAA==
X-Change-ID: 20250930-sc7280-dts-misc-c5dd04fcf74c
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759240635; l=1094;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=LvoK/fU0u4wr6mRtgdT7avBiMc754iRAL/avyJ7a/+o=;
 b=H5yzZH2WkXZYR+4lSp/dVFM49LH1oXDP4ygon7l785TAFzcmY8soqxtCdDZ74m6LvtCG+dBhy
 YRiXQCs2xCwDBBfEKWtUQVlGYrtt19LUwP9/KRphLv+OUW4yWD0tlpi
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add some fixes for Fairphone 5, and use correct compatible for
lpass_audiocc for qcm6490-fairphone-fp5, qcm6490-shift-otter and
sm7325-nothing-spacewar to make sure that driver can probe.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (5):
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add supplies to simple-fb node
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add VTOF_LDO_2P8 regulator
      arm64: dts: qcom: qcm6490-fairphone-fp5: Use correct compatible for audiocc
      arm64: dts: qcom: qcm6490-shift-otter: Use correct compatible for audiocc
      arm64: dts: qcom: sm7325-nothing-spacewar: Use correct compatible for audiocc

 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts   | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts     |  5 +++++
 arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts |  5 +++++
 3 files changed, 30 insertions(+)
---
base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
change-id: 20250930-sc7280-dts-misc-c5dd04fcf74c

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


