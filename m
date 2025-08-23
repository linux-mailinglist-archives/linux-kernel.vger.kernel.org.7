Return-Path: <linux-kernel+bounces-782894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ABBB3268D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 05:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C996F7B6D1B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C9E220F55;
	Sat, 23 Aug 2025 03:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="BikHCDGk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bZXeJADr"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885836F305
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 03:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755918603; cv=none; b=DfmrjBznWswMDdASh6Ig70pXBLb9njtkNj3I9swQo0+ES3VCvp2+Fs6CgWOyvo5GuSysn6Gklnc94Ry3ED62a3+22r/IbLhhW3Cdgg3uElbTLZDLofIyKS6Zg9US6vmLI0prBrVH0Kz4e+UR2FFJ5kV7APlF9MHqBhE7xJmT3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755918603; c=relaxed/simple;
	bh=LkY9Tl48JIOQ1XBTplwrw0zi/VRZaRoa897q3XhKp6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sExby/8FNU+FiBChKlHT1uqRhF/7MZE03F1U+gePSxyuNSIctnPEE2YozfaUi+8nuXVd9M0ilY3DJJtYh8xceowUtJzHkUznhe+pcKiKINQXAXpaypicALjqi/LqiHTj7yIxu5oEvtmX5TfbBFqKxrD/W5zYUdphSMa6vfjnsJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=BikHCDGk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bZXeJADr; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 806C7EC00FC;
	Fri, 22 Aug 2025 23:09:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 22 Aug 2025 23:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1755918599; x=1756004999; bh=6WQuWpLN64
	nSKRPafbdR0IvhPYjUj8JZCAZ/hao9bl4=; b=BikHCDGk/ulZnGRmvVpPzRKVX2
	Tt0sxMdJ2BqlAREpprSZsiarP+j7k2J1eBKtz9HvKa9jAuyMjnVdbCyIU8pwVkfN
	+lPFyEUFeCuyWtcRQpYSRJ59t36xT8/SbBthAZAPrmNv1nt8vOB6AHHqsXnzgFqG
	FURvuCPF+XzVS/REs6LhoukLNAoJHkiLUvPrRnOC/i1+QjgJ5MPncpPVUy0FQS4t
	+ETRAPwT8qgl2D70+6++qPRgWCAzc5iFKPRRkU4o/D9hYXLuqCG0Zv8+MYVvKdsx
	JRpOtaVk/U89+2FGmj9T6sQjBYw30zeAT6FBiH4+moxakElaLWLtcI56SgCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755918599; x=1756004999; bh=6WQuWpLN64nSKRPafbdR0IvhPYjUj8JZCAZ
	/hao9bl4=; b=bZXeJADrDDhHZu3jS4Tw20MfYbRo9R2UMrgknbqAkYUYQ+RrRMh
	nxbwW6eLVCg8BucNn9AUdbeifOroDjSJyfKFYT3ZP2X/850JdO3/mxM4DVnknnG0
	rUMotR3CG5qWoGoJT1ZrlSew7HRp+s4xFAsR2HjSntuSOPw8gAz6owwLiQz6iHsX
	tAKTAhwbBoZNy5nHNhNsqcWjpWFWJqCyVs49WAKq7x2aZ755YcOqTi/GOdjd2Qro
	77l7HLoKKEjzQPq/IpxY8wjAyADTzhLlH4F+5Od8QzP2nsj2rfD+Kaix+edSDiY4
	3rlyS9griWp8dFPWEpdJGw54pXD2cvRrVpQ==
X-ME-Sender: <xms:BzGpaCxFh-Z3lKjUTDOYxmj6uyUC1vHuHRE3QTHdEiLikr8H9Ih05Q>
    <xme:BzGpaHN5FIZfr6F09F7KzkzuEHqYqfeB2a3UZIR0MNpRq80XpugpVtXPYhMjhf3fc
    C4GJJEBl_bX0188dKw>
X-ME-Received: <xmr:BzGpaGTzcMlC4spb_tPew0w2-T_LYcVtglmSR1zfOEvo7mRvMZAGB-tQXwHrXyrCblLJd5xc7I7PRHsCDo4fmSPySklQQTl-HI4olFG6oFMOiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieehheduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:BzGpaFYsiDPNv1SbO7MKO8xl_cBJJVgwWAwK5TyhNJ1Ud-e0svIJUA>
    <xmx:BzGpaD0c6m0pFBbBdI_mXTzNJUGXMCEnaKpTKe2noWybdEoOrGCvAA>
    <xmx:BzGpaFXcxkT6j40pf-LzVLC0cLioytXgEAmPng8yUdbRyjN0Wauygw>
    <xmx:BzGpaNWxxq-W8wn5LF4L93Hl1GUxvzRB2Rj4pWPxwyCPe27SrTOOaw>
    <xmx:BzGpaL2KpaqrKOcdPoUvGVOied_8-OAz7NR5aQNuT-AuwtPXLdclHiLq>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 23:09:58 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] firewire: ohci: switch to threaded IRQ handler for SelfIDComplete event
Date: Sat, 23 Aug 2025 12:09:51 +0900
Message-ID: <20250823030954.268412-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset replaces the module-local workqueue with a threaded IRQ
handler for handling the SelfIDComplete event in the 1394 OHCI PCI driver.

The SelfIDComplete event is the first step in maintaining bus topology.
It occurs after a bus reset or when the topology changes, and must be
processed outside the hard IRQ context due to the latency involved in
enumerating the SelfID sequence. Historically, this was handled by a
module-local workqueue with the WQ_MEM_RECLAIM flag. A threaded IRQ
handler offers a cleaner and more reliable solution, leveraging the
kernel's common infrastructure and eliminating the need for maintaining
a custom workqueue.

Takashi Sakamoto (3):
  firewire: ohci: move self_id_complete tracepoint after validating
    register
  firewire: ohci: use threaded IRQ handler to handle SelfIDComplete
    event
  firewire: ohci: remove module-local workqueue

 drivers/firewire/ohci.c | 61 +++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 36 deletions(-)


base-commit: 8748368c3d92f7bdef67c90d3f62ab92083b3677
-- 
2.48.1


