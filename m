Return-Path: <linux-kernel+bounces-864524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F5ABFAFA3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FC534EE863
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2CB30648A;
	Wed, 22 Oct 2025 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TfCRa44e"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53264266584
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122974; cv=none; b=DnWCFnSJ0zHXvsJEMlfqul7ae+mVtU71YIRI1d49BFNknhlKB6cxlIyawA0QwaRVQkO/IkfxJD1p1cHcwFddcI9ko5sjsJ7fSIKF5y0mvQrUY2or/CVTQaMbvSyK3nrHHlrsX3QdDuLFp5LdeQSknXGOPZNiW1qm11APpFcbF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122974; c=relaxed/simple;
	bh=wjCzMHrY7zm4/gxCP4CZlqp/d73hDT+KJxvUYhxZbuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFKlCIfVhEXg57OTGe4Fd3U3Dca8cz7BZbvdfb9RHTHoj8uncvU23babtpUgckdtZwNBm35ZYIVpA4uyvyKBLUTW4ev2XCfQ7OIXPv2CTsfrD4ehXcbeLbiZ9x5PyAUKC/nJxQpGKo15AIXHtjsVLxCcugVq9XlhdK3M2UQsQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TfCRa44e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7EORa012340
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Wt6eXSz1rKUJ6Z/35CgBqLKd
	WLIVbXi8ykJ1f5OWpiQ=; b=TfCRa44eVuqPByQvt5LGEWzLmxAWeriqAkiXX2hv
	SwDoz5ev80kWyTxifiwq2sYSkFCAyRH/si8Dv4+EznKZF9xqrApbV/6hrOwaQlCy
	gYKz7gSMG5OQP3TiN11f/7YAr4R/9jqsGtWslq9LR/ZIXtMFcEaY6WTrmmUBhEg8
	9+9hbj52A5IYNUNbmRTziJ+OdjUhfPfoEC/f+cT9zFsmzfw2Zziu2YYZ1UTESmqK
	8CL/hxBZuOGV59zFCbGRABFalbX5+XdesE9XBJV9W4WN7orjYlxO7DtXFjhVMYjO
	t4yENBIaTQdf+ODExdsJb6RW/Suyi8FLqJiMuxptf4Malw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0hsks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:49:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e884663b25so27158411cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761122969; x=1761727769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wt6eXSz1rKUJ6Z/35CgBqLKdWLIVbXi8ykJ1f5OWpiQ=;
        b=KPoRF3IgCOJm6D+L8qDncB1Q4t1k32niAezt50ZVP5B4ywh4fAqNe3/GhSkT6abjD+
         kC0ZPCkvSOYthPp1adFTJ8lhUXq1wwBG2qGUY0ORAgEOJbsXPcj68UzXNMBywUH9YEod
         C4p1EezlYsUysFz3TasP+LfT6G96ojSl7jKqRHzrkDLY9jHkZW60OocYRWde3p3C834Z
         F4lQBkOGrPmhJVhUAN8pE/oJvNrNt7sKYMXpvSmpAg5q1Vnr0I1+4e+rIZSgLK+pLd0D
         m9hLn+Fz/sU5Bj/qbIbP0ko1m9J0FAJxA2zaZqPgJVEBeSEbQjqafn8ms16WxrZbgjan
         rssQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3pyRt+zkW3VhwLIo8Y8hyWvHjRlNO0d48UXa7KqMnAD6rtDX8k6Mj9EAUbVc4fWJ/YI++RIlyVEedkmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4da9scluhwH6CJHXXSfMEoUlSJRxYEHiA4Vgk6dvk7rWXEhci
	kzItNVYCIUjV182VHUm4ofzhEUFOffoOAxn5sfIb7FgpBJmKl3AP/p+gOKbdHEcHWyrO5xMIZE+
	5wkFTl85WtQskeVcyrOWgBAjdKv1BbcGOhkIFyROtIKD4ygNZNepO7gLCVtwLM5oaNb8=
X-Gm-Gg: ASbGnct/+nwVu3tD+Tz/AJIqpy7SNes3Gbb8ErnYteioJrGzqBY3Z6hwGY7OW+Ib0n1
	kzdT+PX7H3NVry+k18fkHHDFah6doDRBhd5sqOvHFQ+ymizgGipQes76RgxvR+8Tw6uimaX5tFo
	cuWdxyBSoCSvM6Ng9jArAjMyqUmjRaPrkP0vNWEYHiEsjfXsgY+iKPBjB3O1s+0VWesEi5VdTv0
	JMlzWFz2Zp2iW+T/LqoU4zsSaFc9RumPJMOuQrVBxdXi+M4zZ+kw7CImV00BJlY9CvE0t/O/ncj
	HQW5VjfFtDcE4ywFyKiILHsm6vdh9rJaTRRIXZB1iTywjTIFIawyk0M2DoN+F0mYsVELZdTp8RF
	amvoMabgyDmQn674tZHRWSxvs3HMEY5pZbF51eK3GL6wZHXUgU4+rJkP4R07AVZmIBXv2kfhWUm
	2LAK8+JrnRu2M=
X-Received: by 2002:ac8:7d94:0:b0:4e2:e58a:57e1 with SMTP id d75a77b69052e-4e8b68db873mr143683521cf.37.1761122969466;
        Wed, 22 Oct 2025 01:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD6jgt3mxKd1WB6O0YTEVvISlo0czZyfQHFWSSIjY2FShbZExMO0p+A3Ym2WGTO2ssrxsH+A==
X-Received: by 2002:ac8:7d94:0:b0:4e2:e58a:57e1 with SMTP id d75a77b69052e-4e8b68db873mr143683231cf.37.1761122968951;
        Wed, 22 Oct 2025 01:49:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591eaace6a0sm1771943e87.110.2025.10.22.01.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:49:28 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:49:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eugen Hristev <eugen.hristev@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: qcom: Add qcom,kaanapali-imem
 compatible
Message-ID: <g2iviaqetgxf5ycz2otzkpmmc4goo7xuyjmttuu254bfzqqvkf@4vybjh4eghpm>
References: <20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com>
 <20251022-knp-soc-binding-v2-1-3cd3f390f3e2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-knp-soc-binding-v2-1-3cd3f390f3e2@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfXw4Xa8jNAcuj6
 sjEI5IxvrBquTvkBLyDNUGu2PA8vHeI/u4pCBT6JJAdNK/nbnA0EU8r4Xcwb2KklqxjA5zVi0ak
 Sd7xRoWQorTFI6A4Dh5LW7i3ceaM+cotNnZoy19PAX5SWdv5rTFv/dOYDWQ4/CJ4jI8KhhvfDlt
 lh1UZKfgbll+rzx9Bsv00Lt6KTjIbnUCGQIOsCcdnIIxzkEUObdwLZyTYbQeqeCzecNFPzfHSJ8
 lzRr949xcvOBXP1ZHoNdXa2auIaNaeimWxiSyAchlHIL1lK9qY/z8ezuqaQ78fnNQOWMBt5agOZ
 aIg5D1egste/VliQtKZHx6f3Xt6uClU7Yv3a37AlWnDlOHIjL45U7+JzWgnvvzObWzBdyRJNHNQ
 LfeizmnKt2sQF+Z1ur6JEcwJ4Xg7fQ==
X-Proofpoint-ORIG-GUID: u_Wf3A6cqqEYyBd1KosPqDHzbiUq6zN2
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f89a9a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=xGdXe8btZ7SUbin7ybQA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: u_Wf3A6cqqEYyBd1KosPqDHzbiUq6zN2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

On Wed, Oct 22, 2025 at 12:28:41AM -0700, Jingyi Wang wrote:
> Document qcom,kaanapali-imem compatible.
> 
> Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> index 6a627c57ae2f..1e29a8ff287f 100644
> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> @@ -19,6 +19,7 @@ properties:
>        - enum:
>            - qcom,apq8064-imem
>            - qcom,ipq5424-imem
> +          - qcom,kaanapali-imem

Can you use mmio-sram instead?

>            - qcom,msm8226-imem
>            - qcom,msm8974-imem
>            - qcom,msm8976-imem
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

