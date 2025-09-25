Return-Path: <linux-kernel+bounces-831659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8A7B9D429
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C6D326F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16A92E6CA6;
	Thu, 25 Sep 2025 02:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jaHThDmz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE8F2E6112
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758769088; cv=none; b=b+BtwGQLWoPElKenkx0Q35OWTw7ZEy5k2CaWRA4wdRqxjAQGDj6iPp7WRnN2G/zRVxdhGnXk2bDl3vcLy1V0qJW2DEzKB+XiJyq5yTBr1x70UsMMUnrUOFLQEORnwMQE7zymOEZwvcfZ5QxM05KTHt27caABsYrUs4zkerhSxtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758769088; c=relaxed/simple;
	bh=8ysZNA/Uz6PY3mVZ0DZWwPSIKRaTzuIq8vyE38GZH6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dq9pN5p+IoKXLPeayImnbR+KYIKiLLLE+eGxM6XU7FV9FWvkoGEWPbSQJLfi8cE+spGvWe3zJaQGRD7hOX5Ki1QEBcqLG+GXBzHjg6rIWURSqFmJcMljSYfxqCoJ+IrwbnTcyw3YubTFMK9QWlmnX8FGa7Nj2wLDpgUtvex0hy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jaHThDmz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1kNGc017437
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qjAC9HnS7arrvmYIoGMsNtnA
	EZsulCcHq35dMFpOR3Q=; b=jaHThDmzhZalaOm2waZn8XQ6kqYA2/a4wonJSNCz
	lQAaMQKEFEjEbtM84KfR6TMNFfQe7mvnql2WmhXXaCsU7cEsUX5zno6PGIDCHTR3
	6xHDedvVV6u6go6fc7HcWACRs8p64j1u1C3qddYPsDaXisPWdhbnXAymSR+xstLb
	ot+Z7FMi/o1MFUHoB6N7pRLVHR+2YtgWLy6VQCdzI5eZDC6NkU0pfY4tHyX/RDHb
	2+z0hOe9QUE54nDqhdITnZW0KcaDYu6qHUKl7612hNUeI5/0/Zlb/mOzt9p75802
	+jS5lcCNAuim/AxNZ3EfBQQ2BZer3TLXTYJWTKNa30KDKg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjyuf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:58:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-856c1aa079bso120786585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758769085; x=1759373885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjAC9HnS7arrvmYIoGMsNtnAEZsulCcHq35dMFpOR3Q=;
        b=QP7e7tC3LAgsOmgiwGLGM8GxXdKxK5GjCduEKV2wQCe9K7jQlp642DWccquOoVilA6
         8LH7pOn3Mth9gcSwbyfrdGZ3DVmqjLd98Iy/YJtzd267xEGjRAOBs+irEg4Rec3MeHyt
         sD8wJmm+UVk7tvJbepqXsWPCDll6Fo4ooRwMzYUyGzEOr0VyCTSaXgrH4ZmZDH5htG+x
         PPrDYbxzDXMlwN4J0MwI6hqMbnsaMTUMiyierlcOhMBSoUiu8CjuoR2AHdq7i6u1slOf
         +42KXDDgqESujeJtEXlGppLWuLG1RM5ngR0XtCySIMkiMmbKfMRnCR15xEheNbQKCowj
         xJiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1aphWI1M5gDt38c4ZchQy23ybAxj7HC9qONNAxrTxfSDSbiG4FL36tIw6/BX1BaVYRx+BpPSycnaIYW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWeS2Ex8KiZtuL694Oc+CMAcgyvpSmk1jhaQIeQV3ME8NeCQrI
	DB9UlFM9/ace4s/wHjbL5usoiJwXGZw0HhDCuDHkx72O7WUsRJbhfnMweWwvDCsf63FtWzTmAW8
	2fovoqUEYN5ZwOFR6ON6UhKzdml4+Ng3lnSUiaMYpCn3OwfFtMubPXwXYDzYSLfleTOA=
X-Gm-Gg: ASbGncsVaayXMf6d46MiIhYU0sUBNksVkqw04o534JAqbxIpChhZo+Zq1imOj/LBzaI
	XqUGXmzfyZqM+3GRQMcDcISj0J7YEX5eP8zEegyrPSQrlX5LGqou/0QK10XZ6tIL+/WmT3x6cIQ
	ieqc5VnjSahJ4H3bSZlvGSp6KY01zBI4sUax9Yimmmn8fnZpq7cH8eRkjDAS20Ipx/NfRjYEzP4
	bUK+fcH/mz8DC+qzj6TjwsNSPHExkh7AVmYsAHN1N+L1MpjnJ5fq5tn4R+fPymfOquUyXUcSFX7
	cbzoLsQt11/OTQvSm5GKNyypjWESVBcQvcr6KSPmXTy3R5v2fx2yiwxHqr4o0+3DSABBRwihEsc
	+I4oanO1wLexkyWowZvoqJuPqBEoyN0/UblfwF5dnsx2k/NJ6qQD5
X-Received: by 2002:a05:620a:4416:b0:829:d0e9:bc1b with SMTP id af79cd13be357-85bc193e697mr124454485a.7.1758769085010;
        Wed, 24 Sep 2025 19:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8/kIGrxuGE1UAhcbH+YWeTWUxLahQYTfRVIJoMIFeM/Sl3/4X1nwoIEfPlHoZiFC4e311CA==
X-Received: by 2002:a05:620a:4416:b0:829:d0e9:bc1b with SMTP id af79cd13be357-85bc193e697mr124452385a.7.1758769084385;
        Wed, 24 Sep 2025 19:58:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb770fdb2sm2174221fa.43.2025.09.24.19.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:58:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:57:59 +0300
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
Subject: Re: [PATCH 2/2] misc: fastrpc: Update dma_mask for CDSP support on
 Kaanapali SoC
Message-ID: <pxffubrq3362deajql2ajheoq53wvgrlx7ttxqlwg5n6zsxzib@zk3lwqwiq5zb>
References: <20250924-knp-fastrpc-v1-0-4b40f8bfce1d@oss.qualcomm.com>
 <20250924-knp-fastrpc-v1-2-4b40f8bfce1d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-fastrpc-v1-2-4b40f8bfce1d@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: aqAg0hvo_gYw88mN1MKt__ishw5FPiE_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX7PCy0kNZowry
 +ZIi7PdG5OT1VNlwORT+nuxtPVdukpLJmSuTa/bxUJcFUAxXksVDSJ+TGhySy27ziQmThXWP2AY
 VwzSncnt7OmS84zMdLmc5OHkTzIVQngaC27uG95WgeghO0g+7ZAgPws5WP9BoXz0nutv3g6jkqA
 PuNTN2etlBCQ07BbZh9Isaqk57COAYx9TbKpgM+g8jG8DBRbJVebYrhCUPQ7qHYNfg1qDn+TuNY
 T0qRtgU/2V2Q7M8ItYPTi7ON49uN8xildTnJh6PkG0LBFIZLlXZK51tPOow2I/8+ZyBO1D9ofkt
 bU8jdtJ0Vyd2McepxhM8e/HFuTY2vX09UKnweliBZbKBDNOMQTaKi4mpTT1jS0GymD2oye4cE05
 aDpCapJd
X-Proofpoint-GUID: aqAg0hvo_gYw88mN1MKt__ishw5FPiE_
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d4afbe cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=3nRJTgfC3zKTbEAQhnsA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

On Wed, Sep 24, 2025 at 04:46:37PM -0700, Jingyi Wang wrote:
> From: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
> 
> DSP currently supports 32-bit IOVA (32-bit PA + 4-bit SID) for
> both Q6 and user DMA (uDMA) access. This is being upgraded to
> 34-bit PA + 4-bit SID due to a hardware revision in CDSP for
> Kaanapali SoC, which expands the DMA addressable range.
> Update DMA mask configuration in the driver to support CDSP on
> Kaanapali SoC. Set the default `dma_mask` to 32-bit and update
> it to 34-bit based on CDSP and SoC-specific compatible string.
> 
> Signed-off-by: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

