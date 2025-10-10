Return-Path: <linux-kernel+bounces-848646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A50BCE3FA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E4EA4E3A57
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9173C2FD7D5;
	Fri, 10 Oct 2025 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7WA4es9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2FB2FE576
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760121033; cv=none; b=kotAXMZi9gJTDkUdFGMbE1qiEu3r4ge5cQxbdedXKe/sAv2XdqgydKJcjZXjEfUb3j+kV1nuxgYamOzpuf72HZ+WEIL/MRQ5cryvT9lHwP51zyK7UYpKEDNnyqttb/EXpaamYi6mXcI1zLse71hbGUqr1rlqUgdJFJe2Ri60ZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760121033; c=relaxed/simple;
	bh=ZOZnVWbV81iSXnE0N2FIQPShPP0gpWUpU8VYEUonzrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XsSiGRns4mNTEx2ihdsW6wHd2IYQor/I3012NSVebOnb001q/8k61Q+nkINuMSZ0UbV2DSMq0nV5kRXHq/gincOBjEIu/ynToxUo6gcFDU9cSumuya+y18/Gtp0GxMg//4mqgZuZTpTZVRvsb5meUgJykTiP4JOQJt1VRrpxSws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7WA4es9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0724AC4CEF1;
	Fri, 10 Oct 2025 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760121032;
	bh=ZOZnVWbV81iSXnE0N2FIQPShPP0gpWUpU8VYEUonzrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K7WA4es9SynWyANpqnqALfOUgPoQ6uML85h6viExq4n23365KY2PRssrh5M6AqSJR
	 YGCdBtQdoYaCfnMX+nTFvkpqQVuPVm9QqenbOR5jA9ljOHVrB9tLLLnjkDisBOM9GU
	 EIwWD5+GVOhgF6PmE4Q6e0MQMvUrV6jQYdQkN972tFI25gaRSXn6ffuG62UiEtd6X9
	 iVzrW139Tr+Pobrtuipb1JgVpkFO+YAefhggCiKD+JLz+/TYeEwn8uruwxzcb9Wmez
	 ZOT+02GDcuQS2n8G+8mZNXW2LjIJ5hGvXp22SwnWDyBn5t2PJSuS51e+9Bhj+VGsjA
	 M7tzh6PN6uglQ==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3 1/3] mm/page_alloc/vmstat: Simplify refresh_cpu_vm_stats change detection
Date: Fri, 10 Oct 2025 11:30:29 -0700
Message-Id: <20251010183029.68434-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002204636.4016712-2-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  2 Oct 2025 13:46:31 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Currently, refresh_cpu_vm_stats returns an int, indicating how many
> changes were made during its updates. Using this information, callers
> like vmstat_update can heuristically determine if more work will be done
> in the future.
> 
> However, all of refresh_cpu_vm_stats's callers either (a) ignore the
> result, only caring about performing the updates, or (b) only care about
> whether changes were made, but not *how many* changes were made.
> 
> Simplify the code by returning a bool instead to indicate if updates
> were made.
> 
> In addition, simplify fold_diff and decay_pcp_high to return a bool
> for the same reason.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

