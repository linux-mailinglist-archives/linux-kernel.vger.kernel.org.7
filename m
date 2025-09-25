Return-Path: <linux-kernel+bounces-831616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCD2B9D21C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA40F3A5755
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AD7219A71;
	Thu, 25 Sep 2025 02:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TE1fcczo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0CAD2FB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767110; cv=none; b=gCyg+K9s14qfZER1y8OEmdsIWtSghnYB+6TRqLUl44a8EZkvsKCNJ7Q2aBS1xyetVFF0P428EuxQP7RjP8tfzpgQGd6itdw0MaRIY4iCFk4CMExe21ZAwv83QqUcv9eT1AIMfB5Oqw17El/bV6/0VAh6C7mld1W8eggoYzDlZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767110; c=relaxed/simple;
	bh=0Qp/LugrnJ2KyMABNHdscnMwn/RF9ZoGFmQOfAhUdj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGIhsMwggmNAHGoT5V1UMIICasyYUG/VjZSBOfb2OQoKoQ2sy/WouYEl358uG71ovkJHtnoDWUJ1lbtG5XOs57RWM0mxAutvDeKxHoFY/AVCLxyZhPqCkjnm8pdrVFW3NM1aQNYNhrcgbXAxldWjhs/7fKfqT0oBNrgObxjHhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TE1fcczo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONiZAo022454
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ne7SM+pphoowCwgkbbaH/xsD
	0yWzyJX64HZAf3hO7xY=; b=TE1fcczoV3caO6ftilr66G17EJBDr5k6sK3DtOgG
	muczbVLL8o9MqBuqEx6XuUKXl6i2RlvXDfFyGgmobzydYvj6PCm32L00MRngBEL+
	E8cQaiLNJFEPp0nzhMscBw8ksEnXtlsPoOlinhxM0lpVwNkNmPp48noWnAn0FtvZ
	FLMAYWC2nDPzruCrU0BFWpb/P0BUwgDiL2y6qoe9Lt8ihuUCTJS7fOS9GPn0azFm
	vcE1EV5M6j068f2ZhQ6THjF0bxIkvuwjKwmXzdLFsOkToB8HoR6Mogsq33uj1BSe
	+S/4P4FtbwTxliksm8ZJuIsSVyHqToeGtuKUC3BmzTgVJA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budae02w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:25:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d9a3ca3ec8so9268431cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767106; x=1759371906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ne7SM+pphoowCwgkbbaH/xsD0yWzyJX64HZAf3hO7xY=;
        b=tlUkkA5ZB9/oNGNEUvtlgaIOccrae2bWGeuZaAB/eDlXG2yVzrRzdNdE1LhAKOmmvl
         FO2vH939BQI048nK/nMnG6x2g1mSCFZzfARJBbNmx9AgOZnU5zLUgrF8yPAbctvuNGiO
         3s+UPL4QE9cC2fZKzkaU+RY9sOroutpvKC7qVvHsIXFA4zI9NO3nEnk/HwTu1T2VsFiw
         QJP62dkfgwMJhxUzz4PibXmPw0Ga7spaJIgVZEwOMB4xnRdtxiKH+BbHh0VrnlOZ1aKZ
         +aeyfoBJd83YlcSA1JO9jQ7dTR1hk9OwtHjq/91754qVUE7XC3t6zD6F7pdLKsi4+/fA
         1zZA==
X-Forwarded-Encrypted: i=1; AJvYcCU5A8jvwOfaDSThw+MjODHI/QBtJzuskQEsrSi2uiCJKH21YRCUgMC3fpDdEivKUYlE8rK/Bz7xLOQExg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHWKMJqKBos22ARUs+tKiZpwj/s8u2V7m7L/2yWKq455xjzBbH
	ikJF+5onsx+YoWwwe0tHwy666j59veUpjJT79xPfx1bWtqX/iG2mzMVF5tGD/SRiUK6QZGa4MgK
	/uGTVd3yGskLKmwjugZlN7sjGS4nYk9C8NPpXTytW8a2id8fIgabgaznRc+ZbHV5qi48=
X-Gm-Gg: ASbGncuPclAIFlfuAdo71Bb2ZtT1/06B+gVVGI8MEfFf35pB26OPGV6oCaFmKuk/J+h
	hbPQCz61C17HhrQH3/Coos7Vh4FdUehrEZaYeWo8gYb8RLO3fy4/m2068I2jo7PXMT8qTFfS8hV
	i/VdLAbzqJ4iZuKA431vE6dBWqcHTKnL0jrl3QQVyYCNONeu+jg4BPfEqHTvwIIXwEdLZqqMsXe
	+34vngKFkUcN6E+DAfjqN9qqUsCeTZRfp0UVQxcSNfvQd5rZG438KanKhKuvWKKKGLDKNn3eWrR
	BOyyjISO0LzIcdYi8R5KR7F8YF566PXb9XVKiIaxKG7VPgZ9mUsHP2uiIWSW9rpVr84sQCNNSYn
	cfU9Yi5qu/gEBibLFP6EtHqPTNagmtU9UbUNnoDEBfODml7SZEmJU
X-Received: by 2002:a05:622a:5e16:b0:4b7:a6e7:655 with SMTP id d75a77b69052e-4da4b428c73mr24389571cf.52.1758767106133;
        Wed, 24 Sep 2025 19:25:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiXmI6eYBp1Yn318ynTQ8f5kNCV/BK4r+AQsF0qU33ngmoZSWiC6EUh0gnchKFzSHJ9LVbPQ==
X-Received: by 2002:a05:622a:5e16:b0:4b7:a6e7:655 with SMTP id d75a77b69052e-4da4b428c73mr24389441cf.52.1758767105630;
        Wed, 24 Sep 2025 19:25:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7713a3dsm2034781fa.42.2025.09.24.19.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:25:03 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:25:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] misc: fastrpc: Add support for new DSP IOVA
 formatting
Message-ID: <42ge3imptxp46pltqhktrptm6paivhmhooyehc7zigfdlk2qea@zi5ulbgtvy5h>
References: <20250924-knp-fastrpc-v1-0-4b40f8bfce1d@oss.qualcomm.com>
 <20250924-knp-fastrpc-v1-1-4b40f8bfce1d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-fastrpc-v1-1-4b40f8bfce1d@oss.qualcomm.com>
X-Proofpoint-GUID: VQnyeF2CpdK5mtEECYmXahRE3GzxoSyQ
X-Proofpoint-ORIG-GUID: VQnyeF2CpdK5mtEECYmXahRE3GzxoSyQ
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d4a803 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=RUSZMVMlDKJ86LYI_2cA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfXzDXjP4eexTVn
 KuLLGc55gWMUQ4xOmD6WcaJFE5dbyPPPbeHHKIGB7LOsDolM4q0tg7Ky3kTQXuSobVXzUFeQYiK
 VDFMkyDCVZ+1QXUvwgHK57wgUKFU/PLbiOM0zKEH7tqzVrxQXIhIpZd2hMh/9XYhvGObHc5dusr
 tfAmDrKIypCH1SmifI5Rm/IAnHXYb2VQY3tbd27EMKCzWcuMBpiluzgm69tS+FaMtBAGBzzjAaJ
 saAyuYrP+aJxvAYjfoqqxJOXsmw89KHJZx4YLGb/vxFXEuH1tVEV4cXKSwWNz5YgjxCgZCoIERW
 xAiis2g7Mcn3++Q2ok+CKT/D1iaTyrjfACfZu/i8iqMEVn4SigV4uOeB8CMa0+3nBqEo/WJvYrI
 RMyDnWKE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

On Wed, Sep 24, 2025 at 04:46:36PM -0700, Jingyi Wang wrote:
> From: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
> 
> Implement the new IOVA formatting required by the DSP architecture change
> on Kaanapali SoC. Place the SID for DSP DMA transactions at bit 56 in the
> physical address. This placement is necessary for the DSPs to correctly
> identify streams and operate as intended.
> To address this, add an iova-format flag which determines the SID position
> within the physical address. Set SID position to bit 56 when iova_format
> is enabled; otherwise, default to legacy 32-bit placement.
> Initialize the flag to 0 and update to 1 based on SoC-specific compatible
> string from the root node.
> This change ensures consistent SID placement across DSPs.
> 
> Signed-off-by: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 76 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 68 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 8e1d97873423..db396241b8ce 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -33,7 +33,6 @@
>  #define FASTRPC_ALIGN		128
>  #define FASTRPC_MAX_FDLIST	16
>  #define FASTRPC_MAX_CRCLIST	64
> -#define FASTRPC_PHYS(p)	((p) & 0xffffffff)
>  #define FASTRPC_CTX_MAX (256)
>  #define FASTRPC_INIT_HANDLE	1
>  #define FASTRPC_DSP_UTILITIES_HANDLE	2
> @@ -105,6 +104,26 @@
>  
>  #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
>  
> +/*
> + * By default, the sid will be prepended adjacent to smmu pa before sending
> + * to DSP. But if the compatible Soc found at root node specifies the new
> + * addressing format to handle pa's of longer widths, then the sid will be
> + * prepended at the position specified in this macro.
> + */
> +#define SID_POS_IN_IOVA 56
> +
> +/* Default width of pa bus from dsp */
> +#define DSP_DEFAULT_BUS_WIDTH 32
> +
> +/* Extract smmu pa from consolidated iova */
> +#define IOVA_TO_PHYS(iova, sid_pos) (iova & ((1ULL << sid_pos) - 1ULL))
> +
> +/*
> + * Prepare the consolidated iova to send to dsp by prepending the sid
> + * to smmu pa at the appropriate position
> + */
> +#define IOVA_FROM_SID_PA(sid, phys, sid_pos) (phys += sid << sid_pos)
> +
>  struct fastrpc_phy_page {
>  	u64 addr;		/* physical address */
>  	u64 size;		/* size of contiguous region */
> @@ -255,6 +274,7 @@ struct fastrpc_session_ctx {
>  	int sid;
>  	bool used;
>  	bool valid;
> +	u32 sid_pos;
>  };
>  
>  struct fastrpc_channel_ctx {
> @@ -278,6 +298,7 @@ struct fastrpc_channel_ctx {
>  	bool secure;
>  	bool unsigned_support;
>  	u64 dma_mask;
> +	u32 iova_format;
>  };
>  
>  struct fastrpc_device {
> @@ -391,8 +412,11 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
>  
>  static void fastrpc_buf_free(struct fastrpc_buf *buf)
>  {
> +	uint32_t sid_pos = (buf->fl->sctx ? buf->fl->sctx->sid_pos :
> +					    DSP_DEFAULT_BUS_WIDTH);
> +
>  	dma_free_coherent(buf->dev, buf->size, buf->virt,
> -			  FASTRPC_PHYS(buf->phys));
> +			  IOVA_TO_PHYS(buf->phys, sid_pos));
>  	kfree(buf);
>  }
>  
> @@ -442,7 +466,7 @@ static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
>  	buf = *obuf;
>  
>  	if (fl->sctx && fl->sctx->sid)
> -		buf->phys += ((u64)fl->sctx->sid << 32);
> +		IOVA_FROM_SID_PA((u64)fl->sctx->sid, buf->phys, fl->sctx->sid_pos);
>  
>  	return 0;
>  }
> @@ -687,7 +711,8 @@ static int fastrpc_dma_buf_attach(struct dma_buf *dmabuf,
>  		return -ENOMEM;
>  
>  	ret = dma_get_sgtable(buffer->dev, &a->sgt, buffer->virt,
> -			      FASTRPC_PHYS(buffer->phys), buffer->size);
> +			      IOVA_TO_PHYS(buffer->phys, buffer->fl->sctx->sid_pos),
> +			      buffer->size);
>  	if (ret < 0) {
>  		dev_err(buffer->dev, "failed to get scatterlist from DMA API\n");
>  		kfree(a);
> @@ -736,7 +761,7 @@ static int fastrpc_mmap(struct dma_buf *dmabuf,
>  	dma_resv_assert_held(dmabuf->resv);
>  
>  	return dma_mmap_coherent(buf->dev, vma, buf->virt,
> -				 FASTRPC_PHYS(buf->phys), size);
> +				 IOVA_TO_PHYS(buf->phys, buf->fl->sctx->sid_pos), size);
>  }
>  
>  static const struct dma_buf_ops fastrpc_dma_buf_ops = {
> @@ -793,7 +818,8 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
>  		map->phys = sg_phys(map->table->sgl);
>  	} else {
>  		map->phys = sg_dma_address(map->table->sgl);
> -		map->phys += ((u64)fl->sctx->sid << 32);
> +		IOVA_FROM_SID_PA((u64)fl->sctx->sid, map->phys,
> +				 fl->sctx->sid_pos);
>  	}
>  	map->size = len;
>  	map->va = sg_virt(map->table->sgl);
> @@ -2153,11 +2179,14 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	sess->used = false;
>  	sess->valid = true;
>  	sess->dev = dev;
> -	dev_set_drvdata(dev, sess);
> +	/* Configure where sid will be prepended to pa */
> +	sess->sid_pos =
> +		(cctx->iova_format ? SID_POS_IN_IOVA : DSP_DEFAULT_BUS_WIDTH);

You are using iova_format as a flag. Rename it to something more
sensible and turn it into a boolean flag.

>  
>  	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
>  		dev_info(dev, "FastRPC Session ID not specified in DT\n");
>  
> +	dev_set_drvdata(dev, sess);
>  	if (sessions > 0) {
>  		struct fastrpc_session_ctx *dup_sess;
>  
> @@ -2256,6 +2285,19 @@ static int fastrpc_get_domain_id(const char *domain)
>  	return -EINVAL;
>  }
>  
> +struct fastrpc_soc_data {
> +	u32 dsp_iova_format;
> +};
> +
> +static const struct fastrpc_soc_data kaanapali_soc_data = {
> +	.dsp_iova_format = 1,
> +};
> +
> +static const struct of_device_id qcom_soc_match_table[] = {
> +	{ .compatible = "qcom,kaanapali", .data = &kaanapali_soc_data },
> +	{},
> +};
> +
>  static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  {
>  	struct device *rdev = &rpdev->dev;
> @@ -2264,6 +2306,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	const char *domain;
>  	bool secure_dsp;
>  	unsigned int vmids[FASTRPC_MAX_VMIDS];
> +	struct device_node *root;
> +	const struct of_device_id *match;
> +	const struct fastrpc_soc_data *soc_data = NULL;
> +	u32 iova_format = 0;
> +
> +	root = of_find_node_by_path("/");
> +	if (!root)
> +		return -ENODEV;
> +
> +	match = of_match_node(qcom_soc_match_table, root);
> +	of_node_put(root);
> +	if (!match || !match->data) {
> +		dev_dbg(rdev, "no compatible SoC found at root node\n");
> +	} else {
> +		soc_data = match->data;
> +		iova_format = soc_data->dsp_iova_format;
> +	}
>  
>  	err = of_property_read_string(rdev->of_node, "label", &domain);
>  	if (err) {
> @@ -2343,7 +2402,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		err = -EINVAL;
>  		goto err_free_data;
>  	}
> -
> +	/* determine where sid needs to be prepended to pa based on iova_format */
> +	data->iova_format = iova_format;
>  	kref_init(&data->refcount);
>  
>  	dev_set_drvdata(&rpdev->dev, data);
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

