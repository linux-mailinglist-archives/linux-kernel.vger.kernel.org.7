Return-Path: <linux-kernel+bounces-763947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C65B21BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B646280A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E552DECCB;
	Tue, 12 Aug 2025 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hihrJ1bu"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B72D837A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754971122; cv=none; b=EFqT7H/JY+3ky9M6x2FQamKtLtD/CyPPbvUTwOV+c5mMiJXTxVWSOr6mNxZ3ELeXG3OSoz5YsE98c4gUCWdHbnTaPfQDnXhqiutsneWBqUEAclyshy5MKMaoOblSiP4sxaUINhuU6JMUcwAz4iDq1YGBCqpvi4v8EfwvHNJc6/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754971122; c=relaxed/simple;
	bh=QDW6PgcfQGmvnuZamnjvlDuDj/nN6/r+CzeVaCn9PhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQY9vzykcSYtKT2dS21j0zz/x1ThmUEnoEfUbvXwZclT+8Yywpd5y0g3wRh/HXeADcwqebKm0xhh0etid8r8k7evT26C73gMBaj59KbLqY+KXLbqi7E9ElxplIFo6VxQ8CS6x0iKavU3/yd1/+ZD/iXGTe+6pgjt991PsVYgjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hihrJ1bu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31f4e49dca0so6106605a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754971121; x=1755575921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UsF4i7owr2w64jophO+zO+eW0GN81ddWs4iypkKqJ00=;
        b=hihrJ1bu6sELq8z9mjr/kEdkySRitX2ZcqISoR0PTSKkyQSbp0BF4WtJYLR1JKXZCO
         j83CRm4GSIM3w9rtEMXObIjJkARbBU//RsdBZhHcW3pDcXe+4g6tZr1tqzW3BrA3olCP
         +24KObsBsiVGVgc6BvpbTO1aSlUMd+mMaYNrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754971121; x=1755575921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsF4i7owr2w64jophO+zO+eW0GN81ddWs4iypkKqJ00=;
        b=lYLk0qBJV0PYPy7IYSCpIfDddyZ3WiSQM8QU0Q1SSWYpAgIk7UgoD8jhJKYgOwGyET
         RpV0rcXY6LK934gdEB8XNv2AYhDiWEXAJomgJ8InQqAsL9N/e79DnAQAUiC71Mqmkfk0
         XmUr6MpPdrqZTjzHqQ13AHFwU0WVsdgaWQN4Omgu+SXq1/H+/s9PllPa51Rqb8WB0uV5
         B46I+RUR7GGg360s1YUGAc/j4bDmigCpp9EVFgugSQK4ZrqKx+8zhbuCxTZn9yZ51GGP
         jqtH4PygI5MUGXl+4Gv7dqcAbjbGsJB6UBRlkBJEeRwT1X+VCOgwmO+d9o9CGBsJZJHH
         qwgw==
X-Gm-Message-State: AOJu0Yz0xq2BpOOcKMoGp3Y1Xi/2qJq9YkJ0NamvndKWXXKwwxMD6e8h
	lDQ+BefYscO6JJVckrgL4/aHT/AiIsRBrgjYhuYjrn9/jA9pwUiehH2Qwo6gtwl0vw==
X-Gm-Gg: ASbGnctmDY2TZkENqRJIJTplpBuAHVkRireT8oHqpwgASgpf1wk3yeLoXlXLWqg7WTu
	R5U5HNbYKgtIvkjo99/0pp74JRNUniPWfQb0AhK3o8LUAjJPEyaHoblckEMmuloeDAOSzzbDj+M
	wzzkjcwDcbFJgcigY7FlUyvQPdXgHpYoaruX6Y6kUe72l5kIFbWCxD7SVHPDdsW4x4zB0j1R2oS
	bVEig/Y4RqrHWduPGm8x+vUtn1Ui4v/Td9WwORWVPAfGUt4qe2toMUMz2FUrxpRJw21/5bmqOly
	tzzMGPKYfARs1WMr8aw9hkLhan0klAWGv5br49X+tQFjm2u0ZNvGzYqXPt4iKm2T2VomAG6c3dH
	NJ0QuWKVFdqQDKOPwWOfS8ugwBgblermiEAaV
X-Google-Smtp-Source: AGHT+IE0YyrVY5Vt8OKrl33IrgQwBQBekiXEdcW95C5mTt17WuM8Sondsrrkn0NdMV5pujBh12Fm4w==
X-Received: by 2002:a17:90b:2251:b0:31f:1a3e:fe31 with SMTP id 98e67ed59e1d1-321c0a11aa9mr3103600a91.11.1754971120678;
        Mon, 11 Aug 2025 20:58:40 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e529:c59e:30f9:11d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321611d846esm16436888a91.8.2025.08.11.20.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 20:58:40 -0700 (PDT)
Date: Tue, 12 Aug 2025 12:58:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, 
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Dave Kleikamp <shaggy@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1 2/2] treewide: remove MIGRATEPAGE_SUCCESS
Message-ID: <lky6lmpq5hsflc4rcs2hev5i3gctvbrppysttnzo22r6oiryw4@edfre7sprwk5>
References: <20250811143949.1117439-1-david@redhat.com>
 <20250811143949.1117439-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811143949.1117439-3-david@redhat.com>

On (25/08/11 16:39), David Hildenbrand wrote:
> At this point MIGRATEPAGE_SUCCESS is misnamed for all folio users,
> and now that we remove MIGRATEPAGE_UNMAP, it's really the only "success"
> return value that the code uses and expects.
> 
> Let's just get rid of MIGRATEPAGE_SUCCESS completely and just use "0"
> for success.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

FWIW,
Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org> [zsmalloc]

