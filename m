Return-Path: <linux-kernel+bounces-813482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EC8B54615
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C30BAA580D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5336F270EBF;
	Fri, 12 Sep 2025 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jetTKFEE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777A25B69F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667371; cv=none; b=NgJjrlMMOOsmBMORFFzgRcOqQn3DcDQNP+pusVFGC1Sd/bpRAH7dOrVS68k3eHeoiiGh8Btc5j/6P5nTZl0l11vAqeb3xIGhRM58kQlDkH+fsYoMxQsqWdVXsOetrCsdjz24YpU5QbEDC2IKTHMfQAUtqs/r6VHFTcYCc39uS8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667371; c=relaxed/simple;
	bh=Hw+jWTOnPa5ZB05R1aBQnEOz4XeAn49O3zb5xmvLtoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsG/ckEXPiff/hGsbikYZq0bwu5xg5ieAw2jN+2duF/On7P2yzTy7aUzs8/EqJi8np3ImDiEF44SUmXlbq0F3FW5jF9FQAse6o/GzOUr3OURyKuaEPY2oui+Zv0LZA1Fn4IMd6K8Oj3CBV4Z5Oow1GMeTq3UJm+cBAqWK77vziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jetTKFEE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C7eM3Q008188
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mLpUpRSzu5WwkQPIakVTd9F3SFHqAib21JyOWgJz3GI=; b=jetTKFEED/iGK08x
	OLCF6Rzc9gEuXc4ylMAmmBtykxKYpjnWjlh/lnkWDCfoS2rF7ohT1pcDdp3D+ER6
	z3N+48f8srtAfXlTAcASHvBH4HTpJ9BcuS2NvbKpC/NVkiS4xHIXxyFKBbxSitut
	FoSkI0XDOiUhrUf5LPy80pb38a7koPIWMFvEwrqgzfEuJYqyMctzsgUUV15ez/NS
	jM/JdilFD0vuqOvcCUPdMDQP+OuIAn5QQtr9vUt7ZrJ0hJxJ9MwoN3kSjMxdxIqw
	fNMr4xw+zluF3R35fNtjjCfQ7fqCglbMbPiMUm78G98+j2uwnBOTibGyvR1MexKV
	3DFXjA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapu5q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:56:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5f92a6936so5307331cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757667368; x=1758272168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLpUpRSzu5WwkQPIakVTd9F3SFHqAib21JyOWgJz3GI=;
        b=UOwU2wgTX+0lcNsddOQnMsdugfE1oHsMPCx41j3weMalx4rJInTk8mlAWl1SkRgaIu
         75p861+ASsJ7j62EiI7Bfl7gxDGVd0fSZ+a3zMsns7RQ2LGmDQnSyCb+WNxIXtpXQil6
         CTXOumhOCZmq7+Oz+GhDpRigQ4aA1rtyhK/8KDGJ9LcqfaEjQNlBY4k4lbq3+3ml4I74
         xEKofa08DK/fFlkgVdGsJ/2a3pSGHH7bUsZOJNmTA80gmMW6cOdVaADwYT4kQQPLtT/O
         ldMnP5YgjQ5l58ngNgEvZXjUpMWId5x++Nr0f6laH44PfGFMGYtKe7NWpNxEDti6IaF+
         dgFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0CnYbNXGe/h1dUYDTz72AAmmWqe26CbkLLZgpcsPk+4w6sN10K9SnTsFkb2gR7eOepNlbCZEbifvgLrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3IOhyTtBjfqbu10teaoFdZgMHJEtvFxfgMtPiz8b59VADsjdv
	l0N42Pp6NJCpHwaj7NTG6p+zfrZVKwXDcGSVdCd1VMRirru+cxDx+cP0Yz/F0cblnufIrtRAxYs
	RBSR+3dF/VG1CM1Z3QEUCBG4xOZbc7cKeYuuxDWjNDopvsHhMTyVEHHGFwadV8vNvxig=
X-Gm-Gg: ASbGncu6p3yWLTe6BP5PNfNr7ejykFPfbEhk54zf3dN4xWjhypESLHoIiorv8kr2AFU
	GTVrO3I0/lrx9tgeCVYhA3nyIECeCcLBr/RBmqGozPqPStZwD03unqKGjfvwejbHUZByLiASgKW
	QrSon8gl6CpnbBi2YVYvpFrQ+RIxAXD5a9G/3lMT+95EWM2zAoHkYqwX+5XnchUm9KEhEzEoM+h
	Isg6jQ3PCYRgKRvrXTvOxYXw9qG5yMZ+Gst5Z0CwNeEAkFupGJvlP0PYA2JDlbdHGgTpDlxGe6W
	hMfIaWmJYfjh4mjzsN7uQdRITJBFl/1CML2nYQH3EV3UIsXL7tuoIEECf9zLvnFTvjGzIcVpxwx
	QnPUwH0uSNKze/FgcO0+NNQ==
X-Received: by 2002:a05:6214:224c:b0:70d:da58:446a with SMTP id 6a1803df08f44-767ba2773f5mr18025526d6.2.1757667367962;
        Fri, 12 Sep 2025 01:56:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmyfereoE1eQ0kPbehRY6j+qV0N12MtpHVBAp6lLccgcRMNmVw9DpRMAkIZbmd5hcu6cTwQw==
X-Received: by 2002:a05:6214:224c:b0:70d:da58:446a with SMTP id 6a1803df08f44-767ba2773f5mr18025376d6.2.1757667367299;
        Fri, 12 Sep 2025 01:56:07 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62eed9aec1asm54813a12.3.2025.09.12.01.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 01:56:06 -0700 (PDT)
Message-ID: <56b5bacc-7214-41aa-b969-4f622afcd9f9@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 10:56:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] arm64: dts: qcom: qcs6490: Introduce Radxa Dragon
 Q6A
To: Xilin Wu <sophon@radxa.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
References: <20250912-radxa-dragon-q6a-v1-0-8ccdbf9cd19b@radxa.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250912-radxa-dragon-q6a-v1-0-8ccdbf9cd19b@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c3e028 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=ksxQWNrZAAAA:8 a=-GE0gMS6kJAlqz36ZuEA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-GUID: hmnLu-LTPLRH0BI6ChRPOqvE18e7cKUD
X-Proofpoint-ORIG-GUID: hmnLu-LTPLRH0BI6ChRPOqvE18e7cKUD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfXxm/9/bj4p52e
 EC6Oj6Ut0X8RmcOOwb/eDeqDvpiZSyC+su5oXKlBessev0XO67Hq0dEqaYbufcGmpTa/sn7vKCD
 6+sFYnkhhznMEh2t2uyG+t4mL0XSto/pXIWmyuTmaBstsD5kXVSo8kwXKd5/nG/FikJ9RK9EajN
 z5BgQnBy+BpaDC8TafuSWVt44d9NsSEUkZ4rcLoGcjxbLdpwUqsq+27JWViMelB3fupQstF/SPW
 1wssH4gRHrByqMJtmCcAOX88/yuubHPIfZ5rOfXUU/XcnxYItkKCRKV7GKproMkrE5PnEOTJhOE
 hl9xWr/0YGrEvtNN35VeQv7ZpNksSgJ0kQJAX6xfD30gpi483VL4Qly7M22Vrv4+jMD0kweZhOQ
 vkmKD14H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

On 9/12/25 10:03 AM, Xilin Wu wrote:
> Radxa Dragon Q6A (https://docs.radxa.com/en/dragon/q6a) is a single board
> computer, based on the Qualcomm QCS6490 platform.
> 
> The board ships with a modified version of the Qualcomm Linux boot
> firmware, which is stored on the onboard SPI NOR flash. This allows
> booting standard EFI-based bootloaders from SD/eMMC/USB/UFS/NVMe. It
> supports replaceable UFS 3.1/eMMC modules for easy user upgrades.
> 
> The board schematic is available at [1].
> 
> Features enabled and working:
> 
> - USB-A 3.0 port (depends on [2])
> - Three USB-A 2.0 ports
> - RTL8111K Ethernet connected to PCIe0
> - UFS 3.1 module (depends on [3])
> - eMMC module
> - SD card
> - M.2 M-Key 2230 PCIe 3.0 x2
> - HDMI 2.0 port including audio (depends on [2])
> - Configurable I2C/SPI/UART from 40-Pin GPIO (depends on [4])
> - Headphone jack
> - Onboard thermal sensors
> - QSPI controller for updating boot firmware
> - ADSP remoteproc (Type-C and charging features disabled in firmware)
> - CDSP remoteproc (for AI applications using QNN)
> - Venus video encode and decode accelerator

You have a number of features that depend on several other series, and
as Krzysztof pointed out this is difficult to merge/review.. Could you
please create a "linux-next/master-ready" version of this series and
separate the changes for which the dependencies are unmet, putting them
at the end? This way we can take at least some of your diff.

If you still want review on them, you can also send them as [PATCH DNM]
or so

Konrad

