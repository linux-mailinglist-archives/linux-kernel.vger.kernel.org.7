Return-Path: <linux-kernel+bounces-751032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD93B16464
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D3C5A616B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2062DEA7D;
	Wed, 30 Jul 2025 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hWdheP60"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2A12DEA7E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891819; cv=none; b=U57CDzCgzSaIqzJPrepApqSCvQJPWJEYERdbRQHKk56OdSBrvK019j6LQY0d9LhWbTa74jbatVdc7AijAS43lEefhGtt27adeGozHE/+4b5C0jwlLVFlOgdL1RYLvF9KVdvUa7HTRYQaWkyWOxit/3rs7/fAchQw7Xq8Lp6Mglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891819; c=relaxed/simple;
	bh=AQ6vuDxhEytlekZaYlH8XfS4ZO3JTfZECFeATrSwhLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGFGabi0GnT+fjuv2WXJlJ6CadLsULS6mZa7ns8ysGCLRQWqAvEslJCQqrxcfCXIYCiHfRAVWjgYroLwQOztD3ysyG6dmjvDmxznd5L/JvEWxFE0MqeRrXSEtLajD/thiO0HdpONrtZkm6TjgJfYFfvoWGTByHqZBLyUM8bNwX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hWdheP60; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbAJQ005862
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tIHRX0L2loDM3GRbyCm/tSaU7Q+F+UpeXTABbm/Giv8=; b=hWdheP60guVymOht
	8iShteoXLTmdJa8ln29N8pPLihRsAJphbTJ/nwWoFJxWtYt0RAK89NkDMRuIZn2m
	mIXG37LYpBEMFRxsqYsqVinHJVGDWHIekGqXlaLggE5jjpz9OsrrBSZWswTE03dq
	FSnkrnpWMWnDEZ0E2JdA21D3nTJlS8/p6stJUkbhh4Q/zjFbA6JaQuvf7eAdN5rB
	NaBsl1ZhQUanyg97QEO0DF4Qwz8qdjzvA6NMxKDfg1VqWxSACIVn+eSVOYX2n7M6
	LkgAhN/qil3GZycj1qLJ5z6UXVKPjucjwljpBDRRrJRiRcYSCVHKrIRzArKGh/ep
	UCQJ5A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwg8tdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:10:16 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b38d8ee46a5so1176865a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753891816; x=1754496616;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIHRX0L2loDM3GRbyCm/tSaU7Q+F+UpeXTABbm/Giv8=;
        b=UPdeEb6Xrjv9ZG0fhfrJ++HuFlRAigx+eX50WTmdRFKpY5P6UVLJSE0coF7PZbG02B
         TVGQpXwiTaYKuH9hIBPmGT+gz8wD3oeM5lTJY0qu7KAYOwAi62ok5rQEc83xuB4zVLiM
         Je2wPo6Hi89Ixpwx5h4vBMQ1y1+TCjqDi0wSoHPuJe9Vi+R68c+zPUsop6NwXlur34QL
         MdC62TMMwPmV9qgcVWxxY0/KnSNWrtX2HKHuXx18mk+Hl2STdCVu/ntzAEupvSMmgMSS
         CVptIsT8wg4ORlHkG+nMetsZ/zdCF8pd+rIoUzn5VRYo54uOD4SUaWqravGnZqEQWEXG
         u/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXC2S1kin/EALKRAS1dzt9pqq7BReYZjs34il91Pc9qdIK69DW9RcuEYm8AdMRc+XLWEwtFzbnzduJm25I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx42robqaQ+KBJxVESKwUWx6BHXp+pn7ALhgaKRYyoKbfZzwBYa
	wWkggUNdTMmCIh52VtBLnZrEah0c5PbHlenQJiw5S2v5+/yIVHQGJAgAYHnghDuMkRWy9gVE+IJ
	DODY82Xm46+C7zAJvz+zSGB9y7oxyIisxpA1QSdy0qwrsrU30mfqgdeElq6+lqHREl04=
X-Gm-Gg: ASbGnctKlOIgFO7R10ay3rMP+jG/f+a6W6JM7Ko62dl1dgVhFZt0kD9JwMVXPhytMMF
	U3VHF00LiXSqmQIUyM9msgZlhMb4jeRH54KQTZEkg9sl+y+yE4NEetRLpGHJ5gkautEZnanje01
	htUA9/D+q/kEno/rEESyuscTzTf7gtxUwxF0qhVmOx4Gl499SnftfraDDHGE6xDezDATnyidgah
	x0VmcGHWTwChky6cG44tNaBcU3WlJ7V78+RTEDzlH5ITwT2yjaZieGT9TxeVcz9t65dhmlyMDWb
	X4K9LlyaGiM+cPcgFvHXngY/xkhZQe5xn7LGobdAP7NNVt+lFKSDseipnKkn9Bqb
X-Received: by 2002:a17:903:2f87:b0:240:b630:e600 with SMTP id d9443c01a7336-240b630e7admr27941805ad.11.1753891815810;
        Wed, 30 Jul 2025 09:10:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESpaWOxmNYWoJxFhgXCazhVQZS2S0Iu1Mkn/tVp0EPP8Wf9SOkPH5bbEOsVSgOrIyQZIT8Lg==
X-Received: by 2002:a17:903:2f87:b0:240:b630:e600 with SMTP id d9443c01a7336-240b630e7admr27941245ad.11.1753891815298;
        Wed, 30 Jul 2025 09:10:15 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2401a335b37sm77767365ad.124.2025.07.30.09.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 09:10:14 -0700 (PDT)
Message-ID: <d11496a2-5a43-4b6b-9a8a-d8e05a89587a@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 21:40:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: qcs615: Add clock nodes for
 multimedia clock
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250702-qcs615-mm-cpu-dt-v4-v5-2-df24896cbb26@quicinc.com>
 <ff6eee04-d191-4dfb-82e5-7e3a6c896025@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ff6eee04-d191-4dfb-82e5-7e3a6c896025@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WvgrMcfv c=1 sm=1 tr=0 ts=688a43e8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=HRpvt/FSzHA3SJMKks594A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=J94FwCPnZ0hQmDvvoVYA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 3CfN7pUmkL1Ip_H0aCdAidq_9LXQwtC9
X-Proofpoint-GUID: 3CfN7pUmkL1Ip_H0aCdAidq_9LXQwtC9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDExNyBTYWx0ZWRfX0Hhup3PlZIqI
 Mlju6aHc/nrZcZsrkwsw8w04GGJ/5Uk9JMihydcBnLemUTiV4tymiN7GG2NvyzPGNYtNjcUSX1k
 vNfag11RvXy0FwEqlHLF22FMVxtuDjG7ucfqtO3N4OSAfmrodMw3UJ6F4mJRAh8D5T/6yv1Bak+
 KtPly0dLrBLheX8g384MRGE5Q/ycBGGjuehUzMbIorG8gGUfLyQXkiv+w227wHUm4i3x3HEZtSE
 PsTESWJjGfTyACpVBIYeC+vFMUc2m2qWeaSoIxfS4zs2ctfcId83/QjNShnBnLFRFamlOFG8IeV
 aFVI1BpkpcVABh/SnbZQAsQR5498SYtDxNT91/O2xjCpmBdfWhQ9MNPjjKy4XvfX2ZRpl6qdwJd
 jclu2JpeYDti1CGTG34xyQeUfJYYO/vz7HoSUclnKaqfxAG5GVYUmwtoNILzZMCgLHyd9sGx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=990 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300117

On 7/30/2025 7:07 PM, Konrad Dybcio wrote:
> On 7/2/25 11:13 AM, Taniya Das wrote:
>> Add support for video, camera, display and gpu clock controller nodes
>> for QCS615 platform.
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
> 
> Bjorn mentioned offline that these controllers should
> probably have power-domains attached to them (perhaps bar
> GPU_CC, that's under discussion..)

QCS615 has an rgmu which doesn't manage gpucc. So this is a different
case from the other discussion. Are we talking about scaling mx and cx
rail while setting clk rate? Downstream clk driver does that on behalf
of the clients. I suppose you are not talking about that here.

-Akhil.

> 
> Konrad
> 


