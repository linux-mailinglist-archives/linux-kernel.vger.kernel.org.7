Return-Path: <linux-kernel+bounces-899009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26814C568D4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 706783419F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF82D6E78;
	Thu, 13 Nov 2025 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TR0pXfs5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NxSiKRYv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2EE2AD0D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025319; cv=none; b=SVdDEyalwu57V5RfyAmSbPXrB0y64yTvAhFEEHvPmz48LxbKOLUTszbyHo28frnk4i/p0pO/CnuQt7aLCf7oy1qIMDQY1ZwyWq4ukuIuX7mSUAgSGe25QAqD1OLC1fF3k2p7ME4s/YkHFHnUZocOcK7QiDHIpIkKul2dskxTkk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025319; c=relaxed/simple;
	bh=+2I0kET+9CVqktnQPRUDWWQn11vlGXQG5XhzK2wc0YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ApQTkvt/aHnkfrpUoqmV3NyqhXu+wokz/k/cUfjMtZgC6uDr1p8MQgXpyj2KqOqqBMq7j39iB9UXnAxu0bQjF80/25j8TMGxZubv3q74Tl3T9dyhElaoF8pogZyfpBEgoEwRieCLY56H6uScy94LxGcrEL85WnGGh6GT0dscUcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TR0pXfs5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NxSiKRYv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD8bjoR2993469
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jLP2SIHhzXib+2zlnJMs3Q8griti3mtpmjGcYyxtDhM=; b=TR0pXfs5hGmPALNa
	Pw/FVcmHa4XPGqSoGZq+P/3+rPwTGBZq0jPWQwAz+zXpI/rQs5bgd5+UqeDBOK35
	49F4aMDKu2ibvbGDBiWS9wHPCTt5b4E0s6G6rvtRH4hdUnjSudCzCGzOpqLgNUW7
	6C+dX+SInX4pnmLee56WFTZM4h0+U1U5LfuF68RyMwCPU416m7DxkM4xBFCvvtqo
	/SnjIopHrR1ekE/vlaJE8pDwxdNUBUAAXAEi+z4AahokN7oyEtmLBGAXxbXOiN8n
	GEem0mnZCXnrDvD6jJyb4qUyb4HgW5v9NxOxl6sNVTrs4lK4NnE1Heqo0eNp67bE
	oc7U/g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad47jhkwp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:15:16 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87ff7511178so1558446d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763025316; x=1763630116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jLP2SIHhzXib+2zlnJMs3Q8griti3mtpmjGcYyxtDhM=;
        b=NxSiKRYvPTKGq3BsgAGucLQK6eON6YxhJhpg9XW+4OvDAZUs3hy7OrycsPifOnOiLb
         U+cDMAvFKPP2URzX7aSwHShtWBaiIdecIAZFM93oFbsnEvG4uJFDRL0lasMar6AUZv+U
         u05Sjr4WMvabdPnucyLlVvIlRe5Cqpaotmd5FwMQa9d3yFQ2HcaTCNfFUJ0vqrc+0qhT
         RFPGcGygKeFbizZlNz50zc6RWC7csPMg648yrihoZ7h6sLz3S779NCE0Pz9zwapOqU9C
         02L02IKXPxGzr0bGMdfiEyjKrPELWPKLu271OH8V0hwR0mB3IOonf198Ji1s9Op+da6M
         3bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763025316; x=1763630116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLP2SIHhzXib+2zlnJMs3Q8griti3mtpmjGcYyxtDhM=;
        b=M9YCA2NUhsCbGqXb8FGQevg13ARE7py46bdt4apYG7Bj6cYzk7kENa+wJWWSgpiqj4
         fqUYe9DanOlCi2i8Gv7V225nX8qOUdzeNUUhnDHDsrs0dTRMcxnXdpd7Adfe02Ij53jy
         Rg9vHFakiHGjQD+8MOP+7G7z9FH0l9F3aDjKKDsR0cOPdUF2i2neg3WLZ8Q98/5CKWMt
         PMXCk0NV0KsBhBM9lW4JJcDeklJBldoXemqjl9TGYOcndEzRCkgRlyWbd0w+kmNXqkcE
         mIOftVEbSoztNi7byZcjWavi7E1G6GZIDqNvlDRM9fQ0Kjb9NH6iAJKuR3ODC0kaSlFF
         gXWA==
X-Forwarded-Encrypted: i=1; AJvYcCU/ETizfks1EjeG2dMP8DyDH8pOT1vhg0/giIF2e+iYoOUzCd7Q8WMWGS+v6V7fagk4nHXC02HkecLKnYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEMKc0kbyYXOKimH6z7cWgxBo1u03wG2ICCQ5J1dGOkgPunvmn
	4fu+vzXUp20EpGUBtz0BsanZKjisc8OCAc1i5uWhOr8MQqJ3K2lcy+UFrhuRqU+hBPeTn3Rwxp5
	g+pLo/FsyJ5Rv+6yp1yLYIPnBnsc+F29xmkDub6LvDNgjM5Ec8WVpz24h3K7P8X6x6Cw=
X-Gm-Gg: ASbGncuiOm+WprSb2XwAxLAGUZohZONS0LAkssVfo2/fww2Aes2rg88JNFj/gJDBCyl
	+x4JZRf5Z39+i7ZZMSooarTtA35MseAaoy4yr9xJBImN8TEqdE+eoz6aHT7Ep0On8WYszcCSmpL
	hXwLLHW2W9UYgXpaSGOKjX4DnGR0tGQviRP91WAbwmfeFZo+wO4/ZwRhjbj52lcnjfa+XaKcD1f
	Luc3YLAbHQD3mo59DrZSgC5pa3WObvsQHeTuQRhNZRkH9ulH07We370x+ErUR19fBl6/9j0nMCW
	EJXyXwSSrDzDonEZywOqvHNCP/iPG2Nyx/NrUa/OotzJvUXG377c+3ItImcdPo3+EeRSZirI6TA
	xkFS/hL7tQpooRZrSJWS79cpeP4Vg6nhXrYkn89lvjMmB7z8cZ+Ufn020
X-Received: by 2002:a05:622a:1108:b0:4ed:e2dc:dae2 with SMTP id d75a77b69052e-4ede63aa5b6mr31796371cf.0.1763025315669;
        Thu, 13 Nov 2025 01:15:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV4PFuPYpN0A+ngIo7uy5Nni/EE2S28eHTbVKJjh6EHJpC1GGPOmK562qgRfTr9ZF6na1ygQ==
X-Received: by 2002:a05:622a:1108:b0:4ed:e2dc:dae2 with SMTP id d75a77b69052e-4ede63aa5b6mr31796111cf.0.1763025315185;
        Thu, 13 Nov 2025 01:15:15 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4b28bbsm999537a12.28.2025.11.13.01.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 01:15:14 -0800 (PST)
Message-ID: <cc4d11bf-a0ac-4cd9-ac86-2ff814073657@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 10:15:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: socinfo: add support for new fields in
 revisions 20,21,22, and 23
To: Ananthu C V <ananthu.cv@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251113085432.1309629-1-ananthu.cv@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251113085432.1309629-1-ananthu.cv@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA2NiBTYWx0ZWRfX4dtiT7pLnHQV
 HtUBE39v0YShyBorEYGoE83jflk2BANuVI1rPcJQk3F1wZaA1csm/sch4dnNSzaK6yNAbxFB7ON
 e1tPSRdYkJlA/Fw47iSmzDUdDH/2VcmGWsL3G8xjLAShM4V2CvoJa27Azd+Ih4IlYpS6oLkU4j/
 pFC/eR6KekpWUlFY8cCxr6X4GkSpbkLhVwqR0c6FaxEjH2Jckzkzx67I7MqoLq6LyV12Tz9KGEQ
 6HP+THciYH/YQB3vbM1h8oM7Ut9U1m39gnv7hnJ5ST36SrjBuThs68byIuXDm2Fl/AOlaikoiLL
 NvP17TUvlKoIvj/ZtGS+/wnIvqhnVhBibMX+fcj41la60L0uO+QfChKHvPSeIw9hmhY0L4E4nxU
 PTOFXdNWw4zyxZUPthoftDJ570nr7w==
X-Proofpoint-GUID: 37N5z3fqtqNcjoPdAIX3d0kKJ6kYWqEF
X-Authority-Analysis: v=2.4 cv=A5Fh/qWG c=1 sm=1 tr=0 ts=6915a1a4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=lgXH0h_iqx_sREGEgRUA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: 37N5z3fqtqNcjoPdAIX3d0kKJ6kYWqEF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130066

On 11/13/25 9:55 AM, Ananthu C V wrote:
> add support for the below fields in socinfo structure:
> - v20:
>   * raw_package_type: type of the raw package
> - v21:
>   * partial_features_array_offset: position on array indexed by
>     ChipInfoPartType, each bit notes the corresponding component being
>     enabled or disabled
> - v22:
>   * cpu_cores_array_offset: position on array of cpu cores per cluster
> - v23:
>   * part_instances_offset: position on array of PlatformInfoPartInfoType
>     structures
>   * num_part_instances: length of the array of part_instances at
>     part_instances_offset
> 
> Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> ---

Please follow the existing pattern and add debugfs entries for the
new values

Konrad

