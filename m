Return-Path: <linux-kernel+bounces-859432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E921BEDA4A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 21:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7913AB5D5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C4128506C;
	Sat, 18 Oct 2025 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtgCkFEh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCF2450F2
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815434; cv=none; b=rj6S4gGLQCEpDjr8h1RVsuiADicvoin3skcGh8ocrspYw+xSKhso0rozwpp/ZqWSWJCSK1A2FTVjzZRjmwOWQuJLmTXXCtGAzCmHEe1kkWHkjEa37da1fWpwgZKIn0pzwflwDFgUV3R7i1woVhsFYFMODWIxmwzZv6/6pmRCtUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815434; c=relaxed/simple;
	bh=x2Z/o1CCKMoisaGGnf2Xs9j350IwSc6Q+jOuYr4qwC8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iS5sRSKhQ3i41GjrwgQK+OL39eT8Laq2iREHndwk2DZa8sEXKvPQeh3A2rVyobmNTfTw3Y/kgSaAZ0BMbPmZqagKX3m7WIIeUZ6OqzhVd6yGGkxYyWt/qB12TPk3N2zeqZGDiYNm+JNP5vPMsFdlTYANYbPLQEmTuJSwr6OC9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtgCkFEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D457C4CEF8;
	Sat, 18 Oct 2025 19:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760815434;
	bh=x2Z/o1CCKMoisaGGnf2Xs9j350IwSc6Q+jOuYr4qwC8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QtgCkFEhxFE582hS3yGFyas/4oNJuWCwF2jaHOiuGV+thxcBNTI8pP/07jpyfRV0R
	 2vI5RIXnriHFA6fVZjW2c5rXibRuBKI7RlrT5V5MST1hKiSLZgAS+j6tP1X4krCq9j
	 NeULACg5AXlwXhSKeIMEBcyBvbGSWhW6wFo0yObR3gnhqYKov9LxsNOTy6FYFALKQl
	 fbHa1rrkVTvQcKQYweOjSjiJp2U+aK3Hdj5rDswLOPhozqRrs6Aj3FgXTZGYyUL6v9
	 Rufit4J0iA4OkADZudFKaUwhKWdVQ2ivN/Ty2ZTL9xtYcbzdUzqZCkkByiUHb1+MF1
	 AYNoCxibuD0eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D9039EFBBA;
	Sat, 18 Oct 2025 19:23:38 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <q5p7s5oo-ps69-7659-69nn-48685q1694no@xreary.bet>
References: <q5p7s5oo-ps69-7659-69nn-48685q1694no@xreary.bet>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <q5p7s5oo-ps69-7659-69nn-48685q1694no@xreary.bet>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025101701
X-PR-Tracked-Commit-Id: ed80cc4667ac997b84546e6d35f0a0ae525d239c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2953fb65481b262514ac13f24ffbc70eeace68c6
Message-Id: <176081541705.3081941.4616032405563504638.pr-tracker-bot@kernel.org>
Date: Sat, 18 Oct 2025 19:23:37 +0000
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Oct 2025 17:38:09 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025101701

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2953fb65481b262514ac13f24ffbc70eeace68c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

