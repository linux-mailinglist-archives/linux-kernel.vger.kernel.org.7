Return-Path: <linux-kernel+bounces-751446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442E9B169AD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32F55823D6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165821917E3;
	Thu, 31 Jul 2025 00:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhhWK8W2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D3918C928
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753922104; cv=none; b=AnPAXWm1BXkgzjQ9fsTnRRRnAIQob8aMQ7JZck9UT2EvTn5UzQMOoT1NQpiYST4THsK20fyuEqfz8nyeV+R7ZJHIVmlFkIpQPV2rPgp0CYAWBKuLTZ2yjF88HA9MhnVADCcb+ABQcw0ItXtlh+mBOXud518XDTpvfvI5PgkB9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753922104; c=relaxed/simple;
	bh=geoWnP7BAcdB1y/KkDRMnWQGWof6S1LRTbEil7ZDI4w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d7w6CXh62c7l9hI+4mZ0siW+W4LdXCu0Zeutk/aDy+lhd9cwKIjvx6r0WwCwvML8x6DBvWv5+2lS/2vguyx9yFCKWiiEP6B2gjecQ0gV4SC0fhs9Ox05bjtDQa50gagwK0fOCvWiBVbtP5I/7dg77hUVOZVQS+sY4zpRJtUJ9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhhWK8W2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECFFC4CEF5;
	Thu, 31 Jul 2025 00:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753922104;
	bh=geoWnP7BAcdB1y/KkDRMnWQGWof6S1LRTbEil7ZDI4w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AhhWK8W2nHzdaOu86iwGeSXTyyi0pt1cMyAkNcu9IbPBUEdInrEdyklbYliJsT0Nz
	 Y3czYGaF3uZqMBrF+yHnjPRYLH0AImXxvLNfeVXm0Z7ZiH9NeH3vz52uR+mLHjp9+6
	 a1TPSPlMtvnVTYDQVuYF9dOo3JFz/r5Bap3K5JaUmOPvCES00VhlD7P2fgvFk9VBD4
	 L6NSmO+XPnJY/0KGdDwI65qRXgQAr8X8BrhE3ZQ1c9uArNN3JjPQgZK3crvaD0bNXk
	 49DeMjePkHOBfYlzUmNpU46A2+LauEt6SXwdB+CSLBmb0nWi6G3hCIYSEc9GbrADMG
	 uichN05GDtdpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B86383BF5F;
	Thu, 31 Jul 2025 00:35:21 +0000 (UTC)
Subject: Re: [GIT  PULL] ring-buffer: Updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250729152459.062d15b3@batman.local.home>
References: <20250729152459.062d15b3@batman.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250729152459.062d15b3@batman.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ringbuffer-v6.17
X-PR-Tracked-Commit-Id: 6443cdf567a900e03afe1d66fb8bcc7dad0835d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d50b07d05ca53fdb6c6d1581b9084c09d4e98f54
Message-Id: <175392211991.2556608.10124232800552154923.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 00:35:19 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Colin Ian King <colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 15:24:59 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ringbuffer-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d50b07d05ca53fdb6c6d1581b9084c09d4e98f54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

