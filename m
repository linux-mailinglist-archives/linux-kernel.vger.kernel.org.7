Return-Path: <linux-kernel+bounces-757035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEB4B1BCCA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8E418A4199
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA21021FF4C;
	Tue,  5 Aug 2025 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DaDw12F/"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FACD221DB6;
	Tue,  5 Aug 2025 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754433985; cv=none; b=FOpZ97QzCJZLe0SFhI8RMupRCnVPc32dI+P6fapDfVyR3aEbRxRNqUIlk34NKrLvlhwLqhlJ78Z4/bj6V7Y7CZtXwDocaqLXJ0OtAOApZBYRJT19jKT65juilGXhheBwRiifkaFH3dQ0+toqAGu8Tn0ix+viLwvA+pBqjN3lgLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754433985; c=relaxed/simple;
	bh=rX+rRKTtvMPKWDm9tJXAz+kJfWbbm+FiFfp2ba4OJL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PSqCo32jbH2bh8wnN5OXv+WjYPvkPD0DRc1wD9N0CQwiYlml1gZerTR7jyl0aOfkgH8Y7E/MH4RN1VOWuwsqc1ufokAjsIgAGUzpzDp1u4AhwJoYaANJ09rsn+oU+fLyAWPEY56m5Ex2uLQyz5Y0tPuT4u2b5Iva72dDKc0ycdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DaDw12F/; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BEA3940AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754433971; bh=RdpQo7jAReEyWC1pvuPCfemKLhTOM/+GymqNSoWjQ18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DaDw12F/j/FKnYhTMxiv5JVWBgOpDIz4ZQViYthLWPXWPACZ+9sgbQycr2RxCcR7D
	 hVqTg0Od08dgOxDQszA7EJW/HbQgDrxOoow/MsllmqFF244j/bMb4wU4SbZ/E2C6P6
	 PDPSVY9d+UvqqrKnp+PcElaVV6/8tUW9W2xDj8shfXFaSULoO2p6ipVxxFwzeB1XqG
	 AWO9CdYReDsY/TzshPig42cMXMeATCZUzBEo8PWknrDjzKl+1MVv+XbCcqi0gBxiZy
	 pVyXVDaa+5pQYprun3sEGvtZxn9E2UPQ/bBXe/Jj8l0QnR+iaeMao1Um4+JfdVpjQe
	 MWCrFivhWx4cA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BEA3940AD5;
	Tue,  5 Aug 2025 22:46:11 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 10/12] docs: kdoc: further rewrite_struct_members() cleanup
In-Reply-To: <20250804151511.73ffb949@foz.lan>
References: <20250801001326.924276-1-corbet@lwn.net>
 <20250801001326.924276-11-corbet@lwn.net>
 <20250801080744.14f83626@foz.lan> <87v7n6pscu.fsf@trenco.lwn.net>
 <20250804151511.73ffb949@foz.lan>
Date: Tue, 05 Aug 2025 16:46:10 -0600
Message-ID: <87ms8djsjx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Perhaps one alternative would do something like:
>
> 	tuples = struct_members.findall(members)
>         if not tuples:
>             break
>
> 	maintype, -, -, content, -, s_ids = tuples
>
> (assuming that we don't need t[1], t[2] and t[4] here)
>
> Btw, on this specific case, better to use non-capture group matches
> to avoid those "empty" spaces, e.g. (if I got it right):

The problem is this line here:

                oldmember = "".join(t) # Reconstruct the original formatting

The regex *has* to capture the entire match string so that it can be
reconstructed back to its original form, which we need to edit the full
list of members later on.

This code could use a deep rethink, but it works for now :)

Thanks,

jon

