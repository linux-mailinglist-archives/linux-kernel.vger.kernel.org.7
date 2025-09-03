Return-Path: <linux-kernel+bounces-798738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5FFB4224B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7F4541990
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8152A30DD34;
	Wed,  3 Sep 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UH1qtGH0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EE830BBA4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907016; cv=none; b=Bs0ckC97XqsN++BRhJZm0+KLyo7vuiPMIY8LO9c3EgThPxHbdRz2Jmb5qxMgTqcy2E9yYxd80p8xSHMBhA1Uea4V1jlWzp1g7sIahNAurp9ocJwiRtloaFmfY6U+seIMPiyoaVxTP9q8b0na+sacfsl4lDLwVl37Z69O9/x052M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907016; c=relaxed/simple;
	bh=J2saHSevTBJMdQGQ/k91nD+umoYJ0UhFnd6gQFsyAaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxZ4Nkb/gaIdvz0HCfQm0iTN/qDzwU28AgM6xtT8B7kS5hHbPJAIeEWk7j+W54Fx72SIZj4Mr5/Gx8dmjrJkfbKRroUyc8EuJJzMyKs6kVGKYePJ5KimUGHqHZIKTvIQxwSusr7OrtXI9kI5FnluowrB+ppG8hvAuNKPkifIH3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UH1qtGH0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BExMk022966
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 13:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NhAEVb6Y680w1OtPE9Ykdv0IK3xbZmfs2ASBVN73JdY=; b=UH1qtGH06F5VANyt
	SwvNUMngVUmItbvUX8SL9y+hu362Pwrcw+SUtieT+429RsloOLjAVd2akdLzqQOo
	iP1mPbKYoX502uz5pRx3YdugHFLOFNt3j19T/ru9nHQ70AI9v1UZPFKqli0mpK5H
	kmB6vHBq7A1iEnhja5cm+j7e+A4Cks59rW2EbdsWV/+H0blYVR3ElttLP4ZRzek9
	ptkTlctmEy95uyZ4SBXg1WBM7vfzECknh028d7FxTNqpE4EurBnLdPe6gY/JAJH4
	cZhqxxuETUnwg3U7hxALCgMRGmQgt8mKa05h/hz0/o2c5OaUw0QQEipPih8JSJ96
	HHVZ8A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0em0ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 13:43:34 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b3ca5e94d3so3831631cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756907013; x=1757511813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhAEVb6Y680w1OtPE9Ykdv0IK3xbZmfs2ASBVN73JdY=;
        b=Y5ogIJczUmWFci+fO+Ew2k7YHAaPO2xvweOR3Wu19iTUAgBnJbj14pN/bL3bpEaBdG
         PZg4DBc7aWVQ11IeTBMJ6YT1087tw5v6NMVvTXmmv35yv+Bj73EDjWmbaBkaw3IOXsc5
         S4jWB3rIKdPq83Q41mNscb/R5RXH1ObwWjqkeGg8cWY6OFgqb1R83wYs327XC5n1utq+
         +UpFUImUSfM1UjBHC1Sa3cNSW4bgAH7DC9U9Xqdc2JtDMggAhioVEoc3bi9y7y5mTCNT
         ygumGv+nPWZoiOjB+lvjoml/jNnaZjX4yFcDNJhwPkB749ctBQaU3jAtknE8I/30tNVe
         dMjg==
X-Forwarded-Encrypted: i=1; AJvYcCVIkS2md8Om88ziyXBK++DEOfRRuaDhaP2S5u/ANPVj7o5bR3GIekkeXMdYa6BnV2p6gSbKrtcEmDfm6rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6nHPozPsmIPmmVdEYXIEor+PXCtqrhZgQ1G/gh8Np0ILjGxMY
	RuF43ABcQAT8onPeb2Iuo3cae7tvUrIaZEZkO+WubKGjtakoBv9KoF87HMbmrVr3cKYulQyy6ya
	w8rt8wrqwc1Dt+zwFm7TqPmyHrt9Z91Ed2OidQI3Qk+j/h8sGyOc1XZ4yGxUQuGnutsk=
X-Gm-Gg: ASbGncuwiocEgQZrIpZYN6Y9NeBKuIZEyeah+Fqsgx4LxvgTD/eK3KG11bXlpQ1Ya8s
	Jzi6i0Ba7aIS5JE1LiiLCXcL/ypFypRFPinebPV0RR0JgQy2gQ0eZHX+dg+/ln2+fzQYhaZFl5A
	1H5n7Mz1KgSR/if9X55Fx/O3bWBJCZmMZm1H1jnnD5/dtkCvGqG23LCK68mbhcXE+JXnIulGS7O
	nvJMBCREp+vw+Oi4hbMxQf8pwPYVHTEOA8iQMYfprsL7To+c0bvcd15gpnNFLyB22iMj5QbGvv4
	8+gvp9aVZ0/ui+84hepS0IHrPv4gpznHvQrDVWL9R7RsGySaZQQdJU5mFFSGfQmSl+YpHIMw4vK
	3unsevgIgF9dmXAiqG+xYRQ==
X-Received: by 2002:a05:622a:1b92:b0:4a9:a320:f528 with SMTP id d75a77b69052e-4b313dd0270mr155416961cf.3.1756907012996;
        Wed, 03 Sep 2025 06:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF56Xam6gZtEwPzJFWPQ1ApnzKwNAHz4Gphd/ZewfD8xSeb5FB3EyFo/YQ8Z02OaDwf9p54/g==
X-Received: by 2002:a05:622a:1b92:b0:4a9:a320:f528 with SMTP id d75a77b69052e-4b313dd0270mr155416621cf.3.1756907012428;
        Wed, 03 Sep 2025 06:43:32 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046eb335f5sm107990666b.28.2025.09.03.06.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 06:43:31 -0700 (PDT)
Message-ID: <7a43753d-a0a3-4b9a-829b-5a997ce46625@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 15:43:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-qpic-snand: unregister ECC engine on probe error
 and device remove
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250903-qpic-snand-unregister-ecceng-v1-1-ef5387b0abdc@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-qpic-snand-unregister-ecceng-v1-1-ef5387b0abdc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 89X3E0NZ0yrgJu64p3bX7pXivjGrFE1C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX4Et6uwE7A9lS
 ABkFIt2is4y4j2+Pp+iac5iwMVb6DuhMjuv56NVS6s9XTz8N0raRB79d97Ads0AG7LrJtgiHVP7
 /ceQgDgNTORZBbs21xKmwjHkq7UTfZkSpJOC6H1+vWCB88iPPjgw9eAbMABN66X1lph2UkW/4IL
 +WazTVfxQaA2YM/xp98ePKp7YmLoW6yaDKr8Y5VMsEbwfEdF8xA3U2xvUSXmYe6BCytF13+4KU2
 ylhyMhGnnN2VIToBzksy4KNAWtuTUw+RecFy0hbeJLFV5xz9mpGW6WmrHr4babWth3Rxfz9lsgL
 JI6AFqnUtxDsPoIkdynCzEBwXz71Yu+9OXopAOhwBpaCP7XaRmgi6cO1IyIDtYoEMLVkxG4NY7u
 l+jPYpp4
X-Proofpoint-ORIG-GUID: 89X3E0NZ0yrgJu64p3bX7pXivjGrFE1C
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b84606 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=MVN0ImEU2R9ubr7hOacA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

On 9/3/25 1:56 PM, Gabor Juhos wrote:
> The on-host hardware ECC engine remains registered both when
> the spi_register_controller() function returns with an error
> and also on device removal.
> 
> Change the qcom_spi_probe() function to unregister the engine
> on the error path, and add the missing unregistering call to
> qcom_spi_remove() to avoid possible use-after-free issues.
> 
> Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

