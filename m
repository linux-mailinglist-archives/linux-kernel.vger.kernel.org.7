Return-Path: <linux-kernel+bounces-883852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0A6C2E92D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 01:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CFC3B568A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 00:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6703E1A9FB7;
	Tue,  4 Nov 2025 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kxfHdtZn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71E1A256E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215622; cv=none; b=LE3VDaiVgZYsmpJgPd4IxSR/j65qYdQrukasGjXslm0lFVX30IoNiowClok6j1ifmSZhEAU5gAIJr3M7mw4LfE/iL13UI6aEtDrD9PBfyrRYcyBnHK8YacqiW7OksOIN6kywl4AlKBiXJV4nZAw7oZW6jEfZRbPSFjTKmIJ34EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215622; c=relaxed/simple;
	bh=ARYJ94hkfr+wqtaTaCXJsG3Gdo7c5EgIBjp/zMCYw74=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RY28fXpJxhSgWocJWP8NFYtG1tKZYqLmeUAU4r8jpKQiqKj9tNkLx0e0IY4T0gyOXeW1g689Urrwi/cE7UHRENzO8xMjFgQGJA2FoMf3kET+QP3LPreFmXuxBV6SDS64di1IQfq1WR95b14j24hktybEqTXiMPhX/6LMRJOJfcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kxfHdtZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE24C19425;
	Tue,  4 Nov 2025 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762215621;
	bh=ARYJ94hkfr+wqtaTaCXJsG3Gdo7c5EgIBjp/zMCYw74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kxfHdtZnLR8DJe75xj8jde8hiIdLJsDODUzrkcsU3oth4EmoafaP9q1vIet2FrDF7
	 Vif5lE2/OP4CwnUL/MCo+HJX3LicBWecGw1rfvdMKv85ziXudJQm5eF/OZ1UJX5vzy
	 P0Le76leURiT1Nbr40lIbqF1bECoQ5dIJm3nBBJ0=
Date: Mon, 3 Nov 2025 16:20:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike
 Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kho: misc fixes
Message-Id: <20251103162020.ac696dbc695f9341e7a267f7@linux-foundation.org>
In-Reply-To: <20251103180235.71409-1-pratyush@kernel.org>
References: <20251103180235.71409-1-pratyush@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Nov 2025 19:02:30 +0100 Pratyush Yadav <pratyush@kernel.org> wrote:

> This series has a couple of misc fixes for KHO I discovered during code
> review and testing.
> 
> The series is based on top of [0] which has another fix for the function
> touched by patch 1. I spotted these two after sending the patch. If that
> one needs a reroll, I can combine the three into a series.
>

Things appear to be misordered here.

[1/2] "kho: fix unpreservation of higher-order vmalloc preservations"
	fixes a667300bd53f2, so it's wanted in 6.18-rcX

[2/2] "kho: warn and exit when unpreserved page wasn't preserved"
	fixes fc33e4b44b271, so it's wanted in 6.16+

So can we please have [2/2] as a standalone fix against latest -linus,
with a cc:stable?

And then [1/2] as a standalone fix against latest -linus without a
cc:stable.


Once I have those merged up we can then take a look at what to do about
the 6.19 material which is presently queued in mm-unstable.

Thanks.

