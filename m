Return-Path: <linux-kernel+bounces-816029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB50B56E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF5017527B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C9721CC79;
	Mon, 15 Sep 2025 02:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="lppklzWT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M6T79dWX"
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA072DC790
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757904160; cv=none; b=jM3BvJ+7z3KucVzee5+9omwPRSQyCbDXJm1vXHooBVrkaxFzt+o1Rw4yTyybKP0aYoZTlZ+oIWH4ZguJ0kyKkQZoLhg9Bwghc6HBRChT193QNr/O1laj6I/ymhG1XhnbqPUquxqMEjSsNMQNvCW8za+06eilMFQ6BZTnskg/K38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757904160; c=relaxed/simple;
	bh=+CMb+jMran8oiNCa/2tmg2fLgfvB2h7JakjskZeRitc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlM7n95QVKPtGsXsSPTrwNOKDxfK1pdgrh1SGbmaUVbnYZczGL438kgJDtJeclmLOkTu/0yUu14EllKxlganVbLpOaa4pcf6wN3bVnukSuE76rbJXIYlzeoHlklzFN98WjphWHiZIoCVBUDzxaRJjIMWUwaqqJve5Ov778LpkoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=lppklzWT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M6T79dWX; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9415E7A00E5;
	Sun, 14 Sep 2025 22:42:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 14 Sep 2025 22:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1757904156; x=1757990556; bh=NtZQz38DTg
	Oi03QSeQq0CjBm7YGlTeMyD0NKSMYy6JM=; b=lppklzWTmxeTLOkFcrwebiVZYR
	U4jN3gHBZesTL/HWgxehhK9BCdlQDxxiGl/43ogdOA6VHI1nxtafu13ZM1iAlolb
	PZhcnr8fGAh8jvbJNHBTXWBRRxkcFxjpmbYzuv9OcfD4yVDNu/gui0qwyBjwyGHZ
	mvVJ42/cbfK80pv+uKcNvD54Jg7MfcHKXS45buG2E6tgEGw0U9bi6srGXP959voa
	4nTs2eAnc9mGaGZw2wgsNlQRT5GFvFzKEHZJ6KFaYPluC3lUpYIKGkQ5BjhsvZ7n
	lkyiwUeQ/dxSKvvFUSA7Z5kPmMaWZ/vENYjpdqwLaRSn5Rc4jBkhqAUvqkzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757904156; x=1757990556; bh=NtZQz38DTgOi03QSeQq0CjBm7YGlTeMyD0N
	KSMYy6JM=; b=M6T79dWX36RGOWKA1FX8HZR69ym4CUOMoctlmZeXhP7odkSQK7O
	Ej1ghuv36ElY+lrBR8IOlAc+GJCMTBR6YSnMOrDG+mirWMZD+h+vnnN/QrZ4Hcx0
	foIf3d2OmCt5ZcSB+uV1qbeUJpLki/TDVt1wmuDD9TY/4ztQ7E4lUT03CKCxnQIU
	2pSSlyQ1wdzvpOjAPfPKCLUvse/KxEVQZSDvJcxC4OyN0QIy46Y6Zoil+q/fzy83
	vt1ez0L1EMqEQ24JT9KULxTbBmiN9TuUOkImIPK1trS+QYLyzm/eB89vTyicoQKY
	Zd5b1xe55Dd/NffpDCqVP6DLDvzhQ4HbEXw==
X-ME-Sender: <xms:HH3HaH0PsBGxSbWNgYN-1N0NGQxZ5_yP7QnCjCP3cRxd8paTJxI5Ow>
    <xme:HH3HaPBj40y_5vnBrLtao4-27WxQj3Q_Xjv1Jc3J4XInr8dAzi-fFpXA6hvk-HmfY
    NFZViIyc1bpbgJLNPQ>
X-ME-Received: <xmr:HH3HaJ0Yc-eorL23Ykf9IIwyq5cebmC_hY0-Y9vKi8mTkNlwDU7yctxmiN2IOSyAnUVh3fv988LpdbIDaz8tqdvej0wBrDku-4PvtJNXZytVheU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihes
    shgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevkeduhf
    etjeduffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmh
    hotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfh
    horhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HH3HaJs7b6Y9Z5E4CsdfVTSjhhOjMWjzMpwuGIprhepygPyLaQKLyg>
    <xmx:HH3HaJ6an9sGST0z9ZPodcGgOREF_BdmzeJVqdqPed_ftLx9m87xAA>
    <xmx:HH3HaKLRBKpSabS3yu1RWtHIJ9stFiXiM1OGmw6ixE5GAUSqXSqPvg>
    <xmx:HH3HaJ5Rh16aXQUiPWB4vfy5JM-Benu-uI7GwHDLttqapbGpCzsXFQ>
    <xmx:HH3HaFZGj3fcsFO-sfVF4OLywKpmvOkFSDhjcXcvOnSelZcGkQDzXJD5>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 22:42:35 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] firewire: core: use helper macro to calculate jiffies count
Date: Mon, 15 Sep 2025 11:42:30 +0900
Message-ID: <20250915024232.851955-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In this subsystem, all types of timeouts are managed using kernel timer
wheel, thus they are based on jiffies grain. Some macros are available
to calculate jiffies count, and they have some advantages, For example,
no need to access to HZ macro or jiffies itself directly.

This patchset replaces several lines with these macros.

Takashi Sakamoto (2):
  firewire: core: use helper macros instead of direct access to HZ
  firewire: core: use helper macro to compare against current jiffies

 drivers/firewire/core-card.c        | 17 +++++++----------
 drivers/firewire/core-cdev.c        |  4 ++--
 drivers/firewire/core-device.c      |  9 ++++-----
 drivers/firewire/core-transaction.c |  4 ++--
 drivers/firewire/core.h             |  2 ++
 5 files changed, 17 insertions(+), 19 deletions(-)


base-commit: 2ba08d1bad79cc8d9c82f529adc01f27118e0ca7
-- 
2.48.1


