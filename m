Return-Path: <linux-kernel+bounces-760770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9912FB1EFF0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D5E1C27E91
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E51978C9C;
	Fri,  8 Aug 2025 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="O17MD1WY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nZslFBf1"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293221CC6A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686442; cv=none; b=KgsUmEao51FOPnKNZpAjpaYpXVcN7Tx8DbV5ks6aZ2MFjVK9dg4wPbSVzftyN865nWihUdLrmRhLblfjecpzPRkMipvU+EAJS8O79hyHl4fXsFat+I2M62yhLv9Ku2tY8dUmVZHHRjQghu4rzbUt+PAhermQw2cBz9I+bT+lYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686442; c=relaxed/simple;
	bh=IP+Bjj9OF5POC3wd9/kp/xJn2IXCg8c4iShJcC4dP+I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=RewAdkeB0rCOZGYDxifplz3kchX7iyeo8Umy7OYoi76F7sTW2BDE8ALB7ek4ijBHdtU8cnTu0VxYKlwpxDciXo32qjw7LnckBbw0YhjIMPgOhWY25K+DJARVhMtWsBPStXOCEqMyKHVGOo4LugWj1Yui8TIVi33X2PzjRuDEzrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=O17MD1WY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nZslFBf1; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0932B1D0007B;
	Fri,  8 Aug 2025 16:53:59 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 08 Aug 2025 16:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1754686438; x=1754772838; bh=uH
	YNYkNF/jUzNDjzt2kUBhDOv1VIkRTZuelGuSEW24k=; b=O17MD1WY6bv0NbqGjh
	LMNS36SyzUV8Nnw95UR1lNNSGzUiXWtQ2DfgCtU1tfzyMf7trKyXThHPr/Xzv8CV
	0tsYEiqvPMbr48oENQrYS+7+o9Lv3221kBeMVQ3CobEshW+eQhAPEpt0roVYxHpb
	ZoQ6bArk2dsojyTZh6yEkjBCW+iRPzI1GQzUJ1yij8GhAfCP8ZeO394H3vsGWCb+
	4M81EX8RG4Vg054GEFmGYbMTqeiCrVK9fVMYCFjvbW19EWBtmhLfLq1M59eXEvZp
	XmhbyYtHXNUKr63swLmno+bLCR78+SP3HIJ10SL0bTpniYMZn7Z2bYHwda9gzMk1
	X3mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754686438; x=1754772838; bh=uHYNYkNF/jUzNDjzt2kUBhDOv1VI
	kRTZuelGuSEW24k=; b=nZslFBf1DiBAzBPl9TCpQEAfZPaLepsFH+eOZf/DqRqQ
	ATf4WhrWk7H2pOPaTKFTrhdMTNTwOmYIU2a4kt8WlJMy++CoRdkPXwOJZ1/lzk3r
	pOZt2XpGBgQ7L2ircM/qmGvDEHL9y2QZh83atp6i84acS2LXqwcJ7Sx05WT6gvj8
	G8vxTJ9o6vhH60lal9qQTwVNxIsuW+MDgin6O21ROJXWVya87/Mrah8ag2OEqcqG
	iWFvpnLwfsu1PD9fRn8Tbka2yT2/4lkxrarKsk07zI29tfvxnF7L4llUOpF9I9DA
	uPQbTz3hzKbz9bVXgCq+Kg4ERiDp5dADWKoRlpfwCw==
X-ME-Sender: <xms:5mOWaKDF5Sa477--BGjq04zX2KDqJTYQRABQDaeacSXOYCqG6dHgiA>
    <xme:5mOWaEgB2TYRrtLCeEOjQ936HW6s1l-2uSGq6QVaV52jngO4bcO5eDEtadrwSHE-x
    8PHS2VeeQl1lPZRE0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkffutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epudfgfeeuheelheehfeeigeeigeeiveevheelteelleeijeeikeekvddthfejieffnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggs
    rdguvgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphht
    thhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopehsohgtsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5mOWaOAvTk4fvF8E61GT8ipgIa1FWrm4nLLjHPiKWTDipH_-jT_18Q>
    <xmx:5mOWaEA14JsPRm5rCSx6uNvm10o2qJswjrmmoBP_38Y2quMG6GjLKg>
    <xmx:5mOWaIBW7-r1sMdZ1JojYtPLQIJr0WfZzyOFJEM0ghaxFJvwEe6CJg>
    <xmx:5mOWaHqRtAKXD_3OValej2KPDZ34CbDR04dW2HiYVJlZVGgX23FMzw>
    <xmx:5mOWaMKvfZcLC_q-P8k0vPB5KT4lk5Z0FmSKtyVNl3ibAdUBPFS5xkjX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2C331700065; Fri,  8 Aug 2025 16:53:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 08 Aug 2025 22:53:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <828e73a2-23ae-442a-8d29-415a87b8ec4a@app.fastmail.com>
Subject: [GIT PULL] soc: fixes for 6.17, part 1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 038d61fd642278bab63ee8ef722c50d10ab01e8f:

  Linux 6.16 (2025-07-27 14:26:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.17-1

for you to fetch changes up to 0c952efa0d7cf5258879406077df33d23cb06d5e:

  Merge tag 'tegra-for-6.17-arm64-dt-v3' of https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into arm/fixes (2025-08-08 22:50:44 +0200)

----------------------------------------------------------------
soc: fixes for 6.17, part 1

These are a few patches to fix up bits that went missing during the
merge window: The tegra and s3c patches address trivial regressions
from conflicts, the bcm7445 makes the dt conform to the binding that
was made stricter.

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge tag 'arm-soc/for-6.16/devicetree-fixes' of https://github.com/Broadcom/stblinux into for-next
      Merge tag 'tegra-for-6.17-arm64-dt-v3' of https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into arm/fixes

Bartosz Golaszewski (1):
      ARM: s3c/gpio: complete the conversion to new GPIO value setters

Florian Fainelli (1):
      ARM: dts: broadcom: Fix bcm7445 memory controller compatible

Thierry Reding (1):
      arm64: tegra: Remove numa-node-id properties

 arch/arm/boot/dts/broadcom/bcm7445.dtsi  | 9 ++++++---
 arch/arm/mach-s3c/gpio-samsung.c         | 2 +-
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 3 ---
 3 files changed, 7 insertions(+), 7 deletions(-)

