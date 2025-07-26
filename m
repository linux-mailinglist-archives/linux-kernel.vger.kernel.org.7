Return-Path: <linux-kernel+bounces-746532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 700B8B127CD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68DE581B88
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07968BE5E;
	Sat, 26 Jul 2025 00:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bnzjigvz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB3D747F
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753488303; cv=none; b=s6Nr7O1EkUKufX7SxmPQBowFEBwIpQm+/XQMeg5nwdGVo4i5O9VeaNKUtlUVuaAxLspcogsif1XoXD1wLutyOB0tb9vxdoi0YjxzrBy2VOqYOAU1K+Q8XvzNKJHAv9zjUoPSN/vD3DRm+e1XWsdP1MidChxZm65xjQ3XO9hN+3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753488303; c=relaxed/simple;
	bh=gdGX1BFrzkbNRyHFg4looJDQ1fbqwFVtryMKyLY26A8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QLhMLRli6N8U50rtDS1Ti7BeN4YmCU9/1KnkqT+WgeJEqoYbCogQre3euhv0dGULNJBaGPrGlCJSNX2mzqNhA747FB99HXBov7Fm8sqoYULKERfQqJiaTDz5GkFMJaS4LGkARlclgdQnQ1Hvq6WMyrzzvB2kF2zh7IrThDMeWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bnzjigvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18DFC4CEE7;
	Sat, 26 Jul 2025 00:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753488303;
	bh=gdGX1BFrzkbNRyHFg4looJDQ1fbqwFVtryMKyLY26A8=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=BnzjigvzwiIZEq+VZrrXHGv3AC1AGtg0OEpohvuCjgeGcXd9/qbdOUmZzb0ubMOzC
	 Z9wBA88QHEAqgf98vM9lDLEsrA3fhgFHEQo5XI94OjrQHpF1qeF3DUVdGsqnaCmjTT
	 Yh7WCX+LRssgShO6GoF57FAS9+sEc2eu3SLxXL6Hl/wqN+qtbmUbX5udTkbeFlXVyt
	 ietwQ03Yt353+yI8yzD5WTNMYi15Vrg1NYw/fg9F6hgGseQipCBA+atSiD5Pa/7Cyx
	 OL0OPfk9uY99ObRDB6HM02aOu1UYkh6vgeCI4b5MFDR9cCoSY9xQh/xLSzWWc4M/Og
	 U7Wrh3SgL+RdA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 89F20CE0E5A; Fri, 25 Jul 2025 17:05:02 -0700 (PDT)
Date: Fri, 25 Jul 2025 17:05:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	peterz@infradead.org, joelagnelf@nvidia.com, frederic@kernel.org
Subject: [GIT PULL] Stop-machine change for v6.17
Message-ID: <d4ff8176-3b74-4d7a-ad9c-7ee08659905b@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linus,

Once the v6.17 merge window opens, please pull this stop-machine update
from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/stop-machine.2025.07.23a
  # HEAD: cf4fc66746e344181f41604066659073dbb8aaf0: smp: Document preemption and stop_machine() mutual exclusion (2025-07-17 12:11:13 -0700)

----------------------------------------------------------------
stop-machine: Improve documentation

Changes
-------

* Improve kernel-doc function-header comments
* Document preemption and stop_machine() mutual exclusion (Joel Fernandes)

----------------------------------------------------------------
Joel Fernandes (1):
      smp: Document preemption and stop_machine() mutual exclusion

Paul E. McKenney (1):
      stop_machine: Improve kernel-doc function-header comments

 include/linux/stop_machine.h | 64 ++++++++++++++++++++++++++++----------------
 kernel/smp.c                 | 26 +++++++++++-------
 2 files changed, 58 insertions(+), 32 deletions(-)

