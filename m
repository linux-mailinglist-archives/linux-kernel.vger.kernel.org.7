Return-Path: <linux-kernel+bounces-865304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A82CBFCBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CC7E4FCC2B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC52134D4CC;
	Wed, 22 Oct 2025 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lBnRqMYI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4034BA52
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145317; cv=none; b=PVR8KCZabEbhjMneWeAkppcd6btWAy7BN2iV+bBvwUnlWaGzzy0uL9CRkZo6WWZEotCnXJ/cJsHpcUlFtCymBmCl6is6E0iVnWqoZZzv4oGsCTxDjpL1mRUJJdJVPLhIksqO3wdRikoO4/7br/fCGT/DgoG8k+Br9sK4JHjWrAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145317; c=relaxed/simple;
	bh=wBgS1XQbHKjwCZWH331tMpBjONLIz9oIPI0AY2nrSCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DN/gr/HzIJ1EB8qievLKdpQ7fzk7FlY9sOu47ywQtWkV1W8Hp0MWsLxp9Wru2zFGqpNgalP6TXSSwUbU7s1Mso59PJd2FKG5O4X4GToGULQSY2HK/xOLq6mGdTLlMFG+dquungMNAgLnYcG6nAX+3yYOL2GYiuikUHQ5ihcNF2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lBnRqMYI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MA0P3o018904
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hMIllqxAxPDQ728CwihRb+R8lpaZm1CZIGmWcY9cBDc=; b=lBnRqMYI2x4D59hv
	/oK3jFg1Yf8tBQxIJZALIjvUWvQ0RQiQAd83EHATeCV1CU3BGhIehXeyyFci7sip
	+sUlxiB/+l1rPikTXswpa1qe9i7w1SpIOHNclXa5Kr4NebCJldQlfETqotG+oUo8
	eiY4bt6fEIdFbaFv4RdagdUjr43M//PD9tDC1BagJz0pPHZyViRPe6Tm7AyQ5BdZ
	IoHcaFz42fUIDpQS3o+aXwT+kD03kQKyRXvbynvCWJMLf6kJ0EEGpKTcSQQnSG34
	AXnoDoi1zsnb/VdwPcpRW22B9Xx5EB0v7okxoVISDtlB18/H0ClRNeAcxDUmwY54
	6xwKAg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469n1sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:01:55 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5568b21ddddso32717e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145313; x=1761750113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMIllqxAxPDQ728CwihRb+R8lpaZm1CZIGmWcY9cBDc=;
        b=F1DwgOUpAPOvwoVtJgvxzlUyzJ+WR8i5SDAHEEB/paQ+96FIOuL1svX5B3oQ7Ro03z
         pXVT4UujWjBZMdnHjwZune3sOQQxU53Rgtwh8cDshwrDsJJeGpt7CjTGtQSDIM45t95x
         B28s4xbGMtEFQ2muygqHiJjHrl9BD8106g2UNfFgnnxFRmDEzLdO5/24KSincivqVdaS
         H2k+ItAXCcCfTUK56BAR/l2p/iuWCY2d5dwMO4sdtxjALAr8kdLlqhrzh0LctWWZQ+Ng
         V36E8nI2MF060ImfYZ6K3Zy7D8sx4mVDXp8QvOsxlHFRI445wEKD1QpHw4dQrD3Z/0ZV
         uV0g==
X-Forwarded-Encrypted: i=1; AJvYcCWl+fSgiVAbhxY+QgQwuyTykSgxIfDsW6KFt3IwIzQT8sg52h6nZv3v2eVDu46pDr+Irud3tIWzlepHAes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys3P6TMMMuFfqd9GeBLftBA2m6VSBgWuBh9Ym//kdKOZbSQbgy
	gDgxNjIJro8IokEz1SRpwLrjbk9ioenXzPc4ml0vtcw9RRSMgL8uqBVNzF0wm2F0FXVAU0aV2kB
	ogME+pSquT55aTMsgU54ODnxtalnr5G0b/8l4toewbfFQhKuMmFBXTw9i/nZU0GIJ0Wk=
X-Gm-Gg: ASbGnctPg35ZaqnV1O82O4qmzQQNPzC07srZ411iwVNke0kJGFhCA53YHmGNkJCUAUU
	WhTtB/HDPKqXsCTBur02kAQ2sbxWghSIQQVgvv9aEbOdYRs62ABfbScyBq/UV5IEfhX2SYv5aYh
	vR9a3C+q7piOsHVZ1+T3xMt+3xSC6Ndt7q0cQoOxdgxv4nF7gVIefv1gixck6Ghf8A0+Mt1P6ZN
	Lx4Nk6MZtXaI6Iz0Nd4wYLlIuNu6UGlQB0ef8IarwgOjOyj7guDX58h6X5xZShveLF33ESu2u7X
	e5w9uBewS7N7LplB9GyZutlB62CovjxI6/DnqMSeQv50pzNlIg2XTVvmtWQu/VvVOYeyUEDsc6G
	ok+bJUcB+ePzsQBggux/OSoJ4rvU7PtQzabuvusvcmIAilIRSVq5MO9FP
X-Received: by 2002:a05:6122:8891:b0:557:594c:54bb with SMTP id 71dfb90a1353d-557594c61b3mr67745e0c.3.1761145311481;
        Wed, 22 Oct 2025 08:01:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfgRrt5iXa7DFomRJIQGJ8VDhlVThbjhKqjcQAvv0iCP92sfGzYuCXXxlj2xPk/Du2wJYrKg==
X-Received: by 2002:a05:6122:8891:b0:557:594c:54bb with SMTP id 71dfb90a1353d-557594c61b3mr67646e0c.3.1761145309915;
        Wed, 22 Oct 2025 08:01:49 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb725f3fsm1354965566b.68.2025.10.22.08.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:01:48 -0700 (PDT)
Message-ID: <295c775e-852c-436b-84eb-1084e549598b@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 17:01:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] arm64: dts: qcom: ipq5424: Add QPIC SPI NAND
 controller support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
 <20251014110534.480518-5-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014110534.480518-5-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: k8hSge_MrIaRh9kUS3kSTyp25YfK4MDk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX44F4qiV8A/MZ
 ojEVuoCaqF0vaiOXXFVLXQmAHKLIGmGxYFn1lzwi0FZol6uWT4TNrk5aOnExBerM0I6sLPTdfZx
 0NCqXT49jj2QDwnzoBw8QPvqt83IAAaMdCXsMng2I7C00Vm1M32txhn2LwEIwChXV6SPEGOCein
 f8bFxVJBWaaaJUjJJiSO4GUSaXl9LJluvedn+HA1u3nfvuIJ4rPeFMWj5Whl8iLvprVnzOErwzb
 31q3aupd9cUaky6gZJd0vLmpBG4uTXl4pVXE8Bfh24QCJ995YG+W9xlAEYdCGR/ibUazUCj1/YR
 flpuB/iQnMXsEGOdfvcg5dUZykMPfp1n0lKmjFTq9Weoe4b+YDxxG+jg+zfA7LlNWKzjkC1HXwF
 IGt7Ftes+7i3Dmd8AloYpdRD6i038w==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f8f1e3 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=eg2IErnvy-Z71prtMQkA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=hhpmQAJR8DioWGSBphRh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: k8hSge_MrIaRh9kUS3kSTyp25YfK4MDk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

On 10/14/25 1:05 PM, Md Sadre Alam wrote:
> Add device tree nodes for QPIC SPI NAND flash controller support
> on IPQ5424 SoC.
> 
> The IPQ5424 SoC includes a QPIC controller that supports SPI NAND flash
> devices with hardware ECC capabilities and DMA support through BAM
> (Bus Access Manager).
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

