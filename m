Return-Path: <linux-kernel+bounces-898815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D928C56146
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15EC33B6D00
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730C9329C69;
	Thu, 13 Nov 2025 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="joZqsfy7"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80185327210
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019445; cv=none; b=Yg+HZayPDBddG9mwVJixJsj5wbrLyQBnFe0x1dvkwof9P2essbhsaHRkpKbL8OHVzSUtb/IFHPm3PXihi3mvTRBig/jcM+S11P1OmAjyGfJv+4oZat9NhrJ0/wtudqXWQ3vlqraULq1sKnqtQNsQaXwM3W+svp/Ry6Kl7Ut9IHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019445; c=relaxed/simple;
	bh=SE43tPM6fuT3YpB/ury0/cKpZaVCE0iHqiuOTseBi9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2Slc2VJTtcwiotz408f8Ls0RVcVf0xk1a5gQUTnsTYFn3hoct+3NfcZNx6YJYPodKQTq1t59MiXnbB8rKBI0nR0lAp25XTYWXDjsZ615+pb9lRzzvZHbN5uU9XQa4o/al1byYRicAe1fTHqYbiIf7hiUHdzNcgls8QUN/wL528=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=joZqsfy7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297e239baecso15097315ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 23:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763019434; x=1763624234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PWnM74uHFaI8W0wt5Su2D27ZxngaddFBBe2OQ2Sl5xM=;
        b=joZqsfy7OPuSX+0FUd3EyvC8SNHoVc+DB4ZP/618DbCD1fhgMtXLpeaWxz1B+K8H9Q
         5ImekPkD4G2XkwucmaGKaqOWp7L9JzrHYDjkno7OfmPNX5Rg6q4mFhlKA11OQ9hTyKCC
         WzvWQR4YK0miYGi09Zb4yO0/O9Op+sWZP+h78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763019434; x=1763624234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWnM74uHFaI8W0wt5Su2D27ZxngaddFBBe2OQ2Sl5xM=;
        b=I3QxvnAlfVqSI2FAuo3aVP1ZjhE3BKAy4BVHbg3PnESdsO2Boe+beu4sudQtmUX0C6
         2XMH5dotXIl6Nk6ZDSbPb8ozyfA+KSdY2dBi89wt2p+jvtUE7F5GdbkrFyYzWJcvpN8Z
         JMY3+9rtlLCXycjiRcdhG0Yf9Vm2L9txTvkf7qK5yGrS0RLy4qGHJesAp19TxooLuyPK
         UtykN0MzdSo5axexq8FYMOnT1xXHc+gPDOJdE6xlBK5vXQZdVbgSGEdDdbGwPkb+nAZm
         OD1nJbK6e+kcXOSbed7SRDBsoyjYRzMz0Obxepp1e5hEdDYh2JdhPq4345niMKu8vY8/
         dV0w==
X-Forwarded-Encrypted: i=1; AJvYcCX39a35WCOJvCAbDbmHDa6lXaprHZD10Q2xKajJQD1cWQhc3333G/TnV1dXnKykVxB6S8/xyzaNnAEb15A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGLkdai6z06eHu3kq46ffpw5AbZGUG9DSKO76smACyTBxTw/bC
	8IFvxXt/dxFvh8rWaxsDaAKbno8c3oNkd1prN2IFJfC58CfBL8WknvD8yNDDxps7jw==
X-Gm-Gg: ASbGnctNuyjGQUKJb4Pz7XVFQbJ5W76lTWRWeTRsSD2cL75IHx/hn9oF6qAVFdqlphs
	xwXGcMITgtnJA5v1cRq2yHYzJWhrPNfg72AbtPFSYqgwNzeQOOiw6+dsT7mcaOfs3mCJS/fOAvN
	j0NHM9xZUo7nvuCrABhKXPcqG5bwEsVvF0mqJuo8QRnqL31c8RNjq4rYR9E02C2C4j0XeyKtq31
	OGVaZ6kI005GJgZDpjgwuwa3IkQtU++Z3ZBZblNv88gbUASCbOzXGMSypjCk7qmHWDhLejthN6K
	ZybSYcJzPyE3t4QNgFYMk/NMKz5FES0PIy1cvINF1ohwfZQBmNeK5Q8TDCvUtSF41BSvfene5yN
	MbAXSvrd+7dbZ5opu/By5nn0A0LTr7i6BaHn86GH1EFsJIc4ZrZu5IryRCU2g/KSxDeIPm8+hxv
	4oADhC
X-Google-Smtp-Source: AGHT+IGcwVOQxenlEIltHqenht6mtl/LZ/PZU7x5t8ckv2TF/Hrj/8ENijWtytzcVZdM9dakholzmw==
X-Received: by 2002:a17:902:e80a:b0:266:57f7:25f5 with SMTP id d9443c01a7336-2985a4ccc61mr30548785ad.7.1763019433726;
        Wed, 12 Nov 2025 23:37:13 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343eac93449sm917504a91.3.2025.11.12.23.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 23:37:13 -0800 (PST)
Date: Thu, 13 Nov 2025 16:37:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, richardycc@google.com, 
	senozhatsky@chromium.org
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <sz4brk7ixwzud4hzcgw65au6eto2y55thcku5ouo7x6ieifvlm@t3svlkcwcjb3>
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
> +static int zram_writeback_complete(struct zram *zram, struct zram_wb_request *req)
> +{
> +	u32 index = 0;
> +	int err;
>  
> -	while ((pps = select_pp_slot(ctl))) {
> +	if (!test_and_clear_bit(ZRAM_WB_REQUEST_COMPLETED, &req->flags))
> +		return 0;
> +
> +	err = blk_status_to_errno(req->bio.bi_status);
> +	if (err)
> +		return err;
> +
> +	index = req->pps->index;
> +	atomic64_inc(&zram->stats.bd_writes);
> +	zram_slot_lock(zram, index);
> +	/*
> +	 * Same as above, we release slot lock during writeback so
> +	 * slot can change under us: slot_free() or slot_free() and
> +	 * reallocation (zram_write_page()). In both cases slot loses
> +	 * ZRAM_PP_SLOT flag. No concurrent post-processing can set
> +	 * ZRAM_PP_SLOT on such slots until current post-processing
> +	 * finishes.
> +	 */
> +	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
> +		goto next;
> +
> +	zram_free_page(zram, index);
> +	zram_set_flag(zram, index, ZRAM_WB);
> +	zram_set_handle(zram, index, req->blk_idx);
> +	req->blk_idx = 0;
> +	atomic64_inc(&zram->stats.pages_stored);
> +	spin_lock(&zram->wb_limit_lock);
> +	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
> +		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
> +	spin_unlock(&zram->wb_limit_lock);

This should be done before the submission, not after the completion.
Otherwise we can significantly overshoot the wb_limit.  And we simply
need to rollback wb_limit adjustment for failed bio requests.

Will incorporate this into next iteration of the patch.

