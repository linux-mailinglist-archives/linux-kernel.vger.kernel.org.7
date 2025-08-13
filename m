Return-Path: <linux-kernel+bounces-766238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EADAB24435
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532B71BC17DD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D232EFD82;
	Wed, 13 Aug 2025 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6WQDYQo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58442EA172
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073282; cv=none; b=CxrwUcsMlLAQi6iBY6qQ5e3kISOgokEyBasNmFmTEiV1hGA47/Jz9mM0LSgOfdHUwDC9nQ9hqsWVYOhzqhlxDVw8oblxLrFvC5iNHGXFs2zYUX5jb10tippTJDSy4Uo4ntlVw60JY9JHkB3dXj7MwSBz5cwLrO4bOivFIQs7bsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073282; c=relaxed/simple;
	bh=yhBdBDcSunhilhQ/pLGoZ62EZ7ieGf8uO+xCa6kR1EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5iBTTb4z9knwOH6a723Z9RTmE4o6PY8XAuXOS54A1hyLOJlfE0Db4CQQO63gelE+kUCM8TJwAts1ddYNj1j6tm9OGsLPWS4Q6LmQ54zg/V+GGzxCSkncoAfK9onBxGspLyqAl6zwDKeZ7xkWt3K66/AQflmjLFwGdLm0koZIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6WQDYQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CEDC4CEEB;
	Wed, 13 Aug 2025 08:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755073282;
	bh=yhBdBDcSunhilhQ/pLGoZ62EZ7ieGf8uO+xCa6kR1EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r6WQDYQoBPHnofiXPJ4qmdczWv69WGBwibh1MmP4Fjl2Qtdd/URJMktaPsRbIsYlW
	 15c8wd/lXfLWHpWiMVVLdLYbHQ2ne1hMDvSrmoL/pSjh3Asp+kyaWal/YCfQkcMAjQ
	 +h17hH0xHR5mu+5TG0TW7w1IyoV/W5ASKoWtLeshtCnyBZAc8mdnWg5hndqpGDKt9Q
	 IftQbXR3Uo1QCqgIKLE5EIfxo1Am6K4umMw0+dpB6td6WDyJcTrfb8yk5mnhoEFF0B
	 tK6LAtZsBpY5Agn5WhlxpHzn/dQeQPfWwu6jcqE+IQ6CphPR3nhGoZpllqP2J+q7QV
	 XBQqdO4LypEVA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	pratyush.brahma@oss.qualcomm.com
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3] mm/numa_memblks: Use pr_debug instead of printk(KERN_DEBUG)
Date: Wed, 13 Aug 2025 11:21:06 +0300
Message-ID: <175507323699.801708.6071992016913841165.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250813-numa-dbg-v3-1-1dcd1234fcc5@oss.qualcomm.com>
References: <20250813-numa-dbg-v3-1-1dcd1234fcc5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Wed, 13 Aug 2025 12:51:02 +0530, pratyush.brahma@oss.qualcomm.com wrote:
> Replace the direct usage of printk(KERN_DEBUG ...) with pr_debug(...) to
> align with the consistent `pr_*` API usage within the file.
> 
> 

Applied to fixes branch of memblock.git tree, thanks!

[1/1] mm/numa_memblks: Use pr_debug instead of printk(KERN_DEBUG)
      commit: d045c3154080a04beb07726fa311b89d21608981

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: fixes

--
Sincerely yours,
Mike.


