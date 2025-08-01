Return-Path: <linux-kernel+bounces-753881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C19B1896C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EAB85A1AA2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F113236A9F;
	Fri,  1 Aug 2025 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KG8ggaha"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070B2367A3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754090832; cv=none; b=uvqeW2C9m8sKotSXfHRcSb8ByX3Zml0Lu2AiqzHk9C/MW60AlidtLGYjfgDBoMVlKOAjG9CTtZwgyRAO6tPTJ4jacM7954U9BPACQPz6nCuPvw+HQ/jULZRVea+9RaIrw3c9V2+zloBj8dMsrKQA/UqPjO+YNJDiep1mcXKGinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754090832; c=relaxed/simple;
	bh=5zD2wU0RPedSB71xOIG2wO/sVyEkf/oGBni2oquUu7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6MUfWmmKka5y8tdHE0Gamku6iE6qpD3oVMsblXUiCst0CdmZm8aVEdUIPjn6r0uiB9pgHRXyHRJQZLxN4z2t36yck/POxhkZzkxIGYxP8l5NlUY30owRX4NymWregcivcE1qeUgELsci1hGC8xiCcHVhBLoyRJjbE70Gn54tXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KG8ggaha; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571LfFKa018304
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 23:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a4iwmGaik7FqRWxLvl/RYLwX7bMNVlJbG3lnXv3lDsk=; b=KG8ggahazOlKfkrC
	h1/JP4JFgeXGN1oNnvOGbsbH1MAxLqSXxn1NMWvcY6tfzZMZyXpapwxna3WQh8jE
	Wy7xd7qfIw83BnnGZ/XDMCxBtYIHni+0bjDdPJMQc+ssPi1tXrfr9R2NYb4zSF4o
	LzjP5osb9NgW0hJReKl9KAd6DB09d9LpMeX1IA5srt/k7reN2cJe4lp4hJY2Boa6
	jNlNbFXJldK6bEMopFHyDtu/74JjnCaTxTk8O7T2rrafbbtJnlDATtsMIdAhb9ZJ
	OEYHDTCjjfOVP0+arLMw37tevRMCM36JY33EOYJ47j3eyMCFnyN6WbgfA09xaV2i
	42RlRA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489423rbt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 23:27:10 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76bc511e226so2209333b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 16:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754090829; x=1754695629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4iwmGaik7FqRWxLvl/RYLwX7bMNVlJbG3lnXv3lDsk=;
        b=UX8Y4de0bjNn88nNK7VXakyMlBcbXd7GWqwyV4V1G4QtVr56m6wBz3/10+SPQ3cK9U
         IfxT/JR1CYLI7vA/3+vY2rzOmx0gDk6XCwM5IhfxP+oPB/X9FA9XRaA+4VYwzEBhVlmS
         MpReK/xZYhXsFeBDxMnAlmwWAfVUDzaJhTgImGv16TFDJJxOU7SZ0+zX0LUGZBToxypr
         iKB7eYDlxV9O3ljuca25EHnsQqSQCH96U6TV2bB+GkgRCDV8n5aAXv91zjNnA9UsryaH
         vdltVxk/xuakUp+QtJsa6KmeEzbzMuZv3dOnoX39RkOjykUsuvnNU97B30SgYDN5k5dh
         6U7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaRx9YKnuOcDwFSOq9b4AH5egUF0jv6i3bQnHhEAbe7ARqmb5PXIHPfeJrQJif4sFm/QJ1IO0ueCsuY3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwIZuT4egNsr3vpcD4OdiA7A+kfTToVpn87QFQhnEThlHVzA+i
	zYhnsgRsn/YkmRzLGeDPDzrID40EYF9ht8ab/kQVh0Ho8xae/a+AWLwgytCOSYUnpnvq9grSvJ4
	pR2Iq066mpGuO67B8cGTRdQ7o1m3OrGigIoisn0pam69X3jvOQNtrPqajzpsbxSVll28=
X-Gm-Gg: ASbGncsjLs9OGfQ5GaTey0RI1TcPMaPW4KFT7qcd/+Pku9e6h+NShH+wh9UluW37MGK
	tfBn6FB1NqMttnsL/iAknAqWQwzNscjWr+aVcpuAWzwW2VWWhKjZ39DWJyZHwjMtaZct6mMCoMP
	9lZXIu3Jhk7rUCAV43lXlFdOYKBBPCQxOKb72HptMSsUxf8p1a/ph/ELml5s7LSuJx9GHkzobdW
	ME2j9RMiojG3NqShPIvH5wQo53vhGqgjPAmkA7hawIA+JNMIFS6sNEycV9hSdIynAVtYW1SmDSH
	X24d1uMRf23u+DsljwFEYfDz82EVRe2Stj+zi7ut2LN+iF6wyPZZ5715kPQpZJ/N5Kelt1z5/Zx
	dGib1zrkCogzgtSVy0K5WXlpfS3IMhg==
X-Received: by 2002:a05:6a00:88d:b0:749:4fd7:3513 with SMTP id d2e1a72fcca58-76bec4c5440mr1401695b3a.16.1754090829192;
        Fri, 01 Aug 2025 16:27:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGru+DQkMQeTX4Aq4nDQHiVYbj42cjgkZZ7g48nRXf2BhgxKbCqcIJO1LIRLpdO2wrIjqiEXA==
X-Received: by 2002:a05:6a00:88d:b0:749:4fd7:3513 with SMTP id d2e1a72fcca58-76bec4c5440mr1401668b3a.16.1754090828736;
        Fri, 01 Aug 2025 16:27:08 -0700 (PDT)
Received: from [10.71.113.238] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd174sm5037659b3a.63.2025.08.01.16.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 16:27:08 -0700 (PDT)
Message-ID: <b0ad575c-068f-4f39-b086-c82ef6bad120@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 16:27:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: typec: ucsi: ucsi_glink: Increase buffer size to
 support UCSI v2
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: lumag@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org,
        quic_bjorande@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250716005224.312155-1-anjelique.melendez@oss.qualcomm.com>
 <697bb6b0-ecca-4392-9e7c-8d4ef75ec96c@oss.qualcomm.com>
Content-Language: en-US
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
In-Reply-To: <697bb6b0-ecca-4392-9e7c-8d4ef75ec96c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE4OSBTYWx0ZWRfXwVvdGaEdkeNE
 fob/75TOOFdo9zXKHFN985Q+9sSaU4GSznuTKG5J+v25THNWqETOx9Y7oRhe/tA67HOUJRrK2d2
 KFpCuICoowZ4n9SQku26S+IDXrRPZkvPlVHQFe+rM3kKfxDjvcQaAJd3j9RoqBrrsmzeQGxe5q5
 p3AQ2JvY/IDSLLq4e5ToaDcMBWmBK8Hl8WqZ1DZIlOnxO4Xvp+eIWV5HmjLoH5oWpIwZgX4MADr
 jBXC9/bjwwNWUf8c8TZTT6Hp4UHW/xzuh9l3emGfwXImOiWAYGK0sfTZKm+kkOUgWajl1ws7pgu
 MAfxNJZcJwbSPKO1n16GgCRmLmehBHOqRlgDnbrzjmQ9wrUUaBvx05y/67mElCWcimJd6SoWuP3
 OwMyWzS7dtS8BP2Ju0rUi+TDEEHaESStGqMDMtn7iShL5peZ6EEWAz7XhmrD5SV1IYSgs90V
X-Proofpoint-GUID: EhbZb36Aig5jYj4QpglAuwa2QEEsorGL
X-Authority-Analysis: v=2.4 cv=MKJgmNZl c=1 sm=1 tr=0 ts=688d4d4e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=JTuwudAkkWYWUMqqoE4A:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: EhbZb36Aig5jYj4QpglAuwa2QEEsorGL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=471 clxscore=1015 adultscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010189



On 7/16/2025 3:44 AM, Konrad Dybcio wrote:
> On 7/16/25 2:52 AM, Anjelique Melendez wrote:
>> UCSI v2 specification has increased the MSG_IN and MSG_OUT size from
>> 16 bytes to 256 bytes each for the message exchange between OPM and PPM
>> This makes the total buffer size increase from 48 bytes to 528 bytes.
>> Update the buffer size to support this increase.
>>
>> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
>> ---
>> Changes since v1:
>>   - Defined buf size in terms of other UCSI defines
>>   - Removed UCSI_BUF_SIZE and used the explicit v1 or v2 buffer size macros
>>   - Removed Qualcomm copyright
>>   - link: https://lore.kernel.org/all/20250624222922.2010820-1-anjelique.melendez@oss.qualcomm.com/
>> ---
> 
> [...]
> 
>> +	if (!ucsi->ucsi->version || ucsi->ucsi->version >= UCSI_VERSION_2_1) {
> 
> You mention V2 everywhere, but then check for V2_1 here - is that
> intended?
> Konrad
ACK - Will update to check for UCSI_VERSION_2_0

Thanks,
Anjelique


