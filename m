Return-Path: <linux-kernel+bounces-860809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE52BF0FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11F654EB713
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58B82F83DF;
	Mon, 20 Oct 2025 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OejYqhsV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE612E9EA4
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962159; cv=none; b=AK85k7IPSYjmjQcJl2yrwqdJcc4VHj3hjKbMFuipT87QahYtMxmSwV2XPjg12tsIYuPEt4cRZeJamqh6zLKvGHB3BI665OaBQw4qyg+iu5INhEm2YH6zVXfXIwIyJKZzF9DasO/5kf/I8Zn73K4PKbAakWequllVad0dGpHlzh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962159; c=relaxed/simple;
	bh=PZuc/bT9Muq6qRPzzsJ9gou6TZOwYeljMHos2zbLKgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jbk1bo7RUaEfnRYVwHFWY9ZrBTxUdb1E2SbsHdlx+AOd6ThGqrWanjHIigUftigs2I4ZkyjrNmj62p9g2A54Wy+K7j+TLhqVDAt/Ai0IOWSkOGSkRyreV/M8fv6AIcuGth2DTdu/vPgXgLTvmjH2piMqUB+L6mcMbt5+ZBfcMsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OejYqhsV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760962156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BWIB41YZ1o0hF+IEoK38lD9pbdTvmv+a6Ar+WGHWH8=;
	b=OejYqhsVW+1mCEa6R1cFqBJlo8G8tNjQ/dpcsRlWJWKzJJ0pUvXWswT8VDX1YINUFTmaxP
	55NFywdJ06GKBkpVeHQSeA/f2nYqGCbdJe2HVxz9J09yaCrj5kpYsY287tLLGws2L8KIIV
	XIrPbU//FZnWGFomctdreoFByUVj440=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-I5fJWjN7N9WlP2oK4DcZJg-1; Mon, 20 Oct 2025 08:09:14 -0400
X-MC-Unique: I5fJWjN7N9WlP2oK4DcZJg-1
X-Mimecast-MFC-AGG-ID: I5fJWjN7N9WlP2oK4DcZJg_1760962153
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4270a61ec48so3349112f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760962152; x=1761566952;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BWIB41YZ1o0hF+IEoK38lD9pbdTvmv+a6Ar+WGHWH8=;
        b=NqsqWsoZp95lEAPu8zpI3no86UxePLnLwZWOtiAjRetnDjgsKcrtyLUzF020c6dn+W
         1NKSSkt7TDXbtoby/NsbFjS90edHkBTSdG+Fg94WZ8Q5L8bis6NW+dcSlHLlPH3SyHgm
         6Ic/Bf7hRw6eKlejOdoz707t/g8j1CvUq7HdJ3JNJ3iJXp/9JSSTrOc9otHAYjelQiUw
         n8HkCTcY889nJareYbDZrRASQUsG2czaEA8OMXOQgM5IIoPAxNbs8N1dj/BLc01Fx92V
         supm2eoLEI7GyYKmG07XU6bED+Xvop8fnZkbjS9rrgnzMvhcJq+bmeGmwGezwAji2Sqx
         vyzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+oiLP+fgeQ0FIClGw6mr6rN0Pb45afBhYMQpCPrDS8C1dGU3tGdZh/ZXeaNVfoIX2ySHWRkJ1xqILwgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGH96gJEnn8sN+zvMzuk9GSFYi4z2ZjgwysNxBsLn9YoCaYe26
	414WBRTLAB2g1y3zI7zdGYMJSkVyefiVafnmrnFGZumJXteGkyN94CT3aLS2Gtz+17RCPDE2iHX
	EsOoqNSRtaG3wI42Yhgs8IuWAJ9oCMGB/VNHQoibaiR6L02UsL3hc/qDDuIP/jJ39TXSkbVybzQ
	0uUNBMlFmSZsshgBnAGjyoZs0kZF4hCNFU4qb6BJqlJcJgdrV8Yg==
X-Gm-Gg: ASbGncvS+Nrr2EKLQ0B1ZJXSVoLR7BmFx3RY3NQlFhksjsy27CyEa7rl4rwhT+DIW1L
	KckUhHoYMyVwNr5q742xqnoAqjoSRKgsdZQNNzh3PoqEOQwnudaQSIbbWX8lmUvOkp7d6qndL0+
	wYBP8nb7/crawpGuwARRp539Y3AFPjnOlrhRyhsLu/R3TxurLdWzf1btt/XvfmQnPP0qJ0ImiVn
	ZAEie3EwHyMRyOCbxqdetjzu8n3p0slb8plUwicqP90Bs4SHF3QFp4LxhBh3eBeWT6g6gfd2PLi
	mRjcYBGW0f531AY6BLALh5VAnkqQ4xznZ9GFZkXmBuyT3XZIkmDsAoualobSNffnEMVUl8Lxnp9
	r25/tJBoRmp31yLsVbMkAguhS/UTsiTFboWpE0UpoBaZUvqGjpBUPOiERGsry
X-Received: by 2002:a05:600c:3513:b0:46f:b42e:e38c with SMTP id 5b1f17b1804b1-47117925e9fmr94114665e9.39.1760962152230;
        Mon, 20 Oct 2025 05:09:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuFSjGNIJtFZPbCs4nQX5b2sUasf/R7MuSy30Nq59EfMqDffZQUuwUgCufHTpiLlgzJHFF4Q==
X-Received: by 2002:a05:600c:3513:b0:46f:b42e:e38c with SMTP id 5b1f17b1804b1-47117925e9fmr94114335e9.39.1760962151772;
        Mon, 20 Oct 2025 05:09:11 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d916sm137865115e9.4.2025.10.20.05.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 05:09:11 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Luo Gengkun <luogengkun@huaweicloud.com>, mingo@redhat.com
Cc: peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, huang.ying.caritas@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/topology: Fix memory leak in the error path of
 sched_init_numa
In-Reply-To: <20251014083650.815439-1-luogengkun@huaweicloud.com>
References: <20251014083650.815439-1-luogengkun@huaweicloud.com>
Date: Mon, 20 Oct 2025 14:09:10 +0200
Message-ID: <xhsmhtsztlqqh.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 14/10/25 08:36, Luo Gengkun wrote:
> @@ -2003,15 +2017,19 @@ void sched_init_numa(int offline_node)
>        */
>       for (i = 0; i < nr_levels; i++) {
>               masks[i] = kzalloc(nr_node_ids * sizeof(void *), GFP_KERNEL);
> -		if (!masks[i])
> +		if (!masks[i]) {
> +			__sched_free_masks(masks, nr_levels);

This could be passed 'i + 1' instead of nr_levels.

>                       return;

So the tricky thing here is sched_init_numa() doesn't have a return value
pretty much because it's not meant to fail, if you get memory allocation
issues while setting up scheduler structures then things are not looking
good at all...

Best case scenario would be the rest of the topology gets set up correctly
and you get non-NUMA aware scheduling, but AFAICT the call order is

  sched_cpu_activate()
    sched_init_numa()
    partition_sched_domains()

So if the NUMA topology setup failed, the regular topology setup isn't
going to fare much better.

Anywho, there's nothing wrong with your patch, it's just that in case of an
issue it IMO doesn't improve the situation much.


