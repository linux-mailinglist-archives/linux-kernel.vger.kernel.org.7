Return-Path: <linux-kernel+bounces-858987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8CFBEC6A5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA52421A6D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8D5283FF9;
	Sat, 18 Oct 2025 03:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="u0LLiaZr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jNua1nw8"
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF53209F5A;
	Sat, 18 Oct 2025 03:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760759740; cv=none; b=C/ZowaKDOWHgBK5w0U1YBR3tKt1x9rjlxsEcF1jj4zYcIkcGXeYYfSEoSofE8Of3E70hY7jM/KTXsVec0JgK3lKzofJvTQXJ0lYUDg4UfXVfbRDQjY50MIvJi8AmOYh+Pm7SPIqJSWH/LqBtlF5KESlcBdy0jZN7sKMAIDUaxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760759740; c=relaxed/simple;
	bh=rRJKlDURKVC29REYcxOnJWnJ1HmvYNGQdBqH38oT5zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QAds5wIISHlGXK67NJxnnK09BegNl1dvqE9+HTkbdXZOeOhfPilyT1n0d3eZqPoKhGto1+JkGC46lmzvG3rA6LhcXRH3ahZdbEIDf9vhAzc3fGaTyXl9hx/wTRXk36nmg29KTbdQ4D1yhAzppx6Peto+xSP1UeBRdTWc4WPlfiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=u0LLiaZr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jNua1nw8; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B056C7A011C;
	Fri, 17 Oct 2025 23:55:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 17 Oct 2025 23:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1760759736; x=1760846136; bh=vI3U9j0VFu
	AbqN5rE+fJwknXiqz2vQ8pUtVy5buredg=; b=u0LLiaZrM3huXszIXn8bdyCoId
	IPew8ZWgh6odijkwRm192CqTy30g8r12glmDh5E71Kw/snZhp7PSbWUaBhb+UY8Q
	3MiKkJyttAIQ6s+zU3YfcDBpEsQCbOo15vVZ6pUDc1JA7XHzBqQi135FWhhZgbKf
	0ymHRaPfMIIG6EgYKWCwVk01ZvE1ellLslEwvg1QhIq61XVEj+dr/gliReAJHIiR
	bBv11b7GNMPOjr9rGtMvdFU+XieCFhvgrTUPHPcjGkr+b+ee6lsqPWC9cEYStNcp
	TLLJChT9iw3gj4WBavvsRTi0z3ggp3BUz4+cldpScqqeTOwhizUmHez2ylEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760759736; x=1760846136; bh=vI3U9j0VFuAbqN5rE+fJwknXiqz2vQ8pUtV
	y5buredg=; b=jNua1nw8J7zjolNIVMtgCctZ9THXwezPmTEhBZyTCbigwIYZrkB
	29bJAKuJ0W0G4oq4DvdHsjl2dtg1yWHbIf/0xciIZIRU5HVw2SVibk8xzRmJ3b18
	B76diUJmHXlQCHLdjwML13sQ2l+LGTQS2GWx7pAP/y6W5IxTV1ss/lzDinaoDOCV
	o7SS7YcuS3zluLwxyXxfIPOLQJWXkhD8qrf0K74xvliv16riGp8NdbMTsPcUHRHc
	xdY8opTA4zP1ed6uIP0gFsOv3DLyjMPg40t6dm85lHGybATQRBt93Ag5MYAv8se5
	ORnST1O5IUBf8Pru7fAA1YoPpdESXrd65+g==
X-ME-Sender: <xms:uA_zaJBYHX4Dcon_xIOXF4aUPnUeMKv5pQoagaVsHyr42eg1oOitTg>
    <xme:uA_zaHqWYZ-6fUJdlOFEwsGqfsKmJ02cuhbBPTV7-mXKfSR40It_CLPOmF9xIx7i9
    RPe81A7FNbsdh0mi2DXeKtqXQpjkI0fLfZBq1oNB6CAFSrKP4vKJS0>
X-ME-Received: <xmr:uA_zaMi3CXy7-I4ymRQQwO10ipc6xFcJ4PWbPPkjJqZ3AExPpPobc4KPUVm7IbwP6wSe8oTB7J39PCOEWa3YkMaPsNN_dtK-Oc8WZ9kp_kNAFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedutddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffveekud
    fhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrg
    hmohgttghhihdrjhhppdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurhgtvg
    hfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhouhhnugesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uA_zaMCwz8pH0vhuQKJQmE3AgAvyjB-SzVn6BRGbvS0NlWtxUM3oTA>
    <xmx:uA_zaJHPJNJQEFqybFmQ4eusH4hPZD854JynpcgwTNPneNEc717cjA>
    <xmx:uA_zaMK09Hz_sfRfT5Vi2kzEJGw-IBtMPYIvus7qddWTt08ycHk_Iw>
    <xmx:uA_zaFl4sJqaPJoo68b8ItReOkA00kuqjWhYuUmrZ_LDBlkm_n_DwQ>
    <xmx:uA_zaGnFfNpd-2F75l5mXx2Vqa4nmCXPQ4SanMC8pjaceXE_3dftDBR9>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 23:55:34 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 0/4] firewire: core: handle TASCAM FW-1884/FW-1804/FW-1082 quirk
Date: Sat, 18 Oct 2025 12:55:28 +0900
Message-ID: <20251018035532.287124-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In 2003, TEAC Corporation had released FW-1884/FW-1804/FW-1082 in its
TASCAM brand. These devices are already supported by a driver in ALSA
firewire stack, but they have an interoperability issue related to
the speed of asynchronous transactions and isochronous transmissions.
When operating at the speed described in configuration ROM, they are
too lazy to respond, and eventually frozen.

The most likely cause of this issue is a mismatch in the gap count
between the initiators and receivers. Theoretically, this can be
resolved by transmitting phy configuration packets to optimize gap count.
Nevertheless, this approach has proven ineffective, suggesting that the
device firmware may contain a bug causing the issue.

From my experience, these devices operate more reliably at lower
transaction and transmission speeds, which provides a practical
mitigation.

This patch series addresses the interoperability issue. The core function
of Linux FireWire subsystem is changed to read the entire configuration
ROM at the lowest speed (S100), and to identify these devices based on its
contents. Once identified, their maximum speed is limited to S200. The
ALSA driver then performs asynchronous requests and isochronous
transmission at that speed to prevent device freezes.

Takashi Sakamoto (4):
  firewire: core: code refactoring to compute transaction speed
  firewire: core: determine transaction speed after detecting quirks
  firewire: core: handle device quirk of TASCAM FW-1884/FW-1804/FW-1082
  ALSA: firewire-tascam: reserve resources for transferred isochronous
    packets at S400

 drivers/firewire/core-device.c        | 86 +++++++++++++++------------
 include/linux/firewire.h              |  3 +
 sound/firewire/tascam/tascam-stream.c | 21 +++----
 3 files changed, 63 insertions(+), 47 deletions(-)


base-commit: 15f9610fc96ac6fd2844e63f7bf5a0b08e1c31c8
-- 
2.51.0


