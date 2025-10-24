Return-Path: <linux-kernel+bounces-869279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D67A9C077C0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F17E8562DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE074342C80;
	Fri, 24 Oct 2025 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cDycCcnT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gJyRWPD6"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F3341AD7
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325712; cv=none; b=bWZc646QjlC7PvPSVFBnRK3bsYCwlWHmyiy8xv7gBBXgqPnjCzPf0SqF/jD0REGi9t5pS/bpyxbB1i7/UvFVgbDB6c+9VyA1S42TETzRR59vUHsAa+1T8Lvg6Kjix0vtvT17y7Cwzaqxz9b7RAjNX8rEC63RQ/Id0qHJ/Hngw/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325712; c=relaxed/simple;
	bh=hsau8RmM3UijJFz3mwMqBheQZY+/ajDxhfZ/KewC+hY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=mxxZKJ+Iue2KhqozfM6aaQNLx8p9+1zUzmI9kticz74tDdmjkbvHoa+MgY09vaB/ZHcf3s8QoSG2CoPQ4dlkB4d8UGbCzmiQxiyxNQIPn5Ksan7pTnWfhXqpgwzmou35+59hXcrI/q9yGsITww7uuLQMMB8nGacfdj7I5tN/AKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cDycCcnT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gJyRWPD6; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id BB6C11D001A4;
	Fri, 24 Oct 2025 13:08:29 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 24 Oct 2025 13:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1761325709; x=1761412109; bh=WO
	uNrW310/87AuysnVn8f56bmg1dUBIWWmh8D5BQhSw=; b=cDycCcnTveLKfv1w1x
	Xkv+qnoZBCS+B1c/CeVxcJ8vIJMhayLgHrOYLrW7/u0MAjfPxcG62fmI4uPs7Y5P
	cVczG+g8wjcgDQY4c6GJlyLluA8oYMsgrJr9b4WSN1sUD0CH6EDd1V1TviU+9Wzl
	c3OqKY+hAC5I1GaBQeBHzYbtH0NZt6vC5WSZwz2Cf0ORqaKggRph4gn7kiNGp3yK
	IiS/ap0bHyTezdGlZ2DTXJQCqfD2n4291a+l6E8ioxox0DHLK+GE5N3kbCbw9F1e
	j9DqUWJ5b+sFznKK4OM1nXO3YF5nOHUAxvyiq9o615fI2F5XMsCzwN4sxf1p7Z78
	rLNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1761325709; x=1761412109; bh=WOuNrW310/87AuysnVn8f56bmg1d
	UBIWWmh8D5BQhSw=; b=gJyRWPD6+oGVY21VPy8PjdK4Dbg5lgU14jSYxp0YcjUH
	5PeSLcrv/qB+18HwIbPPga8pWag1uWlpJFfjyvVugTz7jCkuXHzMDh7WY/hzDwWj
	ZSRi21Nl053CbEMPXTScu8EVrsHEShrwxapl3SxzRgvkaFVDhTveuKexGHOdhCGG
	kLfOb5QwrtRa864ZdZGm4GSiZCfC4n7KmU7UldDfuPka6lmYoABNUgZ8q5uya4t8
	vVkiYbVqZ+MYSWbolW4hEvywpSMUWUOk/3tyxbFePhV6MEDF3ugLM+PRtq1Y6obW
	a77uWJczOY57LAGit1beflm/IO/JMOkn1JdcCtEQ8Q==
X-ME-Sender: <xms:jLL7aMNxLqujDZs0DRQxDY8glzgBegewYb7Vs3yQ4wryvGCzPHSkpg>
    <xme:jLL7aNx1TnKODg7qudhJxda0jwkUIp-1RWMdfD-55unCw20HcnP-6ZY3MtZx7O25I
    IGTNrEIo5qJ8HRR5lxtYLMR75b99dLfcNR0o3AQ6j3Bx5PzzL69Ubo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkffutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epudfgfeeuheelheehfeeigeeigeeiveevheelteelleeijeeikeekvddthfejieffnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggs
    rdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdprhgtphht
    thhopehfuhhsthhinhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgr
    rhhordhorhhgpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhi
    shhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsohgtsehlihhsthhsrd
    hlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jbL7aA-cUy09bl4q7zOl26a3hICbbw3yEDZOXVG2fqa58xGeYjkRQw>
    <xmx:jbL7aLTMVn34Eoq1e8cwii0SbZ17f3dDoLrbGpdTPD62XTeWuk3Eyg>
    <xmx:jbL7aJq17K67lAffy5_jbJ98Ij0P_lvWqgGVJPmhqtlXnw7k1LLmrw>
    <xmx:jbL7aAlkdikE5Q0TU5KGYBVzfwu3ctKQ5WwQWM0ipUflI5geuzUz8Q>
    <xmx:jbL7aEFVULMdq-1_XLE-oZWZ5thWPLTKsYIsNLLlc2KO_vmmekcXkv9G>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DC0C9700063; Fri, 24 Oct 2025 13:08:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Oct 2025 19:08:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@lists.linux.dev, "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Drew Fustini" <fustini@kernel.org>
Message-Id: <a51522e4-61d3-4d8d-8850-678f7fc410db@app.fastmail.com>
Subject: [GIT PULL] soc: fixes for 6.18, part 2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.18-2

for you to fetch changes up to b0cd17fd31a86b55dcec3eb64b9d2a17c1c01e6a:

  soc: officially expand maintainership team (2025-10-23 22:30:48 +0200)

----------------------------------------------------------------
soc: fixes for 6.18, part 2

The main change this time is an update to the MAINTAINERS file,
listing Krzysztof Kozlowski, Alexandre Belloni, and Linus Walleij as
additional maintainers for the SoC tree, in order to go back to a group
maintainership.  Drew Fustini joins as an additional reviewer for the
SoC tree.

Thanks to all of you for volunteering to help out.

On the actual bugfixes, we have a few correctness changes for firmware
drivers (qtee, arm-ffa, scmi) and two devicetree fixes for Raspberry Pi.

----------------------------------------------------------------
Arnd Bergmann (6):
      Merge tag 'tee-qcomtee-fixes-for-v6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee into arm/fixes
      Merge tag 'ffa-fix-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      Merge tag 'scmi-fixes-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      Merge tag 'arm-soc/for-6.18/devicetree-fixes' of https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'arm-soc/for-6.18/devicetree-arm64-fixes' of https://github.com/Broadcom/stblinux into arm/fixes
      soc: officially expand maintainership team

Artem Shimko (1):
      firmware: arm_scmi: Fix premature SCMI_XFER_FLAG_IS_RAW clearing in raw mode

Cristian Marussi (3):
      firmware: arm_scmi: Account for failed debug initialization
      include: trace: Fix inflight count helper on failed initialization
      firmware: arm_scmi: Skip RAW initialization on failure

Dan Carpenter (2):
      tee: qcom: prevent potential off by one read
      tee: qcom: return -EFAULT instead of -EINVAL if copy_from_user() fails

Geert Uytterhoeven (1):
      tee: QCOMTEE should depend on ARCH_QCOM

Peter Robinson (1):
      arm64: dts: broadcom: bcm2712: Define VGIC interrupt

Stefan Wahren (1):
      ARM: dts: broadcom: rpi: Switch to V3D firmware clock

Sudeep Holla (1):
      firmware: arm_ffa: Add support for IMPDEF value in the memory access descriptor

 MAINTAINERS                                        |  4 ++
 arch/arm/boot/dts/broadcom/bcm2711-rpi.dtsi        |  8 +++
 arch/arm/boot/dts/broadcom/bcm2835-rpi-common.dtsi |  9 ++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi          |  2 +
 drivers/firmware/arm_ffa/driver.c                  | 37 ++++++++++----
 drivers/firmware/arm_scmi/common.h                 | 32 +++++++++---
 drivers/firmware/arm_scmi/driver.c                 | 59 ++++++++--------------
 drivers/tee/qcomtee/Kconfig                        |  1 +
 drivers/tee/qcomtee/call.c                         |  2 +-
 drivers/tee/qcomtee/core.c                         |  2 +-
 include/linux/arm_ffa.h                            | 21 +++++++-
 11 files changed, 119 insertions(+), 58 deletions(-)

