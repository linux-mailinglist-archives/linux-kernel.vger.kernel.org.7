Return-Path: <linux-kernel+bounces-827624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69001B923DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F283A9A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D87F31076D;
	Mon, 22 Sep 2025 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUUETWtQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C018A2DECA1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558849; cv=none; b=pVZf9mNQGbVwzwDBQP25kACOUQZu/oQtl5zAQL2GviIL3kLALczfTuRoy1z35E7xelY+bYkuqd9AOd8cGIZjQhaM8ENA5VeK0IdskUrnTNJuZPkod5u0MdVN358WRnRHgSsJQD6XhaMQSbwC+9I/F3NmrOey1YRJG03WlODWDsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558849; c=relaxed/simple;
	bh=J5xgFBd3NU5Hap2uxJX37dSYFI7Kfv13S0/GT/le6ec=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXh9aXGqO5391rLBr2nh8oJk4/4W1vpwchnx6QFXC1cnEkrjB4pwzGkGd0/eaxoZVD+wxrbqT85aBWiBFyjmkbw3lal/SR9wY3Pb/GLGZv+scRwlP9ztog0YXHXoEuaqYz7ZYzcgWoTY+1FeoG5qFsJqAe03rblnfDsGQkIUdmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUUETWtQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758558846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gBJljojDbws+qHKYWMWrH6AZIQ6pnwW8hsnZj31y4NQ=;
	b=WUUETWtQLYO5jMZMLsueV3HEcGB1rv5uw8yWRdhuuvwb3F1gIrWvn6xXb036Ztlm4/OGzw
	++hWZ5SehzJsbx6E8lTZy49vCWlS/2XisY57Q40BZN+EZ6Kz8YPG+d+wIYMc697B8qcDgE
	1MBezF+Tn3ts6i+ZGyrv7EwE2fwPS7Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-XWEOdwA6O76xfPMax7Yu7g-1; Mon, 22 Sep 2025 12:34:02 -0400
X-MC-Unique: XWEOdwA6O76xfPMax7Yu7g-1
X-Mimecast-MFC-AGG-ID: XWEOdwA6O76xfPMax7Yu7g_1758558840
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b49666c8b8so80933781cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758558840; x=1759163640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBJljojDbws+qHKYWMWrH6AZIQ6pnwW8hsnZj31y4NQ=;
        b=RUdvMI00a11nNWdng0xcBJhtDPyYoWVUSD5rMGRW9lgF6XeY+crwSvL3jtCYUX5rdQ
         O3l33apPBXGlqi5hw7K4B27Q8uSNNid7f8W2ogypOXr/LKHhDXlvY6WflZPtTxrDRVKF
         TUw0cI8OLN8g+RipVDmOAA13uHV6WIM7rMat1Xh8SiVoPOhxYcRg7SA+Ce7SWFhGM5Q9
         91eWFF1+IeD+xQk3dJpbI8v4IbuuzatakB5Eo8OUw+SOFNmcaHGScLby8CWfzK7/04T7
         8NTJtamzrJBpb3bv5mistmfQRBHgyp5+Z9P+GcOfbilLblBBCQNk8GWXHYgjP0UjurLg
         ErbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOS83q1dzTeRueWJXIlcJXjz4AIpxiFXwWu1d9usT3Io9Z5XqAsk8QtjcO59U8w6lNS7LqVZeSBNkCsks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuHiuToGFY4C5MYBdIISRVzUSFPE1mZ8O9NScNBxzO3NT5i4ND
	zGgTPAARx71z31AVj6PMXwMP1vam71/Zgz8jIbgm8O8O2m2RVoxxyUYh+JE62SWWMP4cmfcrSrR
	Sl5+0SJR4f25RYIaMKxDROxGJ7ZAiv0XBPV0jS76VEW+XF/shZd/Xlv9ok3p5UBWLRlLrXOg9Ig
	==
X-Gm-Gg: ASbGncs8INWpYH8y7UGJEGScfSwm/FuPh944n0W+9CIYmGUGvJdvVrxY0kG8CuWSzYu
	iUPnG44V/CyX8NTYSeBBZK3ynGKPF7cCl51ufIO/n3y3hnxBLEks7IOTx3Qx8HkHzHkiUa361z+
	4tiZtFs3zKUmtA/ZteC9mAuT6lpe9+uKtela934awlB+4On2fjGe3W6e6ZfDlPA26zpN5esTRvv
	5lpul5728E0o3q/B5Y8D7PVq28pAkEblQWpoNZNXl02u73gjO1nmvljVk1TzqKeOF9MuxvzF9Od
	55+u93pbd2l6n+eg1eiujXVeZwE9yUxX
X-Received: by 2002:a05:622a:5908:b0:4b5:db9f:9904 with SMTP id d75a77b69052e-4c06e01de1bmr199682671cf.22.1758558839533;
        Mon, 22 Sep 2025 09:33:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH//E8b4gnkiEJqOP3wljjECSy+ua/1PyrN9UKJVnDq/W9qkrGv0rnACb5iI8z2zg8fwH1I7A==
X-Received: by 2002:a05:622a:5908:b0:4b5:db9f:9904 with SMTP id d75a77b69052e-4c06e01de1bmr199681851cf.22.1758558838967;
        Mon, 22 Sep 2025 09:33:58 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ccade1cf34sm15909061cf.46.2025.09.22.09.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:33:58 -0700 (PDT)
Date: Mon, 22 Sep 2025 12:33:56 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aNF6dCL_yonTforG@x1.local>
References: <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
 <a1a48a0e-62d3-48d0-b9c2-492eb190b99f@amazon.com>
 <7cccbceb-b833-4a21-bdc4-1ff9d1d6c14f@lucifer.local>
 <74b92ce3-9e0e-4361-8117-7abda27f2dd4@redhat.com>
 <aMxNgyVRuiFq2Sms@x1.local>
 <cigo2r2x22bk7wzr6qvazcdkmt5kfqhbgb7nslpuff7djufucg@f6xucfuntz3q>
 <aMx0oGwRpSTcfdnf@x1.local>
 <swfs7qpgrezamnijhheiggwdfklfqdc6ahp5g7nvprr64m7wz5@msf2mqajzbuz>
 <aM1l2YMmvBgiXJ8a@x1.local>
 <unvooxce622bchlsivyr63lsvywnx4u6omyndotdo32ynv2eki@ju5srmktf3hg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <unvooxce622bchlsivyr63lsvywnx4u6omyndotdo32ynv2eki@ju5srmktf3hg>

On Fri, Sep 19, 2025 at 03:38:51PM -0400, Liam R. Howlett wrote:
> I spoke to Mike on this and I understand what I was missing.  I'm fine
> with the folio part as you have it.
> 
> Apologies for holding this up and the added stress on your side.

Thank you for changing your mind.

Mike, I definitely appreciate your help alone the way since the start.

I'll wait for 2-3 more days to see whether there's any further objections
from anyone, or I'll repost.

-- 
Peter Xu


