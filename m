Return-Path: <linux-kernel+bounces-746693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B518B12A1C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F5916CA33
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 10:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDC123C4F2;
	Sat, 26 Jul 2025 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RbVY++RX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lG10jkql"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D107141A8F
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753526239; cv=none; b=pUnlsU5UpbLP3aRL8xbE0E+OoFYjIQg6mD7BJrpCl2MKtQiAUH0BW0LaCgNLFPf+j9P9ISIMAyiospxQy6YohIzAmgqDMb+YKdz3jd+q1+nu2+tXPG2RvY+MUQPhT7w28UR5pM4oXwHFJFUSPESWPKVT6T/sIgLZl3f2GdIgca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753526239; c=relaxed/simple;
	bh=8MCddCGTksS5iRZsvioLx3Znb1q02NvkE3cJ686F5ZQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=YxaqlEfWo6k/LLPub87KXxRdENf9wQT8n6c/8brQzLZKIc5MjmGU/kil0YyaMM78yGgQ+YHgw00lhw+GWES9VFXTSgA5Tcb86jIU4W/ix//NPw+ezaYBt9lgzSTkh34gbQTXgk1zgM7qqYBlyyBXbG+KwF6Izk+msyXeTfFKqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RbVY++RX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lG10jkql; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 15AEC14001E4;
	Sat, 26 Jul 2025 06:37:17 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Sat, 26 Jul 2025 06:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1753526237; x=1753612637; bh=8M
	eKRW79IYnH4GmCMwZac8sROuaBWd8QIywAI0eiGP8=; b=RbVY++RXdJx77DF9rh
	WKMtopbEOcKoL8FuypvlkMHSla0WgzWU6ayHwavRcwdDa+ffLpD21UbmE9MXZLpc
	FjIktSrw6VNsPpP2gcNH6NcoVE7r1y8FRlZmvXcSzNIL+94atLyTQwV2swWwsaqc
	Xxqq734HVYX2HWqIGKgFCbBr9gbyvTtrOrc/HH7icWH15Evkn/u1eAnU0F2E3I0j
	rO1Yu5/qL9RAWNx+CGgSMYkOW63hkivyjx/x4iUt5gLukYptcqhDy+8xendcti66
	bBWgduBereID+MGUz0w+OTIq5gdRZ3MpzhUdCgdIlCMcb7goiAss1mt7cCdyOucC
	GqlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753526237; x=1753612637; bh=8MeKRW79IYnH4GmCMwZac8sROuaB
	Wd8QIywAI0eiGP8=; b=lG10jkql0H5b1l6254Rop4sICnkc8NFfxb1LDu0zZ/O3
	FOc/UI2sfoLgrZ9yQFKcqligkAMbUuRD/YGMlZTWvB1t5PtbsMpgx0jv2+9eH8b2
	ont6Z2Qv8+hxC36s8UtSoKn2duMMMpBqRihehLBkPc4iDDG0AeSKsafw900nYyEi
	6UA4mn1GUJjRSUr8oQz5ePOiUJkQqjONJtx4JEeAn+gOmk6Do1xlvEQZqkg1Zapz
	XuVcezxYm6cmzZP5rCI30C0zcCzN42v0nmicouCqTr7x6FP350foIT+9FoV4MCgH
	JmJ+humfXRUUYT787rE16nHJjtWRaVb9tggT4aZxiQ==
X-ME-Sender: <xms:3K-EaFdM1zXVqqDzXJOPCh0AG-fFWJpUcE9FVRDNEXwSDc9BsJAfHg>
    <xme:3K-EaDPHa3UqeBl2XRtInF25ijwH4EO0b6V2ZHIg_2TwXVSllpytfo2MeCdyov478
    1fhR-SdJk0mFV0IAW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekiedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcuuegv
    rhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpe
    duleeigeekveeugeettdejtddtleeghefhvdfhueehtefhudelffduvdeuleevteenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthht
    ohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhorhhvrghlughssehlih
    hnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhm
    qdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    hsohgtsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3K-EaBde9NHgLkQ2rhd3bfJHSoeis6eHrxjxD6BlN1BXD3hiRCyEeg>
    <xmx:3K-EaKtM20ONWgtDGVzYe4_pjOg0R9voKPogl4ocjoU9q8AwXbRaMg>
    <xmx:3K-EaA9xhmhhWv1PNLnj44eLUu2SMLISk6ZvwZqN2EDJTdJfLdG6Ew>
    <xmx:3K-EaF1au7tPFyorF1yb3uTe37M_bhynb6s_UiCkrcIc0I81t41zrA>
    <xmx:3a-EaO-KZVuyqnSLm9bQMREgIicVfYPlEc1mYgq96eE9XXwbC02B08Vo>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C9398700065; Sat, 26 Jul 2025 06:37:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Jul 2025 12:36:06 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Message-Id: <94f09700-cebd-4270-840f-219ef14bf2ee@app.fastmail.com>
Subject: [GIT PULL] soc: fixes for 6.16, part 3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.16-3

for you to fetch changes up to 912b1f2a796ec73530a709b11821cb0c249fb23e:

  arm64: dts: rockchip: Drop netdev led-triggers on NanoPi R5S (2025-07-22 22:33:36 +0200)

----------------------------------------------------------------
soc: fixes for 6.16, part 3

These are two fixes that came in late, one addresses a regression
on a rockchips based board, the other is for ensuring a consistent
dt binding for a device added in 6.16 before the incorrect one
makes it into a release.

----------------------------------------------------------------
Arnd Bergmann (1):
      Merge tag 'sunxi-fixes-for-6.16' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into arm/fixes

Chen-Yu Tsai (1):
      arm64: dts: allwinner: a523: Rename emac0 to gmac0

Diederik de Haas (1):
      arm64: dts: rockchip: Drop netdev led-triggers on NanoPi R5S

 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi          | 6 +++---
 arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts | 4 ++--
 arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts | 4 ++--
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts      | 3 ---
 4 files changed, 7 insertions(+), 10 deletions(-)

