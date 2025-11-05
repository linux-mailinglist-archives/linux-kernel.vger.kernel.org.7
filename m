Return-Path: <linux-kernel+bounces-886741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2B4C366C2
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D20B624A1F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6B432D0D5;
	Wed,  5 Nov 2025 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SuLYuNMQ"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7757321440
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356323; cv=none; b=oEnRnhm37D0S1NUy4dZilcK0FyYJb5x+s0ZpH4h5bfNE6XmQkLBMK7hA7eXr6Hzwj7cVSdumMkoYYATop/HtbV2+6nY3YNfWXT0vFtImLTnNJR0FlloGZouuIv3KzntBN3k8ETkUOMalq8hl5jtCWYJs4uB+3o9Qo9VBC3QBXTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356323; c=relaxed/simple;
	bh=jVa87eKGqVF+l20ajBfd8ThYEZLpCOEp5uPFz1FOVig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFtBNAznedaobNa2hPVyu1EzpC116//Z9JVvM4pJarm2gUM5eGbAZ3aLsGL1OuAhw+uT7vN/xzjMVuAB7r0ku/vAy6nzzxKMxI0KIMk53vQNrWW8X8pksUVInXLOFRe3FiVGpZgoWfoc830GT/7962eRzROE3m+JWMs2/AUTD38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SuLYuNMQ; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-94868b991easo61523339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762356321; x=1762961121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=487sI5AbJzpMbYjr1CjDcFAjiYiuuI8y81LMpEqcmVA=;
        b=SuLYuNMQsvW2Wzy7K4mLUkR0AoGJNXWXa0P0gDdbBgbZx3j0quIPnpr3upInBfCwFn
         RPwNLHQK5wV356rmAywxjbeB9tJDB7v1cnTrIkA4STiha2ORKBmLmOQApD4kxn5kuFCQ
         4QGrxLeifnYktJ67DjF8XFqNvklzewbeDSW3vKwsBMdWVgq9GETI6XOc72jOBotOHN13
         OmCd57PuNi0/2jb9ryaH3q/6zjtXi51CwEQe3Cg4rCnYA6J/gGVEMpj1XD5gZ5x9ZjIL
         kRwcPBtDaPLpwInKxWRkZnnIJs1Ej/SarM1CXuLUfvUsyKg2gbiV/lldR+HSu6QIDW6z
         fUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762356321; x=1762961121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=487sI5AbJzpMbYjr1CjDcFAjiYiuuI8y81LMpEqcmVA=;
        b=widnuMVWzNaNh6qrIJ/wzLkpMd2rFJkJPaCMFEIPdljEt1PrCf6ifCjPKuziylvtRQ
         jnGiDBZPqiRuXftjHZgGvnIYhDxOKXK3xww6eszQm1vRjeA/42kArQEtS2ykGv3+BFgX
         i/ns0Q9h9tYJeoG9htDL+YnuE1za6bBw4S4jSBCW/v5oRO7MMiRWKbI2XHfpZRKJUqJI
         KAfqQkETzNXNJaVUz5bcs6lHrNYixU1GFpSND40dY0ku5TWaKG/d/+3YuF0BmsjQLDG2
         QwWDL50yxKgr10/eFyr2hFytoZ1zLnfLC92RaOP8BgIkGh3AAt9XTXHRZl4XccTtTK2l
         wJ7g==
X-Forwarded-Encrypted: i=1; AJvYcCXjPkqyoO8aie+6T8mCoKVAOjnYJjZoAFKwQ+RUgdQDC8o7/R/68BsULdCFhDc0YvidxAQ+Jwn/OFt04Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKO34FqWE4awCqeTnDSoP3HaBgaai/uyQaQAXo1SASWfLhNykp
	OawD5roehAowYnYE1f660h+xW9LspuP92bN7l0pxeBlW82x6dq+yNgrb9pReCLJHZRQ=
X-Gm-Gg: ASbGncsuSZKDSAuNR6MANxz2YVJ3ZhBkBt82bs2OvanG7qL8ouHXGmRPGNfJpHT23TV
	QuBt46iq5SbzxsDVFoWQT+LMjMcq+wwRnF242MSoBL10BnplpRh4tRbPnkru5vGnNemUBTHeoaS
	ByW3mWCkdL7NPb3gUmCJ/npWZOuN1BVa69X57RYEWAmrfIXY1Y8lZRJR4s1Mv3pb5u0K9WPtDXb
	r+hpggMTwSdTH7yrKKCEK2aMozPZMTBNoAwkpyKPcW8qWQ75OfAOjiGTyFewyaTtKKQs4UKqdY1
	hcB3yAwQmcLjo9Tb9HfYEDPpCIFREEBHhE3+FQbLGGkT/SLB2UotzYGXDq1C4wVqEdiuB6YV4vP
	CpVvYsQkJplNEjbF1QqRDui+8Ra+FIHZcQdIG8AVWEndNn5dLhMMIcA3Goow+uNrY5bHxt4Uq
X-Google-Smtp-Source: AGHT+IGc9ECZf5jYK1jLXUdJ3FXQag+q/dzClLumbg8vy2PbyYvXZm9bHKrc58cJrzWZLVcyD9QYcw==
X-Received: by 2002:a05:6e02:174b:b0:42d:8b25:47ed with SMTP id e9e14a558f8ab-433407a705bmr56303455ab.6.1762356320939;
        Wed, 05 Nov 2025 07:25:20 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b72258d620sm2536362173.8.2025.11.05.07.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:25:20 -0800 (PST)
Message-ID: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
Date: Wed, 5 Nov 2025 08:25:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] zram: Implement multi-page write-back
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: akpm@linux-foundation.org, bgeffon@google.com, licayy@outlook.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org,
 richardycc@google.com, senozhatsky@chromium.org
References: <tencent_85F14CD7BA73843CA32FF7AEB6A21A6EC907@qq.com>
 <tencent_25F89AABFE39535EF957519750D107B7D406@qq.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tencent_25F89AABFE39535EF957519750D107B7D406@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 11:48 PM, Yuwen Chen wrote:
> For block devices, sequential write performance is significantly
> better than random write. Currently, zram's write-back function
> only supports single-page operations, which fails to leverage
> the sequential write advantage and leads to suboptimal performance.
> This patch implements multi-page batch write-back for zram to
> leverage sequential write performance of block devices.
> After applying this patch, a large number of pages being merged
> into batch write operations can be observed via the following test
> code, which effectively improves write-back performance.
> 
> mount -t debugfs none /sys/kernel/debug/
> echo "block:block_bio_frontmerge" >> /sys/kernel/debug/tracing/set_event
> echo "block:block_bio_backmerge" >> /sys/kernel/debug/tracing/set_event
> cat /sys/kernel/debug/tracing/trace_pipe &
> echo "page_indexes=1-10000" > /sys/block/zram0/writeback
> 
> Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
> Reviewed-by: Fengyu Lian <licayy@outlook.com>
> ---
> Changes in v3:
>   - Postpone the page allocation.
> Changes in v2:
>   - Rename some data structures.
>   - Fix an exception caused by accessing a null pointer.

Please either finish the patch before sending it out, or take your
time before posting again. Sending 3 versions in one day will just
make people ignore you.

This commit message is in dire need of some actual performance
results. This is a change for better performance, no? If so, you
should have some clear numbers in there describing where it's
better, and where it's worse (if appropriate).

-- 
Jens Axboe


