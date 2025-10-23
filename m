Return-Path: <linux-kernel+bounces-866336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53675BFF7E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 180C34EF22D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3591E2C3262;
	Thu, 23 Oct 2025 07:17:23 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9302D249A;
	Thu, 23 Oct 2025 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203842; cv=none; b=VkTi/VBVhtNNfnbBBGaxUcr9Qg2mY02uzYKWAuSXRLNeQifMPOW6mEIJMfPPF/tX3HcdWXiquBcp0MSsLL/T04z/XRsahFw2oIPadTDA7U/SP0qIMPsFaevXnVmaOFlF7J6j+2j9Hlt+tEHZ7/OWhqdA8HEZiZR161DvKAtJ/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203842; c=relaxed/simple;
	bh=f0RUkU6cFnw97PgQYKe+y3HOxH+j8eOcBq6Fvb+2d10=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nkeQSmB+SlpIcEgDlOzi6clsdxnsg3IsKWXky8ylKDCLZhgU6mupA0tOED5yXdkdWDaoRmsWhgsMA0u0Pm1EUEqYSfds0rCzC4GqqqzgRPt5q5DdGbCd8tZvQQDniruDPx+fbU4eEfGz2S04jcsJf1EYTEzTAMsctr+ZCD7ILEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app2 (Coremail) with SMTP id TQJkCgA3yJFu1vlo5pkqAQ--.23242S2;
	Thu, 23 Oct 2025 15:17:04 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: [PATCH v7 0/2] Add driver support for ESWIN eic700 SoC clock controller
Date: Thu, 23 Oct 2025 15:16:58 +0800
Message-Id: <20251023071658.455-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgA3yJFu1vlo5pkqAQ--.23242S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy8ZrW5JFyDCr17AF1xAFb_yoWxJrW8pF
	4kGr98AFn0gryxXan7ta4IgF93XanxJFWjkryxXw1jva45C34vyr4FvFy5AFZrAr1fAw1D
	JFnrWa1jkF4UZaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmjgxUUUUU=
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

Updates:
  Changes in v7:
  - Updated YAML file
    - Added "Acked-by: Conor Dooley <conor.dooley@microchip.com>" for bindings.
  - Updated driver file
    - Added description for clk of eswin_calc_pll().
    - Added macro EIC7700_MUX_TBL to manage mux clock-tree.
    - Added eswin_clk_register_mux_tbl() to register mux clocks with
      discontinuous parent indexes.

  - Link to v6: https://lore.kernel.org/all/20251009092029.140-1-dongxuyang@eswincomputing.com/

  Changes in v6:
  - Removed config option patch dependency from cover letter, because the patch
    was applied.
  - Updated YAML file
    - Added an oscillator as the clock input, named xtal24m.
    - Added clocks property.
  - Updated driver file
    - Replaced fixed_rate_clk_xtal_24m with xtal24m.
    - Dropped fixed_rate_clk_xtal_24m from driver. Because clock xtal24m was
      registered by fixed-clock as oscillator.

  - Link to v5: https://lore.kernel.org/all/20250923084637.1223-1-dongxuyang@eswincomputing.com/

  Changes in v5:
  - Removed vendor prefix patch dependency from cover letter, because the patch
    was applied.
  - Updated YAML file
    - Placed the required after all properties.
    - Removed patternProperties. Also removed compatible of eswin,pll-clock,
      eswin,mux-clock, eswin,divider-clock and eswin,gate-clock as we have moved
      clock tree from DTS to Linux driver.
    - Removed the clock tree from DTS. Used clock-controller to manage all
      clock. Removed all child nodes in clock-controller.
    - Removed '#address-cells' and '#size-cells' properties, because the clock
      controller did not need to define these properties.
    - Removed eic7700-clocks.dtsi.
    - Added dt-bindings header for clock IDs. Because used the IDs to register
      clocks.
  - Updated driver file
    - Modified the commit for clock driver. Dropped indentation in commit.
    - Removed CLK_OF_DECLARE(). Used *clk_hw_register* to register clocks. Used
      devm_of_clk_add_hw_provider.
    - Dropped singletons.
    - Checked the value right after obtaining it.
    - Removed the definitions of macro frequency in clk.h like CLK_FREQ_24M.
    - Modified description of help in Kconfig.
    - Added COMPILE_TEST. Added COMMON_CLK_ESWIN for clk.o. And added
      "select COMMON_CLK_ESWIN" for clk-eic7700.c. Without COMMON_CLK_EIC7700,
      clk.c could not be compiled.
    - Used .determined_rate.
    - Added macro definitions of EIC7700_DIV, EIC7700_FIXED, EIC7700_FACTOR,
      EIC7700_MUX and EIC7700_PLL to manage clock tree.
    - Added clk-eic7700.h to place eic7700 SoC clock registers.
    - Removed refdiv_val and postdiv1_val from clk_pll_recalc_rate(). Because
      these values were unused.

  - Link to v4: https://lore.kernel.org/all/20250815093539.975-1-dongxuyang@eswincomputing.com/

  Changes in v4:
  - Updated YAML file
    - Changed name from cpu-default-frequency to cpu-default-freq-hz.
    - Dropped $ref of cpu-default-frequency.
    - Added cpu-default-frequency for required.
    - Removed cpu-default-frequency in updated file, because there was no
      need to add cpu-default-frequency.
    - Moved DIVIDER to DIV.
    - Arranged the IDs in order.
    - Dropped EIC7700_NR_CLKS.
    - Removed dt-bindings eswin,eic7700-clock.h. Because IDs was not used,
      and used clock device nodes.
    - According to the updated driver codes, the YAML has been updated.
  - Updated driver file
    - Remove undocumented parameters "cpu_no_boost_1_6ghz" and
      "cpu-default-frequency".
    - Modified the comment and used the correct Linux coding style.
    - Removed codes of voltage, because it was not the clock driver.
    - Updated the formula of clock frequency calculation. Removed the logic
      that only used register selection.
    - Used CLK_OF_DECLARE() to register clocks. Registered pll-clock,
      mux-clock, divider-clock, and gate-clock in clk-eic7700.c.
      The specific implementation of clock registration was in clk.c.
    - Added eic7700-clocks.dtsi.
    - Moved device information to DTS. Put all clocks' node in the
      eic7700-clocks.dtsi.

  - Link to v3: https://lore.kernel.org/all/20250624103212.287-1-dongxuyang@eswincomputing.com/

  Changes in v3:
  - Update example, drop child node and add '#clock-cells' to the parent
    node.
  - Change parent node from sys-crg to clock-controller for this yaml.
  - Drop "syscon", "simple-mfd" to clear warnings/errors by using "make
    dt_binding_check". And these are not necessary.
  - Add "cpu-default-frequency" definition in yaml for "undocumented ABI".
  - Drop Reviewed-by, this is misunderstanding. We have not received such
    an email.
  - Link to v2: https://lore.kernel.org/all/20250523090747.1830-1-dongxuyang@eswincomputing.com/

  Changes in v2:
  - Update example, drop child node.
  - Clear warnings/errors for using "make dt_binding_check".
  - Change to the correct format.
  - Drop some non-stanard code.
  - Use dev_err_probe() in probe functions.
  - Link to v1: https://lore.kernel.org/all/20250514002233.187-1-dongxuyang@eswincomputing.com/

Xuyang Dong (2):
  dt-bindings: clock: eswin: Documentation for eic7700 SoC
  clock: eswin: Add eic7700 clock driver

 .../bindings/clock/eswin,eic7700-clock.yaml   |   46 +
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/eswin/Kconfig                     |   15 +
 drivers/clk/eswin/Makefile                    |    8 +
 drivers/clk/eswin/clk-eic7700.c               | 1033 +++++++++++++++++
 drivers/clk/eswin/clk-eic7700.h               |  122 ++
 drivers/clk/eswin/clk.c                       |  481 ++++++++
 drivers/clk/eswin/clk.h                       |  256 ++++
 .../dt-bindings/clock/eswin,eic7700-clock.h   |  280 +++++
 10 files changed, 2243 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/eswin,eic7700-clock.yaml
 create mode 100644 drivers/clk/eswin/Kconfig
 create mode 100644 drivers/clk/eswin/Makefile
 create mode 100644 drivers/clk/eswin/clk-eic7700.c
 create mode 100644 drivers/clk/eswin/clk-eic7700.h
 create mode 100644 drivers/clk/eswin/clk.c
 create mode 100644 drivers/clk/eswin/clk.h
 create mode 100644 include/dt-bindings/clock/eswin,eic7700-clock.h

--
2.43.0


