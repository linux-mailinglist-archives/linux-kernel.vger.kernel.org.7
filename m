Return-Path: <linux-kernel+bounces-752464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838BAB175D8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0583587D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC0229E101;
	Thu, 31 Jul 2025 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P43DjPEL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019BE23C514;
	Thu, 31 Jul 2025 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984484; cv=none; b=OGBsAVyn51EJFsFFPb94q8maV/RViSxSIJMIZdiiQC3Hfpdk6mUWyYTGU2ik346rkn/7M56hJcEf/ck0ZeT8MqZ78c9vNoslENqNO8MC1eNARhJVuejbDcVlZeljapJ818dXu7PtGHK7viZK2+SFzZXIghInjMFoCTUIjafrL5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984484; c=relaxed/simple;
	bh=g47yNcPQpCnCSVUUixwXkPIBomFsYfFHI96DXpo6QJ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KwMAmEFPBUMS3vyWXE6ctBpAon5cQssMW7YVy1JDP7JY+RiE0v3xpDFg27g+V3RJ1Lyk/jsuca6k60R+KtoqtzwuD6WilNhozKcWl4Pzy4bzsn3TmQwfeTTPHO2gRRK2f3BQn0t2G35Eg44vE5axgc2FJi88a6Vw6tuvcZ9gKFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P43DjPEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FB1C4CEEF;
	Thu, 31 Jul 2025 17:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753984482;
	bh=g47yNcPQpCnCSVUUixwXkPIBomFsYfFHI96DXpo6QJ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P43DjPEL2s3x6RtJPc3riTif6rYzkVBr/MrRKMi66YbWCeUtuR0nVHNM+2WGuLYl4
	 M1S0yN7FFirJJl+4UDtteQbbuzgwtdl/RPxRDAYKz5Z62w2+x9m1Yhj2a+CINDECpq
	 02v1NfqKahZBPn6FDI3wGnDEsLlxLgJUhc5Ix2ZGVOS5ET2VxWg8m8yPmK2FCvwknx
	 XmeYB4kglf2axz3s4uWmaoOhqCHQ+V8/jT+XwSle0n5DGFQbWGq08MCfK3SKQc8+km
	 Q2owPrIYlFc6FAHakxUgC1gFam5Ou8MM7BUiZ3Ti3xU4WGDbE93OkS3mkmdAWjP318
	 +ItM0YLJaxnQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D84383BF51;
	Thu, 31 Jul 2025 17:54:59 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIirh_7k4SWzE-bF@gondor.apana.org.au>
References: <aIirh_7k4SWzE-bF@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIirh_7k4SWzE-bF@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v6.17-p1
X-PR-Tracked-Commit-Id: bf24d64268544379d9a9b5b8efc2bb03967703b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44a8c96edd0ee9320a1ad87afc7b10f38e55d5ec
Message-Id: <175398449814.3232013.3906313623073112970.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 17:54:58 +0000
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 19:07:51 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v6.17-p1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44a8c96edd0ee9320a1ad87afc7b10f38e55d5ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

