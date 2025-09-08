Return-Path: <linux-kernel+bounces-806303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19863B494D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B05844E1DBB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA9C30E0FF;
	Mon,  8 Sep 2025 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nc4WM7+r"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E87C2B9A5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347791; cv=none; b=NbQIzLc8LwBiMv/di+Kn/p6vr0ox23F61+aClV8KoA1qI5oQx3qx5bzqEP6cIbV7hSBTDGG5W0gtqP01+YC6OspxXGpXHLHZcb521ZpJFW0RXqHii/4uNht9fTKdK8W16v+4dg/ZoiaKiIPRBXuB5OKP5zszKnpzBA76mqLzjMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347791; c=relaxed/simple;
	bh=ubWdoPQHWOLDpJjgP9VamsCXUKRL6blwyUiqfCr+RMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfpAa7PkwXDv/KzPn20PMeMVbyv+EJzaS4cM+OgMwDtbNZ23II2dgHIbQuND8e5izSY1iz2vHfdJHNLtKMrFasjzYCNcd5TCjJIWNVFidH1TdGkYpsBZ3cappk8oSZ/+HJT0Rd0Q85S9j7QR+ztJeg9m9HfrWMlAk1SHNdiRxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nc4WM7+r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5889jOcq008162
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 16:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CoUaDuOr0Aeqkj/4XHl1iuTrcEJpXOBDJljwriwNMQg=; b=Nc4WM7+r5YAV8P5n
	N32xQYxdol1iNduD+wLaVxRRACWnY9JFJ6LLHaQVciQKjk0WfkczXVAAzjVDrqET
	4nVoe3SR64EsEmXWPfnJ5H0jN4LN07anEG0rC4Y8npb6WnrmKyapzXPHxLA0Obny
	LQ4lKEmmjuJ0sqDh7dRNIzjvBIO/BixzdQtGfhwQK5+EjvkeEHRFzVonAJyM2rEI
	10U+A/rFJNwVtWm1ldOMW4azMiv8irhLapeQCFI5NwZSOqd+FFJ9n3XbwS8OCqi1
	J9N+h5GCRC9sZ9jPyeAjptssWM2TFVQjii2jhlaZtV9oT5UFCcPLZQapG0GWdWRP
	egMdnQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0n69j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:09:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5f92a6936so10115781cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757347787; x=1757952587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CoUaDuOr0Aeqkj/4XHl1iuTrcEJpXOBDJljwriwNMQg=;
        b=FW/IAb+19HqoC1Ig2FHnjVaRUyNh6Ni8yesOLyNQpVbsaRch8e2gcaLbguqq03W9/Y
         4LpvR+J0hhlRkpZpQ+MDaPJTEBdXWSXYUcxqEFsAQMeSHKUmiHR7DmtEIj+HEzu47Fy+
         rm59q/ApYUZmSGNjofkIXCZrmYwYkaso6ourXxkUMvucCQPJdCCV21Z+LcCib6Q4Y48V
         IJtlclywlguBSQFKCOwaKXU9RCZi363LboSpbZ1PbsKN/HLhb09HoasT40EMuV8L/Wgz
         5fog5cn+WiTkPc35zXrmw6NeJc55gqxH0ulyLtol9J2MyQgrdw1QHcPwjgw2RCwH3Oaz
         Zh2w==
X-Forwarded-Encrypted: i=1; AJvYcCUNKWo1GhSMN5Yj2YM2eaX6ouyYGXovEZsbphuJLzqGMbj35ehar9AwmSzErgKPe4luNkt/nvdKIcPJkDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyowCeOhN9iJyl5MQU5g+tUdt0qAR4TrPZpp5ad6HGixsp/EWP0
	yG8SoAawi0d7OQnVnkkie83/uVT9nESuGpZgrJ6bY5BCHN7kGRp25iJ5Y9onuFQ7MDCZ7NGRWeL
	YSU/NTjfVP0ymB8cRXvywoGyCwpA4GKHinGclJ1PClfNGmKOjo9YWE5QYZ+RGhZYXwA8=
X-Gm-Gg: ASbGnct42jvY2tiB0Mwr5CSw7wcV7PIBaf7sRQ08LAyuewYN5ZMFX5a4LRyySPauUS0
	GFn3mw1zm0xQp3EqVR/uKKpPczY3kq4/7SImu6S/5+6BYwlsDL3vpUIf+VUqM7BZF2uj4vHuJDm
	5jwZBi9RfuvZEiUL2pFSnDrnrYIK7GwrZ+wF22+BfcdWmslXazpThJWDyemRSrKXyAJZ9EQwSxP
	InrRV7QhtEMq5Hmtvy4BAK1G8dNTzdUDU0ntY4ECNpVfkUb8ekvS2htLNESQzF/wC5asIePH1B1
	vxc1j+OH+w2TRu92GJFAmYj85aeyu9iS2zav/rGdqkfl8LSsjLlNijYys0SG2IIum1aV7U2mMbD
	EGIqFJoQlH4/QP2QnZN0IiQ==
X-Received: by 2002:a05:622a:587:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4b5f837c266mr64567611cf.2.1757347786597;
        Mon, 08 Sep 2025 09:09:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKp0kzn+Vp02fMPwlJf0k2yNql13pFOExJFPIqquXqfbLcwld8IobIzG+7YJra//PBsHnvLQ==
X-Received: by 2002:a05:622a:587:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4b5f837c266mr64567221cf.2.1757347786096;
        Mon, 08 Sep 2025 09:09:46 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc579ba9sm21968793a12.52.2025.09.08.09.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 09:09:45 -0700 (PDT)
Message-ID: <92123e16-d98d-42c4-9dcb-573dd7eb1973@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 18:09:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sa8775p: Add CCI definitions
To: Wenmeng Liu <quic_wenmliu@quicinc.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, bryan.odonoghue@linaro.org,
        vladimir.zapolskiy@linaro.org, todor.too@gmail.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20250815-rb8_camera-v2-0-6806242913ed@quicinc.com>
 <20250815-rb8_camera-v2-2-6806242913ed@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250815-rb8_camera-v2-2-6806242913ed@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qC0NWc3KnvOVyw9QdcW71QZ7oWyDs0ke
X-Proofpoint-GUID: qC0NWc3KnvOVyw9QdcW71QZ7oWyDs0ke
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX9FByhdtayURN
 eIsZt6gsv9ZFxz33GNeiLQg5qaa4ST80vSgoQenLaxDU6uTKAw1iS/BNasESvlafklli9kIpWRZ
 Jz4MoMZyWRvkdxThK9X7pKtjKUzDH2HKxbsoaJOdpyUqLiID1a703mO357ONtea35UEEb3al9iA
 hu60CXeZJlwipb9ze0DEec/HkCEY7kCzfLyjub0dZTVCWJ8vi2un3oqsU51G2XzjO1zdiGzDJp5
 6JLoaCHK42WnVe8zaMq0n9zzh4rSCUGLhrsSqsUiYTfIWwqtWM3HgrlR+2VVFCzEPVugojP9m1J
 bt55DPQ0f/zODHHAv3ntwsgstPigqf4McYCl/+MNODxVGJL9aiFAM5RfCSpcWgdysrxmvSvII6R
 S5JYa8X3
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68beffcb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Is5zltCUzCQjwDH9xFcA:9 a=QEXdDO2ut3YA:10 a=kxpXfmk2mFwA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On 8/15/25 9:07 AM, Wenmeng Liu wrote:
> Qualcomm SA8775P SoC contains 4 Camera Control Interface controllers.
> 
> Signed-off-by: Wenmeng Liu <quic_wenmliu@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

