Return-Path: <linux-kernel+bounces-882603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9906DC2ADC1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A9214E3127
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA152FA0F6;
	Mon,  3 Nov 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="awVu9mZE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZqNetvVb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42FA2FABFA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163543; cv=none; b=uV+4XRKAmKSuAsgbB7ahOXhQXbwW0SCFzr2EKruQDg/JQWsCA7sVoimCUY1z2x94gGBLSRDwxgW4HD3qrxwmrscA7ko5Y8lylTDJmA8exXSKmi5kSqEq3Rm2BoYAH2CSBX2w/d2+knccEbE51nHtQ562UTYkarm5iul9U0o4WDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163543; c=relaxed/simple;
	bh=ilouYp44rCS2DbXYyq7hh9q0vM4P/bamUocBhybD/nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwP4BRZaScTNj48+93LkQ8yfn1M3mu1Zh0OxeVf7289wPzy/NpK5rjYcHZawj2UYBO835Hfea/+SDyZt3ItORzvdt4mzTpS0A4iAVrrOLhDOfmB2phRCIaPXSbd6G2HbvbhhKzf0kwsNAstZTDVLfCOxB6w77t8Qfv6I+w4i6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=awVu9mZE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZqNetvVb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A396HRj1379196
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 09:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b9/hMynrjGoov5sKXV3QPhZeYgKZmJt12Z9R/C9Mx04=; b=awVu9mZEgPmSkXkX
	vuhMKMbQnQu4DPR1WIqoIJQM6MD9p8+kuaCMa4XlCSzY7XiRPIeEXiNo6z+S0HhJ
	gyB+HTvxEjet2wZnVCcMYpf+yRXN23b9T7CWWwautB8Em3huG1CAlbpmA04UJv+F
	6jN5CBzO4nXnwsykJybFvbU0oX3BGwSvermAk+qe+XFT+ieAt2RDyCRv+27oX2D3
	1102Gxk275LkAt9hIfm/086UufQDYJk79aQdrhsNEPFLKbXHXkGECe6FYqDg0mNn
	zFajXZbsoWuqi39TqUKbqKInwJoU4/P7BtF7qIIOZfAmu3sVp6Fd8UIWpNnQidZF
	VEXwGQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5ak8m62w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:52:18 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87ff7511178so10678396d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762163538; x=1762768338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9/hMynrjGoov5sKXV3QPhZeYgKZmJt12Z9R/C9Mx04=;
        b=ZqNetvVbsR2iOxfb4cDJe7HRIvWfdRHSuTGO9+7BznoOlLLJDTqF5HvjOLPSg1/7fE
         F8w5AE23PjDdEaf8kH+FfcOz0SrGf7HBSGy5jSW6sZ30uBHzSUSO/eZ+bP792fO2Zb8d
         DB1fWf8Auad9rwrvL0PSIBtp48mvjzkoN6dVoZCEO+WBSRgyQCMiVlOYZzAPFJixbbpO
         vBsb7xluiVkyNmpbLDbi576Z8fpGy3TCUnsVDmpOSEeRlkao7TQNOnH3saRGsmNQMt87
         oqgSBDY3pubt7jTC4N/JA6q2225fWI10thxN9WQ4eV0sEqRgdmzEKQw2iBNJGSf61Vap
         6ZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163538; x=1762768338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9/hMynrjGoov5sKXV3QPhZeYgKZmJt12Z9R/C9Mx04=;
        b=YMsdqvJaJAkXfIZDx+S4p8T3pSC4kuwXipVArb65GJtu0VAaszxukr8Yvqfcchv0mv
         qDGk0LTRLhCBR3/hqADils66MsuPUWaBX6CzjSMk/1BMRtLfXze+JDj371noAUlXS1gc
         iRYraOnRpDmVAwenPbOulfsX2657ebi5rJ0ypn2VMeI8NWYhBrvRVRKQwt/CsyQXc92e
         fUMaZ8yNoouLnyxOFv62Z+SJ3Y6EFcA/zlRK1s8Bj1UMPvOzkF6Cx+kRpgDxdjyw/f7z
         cXGW/bnevKi48VwsMeodEVA66nUAveu9/Bg9kbr/RkWNueXMroGTwTbpWDg3grdj8S2j
         cVKg==
X-Forwarded-Encrypted: i=1; AJvYcCVBSBbVlNxLyE9yruMpXF0UM/D5uVh2h8TevXECEO5KJb81E3OmTg8uNw6xjAF/2qMJ1Gp1aqX/+LlHRjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt62TLRA1ZmfYtxEMA9OIyERJRy8C5YHCDK06Zz/Di7D3Ep7y4
	MtKuoZGerv7zz/2phmznMyqk6s/hA4aVTL3HrAGdpqM6qB6vTsj4br0QzO2vIG2+vHkJVLtzyYU
	qfrwl0CnLtjtlARQgZz0YGzXiS88Sp9jIrZpk0z+Y4Yc2nAQHqDMcB5XI5dm0U8L1BoQ=
X-Gm-Gg: ASbGncteumnBuIEE1sahMjXZiYk8+O8TRHrwBGsZrhV2daLVPlUj1P2JsnpLcpYWnlf
	7A/bGrv88IISwHrxDcJWtUBJKNyss++5x0Tv5tXzsjDDGQJm1lrOmKr+A+gjQCiLVYrKSx08EQC
	IpzlxzlJQYgrJ+BoaUl4YWllJ9KCJuWdxLXdJ4qkCwWT8poyg0dgKHipUCVwnhvtJj4sGV+8+oI
	DTQVmDYUEO8wJ3hstz8O3lrs3eOaeSQ3KZaYbsqeiNCm86Xd6SF7R6HPXvUnB8IZbGLCBeiZJvI
	nKCELjMaFspasWi6lzZCLqOxTBjgNSAkwa7yp5Och8D302d2JUPsx87nmojfUvBEELFpQY+olC2
	+5aRHQTtaw/Ar15UyBtgUwrkq1TGwcVDPQLxrGvjZGD/GHTynfbKABJ0g
X-Received: by 2002:a05:6214:19c9:b0:880:51f0:5b92 with SMTP id 6a1803df08f44-88051f062e8mr36977056d6.1.1762163537423;
        Mon, 03 Nov 2025 01:52:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMuJXaeDPuSQb7uyKLednlPXSsjDtFnz5mwdcOTCCfsl7GSBy4eQ2+uDGZPWhbH7VIlYSjtg==
X-Received: by 2002:a05:6214:19c9:b0:880:51f0:5b92 with SMTP id 6a1803df08f44-88051f062e8mr36976806d6.1.1762163536701;
        Mon, 03 Nov 2025 01:52:16 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b42821bsm9228053a12.22.2025.11.03.01.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 01:52:16 -0800 (PST)
Message-ID: <e5d7654e-91da-4662-9055-df3a9d9d7bd5@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 10:52:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/25] interconnect: qcom: icc-rpmh: drop support for
 non-dynamic IDS
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
 <20251031-rework-icc-v3-25-0575304c9624@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-25-0575304c9624@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CQ7AE2dF14IKERPWgrfCxki5l8S5IJks
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA5MCBTYWx0ZWRfX+Hbnx14w963r
 ujj5tYjE7RnbRFsikvuU9p50QfOw7s47+oF9NxjGXYji4PVAawOzULKa055o18ZI6PUSjRoSoTm
 H/3obLXyiHGjT11WUkwKZNUgHZHzToIYDYbB5dGeKve5B2IDo6cl+U/D9T8p2SF5BAPLKC4u8KS
 /jv0veT2dclZR96oSohvMIVWD3dncDgwmL02wONswoiBMPPvIhCeTwVQNJa+2VL8owwxEWwNVwq
 vvnNIbZi1CJ1tCJEOtEdAUldYcviakwLDtV3HgszVMdgwKyLoBq93D9JapjXAN6bdTn2EJgTstd
 yFDP/Xf14GUBDR9Nwi5PMiLhR5skMwjOTNKmQXzJAS/eCcJT/aGzOGgcLhIpxC+PvkAvSOqtd8X
 zFHoepmgO4Bj0IeC72DmiazSLphNUA==
X-Authority-Analysis: v=2.4 cv=ZZEQ98VA c=1 sm=1 tr=0 ts=69087b52 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=--u-uVyheMlGKQUkfXoA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: CQ7AE2dF14IKERPWgrfCxki5l8S5IJks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030090

On 10/31/25 3:45 PM, Dmitry Baryshkov wrote:
> Now as all RPMh interconnect drivers were converted to using the dynamic
> IDs, drop support for non-dynamic ID allocation.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

