Return-Path: <linux-kernel+bounces-751119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870A2B16572
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D293AEB53
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F5C2DFA3B;
	Wed, 30 Jul 2025 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="b1iCMmgE"
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520CBA2D;
	Wed, 30 Jul 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896302; cv=none; b=Tp0blFegAiDA5mBRgthsWZVSsORdLbuCxysg2/+Um76Owt4KXw7AaQSeyZlOdy1Ri7XSKthHYykn9g2olpRcd/BsSLHFyOy5LUkUSPvLhf+1CtR3Q1BmGEv3uLRReJUwKw2oPQi8DIfA5b69Ufr5wJoPqyJ19NuKkmh8PCaOiBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896302; c=relaxed/simple;
	bh=/lWyWVDZocagrXCpoIFP/0Hv9MDxEPjKMpTAhKNf3qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKffXpuJp0BDA6OTDTmObfA0VD/ujEkeXsM8PUNLajVDuFIKkTsFZmtUxweSdYqVnihZDo+v0U0epfZBe9P54s6Ii5IOKbKcDd88su4nqLrTSJ+sv9ngrJ+EZsJrKDI8jMmLDbDHIUNSeqmgNxFpPPhgPlBwpHGpmQKfhaTMpMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=b1iCMmgE; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bsfGz4x3JzlgqVc;
	Wed, 30 Jul 2025 17:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1753896297; x=1756488298; bh=+QJVC+VXQCucnSBxEFhz/liH
	/yAIajbaQoLwwIpoJIM=; b=b1iCMmgEwZF3kY4iab9tj76uXQvYm3ivPdnLLM4g
	t8GC1YCeeU20A96y0iXbEhFPtseFEMNfOdw/qngTnwSQG+gNb3II5VNIZOjahZJy
	whSeFB/K6YvIWREMLJ/f78NwUW911ne7/JL/2UA6DxkG14mYcK0Vzs0Y1q0Sol3k
	ucVbaGHoyOvi+6oFmg+TNWjv28HG982VTIOmIlytUg1tFfcUV0UngBAgvLupzcWw
	H8m/Ei4dASE0o8lUn+tVUb8pjSiJ7WMlDJ/dsHzKJuU9By676Ltvg5j4l9x2673h
	cCVijafvQU5p6j/yYn0ZZ6zgJcyvVVJuPlEauhyx9Wc7cQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IAC4pJZYGg11; Wed, 30 Jul 2025 17:24:57 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bsfGk312hzlgqVY;
	Wed, 30 Jul 2025 17:24:45 +0000 (UTC)
Message-ID: <fd1b4b38-4b0a-4897-8130-bb39ecf11c66@acm.org>
Date: Wed, 30 Jul 2025 10:24:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] block, bfq: switch to use elevator lock
To: Yu Kuai <yukuai1@huaweicloud.com>, dlemoal@kernel.org, hare@suse.de,
 jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
 yukuai3@huawei.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <20250730082207.4031744-4-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250730082207.4031744-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 1:22 AM, Yu Kuai wrote:
>   static sector_t bfq_io_struct_pos(void *io_struct, bool request)
> @@ -5301,8 +5301,6 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>   	struct bfq_queue *in_serv_queue;
>   	bool waiting_rq, idle_timer_disabled = false;
>   
> -	spin_lock_irq(&bfqd->lock);
> -
>   	in_serv_queue = bfqd->in_service_queue;
>   	waiting_rq = in_serv_queue && bfq_bfqq_wait_request(in_serv_queue);
>   

Please restrict this patch to changing &bfqd->lock into bfqd->lock only.

Thanks,

Bart.

