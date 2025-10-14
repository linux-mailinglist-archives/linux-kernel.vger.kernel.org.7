Return-Path: <linux-kernel+bounces-853245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 159B5BDB01D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1487319A3654
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3CA2C032E;
	Tue, 14 Oct 2025 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed51fLjn"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31262C3258
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469105; cv=none; b=f78EMM5VuJXo6R8G/UWMpjOdXnX7HVHcjsQGgR1xluVSH0iEB84ofNWHYGqwY1Gz8qH3YLU8CYNaB4rwZRFVzZ6YwGXbyrZ1SQ0bG5cUMxtVzvk19cEuTeJ2hjqYrgKptqlC9bLFM4H65LbIyjiXFt+YaVg4PE/E0qPYNyUdZ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469105; c=relaxed/simple;
	bh=YefT5otysJ8NjA8T2i4+1rJNyo8a8/c0YKBFqBkyJ/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiRqP6tl3HK58ukio7tP7OVcrY0SBVFlH5laZbSDaHdKD1zeO6TRf0dtNXRmmG75yCefHIlKxTHJKweiro8w0KHDCkdEtSNwoxei195zUgydlZiXVjP3tsE7CtIXjkAhK/8+qG7+mHYu/zmi+OqvKPxUzO/bGkURoOKS5XOAL1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed51fLjn; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b551350adfaso4709389a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760469103; x=1761073903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BogSUI7PkmiswfdRdXAifBQbqaT4kGoB2ig/EHU0lIU=;
        b=ed51fLjnpNY+CnRs75SH14pCN8FN1yRBmKcp6icKFvfJ4NFL2da0rqhf3NsYEpi7bp
         0H/IF/9aUjUkVEE3B+jLxiYRlVVA2QRhAwqh+JUjtu5GGWinDHLOk82MhSckwAD3fpQB
         kp+CdovE0FDdD/7NoHicyH2ynt99GaJ7G0W/AV43mKP2tNJuRQXBCuxNrezxgKy++vK2
         zZCXTyXeuL/5rXaKC1bqOchm4651yz1DrspAY2+Eb2gtr6DLDAKpXu0s7hIj7wKBwgr+
         vioCO8Oa+o7sDhBw3TDnepKWtkHGQyzuKEkCiwvnmmS/uKBOFEKdXS2CbICyZu37ak6b
         qqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760469103; x=1761073903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BogSUI7PkmiswfdRdXAifBQbqaT4kGoB2ig/EHU0lIU=;
        b=wyyGl5pMD6+9luMxOHCleKdNbLLBfuUS1wf2EyKXogzS2S6l6OnUua48UY8B4B57y9
         VZxtB8bbRyZWYIXT5V8k55PZtZCnJJk4cOKjNkYmWrTM079G/SeTN3UGo7OO48KtZyY1
         M6kxvbJtjLoLJRDvK6kSZrp3jmslMfkSC1+z6tad8oMP2X13iGU30gY8WHMR5ef4+avw
         bHs7xJFYr+fpXXMa8fS7QpHXeGJCTAS2nGzVte2W9bNSDM+ueKqUAOPQ1iWsRm8OdSTT
         1Gw72pDYSzp8S3qHC2EIe25nXI2CI6p8egasiZcdaA8q1+nroJoQGcwC5zlXpnBJWMRx
         qS2g==
X-Forwarded-Encrypted: i=1; AJvYcCUjvIGFl8hpfwNtsJgTDboQ2Jf7y2MdFo6ViArREia/wz7VIvaaMcgAysJqslsSwTK1EMkLq19cTgHE6rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygkorgMgIUiPe0QAImmLivROmkIyJQNXI1q90ygYw/zbVGjOAF
	d4H7lN+jbw+BFHwOqsnYNf29NL9Sl0b1Lji5OeJOosZfAGgNYNGa0mld
X-Gm-Gg: ASbGncuazep96MbcEoLeAUnQA07lNAEQ2EJRrb+7vHj45A+8DCPQ1FrvFi5HlNHhse3
	BdaNHKBk/JqTspm35gkOL2xzycwkjGUOKXw1rRtSa9zuNca2BXPS2mw3f9PJX6T6YHJSto0ursO
	2jppl9NsOd+db3Vw1yQ0azSQWGerm6glptxjTVZPUUUcIXsLfNIfd21hExkcz1W9K/yRo22Z7eY
	Pof28mWV4ipwGRuHEBSdT26ayUbigIlIWatsGp/FB69VaEpZ1EIBNQL7FG48xxH9C8g26r7IYvC
	pogdN2OyeYiK44ygpiEyFw51XTWo58pTmyNBn9nkgE3doBJk3YZAMEjALmi0yklBZTjGAAOARwy
	Wp1bwoF01yYOYzjV39b+q+qvEoo4tIsNxqbdJuK37YG65JdcBnj7N4Aiu5iVAWGzmCDWm/eA=
X-Google-Smtp-Source: AGHT+IH6ay/Mncuf3xHUiJWwNuJOB4u2RjfTBQCf/aIwCE5FpVXep984UAF3OAMLdG6dwukU1EvpdQ==
X-Received: by 2002:a17:903:3c2b:b0:24b:62ef:9d38 with SMTP id d9443c01a7336-29027379a32mr350982335ad.19.1760469102875;
        Tue, 14 Oct 2025 12:11:42 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:9987:bec4:a0:deaf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de658bsm172402755ad.22.2025.10.14.12.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 12:11:42 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/2] pinctrl: renesas: rzt2h: Add pin configuration support
Date: Tue, 14 Oct 2025 20:11:21 +0100
Message-ID: <20251014191121.368475-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014191121.368475-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251014191121.368475-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add pin configuration support for the Renesas RZ/T2H SoC. The RZ/T2H allows
configuring pin properties through the DRCTLm (I/O Buffer Function
Switching) registers, including:
- Drive strength (low/middle/high/ultra high)
- Pull-up/pull-down/no-bias configuration (3 options: no pull, pull-up,
  pull-down)
- Schmitt trigger control (enable/disable)
- Slew rate control (2 options: slow/fast)

The drive strength configuration uses four discrete levels (low, middle,
high, ultra high) rather than the standard milliamp values. To properly
represent this hardware behavior, implement a custom device-tree binding
parameter "renesas,drive-strength" that accepts values 0-3 corresponding
to these discrete levels.

The DRCTLm registers are accessed in 32-bit mode, with each port split
into two halves (bits 0-3 and bits 4-7) requiring separate register
offsets.

Implement pinconf_ops to support:
- Getting/setting individual pin configurations
- Getting/setting pin group configurations
- Standard properties: bias-disable, bias-pull-up, bias-pull-down,
  input-schmitt-enable, slew-rate
- Custom property: renesas,drive-strength

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzt2h.c | 230 ++++++++++++++++++++++++
 1 file changed, 230 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
index 4826ff91cd90..501b05844046 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
@@ -42,16 +42,27 @@
 #define PMC(m)		(0x400 + (m))
 #define PFC(m)		(0x600 + 8 * (m))
 #define PIN(m)		(0x800 + (m))
+#define DRCTL(n)	(0xa00 + 0x008 * (n))
 #define RSELP(m)	(0xc00 + (m))
 
 #define PM_MASK			GENMASK(1, 0)
 #define PM_PIN_MASK(pin)	(PM_MASK << ((pin) * 2))
 #define PM_INPUT		BIT(0)
 #define PM_OUTPUT		BIT(1)
+#define SR_MASK			0x01
+#define SCHMITT_MASK		0x01
+#define IOLH_MASK		0x03
+#define PUPD_MASK		0x03
 
 #define PFC_MASK		GENMASK_ULL(5, 0)
 #define PFC_PIN_MASK(pin)	(PFC_MASK << ((pin) * 8))
 
+#define DRCTL_BIT_OFFSET(bit)		((bit) * 8)
+#define DRCTL_IOLH_SHIFT(bit)		DRCTL_BIT_OFFSET(bit)
+#define DRCTL_PUPD_SHIFT(bit)		(DRCTL_BIT_OFFSET(bit) + 2)
+#define DRCTL_SCHMITT_SHIFT(bit)	(DRCTL_BIT_OFFSET(bit) + 4)
+#define DRCTL_SR_SHIFT(bit)		(DRCTL_BIT_OFFSET(bit) + 5)
+
 /*
  * Use 16 lower bits [15:0] for pin identifier
  * Use 8 higher bits [23:16] for pin mux function
@@ -101,8 +112,22 @@ static inline type rzt2h_pinctrl_read##size(struct rzt2h_pinctrl *pctrl, u8 port
 
 RZT2H_PINCTRL_REG_ACCESS(b, u8)
 RZT2H_PINCTRL_REG_ACCESS(w, u16)
+RZT2H_PINCTRL_REG_ACCESS(l, u32)
 RZT2H_PINCTRL_REG_ACCESS(q, u64)
 
+/* Custom pinconf parameters */
+#define RENESAS_RZT2H_PIN_CONFIG_DRIVE_STRENGTH		(PIN_CONFIG_END + 1)
+
+static const struct pinconf_generic_params renesas_rzt2h_custom_bindings[] = {
+	{"renesas,drive-strength", RENESAS_RZT2H_PIN_CONFIG_DRIVE_STRENGTH, 0},
+};
+
+#ifdef CONFIG_DEBUG_FS
+static const struct pin_config_item renesas_rzt2h_conf_items[] = {
+	PCONFDUMP(RENESAS_RZT2H_PIN_CONFIG_DRIVE_STRENGTH, "drive-strength", NULL, true),
+};
+#endif
+
 static int rzt2h_validate_pin(struct rzt2h_pinctrl *pctrl, unsigned int offset)
 {
 	u8 port = RZT2H_PIN_ID_TO_PORT(offset);
@@ -425,6 +450,196 @@ static int rzt2h_dt_node_to_map(struct pinctrl_dev *pctldev,
 	return ret;
 }
 
+static int rzt2h_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
+				     unsigned int _pin,
+				     unsigned long *config)
+{
+	struct rzt2h_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	u32 param = pinconf_to_config_param(*config);
+	u32 port = RZT2H_PIN_ID_TO_PORT(_pin);
+	u8 bit = RZT2H_PIN_ID_TO_PIN(_pin);
+	u32 addr = DRCTL(port);
+	unsigned int arg;
+	int ret;
+
+	ret = rzt2h_validate_pin(pctrl, _pin);
+	if (ret)
+		return ret;
+
+	/* Access DRCTLm register in 32-bit mode */
+	if (bit >= 4) {
+		bit -= 4;
+		addr += 4;
+	}
+
+	arg = rzt2h_pinctrl_readl(pctrl, port, addr);
+
+	switch (param) {
+	case PIN_CONFIG_SLEW_RATE:
+		 arg = (arg >> DRCTL_SR_SHIFT(bit)) & SR_MASK;
+		break;
+
+	case PIN_CONFIG_BIAS_DISABLE:
+	case PIN_CONFIG_BIAS_PULL_UP:
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		 arg = (arg >> DRCTL_PUPD_SHIFT(bit)) & PUPD_MASK;
+		if ((arg == 0 && param != PIN_CONFIG_BIAS_DISABLE) ||
+		    (arg == 0x1 && param != PIN_CONFIG_BIAS_PULL_UP) ||
+		    (arg == 0x2 && param != PIN_CONFIG_BIAS_PULL_DOWN))
+			return -EINVAL;
+		break;
+
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		arg = (arg >> DRCTL_SCHMITT_SHIFT(bit)) & SCHMITT_MASK;
+		if (!arg)
+			return -EINVAL;
+		break;
+
+	case RENESAS_RZT2H_PIN_CONFIG_DRIVE_STRENGTH:
+		arg = (arg >> DRCTL_IOLH_SHIFT(bit)) & IOLH_MASK;
+		break;
+
+	default:
+		return -ENOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+
+	return 0;
+};
+
+static void rzt2h_drctl_rmw(struct rzt2h_pinctrl *pctrl, unsigned int pin,
+			    u32 mask, u32 val)
+{
+	u32 port = RZT2H_PIN_ID_TO_PORT(pin);
+	u8 bit = RZT2H_PIN_ID_TO_PIN(pin);
+	u32 offset = DRCTL(port);
+	unsigned long flags;
+	u32 drctl;
+
+	/* Access DRCTLm register in 32-bit mode */
+	if (bit >= 4)
+		offset += 4;
+
+	spin_lock_irqsave(&pctrl->lock, flags);
+	drctl = rzt2h_pinctrl_readl(pctrl, port, offset) & ~mask;
+	rzt2h_pinctrl_writel(pctrl, port, drctl | val, offset);
+	spin_unlock_irqrestore(&pctrl->lock, flags);
+}
+
+static int rzt2h_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
+				     unsigned int _pin,
+				     unsigned long *_configs,
+				     unsigned int num_configs)
+{
+	struct rzt2h_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	u8 bit = RZT2H_PIN_ID_TO_PIN(_pin);
+	unsigned int i;
+	int ret;
+
+	ret = rzt2h_validate_pin(pctrl, _pin);
+	if (ret)
+		return ret;
+
+	/* Adjust bit for upper half of port */
+	if (bit >= 4)
+		bit -= 4;
+
+	for (i = 0; i < num_configs; i++) {
+		u32 arg = pinconf_to_config_argument(_configs[i]);
+		u32 param = pinconf_to_config_param(_configs[i]);
+		u32 mask, val;
+
+		switch (param) {
+		case PIN_CONFIG_SLEW_RATE:
+			mask = SR_MASK << DRCTL_SR_SHIFT(bit);
+			val = (!!arg) << DRCTL_SR_SHIFT(bit);
+			break;
+
+		case PIN_CONFIG_BIAS_DISABLE:
+		case PIN_CONFIG_BIAS_PULL_UP:
+		case PIN_CONFIG_BIAS_PULL_DOWN: {
+			u32 bias = (param == PIN_CONFIG_BIAS_DISABLE) ? 0 :
+				(param == PIN_CONFIG_BIAS_PULL_UP) ? 1 : 2;
+
+			mask = PUPD_MASK << DRCTL_PUPD_SHIFT(bit);
+			val = bias << DRCTL_PUPD_SHIFT(bit);
+			break;
+		}
+
+		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+			mask = SCHMITT_MASK << DRCTL_SCHMITT_SHIFT(bit);
+			val = (!!arg) << DRCTL_SCHMITT_SHIFT(bit);
+			break;
+
+		case RENESAS_RZT2H_PIN_CONFIG_DRIVE_STRENGTH:
+			if (arg > IOLH_MASK)
+				return -EINVAL;
+
+			mask = IOLH_MASK << DRCTL_IOLH_SHIFT(bit);
+			val = arg << DRCTL_IOLH_SHIFT(bit);
+			break;
+
+		default:
+			return -EOPNOTSUPP;
+		}
+
+		rzt2h_drctl_rmw(pctrl, _pin, mask, val);
+	}
+
+	return 0;
+}
+
+static int rzt2h_pinctrl_pinconf_group_set(struct pinctrl_dev *pctldev,
+					   unsigned int group,
+					   unsigned long *configs,
+					   unsigned int num_configs)
+{
+	const unsigned int *pins;
+	unsigned int i, npins;
+	int ret;
+
+	ret = pinctrl_generic_get_group_pins(pctldev, group, &pins, &npins);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < npins; i++) {
+		ret = rzt2h_pinctrl_pinconf_set(pctldev, pins[i], configs,
+						num_configs);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+};
+
+static int rzt2h_pinctrl_pinconf_group_get(struct pinctrl_dev *pctldev,
+					   unsigned int group,
+					   unsigned long *config)
+{
+	const unsigned int *pins;
+	unsigned int i, npins, prev_config = 0;
+	int ret;
+
+	ret = pinctrl_generic_get_group_pins(pctldev, group, &pins, &npins);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < npins; i++) {
+		ret = rzt2h_pinctrl_pinconf_get(pctldev, pins[i], config);
+		if (ret)
+			return ret;
+
+		/* Check config matching between to pin  */
+		if (i && prev_config != *config)
+			return -EOPNOTSUPP;
+
+		prev_config = *config;
+	}
+
+	return 0;
+};
+
 static const struct pinctrl_ops rzt2h_pinctrl_pctlops = {
 	.get_groups_count = pinctrl_generic_get_group_count,
 	.get_group_name = pinctrl_generic_get_group_name,
@@ -441,6 +656,15 @@ static const struct pinmux_ops rzt2h_pinctrl_pmxops = {
 	.strict = true,
 };
 
+static const struct pinconf_ops rzt2h_pinctrl_confops = {
+	.is_generic = true,
+	.pin_config_get = rzt2h_pinctrl_pinconf_get,
+	.pin_config_set = rzt2h_pinctrl_pinconf_set,
+	.pin_config_group_set = rzt2h_pinctrl_pinconf_group_set,
+	.pin_config_group_get = rzt2h_pinctrl_pinconf_group_get,
+	.pin_config_config_dbg_show = pinconf_generic_dump_config,
+};
+
 static int rzt2h_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzt2h_pinctrl *pctrl = gpiochip_get_data(chip);
@@ -674,7 +898,13 @@ static int rzt2h_pinctrl_register(struct rzt2h_pinctrl *pctrl)
 	desc->npins = pctrl->data->n_port_pins;
 	desc->pctlops = &rzt2h_pinctrl_pctlops;
 	desc->pmxops = &rzt2h_pinctrl_pmxops;
+	pctrl->desc.confops = &rzt2h_pinctrl_confops;
 	desc->owner = THIS_MODULE;
+	pctrl->desc.num_custom_params = ARRAY_SIZE(renesas_rzt2h_custom_bindings);
+	pctrl->desc.custom_params = renesas_rzt2h_custom_bindings;
+#ifdef CONFIG_DEBUG_FS
+	pctrl->desc.custom_conf_items = renesas_rzt2h_conf_items;
+#endif
 
 	pins = devm_kcalloc(dev, desc->npins, sizeof(*pins), GFP_KERNEL);
 	if (!pins)
-- 
2.43.0


