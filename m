Return-Path: <linux-kernel+bounces-782566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13502B32225
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54D81D285CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F722BDC23;
	Fri, 22 Aug 2025 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="okVGphik"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1BD291C07
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886414; cv=none; b=Vvb4ptVFoA5WVSJwzXi9JF8J7+uEfoIr5FISljG+GNtbmCcnL7Okk8isUK54CNndPD1VnXGWPnNuJi9zWazkgiPZJUlqtmH+iwrYAHq2Ph6ivmOgS9IVB1YF9C4XzsoYfgNCvL26qvJIAsYmHCQlZfXgGeiGjDfJ5OzFDChbEpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886414; c=relaxed/simple;
	bh=OsSWM5rafowFUmYpNuV9JqMJVXfG7U6c2e6naLYaZ7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhvszh+Jxbu7Q5kBv4FAxHtlKPxjY7swTHR8aLoZiIXBXEhodgI2YMeZZu2zs24a9tULGnLqkiRC2gs7jAv2znht2s8tNhlYE9dZPt/eAgNyfG6f3IIBLtvcsh/dO6CCzU9kIa72pK94QvDN9+JsYS7kerMkT/GDiQZHnClB4V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=okVGphik; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MHUhud030142
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dSO+6ftuDsb8o5P/S7crWg+c
	tsTiUDkNMjVkpDX34wo=; b=okVGphikPj7NyIg2pKsu8klAXo8PB5IQDnuSM7kh
	HvPvnLXHjcd48MnHikgSXdd1KttVCUhl0VU7YRm2yHlUp1Oqc1p4RRBxh/KtlCM4
	feUMxx4mnnuCy3RkXkbZSQyN+lMg2sJMNzlCv8MC8ctaVcqrHPzWG6JUvZIlYkgX
	8U6pSTrrAaBPZOvOZkzsqgUH5H10RaOpNEmLND5CkZ2Bw6eHzBenXZxrogcz+xj/
	uUs1Fn55cAK4HNcLzP0jFPn6KJYjTKNNX0kBY8YQuDItjZaiTxgvpFps3ImkYWd4
	8bqjG2pq7eFmv05rSuVuo0pf5d8Tep4jUBITagqi+0XYfg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48pw0yr4h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:13:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109919a51so107737981cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755886411; x=1756491211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSO+6ftuDsb8o5P/S7crWg+ctsTiUDkNMjVkpDX34wo=;
        b=e6r2A5bEMTTDarNUt5tEscppcqxAcBdwAl0ebFdRh6NMbpOldyQJfHoxxO2izAbvwL
         EULoakBt3s49eR+pnno3HO7ig9gLMFc6dXX8PRCxoxrq8y4sb5TAmigCAJkJG2FqX+Mh
         JkWBfk63LPm+4TsXIUs75IAB7x3MvhggblidPShVECZjbtvadoRj7F0zI5m+5uecbxrR
         91HXGGRwYjDo404pTf+PjnHalc880s/rNGLd4wxdcKbYfhzI2gU++siXn47XHUpJUrvg
         GyA84hfVEI2ycMcNF0LnaR3uGM+P9rKmEE2ivi+VUVXfORkDBhN2ou0v4h9GEOcJCH2s
         jHJA==
X-Forwarded-Encrypted: i=1; AJvYcCVsh4p0ZIWarcseTmN0Re3Na45qmVLx/r22FomSYrS/r2qYo6nw+v+CkcR6CO5GW29/9ObkdngcWFl0K40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2joj6ufCVYIK2L78buZTdGMND6KBS10uOBYC9lF0ghqQJbsuc
	a98SM869Lf6alqyYrXn1pelA3DFwRiqvOCQswN0POLZ+8Lpj6ziKxaNOhgPVSE795r418nyBHEy
	xvHSIAzStuwSh/SgK9A1xnXCb7BLPZiyUHCeQ+kLXLeQUaW3fs34WuaJtMBY44l5x06g=
X-Gm-Gg: ASbGncsGnDE2ig3rLyerMvX/JRWB7UIF6DDXRqB44I02BvhItXefr/Rf/TnwV6QjkyD
	0bhEgKGIeX3bN5ZWzCrbk2f7JutDwcVFBEicAK9q9+0gG+3ZwXnpfHLdQ2qPCjGEkAusyyF+Wuo
	0XiGBrKBo7udP5pkMH2FCsfEUxnm9gsI8lcS/fd0AZynwSQbsECTq8Ni6dEAzv+hpUG8w2SV6be
	aU+3cc1QMQjQdngsvoQk++yFXEFgOjV7lgrQJxrnRjkQ9Lq38WdfrLPZMQiwExknZGi4HeLMeHx
	EVcjM4G98OqdoX3Zbe+jCf9xGtClRW5eLc6WQ4E3vyakONDj+kmSPcJSp2Aj4sg53/xfC4G6fFk
	RPHLgM6yUefCFnlCm8q1hdcOi7lUunWfdAxM0mBUORxqjMb59dgFO
X-Received: by 2002:ac8:584d:0:b0:4b2:83d8:4e19 with SMTP id d75a77b69052e-4b2aab2f2b4mr47540071cf.67.1755886411335;
        Fri, 22 Aug 2025 11:13:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgl6Rb3LPZBdGK6f5eEI93UymhJjbrLRHxUSpKaWOlHOwLwB0Hqe7KQvriMM2BunTVfmUN0w==
X-Received: by 2002:ac8:584d:0:b0:4b2:83d8:4e19 with SMTP id d75a77b69052e-4b2aab2f2b4mr47539671cf.67.1755886410756;
        Fri, 22 Aug 2025 11:13:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e23df6csm691821fa.21.2025.08.22.11.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:13:30 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:13:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] arm64: dts: qcom: Set up 4-lane DP for sm8[56]50
 & x1e boards
Message-ID: <yf5bw6hesd2vpvum77zprr27oyedaglhafumx5netfqzxcy3cg@2r3l5w3ddns7>
References: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
X-Authority-Analysis: v=2.4 cv=Z6bsHGRA c=1 sm=1 tr=0 ts=68a8b34c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=i8zRFognpsdf2JTOJ_QA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4oFzDhTmNB-Mgu9fSW-Ju5PK59FpvXzI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE2MCBTYWx0ZWRfX5rOJhrTMuIxO
 O0wslbOsQVyPvGieQ1iSumj2IaljIWAJZWDfJd8KtBW/iIMTeivGMPl0taRfyFFSfNuvjifaINN
 rEn8+s+Q1TCineW82V9zizUnBNA2fHOXXxeDYvyc3zzKaY0zDeGrFJFYYgHWUvKZpSJpf/DIBN3
 xLIS0fAE6lcO6FHoFGtF12T7gQ91E7yx9P5NhwRDzOIJ2QOSlOjVTAG+bFozazkpIWQqk2pP+b5
 Z9G+y+dF9YXBSJV7DdO5C9PZHTe2u2Ix/YvnKAYBYMQNDsSc+gaTfD+UrZ5fjAC+FehjusRAcWo
 VKpfYbADnZC+CQLjsQj9FdYygL2bQol63+IildUnWmiyF/diDsS32p2XodNIem3vLRRL/zcAKUu
 GGoY7DWp
X-Proofpoint-ORIG-GUID: 4oFzDhTmNB-Mgu9fSW-Ju5PK59FpvXzI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508220160

On Fri, Aug 22, 2025 at 05:56:48PM +0200, Neil Armstrong wrote:
> Now the 4lanes support in the QMP Combo PHY has been merged in [1],
> add the required plumbing in DT.
> 
> [1] https://lore.kernel.org/all/20250807-topic-4ln_dp_respin-v4-0-43272d6eca92@oss.qualcomm.com/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v3:
> - Move the data-lanes in the SoC dtsi, and update it there
> - Link to v2: https://lore.kernel.org/r/20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org
> 
> Changes in v2:
> - Add missing x1-asus-zenbook-a14 & x1-crd
> - Link to v1: https://lore.kernel.org/r/20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org

For the series:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Thanks!

-- 
With best wishes
Dmitry

