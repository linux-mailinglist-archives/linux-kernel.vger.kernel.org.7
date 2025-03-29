Return-Path: <linux-kernel+bounces-580889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC53CA757B7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 20:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD208188A0F2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 19:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD16E1DDA36;
	Sat, 29 Mar 2025 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=labcsmart.com header.i=@labcsmart.com header.b="T0Vm1s/V"
Received: from 5.mo576.mail-out.ovh.net (5.mo576.mail-out.ovh.net [46.105.43.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E66190470
	for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.43.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743276715; cv=none; b=ehW5TyKCyMjAQmbdjIuyp75gdEaeH0gr5jFycPJ6841C5s3WBP3DPG43K6jApE/qqcO8cJCcXfZhp4dQRo8Kq5rxyQessCD7o89UcUDwGDbZsyb0SR1IRlDa2y7U74hvhFCPgvNP4pz712pGERwereHZXrZ4L+yfQf2KcLjaqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743276715; c=relaxed/simple;
	bh=uGnuxLaPa9lafg8GL1vrIXjXYLga4eyTWR5Bm64gm6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LLR97zO1ncHQEm4+do82inkfJ9reIUYk/7cCe+7mKXiwQozV29T3b1uZ+ouC+Ledl9mftpS6CgIUEINP8iqiRGA24bN95SQx3s4vi2OtnmxzCmSFTIv4w1UEre99mBAPdDyi4C1vng5pskzQDtiRvd/abPNTzF2Eo8nnQZdeX0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labcsmart.com; spf=pass smtp.mailfrom=labcsmart.com; dkim=pass (2048-bit key) header.d=labcsmart.com header.i=@labcsmart.com header.b=T0Vm1s/V; arc=none smtp.client-ip=46.105.43.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labcsmart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labcsmart.com
Received: from director11.ghost.mail-out.ovh.net (unknown [10.108.9.41])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4ZQ5Cj0p3jz28wQ
	for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 18:15:13 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-bnbm7 (unknown [10.111.182.49])
	by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 9C73E1FE64;
	Sat, 29 Mar 2025 18:15:10 +0000 (UTC)
Received: from labcsmart.com ([37.59.142.99])
	by ghost-submission-5b5ff79f4f-bnbm7 with ESMTPSA
	id lXD9Eq446GegAwAAx023iw
	(envelope-from <john.madieu@labcsmart.com>); Sat, 29 Mar 2025 18:15:10 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-99G00370defa65-2e12-46e3-a76d-ab6dc0455f8d,
                    1AA15D79FD1645C8296C06E669C502FD88205396) smtp.auth=john.madieu@labcsmart.com
X-OVh-ClientIp:141.94.163.193
From: John Madieu <john.madieu@labcsmart.com>
To: sven@svenpeter.dev,
	j@jannau.net,
	linus.walleij@linaro.org
Cc: alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	john.madieu@gmail.com,
	John Madieu <john.madieu@labcsmart.com>
Subject: [PATCH] pinctrl: apple: Make regmap_config static const and fix indentation
Date: Sat, 29 Mar 2025 18:15:06 +0000
Message-Id: <20250329181506.890043-1-john.madieu@labcsmart.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4085046338809924234
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeegkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhhnhcuofgrughivghuuceojhhohhhnrdhmrgguihgvuheslhgrsggtshhmrghrthdrtghomheqnecuggftrfgrthhtvghrnhepgeegteetieettdffleeludeliedvueeuuefhveffhfehtdehiefhfefflefguddvnecukfhppeduvdejrddtrddtrddupddugedurdelgedrudeifedrudelfedpfeejrdehledrudegvddrleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehjohhhnhdrmhgrughivghusehlrggstghsmhgrrhhtrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeimgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=akVyMKQyCxWZ3yLiQHM8pT2PU+T/9mwnNjkwN1GvFNU=;
 c=relaxed/relaxed; d=labcsmart.com; h=From; s=ovhmo4089092-selector1;
 t=1743272113; v=1;
 b=T0Vm1s/Vrkc1RsJQHrYki+Vr3ubVgaOhtDZs744k67Osex0cxMGi6iFlHHwWn/vqtIKTC93P
 e1VZxhXuFjq2tNtU8IkyAFaJdFJqmVsbUEGGyq9CTzs03Pkkr+6CVnfiJd3EHQVvA3sJIiWQp8G
 z3H/BNoJUOQ1Gq4qJcrHfL8gCaKqQJHnfybZLKx838mt49Bg+CXmbWEekOhzvM6HqxbKewphJAD
 JbpI7fIyADsh+2pmzFirD+dT7wEj6CYcVwUymZ9XlRDevENOV7a5hZsVYxGPgdPZSGmCzgLLnwj
 42HRqU1sPKlyqcFxY20HYqEYS7B1wY+6abjC+mwJEB5sg==

Mark the regmap_config as static const since it is only used in this file
and never modified, allowing the compiler to optimize it and enforce
const-correctness.

Also fix minor indentation inconsistencies in function parameter alignment
to conform with kernel coding style.

Signed-off-by: John Madieu <john.madieu@labcsmart.com>
---
Most changes replace space indentation with tabs.

 drivers/pinctrl/pinctrl-apple-gpio.c | 30 ++++++++++++++--------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-apple-gpio.c b/drivers/pinctrl/pinctrl-apple-gpio.c
index f861e63f4115..0f551d67d482 100644
--- a/drivers/pinctrl/pinctrl-apple-gpio.c
+++ b/drivers/pinctrl/pinctrl-apple-gpio.c
@@ -66,7 +66,7 @@ struct apple_gpio_pinctrl {
 #define REG_GPIOx_DRIVE_STRENGTH1 GENMASK(23, 22)
 #define REG_IRQ(g, x)        (0x800 + 0x40 * (g) + 4 * ((x) >> 5))
 
-struct regmap_config regmap_config = {
+static const struct regmap_config regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
@@ -79,13 +79,13 @@ struct regmap_config regmap_config = {
 
 /* No locking needed to mask/unmask IRQs as the interrupt mode is per pin-register. */
 static void apple_gpio_set_reg(struct apple_gpio_pinctrl *pctl,
-                               unsigned int pin, u32 mask, u32 value)
+			       unsigned int pin, u32 mask, u32 value)
 {
 	regmap_update_bits(pctl->map, REG_GPIO(pin), mask, value);
 }
 
 static u32 apple_gpio_get_reg(struct apple_gpio_pinctrl *pctl,
-                              unsigned int pin)
+			      unsigned int pin)
 {
 	int ret;
 	u32 val;
@@ -100,9 +100,9 @@ static u32 apple_gpio_get_reg(struct apple_gpio_pinctrl *pctl,
 /* Pin controller functions */
 
 static int apple_gpio_dt_node_to_map(struct pinctrl_dev *pctldev,
-                                     struct device_node *node,
-                                     struct pinctrl_map **map,
-                                     unsigned *num_maps)
+				     struct device_node *node,
+				     struct pinctrl_map **map,
+				     unsigned *num_maps)
 {
 	unsigned reserved_maps;
 	struct apple_gpio_pinctrl *pctl;
@@ -147,8 +147,8 @@ static int apple_gpio_dt_node_to_map(struct pinctrl_dev *pctldev,
 		group_name = pinctrl_generic_get_group_name(pctldev, pin);
 		function_name = pinmux_generic_get_function_name(pctl->pctldev, func);
 		ret = pinctrl_utils_add_map_mux(pctl->pctldev, map,
-		                                &reserved_maps, num_maps,
-		                                group_name, function_name);
+						&reserved_maps, num_maps,
+						group_name, function_name);
 		if (ret)
 			goto free_map;
 	}
@@ -171,7 +171,7 @@ static const struct pinctrl_ops apple_gpio_pinctrl_ops = {
 /* Pin multiplexer functions */
 
 static int apple_gpio_pinmux_set(struct pinctrl_dev *pctldev, unsigned func,
-                                 unsigned group)
+				 unsigned group)
 {
 	struct apple_gpio_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 
@@ -237,7 +237,7 @@ static int apple_gpio_direction_input(struct gpio_chip *chip, unsigned int offse
 }
 
 static int apple_gpio_direction_output(struct gpio_chip *chip,
-                                       unsigned int offset, int value)
+				       unsigned int offset, int value)
 {
 	struct apple_gpio_pinctrl *pctl = gpiochip_get_data(chip);
 
@@ -282,7 +282,7 @@ static void apple_gpio_irq_mask(struct irq_data *data)
 	struct apple_gpio_pinctrl *pctl = gpiochip_get_data(gc);
 
 	apple_gpio_set_reg(pctl, data->hwirq, REG_GPIOx_MODE,
-	                   FIELD_PREP(REG_GPIOx_MODE, REG_GPIOx_IN_IRQ_OFF));
+			   FIELD_PREP(REG_GPIOx_MODE, REG_GPIOx_IN_IRQ_OFF));
 	gpiochip_disable_irq(gc, data->hwirq);
 }
 
@@ -294,7 +294,7 @@ static void apple_gpio_irq_unmask(struct irq_data *data)
 
 	gpiochip_enable_irq(gc, data->hwirq);
 	apple_gpio_set_reg(pctl, data->hwirq, REG_GPIOx_MODE,
-	                   FIELD_PREP(REG_GPIOx_MODE, irqtype));
+			   FIELD_PREP(REG_GPIOx_MODE, irqtype));
 }
 
 static unsigned int apple_gpio_irq_startup(struct irq_data *data)
@@ -303,7 +303,7 @@ static unsigned int apple_gpio_irq_startup(struct irq_data *data)
 	struct apple_gpio_pinctrl *pctl = gpiochip_get_data(chip);
 
 	apple_gpio_set_reg(pctl, data->hwirq, REG_GPIOx_GRP,
-	                   FIELD_PREP(REG_GPIOx_GRP, 0));
+			   FIELD_PREP(REG_GPIOx_GRP, 0));
 
 	apple_gpio_direction_input(chip, data->hwirq);
 	apple_gpio_irq_unmask(data);
@@ -320,7 +320,7 @@ static int apple_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 		return -EINVAL;
 
 	apple_gpio_set_reg(pctl, data->hwirq, REG_GPIOx_MODE,
-	                   FIELD_PREP(REG_GPIOx_MODE, irqtype));
+			   FIELD_PREP(REG_GPIOx_MODE, irqtype));
 
 	if (type & IRQ_TYPE_LEVEL_MASK)
 		irq_set_handler_locked(data, handle_level_irq);
@@ -429,7 +429,7 @@ static int apple_gpio_pinctrl_probe(struct platform_device *pdev)
 	unsigned int npins;
 	const char **pin_names;
 	unsigned int *pin_nums;
-	static const char* pinmux_functions[] = {
+	static const char *pinmux_functions[] = {
 		"gpio", "periph1", "periph2", "periph3"
 	};
 	unsigned int i, nirqs = 0;
-- 
2.25.1


