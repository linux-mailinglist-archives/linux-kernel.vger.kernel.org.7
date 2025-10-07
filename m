Return-Path: <linux-kernel+bounces-844827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EBBBC2DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F272319A25ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F53025742C;
	Tue,  7 Oct 2025 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ukVAcROf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0223B23BCF0
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875871; cv=none; b=WyrD/mdjxsv9TFGPDKRMDhXz4whQAblcqux4MpVXU7glu2WP6kmidBt5mpAA+dmThsa72ur5dpY1r/n7plW8AYTgPYfHL41YX6sNOvhM4vhvCKg6b+3k2Br1xZTUopmV0gK3A7aWxV+8Pg+9PFL1MfhIkphEYBpgjGxxX4ysCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875871; c=relaxed/simple;
	bh=Ml84U/0i9HzLrJRmaMZo5f7luB6RAPc/Szfx7x8g9tc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PpdAEnF+HDhsWzFWcJZ2biSVjVAF5UzOfq9ibLXIEtNrRPP1DiMIekc0stL2QNSRgruAljKR06IWVxA4Vq7e3P0I0p47a5FTpnLNYmSzM31V12lSHmd0i/m2TrJDE/VKwNALQJwZqAX3Oef285sQT61zy5xWDb2HGyOPgqrAazY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ukVAcROf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B19C4CEF1;
	Tue,  7 Oct 2025 22:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1759875870;
	bh=Ml84U/0i9HzLrJRmaMZo5f7luB6RAPc/Szfx7x8g9tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ukVAcROf2a+EK00QUVF/+Th7XtbBmcf75QzTUS5DkMOhQeTmhSUDaHWOcQeDG5qPl
	 tiq6f7AjnoSWOaECe6PHNsHURztv/YQJbCdKcJY74XphlttG9dYewY7jaeO2D1evAE
	 bS1dBJJBf2QspWIlOKXJqpeU/Aato4K68DMlAZGs=
Date: Tue, 7 Oct 2025 15:24:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@redhat.com,
 linux-mm@kvack.org, hannes@cmpxchg.org, riel@surriel.com, kas@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/hugetlb: allow overcommitting gigantic hugepages
Message-Id: <20251007152429.4c28fb85205635703229b027@linux-foundation.org>
In-Reply-To: <20251006185607.3257340-1-usamaarif642@gmail.com>
References: <20251006185607.3257340-1-usamaarif642@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Oct 2025 19:56:07 +0100 Usama Arif <usamaarif642@gmail.com> wrote:

> Currently, gigantic hugepages cannot use the overcommit mechanism
> (nr_overcommit_hugepages), forcing users to permanently reserve memory via
> nr_hugepages even when pages might not be actively used.
> 

Why did we do that?  Just an oversight?

> -	if (hstate_is_gigantic(h))
> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())

> -	if (hstate_is_gigantic(h))
> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())

> -	if (write && hstate_is_gigantic(h))
> +	if (write && hstate_is_gigantic(h) && !gigantic_page_runtime_supported())

Maybe a little helper for this?

(Little helpers are nice sites for code comments!)

