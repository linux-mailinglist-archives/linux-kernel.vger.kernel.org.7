Return-Path: <linux-kernel+bounces-882159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1EDC29C82
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812E53AE11A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68E2185E4A;
	Mon,  3 Nov 2025 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="jMK+xN74"
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894E269D06
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762133098; cv=none; b=uaCVgJjmCYy6uiusO293kMraKkbrDRl2nopKXiUmw+35yRU2j4H74Hc5BpQA3fp1egcYaOGnoNJxTOxkI/blT06/bCcDpallNc1h1nxk2eLa8mpfV4AUwbkHHSy+8Xty07Pyk00VbWGTYM+splhrox17m6PXnANkC+gTnJ2kuc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762133098; c=relaxed/simple;
	bh=w1BBSIqKCcTM94TEne3TpOoZOLy52cPnMPLEGRLvFhM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=b7K4aSUqrRAbmah0oMAz2ATtRyUkf+sr/rZyXi2OopDDyYz3K9lYNX+bWKF4M7CqJibVuTYGe935o8eg+8EFsnlbO3VHOemlQQOYi/dB+FXLaB+J66obOQuwtKnp6LDfOw21xp+eMA1SrFWUuXItaM+YXK648J2RTRe6PmknQ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=jMK+xN74; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1762133088; x=1762392288;
	bh=w1BBSIqKCcTM94TEne3TpOoZOLy52cPnMPLEGRLvFhM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jMK+xN74hx1IMa9RRK9nyO/CU+pAHQVtNV/INce79WsHJTPuIk7d9Nxx8K+ixJgZc
	 uS0bjLRMxYQk5dU+mDhZnAYX+aLZLlvl/buWjicvdBbUMsHaaq+ZqspIAObJOV5yLS
	 ytpDGv6aqrqG8vim8BqFN64aU5p+b9BZaYTG8YzKl4OgPp8Wh0hOCYKDLLGIF7Ll2Q
	 LuS6h9t8MHY1FV58wK8V7+roL36YT0eraRwBrBRUa+GSAE/rby//IxVQJ7DLeSmZgg
	 L7q0md+pJxIyMThg25xRA8iITsk2fd4l/xX85fh0NtkuLerivn5+JF8PLSbFGxvcTe
	 giqMFyCtphCug==
Date: Mon, 03 Nov 2025 01:24:44 +0000
To: dapeng1.mi@linux.intel.com
From: Harvey Tite <HarvT@pm.me>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, octavia.togami@gmail.com, peterz@infradead.org, regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [REGRESSION] bisected: perf: hang when using async-profiler caused by perf: Fix the POLL_HUP delivery breakage
Message-ID: <9f94b9b5-0a8a-4f37-8355-0b5461d6ad30@pm.me>
Feedback-ID: 38997315:user:proton
X-Pm-Message-ID: f634007f31f1bd03ce2d4cf8a6fec95a2baaf7a4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hello hope everyone is well, just following up on this bug report, this=20
appears to have been patched here=20
https://lore.kernel.org/lkml/20251015051828.12809-1-dapeng1.mi@linux.intel.=
com/=20
thanks to Dapeng Mi; however, the patch email does not appear to have=20
CCed the regressions or stable list.

On 2025/10/15 Peter Zijlstra wrote:

 > So yeah, I suppose this works. Let me go queue this up.

In regard to the patch, hence I assume the patch is approved for=20
implementation in future versions.

This is a critical bug causing widespread irrecoverable system freezes=20
reported by many users with many differing setups, including myself.=20
Notably it is being triggered by a minecraft mod called spark with at=20
least 150 million aggregate downloads=20
(https://www.curseforge.com/minecraft/mc-mods/spark=20
https://github.com/lucko/spark/issues/530).

If at all possible I would love to request that this please be=20
implemented/backported to kernels 6.17 and 6.18.

Thank you.



