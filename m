Return-Path: <linux-kernel+bounces-774110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E54B2AEBC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3A96820E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F34C343D8E;
	Mon, 18 Aug 2025 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="M5AnROQH"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B6F342C9C;
	Mon, 18 Aug 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536384; cv=none; b=bfzWlUSYFVE1bnWseVhg4/1/CkoXiIt0e6BxJ1Z8eTSKGsfGcNDEx8qJeS7wURSc24uFphkwzBmYYAkY0Oucni71PiRamqw30His//9djWEp/FmAzZwm8K1E5RF1hhIBvl6d2uc7k6Ixzf307UiBqk0PfaYvEhkhLsvbC7gyamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536384; c=relaxed/simple;
	bh=jVGUJdfuelknMrQ5oIRVNpJtGkFaYNTgSi4oN2ASd88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dW/yUmFu0iiuL3lEWJW39tAsNYKxQdfuaCttlqnUU24MlV43y72ONMc8gRo5yUWfTk6C8AbED1FNH3HasyETwuWs3HcawzAZq5xegxZOJX8Iobnxprj+HbE7BPT7lAKSTgPj3fVYgGZTbpxm7JRYsqjP37pX7479hKnnMnWf9ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=M5AnROQH; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C7CF140AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755536382; bh=+idU5yRZqXaPZBns4dRRW451dtspMQP68FTyOzIey4U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M5AnROQHkYsGbEoatKA10oeIyLu3dE61gnmpo+OL10FIePPzTIs+7oZP5JX2TUuPd
	 2qFUWN11getzFYjkHJuBox65yzyjNRHuwaV4OsFOZjpEk95JewcrLc72rJgZsrbdCK
	 p9O1g5dg/Jt3xm45yEt/u9QpBLhr8d+RpF5MrhZDubBH0TkSab8gq8jnMkAM2fHxQ4
	 YL8jpuDhby+4qSRc4KtVLfQWIZ3bFoWZzAfGJjW3adKDaYAaHDELUkdVfKVw/7fZjY
	 rcIRqNVv9JXVDhCj8uC8fxSqwCknht+YJsSHBhowciZaPZzTnRDpubisGp7xctsozb
	 mywH+wwmCbzjA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C7CF140AB4;
	Mon, 18 Aug 2025 16:59:41 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akira Yokosawa <akiyks@gmail.com>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
In-Reply-To: <acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
 <773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
 <20250816135538.733b80d3@foz.lan>
 <acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
Date: Mon, 18 Aug 2025 10:59:41 -0600
Message-ID: <87349o8t1e.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akira Yokosawa <akiyks@gmail.com> writes:

Just as an aside:

> It's getting really hard for me to keep up with your pace of changes
> in doc build scripts, really.

I can relate ... it's been busy lately, and perhaps I haven't helped
either.  But I do, very much, appreciate your attention to this work and
your review effort.

Thanks,

jon

