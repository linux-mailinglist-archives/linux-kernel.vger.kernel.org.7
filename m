Return-Path: <linux-kernel+bounces-794377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38898B3E0DB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7321896A9F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86463101D4;
	Mon,  1 Sep 2025 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Llous2c/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6D4217F55;
	Mon,  1 Sep 2025 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724696; cv=none; b=ujyp3W2cn7x7T4XQoyMcQwYlUWxr5fJ62CI7ja3PumRpNajW+CoZAxpIWwtnkGRfz1NeQVoTqohpRgc3CCM/EiQ18OFho01vYXvz+Ffc8rNzsQzZhcdibWb6tKkErAuqk89NbDRvu4MPrNul7qlHvRpvYcuNdRaQY5ASLnS4WDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724696; c=relaxed/simple;
	bh=+8gXdf6AYvkuwsTQHIYRgcNXphR2xrs5FzoYe3zQNB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ubZsODzHSb9eHQPkW8gGSz+cRCVrQ+S394xfn3aFWA0J290rmmCQcHHW35Nj0frGg2oBwpyO3qfoIMOh5swMP5dK/06UTLmce4LBHJ9QVJPCxT8R57YKI5opjbfdHRfEDHLzhf5xAvrMnU83A1RotTNzZsIL6jfexX0ncTPY57k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Llous2c/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091C0C4CEF0;
	Mon,  1 Sep 2025 11:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756724695;
	bh=+8gXdf6AYvkuwsTQHIYRgcNXphR2xrs5FzoYe3zQNB4=;
	h=From:To:Cc:Subject:Date:From;
	b=Llous2c/uD3JzoaFblKUbeqxj95iyLg4Pe9RtHB5A9+wc/3CowARUEdiX6c+RlpK9
	 K7Sy4J5gMkuKE9B+h2RAVfH8y3f+OmUpv7G+XWD9unINLmh9fdCvUQTdN03KpdAk35
	 hzyZstEkeFziZZEPab9SAi/4ILOQ2aEQBVrmffbMWDbR7iUJEkiiemGmOhFuihHJdo
	 XTcB+nweJmJViqA3Ez7ixT6JicWtLOn9VmyI/eYkqYRfpNS/fAoMext2Q1a+TNi8Gu
	 bMx1Ukviqzys77lSHwd04idX5K3DMIdwrSOmbrK58/p+ngdfjEdBI8SZtH7OsjJNvw
	 wKIgSjYlqUGSg==
From: Conor Dooley <conor@kernel.org>
To: sboyd@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
Subject: [PATCH v4 0/9] Redo PolarFire SoC's mailbox/clock devicetrees and related code
Date: Mon,  1 Sep 2025 12:04:12 +0100
Message-ID: <20250901-rigid-sacrifice-0039c6e6234e@spud>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5793; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=PDC15xyhviRskACrubd0GzR2ve3J1jVrz01HMsd+U6M=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlba9co/dz9wvq1yRH9jknzywUeCpwU4FtwTT7vfN0in Rjnq78KO0pZGMS4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCR2fWMDBN3n5le9q+/cbuQ xTGuUF6R7Pbbs/pFhDW8P+6TTuZcXMbI0ChRrn/TqHtVfvGcb6Zqa68s1s/o3Z93/czNz4mSV+V mcgIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Yo,

Stephen - I would really like to know if what I have done with the
regmap clock is what you were asking for (a there's a link to that below
to remind yourself). I've been trying to get you to look at this for a
while, even just to affirm that I am on the right track!

Cheers,
Conor.

v4:
- unify both regmap clk implementations under one option
- change map_offset to a u32, after Gabriel pointed out that u8 was
  too restrictive.
- remove locking from regmap portion of reset driver, relying on
  inherent regmap lock

v3 changes:
- drop simple-mfd (for now) from syscon node

v2 cover letter:

Here's something that I've been mulling over for a while, since I
started to understand how devicetree stuff was "meant" to be done.
There'd been little reason to actually press forward with it, because it
is fairly disruptive. I've finally opted to do it, because a user has
come along with a hwmon driver that needs to access the same register
region as the mailbox and the author is not keen on using the aux bus,
and because I do not want the new pic64gx SoC that's based on PolarFire
SoC to use bindings etc that I know to be incorrect.

Given backwards compatibility needs to be maintained, this patch series
isn't the prettiest thing I have ever written. The reset driver needs to
retain support for the auxiliary bus, which looks a bit mess, but not
much can be done there. The mailbox and clock drivers both have to have
an "old probe" function to handle the old layout. Thankfully in the
clock driver, regmap support can be used to identically
handle both old and new devicetree formats - but using a regmap in the
mailbox driver was only really possible for the new format, so the code
there is unfortunately a bit of an if/else mess that I'm both not proud
of, nor really sure is worth "improving".

The series should be pretty splitable per subsystem, only the dts change
has some sort of dependency, but I'll not be applying that till
everything else is in Linus' tree, so that's not a big deal.

I don't really want this stuff in stable, hence a lack of cc: stable
anywhere here, since what's currently in the tree works fine for the
currently supported hardware.

AFAIK, the only other project affected here is U-Boot, which I have
already modified to support the new format.

I previously submitted this as an RFC, only to Lee and the dt list, in
order to get some feedback on the syscon/mfd bindings:
https://lore.kernel.org/all/20240815-shindig-bunny-fd42792d638a@spud/
I'm not really going to bother with a proper changelog, since that was
submitted with lots of WIP code to get answers to some questions. The
main change was "removing" some of the child nodes of the syscons.

And as a "real" series where discussion lead to me dropping use of the
amlogic clk-regmap support:
https://lore.kernel.org/linux-clk/20241002-private-unequal-33cfa6101338@spud/
As a result of that, I've implemented what I think Stephen was asking
for - but I'm not at all sure that it is..

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: pierre-henry.moussay@microchip.com
CC: valentina.fernandezalanis@microchip.com
CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>
CC: Lee Jones <lee@kernel.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>
CC: linux-riscv@lists.infradead.org
CC: linux-clk@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>

Conor Dooley (9):
  dt-bindings: mfd: syscon document the control-scb syscon on PolarFire
    SoC
  dt-bindings: soc: microchip: document the simple-mfd syscon on
    PolarFire SoC
  soc: microchip: add mfd drivers for two syscon regions on PolarFire
    SoC
  reset: mpfs: add non-auxiliary bus probing
  dt-bindings: clk: microchip: mpfs: remove first reg region
  riscv: dts: microchip: fix mailbox description
  riscv: dts: microchip: convert clock and reset to use syscon
  clk: divider, gate: create regmap-backed copies of gate and divider
    clocks
  clk: microchip: mpfs: use regmap clock types

 .../bindings/clock/microchip,mpfs-clkcfg.yaml |  36 ++-
 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../microchip,mpfs-mss-top-sysreg.yaml        |  47 +++
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |  34 ++-
 drivers/clk/Kconfig                           |   4 +
 drivers/clk/Makefile                          |   2 +
 drivers/clk/clk-divider-regmap.c              | 271 ++++++++++++++++++
 drivers/clk/clk-gate-regmap.c                 | 254 ++++++++++++++++
 drivers/clk/microchip/Kconfig                 |   3 +
 drivers/clk/microchip/clk-mpfs.c              | 151 ++++++----
 drivers/reset/reset-mpfs.c                    |  83 ++++--
 drivers/soc/microchip/Kconfig                 |  13 +
 drivers/soc/microchip/Makefile                |   1 +
 drivers/soc/microchip/mpfs-control-scb.c      |  45 +++
 drivers/soc/microchip/mpfs-mss-top-sysreg.c   |  48 ++++
 include/linux/clk-provider.h                  | 119 ++++++++
 16 files changed, 1018 insertions(+), 95 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml
 create mode 100644 drivers/clk/clk-divider-regmap.c
 create mode 100644 drivers/clk/clk-gate-regmap.c
 create mode 100644 drivers/soc/microchip/mpfs-control-scb.c
 create mode 100644 drivers/soc/microchip/mpfs-mss-top-sysreg.c

-- 
2.47.2


