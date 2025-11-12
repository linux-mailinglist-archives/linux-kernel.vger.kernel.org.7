Return-Path: <linux-kernel+bounces-896532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FA6C50991
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70EE13A6F50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8842D6630;
	Wed, 12 Nov 2025 05:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nVEg4d4H"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83FD15D1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762924689; cv=none; b=pDxyXss+EmOga4l6vP/PxVPhNexptzUkD16HEjIVRWEqGFIDWLzC0v09cEoLNeAIIZgWmZeuh4lYsvLkB0BFvGwy6Sk6TThCXBdkZHG0+C/LxcKzbuUBa8bKK4SIPMkqqOf+NsrRC/fFnFyqAlbbwhB+7CagfG/DvQIlFXlYUls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762924689; c=relaxed/simple;
	bh=N2i7mYhy/wako5FItulAn51gZ+92I+axWJfXi+cvC60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7GWxH5lKyhTPWtJxTlnXvfqadrCFlhxx1XOGBwn8dMEdIDaREGJqEpKXYEMeF3glwhlVrHgLXW1/OfwXOO8myZ0+mf1x0p/xCEZ31CYxzLJEYjJDxZEbkjPA+BIhKItwng1GO3NU9wBpqBqjE04FD17JaCoRrWL1W8vpQROTCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nVEg4d4H; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ba599137cf7so399553a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762924687; x=1763529487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJv5UmqfgHdkO0lr5oB99ha660rGNd0N5LAs+dq++Iw=;
        b=nVEg4d4HFceVmE6td0hEsE1pz6FLQdDsA7zlIePdMeu8XFli/T7Owb0EmJ1tnoUDeE
         3PIT+yiFk9ZfTQlm4d9hfwnkPPNcHi4PfQ/t170txOTcL484VoqPv47gSe/dc2EztecI
         1LeIbBUB1qt2O2gDEx0pqsC3jp/Dv1XUhQX8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762924687; x=1763529487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJv5UmqfgHdkO0lr5oB99ha660rGNd0N5LAs+dq++Iw=;
        b=fahLDGFtLXfVE6e73wueUNp3fqLAEiV9fOCYTPFKrxt4miJIwMYEoEsU9QtqwOQFaP
         xcX6/kyShdkKp3yHpm5nxswPlDDyrhLW7sQtXLMpwjkAGk01VVrvZTpX/lvvZwjYxLwL
         pUlRjggghvazCSvDGNXB9FTtxtBHabPTx6JWneXEaI+ENfnN/SciTwPW2Ekpvrfa5kGY
         bkSO6TeT0BixEz5pbrB01Pb0zHbc3qXPuVtpzDH/3+o3D7NRao3WKS38/Pddv3fSJ3ku
         Ipf6pxsSPMzSIvpDpqsVnM4MNBSS56qgp867+Tp8ocgveP3kpgHDoNQbGUz9CVVl/SwJ
         WN3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUozehKYqX1fa7b/qtIC4NGqDibRB6snI0oXp6n72WqHbqzpOowtBq2lQqol5M0BUsI3GsWa6cFP11oJyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIk544pIzZX6te++ZEWUwArjsRCn9mMTFriwda+HG4eR5f9Nuw
	fQhtFVN6jppEMqqkuDeSckiCrzowpWiGTw2Rf7xx1Bl513ww9BKMDFMFhmtGfAeZaQ==
X-Gm-Gg: ASbGncvdX0c0GLzXnIRcB0OC20lwxsR+9fq8C1DkaESjKycb7t7CyMy2kQv2hVI3PB4
	a0CWL5xAOcI/QhqlAVqJ1QJSikUeccCcmXMXt56Lj2NzswHatyeSchY7KIlxoxAOGLb04cGhJYQ
	AJeuUk/lfQBkL3oa1GLHxX+CMYqGgLePbV06BQ/Vag1f8vMNTMHNASO1wt4XzIUxwiGfqYTf1/q
	UDG3j3X0L5W5k/9630yniO0MzpZdJitjuLOzvCILWwERG8SL3UTyuWzpXaUD/mR5U25fwa27L1O
	wOFwjCM+AxuDcMcGGkeSJCVP8BsyV21gRG65wRC18dctX5juAQqbTrU0McWtBdtwxA4tMdpIF9Q
	QDywipJX7lsWEkv55eIPBzgRLhJPlQrwm1is515lC2mkdzr4Wa8m5iroJoimdOY30lV18NkqHY4
	1q+/UA07B8/0vLKw4=
X-Google-Smtp-Source: AGHT+IGbKMmfp62moQ55XqRXlYknpv7VsvU1R/1ooo2QU9Rce7Cy8tcLuOmjURe+U+W+1KDGa9Khaw==
X-Received: by 2002:a17:902:e5d0:b0:295:1aa7:edbe with SMTP id d9443c01a7336-2984ee021demr25227455ad.41.1762924686858;
        Tue, 11 Nov 2025 21:18:06 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2495:f9c3:243d:2a7e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf550bsm15774345ad.33.2025.11.11.21.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 21:18:06 -0800 (PST)
Date: Wed, 12 Nov 2025 14:18:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, richardycc@google.com, 
	senozhatsky@chromium.org
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <htycvrcqbnkk7ldhpaqxesy7uhz3lssymwqm7nzkhyhnid3krm@mfju626njxvb>
References: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
 <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>

On (25/11/06 09:49), Yuwen Chen wrote:
[..]
> +	blk_start_plug(&plug);
> +	while ((req->pps = select_pp_slot(ctl))) {
>  		spin_lock(&zram->wb_limit_lock);
>  		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
>  			spin_unlock(&zram->wb_limit_lock);
> @@ -774,15 +884,15 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
>  		}
>  		spin_unlock(&zram->wb_limit_lock);
>  
> -		if (!blk_idx) {
> -			blk_idx = alloc_block_bdev(zram);
> -			if (!blk_idx) {
> +		if (!req->blk_idx) {
> +			req->blk_idx = alloc_block_bdev(zram);
> +			if (!req->blk_idx) {
>  				ret = -ENOSPC;
>  				break;
>  			}
>  		}
>  
> -		index = pps->index;
> +		index = req->pps->index;
>  		zram_slot_lock(zram, index);
>  		/*
>  		 * scan_slots() sets ZRAM_PP_SLOT and relases slot lock, so
> @@ -792,22 +902,32 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
>  		 */
>  		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
>  			goto next;
> -		if (zram_read_from_zspool(zram, page, index))
> +		if (zram_read_from_zspool(zram, req->page, index))
>  			goto next;
>  		zram_slot_unlock(zram, index);
>  
> -		bio_init(&bio, zram->bdev, &bio_vec, 1,
> +		bio_init(&req->bio, zram->bdev, &req->bio_vec, 1,
>  			 REQ_OP_WRITE | REQ_SYNC);
> -		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
> -		__bio_add_page(&bio, page, PAGE_SIZE, 0);
> -
> -		/*
> -		 * XXX: A single page IO would be inefficient for write
> -		 * but it would be not bad as starter.
> -		 */
> -		err = submit_bio_wait(&bio);
> +		req->bio.bi_iter.bi_sector = req->blk_idx * (PAGE_SIZE >> 9);
> +		req->bio.bi_end_io = zram_writeback_endio;
> +		req->bio.bi_private = req;
> +		__bio_add_page(&req->bio, req->page, PAGE_SIZE, 0);
> +
> +		list_del_init(&req->pps->entry);
> +		submit_bio(&req->bio);
> +
> +		do {
> +			req = zram_writeback_next_request(req_pool, req_pool_cnt, &cnt_off);
> +			if (!req) {
> +				blk_finish_plug(&plug);
> +				wait_for_completion_io(&done);
> +				blk_start_plug(&plug);
> +			}
> +		} while (!req);

Why do you do this do-while loop here?

