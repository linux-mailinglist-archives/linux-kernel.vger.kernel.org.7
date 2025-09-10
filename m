Return-Path: <linux-kernel+bounces-809981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 786B5B5143B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577A93B3A74
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C5531770D;
	Wed, 10 Sep 2025 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v8Xyx6Oh"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D083164AB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501062; cv=none; b=tpOU2KyfTnZUYRwZ71myotRR5VjS/fTx/hyfcQWcSWNZH/h01P0IN56tOtkmeC5yb4BXQ3aeEzskSOOhB17EqZSbykUX8/MDYE2aceF/tTy88CFVxg+6dnFcDuxmDcy4g0FqNInDaLk23nb5HAzYTGC9sxGdS4o5hYx7QX4gE2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501062; c=relaxed/simple;
	bh=56WhvEjp/PteZn0tyO9c/SCroF1xJwxk2BOxQgVeGvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXxWwXZUBqElcLin/PDuoUKc6PK1piu8ROv+mGkZUsqIKifNoUG+mFiFzXuRki4e2u1fCFj1ZpSOYDDf0yAdJGx1vBjNMiykwSzZTHGr5srO8c3AAtbbvhTzS+oEfItajyHO597Z3LggY3ZMYYRWgDhcf+QR1AEdwEucLLrf1xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v8Xyx6Oh; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61eaa4f6784so1142215a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757501059; x=1758105859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WpkGEUpfxQBkF0AFg2VeVRpKBfctEX+Z1irkwx05L8=;
        b=v8Xyx6OhWZfUI16FjuVlsNQQP0+fcoTorSx6YqPQTj9ZT32BQjn4E1hB6G3k+FRXiM
         mOz622H5FWzkCHQF+2cQoXTp7BEaXTpiMCI7ey9CRC7zUIWK+hrIyXwaffojRTOgP2dD
         QswEIshQu1z8DUqDfFvj4zEKKMh3z3+OQ+aRHi/f6rxZledk8wHJOKjaUOUI+b9ph5Yx
         JxTFneM+0RbMdq3pcKSKHuxEbsJmkY6ZKggAx9A7+RLkPBpVGjHRmbP3pJQB7X/Vjp8c
         ZmuVZ7Z6ynN/EyGbko2xq8RH3mfm69rgnoSl782AE1WWW3Kn2SxIUtDp3fdwqYJFl8+f
         INtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501059; x=1758105859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WpkGEUpfxQBkF0AFg2VeVRpKBfctEX+Z1irkwx05L8=;
        b=tBZuDXpz0W5jYiK+BoVbbSW2rn5Gnyx4k3LX4Isvt5BMi9j63xLR/D6avjed0sfJM2
         UjUHpTukV4VBfvt2Eawr01zWPw1E3l/xlW6Nf312AOUbDmud80sqndwtjqfOiGSRLfVn
         EwfYX5iDjpDHJm/GG0NVv3dDOJN0tj2AxG1LboVxYWtEMeWKz4BUCPraaAag8yROEv+h
         09lJn3t0DLVLqQiee+1Et5wAJPAKxoxeaKpCew7VqxMZ/0XxN4pkZ856BsBWtmyxd7P4
         KSLC7DpAy5IWC+1WNPwg4En5ighhD4mCjiXaevP+au4B8CiLAuPm+aBf5Rr5QWVSF8WR
         h7Fw==
X-Gm-Message-State: AOJu0Yz2FROtXzIGZBIiGn4ZYiTJt3Ame+uVt0n3U9FmTWhL3DH1mvPB
	JBSeTIvbUZLsJxEr3iOF1qagbBacOeiivNaCeyVVs3PWEd0PJkeQmWLogIdeeC2hdPY=
X-Gm-Gg: ASbGncvVD/g3spK3EPUbULrrUBUXOmLwcid1IRAsfQt5dO55+01ph+JDZraU5D9jfVB
	1WVC2B3AJb0gT3iq/w657Zq7/qy7HNXl6rG5gBuNIBU043+zF8CwQhSxcKV4bI2Db44NCL1WmE3
	0rAz18PTCEd8RpJObIAY2t9NsopArtuQB4eFfNFAdnrrfSfgP/epf+jiLQ8TPPzXsAAJ0M4sW7K
	Zkxc9glRHe75FXLacshvhoXmrywqqR3nsfxT1RZZ98JOythzGjMWBX+BFmaMh8euwpaq/A/I8E0
	qi+i1KkpzwvIy1SL4zqaa+sRRQDWC2b/0fqSeSfAlROF0A8EGCyVlHV5Ecn0Ev66qhTBu5ntlCP
	f2qd14jVPrdZEbvb8DKR8Q31MoV/3eLZqkyOlBzk=
X-Google-Smtp-Source: AGHT+IGmbydVAXx0O1nO/LcVNbJRNPbs1dnLdhKWCpImMs9fWBcF+2UQFXqS28+DcfFfA7bKKjPXVQ==
X-Received: by 2002:a05:6402:26cf:b0:62c:af05:580d with SMTP id 4fb4d7f45d1cf-62caf055e13mr1859074a12.0.1757501058894;
        Wed, 10 Sep 2025 03:44:18 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01ae5f75sm3144890a12.46.2025.09.10.03.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 03:44:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 10 Sep 2025 12:44:01 +0200
Subject: [PATCH 05/13] memory: tegra30-emc: Do not print error on
 icc_node_create() failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250910-memory-tegra-cleanup-v1-5-023c33a2d997@linaro.org>
References: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
In-Reply-To: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=56WhvEjp/PteZn0tyO9c/SCroF1xJwxk2BOxQgVeGvo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowVZyO+TuUxzmlqng1BKznkSRk7w9OsWLK/p8K
 zUsczbtGrKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMFWcgAKCRDBN2bmhouD
 1+FBD/oCk0CGj9IKqnKbHQqr23NwdJ0d7KodNCecjJFeUmLJb+KSe/+DY0vl79lZ1xVRYpLE+LA
 EsSRrMBrUpL0TdA8CoKV+BEPoOvAU6tH+0aBo4a5QtxaLGUrAPknhVzCdrRkFprTCDn0AiEAWpp
 3Cp9KgMoBP8jNpDCBIzAeegCdvIefuirTdCCtcVtsgJRYMAj8wULIqBmzSn1SIDedUEWwDNdobh
 URLbwWh329ak05l/ER3pqFTic+uKRsbroNi9HtqwWhzvAMB51w+xjywlPAn1k9izh3CH5Sk2B2F
 A/VY9ZBmMueD08O+T6I1OkvZHN+GfNMs2I+3mUkqHw8BCGzlaID+zhxrYORpStIofMbcd+iwsa2
 yhX2/3NdJTmLjcg9JaH31PK9uPD+jyFYbxHmYjvkxocH5thY5Hs75Z/tTZ1LYf2DnUdX88cUrB8
 dXZSSFw2/rN96VIzEk0mfHIISQk/g9kh8cyasxiL1+pPZQxnPilATe2o+/m/ilEuIq9OWbRF9ib
 pNZdHZnOhCm0Eh3tEWHMh1yCZ9QBW7gqrR2LaUM9bcNlah9m9gwSQAsR8MTxJsJEEVqYc3gt/wt
 jzbzczwZFx06Ux6ZDhe+9JAUwd0zC7LunbOvzACuQFEhWSuPtQINQFmFu+mo4ycUqIq0Kv2nYMZ
 Tn/jEx7SFZo8p+w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

icc_node_create() is alloc-like function, so no need to print error
messages on its failure.  Dropping one label makes the code a bit
simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra30-emc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 921dce1b8bc6382ea66d70ad0f2a12283316ad90..c96aa63a5aa085a409ae7ec901d2a210748f5bcb 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -1534,10 +1534,8 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 
 	/* create External Memory Controller node */
 	node = icc_node_create(TEGRA_ICC_EMC);
-	if (IS_ERR(node)) {
-		err = PTR_ERR(node);
-		goto err_msg;
-	}
+	if (IS_ERR(node))
+		return PTR_ERR(node);
 
 	node->name = "External Memory Controller";
 	icc_node_add(node, &emc->provider);
@@ -1565,7 +1563,6 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 
 remove_nodes:
 	icc_nodes_remove(&emc->provider);
-err_msg:
 	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
 
 	return err;

-- 
2.48.1


