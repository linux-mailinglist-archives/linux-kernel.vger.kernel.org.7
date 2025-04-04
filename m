Return-Path: <linux-kernel+bounces-589415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DEBA7C595
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 23:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEDB189718D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 21:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E333520E6E0;
	Fri,  4 Apr 2025 21:35:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A1D1917D0;
	Fri,  4 Apr 2025 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743802539; cv=none; b=Nmb17Z8BwCZVYQ8K2ee5e4yyzKgFqlS9q2DF3hMOA//EipL2hbKIzwAPmFfBYTKva83FwCSHhl5DTCpVGnRuRpgTbGvknMe7eUydFdbCYF+pB/A2pRP8yhwOmAwh0aLKe7ht37fzEHaLUWDdFxRcpDRxyjcAmwOaRxmhCRlUC9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743802539; c=relaxed/simple;
	bh=XMBg5fnuTlCTX80J0N2UOpfYxX3dV+oXFpEnA6wpJ/g=;
	h=From:Subject:Date:Message-ID:To; b=FIppgP4nldctIpkqgJxU1Cr3KL4VRPB96ub2Nf4dQniBNNyIpxN798gnZSUjNWxBe+ThsF87xOp+8ObyA740oC8j/NNsAl06zgktxwgfZ1lviPX8E5GxJDJmE/4QzfAOU+o6I4YJPChFzn68f2i5ArLI1X0rvlY4H5ctRyA+wEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2E1C4CEDD;
	Fri,  4 Apr 2025 21:35:38 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.85-rt53
Date: Fri, 04 Apr 2025 21:34:33 -0000
Message-ID: <174380247376.1673643.838971818539681911@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.85-rt53 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 504c82ca31766b2a3798ef732dc4d9594aee4c24

Or to build 6.6.85-rt53 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.85.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.85-rt53.patch.xz


Enjoy!
Clark


