Return-Path: <linux-kernel+bounces-825952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C38B8D308
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 03:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26AF4189E3B5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 01:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666431494C3;
	Sun, 21 Sep 2025 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="BzuLLFxp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UxZGmyfU"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C1FB672
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758417781; cv=none; b=XGsNJ7AWwSOg4gOKEHWbsYKUCgaZB+3C0MLnzYOEkwJNFrxW7Zz/5fCQ7m4wu39v0RZ9VK4M2wHtCflnyB5EgNS9jpiigrEJ796pKKlmGOPmLvvSsZy4GlDy6JU1tlUnmUlEX43f2XzeYYn6kaPF8Za9tXcJnLQ0J2ziZZ6hQMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758417781; c=relaxed/simple;
	bh=iv//UmIpnsBvuA1g9Ch9Lm9JPxC36uQm1KwmliFRurg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cLDNNaHX6kXMIFEGHUpNziF+LaXmUqg1IrZVOZIOSQtuoCArHlVkUZAfz8m2O7h5yMpZ7r6j8CZS/iYXM3+8gIjdyoJxc3F1WfX3pShF6NpLJzD5/qgmWEGB+AoSMKkNMGUgvuiPXOJGo0fzfrkpCp1K/dYpiQeunmcO6e7quXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=BzuLLFxp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UxZGmyfU; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 5DCD11D0012B;
	Sat, 20 Sep 2025 21:22:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 20 Sep 2025 21:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1758417778; x=1758504178; bh=/TAFCTU731s4phS0aGzHF
	MTzvWaEIJwXNgmuW3iqYcQ=; b=BzuLLFxp70OFjqPGIEXrbAh8vXBaKT7dElBAE
	yB9ulbqgcfQlGRYW4Pejske0PuUHUZ0wyQqcwqIVDTu8PJRFvCWAHtV+g+hxOn8Y
	maW2f8d5xkoespztAMFeB2DX4p2+DKfRWPFggkaZG65wfpgtk1m+86YenP4ETLV6
	KOy5b/Q4KtupvODVgyPxbip0OkyLQdRVfPg7yCPTHAyD5pm8J7BweI7tzJFoDJmM
	WdEYzVUoE0YgxfuaxsHY0TD/yDS5GYdzJxqSXAswqbouScGZqFy6lBEczIfYKSbK
	NiIvo4KNBbKvcyL+Ss+1GtyHX4RH4Qh9TPxawb6iBgNC1rhkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758417778; x=
	1758504178; bh=/TAFCTU731s4phS0aGzHFMTzvWaEIJwXNgmuW3iqYcQ=; b=U
	xZGmyfULjpzPUvXp4Z1L149wHkZ6jHnUyK5ogTOaz/S15jLEsExpI5Pv/Ge2JfNM
	qW+cv93WAGBPCQ5rZ6nPrj+3MvNN0bhN41u+wj76pS5nX4oZmxM/L39ZCVerD524
	6/pXozclqi6rdcdXc+oqPipr569j5Vl2NaREeBABYUt9Noa1BIpkO+LDtVUsbi2o
	fhHnGAkQZ2BafBxM9GGKZP5vlP6PvC4c3hSh4thgHAPcLuwx4WwFPqHegypTzvSu
	yJfz1EvkYAW6MbSd/TwW/bV3NTXvZrFfesDBprc+ZGzDfubw3RvzgUnOAVOq3WVB
	dvA6d5diTvPNusQ3HUAqQ==
X-ME-Sender: <xms:clPPaGKfi2du7-gKbQOaFtWVMBwgYyFNlPZBJmbR-JXr2awh4t6Axg>
    <xme:clPPaFBkXtwYm_YAohRIojK11qg6gR8YZh1A2_nqzQNuw5k9HMaDnUwGMu5izNdQZ
    8bQNhWdG1nqJU84oAQ>
X-ME-Received: <xmr:clPPaDoXooa4uPrnZfUL7T1sGsvbO66sjO_EbtYpSDmgnmtAyNHz50T2W8xzkwsIEqb1yipZ306qEaY7unP03n9WHNptWQ1px_6j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehfeeigecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:clPPaIgJLRdzdn24wkOrci_-CcHu5q5_Lmu48LmJVOR3a2zGmfP1aA>
    <xmx:clPPaID_S3HqEO4cNEdMw1JSm90o3LuG_1-xRSg5ZHSvvx4EWMHzQw>
    <xmx:clPPaFHX0nxfmza2GubeZMUcrJ5mjqlXT8BomI7SkPiq_5GaYNfO1Q>
    <xmx:clPPaIKBBCkEvJEhswM7M8hzGvqthT4nuXhZgsGXTWXR5HljEUgyEQ>
    <xmx:clPPaP_z5gDAH-Ba4kHqy_tYhvcKO6EmNMv1NrDLDxwER-YCiWVMw19U>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Sep 2025 21:22:56 -0400 (EDT)
Date: Sun, 21 Sep 2025 10:22:55 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [GIT PULL] firewire fixes for v6.17-rc7
Message-ID: <20250921012255.GA49526@workstation.local>
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

Please accept a single patch from FireWire subsystem to your tree. It
includes a fix to enable  userspace applications to recognize the
functions added in v6.5 kernel as available. This change should also be
applied to existing stable and longterm releases.

The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.17-rc7

for you to fetch changes up to 853a57ba263adfecf4430b936d6862bc475b4bb5:

  firewire: core: fix overlooked update of subsystem ABI version (2025-09-20 12:17:50 +0900)

----------------------------------------------------------------
firewire fixes for v6.17-rc7

When new structures and events were added to UAPI in v6.5 kernel, the
required update to the subsystem ABI version returned to userspace client
was overlooked. The version is now updated.

----------------------------------------------------------------
Takashi Sakamoto (1):
      firewire: core: fix overlooked update of subsystem ABI version

 drivers/firewire/core-cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


Thanks

Takashi Sakamoto

