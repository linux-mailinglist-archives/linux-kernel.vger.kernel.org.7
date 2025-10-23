Return-Path: <linux-kernel+bounces-866923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B1FC01131
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B17550842E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB6C30FC3A;
	Thu, 23 Oct 2025 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CWyxHwSj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8ED30E0C6
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221781; cv=none; b=Yycxaf6d1UyMq9TtODPhnghH/G8un9yu66v2MG0UAfzhIXMzDY5VcER1EkJ6rkYFEmS1ZzBM2dFf1mhdPj1YmnHVazGA+bl3c+0Jc+LMaKqvke3wZ11MFkCKilKBxY3gIwppOCmp8bjbF4KQOPXoyj5OANCayru3YTEkB1tSv38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221781; c=relaxed/simple;
	bh=0E7U9bIPhzHcbtwkKPPc0NskDg+3yPSeeGrKpQZ6wxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W62pmjSso5ra7QppqvGnRFYk7H0wP6qHJYY8P9kteI37PWsDZ+vft3Nn3jnEgHVTl5wHSGGhLUYU3ccshrMIkK/bBNPPTdZKzQTUmHs5dJUKbsRQk5NxNtqGxdCqNKCLW7/eVoyzlvb0bPZG4ztB+9EGQ9ihgxi6wIkS/3WuR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CWyxHwSj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N84w8U021340
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9bI46L/4oozpzEJG7ZAsQNzK
	TAJeVoM2mUGb1Do1MpM=; b=CWyxHwSj6udPgRngKWzY6aHNz7/y1XRW7WFZ6w9l
	RlmrmFeJXWPk9aG/2XNfqZM8YBfzklf+n9SJr7RRkaSsv12WCDpt1572JVHPyPNA
	IOK0kiy5iDQPG8RZiKZ2+FsXVkhoeZsj+BXvjQrb6npJj4YU7hfn4W8zMbzmkQzN
	DE9M6ZeGxXhBcKy3MXnVFUQNHTae5VtByMP+JZZU2mIjxT8m+BEO25FlSMkwprtL
	CIzHBGnsmD0tzL6tXq8EIMgFxg+5+Mr+sfOgE1JsafAAXEMRkEL8AzJeY2gw4wI0
	xJRtB8R0PEmJNV+CF6mtBm4wdldEVpLfBdjyBg1LMqMGKQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y67qja64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:16:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8a3d0fb09so10303601cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221775; x=1761826575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bI46L/4oozpzEJG7ZAsQNzKTAJeVoM2mUGb1Do1MpM=;
        b=SNKxDalEDPyDheOFKEZkxFo86DSFuFn7D33WLSvxJXj4HZU3fNWqGQyJgato5XzqAw
         iUs5+qf3E/1pD/evZOfB6eo1P/kIti85ZNUYwz+kSN108YEpDesszCInRMMzSHYYQoIx
         Mbn8EtUNozKLc+1dhZp51d6gXl1EjScuy1szwuJ4+LU0k1GXeM/KN6rcx2HLXKgNKDVI
         EC8IbKIX2uSYdWpN0VzbiqqNL7dj5jUYvlb4PUx5WBNI1rynXQN7yjXz1p7ElqpBLT7u
         kl5KEem25X2pttZpTS4Ed4nLWxcDIKIYtl6JsIqtn2XboSLKP5WccA2bFOqa4e/TmwI5
         3wAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2OfNVD8MYWSwG6RWntRjRtg9rpSSV71eOuolXWQnwk4dEsTns5xkZEMYlUZbiCIrxZeByqz8UCzygAnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn3UFeet3VlwEdgZp7R/3FUa4Q2M3AVL+bXzWvCfZC249cPj8n
	pV4b7y271kqRa76rtBUxtx8HztLzb64vjUdO4HDojTDQkTH8081iE9SqXwShiUNFMVDruBF6SVY
	Msl8TIcemdNs1aKyUxendoTCrZsSQ6VfrkiioO01kau93HzsMIew1sc+YtA7nqpQAWbA=
X-Gm-Gg: ASbGnctfLMVNnN0gEOX7N7F8rJT32XHIOq9YdkRhPTZy5wIXqLFnxe7ejN5o+fU/ReT
	vkenDFyrnMPxLTZYAL6DuFGT4T0Q78/ES/APvmFhaDTwmDq4KfotcMYs3lnalE0YBvm3GOq1Bae
	a3NioHUSi/mlgHdPoPnJJ346mCGMhNI4drACILY27KINLM7iUizSXqpSiWpyXBeTz/oXANWSZAL
	3bunUDif1iOfvxwVaCsfV3SFFrCq90c+MquFpNMKsR+N9UO6JqKJvKp0E9Q+FRat3vVSCJCpH83
	dgpb31oHn9dMtFSlUGcD/Dsy+zU7hUyc0LrDcn9CLXBxRN/wadWTdxat2oU4WHyelfPRcC+QnI6
	uqsL0XNtP6+J63yAdTvuuEXMdAWrI6Jja46MD7gqTpC7QQw428L6qXsc1pTiEuSVngCDRKJIuAp
	JyYWCXL3l6R4i/
X-Received: by 2002:a05:622a:4c8:b0:4e8:ada0:450a with SMTP id d75a77b69052e-4e8ada0a00cmr197923981cf.45.1761221775013;
        Thu, 23 Oct 2025 05:16:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeUhuoseObWTvRgOs3Xxp4Tq849T+csVGpql5BFGo9n/VmAM+rZHain9nu6/6zo++Onjyw+A==
X-Received: by 2002:a05:622a:4c8:b0:4e8:ada0:450a with SMTP id d75a77b69052e-4e8ada0a00cmr197923451cf.45.1761221774525;
        Thu, 23 Oct 2025 05:16:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378d67db627sm4204351fa.39.2025.10.23.05.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:16:13 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:16:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 11/12] dt-bindings: display/msm: dsi-controller-main: Add
 Kaanapali
Message-ID: <binhwh2sb72ipt2qhqdmnid2hygdnjx62mhzn2cl4v2do467gz@wkmsvroshkcu>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-6-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023080609.1212-6-yuanjie.yang@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2OCBTYWx0ZWRfX296tLrUzs+XY
 ehDU5REKOum0PSbI7uyNnlxLE/T4PzcvsSlFEbCuCIpiwAoYi125i/f7eHq1EJNIcxQ47UI1ZTm
 MQ4ejdvazZdTteekH8hXe9m6SZLNwmMwQOApG0QZ+NpypkiVz1OfuRHB6dAu9PMG6CU0m/R/BV4
 IHcifEwJ+qBqc5tBNlij7A36Wh5JKnkAzVFwsbWCXZNcSZcXuH9FMVzJSUTwNIIVVz6ypXqGr7W
 bN3Uf3TGgzP3wh5T6vLCvI97fJzBzHFsWlv+S6Dj4Ef4PEiX2+5e1BgU6oP0DRlhNWZPLSD6aah
 JJU7WMOmJhMepYZ3s8kqpY+di1fZKP2m8xBe4f7TKxpqCaaRjV0ufBIWso8Wdx1Tp3gTxnruhHg
 BajVQjBFKJcSelSL2Rd0gkXBMrD9yg==
X-Authority-Analysis: v=2.4 cv=LMRrgZW9 c=1 sm=1 tr=0 ts=68fa1c90 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=yQNLmfnzQBnRYO31l0cA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 2Zcd-iyr2g1mYhFrSKQc9CKi9-0I1uu2
X-Proofpoint-ORIG-GUID: 2Zcd-iyr2g1mYhFrSKQc9CKi9-0I1uu2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220168

On Thu, Oct 23, 2025 at 04:06:08PM +0800, yuanjie yang wrote:
> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> 
> Add DSI Controller for Kaanapali.

Please say something more important here. Why do we need new compatible
for this platform, etc.

> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index 4400d4cce072..536ebf331828 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -15,6 +15,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,apq8064-dsi-ctrl
> +              - qcom,kaanapali-dsi-ctrl
>                - qcom,msm8226-dsi-ctrl
>                - qcom,msm8916-dsi-ctrl
>                - qcom,msm8953-dsi-ctrl
> @@ -369,6 +370,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,kaanapali-dsi-ctrl
>                - qcom,sm8750-dsi-ctrl
>      then:
>        properties:
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

