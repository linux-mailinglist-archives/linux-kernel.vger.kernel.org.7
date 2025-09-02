Return-Path: <linux-kernel+bounces-796388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B70EB4001A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6C05429FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F51A2FE59E;
	Tue,  2 Sep 2025 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wzt2ivyg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB7C2F618B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815077; cv=none; b=JddGDA7Xjjh9DBEfK0gHJyC4h/ORMkEuagbIegySnB1E58tPkJ4y7SGOXDrgj4O7SszmyzBV1BKfuP5MjagfTwKRskXe61OxoTMTajAKGw8203hDExaTxzYImEOXGL9T2s713QkiTr4QEWXZcE093xjw0Xos8BPI7c4a0/iOYBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815077; c=relaxed/simple;
	bh=Q9xhz7InacewkR2sL7hxMKTtf5/Apj8ua9YctrXUMkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsToSf5c8htWfewOCObrddwddJOFBsWHkVXkhvY+Z0M0+a8lLZLPYOC3Bwxif9ILdxTnDQEE/LMjFSKFdBkW+70uUg5pzo3eBGctdx8/ROZVxiVGHq/QqS4Nm5FOuARXgjebSYZXF6h/HxEYqCUEKWcLLdvGKLFq9ZKO+RW7Y/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wzt2ivyg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582B3BrT025567
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 12:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4vrt0A6ANjc79IaqhSJY8cPh7b4X0YAYPY/tdBRrzog=; b=Wzt2ivygiUPCUSwo
	BJAREK+B3YS73ADn7xyrkA3+Yid4oH+u/ktvtdOE2h2Aqx7mOQvkPPDlD6icrrBG
	8S9OW/8/QvXUjbtHgz39CKUw0RxZSjXRqA5DAMW9zUkdmOR4kMSEu4CQVKMcDxQL
	YNw2ENT48z1OpYcLawqx/abCCZksctaQ/99bSs7lkAqi+RDh7ajNPQ4E/st5RjgD
	RcKslF1kElgGzipF2lbQaJ5EUcMdEehlpngPrqnctql7iLR2r0oVhQF+QbHBQowl
	cD12I5MpBTvQbz0xvmgi8fcKmPSvYaqak+HBgFOtdKQwOhENbIiWtavOo1N/T5UT
	ett0MA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuyrar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:11:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b307e1bef2so14332571cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815074; x=1757419874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vrt0A6ANjc79IaqhSJY8cPh7b4X0YAYPY/tdBRrzog=;
        b=OLkXtr4Eb9xYaK4hGaZRmeLa/ZuF+8cfPuhFYtfEupJB8nIq3Pp1+5Fea+vTtoAQH3
         /vKoBie/U1Hx6VYJML1lQoku6DxhMg4nI6Y6TNyopjqu6CSEXnVPNGRxecFqJIPi+80i
         O41zTo4OKfNjL13+o8LvXijMTKG70N++8/ewC9WIhXJwyxbtKO3lyJkaRGqwJgIhOTyY
         MXpQeNam/KnOIWwvVUs7ntA2Mk9pg9n6IQArnz9RtOLV/2sHbM2kyqr1kSNsA0MlzndQ
         E+oEvIqNd7L27jDAjiUOUX85hrWSzQquWsPcAxDsGLgtohgla6hsrZmpyM3TROtWtR+5
         C8rg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Z9LsdJG4qry+EVn/olBzCHHKVPIAx/g6T4ks8yg5TVkFmlXFYAE6oA7BliyVSxS0bkDgnx7c6ACpJ2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZmTV4QJYnegFT2HjDdJrN1NuXwMqg+Be8b7wOpH8vJGQ1MOZk
	iajR2rfKVWsSHEqhJsSNU7OFDRODcFEC38GmVHtq52oOP4w163SeD1y30VRnwQGOvTTfPzPCt42
	jxfZxT+Ub6qTV8vBER+sZRg+YrKCrN9P3HI6vHfwkWY/7uo93EcPUGVpimngz63jtqQc=
X-Gm-Gg: ASbGncvGZLwifyEofXKtILXac63KRNPlAvk2ue9DHMd4SheqnNoDJh+bFbzWjJVMhxl
	cP1PdXmwDM/IFmYRuqf8QwoeRvjTqQwaoHF+H5a1YjYXwobgxxQ6vylHvInnnn7Sa8jUIVgzssO
	P7DsppwN5XBvJpo8I/a2nPNXaI4Lzjc/+TEZgdlRVRA+NLF79KEaraOawQxkNbW0WezCSR97qFN
	/g5smH1c+nq+i8fBtd4/X4zrPctxjXyjBKOf5dPWNS82NR2bpBRl4IyplDyz63KEppUHntSxVHR
	bpGnA800BQ2G8fcCUJ6gJXoup0PFwQsLbpodAwzc++x9Dw+Q95o4FpWkIayVjjJpXG08V1+ueLr
	JwHHuK86YuAYzAn77EAt+6A==
X-Received: by 2002:a05:622a:241:b0:4b2:fb6b:38c2 with SMTP id d75a77b69052e-4b313e63155mr114514391cf.5.1756815073725;
        Tue, 02 Sep 2025 05:11:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3KfpCYj++Nh+x6sT1ov8IcNZd1mz0M6lJHlQz2dAizYJPZViCf3FEA46K+1XVLTY1Q97W+A==
X-Received: by 2002:a05:622a:241:b0:4b2:fb6b:38c2 with SMTP id d75a77b69052e-4b313e63155mr114513821cf.5.1756815073082;
        Tue, 02 Sep 2025 05:11:13 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b040f1cf4b9sm698003666b.29.2025.09.02.05.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:11:12 -0700 (PDT)
Message-ID: <b2838f7b-8da9-434b-83aa-fa117bdb715a@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 14:11:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] clk: qcom: gcc-ipq5424: Enable NSS NoC clocks to
 use icc-clk
To: Luo Jie <quic_luoj@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
        quic_suruchia@quicinc.com
References: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
 <20250828-qcom_ipq5424_nsscc-v4-3-cb913b205bcb@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250828-qcom_ipq5424_nsscc-v4-3-cb913b205bcb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX7V0EPYghh80o
 f8Xxc79APi7zWuS5QhvlPzVyEAn1EkyLK1yTxGGuWapYsBhozZTAw4vXJBzqwa9mhEwomI7Iz69
 7SsbUghuC0T01MiFiD6YvHuw08+oPbyyXHm2PSOJjWJwPY1PO1+E0KoYkddBYcuA6LxzhRjsroY
 l/RQQNK23cOuU8NDEcXPx6fiRUXJM+hDA+dsNYJwKfTE+fTA1ipFhebkF0YpZW+rwhZGfD0inu8
 gr7SAt7nzrW3lZ2QyjptBGy9oSaUddSawvlWHrYHo3adc5DDrC2hH1QjglcU8hfqkFiBMi+Abzc
 AvKiF5v6v6LfxaRa3SLhiVr2L0Hept7p8F6RIZJ1mNAOC/bgzF6x9HxVE3vk2DKS1qNlOaeTMwz
 lPpYaI/D
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b6dee2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=DdE-_dUAR9VioeaCo_UA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: v-zvToDXfw_eGzgs6HVAyQFwhPmHjZZc
X-Proofpoint-GUID: v-zvToDXfw_eGzgs6HVAyQFwhPmHjZZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On 8/28/25 12:32 PM, Luo Jie wrote:
> Add NSS NoC clocks using the icc-clk framework to create interconnect
> paths. The network subsystem (NSS) can be connected to these NoCs.
> 
> Additionally, add the LPASS CNOC and SNOC nodes to establish the complete
> interconnect path.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

