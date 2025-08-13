Return-Path: <linux-kernel+bounces-766538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E2CB247D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE10C688E08
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DDE2F658A;
	Wed, 13 Aug 2025 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm2KiRXI"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DFE2F90DF;
	Wed, 13 Aug 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082833; cv=none; b=kJe14FBjZEvGhy0nKo9C+73NEmSEXUxUnnw9idStxSUrG8I33YV41iMn/hsje+uiSDqXFhXW01B3qZHHjx6DcyvCSr55+hTD765Gq36JAgbdmh1HK06J1I1xt6EWR5t1SoN+z5/mxHMKNJ3DYIXH6dR43SixszrvcPkf/lD8vC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082833; c=relaxed/simple;
	bh=PQfvqcpjdMtq6dnMREILfbHm2mHMjDZ7krmRMywS8YQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dgZ/nR+LF9x1E+v/bfSxUrpc+9F3TWe0InGJRLlCj7GRVuogpY//u3krsjlYpP5fZIZTsc+hRPrk0Yg1PSv3UUFSQhYqctiFcmAxhl09kyXn2bt/6ZcJ0pbNlYMVFKXGyHrK9xWiWX+mbOn4LXYU3XH/xqWBPQo2yls9E9wR25c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lm2KiRXI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af98b77d2f0so1198212266b.3;
        Wed, 13 Aug 2025 04:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755082830; x=1755687630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrxTd0fZrSZoXHNLmGLsVXRRO9yazGCbbT+JQ4l++eQ=;
        b=Lm2KiRXI5vPbOGLWHlZGTe1iVOdAJO6QqZxqYQzIPOp1tzl+SDucyHaKPWAFCyeoXx
         0iYYR5hlHmrAb14uWxq2TKQr8on0fKCdpZV/uf8ADUj0yASDPKgRAQ7U1Vp/1xK4c/CB
         rzeHy5h1ksMuma66dHM2JggzhhvoWbhJbmR1R5fMXS+JQydBlnc364/i2RqQM/6UcM+w
         IJezpfxq5jbbOw1jW4LDT4xvu4evFQuz+D4KbKWL1uxTRc9LwY0fBn3nw0n9GUIxNhCi
         9ylLabdy5/7e/1xcE+qUm+ktt5nmF8NHbZqIC3oqH0o8gJGkoDEEtm2vnZueY9AfyLCA
         /k8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755082830; x=1755687630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrxTd0fZrSZoXHNLmGLsVXRRO9yazGCbbT+JQ4l++eQ=;
        b=pAtvk/+N1Gm8AvlT5hvhnbZfP4r2C6PTohic+IADHZP8ew/4UL3zj7oU3YXhGvnD4U
         ITQJE0ZQEs28eeS7PngcFjiEGlo1QC+y6lwuqkVJIMI6De269TTzkMF3PpGb0HBkiCr0
         sgVsDpRiGtddyL/k5MtF3qByJBh/k1t1T5q0nx6qwM1knH8NQ5HTA0luTp/4XR3cp6Xm
         UlYgNaau11eBQgW46KptdgP+mCJ2qbla2kztJf/+M4oS9/crW4OGBvluyB5PR1kwcNWh
         Cz/Ss+p/LlFij8rI72xk922xpNIcTd1CE/VdyzCrwx1xgtYMPwW6ojjAZRtvEBDoWZH0
         Dmuw==
X-Forwarded-Encrypted: i=1; AJvYcCVDlu+h0aLqDHyvUb4nML7pLMwdA+f4gqHclfOD1aZbP1xoBiMt9dHiVYeeYq/uJJU/Acr+6n8ARziXu2gG@vger.kernel.org, AJvYcCVvUwLgrAMRqT9K8aTzShg49dYRH/AE6zj6FX5I42h4RyCX8/7/6uoix5IhVsvLuJRXL4uSrQxonXKM@vger.kernel.org, AJvYcCWMR0R/3oM2aF6Xdre0dEc5aDfXPyetXkc71DP65LLC5/UNLWvfYA+Ienj+h6s+OpDQ4I2jSgBOze2f@vger.kernel.org
X-Gm-Message-State: AOJu0YypRp6/eGzYm2KF/UV+foop25+vL+qKf5BIRBRtFNpxihlRpO4E
	OZHV35SjQO5NeR5fxsWRRjCJP2wkQhK7ASIP7FCAUDc9uQRbgh0UCuYr5bnLyB9n
X-Gm-Gg: ASbGncsU2m5RT9YpuzPLPknUt0L0+xSNlc0utTgs+A9VpYKjxn+i2+Kb5rvfSlzI1yT
	+RMVIf+mOHl3T2JZNVvyA2feHM6Fa5/WB4yZvh+C9ZJBpipNwIci4eFgvVyGBR+re5+I/nckuI5
	KofA/15qgi7/UrxnmZ2AU+5VSyJCIDQA/VttQ8Aht0H1RFF/t2zQ0awupQgxsVKX/Wl7eeHDt0t
	91s0ER1Q4R74pm0OtAnArRd0+BQJdWobo3jfjnj8R1I01zXwwdB8G6bExdE/slAwKQ6HO/F4W44
	NtzHIERGtpxTiKI64iu05s7m2cT4LhrJomgtC539uaOrTlyGjEP6y6qYoK5x7lY0Jk+vjPdtwhZ
	UgZrAEME1f1CNAcFkqBmF0PmslXzdCHKfg9wejj76PqARfGw/k2qS4HUAyR9bjrRTcD5DivkHW7
	Q/wyRN
X-Google-Smtp-Source: AGHT+IGQh5Gbn8MpaOPIc2Nelb2/hYtoGCvEdRAzGUzlr5r7mYnmJGK+4eLPd7dnjwh8T3//2OAVGg==
X-Received: by 2002:a17:907:d18:b0:af9:3c05:b73f with SMTP id a640c23a62f3a-afca4ec18c5mr207774366b.41.1755082829423;
        Wed, 13 Aug 2025 04:00:29 -0700 (PDT)
Received: from tablet.my.domain (ip-31-0-121-4.multi.internet.cyfrowypolsat.pl. [31.0.121.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df10asm2377046966b.59.2025.08.13.04.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 04:00:28 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Wed, 13 Aug 2025 13:00:11 +0200
Subject: [PATCH v6 5/9] clk: bcm: kona: Add support for bus clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-kona-bus-clock-v6-5-f5a63d4920a4@gmail.com>
References: <20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com>
In-Reply-To: <20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com>
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
 bh=PQfvqcpjdMtq6dnMREILfbHm2mHMjDZ7krmRMywS8YQ=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBonHA9zUcRlsPl4gpUgcKLBdo20HqqhvF3JeUa/
 2bb81G4/iSJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaJxwPQAKCRCzu/ihE6BR
 aLEzEACAo1GqsJJt7brS72zCsUFnz7CWIRSAyCI+7wsuOPWIvtN9v5f2bXRmGMLF0ybmSBUwIgi
 CR1hVkyr7MZnoMZn01tFuJmY1sGu3qkDp2xOibl4NHMUKFjC1+nrGJcnY49n1EZV5zjCBcoOyye
 RiIWx2e/JCAWo9D/WaHY8y7u9pXyt2v4F1amzbe+4UqbypgJnKw0EFLKvQOy1bQTz1zXb6wBNCF
 5SSMBnS92kmqYRoIOLOSmUo1PRLQ51QFXPkbGiQnuJakOU5dBqer9awXuCQ+qwvUp1Y6nHMzIVs
 3NH8b4AcrjINPamT5iOz77bISvqaTnnfscggbS2QMp/NwK7vbuBxChaoJsRmrO00xovqlXZ+hY9
 Hi7B9rn6N2JtjpcngdSvUK2YYJP7lFAuu7WnGOr9U+lekfkGdxIgEkRmRxIh9NJnGqcGd+0ON4i
 j6Dwue6DbunOF2jPQMxICQIgARunJlPRMrCcMZrMmxETw+dxzO6D+J+08a1RbCwXSzm96Z96hcM
 v6KIU0bdLPl8lqwnYDFCI4QPTJOgWzZW4q9SUeXITNJTRSrpDIupXTcB3RKgZI3wspmmKnRNtAZ
 jo6rj/3gUPqhS3DMCsXTDuNPI4RPRlreFmXYvW7RnlX6xcenxVnq/MQjiWYMmHv3oubvWCUzKjX
 EikIhlKVyBk6HeA==
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
2.50.1


