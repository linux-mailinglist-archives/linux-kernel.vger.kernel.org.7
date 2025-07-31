Return-Path: <linux-kernel+bounces-752114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BE9B17165
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5D54E6780
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F174239E7C;
	Thu, 31 Jul 2025 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7shQWe7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A74B5383;
	Thu, 31 Jul 2025 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965609; cv=none; b=qUu1znJFc4MJiXBpo1VPk+FXyyRLDzx8cM8FobV2rVsCOpJK2Pi9T7ziI3z+VvBdKHMFN/tcBZtWJB7F5UiFe2ecrV7TmeTZrdtoF6zqzYNA4q6DI6++KgUXez2RjzirnrKGJ7oGYBtNAeoLapPSYFc5voWmx42Eb4rIEj0pCNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965609; c=relaxed/simple;
	bh=S8bVfgUaq9skY6+3fwoKxn/RY6iSToVOQJ0iSM1DTOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L54UKHtZkIR/l1RVpKC7Iw7jZvW4aDjfWRw1TXLAVZKB1LsYgRcWc7YvkJVA45oyfDZgoUiOHN/54Fzuarh6RqCbuhri62In01gs0iasjrfYRZ1jfGMvVIHwQ9flcxrERNSKBzvoHqUaHBw7EfhH2IDx22vl6hZmeznTykh+T/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7shQWe7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBCC9C4CEEF;
	Thu, 31 Jul 2025 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753965609;
	bh=S8bVfgUaq9skY6+3fwoKxn/RY6iSToVOQJ0iSM1DTOM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=d7shQWe7G1Grdb30MtQqBC+Ggvo3GWXJIbDEnhn9xL1BlM5h3pGKNcrKjHYh79ecA
	 NL9cnb+nTFW+037LmxZAoWlTgFeIwSYr4O3jodrf4yHES/9si0KPzE3scfiHi7rIkJ
	 a0OFHHwWWbObWXtS4v42QcmqDD0J52/ABIak7oSfHgtDtYCOW7a564GQ/2VZmnuuCO
	 l61/gC3Wbu9MT+x5ue/gNMcZjXmmN7fzpzlTrOr6BYb0zTjJrMBlbgF/4tlwBba9xD
	 aGL8n75okuNUmo8mHbtdeB2exwAcjuuNAHjy+xl4hNTXW0QPdT0mBLDwu0VPWttjcb
	 FciuMLMLmePcQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E061BC87FCA;
	Thu, 31 Jul 2025 12:40:08 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Thu, 31 Jul 2025 20:39:58 +0800
Subject: [PATCH] clk: Add fault tolerance to of_clk_hw_onecell_get()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-add_fault_tolerance_to_of_clk_hw_onecell_get-v1-1-886214fab4a7@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAB1ki2gC/x2NQQrDIBQFrxL+uoJJkJRepZSP6PuJVLSoaQshd
 690N7OZOaiiBFS6DQcVvEMNOXUZLwO5zaYVKvjuNOnJ6GXWynrPYvfYuOWIYpNDJ87CLj55+3B
 OcIiRVzQl3l1HWTAba6gnXwUSvv/d/XGeP9e3QhR+AAAA
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753965607; l=2309;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=k/ApzTLmVZinx72j2hoSqfkFYHo5DCBt6wQQxOx8J2g=;
 b=xf705Yot6owGRVQJbr/b5M1+yj9w2q+3qLYSJ/YZz+PAkv/dBXTlVCSlJvwTUlDkjrmhCH3xq
 V3mhB4EzHMSByuN/kPatFCkLlWjE2hVjazB4QKFWVvZKmaX+/Uic4Cm
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

In specific cases, even a clk_provider managing only a single clock may
reference of_clk_hw_onecell_get() to access its member clocks, as seen
in implementations like clk-scmi.

For a clk_provider with only one clock, when calling
of_parse_phandle_with_args(), the phandle_args->args[] members are not
assigned. In this case, the reference to phandle_args->args[0] in
of_clk_hw_onecell_get() becomes invalid. If phandle_args->args[0]
initially contains a non-zero value, this will trigger an error.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
Error conditions observed:

scmi_clk: protocol@14 {
	reg = <0x14>;
	#clock-cells = <0>;
};

phandle1: clock-controller@1 {
	#clock-cells = <1>;
}

clock-consumer@2 {
	assigned-clocks = <&phandle1 1>,
			  <&scmi_clk>;
	assigned-clock-rates = <xxx>,
			       <xxx>;
}

Under these conditions, executing of_clk_set_defaults() triggers the
error: 'of_clk_hw_onecell_get: invalid index 1'.

While the root cause lies in invalid input data to
of_clk_hw_onecell_get(), checking phandle->args_count for data validity
improves driver fault tolerance.
---
 drivers/clk/clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0565c87656cf..4994c551befe 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4966,7 +4966,7 @@ EXPORT_SYMBOL_GPL(of_clk_hw_simple_get);
 struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data)
 {
 	struct clk_onecell_data *clk_data = data;
-	unsigned int idx = clkspec->args[0];
+	unsigned int idx = clkspec->args_count ? clkspec->args[0] : 0;
 
 	if (idx >= clk_data->clk_num) {
 		pr_err("%s: invalid clock index %u\n", __func__, idx);
@@ -4981,7 +4981,7 @@ struct clk_hw *
 of_clk_hw_onecell_get(struct of_phandle_args *clkspec, void *data)
 {
 	struct clk_hw_onecell_data *hw_data = data;
-	unsigned int idx = clkspec->args[0];
+	unsigned int idx = clkspec->args_count ? clkspec->args[0] : 0;
 
 	if (idx >= hw_data->num) {
 		pr_err("%s: invalid index %u\n", __func__, idx);

---
base-commit: 58abdca0eb653c1a2e755ba9ba406ee475d87636
change-id: 20250730-add_fault_tolerance_to_of_clk_hw_onecell_get-fdc81f7e35a5

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



