Return-Path: <linux-kernel+bounces-769966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F0FB2756B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A981175BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993CB29A33E;
	Fri, 15 Aug 2025 02:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="qUpvBFj7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SQgHu6lg"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADE729A323
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755223530; cv=none; b=XsJ0fU9011W6fyvhWaldxetymgbMdl8PUP+nnjjOYw9w6uK4qd1PbLJWt1JE4Ef772sS7/ZViHF+XXtVmHcAYQcuFNe9EU4UCPnUEqjIvQl1GcZe9zBmWzIBeS5UX6ggRwkuZfw8S1i6RjKTjexKGy6dbQcUK3s9f2PP9+l9qEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755223530; c=relaxed/simple;
	bh=xk+l6k/d1jaZRWVyEzhgwsCA0FGWVU8bhTTI1vKCtpw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JFJzdT+N/r/q2iFJrsSkkyRWaGqUUmG+hGfe74TX8YI8b/UZ3iQfw1xAbDGLN3YOYwk6VCad8T2YcQsgvIPulvyuk2EicS8sotDzKESwAfEwMce+ZAoAEbjldQxv0xRBA7HnoXalauPxe6n6K98yNmNDS0MXliSGjD495dUSQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=qUpvBFj7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SQgHu6lg; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F73D140011E;
	Thu, 14 Aug 2025 22:05:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 14 Aug 2025 22:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1755223526; x=1755309926; bh=nsVOmspME9O+t8vj6Hrlr
	cesarieFdua4vvDy3VQTiE=; b=qUpvBFj77igJ86dOLNa+mjlQT54hc+4TKU8Ut
	OuuqPP5CeeMbxKDeVv4VB5RjjADLqV9QUMPGAnIUNMDou7b4kZ5FxZDZ7aSJOuHW
	fV4shuDMwI13RbqIQ6k0Hl8mAmS6YRakW/gmt8LRb+FQwjvyzAMGz1gcStrrI0uI
	bSVSbU6dtBZugv0YdtiG75CHctuZZMMsiyvs/Ux3tyTP56N5kqt1+RPccBWaqeQw
	PIrLKBa89fhY2wC3DjTRNrO2GgtRe6AcGHGhtjgm0ZDZ01tyF/ZKEg5voyzUvv0p
	l8a5UUUfsritTIrP6rAg1J+tS6H4S0aZrUdVji/7hkrB3+6CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755223526; x=
	1755309926; bh=nsVOmspME9O+t8vj6HrlrcesarieFdua4vvDy3VQTiE=; b=S
	QgHu6lg/GVnxHri2e75Ehl5jpWoNezu9VIoTdQzplWb1JAaom2XNVa8TyAXn2jG1
	IJ9SsJpV97tZV9LyCxh3HcZwzI1YmkCBvXX9Z1W4VSO+8nQ0yqhkp5QAf+fIDe32
	gQpG47FDF6QiNv6dVKF+wvloxaQAJ/ix91LTWmXJijL5sNrD+hNcwtEwVxBr92Kh
	n3Mk3yKHZ22ydZcp0eO6aqGm3TgL4knpVUKPr6t7YhwajjHuqromAcP+PlsaExVC
	pd5pQaZFTYN93sq1O+E/dm4TSuQELFYFrwNzp1+QykGhBv6DKr3Y8R6siRBAQnYu
	LGS1QazFSXDZkeEQU6dfA==
X-ME-Sender: <xms:5ZWeaMS6i8wKrxunwh7UrYBXukKNK02tHPeHwAzL28EZ1HKEtUe1NQ>
    <xme:5ZWeaHvlMxzvEnqmse-mm-qR6shcnDjjyNxyu6rAyGDvUVQPAHFi-SwD_9CeITSC9
    Twq4_nV3pJGBGggrvY>
X-ME-Received: <xmr:5ZWeaMJ4GtE0Zwz3PR1Nqt-XpwCVFJKwZ0qBBQ8O8i__RQs1XcFYV5JvqIfUl5ybB1awkcKV5k7oj756nu9B7MlcBkOwJ9MNITU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvjedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:5ZWeaEkRX6hFQYVtpZXWPbeVvdci4d0abX7ZdI7DyIT6BnHrCMVzCA>
    <xmx:5ZWeaNJhOztuc1mCBBDKZwwN_xsAIm8EQ4gVwRMPclFIhIwZrUW3Fg>
    <xmx:5ZWeaJ4hOULOioiS4JeSubP50WKadpsW1GmLJouQH952q_UeHA0L3w>
    <xmx:5ZWeaB1jXxem6_gdIJBl2bpGaWjmZtx2bPvJUWs9GbSOgZ3q-HqUHw>
    <xmx:5pWeaBhNAisNtJyo9_3UsJ6c7-W3j8AliqQ7nIP23lcQwVSbKVSbKdfu>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 22:05:24 -0400 (EDT)
Date: Fri, 15 Aug 2025 11:05:21 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	edmund.raile@protonmail.com, apais@linux.microsoft.com
Subject: [GIT PULL] firewire fixes for v6.17-rc1 kernel
Message-ID: <20250815020521.GA349651@workstation.local>
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

Please accept the following changes from the subsystem.


The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.17-rc1

for you to fetch changes up to 0342273e14c25971f2916de2b598db2e9cfeec15:

  firewire: core: reallocate buffer for FCP address handlers when more than 4 are registered (2025-08-03 21:20:15 +0900)

----------------------------------------------------------------
firewire fixes for v6.17-rc1

This set of fixes includes a solution for the issue described in the tag
annotation for v6.17 updates.

The issue involved a potential call to schedule() within an RCU read-side
critical section. The solution applies reference counting to ensure that
handlers which may call schedule() are invoked safely outside of the
critical section.

----------------------------------------------------------------
Takashi Sakamoto (4):
      firewire: core: use reference counting to invoke address handlers safely
      firewire: core: call handler for exclusive regions outside RCU read-side critical section
      firewire: core: call FCP address handlers outside RCU read-side critical section
      firewire: core: reallocate buffer for FCP address handlers when more than 4 are registered

 drivers/firewire/core-transaction.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 include/linux/firewire.h            |  4 ++++
 2 files changed, 85 insertions(+), 10 deletions(-)


Regards

Takashi Sakamoto

