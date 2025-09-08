Return-Path: <linux-kernel+bounces-805466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B47B8B488E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8703ACED2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573AD2EDD41;
	Mon,  8 Sep 2025 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pcsUPIA3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82E2629D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324674; cv=none; b=noB9TqwSNSw9XutyRH6gvedFgCYwhmVWVPRQbH0dJG6GBICNDqteBtLsvk5XM4ADiW1v6WEYLqRxS3Zrmu3Gy1rSnBJwG3bp1GBA9j4FnU/UlGkjaRSBQJ6t5nUpJKqabf1DlgDZ8JLsu1KnmXmt3SGgfPmd9nfYJ6AipvqlfbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324674; c=relaxed/simple;
	bh=/5Hp4uduzYR8rSn95qJodhbpAeVNgXuREjifN3dAWlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9X10kF04Na7qlPn5p6Jt1U2WkqksF9wXXIr0BzL+WJL6mraS/eBxIkJtggSq+l9sZ9tidCMXqqNtM5PxOep8LKNNW9j3JcqVMlU2ifQCcIfBbBHvqizkWGuewYAKJIh7f+HIIWE0LDzE5tbUvc8RRlcWj/1J1ZnX8LoLZEewlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pcsUPIA3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58894o3T013497
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 09:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5rENSTqix0MMCx/6sKK4C2em
	OiiVNOCSu1Ih7Ltw5Os=; b=pcsUPIA3R7RXvbbz8+O9zHythIMmKzboSZufST+S
	9vB6ouWS19qFhrTK92neLvDRvdfBikhVjFt8IuYkjlBjNIhJGnzMcPshvOQfjIrT
	0hVTNWi1/xEqj9yq2rvUAwHWBTMb4XalqspGwKy99ihPQtd3+CeOe7FtIvknY8ey
	4aDR/I6j+mHkrtKHFLPsVdr0RNi3A3cW5gg81voHJY99vvGC2cWIHDSaifXDu3Jb
	p79s4mPW0RrzkyEzg0D/gONPSWvqwbR0H0SfwA0SrooZmoZLTJIfjOYAlRxGZbSI
	NDF5aFBYzcG7WjQv8X7DMT8ZuY/caXXDPl6qngJkVGHGuA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0m49b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:44:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5fb61d80dso52725391cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757324670; x=1757929470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rENSTqix0MMCx/6sKK4C2emOiiVNOCSu1Ih7Ltw5Os=;
        b=W4pU7CAfAVBSHFV1bQMeZKhJX60GQW5eCZSmK01cnMGQZaWuadbqfMG0ZywJFkG4jY
         yLKIAP5HnEGaCL8U47NSpIvfLwbwcs4yrO2W6pgLrtHWDEYr2ZmYH5QjU8sImJKi4Pg6
         1fze6ZB+cE9Ykx2yYZbLArOs4G1nYac9ABKNWAqMLbxs93o1/jNbui8/UsCFrh9WDbdS
         +UlCCUJaNh85uU6QjelqtGJDQvjtNBPnuRd/TjOYZCqDbZNbWSj32Qj0u9vSPIMOeLts
         ql/IMmmin6b5uFe9UNcCdsROAgshKOdf6tD/YiRwkyaQESN7rkmLY87jkUq4eL762YmY
         7FUw==
X-Forwarded-Encrypted: i=1; AJvYcCW9UTR075rGD+ZvRwOuF7o0b0xZgBODZM1sJUcUewGTDwymTM1Yf/FXUZaZWGNJvxDGxnPrk8poJX0/yz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+TOTDJ77MJ901QXLtyNfKUNkJJ/E3hQvgy28t4KxQ+qzo8xtn
	9U2HqIextgAGWrswF0L5ZjJCHemtpo5ThDM19nseDa8c5YDK2sLEyUZydpFBBGXM3FL0SDmhk3J
	iFuTmPged8mvZA8kA+ENfVb/RwQ+9FouQbLf8VA5d9cDE4er+BupfwSNBto3yNxtQE5Q=
X-Gm-Gg: ASbGncvF9xfRLcXA7u0phn6dXzDzy7I+iJsREDilDrh3opZoUaFZwvNlKvHM4O0f3i/
	n/GYp1zD58qBMhE8FE5PGFpa0ISFfOP8vbXBauYaCTLc9qoRt+5o1o7u54eXqo3B6ygEZuvMqOF
	wFFAtJE2vtc5OUl+GiO2rVkNEZMArn4jJgRcX8/eeqoEuwOy6FzZqS4XODCGJxyylLCdyA1SNct
	f08SGLzORac3JQY1MkuI985StBoA35UQFXjiBjqjdfOq8wKimhEKZnJdeBvnzvWHl8Y3g92vGqf
	OEPfTeA4kEJXRQo3w0GkEhBnXVz8TFcLNREuMmZSTr/fulhXrxA2/DdY4JWrjM4MQSCzInIerGf
	6crsniHRpBSZehggnvY4kw5gj6DrVHV+PLp9cZ+ZjAGkJYyRgK7H1
X-Received: by 2002:a05:622a:48d:b0:4b5:da71:ce79 with SMTP id d75a77b69052e-4b5f846e7c2mr69987141cf.67.1757324670108;
        Mon, 08 Sep 2025 02:44:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBnnlR+4cBWITz1MAUjlBX0yTQF6M4LnI6V4qVgtvEit672J/Oa5JSnMf/qLMbIsnJYQWefw==
X-Received: by 2002:a05:622a:48d:b0:4b5:da71:ce79 with SMTP id d75a77b69052e-4b5f846e7c2mr69987081cf.67.1757324669526;
        Mon, 08 Sep 2025 02:44:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfbb87sm3567158e87.105.2025.09.08.02.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:44:28 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:44:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de
Subject: Re: [PATCH v1 3/3] misc: fastrpc: Add polling mode support for
 fastRPC driver
Message-ID: <zog2obugvfhxq5jspwu6fhsdnntzd4fwuanzvwskkimgk7m42q@p3cfwu5rbrlk>
References: <20250901053336.3939595-1-ekansh.gupta@oss.qualcomm.com>
 <20250901053336.3939595-4-ekansh.gupta@oss.qualcomm.com>
 <hqbazo62hdfwgxoevzkchfddvjpr2ttp7wltpkoooou5anongs@5ncpjec3egjh>
 <1f5daa38-51c6-4546-a9e3-3a91f7b3fc5b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f5daa38-51c6-4546-a9e3-3a91f7b3fc5b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: r9SBUnd2FRXedKE4z2dvM0yFaMQBjVD9
X-Proofpoint-GUID: r9SBUnd2FRXedKE4z2dvM0yFaMQBjVD9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX00gbm1eIEMS8
 sbucfwzaQPzebN2G9b/jQROWQ0scl4GpWi4B29bDhGMQb8jSHnOOqk8M6H+PXPTVU+K0+siaCoy
 PhHOAHPyXcP8cjOsF0KvW25nrGkBu7UVGjI7FMYhwkocbpSZIQiZCRwtS4eSiWFah3tKQSuWm02
 GtVrXzWL0MzhHRjS3f1FiY6/JDAybkAUrsDgonjz3Lf+2scLrntzNbPdAChlEf/4nbUxslzkHmC
 2L1DAa47Y6nqCLF2nnoYJh7b87F5bZ8/M+RszN/IZlVbeR5j0GcebMeRBMamC6n4qY5vLu/B9e7
 rwyQLtJk8C29or3JHmUDtFAaOwHMHw5m0H+US5MyfIjZCRGVwyjNKVFs/jp9WNpC4jrNMAlHyj7
 H3B2M+CA
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68bea57f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=GeyHAHgnsv86aQrLecQA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On Mon, Sep 08, 2025 at 10:56:00AM +0530, Ekansh Gupta wrote:
> 
> 
> On 9/2/2025 2:51 PM, Dmitry Baryshkov wrote:
> > On Mon, Sep 01, 2025 at 11:03:36AM +0530, Ekansh Gupta wrote:
> >> For any remote call to DSP, after sending an invocation message,
> >> fastRPC driver waits for glink response and during this time the
> >> CPU can go into low power modes. This adds latency to overall fastrpc
> >> call as CPU wakeup and scheduling latencies are included.  Adding a
> > s/Adding/Add/, see Documentation/process/submitting-patches.rst
> Ack.
> >
> >> polling mode support with which fastRPC driver will poll continuously
> >> on a memory after sending a message to remote subsystem which will
> >> eliminate CPU wakeup and scheduling latencies and reduce fastRPC
> >> overhead.
> > Describe your design decisions: when it is enabled, why, etc.
> Yes, also planning to enable it from userspace in v2 due to power consumption
> concerns.
> >
> >> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >> ---
> >>  drivers/misc/fastrpc.c | 121 ++++++++++++++++++++++++++++++++++++++---
> >>  1 file changed, 114 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> >> index 57e118de6e4a..939a3e3d29e2 100644
> >> --- a/drivers/misc/fastrpc.c
> >> +++ b/drivers/misc/fastrpc.c
> >> @@ -22,6 +22,8 @@
> >>  #include <linux/firmware/qcom/qcom_scm.h>
> >>  #include <uapi/misc/fastrpc.h>
> >>  #include <linux/of_reserved_mem.h>
> >> +#include <linux/compiler.h>
> >> +#include <linux/iopoll.h>
> >>  
> >>  #define ADSP_DOMAIN_ID (0)
> >>  #define MDSP_DOMAIN_ID (1)
> >> @@ -37,6 +39,7 @@
> >>  #define FASTRPC_CTX_MAX (256)
> >>  #define FASTRPC_INIT_HANDLE	1
> >>  #define FASTRPC_DSP_UTILITIES_HANDLE	2
> >> +#define FASTRPC_MAX_STATIC_HANDLE (20)
> > What is this?
> Static handles in FastRPC refer to handles that are statically defined and
> associated with modules in the DSP image at build time, rather than being
> dynamically created or loaded at runtime. These are typically used for
> system-level services or core module.

Is this a const which has always been set to this value and will never
change in future?

> 
> Defined this to limit the polling mode only for user calls.

This needs to be explained somewhere.

> 
> >
> >>  #define FASTRPC_CTXID_MASK (0xFF00)
> >>  #define INIT_FILELEN_MAX (2 * 1024 * 1024)
> >>  #define INIT_FILE_NAMELEN_MAX (128)
> >> @@ -105,6 +108,20 @@
> >>  
> >>  #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
> >>  
> >> +/* Poll response number from remote processor for call completion */
> >> +#define FASTRPC_POLL_RESPONSE (0xdecaf)
> >> +
> >> +/* Polling mode timeout limit */
> >> +#define FASTRPC_POLL_MAX_TIMEOUT_US (10000)
> >> +
> >> +/* Response types supported for RPC calls */
> >> +enum fastrpc_response_flags {
> >> +	/* normal job completion glink response */
> >> +	NORMAL_RESPONSE = 0,
> >> +	/* process updates poll memory instead of glink response */
> >> +	POLL_MODE = 1,
> >> +};
> > bool is_polled;
> >
> > OR
> >
> > unsigned long is_polled : 1;
> >
> >> +
> >>  struct fastrpc_phy_page {
> >>  	u64 addr;		/* physical address */
> >>  	u64 size;		/* size of contiguous region */
> >> @@ -235,8 +252,14 @@ struct fastrpc_invoke_ctx {
> >>  	u32 sc;
> >>  	u64 *fdlist;
> >>  	u32 *crc;
> >> +	/* Poll memory that DSP updates */
> >> +	u32 *poll;
> >>  	u64 ctxid;
> >>  	u64 msg_sz;
> >> +	/* work done status flag */
> >> +	bool is_work_done;
> >> +	/* response flags from remote processor */
> >> +	enum fastrpc_response_flags rsp_flags;
> >>  	struct kref refcount;
> >>  	struct list_head node; /* list of ctxs */
> >>  	struct completion work;
> >> @@ -891,7 +914,8 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
> >>  		sizeof(struct fastrpc_invoke_buf) +
> >>  		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
> >>  		sizeof(u64) * FASTRPC_MAX_FDLIST +
> >> -		sizeof(u32) * FASTRPC_MAX_CRCLIST;
> >> +		sizeof(u32) * FASTRPC_MAX_CRCLIST +
> >> +		sizeof(u32);
> >>  
> >>  	return size;
> >>  }
> >> @@ -987,6 +1011,8 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
> >>  	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
> >>  	pages = fastrpc_phy_page_start(list, ctx->nscalars);
> >>  	ctx->fdlist = (u64 *)(pages + ctx->nscalars);
> >> +	ctx->crc = (u32 *)(ctx->fdlist + FASTRPC_MAX_FDLIST);
> > Why?
> DSP considers the poll memory to be at the end of metadata buffer. The contents
> of metadata are in the order as added in fastrpc_get_meta_size

It's a different why. We don't support CRC. Why are you adding it here?

> >
> >> +	ctx->poll = (u32 *)(ctx->crc + FASTRPC_MAX_CRCLIST);
> >>  	args = (uintptr_t)ctx->buf->virt + metalen;
> >>  	rlen = pkt_size - metalen;
> >>  	ctx->rpra = rpra;
> >> @@ -1155,6 +1181,83 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
> >>  
> >>  }
> >>  
> >> +static inline u32 fastrpc_poll_op(void *p)
> >> +{
> >> +	struct fastrpc_invoke_ctx *ctx = p;
> >> +
> >> +	dma_rmb();
> >> +	return READ_ONCE(*ctx->poll);
> > Is this enough? Is the write by the DSP side going to invalidate the
> > cache for this memory location? Think about older platforms which
> > usually don't have dma-coherent property in the DSP / FastRPC nodes.
> Yes, DSP will take care of invalidating the cache after writing to this memory.

Will DSP invalidate the cache on the CPU side? On non-dma-coherent
platforms?

> >
> >> +}
> >> +
> >> +static int poll_for_remote_response(struct fastrpc_invoke_ctx *ctx)
> >> +{
> >> +	u32 val;
> >> +	int ret;
> >> +
> >> +	/*
> >> +	 * Poll until DSP writes FASTRPC_POLL_RESPONSE into *ctx->poll
> >> +	 * or until another path marks the work done.
> >> +	 */
> >> +	ret = read_poll_timeout_atomic(fastrpc_poll_op, val,
> >> +				       (val == FASTRPC_POLL_RESPONSE) ||
> >> +				       ctx->is_work_done, 1,
> >> +				       FASTRPC_POLL_MAX_TIMEOUT_US, false, ctx);
> >> +
> >> +	if (!ret && val == FASTRPC_POLL_RESPONSE) {
> >> +		ctx->is_work_done = true;
> >> +		ctx->retval = 0;
> >> +	}
> >> +
> >> +	if (ret == -ETIMEDOUT)
> >> +		ret = -EIO;
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static inline int fastrpc_wait_for_response(struct fastrpc_invoke_ctx *ctx,
> >> +					    u32 kernel)
> >> +{
> >> +	int err = 0;
> >> +
> >> +	if (kernel) {
> >> +		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
> >> +			err = -ETIMEDOUT;
> >> +	} else {
> >> +		err = wait_for_completion_interruptible(&ctx->work);
> >> +	}
> >> +
> >> +	return err;
> >> +}
> >> +
> >> +static int fastrpc_wait_for_completion(struct fastrpc_invoke_ctx *ctx,
> >> +				       u32 kernel)
> >> +{
> >> +	int err;
> >> +
> >> +	do {
> >> +		switch (ctx->rsp_flags) {
> >> +		case NORMAL_RESPONSE:
> >> +			err = fastrpc_wait_for_response(ctx, kernel);
> >> +			if (err || ctx->is_work_done)
> >> +				return err;
> >> +			break;
> >> +		case POLL_MODE:
> >> +			err = poll_for_remote_response(ctx);
> >> +			/* If polling timed out, move to normal response mode */
> >> +			if (err)
> >> +				ctx->rsp_flags = NORMAL_RESPONSE;
> >> +			break;
> >> +		default:
> > What kind of response type can it be? Have you had checked for the flag
> > being set, you wouldn't have a false possibility of having another
> > response type.
> Sorry, couldn't exactly understand your point here. Are you suggesting that as the
> rsp_flags is getting set by the driver itself, there isn't a possibility of having any
> unsupported response type?

Yes.

> >
> >> +			err = -EBADR;
> >> +			dev_dbg(ctx->fl->sctx->dev,
> >> +				"unsupported response type:0x%x\n", ctx->rsp_flags);
> >> +			break;
> >> +		}
> >> +	} while (!ctx->is_work_done);
> >> +
> >> +	return err;
> >> +}
> >> +
> >>  static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
> >>  				   u32 handle, u32 sc,
> >>  				   struct fastrpc_invoke_args *args)
> >> @@ -1190,16 +1293,19 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
> >>  	if (err)
> >>  		goto bail;
> >>  
> >> -	if (kernel) {
> >> -		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
> >> -			err = -ETIMEDOUT;
> >> -	} else {
> >> -		err = wait_for_completion_interruptible(&ctx->work);
> >> -	}
> >> +	if (handle > FASTRPC_MAX_STATIC_HANDLE && fl->pd == USER_PD)
> >> +		ctx->rsp_flags = POLL_MODE;
> > This definitely needs to be explained.
> Ack.
> 
> Thanks for the review.
> 
> //Ekansh
> >
> >>  
> >> +	err = fastrpc_wait_for_completion(ctx, kernel);
> >>  	if (err)
> >>  		goto bail;
> >>  
> >> +	if (!ctx->is_work_done) {
> >> +		err = -ETIMEDOUT;
> >> +		dev_dbg(fl->sctx->dev, "Invalid workdone state for handle 0x%x, sc 0x%x\n",
> >> +			handle, sc);
> >> +		goto bail;
> >> +	}
> >>  	/* make sure that all memory writes by DSP are seen by CPU */
> >>  	dma_rmb();
> >>  	/* populate all the output buffers with results */
> >> @@ -2462,6 +2568,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
> >>  
> >>  	ctx->retval = rsp->retval;
> >>  	complete(&ctx->work);
> >> +	ctx->is_work_done = true;
> >>  
> >>  	/*
> >>  	 * The DMA buffer associated with the context cannot be freed in
> >> -- 
> >> 2.34.1
> >>
> 

-- 
With best wishes
Dmitry

