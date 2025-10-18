Return-Path: <linux-kernel+bounces-858975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B492BEC639
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 070BB353DF5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18449274652;
	Sat, 18 Oct 2025 02:55:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A759326F296;
	Sat, 18 Oct 2025 02:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760756117; cv=none; b=SP4VlpEnXK+ZNZDUQoeJiPIzxDBGSHksI7m5x9TzkBcbKx/Hl3t+KgDd3QliCV2TLHRQx79pJsWkPORBC8NHjPVEmDda6m0DXtIxT4IisBaHoKcHNezY3O6jZMNKlkAvMeVySIQ+EaWhR9jch3QEvJT3cWMY3N2LG/PKFC2+uWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760756117; c=relaxed/simple;
	bh=ugDB9tmjf9fFUxRh9qMD8dOempYnKzCqC6hMGLSVScM=;
	h=From:Subject:Date:Message-ID:To; b=KIVOa2mbUhJddL2Ybm+Y2mQ2jq9dtvdNjOCvcUr2saEqT0Uw0eahnQKzSrZZ0Xt1TMFOfFX82Vk+RS/rprKEPsd/5Di1DD3T/4xkrubS6eA5UPBcJ57883/J3nYiOQdpbgdTW9b6JSsU2WbT+yC1oQ5QbhVarRzCEzh2WPmucys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D944C4CEFE;
	Sat, 18 Oct 2025 02:55:17 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.112-rt63
Date: Sat, 18 Oct 2025 02:54:15 -0000
Message-ID: <176075605510.1213956.13027981274658486967@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.112-rt63 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 6338aa3469a32cb007ad1d5a98353aa8ebee9249

Or to build 6.6.112-rt63 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.112.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.112-rt63.patch.xz


Enjoy!
Clark

