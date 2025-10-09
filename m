Return-Path: <linux-kernel+bounces-846177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 320FBBC7332
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37EF019E2A53
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C8417BB35;
	Thu,  9 Oct 2025 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ObfaIH+t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE75534BA3C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759977147; cv=none; b=NwmxQsC5ZRBh+BHrttxdd70ZpXWJTD85ZRrAjCTdf4CAHyaQhhpkQ/y6ROAtHTp1wmCn23s/odVulAmC3tGyBmSVhHpnpq7OZgLyemQonAjaLFQ0Ip8zR9Is9z4l/sLNtcuhK3t8uHpZ4p8jss/8M/xhTmQRVvEGPblaLu9eodU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759977147; c=relaxed/simple;
	bh=aANUMzra9J3BotN1T1buLbHq3slzrJ2oZxv61EPpeoQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=q/GqjygPB/VQRUcbxBuxoTaQ9M8W8fvJ7TkQKPOp1fr0NL/lAA8j/XR2QNjnVlRTOBhJkE2TN5t/FntGpT4PhrnZd5vGuPedMPoc1cXKC3ieROTPKe/P3bdfwjdhrJrQoq7HUrKWksQPhbJOKkhE2quW+krOBNsjlQdG9vfFP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ObfaIH+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DCEC4CEE7;
	Thu,  9 Oct 2025 02:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1759977144;
	bh=aANUMzra9J3BotN1T1buLbHq3slzrJ2oZxv61EPpeoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ObfaIH+txn/i4w0eUr3hbUPklaxbCmSwjEVRn+6Aq5Bxyd/+REQ3ZA15m3bEeIdKa
	 XrXESA/rhCbSKSDChWkZ3NqpJ9lotRfe+kHClC3klKTTUrXJZv3GoK+P4OZEVpRB76
	 DU0gAKxwezMq6Oo2XeSq8iaradXWQ0tngo+lfLUs=
Date: Wed, 8 Oct 2025 19:32:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar
 Salvador <osalvador@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v2 0/5] mm/page_owner: add debugfs files 'show_handles'
 and 'show_stacks_handles'
Message-Id: <20251008193223.f0e7c243bef94b7db22070fb@linux-foundation.org>
In-Reply-To: <20251001175611.575861-1-mfo@igalia.com>
References: <20251001175611.575861-1-mfo@igalia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 Oct 2025 14:56:06 -0300 Mauricio Faria de Oliveira <mfo@igalia.com> wrote:

> Fortunately, the kernel can provide a unique identifier for stack traces
> in page_owner, which is the handle number in stackdepot. This eliminates
> the need for creating keys (hashing) in userspace during post-processing.

Looks nice, thanks.

I'm surprised that our in-tree userspace tooling for page_owner seems
rather weak.  Nobody has touched tools/mm/page_owner_sort.c in two
years.

