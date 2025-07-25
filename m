Return-Path: <linux-kernel+bounces-745165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAD0B115EA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E923AE563
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BB51F0E3E;
	Fri, 25 Jul 2025 01:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uNfQ4Ypc"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B85FC0A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753407436; cv=none; b=bWkn0yT91M1zTAS7J4Rht4r5FuFlpXHjaU+NEc5ZuyoYzO1zkssAzJzfkNNpo7b1f+JHy9rn6XvrqsJbl+HfJEH91l9HIMrn2AxVwlOfOTxV+NCcswL4ig0aC1G2OHLwZlCbDsjE6wK2RvqanQerp5y2I94O4rRpiCXkGOTMM2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753407436; c=relaxed/simple;
	bh=ZovQDznqkF7J7kMTz8uO3SRnta3pooBtF53KCWVPljQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tbfddQVmWI1fmx1ZMG5dsT6beOnJ0+jZgIo0JORJgfMHavE1qyTb6faf2k60vjaniqQ9HUw2jovGYchs1Qsk5IWiLCCtpY805pFpcC/SxDnX4WmfWhSHl/JeH9ma4GM6dQxzt/AxSX/Bn4Q9VPMj2PmuP+VQHIC2pDqgR54TnIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uNfQ4Ypc; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753407425; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=ZovQDznqkF7J7kMTz8uO3SRnta3pooBtF53KCWVPljQ=;
	b=uNfQ4Ypc/PiDiML7vKZW7wRgV6BmcEU+eZK98Xy5UnGwbIcPQZli63DQZYsrPzHvwUkE+X9SmNBaogBuf1G7SAKk//cinYXiNlFVd8tZjKs2Nb0b9nzEfdRihhMijMujWt0QidEwcKSqx7XxpyWkr/7K5YXTyx5uEPggj/tDqFE=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WjudYyn_1753407422 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 09:37:03 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Huan Yang <link@vivo.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@redhat.com>,  Rik
 van Riel <riel@surriel.com>,  "Liam R. Howlett" <Liam.Howlett@oracle.com>,
  Vlastimil Babka <vbabka@suse.cz>,  Harry Yoo <harry.yoo@oracle.com>,  Xu
 Xin <xu.xin16@zte.com.cn>,  Chengming Zhou <chengming.zhou@linux.dev>,
  Mike Rapoport <rppt@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,
  Michal Hocko <mhocko@suse.com>,  Zi Yan <ziy@nvidia.com>,  Matthew Brost
 <matthew.brost@intel.com>,  Joshua Hahn <joshua.hahnjy@gmail.com>,  Rakie
 Kim <rakie.kim@sk.com>,  Byungchul Park <byungchul@sk.com>,  Gregory Price
 <gourry@gourry.net>,  Alistair Popple <apopple@nvidia.com>,  "Matthew
 Wilcox (Oracle)" <willy@infradead.org>,  Christian Brauner
 <brauner@kernel.org>,  Usama Arif <usamaarif642@gmail.com>,  Yu Zhao
 <yuzhao@google.com>,  Baolin Wang <baolin.wang@linux.alibaba.com>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] introduce PGTY_mgt_entry page_type
In-Reply-To: <40cb7d64-0b90-4561-8e10-06a808a2766a@vivo.com> (Huan Yang's
	message of "Thu, 24 Jul 2025 17:29:30 +0800")
References: <20250724084441.380404-1-link@vivo.com>
	<764c48ad-8869-4f69-898e-0a1c58684f7d@lucifer.local>
	<40cb7d64-0b90-4561-8e10-06a808a2766a@vivo.com>
Date: Fri, 25 Jul 2025 09:37:01 +0800
Message-ID: <87bjp93vb6.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Huan Yang <link@vivo.com> writes:

> =E5=9C=A8 2025/7/24 17:15, Lorenzo Stoakes =E5=86=99=E9=81=93:

[snip]

>> On Thu, Jul 24, 2025 at 04:44:28PM +0800, Huan Yang wrote:
>>> Summary
>>> =3D=3D
>>> This patchset reuses page_type to store migrate entry count during the
>>> period from migrate entry setup to removal, enabling accelerated VMA
>>> traversal when removing migrate entries, following a similar principle =
to
>>> early termination when folio is unmapped in try_to_migrate.
>>>
>>> In my self-constructed test scenario, the migration time can be reduced
>>> from over 150+ms to around 30+ms, achieving nearly a 70% performance
>>> improvement. Additionally, the flame graph shows that the proportion of
>>> remove_migration_ptes can be reduced from 80%+ to 60%+.
>> This sounds completely contrived. I don't even know if you have a use ca=
se
>> here.
>
> The test case I provided does have an amplified effect, but the
> optimization it demonstrates is real. It's just that when scaled up to
> the system level, the effect becomes difficult to observe.
>

It's more important to sell your problems than selling your code :-)

If you cannot prove that the optimization has some practical effect,
it's hard to persuade others for increased complexity.

---
Best Regards,
Huang, Ying

