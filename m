Return-Path: <linux-kernel+bounces-776981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A9CB2D3B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D41A1C421C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8646129C327;
	Wed, 20 Aug 2025 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1JkOaB6i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088F19D8A8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668472; cv=none; b=Rxxvldx+f0sqHnF1GH4u6d76liRuzljxgkxYG/Wc3hPSQbE7brCTN5ppKL3YEHar50XyHvxiw1qyfY58zH3n68HSa3mtSb4ao0iatMFklEyhK4MxIeXiQ/fIKs9t7pdgGvS+YwFY0hooPkSyP64pLAGiiP6LXR6VpvAqWQVrBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668472; c=relaxed/simple;
	bh=sJbRMZ3dzMihdohhvVLrwvHrGo59fz+haIPct8foZ4Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fksE02T897U9KFN2mP97TNFLW4JLfiHk2gFR98o/dCO1sviN8FxKvwtvwMFSteeQqUo87ESZfB9OuO4cvUk/T4agw1oNkDxZlKSpCx/PUKzHzdQS2auSDRu9gnbAha1HgMAvSgKNKLf0VV6iqyvaipgNBx3pUx3jJ6px3ANCut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1JkOaB6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE618C4CEEB;
	Wed, 20 Aug 2025 05:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755668472;
	bh=sJbRMZ3dzMihdohhvVLrwvHrGo59fz+haIPct8foZ4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1JkOaB6ia1UgG2tx2yeCD5I6d69KDl5YYU8TGj8hJLynPffr2A2fqGrt4v/GUIkTb
	 UDUItDtyJVtxG/Q5n/egJnaDiez4L9MDZrI12FAhYWS9mzqaHKek0MAq0ahDtwaRx+
	 /Z0cnDDhMFSmJrwf8P3LgXR6mMjKM9ey/BGPXiw4=
Date: Tue, 19 Aug 2025 22:41:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Chris Mason <clm@fb.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@gogle.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, Zi
 Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH] mm/page_alloc: Occasionally relinquish zone lock in
 batch freeing
Message-Id: <20250819224111.e710eab683b7c7f941c7d1a7@linux-foundation.org>
In-Reply-To: <20250818185804.21044-1-joshua.hahnjy@gmail.com>
References: <20250818185804.21044-1-joshua.hahnjy@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 11:58:03 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> While testing workloads with high sustained memory pressure on large machines
> (1TB memory, 316 CPUs), we saw an unexpectedly high number of softlockups.
> Further investigation showed that the lock in free_pcppages_bulk was being held
> for a long time, even being held while 2k+ pages were being freed.

It would be interesting to share some of those softlockup traces.

We have this CONFIG_PCP_BATCH_SCALE_MAX which appears to exist to
address precisely this issue.  But only about half of the
free_pcppages_bulk() callers actually honor it.

So perhaps the fix is to fix the callers which forgot to implement this?

- decay_pcp_high() tried to implement CONFIG_PCP_BATCH_SCALE_MAX, but
  that code hurts my brain.

- drain_pages_zone() implements it but, regrettably, doesn't use it
  to periodically release pcp->lock.  Room for improvement there.



