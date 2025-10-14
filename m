Return-Path: <linux-kernel+bounces-852956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 356FDBDA50A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D6C74E7510
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F48C301021;
	Tue, 14 Oct 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="fAHzSTqz"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A583009E6;
	Tue, 14 Oct 2025 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454908; cv=none; b=Tx6paOpDbOB+Gt7n2ZVqmaFOoNNXRm5xgw9mNvzv29+2+K6s0nCP3kINBB4EqGAfxkL0de741HJ9Bo1QMdrm2rFBvAnqxaJ4dzBPu+HwnvhGAiKzSZwzSSXxl4KvjMFELF9Mt0x6T3Xh9SJJ7k+q1fwS/9pkzIN29CqqiML/qQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454908; c=relaxed/simple;
	bh=m0i1QUBh4zJhtP8fKiyIIyRlwPYD2o/aXoX6SdDe2oI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n1ifeS2EfgZx9W+ugT95+SN4wldrRALmqhPiz21GKcW7t5tx1SuvMyAgwF4bB7SsjpyxJqTSGHZq52Nm9XzKJUPJB+nOxrGYjaeeUDvNZmO0grJbTuLULyq/l1drT0tKw9Ps0xQqGtubUf2Jsw0CqHcgrznAeRRcrJwa6oI+SzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=fAHzSTqz; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CD5D840B1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760454903; bh=m0i1QUBh4zJhtP8fKiyIIyRlwPYD2o/aXoX6SdDe2oI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fAHzSTqzngYXdnjB5R3lpag4tKXHXZME8EcB/Up/vM7PoU5MrU9jwB0qsiRpA9vve
	 50F9/438qkvYdb3VFif0VQuBWYGYVxrNy14bmG09Z1usYZCZQBkVCzK3STWVTW1F/r
	 ng2Lm+RzLAaRZjrsh3yXEN3OHvMizzT2ObbHwQWqNaAJ/A3elj+GMdaEydMFPGyFZ/
	 jeMtMOeEr06wPMveKF3csaIPKGwxMVOhmEWYyypV3vSVZHIZDXc0GLEjrOp4VT6KD+
	 tQMxcPAgm9uMGZRJ5U9xEKMbiPnyst1HjqfWkjKjdrDYEa9w8Hfsel8t2tuoAef3Lv
	 cMAE2rk+8g+Qw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CD5D840B1E;
	Tue, 14 Oct 2025 15:15:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Workflows
 <workflows@vger.kernel.org>
Cc: Dante Strock <dantestrock@hotmail.com>, Randy Dunlap
 <rdunlap@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] Documentation: process: Arbitrarily bump kernel
 major version number
In-Reply-To: <20250922074219.26241-1-bagasdotme@gmail.com>
References: <20250922074219.26241-1-bagasdotme@gmail.com>
Date: Tue, 14 Oct 2025 09:15:01 -0600
Message-ID: <87bjm9bjm2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> The big picture section of 2.Process.rst currently hardcodes major
> version number to 5 since fb0e0ffe7fc8e0 ("Documentation: bring process
> docs up to date"). As it can get outdated when it is actually
> incremented (the recent is 6 and will be 7 in the near future),
> arbitrarily bump it to 9, giving a headroom for a decade.
>
> Note that the version number examples are kept to illustrate the
> numbering scheme.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

I made a minor tweak to make it clear that 9.x is an example; applied,
thanks.

jon

