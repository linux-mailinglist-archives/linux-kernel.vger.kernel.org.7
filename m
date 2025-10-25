Return-Path: <linux-kernel+bounces-869895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6AFC08F3F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168D93A568F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34132F49F2;
	Sat, 25 Oct 2025 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Nv4Wov5w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FPRksBb0"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CF31C862D
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761388920; cv=none; b=spABhZHO1L1ZCerzblmXiZgKKEjLZQxu072Aln9LDEAeaGkVK3s/6o+08+YaIzzJaxx9AR5SKEEJlSgv+YKIaeRG6340lTCjzUiv4SPKU/fK05frxg+pODOk+Veo82LMI0ey63v4Pw8lBvCLGbYX9vDNCOvDrXrwb/D5YXVUz58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761388920; c=relaxed/simple;
	bh=OamU/lt5toSbFx6e+TEJwLJcQHVUlleVEIxwfwt+XtI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GX82DaWF07Kemf+E+7Ex1dyVxQNepW9AKKQ8eF2SyJOWvnV+ZWxYDOf1HpdqrIMukuxptIXGRIZGEp9TMyasbryAUrF7ZCK1yRO14/n9KnXbojlwlma4r997dG6dPuHd0c2ufKCQQoxAFneq7RMRlRW8bPC9m1fbHYAQutAnlbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Nv4Wov5w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FPRksBb0; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2FDC2140010B;
	Sat, 25 Oct 2025 06:41:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sat, 25 Oct 2025 06:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1761388916; x=1761475316; bh=WQNINHc2Q8TwWbkVBwbzv
	aanh6MshyTqFyrHjqMLAAA=; b=Nv4Wov5wKXUxKxlA4duqP/05myrvEVenrSGER
	2cslKA7Bm4rab7pf3afGV80IZsgXrQ1OW+gy/s4V7cMG8J5XzF/wxgBSxkaeDL7v
	sdJLyDk7N4KLZWCXrfuTb1ONWjlB+y2Al3txd5cHcnkxdVEi1u0TT4pUoP+2I3ln
	Df8g8+lS8POg5bH8GbXB2Fwfr8M6fCqD26nhj/cYtAeHpZQLd1lpRzovPnkx6/Ii
	XWL5jpWMwTjCWX8oF9EkMH2SEHmf7C/tG6TPH4+Ai89SN4f+uToa6qrxJy2mgnlt
	9RM8hfR+YgvJVr3JargC+ciNERKMdd0dnx3fLZmk6WeofeqHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761388916; x=
	1761475316; bh=WQNINHc2Q8TwWbkVBwbzvaanh6MshyTqFyrHjqMLAAA=; b=F
	PRksBb0Tw6jYN+KjCP3XeUvp9vQnI02Qa0UeYBoh08kSXxnvobCu7gVAv5xRefrb
	B8Ag2GAKmUoyyCfiS7/K1yyUosUVcSEpajGtKPJCh/lfVJZnBDDW6YnaJXg7gRN6
	CoqVp1HR3qrS5+8pkpFJ38ZB/9RoLRbkFyxpqDW4iwHG7mqASvgIn57/XBvXM04F
	T66YlaSHNsFMRRKwx+ykDDTNsion/70lX6iGRJ65QTuo2eJblaaNqz00K4w5rtp7
	8+7G2FrF04x4ipaNlJZYete/F/u1x3PvC3fXhtYSMM47Y7EPl9wl3F/2P9U/hvyv
	MzTKEnrLU1+0B33MHw9Vw==
X-ME-Sender: <xms:c6n8aPtCmES8tkIpZd6mLFrZUXoKngNzFO1U5W2WAwBA0ERavpXxUw>
    <xme:c6n8aIOKMFOG8eSqFVuA-5Fku6tUwgc2Hf9MqfX9mxWIRuutK3LQ095OK9Q9ujURo
    bkQAOE86mg7x1K7Wk820gCnjt77FxKbP8sZKEay1CQAIrAbOEzRBAo>
X-ME-Received: <xmr:c6n8aF0nQr02SKgSIcFf-H5AmlsJw0FGao8DOKmTgGLIBsMzHxJyy_DyVRfIU5QHxHAhOamGxo8ZnYQDsJ9QRGee-88QUPVfUxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedvtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertddttd
    dvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetfeeiteefveegvd
    fggeffheetleejkeekleeugeffffdtgfdtteetkeevvddvgfenucffohhmrghinhepkhgv
    rhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhorhhvrghlughsse
    hlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigud
    efleegqdguvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvght
X-ME-Proxy: <xmx:c6n8aMPR1f77Cu3I8wkFRdwRVp0yDKCZPdSz_VmIuasjGJN1imkdvw>
    <xmx:c6n8aN2LFoOm-a-1B0fje-Vfc1_QLLYDYmSyw6LTxiYTQnPOynkYDA>
    <xmx:c6n8aLHbLAuRG9T6JFnYD9m2YBOfsb8QsUgIJM6NxIwON_uWvUR7Tg>
    <xmx:c6n8aC6ekIJEEhQ6GIaSQNCeV0JRW9l_58P2pwKgHMzlPcW-mg1EnQ>
    <xmx:dKn8aOb86HEbHQ2oeLR0QsBCghYH0P25IXpfyJoC-97aWOeF-sal4NOe>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Oct 2025 06:41:54 -0400 (EDT)
Date: Sat, 25 Oct 2025 19:41:52 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [GIT PULL] firewire fixes for v6.18-rc3
Message-ID: <20251025104152.GA501617@workstation.local>
Mail-Followup-To: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please apply the following fixes to your tree for FireWire subsystem.


The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.18-rc3

for you to fetch changes up to 73ba88fb04081372a69f0395958ac6b65d53d134:

  firewire: init_ohci1394_dma: add missing function parameter documentation (2025-10-25 08:29:56 +0900)

----------------------------------------------------------------
firewire fixes for 6.18-rc3

A small collection of FireWire fixes. This includes collections to sparse
and API documentation.

----------------------------------------------------------------
Nirbhay Sharma (1):
      firewire: init_ohci1394_dma: add missing function parameter documentation

Takashi Sakamoto (1):
      firewire: core: fix __must_hold() annotation

 drivers/firewire/core-transaction.c  |  2 +-
 drivers/firewire/init_ohci1394_dma.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)


Regards

Takashi Sakamoto

