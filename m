Return-Path: <linux-kernel+bounces-894510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF51C4B330
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF783B2217
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1B02BCF43;
	Tue, 11 Nov 2025 02:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCykKKwn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB4348453;
	Tue, 11 Nov 2025 02:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827826; cv=none; b=rcXQ94cQTXokxfOK0GLDhaPsWL75uAIHYXZS10XKeM0vXOVOHZQUCHZhV9vqCvQ7yYk/5lyoT9ekyqSHUHYwkjq8B4LLPppZyS+cEoYQ8XHs5a08emEeDdQgMPbq8e4zqwEwBQQqbthYhremNWYkGSW5Jv44sgAj7dI8ndEU8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827826; c=relaxed/simple;
	bh=qHpvkne1MfqljqcFgy1fzdxefwcfvIBuH7/eQGN1Dmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ts4fGMGYWWFet2UO1SOOu4asIxnT54HLRygc4wSkJIdNToKXO5eS4qwEz/r3/unscZ5mwZlioh2aeDG13gH2n1g/THoVKPkqkf4s4HLV3j6YCiuGETz96LUCESr7XfJHQ0zCo906O2P84JRH57PXBWwa82kggbbMQJDf6inLFZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCykKKwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7DCC113D0;
	Tue, 11 Nov 2025 02:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762827825;
	bh=qHpvkne1MfqljqcFgy1fzdxefwcfvIBuH7/eQGN1Dmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCykKKwnaPWeBc9cqhdzJlMO1NrWxpDdlk/BJw6E1i09n/B9z0o1TbmaWdAundDul
	 3SRVsH8yyQDoWNFmRau7QWgA1ImLTBO4kEy+eFD8eNunlWbLhLAZIU/o9qTQn3CxmW
	 AHHxrwUzb0W7lMQ4d8sLqizfvYNX6JhW+7FqUPBGezlFGQclBO8BFwZslgKu/q+UoJ
	 nI60MDPhU8+iDX8vQ7dl+eqzL3xfHiG393xpwlutp5n4iP/+ONiDMYHs6v6ITkmuSy
	 dwnQ+XyeO8xTExrAYKlPkcKyoIN6Riz91lAXScfhCPde8qeEqWsnahJmT26HLR5NMR
	 97ykEKq6NkPjA==
Date: Tue, 11 Nov 2025 04:23:41 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, kees@kernel.org,
	konstantin@linuxfoundation.org, corbet@lwn.net,
	josh@joshtriplett.org
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
Message-ID: <aRKeLRx2NeozFUrc@kernel.org>
References: <20250725175358.1989323-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725175358.1989323-1-sashal@kernel.org>

On Fri, Jul 25, 2025 at 01:53:56PM -0400, Sasha Levin wrote:
> This patch series adds unified configuration and documentation for AI
> coding assistants working with the Linux kernel codebase. As AI tools
> become increasingly common in software development, it's important to
> establish clear guidelines for their use in kernel development.

I sometimes use tools like sed (just to name one) to generate a patch
plus edits. I don't think we need contribution guidelines for sed, do
we? Equally we don't need contribution guidelines for AIs because:

1. AI is not a person.
2. AI has no resposibility.
3. AI has no needs.

Basic computer science beholds to truth that for any problem there is
infinite amount of computer programs to solve it. This makes any problem
we have a moving target constrained by various corner cases, people and
many other things.

If you want to use AI to generate code, it's obviously fine. I don't
mind and I don't care, and I don't see anything wrong in that.

But that is million miles away from being enough to be called as done.
Generation is about getting up on speed, and in the best case scenario
to the ballpark.

Please, let's keep this out of the kernel tree seriously.

BR, Jarkko

