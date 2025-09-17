Return-Path: <linux-kernel+bounces-821305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B0FB80ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DB357ACD10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC772FD7C7;
	Wed, 17 Sep 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpucwN7v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77C2F9C2A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125675; cv=none; b=eWcDV4Wq1EgmMt8I66kCPBRiLdNffPahV3GAuGz5VYUPodHiBeO98BoqimtCHbqrdu2S2WWZ6/iA3rci6TMRmmIbVCFcJgRfGEAMcqK3DqkHFJd/JL90SIPzq0BndO/D/oFGrg6iP8UoPgdUYeB5T/JZJSQt9BqkHixYn+ItEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125675; c=relaxed/simple;
	bh=GCsBS5m7MCqJPnLz24lD//JDAj5Is8wBCI9hodf7iV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QiL5Zq1l0V2280PydseXqTsZGz5TD8eW0mc6o577S/+RNrROZR2SjMn6ima8lmDSdrQIJR9zEogVuTKD0kDMQToqBr9nBiixTyHFKCzMOuRUuDwda1Bjm4RE1acaz8M5WSBOdle2YC7pp0Orr5YYmZuI9B86PQ5LA+YaQUGHVKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpucwN7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D51DC4CEF7;
	Wed, 17 Sep 2025 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758125674;
	bh=GCsBS5m7MCqJPnLz24lD//JDAj5Is8wBCI9hodf7iV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BpucwN7vO4NcN9CHMFiJKpRclWRN3wAmHiNSLulXaIZyohOLl8TZBgHCLTmQABbG6
	 Ma8Uopca0ncu0I6m2dsSirzpRXXOEr9h71NP0f0beyJn4k5A7v5jEdnNK1GNwdmeOW
	 7clgDkP6pmjDqSWHd1lWw8y2LMktoVOwRG1ou2bjmjeZyr3qxZwwGiSs26Ias53Ja1
	 jCdXatFqFs+SfVpsQ2IrnbQjtRPQtwsC3V5asvuIDN+1KryCNoKP3sOvb9Zj/EXgZj
	 Difz98KyzAZK4Wn1+/OvAFchrvCvLGnnTp4VRwejZyu+qOODv86IWmiCV3Jkjyh85Y
	 6GVXsRtMSBslw==
From: SeongJae Park <sj@kernel.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v4 01/15] docs/mm: add document for swap table
Date: Wed, 17 Sep 2025 09:14:32 -0700
Message-Id: <20250917161432.53960-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916160100.31545-2-ryncsn@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Sep 2025 00:00:46 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> From: Chris Li <chrisl@kernel.org>
> 
> Swap table is the new swap cache.

Thank you very much for doing this great work!

> 
> Signed-off-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  Documentation/mm/index.rst      |  1 +
>  Documentation/mm/swap-table.rst | 72 +++++++++++++++++++++++++++++++++
>  MAINTAINERS                     |  1 +
>  3 files changed, 74 insertions(+)
>  create mode 100644 Documentation/mm/swap-table.rst
> 
> diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> index fb45acba16ac..828ad9b019b3 100644
> --- a/Documentation/mm/index.rst
> +++ b/Documentation/mm/index.rst
> @@ -57,6 +57,7 @@ documentation, or deleted if it has served its purpose.
>     page_table_check
>     remap_file_pages
>     split_page_table_lock
> +   swap-table
>     transhuge
>     unevictable-lru
>     vmalloced-kernel-stacks

The above diff is adding this great document on 'Unsorted Documentation'
section.  Could we add the document on the main section?  I think swap.rst on
the main section could be a good place, and wondering what others think.


Thanks,
SJ

[...]

