Return-Path: <linux-kernel+bounces-870489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55787C0AF26
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2CB3346437
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB8226F2BF;
	Sun, 26 Oct 2025 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FY65n/LO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5545572605;
	Sun, 26 Oct 2025 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761500275; cv=none; b=XjSYgaorBs0Q2zpJ+d6TfDkbHLCIBGK41S3meLWntqPLalBZ/ahUJnWqrD9mIVAmotouU6FLHUY+ZXLpGk9HbHn+v/Q3RNhtqUeTh7YdsmGKcqNWxqS7089/HkzZD4EWTtmGtIEvcGXX13KDD3hKxndOjmW0p7uNe7vbT5qodMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761500275; c=relaxed/simple;
	bh=0nlthcM2Sp7KEg6rX9z24/kU11h22ahXcRbWui/XwRE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HnQmOx5TFqIp7kuw3+RiL9oQDkIE+f0yH94hJt2pTxFlZPvPbidMmc4HMRJUQTKemx9aWnuijDRZqT3waKJFX6RfwAye35Cs75BOxJUORPBOMGxW/O4hxcu1PKfUn0h4lLkXffl1KDXcTt/Rwnj2dn9SQOTappTk3QDiWy5u3Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FY65n/LO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD97EC4CEE7;
	Sun, 26 Oct 2025 17:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761500274;
	bh=0nlthcM2Sp7KEg6rX9z24/kU11h22ahXcRbWui/XwRE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FY65n/LO8USRqaLAkiNJMMGcg3c2cVJ9GEUNCD1qKDoXh2yFLU15g92lPVNjOVQUl
	 q8n8odJVwiubuU43Ga4+CN5neWRf7+Lq+cE9lFyuhLNw4+zPmv8XU76e40V6tueA1Z
	 KvgcH04S9FapT3E1E1QGnJA+VUlVl5iZobKJ/3o1XDG65AgVjs+KfymzGvI/VqrWyk
	 BdoPtcxb7o6O4HIHF1PdXHXCilx2T/ZgfqZ3QPLJJ98UYMI9mGpZ2v26hizkYFVP8O
	 idk4NlG8zYAdX2zwN49+x38anHs2EmW44xD+Oen1u7NGI83Raq1tdHLrF6KKauJ6sS
	 MHmtCoSxgQSmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACC5380AA7F;
	Sun, 26 Oct 2025 17:37:34 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aP4pO8V4UAE3XEiY@kroah.com>
References: <aP4pO8V4UAE3XEiY@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <aP4pO8V4UAE3XEiY@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.18-rc3
X-PR-Tracked-Commit-Id: a1b866f2018748282fa026eb4c92d032dfda11a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6190d0fa18995b8bcc6b9a26913bb8390bda8396
Message-Id: <176150025347.300159.8170963441962042610.pr-tracker-bot@kernel.org>
Date: Sun, 26 Oct 2025 17:37:33 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 Oct 2025 14:59:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6190d0fa18995b8bcc6b9a26913bb8390bda8396

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

