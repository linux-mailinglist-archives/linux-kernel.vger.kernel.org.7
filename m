Return-Path: <linux-kernel+bounces-774094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3548CB2AE8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E85B564C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BBC340D8F;
	Mon, 18 Aug 2025 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="a4ClcLts"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150279CF;
	Mon, 18 Aug 2025 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535962; cv=none; b=bZeG0R88dQZsroQWALESupGKgK3ULT84O67xJi6eTt8VycL7nHDj11kXlK6ZLUwtxLaXXGQjiTY7LceDaAJJEHfb+X45YtHXqc2iXpsoJ84KHWHLbi07F43t5gJAM9al4p+QwzCMgjp847dkDoBFYMkT17HfVYi2O7gnf+/ibqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535962; c=relaxed/simple;
	bh=RaZ61BdX4xFg8kvTPwXNCloQmCraD3QMXDwjjRuBcCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sdztdY7Z/CQPStriYIICj4AMSUGFv6+bpBBNKhfXy2gEmUij08TUHpqM8xyGCD33rz2jit+ps5drSDTkC5FyHmk4xpqgmBe6vlFYoWd9Sw06sBRzKrVn0bwlCWeyMJVOAMmIdd8+WXnTiiDSbo9RhCxTSeBmy3k3kmkSU8Q07T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=a4ClcLts; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C9FBB40AE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755535960; bh=jJoGfkPGzsovkqrZFk1ijrUb5+RpNsRfmQGTU3tcLYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=a4ClcLtseQNfJ2HsK4yIgpDDIPypDBvyfHk33o4L47ucdFlgqbh2V3fPTEPxeGI5C
	 GGne/mxIGdbeN14dc56VyXkEcUvEEchNZIl5+EFZKJguHI/MOElHpV1WRzjD7h5ljU
	 mo0zFXMH4VX5wBQEBLpmmrdjSw0kW/g0AOVMC61anZno3VfqRBxlSaTCwGEWW/mtw3
	 l/eVMfpV+/Z+HgktROcgSl3ehRD+2rGsMVKJ3Mmo5LOmifdc0Nn4jTdR1teTw2KXQV
	 RZyvnLsxgHiBW0orEIr/9PGu4laR2NLPjyuR+761HNTR7jSXQNbp+PEYX5p87rj+BI
	 Q6vTnD9as6UcQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C9FBB40AE3;
	Mon, 18 Aug 2025 16:52:39 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: NIKIL PAUL <snikilpaul@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,  skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 2/2 v3] docs: rcu: Replace multiple dead OLS links in
 RTFP.txt
In-Reply-To: <CAHHgkHp-oMuCfRGqL6FGrDNSi3a3HzU7uW27vUfNW7evk1m4+Q@mail.gmail.com>
References: <20250812163233.7330-2-snikilpaul@gmail.com>
 <CAHHgkHp-oMuCfRGqL6FGrDNSi3a3HzU7uW27vUfNW7evk1m4+Q@mail.gmail.com>
Date: Mon, 18 Aug 2025 10:52:38 -0600
Message-ID: <877bz08td5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

[CCs restored]

NIKIL PAUL <snikilpaul@gmail.com> writes:

> A smal follow-up, Do i need to do any more changes on this before getting accepted?
> It has two more changes which weren't in the previous version.

So I only received 2/2, so I lack some context here.  It seems you only
reposted this one patch out of the series?  When you make changes, you
need to post the whole series so that maintainers know what is going on.

Thanks,

jon

