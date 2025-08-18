Return-Path: <linux-kernel+bounces-773832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4BFB2AB0F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A8D6273C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853F933EAEC;
	Mon, 18 Aug 2025 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoMj9hyO"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAB235A281
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527053; cv=none; b=W62L4sl1LCyk048gakFBDYWLnI1QbBlPYhXohajWR6z/F+nKVHJAvSPjfWyP+XFpX9Rl5W1Dhg5OzBRHIee7rZDr9YI331cgLXIt1U84nLaF2IBiz19AaBBHK3BcETaLFQs919mTx8xB8QdX6U3cNeulvLK7RdwV/3NEOyXadnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527053; c=relaxed/simple;
	bh=GQ5ftdYWjc1ggmTXk0Nbj6QK5jviPLomx0fpZtjccPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5WNVKryEOM7801Fsh6Xu6umh6TSKYKW1Z1yuAhREwYj/bdgBEeLz95d0BcpGQ+DqPAeJEQQhIxSdnJFrzRzRKZiklF9FU6ZEAdlSMsH8gNSI5OIrjxQOQ8HXPnXNd9mXcVe8jWzFUluAFxtFJeUycMuc7IqI2S/hrQK2L6zrxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QoMj9hyO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb72b3a1bso76640466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755527050; x=1756131850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QamokhfM1GcyheOMdy3Zz4jkOrdWtl4wsYSaEK3Ivkw=;
        b=QoMj9hyOnlsba5x1RCnXKx7newWyshWX1ot+tb/73K9KyLlL4HdalFoO9PuiuRlmod
         LPeiT52VoRnLknov3b4xxSG+8mMZEpYeTsA1VVP+zPPVNLfMi65+nJB7uocPk8t5gbvd
         0oWPBH6CRIfbIGHlYpC4wnP4yVFZCU8ftgPXY9dthYoq2wXCmFvkhB6l3ODsfdPynaIK
         +Tyk+TY3X8I0gOKvoSjDNUnX+rO3nYP7AF/BxEcCmowLRm1gEl2q0ijlu6gACXjVxvCN
         3sXr0E7KOTXM8yV2hICwVXWkxaPmEkMGYRkyBIVvyGMgXkWivwQsflJj7njwful35Su+
         4bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527050; x=1756131850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QamokhfM1GcyheOMdy3Zz4jkOrdWtl4wsYSaEK3Ivkw=;
        b=ggxUxHj07Zajr63ZkqubBn/fbX3D9rE8yC8BT2k/yVs7zZ048zEmB/V+AP4jMIE9ch
         wzh8tN5iUYC7PxpX5Ts/ASFB9Cpd4GAZNfmroCfVUrQAzfiSn69w1ZnrSVQ3i71sZ+z8
         UvzS92RmxAJrqbxqDbnDp8R9Icw7k+pSCw8KPmmPZAjYgAt/pC/qABRVrIUDvJOSsbB4
         66W7LJ9a8SA6J+oU5iWLYGgJ4H1hOAwsiqoy9lPUfgF9PtrYc3mkxyW/y7HvhDsE7h8j
         OQ4m7mVFMORmY6lB2PFXjKtt/XijgyElY9ZbdLbbYeQ5QAa27JFeacfST7/mSe4abXUk
         StGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVthw030lxXG+64ceXEIixVes4oq/Rg98OfMoBJG0iuxM55DXg5Lz0fzvqU/KJMIAtJH+kEdXw8okKWAtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWPfDQAL8YpUh1BTzFJ23NKRupZhL0P8erXCdTfKcY3/owaEJM
	a974Hknq0p3cxadIBqtQp2zs4EYbry2+nDmd0r63lVOiPsW/uVv4O94xmTDvzwfpfVU=
X-Gm-Gg: ASbGncvAYjB66/GIFlWng7FXuCeAQr0Tr1DyJl06dCxc7VLcfnsQM01L5ax5aGlG0i1
	AmXq8pzH8PrF4QIhXOJmHbdMc7esjfTFoIifP0iVd8Ruh1eFwJ7OJdI6LMoISULCdp+rb4le6/1
	67x3oh5sLRu/Y9hWH+bs3M+qN35ybZ+xY65sXtAHrC7V0IWE133MR7YMPuT0x7T7KaDbAogltJq
	8Flcsn5HxL97keyynhX73rbhQjLgQbyprsQ91hMo8zO0ysEkj4nI88p9FOgdTBCFxGMoQgyZAYy
	WbIRqPp1MqqH2XeM8WUXZlK6+EhDIqibMbGThNkFJWokobq9okFUxS6J5/iypXMUHwlApy5owGc
	qXBeNhlmQJ1k3WviGthPModKGxMoGHZKSSg==
X-Google-Smtp-Source: AGHT+IF0eQL4ER7n043LGZ/uWkPZXG/pygEg35URndrpoalaoUz4uPyviRVbuOk3OWfAjWq8XjlDiA==
X-Received: by 2002:a17:907:7fa7:b0:af9:566c:4cd2 with SMTP id a640c23a62f3a-afcdc2367a4mr462998666b.10.1755527049798;
        Mon, 18 Aug 2025 07:24:09 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53dd5sm803192366b.5.2025.08.18.07.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:24:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <legoffic.clement@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] pinctrl: stm32: Constify static 'pinctrl_desc'
Date: Mon, 18 Aug 2025 16:24:03 +0200
Message-ID: <20250818142402.132008-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=840; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=GQ5ftdYWjc1ggmTXk0Nbj6QK5jviPLomx0fpZtjccPw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoozeCHbXUKSjJp2DSxgX9G/1zAJfSI1ztiFFmO
 GadvdBbwOOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKM3ggAKCRDBN2bmhouD
 1yoED/4kiZrB9q1OBGXP/IDolXlLyozFqO4AV9Emhx7w6pECE6srTXNW0Io7CnrMi0NzZMG58Ok
 fm+15O1C8b/juIQEqd21izzXzrGo27C3MZyD0BRrXqiwig7D2md0Om36cPq5qhacQ/zDmTpqwre
 RB3kZssnYEetCx0yNNlo+4FilIdI73HUOLBe7NjhjdgYyinQ1CUFjyQBrIkfunSZqcBZezmsQ++
 D0K40lIyY0h5nBjRIKpz+x6o7wDitTdHR41tBju6dC/iGlvLJy+EEOpTTi8OuybUdMZTjyXH+AW
 v3l7+uSupThYNKmIPHmI+dgJTg6wYmF+RRwgTwlKOIVSkrjSK0qlmYJxDubNzMVhPGQtLju+zZf
 yrapLhuKFH6b2QE3QQigfWAWcilF9rdt7gD/mr8FljvXYBKtQVazVxlky4pZWXtJnk0acqX4+bu
 JRmGZ08gufYi08WEAQ4Fbq4ef0x1HR4/6epHh6Kyf033ep138BhgWHGz5jinmmwQmCTJPowT+Iu
 ZRAS5U1JPvwEAQHEQsFTMttnyATQyBPYpJ7NZiTc+QJMTnYhxHhQBnpIrcUZuQ8gjf9Aw+NoO5s
 cCDK8474FZvZaoSSTtwZPWx9SuZLQQmpjUT5Yjad3ZHNO4LYiv5uT/wfKA8WZczUAJ1ziod5OIU fbYKk48w9jEUxLw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The local static 'struct pinctrl_desc' is not modified, so can be made
const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/stm32/pinctrl-stm32-hdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32-hdp.c b/drivers/pinctrl/stm32/pinctrl-stm32-hdp.c
index e91442eb566b..0cd41f3f7a52 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32-hdp.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32-hdp.c
@@ -575,7 +575,7 @@ static const struct pinmux_ops stm32_hdp_pinmux_ops = {
 	.gpio_set_direction  = NULL,
 };
 
-static struct pinctrl_desc stm32_hdp_pdesc = {
+static const struct pinctrl_desc stm32_hdp_pdesc = {
 	.name	 = DRIVER_NAME,
 	.pins	 = stm32_hdp_pins,
 	.npins	 = ARRAY_SIZE(stm32_hdp_pins),
-- 
2.48.1


