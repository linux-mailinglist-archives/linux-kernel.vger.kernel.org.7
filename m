Return-Path: <linux-kernel+bounces-802811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2705DB45746
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17013A46444
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB84F34AB13;
	Fri,  5 Sep 2025 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c9jG6U7q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446834A323
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074128; cv=none; b=EZ2FOIREovDN+08kBdWfIjAZdVS0tmePfrjCmizxnw/pLuiqZSFXPmp863dky70QJsIQMKBH0CoPiEZOPztYDxNy8FcR5KJTK38SMe1PrhpvtNu5iJW6YeVF9CRMweOQZUR52RsoL5e8W6wTGVYO0TaCu5YZNmBis/M3P4ssct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074128; c=relaxed/simple;
	bh=rbDWYSVIc+S3ABYMQqky0vWnAX9+AFD4sL9me57s3Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nx3j+0LoH5wZ00rFXyCf5phEvJBFEd9yJN2qf5zqZiQDT0SzwqtDXaPwmMILrBE+pxOZ+zC/vfkU0ELfLdTQNqz88NfY2sMcHCxkLnBxb4RdRBvM+P/veBtz4r6h9EkUjdW1wgG5UwMMX6evYPMav2LaitnEssTeTehrQrjtO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c9jG6U7q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857EDm8007551
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 12:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1eIGHZDbMCTDRlP1TpKl2lygJjT6lzTuIxUng9v1BgQ=; b=c9jG6U7qi/y2Akcq
	/aWaJwz+hlhRm8vaLj9iyFX4qrzwpdL3gprPhwBGgsPJkzeA9TB52Zs1+YfWrGuc
	/w+oj2c1Q9pOWjv6TDVRf09cz6Ltm2DcjtFvcCB32uTcOBLI/ijYs0+jYAmlnVsj
	kCFkhNma439xkpYjyavyIRf6P1Ff8cI57/VqPSxA/iLzzJAsUgII/GacdlLbXkNC
	IyN0xvUk7DFXI/AjfG39pxn92/udY4s715UZcGJ7Be4tZnkBcMrizpzv7mn3oQs+
	sZgH/BCfwB0WiPkvVLX9crUkdYJ/qlbtS1DZQLOoXRO2BRuk+09gpGIOf0gS30bM
	C+4aVw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura92xd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:08:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b4bcb1e32dso9492821cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757074124; x=1757678924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eIGHZDbMCTDRlP1TpKl2lygJjT6lzTuIxUng9v1BgQ=;
        b=U950Lql/uuntHEoihfxYG7xXRTwFWCUKM9v+HQr+0LHe/JYCBt7hhC39BwYazIFkFM
         oB/srC5e2IYThctrN9eUGbLk8jQ7ucHm4WpJUnmBHM+sny/D/HqtIvOZgPa+W+F5adAC
         F6zab0t01GcxiUKN4DmKfRFu0ZidoWvor1fMZjX9uOp+PCUZ+IHDwC3/i9yhpWkzaV6/
         DPdYzI+hlkTwgSEFJ6q+mxAZFI28OT06hbF1LsFjvU7PF2j87qqzLldTUFVitE6Tpwl5
         SPwwhGdK209WQLUnld+A94YXA+jvbfYE5pEB3tXKy71xHXb9+LrehRbJPNX4Pgsv8u7P
         Y3MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmJgyaNpxZsDV3XAGNlvuW14Lf9N+UCM+nulIIp2i4GUAUZvpkUZZ1GOavq4sI3Itd4TFT/5KS4gKBDz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy/06snOKzGHWn1IxtjnaNNZTeep5WJfWQQMfXOdjIanl2rAY6
	Y6lkqQQfDf0y+84TmRTineC1UBWRzSaVlTxEfJtXicNX5UOjAHxT59nsVOpClhUL4iUytSuq+eC
	nwHN4G/87vWrKWJFtPINfcwbCasp1cOhWczH9pl5KuRdcvXgBsZILNPgymAFU+CxT0XE=
X-Gm-Gg: ASbGnctP/kBcS1p/zMJzx+Ovu8XbZ7jMqa/43P8P2RUT0MvV4nvU1U5AREV8tfYNnPx
	SoQi6a1UmmUy/aJpw468BlvSdhKDDqn4NfVxicV/YnPSNzF3tg5fHyDvMC7j7EstSJgT0fxCLpg
	o0q/maCHL6bLuEIAoNRhkYGEZp0sVTLFO40BL19E03mJU0iv9GqI/eXcZnBXN1Ja/vwjGDPQPm/
	3EgXUX35X6QVoimupHDfw3zTytVBMqbu9GDlzHCpKhk0L018jw52iF8Tyevikv7T/tfyoHE3dmc
	toIus6Kf8P/u79bjtaIzMz5+cdbKBl00/aAPd00vlJzhUVvZSaa1dS/fpH2DnkzN9W4tVQTYIpc
	/iv4EDnkBl1Kq9tnYt5LJ/w==
X-Received: by 2002:ac8:5fc4:0:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4b5a0fb5d54mr56116381cf.1.1757074123766;
        Fri, 05 Sep 2025 05:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGhLb6AyLTtxi6It/6ZDvuBl0OtYQNFkjfz2TPhZg6tNQSWGAKLOvNvVjqsEPiE59zf6K0vQ==
X-Received: by 2002:ac8:5fc4:0:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4b5a0fb5d54mr56115811cf.1.1757074123024;
        Fri, 05 Sep 2025 05:08:43 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0079183496sm1557522966b.13.2025.09.05.05.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:08:42 -0700 (PDT)
Message-ID: <cd40b690-69cd-44c6-82f2-39703beb1801@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:08:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] arm64: dts: qcom: lemans-evk: Enable Iris video
 codec support
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Vikash Garodia <quic_vgarodia@quicinc.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-9-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-9-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6KkSsDcOcjXcubWWuPeoSYyM3T-rQt8S
X-Proofpoint-GUID: 6KkSsDcOcjXcubWWuPeoSYyM3T-rQt8S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXwtGjdjdw/5Tw
 AxKirvKryEHVUOaAqCV0G3kw9UuUYElhqflCH9eLk3Xh42TsWzx0iFsuip37bug3IvWrJU1IyJu
 KKzI2qV6euzrwvc4gIIGmBZQmaOzLk80n7V+aOiKpTrQnJ556DDkR9UP47NNqZZU8DR1MThlPWB
 msZqPvpEfAYyO0nvSfTPeDiA54yE1uzdaF1fQNJj6oy0pcW1H+eFdvkxwyOTqGDjiaicPmbRR0m
 gDt6utA4JghD10J9bJ9q36jfNDWbgjeuuCTK3L2X4rOol+62LVf35Y7BCtNDCpAGyEn6AiRj1X8
 XFSJlA+S7vVi+b3JtKeFpBnkhI20pZm4t6Ic2omJG+s5tI+i/svXEjJvPVsk62isQxJuI4Q/tuG
 9k35tMea
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68bad2cc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=yPPeNZB_paKBOZgJB6kA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> From: Vikash Garodia <quic_vgarodia@quicinc.com>
> 
> Enable the Iris video codec accelerator on the Lemans EVK board
> and reference the appropriate firmware required for its operation.
> This allows hardware-accelerated video encoding and decoding using
> the Iris codec engine.
> 
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

