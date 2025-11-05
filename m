Return-Path: <linux-kernel+bounces-885829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB424C33FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 06:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF624628BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 05:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA1426056D;
	Wed,  5 Nov 2025 05:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUo1TukJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37821ADA7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 05:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762321445; cv=none; b=FMTE4p5G95F3XfvLu87KsGeINp5DcEjr6/WdqPt2PiLmdF+b6YpuB2qiInOMLb52zpvFKeMIOCHqDX15AH+3sHcumffZn3FM0Mu7CFLArtGmDQdN347uNz2/nZVyPYQlXIDABg46mqfcNB6HLq8LH13dl4L2OX0x1jgVkqdmt+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762321445; c=relaxed/simple;
	bh=eE9jwmwKeW8ygUlisppibKkqjeg/K6u4ttTW3JhPw6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+FgD+DSqMEPklEIE2/yIe3pesQYA7+3gAAiBpxU4OkR1o3494qEJtbCSHuBfP3s/9GQp++/d8Y4cwv5oBWdT5oywoyHbvJOF8igVfVgSXf+ZjppQ/LKtdIKgU7eIN3Y2Y7mNlNUCUh5xKNbYugPgHRC/lOMGd825dBY5V3wX38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUo1TukJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762321442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9anBVAz2hfGO8p8FWHjuAN59LdM7EdQcG+brg7ozR58=;
	b=IUo1TukJT+eyM5ju4QDRFuOq95WeuzSDZ+qdaNcbsVgx3FD+JLkYw30L+n5ZN/kqwsUvHE
	hvXXjXB+cRvNIEqZ6EbG7EMQVelSGStTrdQsvGvw6vzLzpw4VoOMQzR3SFkWZxVH3iSV81
	9A5qz5tP0rNElworMygRg/SaoyO07xI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-F1-14ySSMlONZ3Zg0k64LQ-1; Wed,
 05 Nov 2025 00:43:58 -0500
X-MC-Unique: F1-14ySSMlONZ3Zg0k64LQ-1
X-Mimecast-MFC-AGG-ID: F1-14ySSMlONZ3Zg0k64LQ_1762321437
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 313DB1800350;
	Wed,  5 Nov 2025 05:43:56 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 222861800451;
	Wed,  5 Nov 2025 05:43:53 +0000 (UTC)
Date: Wed, 5 Nov 2025 13:43:49 +0800
From: Baoquan He <bhe@redhat.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Michal Hocko <mhocko@kernel.org>, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add Chris and Kairui as the swap maintainer
Message-ID: <aQrkFflKE+aiLnQw@MiWiFi-R3L-srv>
References: <20251102-swap-m-v1-1-582f275d5bce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102-swap-m-v1-1-582f275d5bce@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 11/02/25 at 07:11am, Chris Li wrote:
> We have been collaborating on a systematic effort to clean up and improve
> the Linux swap system, and might as well take responsibility for it.
> 
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2628431dcdfe..8b5af318a0c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16497,12 +16497,12 @@ F:	mm/secretmem.c
>  
>  MEMORY MANAGEMENT - SWAP
>  M:	Andrew Morton <akpm@linux-foundation.org>
> +M:	Chris Li <chrisl@kernel.org>
> +M:	Kairui Song <kasong@tencent.com>
>  R:	Kemeng Shi <shikemeng@huaweicloud.com>
> -R:	Kairui Song <kasong@tencent.com>
>  R:	Nhat Pham <nphamcs@gmail.com>
>  R:	Baoquan He <bhe@redhat.com>
>  R:	Barry Song <baohua@kernel.org>
> -R:	Chris Li <chrisl@kernel.org>
>  L:	linux-mm@kvack.org
>  S:	Maintained
>  F:	Documentation/mm/swap-table.rst

Chris has comprehensive understanding of kernel code and possesses
extraordinary insights into problems which enable him to propose
some highly innovative and visionary ideas. And Chris is very willing
to share his perspectives and iedas rather than hide them for personal
credits on patch posting.

Kairui is highly proficient in kernel knowledge and system operations,
and he handles complex problems with great patience and resilience, E.g
the swap table patches posting, and performance testing in different
scenarios. Moreover, he is always quick to respond to people's feedback
and address any issues related to swap.

Thumbs up to both of them, and ACK to their maintainership on swap.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> ---
> base-commit: 9ef7b034116354ee75502d1849280a4d2ff98a7c
> change-id: 20251102-swap-m-7907f24e431a
> 
> Best regards,
> -- 
> Chris Li <chrisl@kernel.org>
> 


