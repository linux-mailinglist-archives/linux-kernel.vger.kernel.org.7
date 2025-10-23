Return-Path: <linux-kernel+bounces-866925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCD6C010DC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D1D1A612D5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D39A3126B9;
	Thu, 23 Oct 2025 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="icgvQ3yD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF1D3112BD
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221800; cv=none; b=AgyEzZc/jqTrwozs/lpQCWy/oboStd44Xdc06oax9l4P+4Nkf0wKTBxmj0yH/B8JKTNt8eYv5kt+CA/QiPgG+RG+FfGA22u6JGf8u9MiGlikm8vxLPUNXs9QdK22jpfmbW+IryTSzuzv2wS9vtNhWB5k8rs0tMOszr29T4LmsJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221800; c=relaxed/simple;
	bh=cZlyEkb7lExdBwh9PEejexhtDGyWrl4DgTZeGjaLI3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBLBMWk3q2OMNiCW4QWQhIuah7bYsbdYl6tOErTa8QDdhk8iV1vjmlIR5gNdyLaRtA7BK6Kall0TcHPtEZq9sVat389Q9HZ66gqA6sTWiOoVkqsaxq1cNPu9+uUc6KxW98T6w61Yeh3vI2bJjJvMbYrufZGdNzutGUDdaHK4CtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=icgvQ3yD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6mTsA010383
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4e4CsJ2qxbzcJTqFCSRdFwah
	q7xIbkuDSSw+M5pcQjk=; b=icgvQ3yDf93btZBjpIalqoLkmXnQ2pDi+Q1TVXRV
	539dPkpkFQMTkL4CilRdyArqe01KPg9kus6yPMaAgoU3BiOF1+UFPgTDUAj4PIIa
	b2278e6v35mn4pjjNchMDN5jUA73hHKhSxWMzox+hikwZ92oCwKbZLyXv8NccOX3
	Bmmpo7vFtSIHlmP7tNvqBMQpKJVH1EDTr+r7qU1Zgyfa9ug1a/81EAXYwm2lSLoL
	iAhIfY0qmYsMuS/e+9EXPHTOgLYRT0cFPKXIbFvMVGRHDOcpfhjBK9Jk/ZtlC4ti
	mbqEJbViiZq5MStIvSRkigVtkz4XqYINo3Lp+ijOhT46oQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3448dj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:16:35 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-79a3c16b276so13972636d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221794; x=1761826594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e4CsJ2qxbzcJTqFCSRdFwahq7xIbkuDSSw+M5pcQjk=;
        b=WgcHJxSZg1zF05hZPqeaEzfByzj44HNZYd+EwyxVkSZUSzgMaCrbAAovWwuwP+iQFj
         +IAjE15YzvFC58fQLpCqdrnI4hqS0c7OSypVe99gYSmFKBJpFNCIc7zcqDQwLr3Dgy8t
         zoFUvId811VDdXojpDJI/3+gmxWmF842ks2DQdhEP3ZONYHGhoEkDXxMAZdGkJGYu4o+
         U96mlti7kZxaUIjjz4f1UdLpBuTtU06x0l4xE984GZulIzgZfHzd8AqZArkby1ExiSpq
         ZV//7A2iXz+lG/rn2wxbtu6tOqmphxkixJa3RgjfWWNeslH6x2meovPa9K1ED0QuJQkp
         sHqw==
X-Forwarded-Encrypted: i=1; AJvYcCUCSAPAmdwd0NCSMUePXLmq6k5EHfXTv9cNP4nXlxiE9ADqgwSMM3wiiCl6Y/PFsqQClu0EhvAtPgR6jcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZKMDHcQDXwcQM6XRGV+KzT7v4fpyHSKAdrctSEscGtyQPuyJg
	34Qs9ZFb1row8ZTntgGw4WHKek0EdKmUBxzwI2RwPIhAd/LZ/lGhPMZVKgk248htHXXfofb6VNi
	am7sony0OgMkChcYDC1ySRDMBMPmMRzUd8mSYpexthp8PZ5iNh+IG9oLl8DbHCsC/jO0=
X-Gm-Gg: ASbGncsVE7SEUkdx9BRx5NnTYqEmd6mF28LJYvwL9J6xUdSF5s5Ok5Foo0Jl5EWe22M
	PZRHCcTnwoeJeYp8NRw4HnanBln4Jiz8F1XiT1q6rr8dcpK/kDRGLPLBt17eIxfnEDvwBv+VIUG
	r/KfeT3LdGRN8Ssm0Kmcc+i8s0UdzOBROr3M5T32ImGwnKEDHAYM7NogYSjXoLcXMD8nrSaty/b
	73M5zeUH7d6HFYLDuJvb5qczlibWIzzVf0dbXsViKPOtTM+IBoeIZcaDTgCPHZy5E2iqz8/QsOj
	3XpZyHQsZ++sGV5RgYtZzlg9Ag1Siic/IHNSTppOHs9wPqoHTOBrYJhFd5ohWJtYS0SrVCqIJC6
	eKHfglXVY+5hMQHcACZjaRUs6AiBcsLkph7fehC2EeslIStZuKQGDciSaEek60l9poBwNQOYIyC
	5WJqNFHAHB5frt
X-Received: by 2002:ac8:5916:0:b0:4e8:a9ee:940d with SMTP id d75a77b69052e-4e8b6848072mr186108461cf.65.1761221794269;
        Thu, 23 Oct 2025 05:16:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGop9hpBDFFP1MrcMk2Fsq2TpD6+/75ykSiER9cOjUVWtI35/vGRfvOgaBCSCvXp2xBdGKtQ==
X-Received: by 2002:ac8:5916:0:b0:4e8:a9ee:940d with SMTP id d75a77b69052e-4e8b6848072mr186107931cf.65.1761221793683;
        Thu, 23 Oct 2025 05:16:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d38709sm678359e87.106.2025.10.23.05.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:16:32 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:16:31 +0300
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
Subject: Re: [PATCH 10/12] dt-bindings: display/msm: dsi-phy-7nm: Add
 Kaanapali DSi PHY
Message-ID: <em666johhzrluo5z4t2nu5jo4yuowegaemlrursvczx2zze5o5@uakt5j22ygwm>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-5-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023080609.1212-5-yuanjie.yang@oss.qualcomm.com>
X-Proofpoint-GUID: kpuoi6GEZBt_vgvSTG556aM_vtaW-U0L
X-Proofpoint-ORIG-GUID: kpuoi6GEZBt_vgvSTG556aM_vtaW-U0L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX8gIHeGbQCIco
 pgiVcf1fS6sKqTy+zBVWoYoSpeHVJdtIc5sYHICJJDZaDL98OtsZenTIRyHFAhB6gRVe+pJWS1/
 2gdNFPnvPdkSVyD+v3sauLG+6Pu5KHHPnYriZ65ShLxwXgaDkkS1MiG91iNGhIXxwlrR91sfjhq
 8459Tn6UW2QFDFCFTcsmfGi3N+MGCJ5AesACzfpC/q26qNMorleYsp/966hOkQDa8Dxi01JN4sh
 EJqL6HFv15z8dnAeVHvIivyApnHFWS10SvXbuw+1AuAt2SU0EjKARI5yNni8bvtY7XxBb+H5qVJ
 L8+OKVMgEO9V8XgNB0l5Vl3RpICH77MdJHRjmGQtrzi3jaHBLMNbLj7Xso2BdCd16jpLQStDEZt
 IqmSphHgclJN6f3v5otC8d39dhW0oA==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68fa1ca3 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=hdgSSxsrCpB_R1hBYGgA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

On Thu, Oct 23, 2025 at 04:06:07PM +0800, yuanjie yang wrote:
> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>

In the subject: DSI, not DSi

> 
> Add DSI PHY for Kaanapali.

Why?

> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
> index 1ca820a500b7..a6e044eed3df 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
> @@ -17,6 +17,7 @@ properties:
>      enum:
>        - qcom,dsi-phy-7nm
>        - qcom,dsi-phy-7nm-8150
> +      - qcom,kaanapali-dsi-phy-3nm
>        - qcom,sa8775p-dsi-phy-5nm
>        - qcom,sar2130p-dsi-phy-5nm
>        - qcom,sc7280-dsi-phy-7nm
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

