Return-Path: <linux-kernel+bounces-812167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8023EB533E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283565873F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF19332C316;
	Thu, 11 Sep 2025 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="h5q8MobS"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55085184E;
	Thu, 11 Sep 2025 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597950; cv=none; b=sFxVaxM45FTZIVnDsdw3lPwE9ElC1xvP9SCsfP7bfBPSnBACgqBIs9khJEy7Yig4geuvHarnCjwVRPXqBAiG8w3jc4PQpNcWzh3OdHtnBjRa2y7JA2NWYPuH7B0hnjqof4BdN9JhfxqVt9DHu/j5TGhaWod4hDVuSMlWD50JROQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597950; c=relaxed/simple;
	bh=BhITpaOyCg0kiAA9rkgScH1CSG96+Xse8zf3imxO7KE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FWb6Wha7dL4zd6XnP+qSBtFEDVU88NA3fhg0znnr8v/IOjUT7ujG8Hc60NqwDh5BEQUEQGNL0yvt9mvrIyqqob93tpNNjo8u0o7PNhvuy2BfZWpzLLRUD3AaA03DES8nr8VrZkbFFjmUQf+3nE1jgS3EB3cabS/B7MIwqQe4NJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=h5q8MobS; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DB0D940AE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757597937; bh=J3SqLsNgJyDKHvN19ZY09r8OGxhHJc/ev7e58fUl1ps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h5q8MobSvNmHXvKp4cbNgppohYxwSNVCGTNgObY5s0EOseMCRHBEL6x/CqCl2xnJ3
	 H9foSNQCofcrslS5Vzb+syEDVAY2JnpfP7eB/kr7i02YNzESiyRSCvz6lTau4U4hDI
	 HzxO5iKlWka4/zmOe5MEZcOTIFU2BNYq1JfcWnZ6sXAnhpTIlaDM+KMknU52LUTAPI
	 AR08dybANkiZrAa9DHKo3xHpVjqn5Yc2mEItkPg/0nqwrh0SgRX3LfjWO9BiTij4rT
	 fT5jKirElurji3iiwAq3Qe/oPBOccIn3IDgKSbwpjMYbA6sPql1fbpUTaHiuHu/QDF
	 Je0LAmD9jnSnA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DB0D940AE3;
	Thu, 11 Sep 2025 13:38:56 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jani Nikula
 <jani.nikula@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Alice
 Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
In-Reply-To: <fuv4p45tvjfdvwu2625s2l2kvcw64p4ohherlwyum3vmogmrfz@yb47nt66xgm6>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
 <e13837a0ac46dffe39c600d11fdf33f538bdc9c3@intel.com>
 <20250910145926.453f5441@foz.lan>
 <45888ca6c88071c754784495b4ef69460ea67b4f@intel.com>
 <fuv4p45tvjfdvwu2625s2l2kvcw64p4ohherlwyum3vmogmrfz@yb47nt66xgm6>
Date: Thu, 11 Sep 2025 07:38:56 -0600
Message-ID: <87zfb1p0r3.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> On Thu, Sep 11, 2025 at 01:23:55PM +0300, Jani Nikula wrote:
>> > 1. SPHINXDIRS. It needs a lot of magic to work, both before running
>> >    sphinx-build and after (inside conf.py);
>> 
>> Makes you wonder if that's the right solution to the original
>> problem. It was added as a kind of hack, and it stuck.
>
> The problem is, IMHO, due to the lack of flexibility of sphinx-build:
> It should have a way on it to do partial documentation builds.

A couple of times I have looked into using intersphinx, making each book
into an actually separate book.  The thing I always run into is that
doing a complete docs build, with working references, would require
building everything twice.  This is probably worth another attempt one
of these years...

jon

