Return-Path: <linux-kernel+bounces-720900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B863AFC1E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B102E1AA5146
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2068621578F;
	Tue,  8 Jul 2025 05:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MavYJLDw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58161A3179
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751951254; cv=none; b=bJtG4BBKF1EE+xeJbi5NZ+w/F/VsoNwfYuFgqw8X0p4x0h7WKcHRGMBkLq0qJZSQM5ttyLP6a/ggp5/OiimWBg4dBmW80z1auXOeJhu6TqxDuekjytyqk6N+tA27z5KY7n/l0CHCL6TL7l500QGq9nGkXVVQFc/vtM3EkhsqIe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751951254; c=relaxed/simple;
	bh=UgFjbcye84s+KDcBxlDJ9AeJpfDrvjuDp/d8vKxVNuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQ3NaiTwm0Oji8HaYjUkcnWDhP6I1SF1SxCMyCtDDngVScI+1toV4OsjUwPPo6pFUDmhDU8Ko7sfh5fx4ICQn8Pyso4aMdqAdBRsPGgWmcJpGUeeGqNSVW8bzMqYGzH1QDaCvNd2piJI5lpVWH1OcWFN+y9SRIz7VM8wnYawS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MavYJLDw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567IW17P016790
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 05:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3XONfzPCD67UozhiardL/SFpSzSG3TM0b5mJZo5/Keg=; b=MavYJLDwxR7t1eyE
	T5Vmkizacqxy9rbiEEYz6cqbK5frFVBcOVMhtpS+x/vwktwVzdokJn4XDMM+UpsV
	3rrAu8tV9WGY1WYBOJgwpi6FXF9No3i/b+wTH+FVHwUSLW5plSs6fIxNmVXLeo7Y
	4L1dYtypdETRtqMxUlqPCe1STc6WBEGZGZG7qJBoCfT9uiHPiCacxzDc3QyX3uqX
	E5L2xGe0ybfIYk7nm3wGoBlsctG1fNWrbgicaLdZhs8goHk4hI679jvHft+cJHXX
	eInznVAY2rQkMGL6lK5jAmiVnD+LKRCWh5peSVrhluSGbtCAVSAOEiDkkbJ1hboM
	8Cj+mw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucmu3nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:07:31 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74890390d17so3703196b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 22:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751951250; x=1752556050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XONfzPCD67UozhiardL/SFpSzSG3TM0b5mJZo5/Keg=;
        b=Fug3Xg9R8SbwF6W5S+LAg1b5VPLTxPc7VapOw0KxFdUXnvOePjnUyyoCswGXpZEqA7
         PTxUZ5OznFCKQnbKRQh5E/1PYdHi0hi2yruxuxXOq2x1Xz4N494KD2xoJkE1DDQlmw+w
         zeZrUjG1oIvOVDnSAq2/p09hNJU6wcV0q40K+u6FcLsnIGCGczYuW4gAHk37rfc6kg37
         t+geRcIXLpVeV304GRI3BCIKuubSjLNmXPO3Ka6/WEgkblRykeXAE6Ep5osWGcDiwiKW
         Tp6XCU3aPOBe1/r4s0N/xvQ+Pee4X7hQVt2g8XNpxNe/LHcFc0xDS/KzmRTeZHfwrWsU
         Ekbg==
X-Forwarded-Encrypted: i=1; AJvYcCXgygreLALMOW5NlM9uxobU5dTTrjnDEOYGu1lUgBBSazTmYkML6FIrYH1PC8fFrtseFTXcGYbSNSYScEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLcddLJ0l1+0HUQth46IMIgvRcIz57MKxD9KTmlulLUgbmnw74
	R1VI85r4UDEwJNmrNy4CAx675pumZcrVauXJ06NG81UsowNGk3L2XDQsw4Znf59ZMnabXNGgSdG
	nVafBJOeP+3BrEzmW3PKDQeABmbRYrQEPAdmlRQiVcrmNCelMpHmQ5DclQ+1fD5QyDU4=
X-Gm-Gg: ASbGncsLt3z/QOxaUuJYYNUjR9NJAn3JFV0T3W6RZIhIt9k2EHv+CFwZb4AJiYWF6uG
	FFRaCDx/ZaVAeJq9MLjnXAqzngL7/uPOxKLORJI6HlYGDzpRwwwT1w3RQ2Yxfxeq6EtedZ8R1+3
	BUIeE3Kfy9UOl0ufHPPU6+NqQaseX2F8gDjd73MkK4zRNqdRJYA3XZhe/x5+HVedZf0O6Nx7sEW
	x0V/WHWzCW2ixyHA+EVW9KRr2kjTZptO3UMW+dMBEp3mR1mR3M2gJsAR95lx1+bCGGnr7u4GPbn
	mqVkKeHqmN/TrN2AgFgk/iVRC7qzaDLWsNJeafAUU3+vheI=
X-Received: by 2002:a05:6a00:b51:b0:740:9a4b:fb2a with SMTP id d2e1a72fcca58-74d2440978emr2677180b3a.20.1751951250024;
        Mon, 07 Jul 2025 22:07:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqHblQbGysxGleH5Wnt20GWtcNUMnVHNG6vTxl/JLNS6asi+Y/ohVURvo0gQGzmU7xlQZehw==
X-Received: by 2002:a05:6a00:b51:b0:740:9a4b:fb2a with SMTP id d2e1a72fcca58-74d2440978emr2677150b3a.20.1751951249567;
        Mon, 07 Jul 2025 22:07:29 -0700 (PDT)
Received: from [10.217.199.21] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35d0014sm10576104b3a.67.2025.07.07.22.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 22:07:29 -0700 (PDT)
Message-ID: <10b11ae8-b375-40a6-88d5-3796902299e3@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 10:37:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] soc: qcom: rpmh: Add support to read back resource
 settings
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250623-add-rpmh-read-support-v1-0-ae583d260195@oss.qualcomm.com>
 <20250623-add-rpmh-read-support-v1-1-ae583d260195@oss.qualcomm.com>
 <c4947591-4d09-4f49-8458-b993b5f95a2a@oss.qualcomm.com>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <c4947591-4d09-4f49-8458-b993b5f95a2a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686ca793 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Xk3zx4k8AspjBMzuXmQA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: ZVaCpMZRwCIghydDWkDU6WrD8kPI58hu
X-Proofpoint-ORIG-GUID: ZVaCpMZRwCIghydDWkDU6WrD8kPI58hu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDAzOCBTYWx0ZWRfX8H4R5ynmHhRi
 noZDt53wTpNvMN5uEABl+sI+IJ6F4dFVEw44vMs+MyWl+yrsuXa2xbqkBhyYDVU0qCAhaXB+DbQ
 rzzjJNTHYcZ88oxnHgcrqGgP7O5Ht3ypG0rcnbvwYj1cUj5W/agADSDk0ga96RWrJyRUw4QgRYn
 m3RNRtTvJNCIE9XXz5KqRDktodWDHdA9C1IbpRMXQg2cSkd0rIwgE+ueiCGQo1qIAqq9K0fHr2d
 BCBl/O3m1jU1B3r3LBXhKLGowsikHKzoo1PiaEnbP8VyW7RWIsDzkoWWMkDxYRDR6BLWAxdeZ1j
 tYTuUIMqDOwcMa8CsT3yu8DKP9xM8ab9j+mtGZ8FCYDpNOhRtBQRjOx+9gCqN8r2IbVkale1p39
 MK+PW22NEALXUvZXYjpD13Bc/zWYMQSQBe83p0GIF7a7S2LOIZDGXj2oblLqhdt5b0HG+uFK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080038



On 6/24/2025 8:14 PM, Konrad Dybcio wrote:
> On 6/23/25 6:43 PM, Kamal Wadhwa wrote:
>> From: Maulik Shah <maulik.shah@oss.qualcomm.com>
>>
>> All rpmh_*() APIs so far have supported placing votes for various
>> resource settings but the H/W also have option to read resource
>> settings.
>>
>> This change adds a new rpmh_read() API to allow clients
>> to read back resource setting from H/W. This will be useful for
>> clients like regulators, which currently don't have a way to know
>> the settings applied during bootloader stage.
>>
>> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>>  	u32 msgid;
>> -	u32 cmd_msgid = CMD_MSGID_LEN | CMD_MSGID_WRITE;
>> +	u32 cmd_msgid = CMD_MSGID_LEN;
>>  	u32 cmd_enable = 0;
>>  	struct tcs_cmd *cmd;
>>  	int i, j;
>>  
>>  	/* Convert all commands to RR when the request has wait_for_compl set */
>>  	cmd_msgid |= msg->wait_for_compl ? CMD_MSGID_RESP_REQ : 0;
>> +	cmd_msgid |= (!msg->is_read) ? CMD_MSGID_WRITE : 0;
> 
> if (!msg->is_read)
> 	cmd_msgid |= CMD_MSGID_WRITE
> 
> looks more human-readable

I will update in v2.

> 
> [...]
> 
>> +/**
>> + * rpmh_read: Read a resource value
>> + *
>> + * @dev: The device making the request
>> + * @state: Must be Active state
>> + * @cmd: The payload having address of resource to read
>> + * @n: The number of elements in @cmd, must be single command
>> + *
>> + * Reads the value for the resource address given in tcs_cmd->addr
>> + * and returns the tcs_cmd->data filled with same.
>> + *
>> + * May sleep. Do not call from atomic contexts.
>> + *
>> + * Return:
>> + * * 0			- Success
>> + * * -Error             - Error code
> 
> This isn't valid kerneldoc

I will update in v2.

> 
>> + */
>> +int rpmh_read(const struct device *dev, enum rpmh_state state, struct tcs_cmd *cmd, u32 n)
>> +{
>> +	int ret;
>> +	DECLARE_COMPLETION_ONSTACK(compl);
>> +	DEFINE_RPMH_MSG_ONSTACK(dev, state, &compl, rpm_msg);
> 
> A reverse-Christmas-tree sorting would be nice here

I will update in v2 per reverse-Christmas-tree sorting.

> 
>> +
>> +	if (n != 1 || state != RPMH_ACTIVE_ONLY_STATE)
> 
> if n must be one, why is it a parameter?

I will Remove n (which is always 1) and also the state (which is also always RPMH_ACTIVE_ONLY_STATE) from the parameters.

Thanks,
Maulik

> 
> Konrad

