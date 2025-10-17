Return-Path: <linux-kernel+bounces-858233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0605CBE958D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95AE6E52FA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806EB335094;
	Fri, 17 Oct 2025 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PU0CnrEy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD061F3B8A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712674; cv=none; b=rT/ZUIlYxjViVQ4bu3Enpdp5iIxe1vdXNjAlIiOtnFhq63Oj+WP9eRE4nULY1o0dIwChRDpVPSSty1E+iGMpTIeB24NOCOTbai8VlY1d818jCpL1lbgP/81XZL4o2X98l6+ShCEPXCKPff69rSvydK6inGc1hS3I74ZEEBt3BOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712674; c=relaxed/simple;
	bh=dLvj2t72QwSsLKzvWRBwYoLKF9GjmO615gEa1hOh0k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EV4RLyv9EUQc1HHyE8fFy8ZzLmHR9qAJkUfcz9JfG/hhCZ0jNatXfW5NqsDBz/OY5KK/6XEjiQsDxvFovxOKEvi08qkW5BK6+/pLg+hEvB6xa9C64/hBB129v4EtW+LZ1mJCX5DgZ/qTGBaXCcYrIMZA1fLtaZ4DrGQ+pgORzU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PU0CnrEy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760712672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iBgvSFA9wqQN42AVm4tDtxe28Jc5wuc+NIBnNh4EXQ=;
	b=PU0CnrEylGCWhUayuFMd2/YXy7+C52Q8eL9bjUjorlIHc7d059d1qKaV/JjJneiRzKFAdA
	KgrxB5MybYxgb5EcAouUbTFb2qkSZL2CXvIzTd5Jv5+tuU3DF5PIlg+SBiGhs9vfBBg3Yu
	/7bklsM3CG0Qzab8zY0qwPNSRnKTX/Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-5Vqg52vFMhKqn6iP4ELsRw-1; Fri,
 17 Oct 2025 10:51:08 -0400
X-MC-Unique: 5Vqg52vFMhKqn6iP4ELsRw-1
X-Mimecast-MFC-AGG-ID: 5Vqg52vFMhKqn6iP4ELsRw_1760712666
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39FC41956095;
	Fri, 17 Oct 2025 14:51:04 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.82.94])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2063A1956056;
	Fri, 17 Oct 2025 14:50:54 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: lianux.mm@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [V2] mm/khugepaged: fix comment for default scan sleep duration
Date: Fri, 17 Oct 2025 08:50:51 -0600
Message-ID: <20251017145051.13842-1-npache@redhat.com>
In-Reply-To: <20251015092957.37432-1-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

> The comment for khugepaged_scan_sleep_millisecs incorrectly states
> the default scan period is 30 seconds. The actual default value in the
> code is 10000ms (10 seconds).
> 
> This patch corrects the comment to match the code, preventing potential
> confusion. The incorrect comment has existed since the feature was
> first introduced.
> 
> Fixes: ba76149f47d8 ("thp: khugepaged")
> 
> Signed-off-by: wang lian <lianux.mm@gmail.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>

Nice cleanup for the comments!

Acked-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index e947b96e1443..d635d821f611 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -67,7 +67,7 @@ enum scan_result {
>  static struct task_struct *khugepaged_thread __read_mostly;
>  static DEFINE_MUTEX(khugepaged_mutex);
>  
> -/* default scan 8*512 pte (or vmas) every 30 second */
> +/* default scan 8*HPAGE_PMD_NR ptes (or vmas) every 10 second */
>  static unsigned int khugepaged_pages_to_scan __read_mostly;
>  static unsigned int khugepaged_pages_collapsed;
>  static unsigned int khugepaged_full_scans;
> 


