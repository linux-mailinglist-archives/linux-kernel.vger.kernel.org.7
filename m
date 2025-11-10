Return-Path: <linux-kernel+bounces-893481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F230C478A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43C83B61A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538A22206B1;
	Mon, 10 Nov 2025 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rjs7pjQA"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92D41DDA24
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787973; cv=none; b=huGHK9Xnn+Me7/z2VLczVRMuwNNDrRxz6tKM5b0H2YHxe+zKF60flgSXTCr455Y1ErwFjvf3FfOmdEDLxM+OXFg8rdJb2yBMKDoT/KBpiNGgTVR5UUEom6WGcqb5Q0gfOwQ5Oo6KTqg+cOR7IZtd6CYWiAkPk5nzxuPYPp6U0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787973; c=relaxed/simple;
	bh=niJrzGhjH3aPUYN0kaqkNxtfinbB5vdDXxUzdwr2IB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aZF6u2p5sec0XJcebQE6UNU9E6libzN5JmXa7XG3zE14C3tRqyVKTbTSNVf7xAsggHEoUDKz4s5QE6rEg9ia51cgM37AU4DSx+Ef0ynnkqCHvGAESb02WSOgD9d5ATYRrhvZ0YShO58KfbsNdRKwyK7d82MOqJulyau2loDcVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=rjs7pjQA; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 68A1340B1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762787965; bh=hj5Plf1lhQlM2Bx3nEELWiwLqFOKs9Lw5lgdxyTwsLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rjs7pjQAqGsBOoHRNG3gMBUo+nlDboYR+tieYVPnl2F29/8AILQQl+leDv2KNw/mS
	 Zy4gB3XuLeyLDOi5UQkM+4zUByiYB2uZaNIxrnlce60155JsmMDphb5bOKCUgC8gHG
	 Fw3RkAWFnq3xY6eryXvOAyPa7eLqUCM7RX+cy9BOgp/Y2ylT+eFzbgRzoSDKxkGVy6
	 HFOXv9IOZ4sm/vHC8t4FVaSRN4NgKWSwNwsK0jugbjhdBgokKQjm9GofYAFKX82H6q
	 Bn5r7A84IJHJWIYnAECrOKEgFZSJLlppFJ/XGdfa8d2ENbR9uZKeKgGGNg1XAG3vB1
	 RUB8rug2F1OOA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 68A1340B1B;
	Mon, 10 Nov 2025 15:19:25 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dave Hansen
 <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Dan
 Williams <dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>, Sasha
 Levin <sashal@kernel.org>, Kees Cook <kees@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, Shuah Khan
 <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
In-Reply-To: <11eaf7fa-27d0-4a57-abf0-5f24c918966c@lucifer.local>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
 <11eaf7fa-27d0-4a57-abf0-5f24c918966c@lucifer.local>
Date: Mon, 10 Nov 2025 08:19:24 -0700
Message-ID: <87h5v1zzib.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Stoakes <lorenzo.stoakes@oracle.com> writes:

> It also seems slightly odd to produce this in advance of the maintainer's
> summit, as I felt there was some agreement that the topic should be discussed
> there?
>
> Obviously there may be very good reasons for this but it'd be good for
> them to be clarified and those who engaged in these discussions to be
> cc'd also (or at least ping on threads linking!)

The reasoning, from my point of view at least, was to have a starting
point for the Maintainers Summit discussion.  Trying to start from
scratch in Tokyo seems unlikely to get us far.

jon

