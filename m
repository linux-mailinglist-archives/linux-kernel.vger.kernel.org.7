Return-Path: <linux-kernel+bounces-787391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C74B375A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E4E3B7CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101CC3093A7;
	Tue, 26 Aug 2025 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mZsNZHH2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0563307488
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756251761; cv=none; b=gLt6Ob6lS0+92723oHDQqhzr9U021LJbyTHcvRq2TSwmFCNluPeubSMDHldzwLnW0nVXlCdZDB1lo++DsUqf9B4G5bZjtkDL5lHnMGm4HuNqK2uBQPg6FIJaRe6hwUO2hw7F1XPzNHD8UM+fq407OdJVPAxduV0idjbV73h/ajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756251761; c=relaxed/simple;
	bh=yXMFyjfeKUih8geJMgMMetn9P8ay1yDAAM7I8cReToI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/3MgnHk7LJjE+STCfb25Ax4i7dXGH20atQgzf3mhBFsdYjWVWnNWkJbDCC/WZbFGW8NKK8Jh+uL6nDhnXjzUom9q/pmSCteJ72TtGm09HYVavz9qkdgw6LiQ/tfGVCP6Qvz1/R6gINjAIExlJFlj2d8k/Gu+wB8DRW5k3ygqjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mZsNZHH2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QHLV29028938
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zu9C8ffYP2zbDrnUd2W1zM9YKo6YTVhAJreh0ub4tB4=; b=mZsNZHH2vrpoWbMB
	1dNmWkE7asnW6C8+z6PLbatFsJacAMKuO6/mbA6lSVJeDWLqXaI/MvJgRirXSk3X
	tbtKEEbEm3NKx6izBpLfJ00D+IGWGOOS59vVO36vBZd03P50O7SXq0hbb4yG6v37
	Mm+KTpTWDN3CglA3JLoQZqnK6JEui39E7bWxLEGpdGwAV3M7rbATg6w52GAI3bFL
	DAciHcH+izqmlrhP4ccllgnmaUjS4k5kxSik/Zs/3M3IuG4p5V4qTebZg7kOSgTJ
	AKsv9IQvcAuHrPR/CGHwQJCqq3vaMT53VfYVFGZr+k80BFN0NBmFGLyac7zvjE+G
	7XU0Hg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48sh8agx7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:42:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b1292b00cfso59312681cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756251757; x=1756856557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zu9C8ffYP2zbDrnUd2W1zM9YKo6YTVhAJreh0ub4tB4=;
        b=CClWz6GhBFUaeY4lHMBkneUtI74f/cT92th+cDBfs5MF/IpShueoJhpoP6BF7N9gUS
         n09jRCQpvisUgBuIgI0Sqln+2ZDY8XbGogwiirBxSEMNWwT4UGp6v3V76Yf8sT1be8qc
         v+JGCci1BEmNQFHuPbp0JD5rUGGaA0PJ+ZXTnnCuYQ40BlOMxz2J9aPIFBkDwLDm/m5N
         pkA1u7KPGulg0cXvu752I6zsFIt4p3t1ofeb0dFoFEN4a+aMW4Z8ZsbgkbNEABi59LSY
         HRsfGpwd0V8VlR9xBMpSYajadRvcZaN+bJ0yWoWF4vnj5/2nYdJ4INnRaNy2cIDjnVv6
         eNkw==
X-Forwarded-Encrypted: i=1; AJvYcCVeUMYxi7Fmn6HdFe1w7pgeeD5k2ubkQRQ8DdjTg82UP38kjnqWzY7VBswLQifVW1AR6RTr4wstSuNVPQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbYRunKEYdqIO6mKAtsNUT/aZl0Ujm7M9pYkQOoLR82WaeqWy6
	OSG9jzwqcXggF+zohTVynBB3aTfhsY6rEr+1RVortCFQGh5wmwE4wRXEzv5Vr9UxhPVJ3VSx8nI
	1GfxAPzQKftOdTQEWdmvBUT6qXey+eFb3bwpupJqsphOizjrtSgdgwKTrUxgs12bSySn/hLVXnG
	Q=
X-Gm-Gg: ASbGncvy3vYuJ8oH3+PhO6x4X6VuGg6OVcTTLKmXktLhid5SY8ONPKodFHiPSPDEPOo
	305QybOa5m11rxnLm1alIKafcxVqT+DUiEkB7GHtgi8LxUoh0c7Q2UV7go/dOjCYk4EGvTYYxdo
	e8XHVs7nC8QM6g97wu97SGx2FGm1F6WZGbyMrQ7lm2EzOfO0f2edWdD8ZTZvDVrwq0/sOzlVT8V
	fzcWxAaaReObs1/m7dgOmJYoDGgbUly31NzSCBO/ZjH3g5OJG+NpB3BBUN+/XKZfRN0sxmNA7DW
	hO2xLj4idaxt0SO/J5BiMQkBqw6UdHxspJhb6nw3BfKRDmKZsl+CAkWkZJY5yUc5zG2GPiXaqqh
	H5wJWFUNxNrdZYQ6DCsbRdDNO6rMKmOmfWXpb9UPYocSRmXAdkTRg
X-Received: by 2002:a05:622a:1898:b0:4b2:f2b0:32fb with SMTP id d75a77b69052e-4b2f2b038cfmr1568031cf.1.1756251757074;
        Tue, 26 Aug 2025 16:42:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjGIIylAidnuipVcsn/Q+ugXwaDOHP5jB2aqY956weD36FeNFEDeYWh8wFDm8rzuQrzEue6w==
X-Received: by 2002:a05:622a:1898:b0:4b2:f2b0:32fb with SMTP id d75a77b69052e-4b2f2b038cfmr1567761cf.1.1756251756549;
        Tue, 26 Aug 2025 16:42:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3366de0ec70sm18587661fa.66.2025.08.26.16.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 16:42:34 -0700 (PDT)
Date: Wed, 27 Aug 2025 02:42:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 36/38] drm/msm/dpu: use msm_dp_get_mst_intf_id() to
 get the intf id
Message-ID: <exfflgjky4zgqa7tnudfteeosncr6nsuwqadxnfftxtjay6hke@fxru2weupuwt>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-36-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250825-msm-dp-mst-v3-36-01faacfcdedd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=cLDgskeN c=1 sm=1 tr=0 ts=68ae466f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=FCQRL5G5Yy2VVt0fnmAA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE1MyBTYWx0ZWRfX1g4bLYG8YYTV
 eulptVZQgzF7oo7ZeNAb16DQotMsc7yu6yUV1OLiWJsT1SK+ZShNxDwisttUDnxinNVgnko+/su
 epos+WpB6tEpEO5FwawAlRHfht7BfBwdqdreR3JZgWG2O4MVMS1torFB+pCheTVk7x3OrWtglaL
 HQLHRITxSPh6j5u/y2Hq5oodgPavLZoOE8BGw6pGGBiaaViv+mfR/0qNlqUL9L8rCvkYy6r328Q
 cih1fGJzB0Ag+uf2zfIT83TO45At7GS4/Kk900NPAMYmQVvAvzo4Sa49LnUDO6zYkHLhMQdacNz
 INOLcytFa4QZIu/35IJYK2nJqi2iLbH1OtLjz/tev7akuKwQflXOQQnUuAXBTx2+Jksd6EeUXxh
 drjKuusq
X-Proofpoint-GUID: Gr4FJWCAJqPzg1cq5L4UEXPs6DKs5tfH
X-Proofpoint-ORIG-GUID: Gr4FJWCAJqPzg1cq5L4UEXPs6DKs5tfH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260153

On Mon, Aug 25, 2025 at 10:16:22PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Use msm_dp_get_mst_intf_id() to get the interface ID for the DP MST
> controller as the intf_id is unique for each MST stream of each
> DP controller.

I think we have one sensible exception: SC8180X, where we have several
DP controllers and one shared DP interface, but let's forget about it
for now...

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 51 +++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 05e5f3463e30c9a6bd5b740580720ae2bf6b3246..2eb5397d15732b224372c68d0b2b7167da9f2896 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1429,17 +1429,52 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
>  
>  static struct dpu_hw_intf *dpu_encoder_get_intf(const struct dpu_mdss_cfg *catalog,
>  		struct dpu_rm *dpu_rm,
> -		enum dpu_intf_type type, u32 controller_id)
> +		enum dpu_intf_type type, int enc_type, u32 id)
>  {
> -	int i = 0;
> +	int i = 0, cnt = 0;
> +	int controller_id = id >> 16;
> +	int stream_id = id & 0x0F;
>  
>  	if (type == INTF_WB)
>  		return NULL;
>  
> -	for (i = 0; i < catalog->intf_count; i++) {
> -		if (catalog->intf[i].type == type
> -		    && catalog->intf[i].controller_id == controller_id) {
> -			return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
> +	if (enc_type == DRM_MODE_ENCODER_DPMST) {
> +		/* The intf order in dpu_intf_cfg matches the mapping in the DP HPG.
> +		 * example:
> +		 * DPU_8_4_0 - DP Controller intf to stream Mapping
> +		 *
> +		 * +-------------+----------+----------+----------+----------+
> +		 * | stream_id   |��� 0���� |��� 1���� |��� 2���� |��� 3���� |
> +		 * +-------------+----------+----------+----------+----------+
> +		 * | DP0�������� | INTF_0�� | INTF_3�� | INTF_6�� | INTF_7�� |
> +		 * | DP1�������� | INTF_4�� | INTF_8�� |��������� |��������� |
> +		 * +-------------+----------+----------+----------+----------+
> +		 *
> +		 * DPU_9_2_0 - DP Controller intf to stream Mapping
> +		 *
> +		 * +-------------+----------+----------+
> +		 * | Controller� |��� 0���� |��� 1���� |
> +		 * +-------------+----------+----------+
> +		 * | DP0�������� | INTF_0�� | INTF_3�� |
> +		 * | DP1�������� | INTF_4�� | INTF_8�� |
> +		 * | DP2�������� | INTF_6�� | INTF_7�� |
> +		 * +-------------+----------+----------+
> +		 */
> +		DPU_DEBUG("controller_id %d for stream_id = %d\n", controller_id, stream_id);
> +		for (i = 0; i < catalog->intf_count; i++) {
> +			if (catalog->intf[i].type == INTF_DP
> +			&& controller_id == catalog->intf[i].controller_id) {

&& should be on the previous line

> +				if (cnt == stream_id)

if (cnt++ == stream_id) return;

> +					return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
> +				cnt++;
> +			}
> +		}

return NULL, drop else{}

> +	} else {
> +		for (i = 0; i < catalog->intf_count; i++) {
> +			if (catalog->intf[i].type == type
> +			&& catalog->intf[i].controller_id == controller_id) {
> +				return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
> +			}
>  		}
>  	}
>  
> @@ -2670,7 +2705,9 @@ static int dpu_encoder_setup_display(struct dpu_encoder_virt *dpu_enc,
>  
>  		phys_params.hw_intf = dpu_encoder_get_intf(dpu_kms->catalog, &dpu_kms->rm,
>  							   disp_info->intf_type,
> -							   controller_id);
> +							   dpu_enc->base.encoder_type,
> +							   controller_id << 16
> +							   | disp_info->stream_id);

No need to, just pass whole disp_info pointer.

>  
>  		if (disp_info->intf_type == INTF_WB && controller_id < WB_MAX)
>  			phys_params.hw_wb = dpu_rm_get_wb(&dpu_kms->rm, controller_id);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

