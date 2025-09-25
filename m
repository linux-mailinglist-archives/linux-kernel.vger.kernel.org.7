Return-Path: <linux-kernel+bounces-831680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDC3B9D4E0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4247A9D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBC52E5B05;
	Thu, 25 Sep 2025 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9hENe0O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E729F34BA52
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758770478; cv=none; b=g9fCKTHBrxIWAhrmyyfze2IdbGWraun38n0DZNpn5cgafd0SNGTSmqMYtVVuGbNX/eyGZQGqUAKom/IrYnhI+zUSvferlP1mWAfkgX4HU685MkI8YR4TRTzkfPh5SH269+d7LecN7X/wPg8vQ26WOPzgJwgxthDvkK8ScAbDleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758770478; c=relaxed/simple;
	bh=4DKvOHRHUgw5JBjsOhvoKaJB66TA+wjyVN9uOpPEmmQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=suQMOBxv6zRhTfFaxcN4w/pKYnWXPplbHblrj7p9w9YBMHbg9+it06F1rULmZA+57j+iCqcua4D1HA9yomCUkiuc/Ac3eUCus3yyOPzaXqy5me3UgA0OyRnHoEt/aBUh9djCKQdtSBuC/WQnB4jivNAVMn2OmhRrVHf6iT5QiM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9hENe0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB17C4CEF0;
	Thu, 25 Sep 2025 03:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758770477;
	bh=4DKvOHRHUgw5JBjsOhvoKaJB66TA+wjyVN9uOpPEmmQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A9hENe0OTLjPiJPJ1Pa1pzxLFS5q8sKcH9WDzENkWyRgY83sWYobfVPXdhGZXvDwg
	 yse7t2Q1h+co8l4+P3E+8I/LLRxQKQsypjFkWGURqAdkh/ebYbK4t+LPXI6E2VtxZH
	 ITFR/aq2hdjHDUuWuFzVrZhqU5rYW4nCZmxejE6LoAP1TKiFUS0z/fJDlL7NARQMw8
	 20jcpYln99AXpjsHh/+QdnLknISXvjFZG6nn4QZtSvPApvT6LEzzxep/QvhWm5DDl3
	 tbe/XbReEjNlHWdfSro+nPfxfk1/xx78WWBncqhy62h//75MEZc4/9xkRuc14lRP9x
	 T3YtumKUGLGEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB18A39D0C20;
	Thu, 25 Sep 2025 03:21:14 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.17-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250925101826.671b15ad33f115bf0922aff2@kernel.org>
References: <20250925101826.671b15ad33f115bf0922aff2@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250925101826.671b15ad33f115bf0922aff2@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.17-rc7
X-PR-Tracked-Commit-Id: 456c32e3c4316654f95f9d49c12cbecfb77d5660
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf40f4b87761e2ec16efc8e49b9ca0d81f4115d8
Message-Id: <175877047350.2801670.1387431350456124350.pr-tracker-bot@kernel.org>
Date: Thu, 25 Sep 2025 03:21:13 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Sep 2025 10:18:26 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.17-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf40f4b87761e2ec16efc8e49b9ca0d81f4115d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

