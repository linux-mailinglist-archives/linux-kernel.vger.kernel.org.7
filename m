Return-Path: <linux-kernel+bounces-609313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EA6A920B5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 17:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2815461361
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8595254848;
	Thu, 17 Apr 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZPi5avY"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF3A253334
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901952; cv=none; b=kxlBfeo7sDJLT89xCpYXcFHuE0e/w6x+K1W9goxM2sqhgCcQecklG5gpDKP3EHHbJK256rQ6n0kthHiTcDtLgnBLJmxt0j/th26Z6cS5DD/Z0uSOQFRur4hf1tEtWeUQqx9sRSaR+admq6mvmCQVrLl2AnRrL+zN1Jf8b6gFfII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901952; c=relaxed/simple;
	bh=D3BGxGQzPMZ7cSKp1beIeyQrn/S7GYrjg1KVHthBNgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gOt5RtpvWyu2YGuGQ7+N+I2rAJvk47dhplk/C2QQ1m94ByBItwbCLL9vhzibqkgF9lx8fAoVjK/wML66xtpYhtMBKiYnFBbwS+ftslhJOV4ZmQ3G7A1F5aCgWItCp5YwxTjnTUG4f6P+8HhuiYsy6GmfvFrVyZZq3zZCOMpgEBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KZPi5avY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso8147475e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744901948; x=1745506748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4YPf8o4iBnEJjpRRhFuM68VRpNpwn31LXM+pz342zs=;
        b=KZPi5avYmM1XG/NQ9E4RPxYIunZCJngLf8mRex68Z3KJ50EfmFmp8R8og7CFa05J26
         M6Oe2fIOz7ovWiymEinX56IkgIIjliOPhSxtSl9WjjTBJNiV3MFxz7eo80o/h+dEVNQ/
         Pb/mvEfLd462cHP9UDlMBj4vxnMnG4fbPCxywBthB70yuLhZ7jIRkL0DB3yLRv+d0TJs
         BwF9G6HONsYIqPhdt1DltkG0g2CokvN8lArQZPBx+OSSbRzrSl5Secx6RXb1MBZQtWVb
         XCrJNezQcVbPh9dEuFpn7hsGStkGs7qTHHTcEDHJXo8KBa5UFrvq0JlhEuPFDEuTAqxR
         dKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744901948; x=1745506748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4YPf8o4iBnEJjpRRhFuM68VRpNpwn31LXM+pz342zs=;
        b=V2g5dqDq1hzpwTPA5q5ffIrBZyuh0eO98RqaJLT7zXf+ukYGQnHVUr7XwDbA7aP52c
         RuE7xrn6yIwMkr2W7c3gdEYBt3lv/zXj6UOjAA3T0O4TkpK8TwZ2B4WUyIzE57FiNxhB
         1FUnXmj1l7jeJqaPwvjFd8tLAt2av6JQCgpOYcEQHnpZnfD+oiqksNF1Qxih1H3zgyXW
         VaU5RSj7y6m+fbMv3NmusaLEzSbWBXtBoMv/siC35SkG7yiNzle5TH8U6RtzC4RUkIRt
         50B1vcUDdsFGNU4gSrHrQOnAGiBagCNZHDCrDU0r/MW90b67TPWAZ7JrEDy3lfxKflAq
         6eTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4OQ8reG1g/wP9QpFslR03VnW22Ya/37/X6RuT81mXCef2MDrI4FkFFbE/9+AbuW0aG6RaQzmW1BCUyPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9zirWTKKgXHDTiM8TBigyqhX0Un0nvI9TDozPbU27tgYj6hlX
	enUnU0KPZ5iRFBuAmEftt94ZMiw5r52zhS6GYAQLVZjI7KX0FvgkhZ9n5Ld/gl8=
X-Gm-Gg: ASbGncu1X/BiNjRmUXAmJT1d0bPN2FonFOH+iggXcB8R7bFI8JIuWxC5kkuuxmQ/0ZH
	EczTCpY7Z10H8BtPe+oiDSuv6Xum6xFQtRZ8obk6PnQoJgBKaS9YWIBwxRSMlxzywS7l8XgJ4gk
	psetETg9Eg0loWzkdljDyVVmMH4BHDgCrlTTVee60dSGXK1AlIFJtN8XiUnQR1ngCZAdN1M9xAC
	kJYAEwbQjHz35bDk493oizpo5DBsgz2jZ514OkHgzIQFVmepRKsP9zIehKwnSyDporENNgOzp6z
	4M7kXqCxJBKexH7nMNG8gcoBThqWXauKbw5Xkr1r4Ja+hzXTG+7OYq6/TE28mQ==
X-Google-Smtp-Source: AGHT+IE6fiQPa3/Mo9PzYjfWbQ22AgX+a1kcDziqxoJGmOSEQPbW+FbzkeMnVkqbW7tD2LK/VkAISQ==
X-Received: by 2002:a5d:47a9:0:b0:39c:1257:c96c with SMTP id ffacd0b85a97d-39ee5bb1b28mr5735822f8f.56.1744901948078;
        Thu, 17 Apr 2025 07:59:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf447914sm20497743f8f.97.2025.04.17.07.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:59:07 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 17 Apr 2025 16:59:03 +0200
Subject: [PATCH v7 3/7] media: platform: qcom/iris: introduce optional
 controller_rst_tbl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-topic-sm8x50-iris-v10-v7-3-f020cb1d0e98@linaro.org>
References: <20250417-topic-sm8x50-iris-v10-v7-0-f020cb1d0e98@linaro.org>
In-Reply-To: <20250417-topic-sm8x50-iris-v10-v7-0-f020cb1d0e98@linaro.org>
To: Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4499;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=D3BGxGQzPMZ7cSKp1beIeyQrn/S7GYrjg1KVHthBNgU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoARc2YLaxQ4Rtx2sAilESosMjwHBtg9mf1M3oeWJS
 ow7tmAOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaAEXNgAKCRB33NvayMhJ0YvQD/
 9/KtKYAEGEUUVE8F1hIq5QJyfdL+JwjntGK5ng7i1/k+bUU1WyzC9KS2gjDR2cOvxb81WhbcgTEOmr
 eVfLf7gqYNXDUxnNqZWxuzXvES17Yu362gPlIppNrjz68r6cTFqZm52mNwaekAVNylTysM5GhdnGAu
 rO/jTqElAOL0kgl975SaHflI7uw8MAtVxM4+A9sn4WxwrgSw2b9d9mQ9EoQA8z4ngS65M2MYuQ4k8R
 NYhPR+0Hr2VJmkm4fm3VQt06OWVhO9CbVwL2PHdCcnE1HM+fH2grq1c6S644XVQ45laONRbP0BDJM2
 lE2n6HXB//KcEB75KJBr6xssz6ZWar2gPCH1eZCKTlWeaT4r64zXTLfvYVDwibd6orjbyGK836b27/
 G+PLovrd66sB+pq9LEHQwhpzsFD4aDkXX1Eou9hifEP9WlHZm78GygHJBAzBmFawnLEIo2R/Rghqmo
 ChfUbNRw3oobM2LAVmnzir4F7f1EHwiJ/0CG4r8GXySTDGXKp5hRZw11m+il3tfpt704EjrugZ/+3H
 KKJEzdcG//ljGJWuy5bxiOj+stF5DKzNHnm/mbt3MARclU5uq6cM3YI1pvbdcw5MPIAWBBgnJ13GGz
 yllQl2+jkjsmpL7dHzKcWEMBh9XM8B9VZLWt17zrDz5IZhV/cwW39EvscBEg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Introduce an optional controller_rst_tbl use to store reset lines
used to reset part of the controller.

This is necessary for the vpu3 support, when the xo reset line
must be asserted separately from the other reset line
on power off operation.

Factor the iris_init_resets() logic to allow requesting
multiple reset tables.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # x1e Dell
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/media/platform/qcom/iris/iris_core.h       |  2 ++
 .../platform/qcom/iris/iris_platform_common.h      |  2 ++
 drivers/media/platform/qcom/iris/iris_probe.c      | 39 +++++++++++++++-------
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index 37fb4919fecc62182784b4dca90fcab47dd38a80..aeeac32a1f6d9a9fa7027e8e3db4d95f021c552e 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -43,6 +43,7 @@ struct icc_info {
  * @clock_tbl: table of iris clocks
  * @clk_count: count of iris clocks
  * @resets: table of iris reset clocks
+ * @controller_resets: table of controller reset clocks
  * @iris_platform_data: a structure for platform data
  * @state: current state of core
  * @iface_q_table_daddr: device address for interface queue table memory
@@ -82,6 +83,7 @@ struct iris_core {
 	struct clk_bulk_data			*clock_tbl;
 	u32					clk_count;
 	struct reset_control_bulk_data		*resets;
+	struct reset_control_bulk_data		*controller_resets;
 	const struct iris_platform_data		*iris_platform_data;
 	enum iris_core_state			state;
 	dma_addr_t				iface_q_table_daddr;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index f6b15d2805fb2004699709bb12cd7ce9b052180c..fdd40fd80178c4c66b37e392d07a0a62f492f108 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -156,6 +156,8 @@ struct iris_platform_data {
 	unsigned int clk_tbl_size;
 	const char * const *clk_rst_tbl;
 	unsigned int clk_rst_tbl_size;
+	const char * const *controller_rst_tbl;
+	unsigned int controller_rst_tbl_size;
 	u64 dma_mask;
 	const char *fwname;
 	u32 pas_id;
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index aca442dcc153830e6252d1dca87afb38c0b9eb8f..4f8bce6e2002bffee4c93dcaaf6e52bf4e40992e 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -91,25 +91,40 @@ static int iris_init_clocks(struct iris_core *core)
 	return 0;
 }
 
-static int iris_init_resets(struct iris_core *core)
+static int iris_init_reset_table(struct iris_core *core,
+				 struct reset_control_bulk_data **resets,
+				 const char * const *rst_tbl, u32 rst_tbl_size)
 {
-	const char * const *rst_tbl;
-	u32 rst_tbl_size;
 	u32 i = 0;
 
-	rst_tbl = core->iris_platform_data->clk_rst_tbl;
-	rst_tbl_size = core->iris_platform_data->clk_rst_tbl_size;
-
-	core->resets = devm_kzalloc(core->dev,
-				    sizeof(*core->resets) * rst_tbl_size,
-				    GFP_KERNEL);
-	if (!core->resets)
+	*resets = devm_kzalloc(core->dev,
+			       sizeof(struct reset_control_bulk_data) * rst_tbl_size,
+			       GFP_KERNEL);
+	if (!*resets)
 		return -ENOMEM;
 
 	for (i = 0; i < rst_tbl_size; i++)
-		core->resets[i].id = rst_tbl[i];
+		(*resets)[i].id = rst_tbl[i];
+
+	return devm_reset_control_bulk_get_exclusive(core->dev, rst_tbl_size, *resets);
+}
+
+static int iris_init_resets(struct iris_core *core)
+{
+	int ret;
+
+	ret = iris_init_reset_table(core, &core->resets,
+				    core->iris_platform_data->clk_rst_tbl,
+				    core->iris_platform_data->clk_rst_tbl_size);
+	if (ret)
+		return ret;
+
+	if (!core->iris_platform_data->controller_rst_tbl_size)
+		return 0;
 
-	return devm_reset_control_bulk_get_exclusive(core->dev, rst_tbl_size, core->resets);
+	return iris_init_reset_table(core, &core->controller_resets,
+				     core->iris_platform_data->controller_rst_tbl,
+				     core->iris_platform_data->controller_rst_tbl_size);
 }
 
 static int iris_init_resources(struct iris_core *core)

-- 
2.34.1


