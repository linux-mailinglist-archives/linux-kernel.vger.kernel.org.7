Return-Path: <linux-kernel+bounces-855242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A4CBE0970
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F3C19A3EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379DB30C62B;
	Wed, 15 Oct 2025 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h5EfwfB1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2B30B520
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559088; cv=none; b=VCBqBqOt9kjNyTJ91H6L1M+353iiLuVTlflUK/iFhd77wKK9b2YGV9capbdRQnTv/twbhKTRzMEr0f4Ecl17C3R7WJyogedT4LZL8y5ysvok4PE6DtToBGxGZu5JjbpspjQbiWbxbQQH43OHy8MoxJ3QYQpfT4wjTdE726a/19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559088; c=relaxed/simple;
	bh=tlQYqfr+lRcDlNEbr07FlHSH5FhhsNlr3tj/6Ax+bv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqRDKOY7yXDLjg+FQ+hV1BK5qsPQN8Ge+ufiIBAt7IoOvil6epF7LDfreFePfVH9yJRdgzuTqVhfsgw8w5c/BR62Nu2U4eY9vwks17moZ/fSkwlbyFoNfqmNH5TB4eyfDvg7B5vc0WE37c6jljCjEraJ0S39msEkvKQdPEfXx2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h5EfwfB1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FBBlTc002717
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LVldk4RaYwVtWNntXmtqcnQ4
	tRICAXA4ItTRgBL4U/k=; b=h5EfwfB16OChAMhW0bSF4lcrtvuj74YxIA2+zh9I
	Um1+XfQuBgID6kcKU/RXriVZRNJC/EOJPCF/WPGlBGjus3UPXnE+uHIxlCll9Rfk
	x4MUwoXHW1gkZxWGGbl3EIX4othAMFy74lw3rndNSLe+NTAbYf2iBgyKqno7VlKr
	rBvw/rzHNrUM/ruU1LIT1lOASrj8/aDs1z84zCIfX45uxu/3nBllYIaTQJ4kFlqA
	If9XNSQZDEdgv2WtXSbJsj5UY7GuLYXTPHCYO3Yfx88Z0UImW7L0ZtKaub+c6Uk4
	MipaVg0Xb8rjaUgjKhyETf5eBl1SgBhktN1g0pr14TzFRA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd95v7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:11:26 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-81d800259e3so300636d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760559085; x=1761163885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVldk4RaYwVtWNntXmtqcnQ4tRICAXA4ItTRgBL4U/k=;
        b=XZJ4Op+p21KKtdfavLXQzpBF8cfBHq5mIxrb3yobh0LGP3K9xmDl2MdDtmz9JPRKPc
         Ajjutn5t6DKnP54f1Bi5rFWiecfPXfQCVz/jJTYXLhwDXzyjeeHtKVcaYBfo4/iqrLFQ
         u4a6QDeTQRQcY/z2Gf442m6IZGmjocV4E2Asu/8fGWWENU/KctHei66IQWG9i2JSsulD
         lMHW5yQie60l3bzTg6r5l4idq0jHg4HWvKQjglPqD5Qm1w0KBeY1aK1S8BN+XGFKmNWr
         nWwUGGJDH0P+WVHatUogKjYzy4MP94a51hAgQi9JSvUN3ppDeyg6+rg+G8tnfVtAuz+M
         ZTgA==
X-Forwarded-Encrypted: i=1; AJvYcCUD81nDhbxI8duTUuJXHX68etrhTj+2hQAn4dkHCEd4l+H4+XgNazmL4z/ZEYwHeYuid64JABEdny8e9us=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1y9hAY/g612oDhJVh49aTbQqsJR0o7+KIzTfBzLxEM8fGmw5V
	j1jOcPv87tW7Sitx93xkAxLo4jhrCdt0YcGgqaZVeVxQCirmEvWHeu6fkrBA4qIIczjG6YAlk0N
	otuLzbpS/1pUzzjY/EHm88gvC93LT69aG9KKYsw8WyepGQcCWii8waM7UxODEq3wDmvg=
X-Gm-Gg: ASbGncsb52A6laJUBxgzu8odGmgRMiyoCNWBhwhldS0SbkY/AYMIEXhsz82/l5RhmEM
	4cw4JnB9VT2O8XcD9gpYioMD9azTU6rI2yIK83KnhlVYP+P5pbKoMvFvWIp//SZUoI7JbmpeKha
	QyrHZC6mjbejYLfTSW/jPmvLuT9Bo2m7uAopsg2MgmiXc8I8xnJFPBTcfh3uRDrWItQWPP1c+I+
	znItsAqTEM2olrC/e0asX56WIpoMnYwtrjJEDGAT6MgAlUPsrym0DhZxtJzfTy5R3IUrnJr5zBW
	x9wgJ238V5DluVKBw/LTUybCUpSSx32NAota2td1pKWpqa/XFpvMn7epRk0gOehz1az13KE4xE4
	Yuv7E6NaTNvIpJIJPdeUbXhP9ix2nURNvdUQezNb7GZzZSPOEdIhnrh1G6aarGdB+d1XO5+dl0h
	RZ9RZ+mMdenf8=
X-Received: by 2002:a05:622a:30a:b0:4cd:601e:9d29 with SMTP id d75a77b69052e-4e6eaccc282mr395056571cf.11.1760559084782;
        Wed, 15 Oct 2025 13:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs/8x4/fTZv//0wDdUVKmlKtMYrWW/DNTSd9Z59w5HhH6mfvuS0MkwZLiRmy45Bts6zp0Mvw==
X-Received: by 2002:a05:622a:30a:b0:4cd:601e:9d29 with SMTP id d75a77b69052e-4e6eaccc282mr395056121cf.11.1760559084146;
        Wed, 15 Oct 2025 13:11:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088579de8sm6500434e87.115.2025.10.15.13.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 13:11:23 -0700 (PDT)
Date: Wed, 15 Oct 2025 23:11:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dzmitry Sankouski <dsankouski@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sdm845-starqltechn: Remove stray
 #address/size-cells
Message-ID: <37x5l2wmtzcvhz7ui3plpke5irnj4lpf3fpsi6kmuv4d5tiis2@cdxx5nserdnd>
References: <20251015-topic-starltechn_i2c_gpio-v1-0-6d303184ee87@oss.qualcomm.com>
 <20251015-topic-starltechn_i2c_gpio-v1-2-6d303184ee87@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-topic-starltechn_i2c_gpio-v1-2-6d303184ee87@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: TVoQ6O-HGxeEGNIaNT4AWmsDGIArj_w5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX6GYF87TKsQ92
 F17dF/nYtFVlGIJemfDd3n8A+DANhx+2niUw+/QmteIAo7I1bln5zoPAOoKL137Ce3sKfTtiKRs
 cYvQYdURwXWSsBkl0W+b4/I3mW1hKq3I0Zdm+bBF0Oqgjaba5Q8LmyG54Q3eS3HgGDIMYmm9+hk
 QEke7BXLU/sQAbN9gQJRObkLA+/vwKEzK6zPouzMnOLZXBIoP5i7xKZqvh5iHVmrtWvrTeHAuQW
 o2ebQsUzyt/ahGJfV14I611PqgxEwZlX2VKdWE14EGDTw7W6a5q2GUgcSanXmb3ebiJg5p/+J4z
 XR4GahXLqhPJSuCNjkEE3ncUTPwUnD7SuGBR898KkXjTzsLrCOYoOsFBlGkJpd3Yrr+lploQ2hH
 AK5gphnJETlkHbdMcigDsglZmaUmJA==
X-Proofpoint-GUID: TVoQ6O-HGxeEGNIaNT4AWmsDGIArj_w5
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68efffee cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=uQEY_WcXetCi4OVW4CEA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Wed, Oct 15, 2025 at 06:32:17PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> maxim,max77705 does not have any children with a 'reg' property, hence
> solve the following warning:
> 
> '#address-cells', '#size-cells' do not match any of the regexes:
> '^pinctrl-[0-9]+$'
> 
> by simply removing the disallowed properties.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry

