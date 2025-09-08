Return-Path: <linux-kernel+bounces-806262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E275B49451
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C73D3A3D31
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FA030BB86;
	Mon,  8 Sep 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jtmoeSZW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934942E8E11
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346871; cv=none; b=emH24dhFcp8QRAeVZ7Q+fdXvLGQX1vrNQ5+AcX/f0bUgMAwLx0DU4kPrBpj1QtxXjSRxfjjnpsBzMMN9dI2X4Ghw6ho/Pzub7godNlIBsGvditUkJe/bBU4h7W1SqgcshKkGEmyLs53P6aH6gO6QAxpEXxDewKbPZdzsUqBltn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346871; c=relaxed/simple;
	bh=I98L7wVl2WaiGNwfnBzveMZ8tRbwqAhF8X/Pp9rmIF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NREq2t1VxMrZGGJl7dh5LQudLQsfAw07CijnMI5m/qAuim54fs9AAW8yzTEUN0OUOzE+OQnxBOSkC0LKVh7a2deCr1+6twKy09y4JNF5VbSaLLbg6QN7I/iIxHIBxLs+bFlI4+Tceo30d/9QhhtVCYZqV+IP2eXmHasZ/fC8OAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jtmoeSZW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5888vord009866
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 15:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FZVyFRJMgNXCoEzFRk37j1p5sKIJje8nIrgLumMu8yU=; b=jtmoeSZWhFE6gdOK
	qO9tzHqRQtL89IX12UOsmkbd+MG9E5yEARYlV6iWmPkcVRWbHeRi3dKGrRd+0crZ
	TOv0c7c1TPqZ4MPjsbsDAvp50RBP1QKrdzbvNhUdwVE9iSl5kh2ycVcdVjh3BShZ
	xji30gA9AQM7AqNtBzzOByEi++k7cawsNp+it+Em61eiJ316Lqh7W1QwUJfjx1Yb
	8Fx543+0sDDwxk+rIj0qmQqArO2nh5o6wxQ6N4m8wTao8cZstHUf+/iUQv/Dnqjq
	5DyGR/YYICGdt+iiTGBfUim6pN54dOMRx2suHpF17U7O/JjD8x/e48RC9UfIIzRw
	4lapwA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j57dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:54:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b604c02383so8636801cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346869; x=1757951669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZVyFRJMgNXCoEzFRk37j1p5sKIJje8nIrgLumMu8yU=;
        b=icx2GVi9UsZVx6fADFsgydf+3hyIrtd3Qp/IjRP9v9C5s8ZOjdkMJyWgP6k6pmtH/J
         /qPyMZ1+qAs0zODmFKwVlGN+u/3Qs9q4SDs/ZMjINin/6lZtZGdYkAVeCF/xpTBbtR8x
         EGJpDXgn1D0ELlmobUlOE4CMmT+t0cLERGxAEtKTS2wYY61OuBe6plfbqi5negyfBioY
         4oPnw5znFpp+YGxLe0HwsZTNIgWvToYp0P52NpI7A3Pf6cTWvxD0CDzF86MvsqPoptL3
         Rz+tD3SluKKGT/kVANRNxpUboX1baoi6y0o+cD7AKsAGQCQVs1wPyQVFFtabslDm9JnH
         +0+w==
X-Forwarded-Encrypted: i=1; AJvYcCV86txk+lqi+yfH9rWyKjYJGTb+9VqjuGavGvgl1T23YVxL7yXy5uF7uhz7B60OpckUyz/xnzIZdr0rRiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBjYjv/LjHUgCGwOKjvydgrJIQytPMbqVpCK773KYBvHucwc9
	+liiq+z82V6696I+gFrcS7fzQwQeJSERVEvkNdkN3A6Y4vH80zrh/g6LdI5i7qb8MK9v0tvtR2k
	pJajBfxL9q/85uuc1E/r3gD41Y/AL6B8//T42kTUMehuwcPkc2Qd9TaHfkXgILAp2mJQ=
X-Gm-Gg: ASbGncvZmfdfricgbM29l8fmmdIZ1J/1dRoiAkt1GmPBi4LQA7s7rDmGllS61iVan53
	IyfSGVufj88VHcGh1MQQlzXGvfjOK++lpdKj9bPWVkTDZnSAC0csI/1g3AYHl0lknLLhEYd7wZb
	d25IkKTW9oBRLli2CZnU60F2fj8QwjqW49M8qrorJBCiwRT5zNUwSXFEuAfDm/MeekXQJgbjYdV
	QjRRh/1ibFpj1/QrW8YDy1//nGQ4l0HLfCrigpBNE0oEYLSebtEhCFphq6fUMlCt8fFS/w36L+C
	YWsq0pWvSzAAdLnqMu484b0kUMmPxjckksQGeHaTsJwED7AtRwLxh2NSCnohkPCfLgWYmy3X08P
	hlFuOPMB6OudqCqkGUs4EUA==
X-Received: by 2002:a05:622a:587:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4b5f837c266mr64007171cf.2.1757346868481;
        Mon, 08 Sep 2025 08:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmj+R2u4FLhqzfyki/3z/8FBeF6ho/daOftyM/uI5DeD4o//Or/s9QM8aLr6Cq2JdI0BWMFw==
X-Received: by 2002:a05:622a:587:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4b5f837c266mr64006971cf.2.1757346867969;
        Mon, 08 Sep 2025 08:54:27 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b040d44c9adsm2200245966b.9.2025.09.08.08.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:54:27 -0700 (PDT)
Message-ID: <66e99113-6a53-48da-b775-9044e4269344@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 17:54:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] arm64: dts: qcom: qcs8300: Add gpr node
To: Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250905192350.1223812-1-umang.chheda@oss.qualcomm.com>
 <20250905192350.1223812-4-umang.chheda@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250905192350.1223812-4-umang.chheda@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX76wEkOuQg+UE
 1SvmD8rnNX9xN/2Bgp5uDhBj1yHmMteOHFAveZ3sFsmuojkx1Dds8xLZVZwuhHRvukbW8hf1fII
 sy0RyDO9xOeg27Ki6B7Qz4611I73eNZL5aiP1W1wqolFX2o3zR1TsMC/WEkfoLkDGn+s5kgk7sA
 AewmdwDkAgthAqKlETyrE7o2nE2bek/mCpg7Nmcil/50o93BjVsnUW9r0NAuFHYEcRG9JjES/e6
 e99Yjdfa5j0LwYfXXZMLE1wfcoxZWGBN5VWhF9lVWFFqgbSAIjd5dYJCAdcKsFr7DhulYH8FMkN
 TVRqCQxCp72DrzE9FO3LWMZRrDSQAuTH1+0P5xIoD5FkulD0nJlUoItoD/WvYLkjWZW+QdtxaRy
 p6D/lsZ6
X-Proofpoint-ORIG-GUID: yYh9s9wi-JWKP7-NPR3RVucyerjSgCoh
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68befc35 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=0KPPPQ53LOdx7guq9hsA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: yYh9s9wi-JWKP7-NPR3RVucyerjSgCoh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

On 9/5/25 9:23 PM, Umang Chheda wrote:
> From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> 
> Add GPR(Generic Pack router) node along with

Packet*

> APM(Audio Process Manager) and PRM(Proxy resource
> Manager) audio services.
> 
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

