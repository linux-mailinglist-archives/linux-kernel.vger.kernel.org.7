Return-Path: <linux-kernel+bounces-805462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD4B488D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F65A161B98
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C422F83C4;
	Mon,  8 Sep 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UZV7q01N"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173E72F49EB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324476; cv=none; b=Oz3/jvQDstGwhmI/1yJEoHyPfAy0sOcIHoz0vke+P/Or49n1S9nN9zdf0j3jI4gj3+DhfgjY60vaeRTk55ogXfZ34Dlg6VoWTFBvMse77vsQ+Ja3PBJbk6HZ1NICkkuKEAQ7nQsBzSlmlB8U5P+4I5bEUcq5gUgAwKqQqF3opFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324476; c=relaxed/simple;
	bh=66wRVM6m3TXopzF2H4lG/Z9N0JNto9PXUsvf4Z5PGvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrVdgkkNxc4MybJ19KwReRXb3fEYz5uM/mkhAoSngzYL5yalxayJXZsZogwcr0kh4MrInaYrHfmWL1LFbuK1nvwV0RXKRdnrhrjLfnkvCNgbJLhDNDoPzxAVZzvGwzR7/ySBWr31gHFkh6e4BCKkd4v0PCEuhcODqLI5YJNYo9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UZV7q01N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58894iwR022881
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 09:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rLkopAvHXNphSnNL8Z6qcCho
	LeEnmUgrVO2Bksqi2ZI=; b=UZV7q01NFl3HrCaOGPeNLl9/sd0YyL2tsbFBCDG/
	OvV/R7T+mpU8C+krsVbxsCpK1s+sAbIOcAwVHiuaNfLVLMpawirpaaqDPAEoo3mH
	qRlV34rW0uREu6xbb5UXUpOp7Y8itOg8qYDp4HJjKf8Va0VEXqOvp01/YPQwMYMw
	ztiqJBY3AK0hYXjhrhgBwLHAkIZIE+PSa/te1Hoi2swzq+H27ZJc1Tyz9se+a23T
	0MJrY+mCEs444APJcr1FfTxKOfbhvtKtYn6+8ytOVpFzSYgqaNXB8Bz3rob2VcZ7
	1mQgJxqxP/gTq+xQ8pV+6Vwx0FP15FVU2w/lUOwvDdY7qw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j47c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:41:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5e5f80723so93301601cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757324473; x=1757929273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLkopAvHXNphSnNL8Z6qcChoLeEnmUgrVO2Bksqi2ZI=;
        b=VVE+xk8gnejd9HD7u3CVWC+Jf8JKsbK+9e0sFMH/T2ytQoJ+xHRrEFmRs/gzTPGtNr
         1lroS6D8LkHKIUvllO/Fx7TNQhrws4NnA7J+XJvuqiDdlzSaoOq/EFCO1AQRaRwbBBYj
         y1f8C6nCYRZxVga7rltPGP7EsqNxRs4+/lelLyEYs8WX4cJ6YQxhj2z3Avc0Y//EeYIf
         X/Pr5cwNU3AiRfp9kFvHRn2H+ekVDeu7QWQhbQjSn6qDsQi9rQKXoRnkvSLXdvSAZy59
         K7fneoO+BbnRUn/ccSUZfSYHd6OEOwVabC7E/tURSmgClUdnNGtq/PS8xIfom94qK0vR
         fs9g==
X-Forwarded-Encrypted: i=1; AJvYcCX2OG+fkvit4A++LSI8NsPS8P+Y1IvETJ0+SRF0itxPPhu+KnOGaBKdceAEpJZAPRx3BPy4pv7FnPQgndo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAiaLq8pnnT7gt4aVNMOgE5eyo5dvGpDatfJUrHNvRB1z+jmcM
	wbbWSmj08Py+5ZChMs6kjvFTZVaGP52I5kYoliS56fncldCxA4WvUVLh2Ax9v3Y8PYKxK85a67H
	DcDtlCrlhIgGVWhzGHx2cxT1c8KMcLvdoWhxHRpojG9UKjnGC9tj3yfiNY/JBuD7SOMc=
X-Gm-Gg: ASbGncvBXIN6R4Lilpwrfthr/whS16V3BF6puoTYklAHJlsXuLgJNp/Dh8n7eUY74Vr
	IuD3MImP315tBeIRHMmu/4rZ4o8YBAu21gWfw+P9tDofY5T1nTHDCqvtJY0lI3BrCb1zD9UVr6P
	PNjmVj8TZMClcO5nJXlkJk/UsL77EbJ6ss+lSpDU0c8zZ62GkpBcl/uhKl/ldXPLtghnRNoMUk5
	nBJCRnwUzMTy0TLSh21iJdBYBnUdi0v2l8Y/cmpdLYa33JAuoh3JVBhFYNxycD4sTzgvvuCtVCg
	+5XyqVtWdf3L3hdgkuLvTVhqQcA8qOig4prh97PGkxfUZZVqEfN7qlBkxLu68xRwo6tgA4c0/ON
	1Z00UngfWPgU4a9/74kjzAjSm+pfyf16tUmemiwj51LRNvGTlntGi
X-Received: by 2002:a05:622a:408f:b0:4b2:eeed:6a17 with SMTP id d75a77b69052e-4b5f844db32mr72590961cf.46.1757324472861;
        Mon, 08 Sep 2025 02:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED6yA4XaMS5YnDRmXOE5SImaTO28AEqye57aEqOauBtVGl5BLAOdUCTQLQCqvscMVaIInAYw==
X-Received: by 2002:a05:622a:408f:b0:4b2:eeed:6a17 with SMTP id d75a77b69052e-4b5f844db32mr72590761cf.46.1757324472225;
        Mon, 08 Sep 2025 02:41:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f50328fcsm32853551fa.40.2025.09.08.02.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:41:10 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:41:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de
Subject: Re: [PATCH v1 2/3] misc: fastrpc: Update context ID mask for polling
 mode support
Message-ID: <rszs7ttr6eibkzwfykrtokua37lxpeph6lq5t5c2rwemahghcr@zicxvouknr2n>
References: <20250901053336.3939595-1-ekansh.gupta@oss.qualcomm.com>
 <20250901053336.3939595-3-ekansh.gupta@oss.qualcomm.com>
 <dqkd4jxzrn4l6notk45udbapcan7icph5lpaoccgenm53kt4me@n7sv2rnf37im>
 <7250915d-4611-4f81-a46d-b85e76185aae@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7250915d-4611-4f81-a46d-b85e76185aae@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX9lO8BxrLo8NR
 jSHwsVjFJkjiBSDIERcbUthDYbczywkzjXmiNDsoSmRDDoHG5ek4mxGXxM51NA2ZEd5GmEPMV/I
 QAayvyo8Uo8YcretpYiWYaG94VKzyQbftpJBRToy8C8RW7ZiLos/WatbdfoYIKqqfYxS0dK3Pft
 +pW1EuueN/2e2F0flLZ6Hkz9BM5QsX6/AdBLFpYAchz3oDO+HJFeFXEGmz1SZt7tCFtR6jDkr6T
 U9DeSII8EZAnOLmb5B9+g4fgQH4Xv7Prugs5XnuJjrhriLGcfGRMomFz/ncAGrml1B5yTlgd8Fv
 eBceTOpl4zRND1b2gRLvAsocd6s+IaLP0d/BrPTT90ghYpRrD0sG95+PNRWlTiwBqB+snbB0a57
 giRVRfsM
X-Proofpoint-ORIG-GUID: ImFL7Toy5Ihe8M1brJtZcGpn-YcJ1Xz8
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68bea4b9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=wZnQ8fNWVwIMS66gRYUA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: ImFL7Toy5Ihe8M1brJtZcGpn-YcJ1Xz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

On Mon, Sep 08, 2025 at 10:42:10AM +0530, Ekansh Gupta wrote:
> 
> 
> On 9/2/2025 9:42 AM, Dmitry Baryshkov wrote:
> > On Mon, Sep 01, 2025 at 11:03:35AM +0530, Ekansh Gupta wrote:
> >> Current fastrpc message context uses a 12-bit mask where the upper
> >> 8 bits are context ID from idr_alloc_cyclic and the lower 4 bits
> >> represent PD type. This design works for normal fastrpc calls but
> > FastRPC (here and in several other places).
> Ack.
> >
> >> doesn't work as expected for polling mode. To enable polling mode
> >> support from DSP(DSP writes to poll memory), DSP expects a 16-bit
> >> context where the upper 8 bits are context ID, the lower 4 bits are
> >> PD type and the 5th bit from the end denotes async mode(not yet
> >> upstreamed). If this bit is set, DSP disables polling. With the
> >> current design, odd context IDs set this bit, causing DSP to skip
> >> poll memory updates.
> > This looks like a description of a bugfix. In such a case, move it to
> > the start of the series, add necessary tatgs and change commit message
> > accordingly.
> I'm not sure if it could be called a bug fix as there is no problem with existing mask.
> The problem is seen only when polling mode is added.

This sounds like a perfect part of the commit message.

> >
> >> Update the context mask to ensure a hole
> >> which won't get populated, ensuring polling mode works as expected.
> >>
> >> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >> ---
> >>  drivers/misc/fastrpc.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> >> index 0991ac487192..57e118de6e4a 100644
> >> --- a/drivers/misc/fastrpc.c
> >> +++ b/drivers/misc/fastrpc.c
> >> @@ -37,7 +37,7 @@
> >>  #define FASTRPC_CTX_MAX (256)
> >>  #define FASTRPC_INIT_HANDLE	1
> >>  #define FASTRPC_DSP_UTILITIES_HANDLE	2
> >> -#define FASTRPC_CTXID_MASK (0xFF0)
> >> +#define FASTRPC_CTXID_MASK (0xFF00)
> >>  #define INIT_FILELEN_MAX (2 * 1024 * 1024)
> >>  #define INIT_FILE_NAMELEN_MAX (128)
> >>  #define FASTRPC_DEVICE_NAME	"fastrpc"
> >> @@ -487,7 +487,7 @@ static void fastrpc_context_free(struct kref *ref)
> >>  		fastrpc_buf_free(ctx->buf);
> >>  
> >>  	spin_lock_irqsave(&cctx->lock, flags);
> >> -	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
> >> +	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 8);
> > #define magic value
> Ack.
> >
> >>  	spin_unlock_irqrestore(&cctx->lock, flags);
> >>  
> >>  	kfree(ctx->maps);
> >> @@ -623,7 +623,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
> >>  		spin_unlock_irqrestore(&cctx->lock, flags);
> >>  		goto err_idr;
> >>  	}
> >> -	ctx->ctxid = ret << 4;
> >> +	ctx->ctxid = ret << 8;
> >>  	spin_unlock_irqrestore(&cctx->lock, flags);
> >>  
> >>  	kref_init(&ctx->refcount);
> >> @@ -2449,7 +2449,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
> >>  	if (len < sizeof(*rsp))
> >>  		return -EINVAL;
> >>  
> >> -	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
> >> +	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 8);
> >>  
> >>  	spin_lock_irqsave(&cctx->lock, flags);
> >>  	ctx = idr_find(&cctx->ctx_idr, ctxid);
> >> -- 
> >> 2.34.1
> >>
> 

-- 
With best wishes
Dmitry

