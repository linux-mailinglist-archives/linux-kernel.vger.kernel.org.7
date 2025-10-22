Return-Path: <linux-kernel+bounces-865602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00859BFD873
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6EF6234C69D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE36286D5D;
	Wed, 22 Oct 2025 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EVWQCw0r"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3F286D40
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153582; cv=none; b=aEG7VjzRMemklDgHcH2G889u2+13YftKrjeB+9TQNsnYHmZyx5D5xyYux3CUlrhCvP/wZLHn1tfS4hLaZRe3OYZcIr31On+am7Ni56N0U0JPvx/6iW/DjvhIPkjQcA+JrkoXXZM0VjWAZCrqh1fFjxp23u35/A8bx+0/PaXc+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153582; c=relaxed/simple;
	bh=gOQwJElKrLlL+KczaQjBEU0WOC+y5P4gVQMiGU5ncQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ca6T67DQbAiAe9Isqb9Y4eqggrGAymXxlKQRJQPU49DibfRai2WunQ+0m2yeluyZqfiMUd+Y61xiaMbLWriSdMmuNiFHxbu//5/+BH3fsB8NZoceObwMxDhJAiaDJ3y0Ccj6381Gy3hvbOH+rXUKa7RNJ3bYwrYJFGnmKIZwrUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EVWQCw0r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M9twkZ018880
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1ObhDx2qKilPXrpU/ecszP1sikcNLUfUe5WUKxrKas0=; b=EVWQCw0r6O7WujXl
	Q7FsvceaN/p+YMzjCUZ4WD3SMhwUnWNjLavMDJ3l1HEdHNImw46Lpo7YhZKWXwiK
	Lu82CGQH94Jqkjr7o/2FhaU6kNo2EoZHdxgW/bBNdHUaTlTX2U5Vpiodr5iYZs2q
	EXPAXYvoOek5eCLpZRicIbRByJEvSGhdCyUSfBT406E1TG/oQOGRH6wwiRiR874j
	5njdBEGx2LmXDej1Tw/mpNx8s9fA2px2uPk4uh5RiAe+B94TU8W2RxsxMJwdokkx
	JtAiH1W7GYHoi2W/g3qz4lPTdvoUHyTkb7o0ATLTSKQ0pIpKO1oIHBTizVYyiMGL
	0SjH8A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469ng3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:19:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8934ae68aso5841821cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761153578; x=1761758378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ObhDx2qKilPXrpU/ecszP1sikcNLUfUe5WUKxrKas0=;
        b=WB9lS3K3UwM6BovxtUM5edGpoucdQVrX5R9OVdogU3GySkFNswPANAR2Gpbby35Kiy
         yl2RdIz6rYNFc6g56l+G8huWIII857vUNTwJIjFCKuo339jBTelDjMt+sPSuRQrmvFlU
         beBPE4kTj3PXl9lvSJP3qLNCPey0upO+0NqfBAZr3S1SEgicZYiH0iCaA7WNFuwmBv0t
         pCl5Q3NVV3CkjGSmQ4z29866R7YU/8CVC/fUil0knzbmia6jfaXJekcCQiiNwhY/rGmk
         /4TY4H/6y+GKZ71O5CSSKD2fB+mhk3b9e9HqgS6EBDQD7BNgurTod02MiArv+UOj7qnK
         fk3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzOz/GirQrjQHvDmt24Lguu02pCcYoZcJDQJKs7W0LYIjLoSUBFOzT9AX4xG4CJdTeMZg3WgjkmVZTmwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+S5XitLn5kpVKqZOwc8I+yvglM8h1I+/zEm7RkYPRgzNKv8g
	urueFj7ZRjqg26gVINj/rf1o74ZYGemNw4H+2WPRSLU6HTKYkvPEnRlmKyBpEz0kJOp/8x96Pqk
	V0+wRwmNhPMCotBVG0LEZiD5C+Bp4u8I2m2TlWSjQjdpvS3us7L2WASEvNSMs6IfJ964=
X-Gm-Gg: ASbGncv27OjClFb9hNwvu99Cetkxz+NXk+ilwl1Hz0SL5cheZmxyonDZDEcR90VmNBI
	MVcPRZIK6xVW6X+QFsPPFfMNtMCwytj0a0zKJj4K7PuQo1Fh2c4oDeen2s14Y8mDZFrkfZOk1qJ
	3FppzpZxLB+oh2Vm/qO5unePlK+WEB3HjWc9361zarU4Q8kZZTEt0hP82AoJp9ALMaD+LcWuihb
	lh0s7o6R6HFQxSpUUoH4/a6LceuGRaDQK251PLIyYgDl8eHPHCZ/p99FCu/t+PoNya8aXH6zufe
	hmAJFzyDwROivuxZqdfoAnc0b4y8R7JMnI8nJnNXPwz1dvdRVser+MRDINfCFYeNwJbqdKIytKo
	6TT9qu3Tfx7iOcjVGRDcWd8GcOfUXJB7XbaD2pvMOCwpuOVlGqv8jiebt
X-Received: by 2002:ac8:6210:0:b0:4e8:959e:440e with SMTP id d75a77b69052e-4e89d35aecfmr132575371cf.10.1761153577576;
        Wed, 22 Oct 2025 10:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1reHXf9fw3+r5fcINDoVpcwTbqNCUu/7wsWRAFjR33coa1mmho1pVdqG0TLpKriqCc6KFvQ==
X-Received: by 2002:ac8:6210:0:b0:4e8:959e:440e with SMTP id d75a77b69052e-4e89d35aecfmr132575051cf.10.1761153577093;
        Wed, 22 Oct 2025 10:19:37 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebe4a5ecsm1389504466b.81.2025.10.22.10.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:19:36 -0700 (PDT)
Message-ID: <32702920-19d6-45dc-bf1e-8a90b1b8c9d3@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 19:19:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: qcs615: add ufs and emmc inline
 crypto engine nodes
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
 <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-4-2a34d8d03c72@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-4-2a34d8d03c72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3cJwoZTTQOvnT6wgSFLLsz0dFj97qLay
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX11W1AGiypbqS
 fU2JXYucplykyVMFZX2IdhbOetrs1jmHyG7F0tjQkIRr+sub/BVt4ldEYPllOQJ2A9XOx5JLinl
 M2NjxN2L834ePeVQDB5DlILoI7ypnbwy0HRtevEXv96JXkXvdEafNgGpbQenOXEajWgYtlKzD2f
 V8bdedzvyCgU4QiFvb0sJMuOVcoKBW4TZeyB/FL3Imo7QAXY/thTwBEVuOgDeFc/j4WYwjeN89r
 4ybIumSfMKdMc6DsWYpXIDEBo/Y61YzRoqQQfAt1gP2c7khvLO/RAx60LBsXzjCaR8rAoBw+yR9
 dmsfhVVEEGN6025g0iCtDxYFDpj/sGp4uVYVRYmaXWYa6n3wumGyESNN8r/LvQ2OzvMhcu6OWeT
 InWDVy8CPyReqYdyip6gEoqtKVbvhg==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f9122b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=FCLlhkshBCn6XtExdV0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 3cJwoZTTQOvnT6wgSFLLsz0dFj97qLay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

On 10/9/25 8:18 AM, Abhinaba Rakshit wrote:
> Add separate ICE nodes for eMMC and UFS for QCS615 platform.
> 
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---

The commit message lacks a problem statement

Konrad

