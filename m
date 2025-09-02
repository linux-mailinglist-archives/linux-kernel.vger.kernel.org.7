Return-Path: <linux-kernel+bounces-795508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8F8B3F391
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5103BD184
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C9E2E11C6;
	Tue,  2 Sep 2025 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z9SeDsfd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586A2E11B6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756786349; cv=none; b=Meh2GZPpCecn5ux6Rtg0ZL54nItVBNctG2G8E6iByz6O6XQlWrgE5OQcBtAsxhEtbBFDoZiX7XJE7ZAdcUDW3/fUnR9PzYTJpROtAwCgsFTyV0AEsMYfXQFOiAgrhs6TMkZQG+PTiVWlaci9a18qj23hlkldPfbPq6vTII9kMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756786349; c=relaxed/simple;
	bh=zbdpW7G8dg6+El5YE34lASj1j6xTuEzXUpc9aYPaKXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6weqHRjh/4vDccxwUmu+UhX8NZzBLW5MXcdKWGLwEIrLtzndKtReH3AfWG5PkJERr+H4dISZxCCIh8UrpsbU1aQQGZiu1LfLqnbT1pwV1slSDzLwZtighfmsk/PlBoCEQ6EHy4LCJaJD5sVo7yGwdZpUgn96WXoMkyeNylvrhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z9SeDsfd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SAMS022312
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 04:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4hytzX8xBTH7gMfyLEWCSqte
	MJOdC0UJlFb3/TsaAvk=; b=Z9SeDsfd7UR2aP6UdZhf4hrBgbBGC1EzAHPEkhDA
	D/pTRAWMyO/YqiQDK7WNra9wKwIevfeaO8OJ6sSVsOK5kVc0JU/XMBv+4iD0jD04
	eyiU70lUY6ligxbRzieTemKS287oDglSpqF3GzqOr4UpQZS1PScCF1dhtSvHFRSZ
	H0JT52dXo3SHy0ZZh9gixIBAUGDz5oKKGH73zEU7KRIWaOnF9rzbY8HGuGzsHLdD
	02XagceP1tFhJAEwZGZijtOtJyVYvS7IZwzsYz4S41stgJkPXs+AqbNe2+Rgl04H
	s6/6LGFP9jFO17iKFRb7tBwAKk1rufKIpdqhoEXJZoDWZQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp6kfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:12:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b311414656so107496031cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 21:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756786345; x=1757391145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hytzX8xBTH7gMfyLEWCSqteMJOdC0UJlFb3/TsaAvk=;
        b=S8cbTFaIEGYNEcJpehgyWEHNLCZ7uewray/O38Lv09b4n5w0I5ykO6nS+UTRVS4AeE
         wPYF9zdGS9tStPGZY4InuwTti0NxfFwaJfikwViOT2A+DY+bXybyFiuteiDkjvDNGPoa
         gqJf2B84vBDWzoaScLIgpEgUH1WqGNi//bBzYkeiBj40XP7EON1appQHc4F+9Zo3zslF
         W7PIWaQxzKzPjGNGxt5/ZSZf6J4dxusS8UP+wd4CUTm6/xnL/1g9eZEciIhqNKr5sn0h
         B/QU+IDBl1SaHTPYmWMcEanH0FOsvA5T/p+Wl2dSBEuBQgO+YMPIemGZFFOmAjUe104n
         yYXg==
X-Forwarded-Encrypted: i=1; AJvYcCVg0oGPCaq88dVby7GGYhtT57ZJ2J9muIs2rnhve7Gm5Niu0G+iaKxP9O8eS2r5QBSLJUuEh3GkeJ7hxcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsFhE3mfbKe5RWF0IZKILbM7X2/X6mm00DBEO+9qdXfhPiCb0k
	5GV7k3y+Uf+vioCXCVn4TrozdZb40rS0qwKe0nb/8ZLNTtbiZORmy/NsPwAn9ZcR2gdztzBwLpO
	k9M1WpPruqa9cizBwsU3c+pCUVCkPOnU4WB0A8wlfHtbrexeuP3G/vt7GEq9y3uRsb0M/y/kRgN
	I=
X-Gm-Gg: ASbGncunlkVlC8xYBZ66bbnDGL0sAMhT2Q0i/EnfU2v0+6vnUNG3gsyEDywW9OHJzwC
	YQpm2f8Pe92arwvoEY8Cp4b/wQAYa8rcABjr3Z1lcHUNXWcULETXW3iEKjPOSY3mQlC21/vJR6L
	2eN2lguf0Hv5JpM1cTR+7H/WJuKbc24iWTlvgSmN9eAYgN0loKyUsqQgdnW96hCOZ7eLR7iA50S
	c399n6I4xWNLOIlWPoL3HuZRsSMfjYeAnvFXH5aH8HBUe96Z64GnpBju1+bvNjRT5rvgpR3JuiB
	4Hialj3KWn+JflWda8IWOgfWDY+Kvl3+Ih8KM6wVafUEQ+eA7JTJFJUHCYPKqJXI5b+Hm8AHd/i
	A8RMt59qxamnUDR8p2jsXlY64lPaWlMm5bRJLgfU1De0qmtymkjjM
X-Received: by 2002:a05:622a:1452:b0:4b1:dd3:e39e with SMTP id d75a77b69052e-4b31dd23338mr114026691cf.61.1756786345095;
        Mon, 01 Sep 2025 21:12:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ5ZmDCtlOCTJ5CNy/dDBkom0CRsWFzCNRi65zEfcrO5jaS3sB1mwTAnfyqabE66OpLSYXiQ==
X-Received: by 2002:a05:622a:1452:b0:4b1:dd3:e39e with SMTP id d75a77b69052e-4b31dd23338mr114026441cf.61.1756786344501;
        Mon, 01 Sep 2025 21:12:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56082793359sm352715e87.88.2025.09.01.21.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:12:23 -0700 (PDT)
Date: Tue, 2 Sep 2025 07:12:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de
Subject: Re: [PATCH v1 2/3] misc: fastrpc: Update context ID mask for polling
 mode support
Message-ID: <dqkd4jxzrn4l6notk45udbapcan7icph5lpaoccgenm53kt4me@n7sv2rnf37im>
References: <20250901053336.3939595-1-ekansh.gupta@oss.qualcomm.com>
 <20250901053336.3939595-3-ekansh.gupta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901053336.3939595-3-ekansh.gupta@oss.qualcomm.com>
X-Proofpoint-GUID: 3JQ3uVAG33xCWoV63HH43XUh5q92zpZH
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b66eaa cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ruUdINtktsOv1bkmipUA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 3JQ3uVAG33xCWoV63HH43XUh5q92zpZH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX1ubou3YIDWaR
 zMosJsnhoe2ggndir/TmhbHiWEQErccKia4hoad0I1scgOc9D1yepbwDfv4RBv/RqupjJyKdooR
 bBKovG+iC9J02hMGMCP02PMcdwd1dZB2/+f6saWfT9Ptav3evndjZXIGP99ZmMEYNaNlE9vf2IL
 5k7EgEUjsJGx4xc6f6cHaHlVvoFImM6ZdjfMJDJq5iPcwHLAZSThlCr3s5lX2zpfdSyiNwq43W9
 /BKE7s2klzOsJn3e1FUUOKMYHACpF43WHRaF/5C0+LJRU483uscxp2EOYVw3vtN4FIas4zyIh6h
 eHwaSYp7mj6dwxKqU9Tt73V0FvpfSrCsekCEn6zdHC+JeN4Lz92iafbKig/eohx66z7mRz8VC9E
 kLQ+ra4b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On Mon, Sep 01, 2025 at 11:03:35AM +0530, Ekansh Gupta wrote:
> Current fastrpc message context uses a 12-bit mask where the upper
> 8 bits are context ID from idr_alloc_cyclic and the lower 4 bits
> represent PD type. This design works for normal fastrpc calls but

FastRPC (here and in several other places).

> doesn't work as expected for polling mode. To enable polling mode
> support from DSP(DSP writes to poll memory), DSP expects a 16-bit
> context where the upper 8 bits are context ID, the lower 4 bits are
> PD type and the 5th bit from the end denotes async mode(not yet
> upstreamed). If this bit is set, DSP disables polling. With the
> current design, odd context IDs set this bit, causing DSP to skip
> poll memory updates.

This looks like a description of a bugfix. In such a case, move it to
the start of the series, add necessary tatgs and change commit message
accordingly.

> Update the context mask to ensure a hole
> which won't get populated, ensuring polling mode works as expected.
> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 0991ac487192..57e118de6e4a 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -37,7 +37,7 @@
>  #define FASTRPC_CTX_MAX (256)
>  #define FASTRPC_INIT_HANDLE	1
>  #define FASTRPC_DSP_UTILITIES_HANDLE	2
> -#define FASTRPC_CTXID_MASK (0xFF0)
> +#define FASTRPC_CTXID_MASK (0xFF00)
>  #define INIT_FILELEN_MAX (2 * 1024 * 1024)
>  #define INIT_FILE_NAMELEN_MAX (128)
>  #define FASTRPC_DEVICE_NAME	"fastrpc"
> @@ -487,7 +487,7 @@ static void fastrpc_context_free(struct kref *ref)
>  		fastrpc_buf_free(ctx->buf);
>  
>  	spin_lock_irqsave(&cctx->lock, flags);
> -	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
> +	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 8);

#define magic value

>  	spin_unlock_irqrestore(&cctx->lock, flags);
>  
>  	kfree(ctx->maps);
> @@ -623,7 +623,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>  		spin_unlock_irqrestore(&cctx->lock, flags);
>  		goto err_idr;
>  	}
> -	ctx->ctxid = ret << 4;
> +	ctx->ctxid = ret << 8;
>  	spin_unlock_irqrestore(&cctx->lock, flags);
>  
>  	kref_init(&ctx->refcount);
> @@ -2449,7 +2449,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>  	if (len < sizeof(*rsp))
>  		return -EINVAL;
>  
> -	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
> +	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 8);
>  
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	ctx = idr_find(&cctx->ctx_idr, ctxid);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

