Return-Path: <linux-kernel+bounces-836345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04670BA965C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F103A9110
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3031FBC91;
	Mon, 29 Sep 2025 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ZLg/f5bi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uu2iMx7X"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBA02AD24
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759153611; cv=none; b=oD5mOnoHcqrRPScZOPCdE1WpWFMWZraFhJipBYVf7TKvMTOmxccxu9L4dXxhaBA1se1jtPKogYRL/SP99yJ4iYeaCf4iAkm5O5OPtledyFjoOXiq0Xkiclm5CLmQqkMkORgmSWKOm26jJa6T/60GcCPPVnkQZbtFlTcmtmXHtAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759153611; c=relaxed/simple;
	bh=cEUmmAPKqmvDk/g4ktGYVigxucz+ZampVI1F4ms6JZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tcO7rWePImd66ju+0gCcRsAcV9fbO+Bqm6w63YYGuQceIwH8HPHuQNWIlUzdCY8fnroFfuNL+XXPrH9DAbpxmS1fIKAXasuLDFj5gf4V2uSnk/+bmOMPP5plBfxMKn7PadjAe0yr2mGBFvsMSv3nQqXCCu6PJoDmWlHH8pZct7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ZLg/f5bi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uu2iMx7X; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 203BF1D00018;
	Mon, 29 Sep 2025 09:46:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 29 Sep 2025 09:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1759153606; x=1759240006; bh=VtDAfbV6Oj0/9M1Wdg+zZ
	FLDn3mMhqZRbW/dQ4BuuTo=; b=ZLg/f5bipnef+4g8NsMJmsFuT3xyB6NSyk9DW
	dFxXs+sFYuS1YPZcTpbYAvRGDfNzjaBGhG3Yyy1lJA86b8Qo9xSQGW6Vuy/IXblp
	jzkijM88o4lJhgG4kNGr032kwGq79w3iykQh+RtdkE+pC+QUmyg7zAc6ieVYH52y
	D2f5VxsEUUwtmwy6wMT3G8lZ+Paomn6Y95q2uS6ptmJ+vFOPpADUKcDzhdjSTj4h
	sDCDdZmx2w0klR/S50sLuCDz22YFk924lVa+hmEbvuxnBbNq5Lyr9ulZxGxXwtx+
	BhL/sEJEbGIolj2/XZQ8QsXFdd1l6lswnBdTsucDuXAIYQCAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759153606; x=
	1759240006; bh=VtDAfbV6Oj0/9M1Wdg+zZFLDn3mMhqZRbW/dQ4BuuTo=; b=U
	u2iMx7XQjNslCVFYCdBuU4xo8IKXC31FeMRTPqBdIpNBpOyUhYy+SFDNujw/F8kn
	OKJXGnpjkc4J8gKgRvwPGE5mlBbCMKTQM30Ct/49ZQ88bUhUAjlRDMM5meZnhQhk
	nZEd28oGpE9aGoJEMYDhM7OeDg7ZkWizdakRkJ8dJBGSQRox79HQfL/e8m0X33q9
	kJjx8aUqlOarul7tF1QcgGLl8meQZgkvJMHqXuBCVUqn4TYOAPMUH2Zl6rhGGsVn
	Iu5L8caGY0NSUJInQ+vAeyUImOAvcuq31fvg7jDCv537QZ4/472OD1MvgW/9YRgr
	33Az0rY1+WrgfwwsgYlRw==
X-ME-Sender: <xms:xo3aaLmHJ7mF_6DLuBbQ2lMxvrNgzYdDkUKREQkVSmTm5ilvOvYRQw>
    <xme:xo3aaGmDG89YOZaL_pPYW-R3vALq_3zhLVuHDFrBBoFGOSdFtFA_ZKXqPzv-FPlaF
    98tiR4WJY8djjRiW4ODyBZU6pob_c6EFqTNNDzixjpGfCXqRK_huA92>
X-ME-Received: <xmr:xo3aaEvF9IOMTOAGCgI8Tph803Oa0f4uM7oCxujX0RLnAzFoOv0tHV20NI8TGLgUJgIb_RsXkj8cAoVpSLQTGpeRuWdyqsBYcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejkedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtredttddtvd
    enucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihes
    shgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepteefieetfeevgedvgf
    egffehteeljeekkeelueegfffftdfgtdetteekvedvvdfgnecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhrvhgrlhgusheslh
    hinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidufe
    elgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvth
X-ME-Proxy: <xmx:xo3aaBnkLg6pII-KmrHlD4wpNYnCOjajmcalF96fodj63l3kcURIHQ>
    <xmx:xo3aaHuexI0vDQu2XBDU56DDxKNuxHnGS12bgwZ8gE3952wc2_FNjA>
    <xmx:xo3aaPe8rCnEurDd95p-pVZfx3HrRC0Hbp8fR_aEVZfEv8FbQ8Vn0A>
    <xmx:xo3aaPxs8MONidhDQ9QcjYteUkMLC8MQuwsFuWcaFviwRP4kCRntyQ>
    <xmx:xo3aaGNtptQRmwiNA_WVgBnpx_DcJzZVP0Y9_At0r_TFMEZIUaQ_5MW->
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 09:46:45 -0400 (EDT)
Date: Mon, 29 Sep 2025 22:46:42 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [GIT PULL] firewire updates for v6.18 kernel
Message-ID: <20250929134642.GA748211@workstation.local>
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

Please accept the changes for FireWire subsystem to your tree.

This update may appear to include many changes, but most of them are
code refactoring. Except for the removal of firewire-ohci module
parameter, there are only a few notable changes.


The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.18

for you to fetch changes up to 40d4c761200b796a44bf2c7675ae09c87b17d4af:

  firewire: core: fix undefined reference error in ARM EABI (2025-09-28 10:20:30 +0900)

----------------------------------------------------------------
firewire updates for v6.18

This update includes the following changes:

- Removal of the deprecated debug parameter from firewire-ohci module
- Replacement of the module-local workqueue in 1394 OHCI PCI driver with
  a companion IRQ thread
- Refactoring of bus management code
- Additional minor code cleanup

The existing tracepoints serve as an alternative to the removed debug
parameter. The use of IRQ thread is experimental, as it handles 1394 OHCI
SelfIDComplete event only. It may be replaced in the future releases with
another approach; e.g. by providing workqueue from core functionality

----------------------------------------------------------------
Takashi Sakamoto (42):
      firewire: ohci: remove obsolete debug logging for IRQ events
      firewire: ohci: remove obsolete debug logging for selfID sequence
      firewire: ohci: remove obsolete debug logging for AT/AR results
      firewire: ohci: remove obsolete module-level debug parameter
      firewire: ohci: move self_id_complete tracepoint after validating register
      firewire: ohci: use threaded IRQ handler to handle SelfIDComplete event
      firewire: ohci: remove module-local workqueue
      firewire: ohci: use kcalloc() variant for array allocation
      firewire: core: utilize cleanup function to release workqueue in error path
      firewire: ohci: use return value from fw_node_get()
      firewire: core: add helper functions to access to fw_device data in fw_node structure
      firewire: core: use cleanup function in bm_work
      firewire: ohci: localize transaction data and rcode per condition branch
      firewire: core: code refactoring to evaluate transaction result to CSR_BUS_MANAGER_ID
      firewire: core: refer fw_card member to initiate bus reset under acquiring lock
      firewire: core: code refactoring to detect both IEEE 1394:1995 IRM and Canon MV5i
      firewire: core: code refactoring to investigate root node for bus manager
      firewire: core: code refactoring whether root node is cycle master capable
      firewire: core: remove useless lockdep_assert_held()
      firewire: core: use macro expression for gap count mismatch
      firewire: core: use macro expression for not-registered state of BUS_MANAGER_ID
      firewire: core: use helper macros instead of direct access to HZ
      firewire: core: use helper macro to compare against current jiffies
      firewire: core: use scoped_guard() to manage critical section to update topology
      firewire: core: maintain phy packet receivers locally in cdev layer
      firewire: core: use spin lock specific to topology map
      firewire: core: use spin lock specific to transaction
      firewire: core: use spin lock specific to timer for split transaction
      firewire: core: annotate fw_destroy_nodes with must-hold-lock
      firewire: core: schedule bm_work item outside of spin lock
      firewire: core: disable bus management work temporarily during updating topology
      firewire: core: shrink critical section of fw_card spinlock in bm_work
      firewire: core: remove useless generation check
      firewire: core: use switch statement to evaluate transaction result to CSR_BUS_MANAGER_ID
      firewire: core: code refactoring for the case of generation mismatch
      firewire: core: code refactoring to split contention procedure for bus manager
      firewire: core; eliminate pick_me goto label
      firewire: core: minor code refactoring to delete useless local variable
      firewire: core: suppress overflow warning when computing jiffies from isochronous cycle
      Revert "firewire: core: shrink critical section of fw_card spinlock in bm_work"
      Revert "firewire: core: disable bus management work temporarily during updating topology"
      firewire: core: fix undefined reference error in ARM EABI

Thorsten Blum (1):
      firewire: core: use struct_size and flex_array_size in ioctl_add_descriptor

 drivers/firewire/core-card.c        | 490 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------------------------------------------
 drivers/firewire/core-cdev.c        |  36 ++++++++++-----
 drivers/firewire/core-device.c      |  27 ++++++-----
 drivers/firewire/core-topology.c    |  91 +++++++++++++++++++------------------
 drivers/firewire/core-transaction.c | 130 ++++++++++++++++++++++++++++++++++-------------------
 drivers/firewire/core.h             |  22 ++++++++-
 drivers/firewire/ohci.c             | 316 +++++++++++++++++++-------------------------------------------------------------------------------------------------------------
 include/linux/firewire.h            |  33 +++++++++-----
 8 files changed, 518 insertions(+), 627 deletions(-)


Regards

Takashi Sakamoto

