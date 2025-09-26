Return-Path: <linux-kernel+bounces-833584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72536BA257E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7A83B1E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33140262FED;
	Fri, 26 Sep 2025 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCwLjwOC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC3F1EBFFF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758857870; cv=none; b=m/AkNnYNqcrfSumwGvCpLeNZo3k9sMtjFNK953zgue5xJEKo8Z5FWMIUlq+k3HJVr5bftPL8a4BKIgQVT+lcL0vpW/6M2/MiykCGte/Y4dY0TFIon2wB99YdSmZ2xziD3lfwBCMAGYuzZGZNEvdqcMUri/Fp0CxPaNDkB8NDizM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758857870; c=relaxed/simple;
	bh=Z8ymzU8QK2Rz1EhzcD996ZhA/fhIRvQiH7h5v9ptZYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAjTeo6JdT2ni16+KWkv6tS2vqd8DdtihcxfamStXDD544lEKLtGEfdT+cHmfmrhCLQheW89U3SqK+JqxPpfj9v7thqHVQTmgQSMp0cWzz/R9AfFnmRKXOG0oW49HOijlFMesAZDUEZlw6kMJhCyVy4oVyn41MDjDAh/Um2PpPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCwLjwOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CC7C4CEF0;
	Fri, 26 Sep 2025 03:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758857870;
	bh=Z8ymzU8QK2Rz1EhzcD996ZhA/fhIRvQiH7h5v9ptZYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCwLjwOCVeh6BUxuvTk6f03h9vvDiJxi9sWYZIdOV1KuBn5qTCvO0TsnXm0ctD9Gx
	 0x2gxqbU2GJtRN4babQFKjKo0KfKN9+QsW2SClYX/6WkBkjhT8befTRIiY3H4Ea75L
	 N5CYsYqdYd+Zd+i73vv2rLDTRwNOsLCDCKc0XsouHDNV76sSd7c3d14s4dpgPn6S8P
	 v5GAhhwAEaNef2SNhPM7dov7BKPSe78f5yK4S3Xs54ZK52tH44ixpO6z1Zyh1Lbllf
	 IYEph7qy1CLk3KdPTYH3ItlhgCOpF/qqodxokwyFgg2ZjLs3JBMo+Lh5b9YcCCn37S
	 /LtnOZ7i3Wyrw==
Date: Thu, 25 Sep 2025 20:37:49 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alejandro Colomar <alx@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christopher Bazley <chris.bazley.wg14@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1 0/3] Add ENDOF(), and use it to fix off-by-one bugs
Message-ID: <202509252007.E9D3C14@keescook>
References: <cover.1758806023.git.alx@kernel.org>
 <20250925134814.1f68d84a951572245893abbe@linux-foundation.org>
 <202509251657.F4ED4CF@keescook>
 <CAHk-=wg2M+v5wFQLK3u3DuchpCbuHF8Z7_if3=foECVRXF+8vg@mail.gmail.com>
 <202509251823.1B974C7@keescook>
 <CAHk-=witf7e1QRp29tAeHLB34HuBSO5G7q82cmd-mAPSt+0JVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=witf7e1QRp29tAeHLB34HuBSO5G7q82cmd-mAPSt+0JVg@mail.gmail.com>

On Thu, Sep 25, 2025 at 07:36:13PM -0700, Linus Torvalds wrote:
> The thing is, the "start+len" model is actually *safer* than the
> "start+len-1" model.

Sure. But start + len is a vector: "start" is a pointer, and "len" is a
size. No problems at all.

> Obviously you cannot dereference a zero-sized object, but zero-sized
> objects aren't "wrong" per se.

Right, totally agreed. I'm a big fan of zero-sized objects which are
useful in all kinds of situations (e.g. empty flexible arrays). And
as you're saying, a zero-sized object shares the same representation:
start + len where len is 0.

What I dislike is having this vector collapsed into a pointer because
it loses its explicit start/len information, and becomes ambiguous. And
worse we have nothing that says "this pointer isn't safe to dereference".

All the bounds safety work we've been doing lately is mostly centered
around finding ways to retain the "len" part of dynamically sized object
pointers so we can reconstruct the vector unambiguously.

Anyway, yay for vectors. :)

-Kees

-- 
Kees Cook

