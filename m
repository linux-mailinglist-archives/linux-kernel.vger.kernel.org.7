Return-Path: <linux-kernel+bounces-754411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B56B193FF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEF91895861
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 12:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D82B259C98;
	Sun,  3 Aug 2025 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="q3a4iBo3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BfPlSP9I"
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCD6221280
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754223624; cv=none; b=eE9peUbeW8kB1knGEDUu1KTSHNhncnKSlTOYE2/ANlVMKoO+HdTHa6x0LUE10KahXd9cEhNbMtwdwf7szlzx4YMO/mKp3ZEaHd+MhTeyLLiBI6XspiLngyTy8pLBVMm7WOpT7GgNUOwAcTgfQYbj5dsWxy9djQmSj5iVbg9NS/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754223624; c=relaxed/simple;
	bh=xnqTW00f/pTbVBz8AriC6QPMU0M+LRlehseaLTu/tLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JnlgTF24p9mm1Vw76yhJE4UxbAogTmMFBRVRjMPY12V8sQEnzFzzhAcR7fVG5oC82qpu1ibUKDUnDVzh4/NUYpFPO+fNTfoXKAcLr6rM1LvDRzd+wLX3hoQctlbXlJh6uLGxYoDMpCqXiTRTU0uTb941GL1FaAxd9x1UifsL7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=q3a4iBo3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BfPlSP9I; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 74F0F7A0053;
	Sun,  3 Aug 2025 08:20:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 03 Aug 2025 08:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1754223620; x=1754310020; bh=82arPFn44b
	Fux6dZl+ncEfdiZPcXgbDKmVNiH8NTCo8=; b=q3a4iBo3D6NMMW5ZpqEBVuJ1kU
	oMSfrx3ysT3uzq9WNp1DkHg9Qb7ZOwmwjHO5uI902Ri1zuzKpnMPCx3fT4v6qKYw
	SEOdT0+7iXFjI9S5MefeMIzUdTIhLLUfDeqX50QQviXFhf+uC4UdUP+fKKriXfL7
	cwZQaD4YGKXb1EEtFumiXYApOR0AomA/8mumdVBuOxFtheGnp4JkWMfmP/rrP5zZ
	VlrZekyqUb2vbH5yjwpAWAtJKj40/OogmkJqQGiRdR9K86ZTTwbRage1EmuRYr2C
	lFsaNWSaovEIQ4+Z0zNykW/HZCjnxGXbYyh8QC/EjnP5EgQzeRGUDPqw8sjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754223620; x=1754310020; bh=82arPFn44bFux6dZl+ncEfdiZPcXgbDKmVN
	iH8NTCo8=; b=BfPlSP9IrB7A/S+gA77j6LkzIOmt5xx7LdLvKAv7/g17KuFtKhc
	S5LXkSs4n+YmrcOCpYJbAZv8wEbfDYCPnTlRWR3BhX0ZNUvMKsgbgFgORKq+LgIp
	IEC4HF1zf3aiWFISR9QzhtzwpRIp8XZW6MXD0BmxI97dONVYlzrOdvO/J7A93wXE
	dUx8NjKF4JsRTNUkfexYguXeHK4Zo3HPNZuIYkJ/56M7rYzHJkBub3KkicHoi88m
	MZcwGxotpUpmYOmKjpe1f3Chd31Buhj8SNX56wc/gV/G7ABH3ErpzJ8IL92Uc8BI
	xNYDxwZdF37Bl9Fk50sZcwi5ecU7UZndLJg==
X-ME-Sender: <xms:BFSPaPegtwT-rfseVz1mrRi5stgLl_0SN44xsU7cLcXnnb_h2FIDJg>
    <xme:BFSPaOLwR3xRaSbygRYnsBKLgkPQ_JDNPHM8y1uetmT7nIQEeybWrK57y2XSSeQmx
    JoGwxWSJhSQggKA7VY>
X-ME-Received: <xmr:BFSPaKeH_DYTALgSshNiLVImMZMWruPIjN6nEaHJZKWVi6HO3K02IKVIx91TjqbPDqN7g_4ZOmBARgZosU6sAKX72VkbMMW87U0yYDvst2Mb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdelgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeggfehleehjeeile
    ehveefkefhtdeffedtfeeghfekffetudevjeegkeevhfdvueenucffohhmrghinhepkhgv
    rhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidufeelge
    dquggvvhgvlheslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BFSPaN1-7gZJiZrEfuQcpvQYjTbYQJQJRAD4V95lmnzNn7ri9_kD2Q>
    <xmx:BFSPaLiJFIXe6ZFT4vWUE9ldXMXtw51O5P0pvGVENr1-4NvWlxy8wA>
    <xmx:BFSPaLT7l9dF2_JVqCppkazHq9G-X36IERU8D4w3NuQlyQG3xgGHOg>
    <xmx:BFSPaEhnlGIpvJAjliLJOUFTPGjMGNgglp2S3NErooQOnW5evBk8kw>
    <xmx:BFSPaCDzZfmb33KwVtSb1xUit9X8kt97Wja93HV_LPuLm3zmZARTfwNj>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 08:20:19 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] firewire: core: call address handlers ouside RCU read-side critical section
Date: Sun,  3 Aug 2025 21:20:11 +0900
Message-ID: <20250803122015.236493-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is an updated version of my previous patchset[1].

In the earlier version, XArray was used to collect FCP address handlers.
However, in typical system, only a few handlers are registered, and
using XArray for this purpose was unnecessarily complex and inefficient.
A simpler and faster approach is more appropriate here.

In this v2 patchset, the kernel stack is used initially to store up to 4
handlers. If more than 4 handlers are registered in the system, a buffer
is dynamically allocated from the kernel heap.

[1] https://lore.kernel.org/lkml/20250728015125.17825-1-o-takashi@sakamocchi.jp/

Takashi Sakamoto (4):
  firewire: core: use reference counting to invoke address handlers
    safely
  firewire: core: call handler for exclusive regions outside RCU
    read-side critical section
  firewire: core: call FCP address handlers outside RCU read-side
    critical section
  firewire: core: reallocate buffer for FCP address handlers when more
    than 4 are registered

 drivers/firewire/core-transaction.c | 91 +++++++++++++++++++++++++----
 include/linux/firewire.h            |  4 ++
 2 files changed, 85 insertions(+), 10 deletions(-)


base-commit: 7061835997daba9e73c723c85bd70bc4c44aef77
-- 
2.48.1


