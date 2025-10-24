Return-Path: <linux-kernel+bounces-869389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 520F6C07C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7681C507BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B0734A3B5;
	Fri, 24 Oct 2025 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/0LvbHZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D50327587C;
	Fri, 24 Oct 2025 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330793; cv=none; b=IxVj6c1AEtae6Yvk7edRQUcjEvnj3hYEn9tqxyveLg8Q6GHNubNLr4166F/QIWb5ZK+BREmXH8IoJy5wk/XRpPgr7jwSvUkRGooZgV2vTk11zZtq37xpoOXzH9K9dQyrGflMTyPVt1vJ+wihLc2gYWJeu+O0gE4eBuQs6m9Q1C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330793; c=relaxed/simple;
	bh=mmN+NbFL4nZEK4l7kHxyMm6mtjCmAy3bWqtfQ/SoMms=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pdyuMPR8C8V/9B5UCAqqG5iaqoycz4uP4Mb28vTjsJqMHnGZ0oK3EV9hiTBAu4V4TE8QxhtFs3hoSlWUc/wewPoKTec1sK3enR4UbzTcZKuTy/MIB3dZad3jGErhjeO9iVCl/e6LdFhVBfvC7ZzkW9A69lODVaVNODzJV8VAHdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/0LvbHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6F6C4CEF1;
	Fri, 24 Oct 2025 18:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761330793;
	bh=mmN+NbFL4nZEK4l7kHxyMm6mtjCmAy3bWqtfQ/SoMms=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h/0LvbHZdNL41bZUzwJ1YsDaK6iZ+tKAWqmV+F9uT2202/toawjVZqbhSLumorhl/
	 bQwVNyMAZ5cyCkmou1J608K/TB9nkwmqc/LdwqnJz7xPaqx4+6+Yf4Dm8xFT8HQ8pQ
	 aqIm0eiphgYGNfaRIH2qn1+z4OO5DCrxlfhmLlhm4ltkqBHgieKozl7K9lK3c5ntJP
	 JxgUA8uU8ARdo+XhX4FOisSHOEqYmJsYTbJYSevB9y/uLuy7O0sWg8kSWPpm/Sadkr
	 kthHUP/3JF7Cfe+iJe3Eb/DWjZmJNQqhtaK5+uU89hnEr54LX9OLG78BQ/jkPYV5MQ
	 o3TdhG/viJDtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D2D380AA4C;
	Fri, 24 Oct 2025 18:32:54 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.18, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251024172229.GA2130411-robh@kernel.org>
References: <20251024172229.GA2130411-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251024172229.GA2130411-robh@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.18-2
X-PR-Tracked-Commit-Id: 7209ff310083315386570bf8d001a0845fe7ab8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e590d67c2d803d603ac00b85f2fab235df52a1b
Message-Id: <176133077276.4023146.10181752662522448113.pr-tracker-bot@kernel.org>
Date: Fri, 24 Oct 2025 18:32:52 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Oct 2025 12:22:29 -0500:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e590d67c2d803d603ac00b85f2fab235df52a1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

