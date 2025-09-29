Return-Path: <linux-kernel+bounces-835809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B56BA81DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72F43B710F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22C786347;
	Mon, 29 Sep 2025 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BTzPoKIT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B0A253B64
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759127283; cv=none; b=k46z66RUngsU5E9fzfug711NTJvAOOKbxb8dcqloe7tVL8kD26C8Vszs+GU+3KaryJOAo9JM3qMNl7rYcCzn+2E0J416me2qtx0mJJFsCSqRrGBPEFTXOlA9qyDxTD6TErQhbDffXFUN4WhZNRBIq3V5LrveVJ+DUiiDRexTmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759127283; c=relaxed/simple;
	bh=7MONXp2kxgmvXUrMFPJPcWOY5YJ/mSytwCSndhWpUr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klby423l/NctbBIluPSQlvyNvUXDj9V9jUGju6t9aefZHBpUTPZLJKNepyxSpbXSheQlQhg/dsn7niVqyCzopAPqmVoTLtDwry1bzvKbMRbSwtJ/8CEpbRwVUWTu7hVrDqNhpVJjvzAIyDkt831/Xd1svjn0+PZvd5XJ/TxA8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BTzPoKIT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SMtDlX008908
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aoiySB9U8Vv6U6hO1VDsQsux8dNMt7jx6n76caS6mIU=; b=BTzPoKITsjHcE/Ig
	+gEuoJQqZWQkBnXTNjXpQkAuxDJy7kI0tKw+W2EUdfdtYH3188g0KQANVZ7EfnVd
	gEGwbi4qQDZXg+NFwqB2iWj4DMNQUV/HvIRuTmZF4ZHrFoFIF4Qmp8f9tZAh09i2
	Fil7I7ajvt2czV86ezHNTTCZMwI0xMNnxMFMGFwz0W6AmsQuz7GjDv4vqws3JRc/
	A6AaGsnAkFZ9/2Tjn+uZhZgf/Y7lBLhOmkBtlp91+86228Kl8YlQNcDGeJtlHaba
	y5hpQV0KjClPvzyGYpKY7DmYag84CJ4zark0O1ew7c9EELGMhBm099B3l7gteAsw
	pbA3Pw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e78fv5qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:28:00 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b55443b4114so2860686a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759127279; x=1759732079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoiySB9U8Vv6U6hO1VDsQsux8dNMt7jx6n76caS6mIU=;
        b=u364WaDy9n2pVXUu/HSAIdpvQDfbvCB2FqTJqgb/FGP+AMU7TCBsS+FmfEel5GweGT
         Z+TcdqUM/w6vIgiofXO//c1vpICjzrLzCeF/GpBQwRoajcnTq9KT1T1tETxiIHrfQDbt
         BqONy+S/5AQ6xBjKYLOyGRaaJrZNkXWHOoxgPv0ouzuAUIC4aLOuHRmMt1tDPk4nzO0Z
         fyp8IXZhuLsXT0Ua1yHP1LzySerwsqsajZ3ojf1mIBp+0R8vKYqBoLmEKyKUSliKWllZ
         e44gI2vh/TDadqIdqK2heXs5h9byTUj3W5R9e8w3l6XZmyP9VuqUCLpHuNgb9bVGbowA
         OIug==
X-Forwarded-Encrypted: i=1; AJvYcCW/gbkshZbGtfWByqE20GqukIMahzksdOQx3yG91gmW/0V6HoRUuQnvsn4bgMamI0rLza7W83lH6CPfxOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmjnPYC/ZXAS2PhwB4NeQ2wsn/jcjPtg+vV6O0Kx5GANuj8AzH
	Ma1IVpY8C6cF5mVnF2/2nr4m51BR6W8i1r2Ke8XBQKWwL0VUY88quYWHvT65DHkoS6ObvLFWtJb
	nm66YmjhJdEkn8Uuqh/x5AaugwStYj1ymHHZ++U5X7lwDjC+7LzzA6kk+TOvmFHjj0w0=
X-Gm-Gg: ASbGnctWU2HVMv/f97gBR8MdxBIadVsKZzh7Q8nIQw0BpQcHVq4X+NOkk4yeBtxW3PX
	GNE6+7FCdT9EwacWn6FRFXEisyjhCksQsw6kTR/hsDFGjjfMTKamWQTn2VIWJ8KspolxDOpuwcf
	IT+X6DoJGa6yPXfNPVkM8sVHAVyK7XZLZcv0hU20jmZLSBgoJO3BjwCZ38NT/hXnh1OG5tQz1K3
	Zd7YDViDTSGciRV/iUrWgReRzlvC1AtuGTYp9x2DKstf+BrFG8ijl7ZR7YrG2s8j70CQyT1ozzO
	jg8oCWj6ExylGwbX/ksH0DQpeTIqri0XDdN4eIkAznWA3Hi4jld2Z+surUsRcRqo4so+LxJWE8c
	oQtUfLu0fMOMWgNEASBM+657GpzUZWPh3JSU=
X-Received: by 2002:a05:6a20:e212:b0:2d9:c2:5ce4 with SMTP id adf61e73a8af0-2e7be066b1fmr17865341637.7.1759127279072;
        Sun, 28 Sep 2025 23:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0+hgjwMD2S0KLIaHpLLLlNzETvpPU2QOEdVqYskNhuhBWrT5uV/PegOpSnXKtl0Mat/ebyA==
X-Received: by 2002:a05:6a20:e212:b0:2d9:c2:5ce4 with SMTP id adf61e73a8af0-2e7be066b1fmr17865313637.7.1759127278653;
        Sun, 28 Sep 2025 23:27:58 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55be5b9sm10167314a12.52.2025.09.28.23.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 23:27:58 -0700 (PDT)
Message-ID: <464b38f8-f91b-44f2-8028-aa0a17ca3e68@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 14:27:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] remoteproc: qcom_q6v5_pas: Add SoCCP node on
 Kaanapali
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
 <20250924-knp-remoteproc-v1-6-611bf7be8329@oss.qualcomm.com>
 <b7855860-410b-4d32-afd4-84d61cac4a79@oss.qualcomm.com>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <b7855860-410b-4d32-afd4-84d61cac4a79@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DZAaa/tW c=1 sm=1 tr=0 ts=68da26f0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=bJu89BRhDEOEog6wxuYA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMiBTYWx0ZWRfX4NqBtofP7GxK
 tyFC0Mt14ZbRZ51w2VfBsPT1fSOLUKhOc2Vo8D1yo6pSr7RwREnxlbnRIp2NEtvNwblV6CPmSbm
 oQLST2eakV1TDRKyq12apWIhhOmNqD1tmEUtqyNPC5aSONDlXRl46yqsY5hCAI3bgcohSJgDHYn
 Q5k0WZhL3mX1n4J+RswSJymE85+5OnuvFmJgQbd7sG/+C/Cu0GnBsw6e/ajXQfBdQ7rV/qScfJo
 J8KnMCZVTQafNaqhHVhPoGNWJATdTYX7R8GoTgTmHRuOm+AAtwSyJnorqywJU352wfrNlvEtI1h
 WZInubCwxa2mFsrYW44YbCK83NZJlDqsNGafW+mp/6XfSLKw/U2AyDobaPpcgGgLUdeCfWMpJzM
 5qTYNmZymPjKyayCIWl6s/tMxPS73A==
X-Proofpoint-GUID: XuWz7GSoTVjlUI9OWV2qqjayS0ZLHUo7
X-Proofpoint-ORIG-GUID: XuWz7GSoTVjlUI9OWV2qqjayS0ZLHUo7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_02,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270022



On 9/25/2025 7:42 PM, Konrad Dybcio wrote:
> On 9/25/25 1:37 AM, Jingyi Wang wrote:
>> The SoC Control Processor (SoCCP) is small RISC-V MCU that controls
>> USB Type-C, battery charging and various other functions on Qualcomm SoCs.
>> It provides a solution for control-plane processing, reducing per-subsystem
>> microcontroller reinvention. Add support for SoCCP PAS loader on Kaanapali
>> platform.
>>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  drivers/remoteproc/qcom_q6v5_pas.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
>> index 99163e48a76a..5007e1706699 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>> @@ -1487,7 +1487,25 @@ static const struct qcom_pas_data sm8750_mpss_resource = {
>>  	.region_assign_vmid = QCOM_SCM_VMID_MSS_MSA,
>>  };
>>  
>> +static const struct qcom_pas_data kaanapali_soccp_resource = {
>> +	.crash_reason_smem = 656,
>> +	.firmware_name = "soccp.mdt",
>> +	.dtb_firmware_name = "soccp_dtb.mdt",
> 
> .mbn?
> 
> Konrad

Will fix.

Thanks,
Jingyi


