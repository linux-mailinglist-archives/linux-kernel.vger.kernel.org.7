Return-Path: <linux-kernel+bounces-832349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7D8B9F0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803BC3AABAE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E052FD1BA;
	Thu, 25 Sep 2025 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ghK7Gy6U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140C2FC864
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801363; cv=none; b=IIbaURExKsyKDqV+Fp+bspTkxmffKXTVH6WkryilVDymmVg2faGwrP6dLvONcsDDkfJJJDTJIJ6a40joGXvU3MSVgSD1oMv0ETj23p4qsQHL0jEbMKQx5z2n4Im8DE5B8wfHKP/f/7NbCj0FzxOg7iDSIL+gTOZv8WggVFmNOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801363; c=relaxed/simple;
	bh=yl52+8t16PBY6bibfVojwBzJQIRHVSQe2DfRABhpTfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXT5s0wSY8euXUFc6Q0n4YQto7gly/vKj3p8HOYB6/tCxiTA3CRuU0LiUW8yW7bOUAJhJ9DItidwJ2if6sajWbgHBdWVCfItNyWyrUk54Q1NNXOB43MK2CXlZWGw1QGGWFZIAXIZaRjkrwHOk60n2GXf/xCjsZ4J8+N/iqk/Mfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ghK7Gy6U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9l5s1029974
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BGho4vei24vHpadg3iVDOtkY/sdrfcEeDXVF20xwVL8=; b=ghK7Gy6U3dP69nus
	K1EkoylRUWcWiCXq0RJWUTUIDslnKTYIHtym5SsrlCV3DqbpJ0wmWG+Qwox+Rkqo
	RYHN7hqkRRN0CgBNpntNwi4aqvODBgLrJ9YOjIYqZRZvSWzL8cLJnNbbS36VvlzJ
	Emq8L3BY1a0PDv2NF3CvlLZbHu+MxBTVzEz7tSbBUWepAP9McKfal87L3qLf3yyN
	bJ5B3haiQ1PHNUle9LGPf90aKlFbeRvadOQLjp9ZcDnyvee23rnt5jm0mzWKbnR5
	t4ms2exDANoscV2QbpvVNnGKKtBtDa6zHwFDvhNgu64wwQ6Do9ARbw48SbsF+eaC
	NXjFrw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fqudt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:56:00 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7cc365ab519so2171656d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758801359; x=1759406159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGho4vei24vHpadg3iVDOtkY/sdrfcEeDXVF20xwVL8=;
        b=RQ2NQEBMd4YHONPCrEdmBiTYIAHZPydcf9/bZWolslgq4Sx+HlhhadgiGJkjxOtfM7
         M/cjj4aaZEkHX8GsqegEY0Ll6Avnfv0KB+eSEPQHoO5oLHVtSHPLg2jhV2CqqbWMpv/N
         DpcaCthw7JtDQtPI8suYe5cVoD2OJewNzeY9Wk+6VAMKD9DssisRhdjPZeQFx2wPP++E
         K4+KA3bztaTMxrK7PD24pXMajC02d8t9FfwDyqtF1myefGX0NffKvMNs2hsYVHVmvXil
         zqxXcPSjtn6jTk5kkQcThRPW3ohSNo3m5PIRO46tERfgaYcwO9qEgU62tqST0Zv0MVQZ
         ISQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3DOly9zjbPc4Z9DLaXk9fKVctIMAUKJrE26xIQK5Af4oC2a+BcitRc3VbaZvPv9QlcRSgYan29Qm3o6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMa3PTOuoActcUrmPbWt1Qt6i1iruuMN8uRJKCh5jEDM7tImFj
	kSWVMRvfXFpes7rQuYpKxuky1ICmuntLpejycp7Awv4gf7wcXr0xi2BS0BT6LlpYMPSgoOPjAPr
	YD7HiepH1Iq1dujyP2z6bvQySAEK1gioo1P+6n0tG3rPwazwPI2w0Uj39KzK+tfMXIC8=
X-Gm-Gg: ASbGncsZ6cMhA0e9sWMLBDAvuV2EtpWar39TDh20N9siGpZPurap4+MA0L1FzFKv80Q
	Em0S5HWKM5EohYBjLpHeHbGo5C6k5QYzwg5v3ktr5OCymlklgwt9xe7WRu72O0TfnoF2/7EhG35
	tHXTAKZ4dxoypI4LR5AJQLmPKZrCMRcE1L4E6Eh+9/VIMjL9C8lBO8VqXEzUayNFvVXJdMtxeIF
	SDgkv7i8plJczXLPrKia4auBYQO2DKGOkBDY2kcBBYJO9nc57qmGpDKvTWKhx9WimlT4F0iBS8+
	8Ip2iajmGfl80v8WZn40jCpolMVIVObo/w4MfYo8plv2qAQ2unKhU2dQUFovlJe0IBkMb+x0iIG
	cqJMcZyl6b/uzw2D4Pxf0fA==
X-Received: by 2002:ac8:5d08:0:b0:4d7:9039:2e87 with SMTP id d75a77b69052e-4da47c063ffmr28296821cf.1.1758801359244;
        Thu, 25 Sep 2025 04:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfws3DHjZ7NiFj2AF7AaqOeOE+RAgqdSMayjchEUwDWrTLQ8HNN+0mGYgmyc++RfEn9OQlxA==
X-Received: by 2002:ac8:5d08:0:b0:4d7:9039:2e87 with SMTP id d75a77b69052e-4da47c063ffmr28296531cf.1.1758801358755;
        Thu, 25 Sep 2025 04:55:58 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d168dsm160195466b.4.2025.09.25.04.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:55:58 -0700 (PDT)
Message-ID: <ee4f25d6-d04a-42fd-8b72-6b272e750b9c@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 13:55:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: phy: Add QMP UFS PHY compatible for
 Kaanapali
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-ufs-v1-0-42e0955a1f7c@oss.qualcomm.com>
 <20250924-knp-ufs-v1-2-42e0955a1f7c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-ufs-v1-2-42e0955a1f7c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: PHRqR0CMj3GkBHtpRXuW7kIY2OKLOlT5
X-Proofpoint-GUID: PHRqR0CMj3GkBHtpRXuW7kIY2OKLOlT5
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d52dd0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=mUVx_TFFIgGiSlsxcIcA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX63G4CTvLip9h
 s3lrvupPZhdGGwx/cOEUW1U3jW5qBMOGjW66a0WwW+FtsRSuooFaYd0aImtF5fLQJ3dGMpQZ/vI
 0Z4smqxr+qfbpTP8vpppCRyB+I/kF8tfW4TShtOlY90LN0Sw2YvPsSdSUCgNDwIHOxngsZfpNUI
 LyoW6UD81o+J31ruNkM/gqSRQTa/PxwN0Q6uLOf3WLMF+0cr4JLwvObiawUIf+mYoWRo3not5wb
 xBUBQNhZY23DBjUb6aynagJnHRS16Ev4KamDbVBlmB+G1uN1sZRO0u7Ux32H8td5OfYWkUmJ4Uc
 wrCWXk3TKZDm/FamVLTo5MOzinVismQ7SQ8LKlrkguA+1vAm9fQ21slDqa3xtdyFc9Pfur9XtWG
 zmogG+W1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On 9/25/25 1:29 AM, Jingyi Wang wrote:
> Document the QMP UFS PHY compatible for Qualcomm Kaanapali to support
> physical layer functionality for UFS found on the SoC. Use fallback to
> indicate the compatibility of the QMP UFS PHY on the Kaanapali with that
> on the SM8750.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

I can confirm the SW expectations are identical, down to the programming
sequences (mostly, there's some minor adjustments that MAY be specific
to 8750/8750QRD, but IDK if that matters or if the docs haven't been
updated)

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


