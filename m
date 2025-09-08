Return-Path: <linux-kernel+bounces-806537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F08B4982F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D1A188ED8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299833128A7;
	Mon,  8 Sep 2025 18:22:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD074A1E;
	Mon,  8 Sep 2025 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355761; cv=none; b=Brcca7yq7mTD4ozL4mPpcbBe3+YCF5i3mtDCec2EvsCUFffMiKvyO9TEVfuleeitzjUex0B2HTOS7/ZYS7pivudGskWJXnaAVQcIWBXVIBBBpuSEFchGcO0A3Mud45YKdwO2Z3cYnxCDDhusL3FKjMov+V6fPbbD83azf2Mo4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355761; c=relaxed/simple;
	bh=rESEsWNmYCdLKX4aPcc0Y29tgFf4Kaq9wg7a3jnDLLU=;
	h=From:Subject:Date:Message-ID:To; b=lm8kjSu43F4UCZapHWc7RCovye9/3qxAwOmLeQq/yEZ2eqMQaOhlUU1TozOwvkg0sar1diJf+UAdW5YAbtqaqH+NCcRpoyPwaRgz0KKj5b1pRFoOzzU3WZBoXm+NvmFV/9DGb2VfDEv+9mH02+fbSc/LXlQ4/s7o1vxCAMkQuE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38044C4CEF1;
	Mon,  8 Sep 2025 18:22:41 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.191-rt88
Date: Mon, 08 Sep 2025 18:21:47 -0000
Message-ID: <175735570717.690901.3747629786341532747@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.191-rt88 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: fb343153b1c033d7bdbf2acc355cbe76a8388872

Or to build 5.15.191-rt88 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.191.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.191-rt88.patch.xz


Enjoy!
Joseph Salisbury

