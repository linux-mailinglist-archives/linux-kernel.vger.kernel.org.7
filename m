Return-Path: <linux-kernel+bounces-795123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0907B3ED17
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CCF117CC96
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE92732ED55;
	Mon,  1 Sep 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPAvf3Wj"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2432ED27;
	Mon,  1 Sep 2025 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746498; cv=none; b=b5bCOdqOxbsmorYCdIkT2og00oXyBorEt3ZOY/I1TkJwRzyERfLaD/GYCWw0cPhlDul8yYRkAHMMSxgZdQ1Pkv7kZK/MXyAuudolVHLS5MEAR+Jswsum4QMcJIuveJyVGt8J3UzVNQbsREA725m23g/rcOOGbDgqpk/TyOdHmdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746498; c=relaxed/simple;
	bh=JuYT5UAjk8yWbra7ZXI5AZqez5OjuKeItEclQB5Yivo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dttndUXYbtFfn+g1cb2l7SsYZBaVeorJ2/5lw+tDbkqbnQfU+Mg78YRsIwRdSA+XGTQRp97IrhABJLIS4b1DR3hSVI0SeDQEZH2ZNPemFSQTMKmOec+PK4KHvQYasrh8NobXxGPvmezL3eigRnYSeZQIcFjQeW6v4mJAhaDm+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPAvf3Wj; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f78e3cdf9so1797705e87.1;
        Mon, 01 Sep 2025 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756746493; x=1757351293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1oMGXYzMskcrO4jxEYQxuxrzZ5aMbCzOb6wvN651AtQ=;
        b=UPAvf3WjwZAm7fGOD9gnUSpkZKREnnr2ZuUC5lsUkaxSBlLJaywwW6REwW9T/F56K+
         mATLeeSyMhjgGb6ZVdSgCpgw56RKcObqkNtoeCToG7J/+VF01SrTD8rrOnkBcUXmQCum
         V5Vk0BofcQfhnvVFrlkDEIkkog5FBZe0pTQ9lyDEokIyo/wsM8RInDINfWO3pmcTk4/J
         dP/M4fjSG5Oh9ATN4mgUP6Xo6gTjN9JUG6UErJBtZsK2EuNsK9He39V3RYSAabIP57oq
         RWD+1PWx4Kk52V3cKsJcMNbi0Od124xMC674r4tEN/6TLJQioGXBfr2994+Kw8G1mkhL
         bMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756746493; x=1757351293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oMGXYzMskcrO4jxEYQxuxrzZ5aMbCzOb6wvN651AtQ=;
        b=dg/6HKEhksA92fpL6ci2EynUnUaRB+v38AYUi2wkXJgnfqbQoRJvhLpmgjfoEzcRtw
         atoa7CgzP20wQW0rf6jlShhmgUUHGKWoTy6G6I3KEdrGrIKcvmvLMkwDf4I7tSW7Je4X
         /DWa5kodgc2iaUQ7h3FKlTTJbHoa995bxUVq9HLe1WiIzqalVz2spHpmnilOHUecxtHs
         A/da6K3Mj29i7bmcKBcHYGbV94p2UUBjc9iM2tGu9hGGPPd63EAmquwER3QiZ10R8iGZ
         Nd+ZQb1tKGiGPInlofQtztx1S9VG0fhe1UU9ey6XEnSwdy4ndsJE9sleT9X83H/fxfpX
         Flfw==
X-Forwarded-Encrypted: i=1; AJvYcCVpldRNQfWbv3qmZvvWrlJZ3izQrIpNk5FF3mQqc2A4L3SZZZAgh4YDoJWwni3eEM8Jk5JeAHtIQ+7SZkiC@vger.kernel.org, AJvYcCVwB9lbAeuunykYNzS2r/9uTBcUqINK/NJOj+4bPyS16lrrSaiV5OB2ZbvhIUfjaruc3rrmtYri2tGG@vger.kernel.org, AJvYcCWwhoRqaKXBsJArXFMT2W6n5kknFVUxB7VSDT+i2b6IXuBMzkc2ivCq8TrObRmUKeiSehe5r+7coJ0y@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3dW3H77IQHZ2ODyKeVDea9FMRFBmx8YJ6zWhoa1RtqCh8tV5Y
	aQPh7H/mIPDnE32YHvz0of1ryPD2AL5WIFgy7Y8yaVpQx3e0NMytu5hf1QqYlw==
X-Gm-Gg: ASbGncsk5bdy3M2yZXUbrX7/F2MM4NI2Cp+aEXzkymgs9WUjK3cVExjXIiJCONjwgYf
	HHKgDuAD0ERjL87c6znlXJY0gGqOo/2oIGcVhrgN+IJF56MAk1I9VJ7ibt9nyiVdsoGE+ECoSEY
	GxD95ugzLKLGkSOt1MVL4Q7Wd8MJXLOACI4FUh0mKVLm2A/f9eaMP6xEnXCB2pOGqUdOBlBPX3J
	Rdju8Zbv2ElStTi09LiPDJoQKpHS53+RiqEU/R4Rgmyn5Ege7rA2FKQX91aTo9uTbDrDeKp6psq
	qoAQVvQdGoJw6YHrQjDRIzG2IFl4L1pzSiZGdla06kcp4eFEmM7nhaKKgzECKiTfaVdEO5/1eVn
	8GWYX6zjk+unO7euibyPxTlZH4YFZgOQPA/M=
X-Google-Smtp-Source: AGHT+IFmSiaj+vRwEthsD30MDf0vVWZqAe7Z2k/D/eZwbwcsNhriILyTDHy0uXVAieL74oCefyGsdg==
X-Received: by 2002:a05:6512:a90:b0:55f:3faa:7c02 with SMTP id 2adb3069b0e04-55f7093eb00mr2230716e87.40.1756746492580;
        Mon, 01 Sep 2025 10:08:12 -0700 (PDT)
Received: from tablet.my.domain ([2a00:f44:892:8a37:6b0:21e7:549b:225b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f7abf7abesm1137666e87.55.2025.09.01.10.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 10:08:12 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 01 Sep 2025 19:07:11 +0200
Subject: [PATCH RESEND v6 5/9] clk: bcm: kona: Add support for bus clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-kona-bus-clock-v6-5-c3ac8215bd4d@gmail.com>
References: <20250901-kona-bus-clock-v6-0-c3ac8215bd4d@gmail.com>
In-Reply-To: <20250901-kona-bus-clock-v6-0-c3ac8215bd4d@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, 
 Artur Weber <aweber.kernel@gmail.com>, Alex Elder <elder@riscstar.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8647;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=JuYT5UAjk8yWbra7ZXI5AZqez5OjuKeItEclQB5Yivo=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBotdLKdDLqHNQiSvycXFBx3bhT5oBFVDtOgxqx7
 pv2y8EwnjSJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaLXSygAKCRCzu/ihE6BR
 aMBUD/4jjje9188gdq6tOefi0bfAdRWNJKhHl2FU3XhZMMnzUJ+45Ws11ZaZeyl0fgzvimZFtC9
 EyY/vRPlgWmX5oB4lt7nTyRLIe72jHkLN1VncCpjmTfYi461t6GQ8TXsQ5HLlWGtpj3a2EnCX9O
 CM48drN/sqVkv95chIm8pDRlXKkQLKIPjStR50Ekthi4laUQthC4bhixd8gYWhv7KwsZr0abzR4
 TudSOUN3zBXIB7X4vRrH6T3o5Uk0MdBNSv2N8m791WSDu8QYMw9jSKfFJGGq2rXtOhQRYYOgBaX
 2DyWMsLPo9g0lN29/Jf8l8Y/3bcZrxEVH1zUWMQMZJ/2jDGfKQBa9oCQYr4eC5rhpF4vxSyqwnP
 XhOldhX28adRXC0bUbVOq8ZoKLOnZH1lh9RhL40QTWEvq7Hj4FvS8Qqdu8TdZoZiXWQLVy9Xx/M
 Pmwv1GaMrDnaX5fejEmYiX5g9shR7wyifoQYXc0QdCNKKE2oGuABAkHdKbUfMHbCShHStEmpBJW
 L3ZmCSFY+ZTIVe1PQ8vfJuUqYZ9Makl18/xD2qi3bkgAB0kjKvvRTcxQmy3lbSVR2SBEG151e1G
 aSgBsC3nl3fb8liWrrtCzHavShCv+jpgnAzU35BTFWz58DIj/DK4AiV0NBhWSlj408Jd23tg9ps
 i3KAEPvV+N21a0A==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Introduce support for bus clocks into the Broadcom Kona common clock
driver. Most of these functions have been adapted from their peripheral
clock counterparts, as they are nearly identical (bus clocks are just
much more limited in terms of allowed operations).

Reviewed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v6:
- Made kona_bus_clk_ops const
---
 drivers/clk/bcm/clk-kona-setup.c | 116 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/bcm/clk-kona.c       |  62 ++++++++++++++++++++-
 drivers/clk/bcm/clk-kona.h       |  10 ++++
 3 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-kona-setup.c b/drivers/clk/bcm/clk-kona-setup.c
index 338558f6fbaec27418497fc246de17e15236ca0d..8b6123e188fbc035cda2cf394035d35197671d06 100644
--- a/drivers/clk/bcm/clk-kona-setup.c
+++ b/drivers/clk/bcm/clk-kona-setup.c
@@ -167,6 +167,58 @@ static bool peri_clk_data_offsets_valid(struct kona_clk *bcm_clk)
 	return true;
 }
 
+static bool bus_clk_data_offsets_valid(struct kona_clk *bcm_clk)
+{
+	struct bus_clk_data *bus;
+	struct bcm_clk_policy *policy;
+	struct bcm_clk_gate *gate;
+	struct bcm_clk_hyst *hyst;
+	const char *name;
+	u32 range;
+	u32 limit;
+
+	BUG_ON(bcm_clk->type != bcm_clk_bus);
+	bus = bcm_clk->u.bus;
+	name = bcm_clk->init_data.name;
+	range = bcm_clk->ccu->range;
+
+	limit = range - sizeof(u32);
+	limit = round_down(limit, sizeof(u32));
+
+	policy = &bus->policy;
+	if (policy_exists(policy)) {
+		if (policy->offset > limit) {
+			pr_err("%s: bad policy offset for %s (%u > %u)\n",
+				__func__, name, policy->offset, limit);
+			return false;
+		}
+	}
+
+	gate = &bus->gate;
+	hyst = &bus->hyst;
+	if (gate_exists(gate)) {
+		if (gate->offset > limit) {
+			pr_err("%s: bad gate offset for %s (%u > %u)\n",
+				__func__, name, gate->offset, limit);
+			return false;
+		}
+
+		if (hyst_exists(hyst)) {
+			if (hyst->offset > limit) {
+				pr_err("%s: bad hysteresis offset for %s "
+					"(%u > %u)\n", __func__,
+					name, hyst->offset, limit);
+				return false;
+			}
+		}
+	} else if (hyst_exists(hyst)) {
+		pr_err("%s: hysteresis but no gate for %s\n", __func__, name);
+		return false;
+	}
+
+	return true;
+}
+
 /* A bit position must be less than the number of bits in a 32-bit register. */
 static bool bit_posn_valid(u32 bit_posn, const char *field_name,
 			const char *clock_name)
@@ -481,9 +533,46 @@ peri_clk_data_valid(struct kona_clk *bcm_clk)
 	return kona_dividers_valid(bcm_clk);
 }
 
+/* Determine whether the set of bus clock registers are valid. */
+static bool
+bus_clk_data_valid(struct kona_clk *bcm_clk)
+{
+	struct bus_clk_data *bus;
+	struct bcm_clk_policy *policy;
+	struct bcm_clk_gate *gate;
+	struct bcm_clk_hyst *hyst;
+	const char *name;
+
+	BUG_ON(bcm_clk->type != bcm_clk_bus);
+
+	if (!bus_clk_data_offsets_valid(bcm_clk))
+		return false;
+
+	bus = bcm_clk->u.bus;
+	name = bcm_clk->init_data.name;
+
+	policy = &bus->policy;
+	if (policy_exists(policy) && !policy_valid(policy, name))
+		return false;
+
+	gate = &bus->gate;
+	if (gate_exists(gate) && !gate_valid(gate, "gate", name))
+		return false;
+
+	hyst = &bus->hyst;
+	if (hyst_exists(hyst) && !hyst_valid(hyst, name))
+		return false;
+
+	return true;
+}
+
 static bool kona_clk_valid(struct kona_clk *bcm_clk)
 {
 	switch (bcm_clk->type) {
+	case bcm_clk_bus:
+		if (!bus_clk_data_valid(bcm_clk))
+			return false;
+		break;
 	case bcm_clk_peri:
 		if (!peri_clk_data_valid(bcm_clk))
 			return false;
@@ -656,6 +745,14 @@ static void peri_clk_teardown(struct peri_clk_data *data,
 	clk_sel_teardown(&data->sel, init_data);
 }
 
+static void bus_clk_teardown(struct bus_clk_data *data,
+				struct clk_init_data *init_data)
+{
+	init_data->num_parents = 0;
+	kfree(init_data->parent_names);
+	init_data->parent_names = NULL;
+}
+
 /*
  * Caller is responsible for freeing the parent_names[] and
  * parent_sel[] arrays in the peripheral clock's "data" structure
@@ -670,9 +767,23 @@ peri_clk_setup(struct peri_clk_data *data, struct clk_init_data *init_data)
 	return clk_sel_setup(data->clocks, &data->sel, init_data);
 }
 
+static int
+bus_clk_setup(struct bus_clk_data *data, struct clk_init_data *init_data)
+{
+	init_data->flags = CLK_IGNORE_UNUSED;
+
+	init_data->parent_names = NULL;
+	init_data->num_parents = 0;
+
+	return 0;
+}
+
 static void bcm_clk_teardown(struct kona_clk *bcm_clk)
 {
 	switch (bcm_clk->type) {
+	case bcm_clk_bus:
+		bus_clk_teardown(bcm_clk->u.data, &bcm_clk->init_data);
+		break;
 	case bcm_clk_peri:
 		peri_clk_teardown(bcm_clk->u.data, &bcm_clk->init_data);
 		break;
@@ -702,6 +813,11 @@ static int kona_clk_setup(struct kona_clk *bcm_clk)
 	struct clk_init_data *init_data = &bcm_clk->init_data;
 
 	switch (bcm_clk->type) {
+	case bcm_clk_bus:
+		ret = bus_clk_setup(bcm_clk->u.data, init_data);
+		if (ret)
+			return ret;
+		break;
 	case bcm_clk_peri:
 		ret = peri_clk_setup(bcm_clk->u.data, init_data);
 		if (ret)
diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index 2641eaa4ca52c2724aa1dc9b4bdcbee5bcac95e4..fbe0d902dc8064289fa4db346f06594b56bb7236 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -944,7 +944,7 @@ static int selector_write(struct ccu_data *ccu, struct bcm_clk_gate *gate,
 	return ret;
 }
 
-/* Clock operations */
+/* Peripheral clock operations */
 
 static int kona_peri_clk_enable(struct clk_hw *hw)
 {
@@ -1216,9 +1216,69 @@ static bool __peri_clk_init(struct kona_clk *bcm_clk)
 	return true;
 }
 
+/* Bus clock operations */
+
+static int kona_bus_clk_enable(struct clk_hw *hw)
+{
+	struct kona_clk *bcm_clk = to_kona_clk(hw);
+	struct bcm_clk_gate *gate = &bcm_clk->u.bus->gate;
+
+	return clk_gate(bcm_clk->ccu, bcm_clk->init_data.name, gate, true);
+}
+
+static void kona_bus_clk_disable(struct clk_hw *hw)
+{
+	struct kona_clk *bcm_clk = to_kona_clk(hw);
+	struct bcm_clk_gate *gate = &bcm_clk->u.bus->gate;
+
+	(void)clk_gate(bcm_clk->ccu, bcm_clk->init_data.name, gate, false);
+}
+
+static int kona_bus_clk_is_enabled(struct clk_hw *hw)
+{
+	struct kona_clk *bcm_clk = to_kona_clk(hw);
+	struct bcm_clk_gate *gate = &bcm_clk->u.bus->gate;
+
+	return is_clk_gate_enabled(bcm_clk->ccu, gate) ? 1 : 0;
+}
+
+const struct clk_ops kona_bus_clk_ops = {
+	.enable = kona_bus_clk_enable,
+	.disable = kona_bus_clk_disable,
+	.is_enabled = kona_bus_clk_is_enabled,
+};
+
+/* Put a bus clock into its initial state */
+static bool __bus_clk_init(struct kona_clk *bcm_clk)
+{
+	struct ccu_data *ccu = bcm_clk->ccu;
+	struct bus_clk_data *bus = bcm_clk->u.bus;
+	const char *name = bcm_clk->init_data.name;
+
+	BUG_ON(bcm_clk->type != bcm_clk_bus);
+
+	if (!policy_init(ccu, &bus->policy)) {
+		pr_err("%s: error initializing policy for %s\n",
+			__func__, name);
+		return false;
+	}
+	if (!gate_init(ccu, &bus->gate)) {
+		pr_err("%s: error initializing gate for %s\n", __func__, name);
+		return false;
+	}
+	if (!hyst_init(ccu, &bus->hyst)) {
+		pr_err("%s: error initializing hyst for %s\n", __func__, name);
+		return false;
+	}
+
+	return true;
+}
+
 static bool __kona_clk_init(struct kona_clk *bcm_clk)
 {
 	switch (bcm_clk->type) {
+	case bcm_clk_bus:
+		return __bus_clk_init(bcm_clk);
 	case bcm_clk_peri:
 		return __peri_clk_init(bcm_clk);
 	default:
diff --git a/drivers/clk/bcm/clk-kona.h b/drivers/clk/bcm/clk-kona.h
index 7064ce316981ef8f32cf20cd4cf674e5f0169101..a290f8870e24c286e53c0ad68c0946c8f891f9d2 100644
--- a/drivers/clk/bcm/clk-kona.h
+++ b/drivers/clk/bcm/clk-kona.h
@@ -390,6 +390,14 @@ struct peri_clk_data {
 	struct bcm_clk_sel sel;
 	const char *clocks[];	/* must be last; use CLOCKS() to declare */
 };
+
+struct bus_clk_data {
+	struct bcm_clk_policy policy;
+	struct bcm_clk_gate gate;
+	struct bcm_clk_hyst hyst;
+	const char *clocks[];	/* must be last; use CLOCKS() to declare */
+};
+
 #define CLOCKS(...)	{ __VA_ARGS__, NULL, }
 #define NO_CLOCKS	{ NULL, }	/* Must use of no parent clocks */
 
@@ -401,6 +409,7 @@ struct kona_clk {
 	union {
 		void *data;
 		struct peri_clk_data *peri;
+		struct bus_clk_data *bus;
 	} u;
 };
 #define to_kona_clk(_hw) \
@@ -488,6 +497,7 @@ struct ccu_data {
 /* Exported globals */
 
 extern const struct clk_ops kona_peri_clk_ops;
+extern const struct clk_ops kona_bus_clk_ops;
 
 /* Externally visible functions */
 

-- 
2.51.0


