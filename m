Return-Path: <linux-kernel+bounces-846990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FFFBC99A1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C15D4FB419
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6576E2EB847;
	Thu,  9 Oct 2025 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dKamZcO1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423362D877C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021127; cv=none; b=OnqknQj2Var9Zfcnm1pESNfWtuJYjeiHXkWmtMY9EK1deyuWypOAadZ1Xc7LyDAMpQTzG9CqXV31SgpqV2YdGO70t+EVshzvCpji2agtjmw8zJ2Trdkm+9ENhFl9WWGBpx+5dq882ByattI/5pOLfG+maE+GyytTFR/aYAODzvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021127; c=relaxed/simple;
	bh=Wpq6X2Bh4pWgoixvchHMpCayL0dRsdmKyfhfouSikNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hesvJ/ASGmBCcq7HkKQ8O/m70ON/mcg55kQo2+Mpy/1Qq2FjPviEHm3is8oqOX98LG0vm3W7t0Hm8F7MwwQTH3FoEsweMrEGMjM+tar3AZ59xhjS85o70hKjbn4QzCDeyoqPkf6Y8gx0wfsLU0mI866DonEpExdmqSCPyOpSexc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dKamZcO1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EZVNN022397
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 14:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zS0WtM/F0U5NDqRQEtXZLsZ8
	HXMsmD9R/IgnETcvlU8=; b=dKamZcO1PgD1eBG2bOoP2bTgvej76gs+GV39sjRY
	D/FMLr8lm5c5vEAmGFHfpPSHsQWxWYpj1RI2m4pYgU4nx+k+eZ8SNm+GyGQRY2MN
	S4oa3FBi7sWMvwuZGPmqBDZInsNgeIi08TCi8uuPz7YKvXCtET3K/PTNmPAA0kno
	OHUyElwGsdJoKt0tq+VOEf3dVtEc2Uuwwfq+c8uBwOcWgf+w69AQWXHadET1m5yv
	+NgioEwbFLzZQYvPu+TpNgcSMkEmCVnZtRHE1fmk+paRKFnce/qean2E9nuLA2D3
	vqZIP6cPxSsAZmCGTSvdUOKNy2y8BixFCdHTVpcnltcsAw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4sk72y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:45:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4de53348322so60973201cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021114; x=1760625914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zS0WtM/F0U5NDqRQEtXZLsZ8HXMsmD9R/IgnETcvlU8=;
        b=Z8txmNOjbuOaKjm/pd/tirNDjyhkAY9Muoy2dN9E/CJK455PkdWkhv4Apn2xInnfUC
         7RqvYgz8hK0audZbjAMQbT4e/P2FiC6hHr8D93veyY+sXEM41f1YlxC6gRa9Vy79z13C
         +XaW6454Hddn+MUAHzRDU6/XS3g5Ne/OEO5H8Dk7JDg1+GsAXFoQVOzZS6+2K74Zs6fb
         2NmZl3p/QDxKs11g0MFUjw3gPsFdB+gsb9UWIMQS5KeCb+x1Xq8oSSzSKcvPeSfCSzWQ
         z/K8sDq67Y5dKmwNVFEltLm/+8TqNesu8oJFz/zEiB1hconxsdw70S0lWjXn+hWpOeIn
         WDwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdPi+870CKZ10oWh2uDFgIdOWhZB9KwK+hmAW7sWVbYMMyk9PYaZKmiqd7Y/5fJRfOsZ74v81+69nsaCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ciXfVjp6/X9TFjLc8SECsazA0oiob6GimiQofdbbnLM8dhfY
	QMbg7/1Vwlpqoza+J6//c6u7LV/kIN/HEXhji+8jmTaoKHnbE+eEPQd0cuOrgCCHoXU75F/0jB4
	fOOD9DRTsBMYLrUc8iZKaaodC8AKzDYZR5r1HVF0vKWul7PQq/Hx291vA4cFChFGZlRI=
X-Gm-Gg: ASbGncvM3Q9bQX0YG6/FbADwDgGiBt/xHTzgDHQOj8obtHahxUwPptbdKOp8H5vJJqq
	oMcbgRYpNWvU5sG7h8hhLpHFF+5/cDw08yCYLwewgsma4VefV3HqhtuYs4bC0/OYtwSXkbEHEzH
	85GPnhAf8AvJ1jXLTBT/qmZkJIc5DJVDrgxQChPpZYicgICrXmiAH/bCgkR+9ZxGfT61gzKOnz9
	K1HtxD1YOITJI30Cj2cPlIkd/uZmMLG85pUcBqmyRJHavbE/hqVtd8KfNfgeuPaoo4Dne2jFcHp
	33yppu97k1EVSEuUfJy5AYg6uLDZRdpYoqYI8Msk7PfMk3MxMxItGQ4q7frATY1j2ThLbVVNXgX
	mxo048S48FDqzfMbyRDBgONGsKnOrpwHDxk2O3Ss4zR24DhGUnny2RLwJqg==
X-Received: by 2002:a05:622a:114c:b0:4e6:d0e3:ac8b with SMTP id d75a77b69052e-4e6eacdb2b9mr121918351cf.3.1760021113332;
        Thu, 09 Oct 2025 07:45:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHExsw3wuCbhIUXYsG7UAJJhdf1NCRTGbXdHExJaMXOVTC3+o0DKeg0yWshy0/W0pdkUoQVvw==
X-Received: by 2002:a05:622a:114c:b0:4e6:d0e3:ac8b with SMTP id d75a77b69052e-4e6eacdb2b9mr121917961cf.3.1760021112870;
        Thu, 09 Oct 2025 07:45:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907aeb40bcsm1095761e87.121.2025.10.09.07.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:45:10 -0700 (PDT)
Date: Thu, 9 Oct 2025 17:45:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] media: iris: turn platform caps into constants
Message-ID: <cwpv42re6a6o7lk4jqetuwfbtnr65fuwcl5hcbldaxls7xj5e3@tkdngtx6mh6l>
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-1-def050ba5e1f@oss.qualcomm.com>
 <206dad42-7a7e-5293-55a0-d6d5bc702c07@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <206dad42-7a7e-5293-55a0-d6d5bc702c07@oss.qualcomm.com>
X-Proofpoint-GUID: _zSmK85ZhuGHpo9aP-yDzyqyq4gpdCkv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXzg8C8Sioikh7
 pR495hdCm9grQErU9V9c4V4u7KvCMrptO1T8YD/HXNDP/6ly3i/pk2nkolVucScwEtwA5P+Cp+B
 xiJ1eF6pTlriVN3JH8O2jHIFbdR+CJOYGmXd42Tg30G3hasCDyk2VWdZwsxorTrnyMTc+R9OwJ5
 S7YSKsx/pfNBpyDEeXCkYwbHzi3iQzW4d3c6k5QLuap2rsP5/vP9y1WmoYtecm2LZEc60mmFVQ2
 x3h3ivvK9j8lwm1wbf50UBkQ/awCNXJqRbKRlky/fTPeAJqZCMTFEnFfTor1UPVo3OCNVwa2lR2
 6ukKxzkZnUv9Yyznw+707SbLt21x6388FMo6vNrfrn1NhB0Un6DowoeiWVgfvu3TowUZH2DEB/F
 HK9RCCi8hVbUA9xRKrwGEZShHmu9BQ==
X-Authority-Analysis: v=2.4 cv=SfL6t/Ru c=1 sm=1 tr=0 ts=68e7ca83 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=kPCPtfcKM0uLTnIstR8A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: _zSmK85ZhuGHpo9aP-yDzyqyq4gpdCkv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 11:38:54AM +0530, Dikshita Agarwal wrote:
> 
> On 10/8/2025 10:02 AM, Dmitry Baryshkov wrote:
> > Make all struct platform_inst_fw_cap instances constant, they are not
> > modified at runtime.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >  
> > -static struct platform_inst_fw_cap inst_fw_cap_sm8250_enc[] = {
> > +static const struct platform_inst_fw_cap inst_fw_cap_sm8250_enc[] = {
> >  	{
> >  		.cap_id = STAGE,
> >  		.min = STAGE_1,
> > 
> 
> Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Please trim the messages you reply to. There is little point in
scrolling the whole patch (looking for comments) to find the R-B at the
end.

-- 
With best wishes
Dmitry

