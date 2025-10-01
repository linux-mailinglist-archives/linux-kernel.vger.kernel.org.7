Return-Path: <linux-kernel+bounces-839600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAA1BB1FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106C117C087
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308CD311C2E;
	Wed,  1 Oct 2025 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="en9PSW5a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o4tLFKfU"
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F3286D40
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357483; cv=none; b=tvWfej1s8aGUQ3LP/FiIbKgiG6KHLMR0LMTduxooJdjzXFsGgXaPL5bdrDT6Y2gnkR8yhpck58QtekG7ztpBvc2CqNZO5ji3uSjcXagzHbeHS/ob9HPmhzJFKLyG9gu8Szc9PmrXadf37PSjpnM0+D63ZD/ZPwPYO9bh+rXZv5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357483; c=relaxed/simple;
	bh=L7DfzCifVc4WHoPfx7Tkgs8WK81wXV+GfP9ozRZUHlY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qBxyxAvWdSpyW9loWCj5y0kfu/qP/LqWEkd708m0opLkzdxpywnhQo54FRfDM8uK9JuKBUwc5HyYVx2NGwu8Lm95ChpbF2PPXL3rYhG35tKPqBMkZNn3aKC7vSgpEIJRURI9iTR50o+S9mk44NEsOtJq7GybGbgnc0ypPVks/4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=en9PSW5a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o4tLFKfU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A140514001C4;
	Wed,  1 Oct 2025 18:24:39 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 01 Oct 2025 18:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759357479;
	 x=1759443879; bh=moxgaLcuMbxH/PiuEMrkm58H9wq1j46Mre9sz1eZFrM=; b=
	en9PSW5aUsT/tAn9sZ5AqEoNTZNclDv+PpBZVW6Zwd8lZx84O6Q6pDrcGsZuFyUr
	NPFdELNL7QMbw+ndiO9t4Wl5877iF5ZCgwZbcs/pK0jfOv5aeBUFgCaeRJViYtpw
	fGlg3ZUFY3vi/B3iO5DjxIPLa3vi+N4mEMS0kOrSKa6yPT32vVHH6e9AE+fNu07d
	DoYaQn70RX+JVE313Sa7YqG3CYvP6vTsbatamCJu/OT+AEqDgSu1A88uLeb66By5
	A48q31P3JVMlszXIj/iTaCdPC0gx91wyBxSvWswJdJJonyR0LBXx7p6CrqXaKePk
	e3HkKfsAD243Jd+3T7aDCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759357479; x=
	1759443879; bh=moxgaLcuMbxH/PiuEMrkm58H9wq1j46Mre9sz1eZFrM=; b=o
	4tLFKfUwpO/iAV1NRanH5sdMTvzUWd87kSHuBQdoQBidQx4720+bBpcTXGG693pq
	tES1ggytGbdgi2IyftuYFOAt0DMvsQ597YU6K73gKWXNTwxVEdzJytonOAHAUykC
	wkeWe98Dd2JXmIvlRoIgQnx4gN/T9PMw6Q94aLT1qEDQWSEe8jBRqRVLGwPeFlC5
	EJBJZU0w7pBkgI4yyxERxpwtlEkqcISdWfCJpatK5Ebxo8Lrdd4iRU3bDzBgcjwn
	SbKOcRq58SGiXT2rAAbJMo3EE+tsEVsTu6pN4OakTNNiBQBSeZz46C/TKaN9gnAE
	oiXZvkiwYN0L8BcTjdjrA==
X-ME-Sender: <xms:J6rdaN7BHPRLX-YZccSKtiEKJ7bLz6bcVOEcDCHZsTxU_rJgVZgC5g>
    <xme:J6rdaFvTot4X-yU5dMg28uk6H1s1IkVehZ2X8bMIfEgD3gAnJNQPGM8SBIt9TbMWW
    aiG9VjJSXn25QSeJUH7GZ0CcFNfgyHn2BhyalYuS_-puVQcgK4BRVD_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfeihfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhorhhvrghlughsse
    hlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgr
    rhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhr
    tghpthhtohepshhotgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:J6rdaFmr_cOJVKurTwkfHQfAeBDUqcJPs7910tHDJd-dLerBzJsGZw>
    <xmx:J6rdaKJa7WLna1HZt0nzSx18G3VzWsGeIz74toCM__u4bKYsmeldqA>
    <xmx:J6rdaC7ySs51HgL9LASjKYKOO7nV6BVUvxKoZHDw6SjfsNUz1HEMVw>
    <xmx:J6rdaG2QFuF5vrwC7VFh4GdA_jYdXPUOwJVHwhbUZcF9Q4qmh9C_VA>
    <xmx:J6rdaBQ_l0QntbWP7eqbqqLYXK1pGWhKB5kjWYzbGysZtfc3dFScNwsU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 49DD5700065; Wed,  1 Oct 2025 18:24:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AjqV-Bcf-9VR
Date: Thu, 02 Oct 2025 00:24:18 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, soc@lists.linux.dev
Message-Id: <ce4be3de-eae9-4a73-9d85-e47976ef8372@app.fastmail.com>
In-Reply-To: <54b49f7b-9232-44d7-9ae3-ecc1826f17d7@app.fastmail.com>
References: <54b49f7b-9232-44d7-9ae3-ecc1826f17d7@app.fastmail.com>
Subject: [GIT PULL 1/5] soc: new SoC support for 6.18
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit b320789d6883cc00ac78ce83bccbfe7ed58afcf0:

  Linux 6.17-rc4 (2025-08-31 15:33:07 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git soc-newsoc-6.18

for you to fetch changes up to fee2f45def0379ed140de4db8f998edb1d78e619:

  riscv: dts: eswin: add HiFive Premier P550 board device tree (2025-09-25 08:29:06 +0200)

----------------------------------------------------------------
soc: new SoC support for 6.18

Pinkesh Vaghela adds support for the ESWIN EIC7700 SoC, as
described in [1]:

 "Add support for ESWIN EIC7700 SoC consisting of SiFive Quad-Core
  P550 CPU cluster and the first development board that uses it, the
  SiFive HiFive Premier P550.

  This patch series adds initial device tree and also adds ESWIN
  architecture support.

  Boot-tested using intiramfs with Linux v6.17-rc3 on HiFive Premier
  P550 board using U-Boot 2024.01 and OpenSBI 1.4."

[1] https://lore.kernel.org/linux-riscv/20250825132427.1618089-1-pinkesh.vaghela@einfochips.com/

----------------------------------------------------------------
Darshan Prajapati (2):
      dt-bindings: riscv: Add SiFive P550 CPU compatible
      dt-bindings: interrupt-controller: Add ESWIN EIC7700 PLIC

Min Lin (2):
      riscv: dts: add initial support for EIC7700 SoC
      riscv: dts: eswin: add HiFive Premier P550 board device tree

Pinkesh Vaghela (1):
      riscv: Add Kconfig option for ESWIN platforms

Pritesh Patel (1):
      dt-bindings: riscv: Add SiFive HiFive Premier P550 board

 .../interrupt-controller/sifive,plic-1.0.0.yaml    |   1 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   1 +
 Documentation/devicetree/bindings/riscv/eswin.yaml |  29 ++
 MAINTAINERS                                        |   9 +
 arch/riscv/Kconfig.socs                            |   6 +
 arch/riscv/boot/dts/Makefile                       |   1 +
 arch/riscv/boot/dts/eswin/Makefile                 |   2 +
 .../boot/dts/eswin/eic7700-hifive-premier-p550.dts |  29 ++
 arch/riscv/boot/dts/eswin/eic7700.dtsi             | 345 +++++++++++++++++++++
 9 files changed, 423 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/eswin.yaml
 create mode 100644 arch/riscv/boot/dts/eswin/Makefile
 create mode 100644 arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
 create mode 100644 arch/riscv/boot/dts/eswin/eic7700.dtsi

