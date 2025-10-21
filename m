Return-Path: <linux-kernel+bounces-862515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E832BF5803
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F51134AE44
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA22332B9A7;
	Tue, 21 Oct 2025 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U6zX7j1V"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC07E32B9AA
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038878; cv=none; b=jinTa6ACFiD9MD+EX4XKuu0ZXcyY4ySVn7eMIAYPU1c4TpA+nIxQjjmz+kabAu7qxKQR686dbbCv0zNPfRvpaoVisxY/cy9yeRjNej+cgzRtljtvlyYoSDZvwspOBtf6WnPIEG4dcW3wwyCKgMxZTHb4lXeckrA80XAisKWQt3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038878; c=relaxed/simple;
	bh=jr1ATh3mFN1Fz67pSymlfb7tA8VWXEqzYhWpbE/WI48=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WvUVL9442irh5Y9Vg2/Mj+/YpH8qr8k0vxfFzwvEn+x6MHvAOwYdl4UBMPPiOuQT+47y55g/rd34284yt5LwG1UJo3cv1ZE8OVkwJQr7tjVs6U88F/59prIOVdCXfvB1OFu9MEATsTTEVFQi+gIgv34NKbtl94lXoSkg3CA2QLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U6zX7j1V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8PMAs024200
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YfrbI/XJEDAcD/07p/XyDCO8jd39lqi6bwsbDgQdlYA=; b=U6zX7j1V/d2Rh7Ly
	2Ucjxh8n1mo7kJQssHUBoBefel67xZ9CcHRwvQB/Bc0NgvUZ0/7dtjv+Zgl8D2z7
	xHONvJUupb2liwWMk4uJX28wfPx3hiJvJeIdUHGOW9n+A9bo4P3Pcsr6UihH+Fx5
	1JWnbd5Y6zFRxqXtxXSPWmryDS+8DYjJ7O3/BMdUQdb/dxVzpk+YoGBdYMRoZuEz
	MUJDd0v7ByXn9Kis+2oFNhwqG+7MB+SC/IPhl5+lX6cRLE3PFN/DIJE1c5fGNYdZ
	hV3lCMpEwynP5+cRTeXDhlaSDOTPvxTqmMzz9kk4vRwH1drPMZWbnTzCV11M2eKg
	RL6zMA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w80736-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:27:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8906754b823so190182285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038875; x=1761643675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfrbI/XJEDAcD/07p/XyDCO8jd39lqi6bwsbDgQdlYA=;
        b=f8oaoleOjKff9GwuZwZqA3MPKLYYvmRM+cpyPtjrn0iqwMjn3sG60I3wxgpbVQ46V7
         +H2QyfmMRepUrhgodRb1b+Y0D7wUiPJg+Cvir5TWBCZVvU6FWu3h9xSlKijR1xECwl8I
         ZiEY2nJcBmN1P9Ajw8ysS5CX3KOOVFqmGbOisyimWj6BFl6/Ilf20QrmQdvf/fqOndFX
         YdpbKQ4OT1SRnLEEaaxXW+V2YZFnQsSLutHeQ9I+ocy9Y4AA8K6BiDctuUYRdlpk5KsK
         LX45sDhGDODMqB9qWHUAE/XbsNWNMM+BZljXuVFUDF9FuHysEVEZMqeBSL0v5RgOTRrY
         ajnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfBKZ8F7bQgWWmBDDfrcJLpbUqaboMhlkt60mcCMS5VYZK+LUicMNuVZR2C2k3FqME/7W16vcne2/IZVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVaJrEqfgeJHtQTgF/gihTD8eibIF9dVdPqjmlJoXelIzGvS4E
	tdhfuW2kZOiU6YvlbjgrL8Ked+uqyrQcyHWk0KcAgWI7jfCDLJMwVfqeC+SMPMUHMaL8BuaI2Sd
	HbzKxDz6ortCNuXw1zgcsaKjHM+VnMSH1HtgY4newfVbFKFF2LALX0Qf0ByZwejThUp58ffdCv5
	Q=
X-Gm-Gg: ASbGncuaQkywjHAOYUtaj/CjI3vsueKWugrk9QXdCWvotiADFdjxgsf6qZfxQfutmhP
	fpnZZ2ua/eL6q4RThRknnJeadUmgkFa9EXm8mgcmdRBGS36BgugX3xYCyTOvMe/JoP1Wz6FSBAC
	B/tUVqLauRTxl/3ucSkMnESXYORQif45zPtSxHpikqLai4+RrPhqj0k+uIMXVu/Vd9KtP5P14Wu
	xrkxt7RhDCBsAgehZxCt9CIpYdncyhvKuSjfKT3GczkqTNVVVpDsmaAm2gTGneiNY9ceHLQPL+v
	+lAccHoWPFlkucDBlTsBIYKQ8oSijcAuhH5oz5BPuBMe0jYdSA5fQu9F0rxVYl+gqAYuZh50kvU
	HXns9GsLXoCd63M5QjLIslI/hhsAUVc9NOwVUlT9KOWL2YOKDtEV0j63X
X-Received: by 2002:a05:622a:450:b0:4db:1bd:c21c with SMTP id d75a77b69052e-4ea117b0e6dmr18977181cf.12.1761038874724;
        Tue, 21 Oct 2025 02:27:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFinwYQWXxrRjluTj8cLkak6FzinIPonTbmJID/BUM56PasN4UGoEM00cUsgGx4bU/4sp8Yug==
X-Received: by 2002:a05:622a:450:b0:4db:1bd:c21c with SMTP id d75a77b69052e-4ea117b0e6dmr18977071cf.12.1761038874189;
        Tue, 21 Oct 2025 02:27:54 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da25d4sm1016938266b.9.2025.10.21.02.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:27:53 -0700 (PDT)
Message-ID: <89150929-873f-4d09-9cec-727f92572d17@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 11:27:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qcom: ice: Prevent client probe failures on unsupported
 ICE
To: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>, quic_neersoni@quicinc.com,
        andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251021040337.787980-1-quic_dmukhopa@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251021040337.787980-1-quic_dmukhopa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX8zWukFZGZeJK
 ooawPPHrQDYI3OUiymaNS4ORt1KIZHAYN1nI+wTxttuRJ2eSojuzLH3EezLHF9r7Vhiy1KyKDsW
 +6WMm2BN1qJnWA23Zde3oQfWqsYTeSPPJaXN02BQbrT44PItC00NmAp6dvz4tnLyhs8sV+LDGG3
 7M+iXgEYyA6iEtBg0NuTAi2E/sKvNzTWLSC+HCB02gCSWmAul3w6mTysqWC7Mz9POmkDqh4RbgR
 C5RqGhDylHRgaYeCakCDoZUSynUGmT08B1tXdS9DaDKINsTl1cSpl/xfLhnKIDjS19Hk2pxLs92
 C8LpRbwVE7od1W9e4oUjXgV2jmDNaH4QPh8cjDOYqhzZHTFEorNUH4iWwBPakeF8GQ0tmUwjkfD
 ecRVRmQXEbffxaLaNkZ/eXlWtjHb+Q==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f7521b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=-Y4A2yJOX9EHAnGLR20A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: cZHsQJxs7tWB5OLyI96BA7kOXsC0k9pM
X-Proofpoint-ORIG-GUID: cZHsQJxs7tWB5OLyI96BA7kOXsC0k9pM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

On 10/21/25 6:03 AM, Debraj Mukhopadhyay wrote:
> Storage clients (ex. UFS and MMC) invoke of_qcom_ice_get() to obtain the
> handle from ICE (Inline Crypto Engine) driver. Currently if ICE is
> unsupported, the return code from probe could prevent the client
> initialization which is a bug. To fix this a new flag
> qcom_ice_create_error is introduced which caches the error encountered
> during ICE probe.

Probe currently only happens if the ICE node is present in the DT and
referred to from the storage controller. What does this patch solve?

Konrad

> 
> The qcom_ice_create() and of_qcom_ice_get() functions are updated to
> return -EOPNOTSUPP when ICE is unsupported, allowing clients to proceed
> without ICE.
> 
> For other failures, such as ICE not yet initialized, the existing
> behavior (e.g., -EPROBE_DEFER) is retained to ensure proper error
> handling.
> 
> This improves error signaling and ensures that client initialization is
> not blocked unnecessarily.
> 
> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
> ---


