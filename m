Return-Path: <linux-kernel+bounces-741417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EE3B0E3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B060E1C84507
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEB02836BE;
	Tue, 22 Jul 2025 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gyhtp8el"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EBD17E4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210966; cv=none; b=Y/K587uBO84KfUVp7jLjD9elXXrtPk11AjKcak3DpSdWYDAQUQesaehEe8zBfIRB6kavTZWgtLaPkkhAsndj8UHjkag/9B0YlySvaUMyVRKA6c/pStK2+XKqNntN8tf0WcyzcuLL0FDl/WGOSmZ5XEabxDq2CfPugeEs0mbYfLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210966; c=relaxed/simple;
	bh=1jW+AQBLmrBwT5OqSJctwQ/2tI0p4B8L4gpSCTjZz20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp0IFbxRiIwhPG3iEPLDl/Nk7xrc1xSvcmlrnjShOORcEmE0Oc94n8uqnZO6u8Kf5G4yqNpol4IRoY23ZVR8kqOC0cAlSDR/+Xp7+3L5R0VyGlNOxkN1cZs1jlDDcosohYM2UzqiK8qvBLUeyU/THBofzZbEc+2R9NkYhiYOaYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gyhtp8el; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MFoWh2005066
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eeNJd288lALWCAPcNkFrKeWB
	uzWCZ8l6rZ+MwXhFjY8=; b=gyhtp8elLmKM4dYCBMpPzjGY63U1H7BqaIPm3d/V
	iuhp8iqecnu34Ssg+Ellxxf4780WhBLpFkf0vGOi+IrmadgAMyyR5N0NO8O2Xq/H
	YOcsSfOgJg3dUuyS6FUsPrO6MBFYV+A7UCBTUpKGbz3CjI2GFSg3omVv1tZ/6Fm1
	aHXhIhM3Ls5o+d8EFry9Bo8vN1HOuEwJRGYVRgMS2KPRlilyXuitfggnQk2txLOY
	YnIXvrJ+KD0rShyIWHR1XAl/yglCuuHj79XtqxdIcR4UCsoAT+7ANPS6FF68Kv8g
	Ucql98aRd1srlKnGkvac1UCcQgj4znjRLvHQjjnFnc0/wQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048v8waa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:02:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235089528a0so1253705ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753210948; x=1753815748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeNJd288lALWCAPcNkFrKeWBuzWCZ8l6rZ+MwXhFjY8=;
        b=JHVKw6aFEL19JeuQCAlVsdT2B9nE6woF4uZYoan/pFwG2LAZvCg+1L4EihB+cp1QNa
         dGBtTBrDngXqoLiDm6GHpjOWKv/puqxI+velVe6FU6ktwIpg2uQkJR3CS+ypQwtmZhe1
         ogzB8W2ElmGb3vRCv2AdRJikL17G2NQB5a9lxKAOz8D2xGr1LGIf8y8OgGRURxYh8FVS
         Msjju6VqlzVnicnMUMFAoTT8reqTZBV8d15n6fj2zrf516uqVU8b6O3aa88x9JtPtKQf
         u9mCPXQmTbiqlZlRK6w1Mdr4Qn3gEbWR/zG/dGp+pCjjQB78qYqmvyBRyuZnax77Hu4H
         N4bg==
X-Forwarded-Encrypted: i=1; AJvYcCW31sKlWsUEtJQPB6Oko+iODviaOnkbgS/nYEaMO2cefmXpG19M3pMsZW76BMO9I1gBxDP5v00OQCDY3fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZdgrTX5yZJDssmalY0JyJd+OabaFs8NxlacGJN+Rw+aWZEdIA
	FmabFmETqLeJK8fEx3i2jNlVBER+jrySs1yVr20joFz+0F73sWDJ0kkVUv2+CAHPXIssAPXuytg
	ri0Hqu0OS8y774ZoctXbJmLfKN00BOCLlcfRwgDQ2FDcaFXAfYOK/YELNlF1Mu5bUE5c=
X-Gm-Gg: ASbGnctOFJyz57Yf7bQ1ZsekoHt8IikOSy53wvbqPxGcLl06QxoKjTYQAD418WlJ/eF
	gAKlT+PAwp8IcXwvnvNIYPdzH1Gi+PJ00CM/DJC/7AGvW1maA+v7JttFbE8SI3TaWuXeW7Rbzt0
	LD1Dzj77O16BAVf5eS/xDHSclXUrUa4mJEDpoH0Z3MMubxKQz6wqyX1hSyHPV8x+qBnOtJU5R8g
	xQlyRkKrv/f0p0G7XuXI/CMO6NcbjuL+itcSC0CJkd7htcOU9BkO1FBsIAAAS+pYxI5TqtLov0U
	jNIW6Yr1H16fgxXeo9kK1nlewNJ6Dq/bPKxu6NlCC3dwnCkTkQ9Q3qmgHD4wNfj3eNDqc1ms7fS
	UTx2OICyPKjIflFundB4F6eqFxDUYR860OzvX+GN6xTieOsnrDAOl
X-Received: by 2002:a17:902:ce8f:b0:21f:5063:d3ca with SMTP id d9443c01a7336-23f8acb16f9mr66352845ad.16.1753210947572;
        Tue, 22 Jul 2025 12:02:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTaRg7+RT9XmmVIQa9Z5l3X/9yEYapn9SUbtScQ0vSYOHwQTYMt6q/ro/+Isxq9+wASsihpg==
X-Received: by 2002:a17:902:ce8f:b0:21f:5063:d3ca with SMTP id d9443c01a7336-23f8acb16f9mr66352225ad.16.1753210947052;
        Tue, 22 Jul 2025 12:02:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d7c7a4sm2038313e87.130.2025.07.22.12.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 12:02:25 -0700 (PDT)
Date: Tue, 22 Jul 2025 22:02:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
Cc: mani@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: ufs: qcom: Document HS gear and rate
 limit properties
Message-ID: <6yhnlwyuimkrlifmmdihcsuhws6qkdjzmjxdupu6cevu24nmi6@f4vk5dffjie2>
References: <20250722161103.3938-1-quic_rdwivedi@quicinc.com>
 <20250722161103.3938-4-quic_rdwivedi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722161103.3938-4-quic_rdwivedi@quicinc.com>
X-Proofpoint-GUID: iDJ6eg3x17U4kpZFlZarXo3xqavUQjvj
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=687fe053 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=rRQ5tug-ufnQS7fofaEA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE2MyBTYWx0ZWRfX9gbldjZZQooP
 rcLS+2mOILlYP/2RuHQ0/IsvjE34ZQQlYRBaYWaHBQZP7v1LFjSyPlrG6fHLnTDK4OVp6SULf73
 SK9Hm9kN9vEq+WTSBaQ5hlDvMhgpJyRcBB1eJXDko/0epNIDwkW4FDvFappPWYE+n5WNO0iOBCL
 6y+H1pBr1Y+xU820T+q5MwOtEb8FTxQBZr2DZR081NmXbvvJR724RhtCCw/wnRBU0dzo9jIxi2/
 KrRJDq9CcU3NbUk37wbgoo8RGmvwohSIN3AfP19LkMQ6G0ArerqTzFAYv9IdYjiljykSSB8IuFZ
 r2Kw58u3i9GwxEK/znqXMCp0yoY+gQG5oJFkMYrQoGSpLUYug4DL2TH+iwQrzo7Dd0VpXh5dLIg
 R9m89ypZx/YNLarkgzkxMB7IITt19bb83ZNNlvAH779KdWxrQcrqrmNLUbyVaW7q6LxnGA3Y
X-Proofpoint-ORIG-GUID: iDJ6eg3x17U4kpZFlZarXo3xqavUQjvj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220163

On Tue, Jul 22, 2025 at 09:41:03PM +0530, Ram Kumar Dwivedi wrote:
> Add documentation for two new optional properties:
>   - limit-hs-gear
>   - limit-rate
> 
> These properties allow platforms to restrict the maximum high-speed
> gear and rate used by the UFS controller. This is required for
> certain automotive platforms with hardware constraints.

Please reformat other way around: describe the actual problem (which
platforms, which constraints, what breaks, etc). Then describe your
solution.

> 
> Signed-off-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index 6c6043d9809e..9dedd09df9e0 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -111,6 +111,16 @@ properties:
>      description:
>        GPIO connected to the RESET pin of the UFS memory device.
>  
> +  limit-hs-gear:

If the properties are generic, they should go to the ufs-common.yaml. If
not (but why?), then they should be prefixed with 'qcom,' prefix, as
usual.

> +    maxItems: 1
> +    description:
> +      Limit max phy hs gear
> +
> +  limit-rate:
> +    maxItems: 1
> +    description:
> +      Limit max phy hs rate
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry

