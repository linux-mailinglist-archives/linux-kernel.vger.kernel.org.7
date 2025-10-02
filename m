Return-Path: <linux-kernel+bounces-840848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2778FBB58D7
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 00:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAD134E4278
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 22:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A7D27B35D;
	Thu,  2 Oct 2025 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fOpDeJPM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WBmOKvJ7"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E8846F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445090; cv=none; b=DyApF+Wub/Eqt8UZ7GRjPngXB90ZhO9t7j2IJzd5/t1Wi9bGn0BNEJe6w6sBjS4ssm31WDfQv/eLdSLrVmZvbw50LM1ES3SLPlMxqsslieO59uWiVYg+MCCWD/hWtGx1PjHkLWRCZqxi3P/NenV00jAp/PSW7KRASXySmdi65V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445090; c=relaxed/simple;
	bh=MpznCzUNU/M2yGcJDWDORNDm9k0EdhMFQ0uW/2x9Ex4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=qmTktHTQ/704hUqdIrZvzurms0am9Shu5qidimClTuiXI/CICUTEFjbdVNH3UA4OLPtjUjkIdUfvY2Y/5VEdWfXcqsiSuy/dljt4UR/GVBIfpkVaYxC8XEDahc2aMxwY8nl0GiBTksszpxRn7PHHZcOxdksXKd98QrzY5LNuc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fOpDeJPM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WBmOKvJ7; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 34F247A006D;
	Thu,  2 Oct 2025 18:44:48 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 02 Oct 2025 18:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1759445088; x=1759531488; bh=eT
	eoUMIRLDbBktgpxFyGT2F1dKdq/G/dsQMMuTFQPm8=; b=fOpDeJPM90LWGxXsRj
	5j7sLOGCU8wKAox8fuQG7IPoWwoiEPSm/NONJwY0HTkZff2L5EcVafRAmFi5cDZc
	pjkBTAC5W4bFBmtd8MXZrS2++FNX/nexOE9lDZBRxXc6Z7AGjbAY03cMKvcs7kZ1
	9QpmJGo7ZJUn/HJKIg6oelt3a3ILGEcykvtvO3dbHmDM+fjyJjGV8mLeolwjIuYw
	bLvQm+BtKh+kwhutOPf7BmLjcB3k+yyNeSyWkPh4epEbsQcdgFewckGI91BHNt/z
	c4h8RAIz9ZvhsejG1aWtZcTh6TD0Q+P3wDuMmdk2L0gCRhFI945AdJUMT6fIMPr8
	w8Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759445088; x=1759531488; bh=eTeoUMIRLDbBktgpxFyGT2F1dKdq
	/G/dsQMMuTFQPm8=; b=WBmOKvJ7ALBV0tX1Xv2QQmFvy01e8wgZ9EuSio8q1RyX
	jzyzi7gXm592fsLM75I6wG9GsUtX2r9DRkfzMnuOzOWszrfk0ZACSfpxvYLM4n6e
	bgndCfZgiSJvWDCj857qL9yMOIKkWfZbukFmx7AIjYY5EJCzCtW59YxGuQYJtM/e
	q32svAgoEvnjKMt525HN0te0H8xkuVWJkEVhoxQ/uM3q4B88nhsUS7/YH3OBYPwd
	cj1X/eiEuiGvbHzovZPUwC/u/p7+80UnZtbWdMuasgMv2bjXpBVRZOt6HViQ9NJp
	3c93tTxSB9baTpEGZ+IoAB0U9SnOtkSSZBjY8KHW7w==
X-ME-Sender: <xms:XwDfaOn9pVkv6RMzMNSBVPB7zWGdC4WLdtiz8YkuBjLCahNDbWHVSg>
    <xme:XwDfaApGJ0of6COO2bUmupStLapYNIPW0po9j-JoDGHk5cFqKKw2jjx7gkAIrQeJX
    k9QRRtIA-xoNY7rAoHR5hludytCth7jfdAxH9b-pP82dBre-DBeVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekjedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcuuegv
    rhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpe
    duleeigeekveeugeettdejtddtleeghefhvdfhueehtefhudelffduvdeuleevteenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthht
    ohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhriihksehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhi
    ohhnrdhorhhgpdhrtghpthhtohepshhotgeslhhishhtshdrlhhinhhugidruggvvhdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XwDfaJuuOrK9OMcGlcIs67TCY4E_heIFD2CaJg6n56R2BbDkL2FdzQ>
    <xmx:XwDfaN7nVUsgITbiyTfaXunVtEBgikrANuqj8p6MxZPZ0BFU9AVvQw>
    <xmx:XwDfaARBeA5KtPMbIMIEq0v2q7ROdhbPLXcKKyw41xE2072lFb4Big>
    <xmx:XwDfaEoterbZA_wqkURSqtk2oSfF7t94LCuuL6STbFbBjXyFtA44nA>
    <xmx:YADfaK6JGpFhlqDaLrCuxh1PI3YogFHgzfAg51uW4ge1hZAAtMQR659U>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B019D700065; Thu,  2 Oct 2025 18:44:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A8Lgby3dhPuR
Date: Fri, 03 Oct 2025 00:43:59 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Krzysztof Kozlowski" <krzk@kernel.org>
Message-Id: <417683c6-434e-4ae3-b361-cdf25e01d943@app.fastmail.com>
Subject: [GIT PULL] soc: build fix for 6.18
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.18

for you to fetch changes up to 91f98de42310c70f9a23595b3b20aa305717d955:

  dt-bindings: clock: Add ARTPEC-8 clock controller (2025-08-31 15:22:10 +0200)

----------------------------------------------------------------
soc: build fix for 6.18

One commit for the dt bindings was missing from the dt branch, this
one is already pending in the clk tree that contains the corresponding
device driver.

----------------------------------------------------------------

Linus, please either take this one if the build breakage keeps
bothering you, or wait for the common-clk tree pull request that
contains the same 91f98de42310 commit.

Sorry for missing the obvious build failure.

Hakyeong Kim (1):
      dt-bindings: clock: Add ARTPEC-8 clock controller

 .../bindings/clock/axis,artpec8-clock.yaml         | 213 +++++++++++++++++++++
 include/dt-bindings/clock/axis,artpec8-clk.h       | 169 ++++++++++++++++
 2 files changed, 382 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/axis,artpec8-clock.yaml
 create mode 100644 include/dt-bindings/clock/axis,artpec8-clk.h

