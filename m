Return-Path: <linux-kernel+bounces-784443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0039B33BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F3E1B27CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBF32D3A9E;
	Mon, 25 Aug 2025 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E1YSSVrl"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7952D0C9C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115476; cv=none; b=tBPz+O5nabBxFfd12dXopKMc3L6H/T9MT9MQkyCE/BT0DrkWz9gGlerc9J4OGfhiaqR3ltxxDjazK+tgTSfvHfFdluyDKEpUJjsN1MhRA7jcJnFOKgSzPkACPydEtB7shAsrRUlSASk+lN1GReyC/kz3HZdmgqQQMyEiF0ZCXtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115476; c=relaxed/simple;
	bh=B8eCYEono40PCIy16xmaC4Aox2ZtXZbrtkZF8FCENiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKSYf2T7ByBySrI2HdNRbwBAQno6en22JC2Jx3GrmEL6J7fIZKyHNLG0cgo/g7Jt/YojUTHBrQIgpS2bnbOQf82oclDcTr/YIbsSZiVS7z5eBY+TKJYJnZEOTbvM7zruqmBuf83YilPw6+xgES5JzJli9vuKUqZp0Ib8LxXUOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=E1YSSVrl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-771e987b4e6so341106b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756115472; x=1756720272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=91s1cIGRQAxrumxrJ8ni6aEx18e/r1sz4gPLC81PIgY=;
        b=E1YSSVrl8O1J/DGQWQkRBjERagRt0CuIMoYZFNRkgUW2Y9BQf3qFeYQRmUqFSaHT6O
         bFkk/QetwGsQXg8DKAjBdYNpQycSlMQ2De0vvYOVRfRu7Gv9HyNMwtWlMXH66KFoyevZ
         F9um6xbXyAkHdC9p3Mx1m10vpMTfmoz+3BohjFROf2HSDHY+3Daqr+kLdTE22bhx95V9
         ExkFTB8d+eEmMphg+c5cjrbHv8aTtiC2dRztLHWxEnQcLWk/yX+zGK/MGq1BIlkkosYt
         THlG0bmrm8+pEKSmXcfNTCapzIo3fsPZfN67EeBEs+qkUjj6aOV7wQmd8EOwyEFnVRpo
         Edxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115472; x=1756720272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91s1cIGRQAxrumxrJ8ni6aEx18e/r1sz4gPLC81PIgY=;
        b=ZjdKivpARtWpnq6QhIGkXYx8SDN7EkqGYzSDOFOnNTNJTI7ropfdjIwIrxcomMJo75
         agjKg9GIdDXwuscH6OWRKJ6m8RGMkgA6bKkk5T9P8FNcjCvBey6Jq1RfMzeL52BDAxSf
         z92ED95+RlYU3VWNCBkjm7zXbQ6kEb4Ujv8IcL6zxBKx7cDxaNLtly1numTpD+1/JJgZ
         40EipmuzAw5mSJI4FoX8mWCL5+mrVU5A8YWfdYftXA/S4LNhV8xUMxorzqBcmeS/dBAM
         +A+6Fh4AwI7D4fu6nHKH1BbRcyivtvDsFupwKYGFZK8hjx6/PqMmbvSECp9SeV++B2hm
         EsLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9Z0lVHL6K1PFq4PrqYbeyNrBk7i7pQnJW5q32BGCUSUj/wYWVr1nvWZBOiZ5ZY3I5y45VKikbqPLOCa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVHFHZCwoDid6GwNOT9eXUFLEoOvays00gqHTPOpLCoQ6nHIq
	5ma7BRTBPgPNdP6v377r44Csd9I4T38l5XwKXQTH2jAyvygdm2hf2G+RU0dQE4Oo/w==
X-Gm-Gg: ASbGncvLUOR0nSMr5LwS1ePR2/CqnOUW6pPKRdZBqjgvLetbbgFgldCZ8fXc8VMjCzT
	OFjd11bqdYDSwWZ9+MOceaDGzbAAToGEqTXyuZFYDtX+TKB4u9vFn/VsSPF7Ts8bgTC0h72klP6
	65dK+uAiJ3mzGLV6jIuPj4QoYlZkU+CBY78C5jZyFFm29KaOh5dnJ1Zgq+X/UzXtmRj2Zkvy4Yk
	Pxrer5Sb7c9u+xKbtqFmcAqLUOTK2RKy+n4QFo5WUO+xaKQpgErEFCTc0MnPomAVcCJM2TGLuG9
	EZXGs1MVpV89gtUkWSHmZUrcI6Ih3WC8T6CgB+FDN+E4P0I1GDfH4h0AbZzLJSCPj30/yEsoSdI
	i+6/Oam4KqVMRghG1kYN3conVeV/kFjMLIyO6zKKB2HiNSL0=
X-Google-Smtp-Source: AGHT+IFKmShdsyMlmj4cT5JRWT7LwYbqWBv7GzkGKLvpKSJg5ombkdXo91DBer2NpWN+oCdJY5Gk/A==
X-Received: by 2002:a05:6a00:2288:b0:770:3064:78fa with SMTP id d2e1a72fcca58-77030647984mr14107031b3a.2.1756115472294;
        Mon, 25 Aug 2025 02:51:12 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770b5bed408sm3213674b3a.18.2025.08.25.02.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:51:11 -0700 (PDT)
Date: Mon, 25 Aug 2025 17:50:56 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: xupengbo <xupengbo@oppo.com>
Cc: bsegall@google.com, cgroups@vger.kernel.org, dietmar.eggemann@arm.com,
	juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
	mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: Re: [PATCH v2] sched/fair: Fix unfairness caused by stalled
 tg_load_avg_contrib when the last task migrates out.
Message-ID: <20250825095056.GA87@bytedance>
References: <20250806071848.GA629@bytedance>
 <20250806083810.27678-1-xupengbo@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806083810.27678-1-xupengbo@oppo.com>

Hi xupengbo,

On Wed, Aug 06, 2025 at 04:38:10PM +0800, xupengbo wrote:
... ... 
> 
> It actually becomes:
>     if (cfs_rq->tg_load_avg_contrib > 0)
> if cfs_rq->tg_load_avg_contrib == 0 , it will be false. As it is an unsigned
> long, this condition is equivalent to :
>     if (cfs_rq->tg_load_avg_contrib)

I suppose we have reached a conclusion that the right fix is to add a
check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed()? Something
like below:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index af33d107d8034..3ebcb683063f0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4056,6 +4056,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (child_cfs_rq_on_list(cfs_rq))
 		return false;
 
+	if (cfs_rq->tg_load_avg_contrib)
+		return false;
+
 	return true;
 }
 
If you also agree, can you send an updated patch to fix this problem?
Thanks.

