Return-Path: <linux-kernel+bounces-785241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AB5B34802
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8022A2802
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541A130146E;
	Mon, 25 Aug 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="MWVXxX6l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eW4tXBo1"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518072FF17D;
	Mon, 25 Aug 2025 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140997; cv=none; b=c8tJF1ABd3yMDt60nQ6FbsSuxzFoemiqrrz7QIVHq7TrtvNLwAWcLV7/a5Sq9YeRJr3UTehw2Ko6xkv2UlUCZ7JiQPAyIVEi6VyruEEMcqbpuHt1LLoK/3a8LhECM32nnQKO4lOw77gWUnQy7vgDbyB72/o13f1zCf1mHVNtrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140997; c=relaxed/simple;
	bh=gbO/zfSLZKwIkdcWa8lq6pAh0F/PKrMcuam1wSYANZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsO7t7iKhDWpr1/5keO4Pcu+jLhdEEiZ6jqdFKFP4Q5qZRXkeHbECNMANC43Sqm3LVrCXmCe6SEiHlrpgQyvSM/qMrSHAmWECB+1JBoCsKWrpmMa+2Bya84FKuAYML+hR5+wg1MUU1AXHp6UHAnFp7bEM2Bx6xGMdhcRIMkQj5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=MWVXxX6l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eW4tXBo1; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 41BAE7A0149;
	Mon, 25 Aug 2025 12:56:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 25 Aug 2025 12:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756140994;
	 x=1756227394; bh=2oO4BZcpU5QLF9yoO1Z3iTLwTVA/fCrME0TR5ifc14k=; b=
	MWVXxX6lSxQ4J54jotb0smHj9qDbdNjSC6FS2eFR470drPaxdir39+ha8MSEReK1
	6D7PMcQEj5ZvSCogTiBglgrFVglV18eBWWUKuMsvODEoY/7n9tkVoElVmz/PMHWX
	JDtE+ib14s0GhFZ3vQ6hgOIoudct8B9Fvj88lCmB0x9I5TueRbVgc9cIWfqn48Bl
	54ywlKc9gdIdLvWck3lhIGX2EUKHUi5Po3H46DdHL+7fslqH9E6Tk4MkhJFfT7tD
	JFPH2gFwV/wm/G3/VcooSyg74+sx+iNYaB2RVYBvwk1BS7dfk+CzUAf9rm5xy5R4
	7l/xBoK+AuzxvhIojVTw9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756140994; x=
	1756227394; bh=2oO4BZcpU5QLF9yoO1Z3iTLwTVA/fCrME0TR5ifc14k=; b=e
	W4tXBo1QmxLm3ssGRGxy5nlugGczaTY+XiA5iupj1SMYhOHlXhsqOr7IESiVGR92
	bQjw7WrFqjHYQb0D54t134NaBONI6dMyGmMFwdl72ldU8x+9CoJnpSOKPNYS71WK
	jY47dpZ/oh7Ft1o2OKIYl1ZVu/ugQRTl2gQpd3dRVHFaVTynV67uVPvqWQ9SAKOl
	H3f7hi3G5xl6yAFc9Lvjr8/olSJGsNrb4Q/lSx87szNR7s6/wg6IpglZoTEw/f03
	LJohnxbJOSEfoyFAwap9A3ALxeWLP5AmtVGv2fD15thRgFgPvRGVuarCjxm3zEp6
	dVSrzAs10e0DMTMB0uvtQ==
X-ME-Sender: <xms:wZWsaBEWFJRr_Uj1mqVo7SU9jHd_D8-TMiUbDeQ4BkDLMXVWe55tYA>
    <xme:wZWsaNshFTwoGWo7Ai5XJsk7voTSR-dA2Ais82appNRe64ELO5n08d8wdkyRsZPls
    I8MM8S5W7qnRJCCqaE>
X-ME-Received: <xmr:wZWsaIswHLD1r0QVnvcavB1Nu3Vj71B9VhXzW1nf02kWCGPExuZP4mNCDoHlMr8D9Da_I0eeFdvoC_wx9Pj2k1TrGiUUWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforghrkhcurfgvrghrshho
    nhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtffrrg
    htthgvrhhnpeffffefudeuueduueduhfefkeeiueeihfdukeeuffekfffhheeigfehveek
    hefhhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprhgtphhtthho
    peeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnhes
    lhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhrghnshhgsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehkvggrnhdttdegkeesghhmrghilhdrtghomhdprhgtphht
    thhopehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:wZWsaDBpBYUKtOnrV8Bo6zMyq_GtECa_8llfF41nqeOLoEd0qORfBQ>
    <xmx:wZWsaKNXvqYPZ0JivKTXvej6zwhkdefaFgSU9BPZlfCrqdmRboCyNg>
    <xmx:wZWsaMyWwG2y3k-P_We1XxjLSRtup7JziN_hQcn3Z0xxrLgE5FoDXQ>
    <xmx:wZWsaKXc2ABsGYa4ufYzYmxmjczklWTJ3DJTZgGX-6uUtMtIxWvorg>
    <xmx:wpWsaCf4_n7Rs1__TNmGUA-eetWuBgnwOAV9kuJU-EU55-K00tMzbzEt>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 12:56:32 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	kean0048@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] platform/x86: think-lmi: ThinkCenter certificate
Date: Mon, 25 Aug 2025 12:03:35 -0400
Message-ID: <20250825160351.971852-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Patch series to implement certificate based authentication on
ThinkCenter platforms

Patch 1 introduce a certificate GUID structure to make it easier to
support different GUIDs for certificate authentication
Patch 2 implements the changes needed to support ThinkCenter platforms
Patch3 adds some extra error message handling as used on ThinkCenter
platforms.

Tested on M75q Gen 5

Mark Pearson (3):
  platform/x86: think-lmi: Add certificate GUID structure
  platform/x86: think-lmi: Certificate support for ThinkCenter
  platform/x86: think-lmi: Add extra TC BIOS error messages

 drivers/platform/x86/lenovo/think-lmi.c | 103 ++++++++++++++++++++----
 drivers/platform/x86/lenovo/think-lmi.h |   1 +
 2 files changed, 90 insertions(+), 14 deletions(-)

-- 
2.43.0


