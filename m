Return-Path: <linux-kernel+bounces-898427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFCAC55448
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A4A934693E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A4C296BC4;
	Thu, 13 Nov 2025 01:38:01 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B757080D;
	Thu, 13 Nov 2025 01:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762997881; cv=none; b=ZRTI1hiGs0uF0fWkA1ZGLazuCslM163mEHzqCoScPHnz8BUdZKXZkJgUYG9CQfQr3y2pLgSRTdL1j21P6FPSWUC1uZpBQFucs9SZlWOUOWy7sI/d7OscJfuv2smI1Oy5WauuYiyC9tzu5QfETQyDgrQDyyUInS/bHfc1zIRLmN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762997881; c=relaxed/simple;
	bh=Uiu7GyzBjzUkcrK2zXQT7LSVNZ3Ei1g+wlG73SyEsJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=riiVJvMFH86S8ujtfe+JTlglSXOqqRaptAA5rP1ZaueDgrgoWWFgibSBhfppGAKe4rc7+I44O+Qn7ABHTRKdJx3yRu4iP22YyCSI6rUzkNgPZaNmD5mJZI/mGzKnRjYGukqnxKZ2NFOyFGLN65ZAGXdMVgTjFCLsaGoXw8+PwJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app1 (Coremail) with SMTP id TAJkCgDXz2daNhVp+DV7AA--.29102S2;
	Thu, 13 Nov 2025 09:37:32 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	troy.mitchell@linux.dev,
	bmasney@redhat.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: [PATCH v8 0/3] Add driver support for ESWIN eic700 SoC clock controller
Date: Thu, 13 Nov 2025 09:36:37 +0800
Message-Id: <20251113013637.1109-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgDXz2daNhVp+DV7AA--.29102S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF4DKFW8Cw1xWw45Aw48Crg_yoWxZr17pF
	4kGr98CFn0gryxXan7tayIgF95XanrJFWjkryxXw1jva4Yk34vyr4FvFy5AFWDZr1xAw4D
	tFnrWa1jkF4UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUO73vUUUUU
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

The link [1] provides the official documentation for the EIC7700. Section 3.2
covers the clock subsystem.

[1] https://www.sifive.com/document-file/eic7700x-datasheet

Updates:
  Changes in v8:
  - Added clock-tree link in cover-letter.
  - Updated YAML file
    - Added "Acked-by: Troy Mitchell <troy.mitchell@linux.dev>" for bindings.
  - Updated driver file
    - Changed Kconfig symbol type from bool to tristate to build this driver as
      module.
  - Updated MAINTAINERS file
    - Added entry "ESWIN EIC7700 CLOCK DRIVER".

  - Link to v7: https://lore.kernel.org/all/20251023071658.455-1-dongxuyang@eswincomputing.com/

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

Xuyang Dong (3):
  dt-bindings: clock: eswin: Documentation for eic7700 SoC
  clock: eswin: Add eic7700 clock driver
  MAINTAINERS: Add entry for ESWIN EIC7700 clock driver

 .../bindings/clock/eswin,eic7700-clock.yaml   |   46 +
 MAINTAINERS                                   |    8 +
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/eswin/Kconfig                     |   15 +
 drivers/clk/eswin/Makefile                    |    8 +
 drivers/clk/eswin/clk-eic7700.c               | 1033 +++++++++++++++++
 drivers/clk/eswin/clk-eic7700.h               |  122 ++
 drivers/clk/eswin/clk.c                       |  481 ++++++++
 drivers/clk/eswin/clk.h                       |  256 ++++
 .../dt-bindings/clock/eswin,eic7700-clock.h   |  280 +++++
 11 files changed, 2251 insertions(+)
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


