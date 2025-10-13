Return-Path: <linux-kernel+bounces-850624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C6EBD3530
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0614D3487CD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B72580F2;
	Mon, 13 Oct 2025 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="kRJXpFJd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E7fT/E+i"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6468823AE9B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364199; cv=none; b=YUh6UVhbIb6hgi1uIL1AfjRovyZSz/jz3cLRWaJAA5QXifGDA2E4ipEizq/bgIrQMlUXFjAhw1WEe6BjkvOC+wtRVzjljf/2NnbnyeDwVKO9WsdiRy1o9In1VVXEnc7aBMewrE6ChBExAHVPXeLLKMxrY+iga9WvZGD8XuyRe4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364199; c=relaxed/simple;
	bh=qFNp5MB6DWbZbp8cEbmqyi11ic80zgN1H85m+AaUgkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/5CmtS3OXg1uPShcUjIRZbAcgYGceCw60YFhJnylOb5WxyRohxsfwrmW7WD7qkJXmo2lbHy5zX4zto087qzps5R/cWiU4D9O5O2h9BoZuJaZ5/nQl11dP2p3FuYR5iKpqPssNSpEag4ILXbtWd/uWC15H4dljrcn+6Q7R6zKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=kRJXpFJd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E7fT/E+i; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A6887A0101;
	Mon, 13 Oct 2025 10:03:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 13 Oct 2025 10:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1760364195; x=1760450595; bh=0v5l7tGijz
	2EfG0QG368LVGN6Z2/AIGcrEg8hzXalO8=; b=kRJXpFJdRrcmcQwBgL9hpXxwtJ
	mavohww4QN0z57tdq8T6mTmyceZjnUPw9lz5iqYTq5BK21D2qWsoSHQMX+Qv1mTB
	CCo1VeXBV83Tk3MqXMjTSbtqXpPFizHoVfvuiUd3pXscycF6hEBgD9DaA2Pk0oAE
	iLeVddqV6hdXAS8EghpRkGuuqJvA1c8qu/L6RcvDSNm44NpeynNq6PeY0bT0Ovuf
	oNsvOWcC55CQZh0H6x4DMiFCRue2rY54RNabcUuc0d0GcVvyOOMJB6jRlds7EPk6
	bkurFUOph7/50y3IWSwk2vBtO67sXgW/JwVaYVT6lhqDJ5nQI1nyriktqo8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760364195; x=1760450595; bh=0v5l7tGijz2EfG0QG368LVGN6Z2/AIGcrEg
	8hzXalO8=; b=E7fT/E+izu+Rvy/D+jWYy7nNxqfQCRe9zaBWIx9o1LYtg4Z0VmX
	obm129WENgXraiTPrVHR53Ipwy2hHLufm5yqkaVbCy0SBdv+aUPz/sJ4dSg7Nx3q
	AYo3KvOf9dRD7dMDMtx3+DnV4FgeuHaRrYWO059ekZnWTUxv4fCNgaaMuaUkSGfm
	1mzKzLHOZ0JPSEDGeilHCnYn3/KQVu9HjwCZzG/TGyx/aClPYw81RHGlo0hlWf3Q
	XqF/CHQT2OyTiyaAqedMQWIVbdvcGBW4MZ5mhCYDumtmxPws28lKzpucvT5NPFg2
	3W+XaX/5Q5zK31CWUXkEftMuIUREKikL7dw==
X-ME-Sender: <xms:ogbtaABaJh18La4CwcGruwgNqQ6DPGjoGbX_RQA-OE6SJbyxQRDHYw>
    <xme:ogbtaAebCv6xguAVecyzQeny4a76N9PnXJMDmElexGZzUhbeJx7M7xajF4eLEw1oi
    evAquiuH74slv8WQND16ePLb7NFHEdyeywK6nt4iHAInve1KhUoRsQ>
X-ME-Received: <xmr:ogbtaLLJBpj19TC-Ddna2OOlSQvClSqmjrRdbxVK6AoahIuIsZMROs0CqM5IUIJ22UEd2vwn9_SJmbAzXj34EH4jO9KY5iuc3iv7JC4U35VmPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudejkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffveekud
    fhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrg
    hmohgttghhihdrjhhppdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurhgtvg
    hfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:owbtaDe4yb0af412onUTiB7nJbCqoeZOsQhSbcfs3v7r28vEiOOmBQ>
    <xmx:owbtaC2MrWq8qjJd-VG8mIYNFRe2cuRlCAXyjUgSoT82jQTnnBz1Tw>
    <xmx:owbtaMgUI0lrAv3vLzzgnNYwPcyKqMYbnlBI4zHL9uLHtSUYzNpeHw>
    <xmx:owbtaISReXUczATcNNF9ZkpRH6SPJczw2WUidF1h5oF9WfLzMez1qA>
    <xmx:owbtaJ2igtKSQvjhL0e0gyyjRyrFFxeanMRO2ubDTqoWzvzBtGb-eJUm>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 10:03:14 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] firewire: core: add device quirk detection
Date: Mon, 13 Oct 2025 23:03:09 +0900
Message-ID: <20251013140311.97159-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In the history of this subsystem, we have experienced some device-specific
quirks. For example:

* afa1282a35d3 ("firewire: core: check for 1394a compliant IRM, fix inaccessibility of Sony camcorder").
* a509e43ff338 ("firewire: core: fix unstable I/O with Canon camcorder").
* 3a93d082bacf ("ALSA: firewire-motu: add support for MOTU Audio Express")

However, there is no common mechanism to handle such quirks. This patchset
adds a consistent approach for detecting and managing device-specific
quirks within the subsystem.

Takashi Sakamoto (2):
  firewire: core: detect device quirk when reading configuration ROM
  firewire: core: handle device quirk of MOTu Audio Express

 drivers/firewire/core-card.c   | 21 +++------
 drivers/firewire/core-device.c | 78 +++++++++++++++++++++++++++++++++-
 drivers/firewire/ohci.c        | 29 +++++++++++++
 include/linux/firewire.h       | 14 ++++++
 4 files changed, 126 insertions(+), 16 deletions(-)


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.51.0


