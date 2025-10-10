Return-Path: <linux-kernel+bounces-848687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1916DBCE574
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C566542BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E469D28315A;
	Fri, 10 Oct 2025 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH9tfNHx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE81EEC0;
	Fri, 10 Oct 2025 19:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760123829; cv=none; b=NEnaCV3x9VlQEcrUWNkVwWU4uj/1eDJG3mMW84lzuovkTwOGYk5DjeV6WfF2SOOF9GRzdBG9r1M4jethrCN3j7+hsQArx1RZEPLhMzrHM4WXEonVTxF8bWh+f7+g/3Y4vGBwPV8RVBjc32LoVMfAK17bE9qhuupS2+w7N7GgspE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760123829; c=relaxed/simple;
	bh=5Hw40SEvi7Bz2/TkcM+9MkBbZhapW9/FzQzevvpyd0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oR18rXqDBaZczQr9K8qXnZm/Tn7O7OWm97wbD6fkk3zMBhDkDeIG++DhnpTaY740NpJxc+20iH9vNXojGz2786CH9kBk/WKnx36Vio4ryE8jdD+CEJ2KLF4Ua25D5O85ZRPs5X2/d56cnnMNUbEJeObJwqiYA9r30Cu0Kw634Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH9tfNHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7568CC4CEF1;
	Fri, 10 Oct 2025 19:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760123825;
	bh=5Hw40SEvi7Bz2/TkcM+9MkBbZhapW9/FzQzevvpyd0M=;
	h=Date:From:To:Cc:Subject:From;
	b=OH9tfNHxDtXsBLtfB+8ecmywpVXF5bU6AATkxYu8i1GvJeZjisRf0mP0EBAD2iGsp
	 w19Y5vKzptRB/7PuKaLnyxu06Mp0pHD1dXeRrTSphJ9TPkfuCYT5UXx6eKGXTXpgUL
	 JRPXr/v7fFyI111wzBvT55T/zYWMC5SAGW0h8LAqLn6q0+aRLwjw+WgidIHdhs2x0Y
	 yvTK8nsEzz2pIpVBkRj2QxP2Kmnifykv/AhZd4zlQYAAtOJndOC+Pf0p4QmM1FFDLV
	 0+447+xYaExXI57kcAuHntNLBx0aN1jL7ibyyaIeV5GxRj+BFhou3s2mA0Jtv6OIa+
	 JPQK6zWUBf5pg==
Date: Fri, 10 Oct 2025 14:17:03 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.18, part 1
Message-ID: <20251010191703.GA796093-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull DT fixes for 6.18.

Rob


The following changes since commit 129b91fc329604e05f794dc1a18a6da3eb518b4e:

  dt-bindings: arm: altera: Drop socfpga-sdram-edac.txt (2025-09-28 21:40:45 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.18-1

for you to fetch changes up to ce740955b238761ec1d8cf0590d7e6802d3a813a:

  dt-bindings: bus: renesas-bsc: allow additional properties (2025-10-10 13:51:15 -0500)

----------------------------------------------------------------
Devicetree fixes for v6.18:

- Allow child nodes on renesas-bsc bus binding

- Drop node name pattern on allwinner,sun50i-a64-de2 bus binding

- Switch DT patchwork to kernel.org from ozlabs.org

- Fix some typos in docs and bindings

- Fix reference count in PCI node unittest

----------------------------------------------------------------
Akiyoshi Kurita (1):
      dt-bindings: mmc: Correct typo "upto" to "up to"

Bhanu Seshu Kumar Valluri (1):
      of: doc: Fix typo in doc comments.

Ma Ke (1):
      of: unittest: Fix device reference count leak in of_unittest_pci_node_verify

Rob Herring (Arm) (1):
      MAINTAINERS: Move DT patchwork to kernel.org

Wolfram Sang (2):
      dt-bindings: bus: allwinner,sun50i-a64-de2: don't check node names
      dt-bindings: bus: renesas-bsc: allow additional properties

 .../devicetree/bindings/bus/allwinner,sun50i-a64-de2.yaml    |  2 +-
 Documentation/devicetree/bindings/bus/renesas,bsc.yaml       | 12 ++++++++++++
 .../devicetree/bindings/mmc/mmc-controller-common.yaml       |  2 +-
 MAINTAINERS                                                  |  3 ++-
 drivers/of/irq.c                                             |  2 +-
 drivers/of/overlay.c                                         |  2 +-
 drivers/of/unittest.c                                        |  1 +
 include/linux/of.h                                           |  8 ++++----
 8 files changed, 23 insertions(+), 9 deletions(-)

