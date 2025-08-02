Return-Path: <linux-kernel+bounces-753962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B08B18AD5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 07:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C140566905
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 05:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747B1199934;
	Sat,  2 Aug 2025 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="rc2ERQp5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O2p67z83"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148E2A59
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 05:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754113766; cv=none; b=Ywk0Je8sHc0/UfqKmKjtXWda8knNieUjt5ckcFe722MHMnz7TKGV/ocgYhlLtj04gFJwDcL3TQNTAP/rVLWbBQXHAvVIJcA55ASHgA5TIlPzZxsgoeTzKaikfNj2PUHX0lB91NU8N7QpYof/TxDBhuGvfoPGFK2np4lc2VntgDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754113766; c=relaxed/simple;
	bh=HFGBwq27ek3FDnXjZjckbNaGMLYf/xD4lmYhSblUF8I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AiExMYH7CDyGX+SwZ3IJVPQCg6yr7lsxrQCdWua9AbfnkEqXmpxdCMhzwU4a3L+b4wXn5jgARrUn6HZNhO7qkplrNWHub/fmfI+MSdkzk4ydrTP7pAx+egDNgY6hKooqxs8tfKxjSJRfd3VNZJ8J70fxeSPFCtGfHe7jgu3mCYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=rc2ERQp5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O2p67z83; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 14B261400265;
	Sat,  2 Aug 2025 01:49:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sat, 02 Aug 2025 01:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1754113762; x=1754200162; bh=dO1KBpVrxMGmS+Mb4I9Az
	t5I6h3EN/fSrL4K9sindLE=; b=rc2ERQp50s27vGzkkrJY42Zcd2VwozAdTscdk
	64RNnNO6QUS739kEycDr9NuV5pUlMR2vsmDwZ06bbfstFmV3tkM4556Ks1RCn+/i
	Eb2xluQ+Z+aYIcu1IhpRgvpvW4rNeTJcWeTrEpkpM8BiVmhQ0zMZAb+3Fk8ryKID
	HktDxv5+venGRdD6XfgzitHcaNml4r2AVCIKXAcinOD2ZVRYB8+9n5ag8o9DBynr
	g6IRYmV50B+geavIypH+f0xtKmaOUnexivE8dxdC2caMh6kPxomics+nHeQw9KIa
	NEoI241KGQqnXL8AqTz81WZeb1FwNkgKBnzN1/Qy0Cki36dmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754113762; x=
	1754200162; bh=dO1KBpVrxMGmS+Mb4I9Azt5I6h3EN/fSrL4K9sindLE=; b=O
	2p67z83SP2XC9/gYfjLtbw7ITDPfem+Fsnzv6oBn+8BgoG7AYVOzDOleeB3t6nYK
	6ltpb9DV1DFdXs9SurmlNbdgOEFdgo5BuXRJFC9FNwLSYFvijzUqQx2iM4T/2oAC
	FN61pcShA5h23vkFMGuj5KsVgOkHfq9CXyQMIGC1y6qm8M1/TWtZi4HpclFDCBZT
	QATdB8FASkgFZcAXc1bODuZ9ooAaW48ARCZQ+rhQoOW6zMUncNYbE9cPDmPhNl/D
	UZ+asAQ28EnM6lGSvmKpMy2LAwf+UgKG5IoU/2ZIMd4wHx/qeokWbaXBr1ak3D/F
	EiyVUyMqILeY1PfuhTJFQ==
X-ME-Sender: <xms:4aaNaDKcwPDHsPhAzQUkTpRstLHoa1u5a2zNH_jiUvFXTA3fvO_ohQ>
    <xme:4aaNaFG1qD7t3ROn2fWC5sef9LLe3CPak28EIaVdLYQw8-zQjbIhxFGKxNrd-elSh
    bonyvBzJSdVN5zbqA0>
X-ME-Received: <xmr:4aaNaOA62ZxElQ6aceWhXPjIh3lla2rf5uv-EYI-tU-EkiReB1ZcuEV7_2FZ47LWPxs0m-MxyQvNAln0fEz_XHz36zvRHUfD0yA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdehjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertddttd
    dvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetfeeiteefveegvd
    fggeffheetleejkeekleeugeffffdtgfdtteetkeevvddvgfenucffohhmrghinhepkhgv
    rhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhorhhvrghlughsse
    hlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigud
    efleegqdguvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghp
    thhtohepvggumhhunhgurdhrrghilhgvsehprhhothhonhhmrghilhdrtghomhdprhgtph
    htthhopegrphgrihhssehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:4aaNaA-spsJLDGliSh6KIRn8c8WJYEZBeEZpx2qudNbMIqdCOYe6GQ>
    <xmx:4aaNaCAsTiN6R-8YvXbC037j9Fjg2wpb5dLIOb4UVmlOr9b3dG3Bzw>
    <xmx:4aaNaNRY4xexM94-Fa6Jp_jRCx9R2wFCFKArgAYEARV2zud83Hzx6w>
    <xmx:4aaNaBtpO7iSUziJ0xjFemM-YFLbXsRALKyscBcBZlHWXSv4y8SDzw>
    <xmx:4qaNaH5oCq6vyg_Uk160GZuqvzkQ_sHOfNSuvO8cw_HgvLDoFEbhUNmQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Aug 2025 01:49:19 -0400 (EDT)
Date: Sat, 2 Aug 2025 14:49:17 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	edmund.raile@protonmail.com, apais@linux.microsoft.com
Subject: [GIT PULL] firewire updates for v6.17 kernel
Message-ID: <20250802054917.GA127374@workstation.local>
Mail-Followup-To: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	edmund.raile@protonmail.com, apais@linux.microsoft.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please apply the changes from FireWire subsystem to your tree.

This update completes the removal of tasklet usage from the subsystem.
The bottom halves for all 1394 OHCI DMA contexts are now handled by
standard workqueues.

Based on observations from tracepoints events added between v6.10 and
v6.11, the replacement appears to function as intended. However, an
issue remains where 'schedule()' may be invoked within an RCU read-side
critical section. A proposed fix for this issue has been submitted and is
currently under review and testing. As the fix is still recent, it has
been excluded from this PR, and will be sent after the release of
v6.17-rc1.


The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.17

for you to fetch changes up to 95a042a0c8ecd3c1e886648f6f6ab9c7e4403db9:

  firewire: ohci: reduce the size of common context structure by extracting members into AT structure (2025-07-12 21:52:16 +0900)

----------------------------------------------------------------
firewire updates for v6.17

This update replaces the remaining tasklet usage in the FireWire subsystem
with workqueue for asynchronous packet transmission. With this change,
tasklets are now fully eliminated from the subsystem.

Asynchronous packet transmission is used for serial bus topology
management as well as for the operation of the SBP-2 protocol driver
(firewire-sbp2). To ensure reliability during low-memory conditions, the
associated workqueue is created with the WQ_MEM_RECLAIM flag, allowing it
to participate in memory reclaim paths. Other attributes are aligned with
those used for isochronous packet handling, which was migrated to
workqueues in v6.12.

The workqueues are sleepable and support preemptible work items, making
them more suitable for real-time workloads that benefit from timely task
preemption at the system level.

There remains an issue where 'schedule()' may be called within an RCU
read-side critical section, due to a direct replacement of
'tasklet_disable_in_atomic()' with 'disable_work_sync()'. A proposed fix
for this has been posted[1], and is currently under review and testing.
It is expected to be sent upstream later.

 [1] https://lore.kernel.org/lkml/20250728015125.17825-1-o-takashi@sakamocchi.jp/

----------------------------------------------------------------
Takashi Sakamoto (8):
      firewire: ohci: correct code comments about bus_reset tasklet
      firewire: ohci: use from_work() macro to expand parent structure of work_struct
      firewire: core: use from_work() macro to expand parent structure of work_struct
      firewire: core: allocate workqueue for AR/AT request/response contexts
      firewire: ohci: use workqueue to handle events of AR request/response contexts
      firewire: ohci: use workqueue to handle events of AT request/response contexts
      firewire: core: minor code refactoring to localize table of gap count
      firewire: ohci: reduce the size of common context structure by extracting members into AT structure

 drivers/firewire/core-card.c        |  59 +++++++++++++++++++++++++++++++++++++++--------------------
 drivers/firewire/core-cdev.c        |   3 +--
 drivers/firewire/core-device.c      |  15 +++++----------
 drivers/firewire/core-transaction.c |   7 ++++---
 drivers/firewire/net.c              |   4 ++--
 drivers/firewire/ohci.c             | 162 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------------
 include/linux/firewire.h            |  12 ++++++++++--
 7 files changed, 146 insertions(+), 116 deletions(-)


Regards

Takashi Sakamoto

