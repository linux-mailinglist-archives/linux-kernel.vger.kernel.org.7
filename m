Return-Path: <linux-kernel+bounces-689302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AE3ADBF27
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 04:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779EE3A9356
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 02:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F41233D7B;
	Tue, 17 Jun 2025 02:25:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7020E1DE4CE;
	Tue, 17 Jun 2025 02:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750127139; cv=none; b=fx1XTPKAFwuDAujnASD+XIymxTJOX3xhhTqFwWpOv9ecWjU4gaYKdW4gw2gNuYT3TbpM6pu+R7/FApupdjRih/PooZHtM4i1VbEo852gMKC7JUhubIiCLQk8ilCYzRykBW+EC4m2JwE3jrVE6SF0Byfskq8DVsx5HPJHPMgn4oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750127139; c=relaxed/simple;
	bh=tqxotGWZsCsjHg34A6ge5g1jgleVsq7K/esLtnMMj6Y=;
	h=From:Subject:Date:Message-ID:To; b=OEmidK2i5GAyHPi52+dH+Eh0uFX0rfKxKlJ9JYaJvY9SQmvSIhAbjL9QbG3uGXui+VU1YhfZEW8wkm3BZ/BZJkg9WnV/RWPtsyhL9AyM+ZeM0reYWOW2fSzcCts9J4dYH4LrmknIWZ9OfERO0ZnYtn8a295hC4ktm60TdbGHBO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB38C4CEEA;
	Tue, 17 Jun 2025 02:25:38 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.93-rt55
Date: Tue, 17 Jun 2025 02:24:46 -0000
Message-ID: <175012708623.300399.18385688911351346339@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.93-rt55 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 5495197730f86d3227ddfc243ff2980747a321ff

Or to build 6.6.93-rt55 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.93.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.93-rt55.patch.xz


Enjoy!
Clark


