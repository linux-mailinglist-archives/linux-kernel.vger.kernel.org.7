Return-Path: <linux-kernel+bounces-834753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B79C2BA56E6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 02:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9B416BDCD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334421D61BB;
	Sat, 27 Sep 2025 00:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="W3TSx0qN"
Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF01547F2
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 00:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758934004; cv=none; b=p9yOqORlEnsUiZXHKHa2QK9o5YkGOHnecDktBo8CZTSXA9CYUT8DDjMJAAm4w18nk0Hr0doHj3gpO6C94msLIVBFqV1fi8EbQXb9R6GqnqRQEnTvXWubhrXrPzuTJpRWovF+Qamdmz/oZLce+CwMCRo9PApHg27jJrkKT4QlvpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758934004; c=relaxed/simple;
	bh=/gj5aSc5aXYD/0A82R6sE0UU5SgRgj4nk61e0soPBBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPte5Vt1NGPBvxRcB9LQfufGVDhbHjlbOaoVPP5PDjbGVEBgFoa/2pnJjxkqI7gjJ0z59EXlIx6l4Sy6XN9/BNhRNWz9yCZwgno4qlyuofD0g2InlTUI1gOQmikrkPRuCBStTY+tnUhd8cAroOtdqzo+WTon0ru6wUikruRtmGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=W3TSx0qN; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758933996;
	bh=9cnyeesIhcUrYexD4eZfyUD5rAtsW99qBCL0U3oqSJo=;
	h=From:Subject:Date:Message-ID;
	b=W3TSx0qNdSMtvI6GF7OAUXTg3GPBWpoOxZTZAo5Gp87ffExR3UR/2JqOHr5s617wz
	 hmANuqKC9tpoxwkONWzkieDyVr/HrZdn1aBi3CZq1kFgzx5FuGe6ptnkaH6bxI1sBJ
	 uTzfLic4y4euVXL0q2t9cJrWv/r7ieIcgRqy6Q6o=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68D733E100003FC0; Sat, 27 Sep 2025 08:46:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8362056685430
X-SMAIL-UIID: 6AE58A0D45A640499DF9C2884A90FC74-20250927-084626-1
From: Hillf Danton <hdanton@sina.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in drain_pages_zone
Date: Sat, 27 Sep 2025 08:46:15 +0800
Message-ID: <20250927004617.7667-1-hdanton@sina.com>
In-Reply-To: <20250924204409.1706524-3-joshua.hahnjy@gmail.com>
References: <20250924204409.1706524-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Sep 2025 13:44:06 -0700 Joshua Hahn wrote:
> drain_pages_zone completely drains a zone of its pcp free pages by
> repeatedly calling free_pcppages_bulk until pcp->count reaches 0.
> In this loop, it already performs batched calls to ensure that
> free_pcppages_bulk isn't called to free too many pages at once, and
> relinquishes & reacquires the lock between each call to prevent
> lock starvation from other processes.
> 
> However, the current batching does not prevent lock starvation. The
> current implementation creates batches of
> pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX, which has been seen in
> Meta workloads to be up to 64 << 5 == 2048 pages.
> 
> While it is true that CONFIG_PCP_BATCH_SCALE_MAX is a config and
> indeed can be adjusted by the system admin to be any number from
> 0 to 6, it's default value of 5 is still too high to be reasonable for
> any system.
> 
> Instead, let's create batches of pcp->batch pages, which gives a more
> reasonable 64 pages per call to free_pcppages_bulk. This gives other
> processes a chance to grab the lock and prevents starvation. Each

Feel free to make it clear, which lock is contended, pcp->lock or
zone->lock, or both, to help understand the starvation.

If the zone lock is hot, why did numa node fail to mitigate the contension,
given workloads tested with high sustained memory pressure on large machines
in the Meta fleet (1Tb memory, 316 CPUs)?

Can the contension be observed with tight memory pressure but not highly tight? 
If not, it is due to misconfigure in the user space, no?

> individual call to drain_pages_zone may take longer, but we avoid the
> worst case scenario of completely starving out other system-critical
> threads from acquiring the pcp lock while 2048 pages are freed
> one-by-one.

