Return-Path: <linux-kernel+bounces-681704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC0EAD5626
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 14:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F13F3A6CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2601B284663;
	Wed, 11 Jun 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3SNeEW8J"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658F4283154
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646620; cv=none; b=KTH7fYzNf5xvh+M3cl8xX7g564E1wWHX7UOC7XaPrNiqvfxWYnR06EwPODl4hOzvC6WHOGrUCkvlbiVmR3SbfECgbKH2a14AzwJPnrzHJl02dDngS7JWnB6+ew70kP9vww4XBvrGPjjv3aBUkrUIb+GRRZnLFxdM1d0PoR/t/BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646620; c=relaxed/simple;
	bh=WFBUbKMMnKHZdjkqyPfepwRYRaY3PMbvKPZrZUg2BWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VE8LcOzFaaQISFiK0iM7IloNM4ncV2WY78cQd9kmWJQxjQayE/RkZHUceZi22XN+Mrow0VnICZUcd8iUiIN4p1eRiNpIb1hIVHosfSEgwHZSEW3VDOoaLtOjZuU4g1cSnq0JCMBv2ytS/N0uRnyvB8kbg9HYQp4WujnzEOAHi7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3SNeEW8J; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3db7b3de375so55523405ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749646617; x=1750251417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPGWj6XVqoqMlOowKe5NeP45YX5gIMyOrC/TyjewJiI=;
        b=3SNeEW8JE6h/oz8q6m6QF2ImTL+tlmycebGzUU801zIFrCEDkbol5VveffiMdaCcVr
         DR4DtdLs0b+1vL/7V92uya5ywuKnyqGYVSg0ovhGxi0LJoY7dxjooMAxjnoIBEzQXMr+
         qMeCgAww9N0HEgBHk0ug5O3IF+BFEyTe1ylZYv+Y826rZiB61Q2HaxeJnbGKLVKmd7gE
         Aeg10w+4veLhgu4Nb+O8L6MkAU1TZQkC7AhlyIGuZtpexzE1kEY4l5aPG9Hz/W2teHnY
         49kehI159q8ArkYpHFN9doyq3ao1juv/h8HlhUTH3p4/xVB/T2oRSBlwS1sUivjQy8Bs
         7uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646617; x=1750251417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPGWj6XVqoqMlOowKe5NeP45YX5gIMyOrC/TyjewJiI=;
        b=ktfp996W4tBvnb4HjJDqW1Ys8m1/fK2MVV77IMBCiJPwWAunx83L0B6Ol2OkQTmRIv
         iF5y6r00lqvvzhD/YYTYebFdPAe26B/KuaGYUesW9zwMrr5CQZ75/omj/q+VF3/b/d54
         2igOTdaV+TI+nIvltK7wxf4WYDXqKWIYOU5TNvNm4Rvatpt2KfxaLgE5huP9Pg2YYkQH
         2mjPOoJaWFxThPl4Xf0nyeuM2Jc9fSXNpTQ2/RLYyCNSeh6rekG9cPgfRqrrTrwLQXER
         kmRZxmqurGco2iTu2RPen1LRtRmjyC+C9SlvUZqZViDBOwWrp8NfufobYLt9+crNLlG1
         KODg==
X-Forwarded-Encrypted: i=1; AJvYcCVRuUuE6z69RYk5HhZzMoX40ReMhfRy2NUrsX34s4fdi0/PdLcT/20ANX0z6abU22xk4MN0ieP7UFoFkr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3BkLrIpmIQWlEyKXi7rO8Uwu6621e1oTTKJ/MDZNjl+SBcXdH
	7XGmF+BfGnFQ50srO/2r+yu4J4c4LOxDCx04OYYShph50/s2SPJMRRiKYqLDo4LOhzc=
X-Gm-Gg: ASbGncv5+AiVgVzRcwyu97aI20xjxlgxntKQCFcnFEJuMy0f+bfGFKBk/1A2pfKysNH
	ls/6CZQ090YMr4LKoRcqkR2FCnUvmG4SoR7ICckQzcnTCLNT8x28OZXoPVcECAHbJ3eQ5YV+jRP
	g5hatzvimz5O1EbZSjnYhJuNV26BLlL2q6MyVbVTxxglGZtRYSG3GpNJguwvWihTRCUBYlRlVJx
	Jfr7WtTqkVKeb0450PZbjhpPDjD6xQQEG7Hj1XGfftIUSdU+XJkj7LBAKb2nj06FMlvjcnYdgLf
	+es1p5Y1QtKKHfyg9qUKnd544t3/dpFjWQ6gx8AVFc+TinKx3uDQD5RdPfsijMW26tMsQA==
X-Google-Smtp-Source: AGHT+IERz9UEhN3gPoO6s9ZO+TGganlwoJirBS1zd34gle1XGHdmdK7NOLrIX/f0q//+H5iwkCSLYQ==
X-Received: by 2002:a05:6e02:12e8:b0:3d9:668c:a702 with SMTP id e9e14a558f8ab-3ddf4d5d68emr25015895ab.9.1749646617386;
        Wed, 11 Jun 2025 05:56:57 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ddf4768c0dsm3851505ab.55.2025.06.11.05.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 05:56:56 -0700 (PDT)
Message-ID: <ed33ffb7-31bf-490c-b1ae-304a6e4b9a0f@kernel.dk>
Date: Wed, 11 Jun 2025 06:56:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "block: don't reorder requests in
 blk_add_rq_to_plug"
To: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Cc: stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Hagar Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20250611121626.7252-1-abuehaze@amazon.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250611121626.7252-1-abuehaze@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 6:14 AM, Hazem Mohamed Abuelfotoh wrote:
> This reverts commit e70c301faece15b618e54b613b1fd6ece3dd05b4.
> 
> Commit <e70c301faece> ("block: don't reorder requests in
> blk_add_rq_to_plug") reversed how requests are stored in the blk_plug
> list, this had significant impact on bio merging with requests exist on
> the plug list. This impact has been reported in [1] and could easily be
> reproducible using 4k randwrite fio benchmark on an NVME based SSD without
> having any filesystem on the disk.

Rather than revert this commit, why not just attempt a tail merge?
Something ala this, totally untested.

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3af1d284add5..708ded67d52a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -998,6 +998,10 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	if (!plug || rq_list_empty(&plug->mq_list))
 		return false;
 
+	rq = plug->mq_list.tail;
+	if (rq->q == q)
+		return blk_attempt_bio_merge(q, rq, bio, nr_segs, false) == BIO_MERGE_OK;
+
 	rq_list_for_each(&plug->mq_list, rq) {
 		if (rq->q == q) {
 			if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==

-- 
Jens Axboe

