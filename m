Return-Path: <linux-kernel+bounces-809987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE59B51446
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0765A16AB42
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BD0311950;
	Wed, 10 Sep 2025 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qiiutLdN"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A82131A065
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501070; cv=none; b=MY7Ckz9sh/2Hf78nOjVS5uX0NizHy5t6Jnx4JphZBQ4A3dOZw7YDm2qnp4YPqb8E+n8nk5MJO9/nuWf2ruBKVY1EEIWN5SJ59rhrIrANBGsW0RXvlnT1Pbar3gj8GNhSTTXjC0erfvTyT1AVOLF+gYHwuYg4wE6XYrDCleEkPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501070; c=relaxed/simple;
	bh=Wq0vuHhTAJlaPz6HkeacWOsQOmTgXgsMsPqpxkUBtX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRToIjAJt72nZWQcmhwBBjS1bH8filHWvHL9OH9GhW+ihRe2Qxgk06Ckw1eJiv+j8M+hhHUq6oiCGfHXC+mQJ2lJgYPCddekU8e/0icD0utUtBDz5O/ZLLk8Oko3ffC17cxh8q16L73xBrFXcH0DqVYcwLAgqIGpn0+VrfW4nTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qiiutLdN; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61ebed1e37fso909409a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757501066; x=1758105866; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sk0N8hWIhOaA0zE24bk/claWEtHXKITnd4Xgk+Np0Gg=;
        b=qiiutLdNnJwSYh+F4T+QmXsA08RwrsqfxgcPtgUQ0YI8FdL7ePMImnUJ2ai+UNwxgi
         C9q+GkgRFNO+ySBglfADK4jauuvEgv7ZpUlXPlqQhEcDHwmuxeK0DkVCy8vRsNR+f4HY
         ++zEHDuPHE7r+Fzg4wxyZLZplNU6eMed1j7EclY8l+539BIHIko7Zvpa0wsQ+V5DFYIy
         m4FzUTqlDONXJoFeJWPXSMWdPwdYKGlG/1B2h8g+1eBB5bO91PTbNImKjDRJuSF4FR8K
         tqahKdWkufMhWWwaEvKViaJsKhHSpaLa38PYBB7GGJp5bnyuyWXaMYswqppqcFh6Heif
         H5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501066; x=1758105866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sk0N8hWIhOaA0zE24bk/claWEtHXKITnd4Xgk+Np0Gg=;
        b=KfIaxsvjcuqW5PPaXjMPzDFJ8hQNFqJxZA2JEjV6YNqN8EDBLobPX+AdOvYNjZ1lw/
         dR2QjsfhvFtWdh4CwyIJzVmU6HzB/g1bFK5By9WGX/LylmQNb1S4uDIa5gn5H2Sb/srm
         +1KCv76rDc/8xozb7XpZ0/6k8NC9OjCwTaE3TvuuFbcljyDXK6AMewQRkL1K2Zdgoj/F
         xnnSXnFKOM6FNR+Rq8VlnaAlZ10wZqjG0N9pfe/hpwXZsM+GxJUTnAZTZkdhbURAsoEs
         Zqmpj7uL0JRBcBALbRoJzQz2zOdIwGKnUSTBVP0gwQpOMU216pHLHmF0M5593Rpx+2Rq
         ooUQ==
X-Gm-Message-State: AOJu0Yxq6KGVdt5F+65yjSR/9stG0tMRyni+c+AceWiw/QG5fvGXS/I/
	9GGw1KxhoKWtQjdUL5g63uow+Mcg1m43n61bAq3GD5YpvgSGbT6Unlcsnw2c4Ni4O6I=
X-Gm-Gg: ASbGnct5IbW3ZyJdKKFY9AeDbJRyhtfCmmff7vBjimkpbh8W8HzZWkqM9n4P1lgIFkm
	mArIKnkTedsJxvZwBW7lneJnnlNej0FL9wUfQUB561Dhw0fhO/JJ+2/em+td5/SdpAdmNCeJTSJ
	Ot070KCpvBd963lL5hQvukkisUJfCcVhL03hvJWOJPoc9PVvm+QjpiM2Cbt8bSApxpJeM1tQIOI
	uqDYAgCU+zjMiRQaOAzw6/wb13bTebMrkKfAEW319PS5Dqw7PWbWEMgN2KPCHvyZJ2d2b1zGE4z
	DtdZnEmg53ztG2kPRrwiIGleH49j/Wu0uf2SMMY5kOIIuN3Yt4lEpvTzPaqVBqlCCZuJ21s4idi
	Ayg+sfCsbJ9n6yzkDX++1a4UN2+zh+sAM0EyGyp6X9mAcoYq1qQ==
X-Google-Smtp-Source: AGHT+IFcwfWKWYZW56frObvDREjVKz5uTu21j6RaZXvJLRMYEJI2JkqVO8Se3R+b4vV35iyYOlqO4Q==
X-Received: by 2002:a05:6402:520e:b0:61e:a890:aee6 with SMTP id 4fb4d7f45d1cf-6237a42fb5emr7068174a12.7.1757501066334;
        Wed, 10 Sep 2025 03:44:26 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01ae5f75sm3144890a12.46.2025.09.10.03.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 03:44:25 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 10 Sep 2025 12:44:07 +0200
Subject: [PATCH 11/13] memory: tegra186-emc: Add the SoC model prefix to
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-memory-tegra-cleanup-v1-11-023c33a2d997@linaro.org>
References: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
In-Reply-To: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3374;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Wq0vuHhTAJlaPz6HkeacWOsQOmTgXgsMsPqpxkUBtX0=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGjBVnjI2IvsYqiYyv0pRCbNw1ssBZQM2iUs4590HSHcaqjXi
 okCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJowVZ4AAoJEME3ZuaGi4PXIogP/jri
 eTvg8lNymEqXda0LSA2MJ/fWzDkAgvrpc3hUt1Dp4ziZ2CtujieSyZBnriJFHI6BBgtG8dQ/vV5
 P/XOybdwQu1XQxT/6aE9IFmQadK4QJRpi++DeB+OQvGLDrKtcDZVCzrVhzqTcfCA+vjEFbmK+Vu
 q8QxvCoez9BQF2XgASjdDD9B4WfQCAmZtKKp/8em+mI5RZG/DQPHsEDbeu3SmLWQO4e7GsORYPt
 K+JAGVRto+BsoT7TlwBEYPk4OCmQj5pW/V9hcpu2mnR9pX23JMU2w4hnEOhWZwGh/Xktzm/jn3M
 FHeogvttFWb86SOf+yRGztM8KSvSa4vy3NnZvF/pzA0d4giLAmyb+wN63dlkngQObm8X8xfpJDq
 KWXpnb1uNy/LKsrmtcNPiMoKEzI+Ttomy/Mxlt+runpVeqkDhLRMMt4y+qKu6mJwUN3KzliYyXy
 dBVyLtKzF8CGczDljsn1iazYmDvwUBH2GbyJX8q9dUZH9t4Dadh3GsN54f+aiJlxroxchHKqlmG
 MHGCIGHuKeUsJwO5v3E8Ps/g70YE1/+K8CmYTLK83Ivo2qnF0dgXSqdta0w3Qz3mwDK12qF/zN+
 YTCMwo3ct10GmjTeJhDktW249YCgFk9NWnX5VHzzXE/Ci0AA2v3MfC8OfzQX09LHwUyS/IVKbS8
 WhJxX
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Replace "tegra_emc" with "tegra124_emc" in all functions to:
1. Avoid name clashing with other Tegra EMC drivers which makes it
   easier to jump to function definitions,
2. Decode the calltraces a bit easier,
3. Unify with other Tegra MC and EMC drivers, which use the SoC model
   prefixes.

No functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra186-emc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index a0de80afe3e90531fcfb29d20773aed0d04478c5..9959ad5804b444b269456d1fbae87b4bc111661b 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -218,20 +218,20 @@ static int tegra186_emc_get_emc_dvfs_latency(struct tegra186_emc *emc)
 }
 
 /*
- * tegra_emc_icc_set_bw() - Set BW api for EMC provider
+ * tegra186_emc_icc_set_bw() - Set BW api for EMC provider
  * @src: ICC node for External Memory Controller (EMC)
  * @dst: ICC node for External Memory (DRAM)
  *
  * Do nothing here as info to BPMP-FW is now passed in the BW set function
  * of the MC driver. BPMP-FW sets the final Freq based on the passed values.
  */
-static int tegra_emc_icc_set_bw(struct icc_node *src, struct icc_node *dst)
+static int tegra186_emc_icc_set_bw(struct icc_node *src, struct icc_node *dst)
 {
 	return 0;
 }
 
 static struct icc_node *
-tegra_emc_of_icc_xlate(const struct of_phandle_args *spec, void *data)
+tegra186_emc_of_icc_xlate(const struct of_phandle_args *spec, void *data)
 {
 	struct icc_provider *provider = data;
 	struct icc_node *node;
@@ -247,7 +247,7 @@ tegra_emc_of_icc_xlate(const struct of_phandle_args *spec, void *data)
 	return ERR_PTR(-EPROBE_DEFER);
 }
 
-static int tegra_emc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *peak)
+static int tegra186_emc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *peak)
 {
 	*avg = 0;
 	*peak = 0;
@@ -255,7 +255,7 @@ static int tegra_emc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *peak)
 	return 0;
 }
 
-static int tegra_emc_interconnect_init(struct tegra186_emc *emc)
+static int tegra186_emc_interconnect_init(struct tegra186_emc *emc)
 {
 	struct tegra_mc *mc = dev_get_drvdata(emc->dev->parent);
 	const struct tegra_mc_soc *soc = mc->soc;
@@ -263,11 +263,11 @@ static int tegra_emc_interconnect_init(struct tegra186_emc *emc)
 	int err;
 
 	emc->provider.dev = emc->dev;
-	emc->provider.set = tegra_emc_icc_set_bw;
+	emc->provider.set = tegra186_emc_icc_set_bw;
 	emc->provider.data = &emc->provider;
 	emc->provider.aggregate = soc->icc_ops->aggregate;
-	emc->provider.xlate = tegra_emc_of_icc_xlate;
-	emc->provider.get_bw = tegra_emc_icc_get_init_bw;
+	emc->provider.xlate = tegra186_emc_of_icc_xlate;
+	emc->provider.get_bw = tegra186_emc_icc_get_init_bw;
 
 	icc_provider_init(&emc->provider);
 
@@ -354,7 +354,7 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 		 * EINVAL instead of passing the request to BPMP-FW later when the BW
 		 * request is made by client with 'icc_set_bw()' call.
 		 */
-		err = tegra_emc_interconnect_init(emc);
+		err = tegra186_emc_interconnect_init(emc);
 		if (err) {
 			mc->bpmp = NULL;
 			goto put_bpmp;

-- 
2.48.1


