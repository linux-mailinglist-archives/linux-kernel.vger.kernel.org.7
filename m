Return-Path: <linux-kernel+bounces-765955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10876B24086
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D95586CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEAA2BF3E0;
	Wed, 13 Aug 2025 05:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E5swJDKA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF7D27D780
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063947; cv=none; b=JASi485BKN6/AB4BQIMwolEFXu4+X9XwDtqo6hrt5IFJpJvqTzhXKZYmYJ0JpRe1AxGZ/W+iKerOzGZdq2oLYBhxr/qz1NFUV/SyeE4A0cm2IxHBata+iZNyXhtVf53PuRNntcMeyNbY0qFT2ZFYZuJI+Rdfyeu/EMCyarI3E44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063947; c=relaxed/simple;
	bh=zGwOTcUsz1xirDMHVrkdX/vvxQbHA7GU3AGFpslLXF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gzmnn8mqmv83wr6xrWBTsKWlZf+B/SVml1Oz+jI0734C2L8D3etdEDIV72JPvn7k3ULr3pbwxOoh02p+SWHRtQtRyZk1i9BO5TdSqYqUtTo8vrF8niwTPVWUm4Zc1zsnUPNQge0gfmIbUP7VT2IodQSRk3WmL+zngo5BqmFFopM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E5swJDKA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D3nf6Q029467
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Don7/I9Uj7z5dTSOT5GELdMDcLUsYu7/Ujb3hm5duA0=; b=E5swJDKAH1uztF3G
	lhdB7KhgUNjRtjT0vfqGP4EW5tfyQXb90bo8ttURhP7m5PCr8GhE+nv5695XNviu
	zfP76HrSLq3E2bITYiGck0fyfcen8joBvJzgorzFTQbfJy+PRaJ7bs4eriJsUyqj
	kgmRAz2ADTxUFbiDtE2KgfVakZudUdInTwq1imnO9HsJ+d0T0abxgt9Ry2+nd46M
	u/ZYVzH34R4u9ZtikKyVEY7H31YArJGDrkqRcs0mtVDgBMV1y1/485Yoy1m+bOXv
	KdnnnGmY6ZwQgHs0HUS/3z1XkgnoiHDZKNpx3GkqNl4k5nOIQBmxvRIV72kD886w
	S6q2Xg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx8qy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:45:44 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23fe26e5a33so94540715ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 22:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755063943; x=1755668743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Don7/I9Uj7z5dTSOT5GELdMDcLUsYu7/Ujb3hm5duA0=;
        b=am7quAWZD+vJCMEpnnVV2u9Os4Iyq8AuPoBYOzK9GJb2mcnX4m4p5LtV9m4VGhwFu6
         Hc9SQneLctfLtG6cJppvfOfwVs5PX2ApMQ0FAldbxDJhqpEUGO0F2THJtgeri+VZW+OG
         8Lh7NQ6z5F3rnd1nfmzGhFb3I9X7ZBPBwrNxil4ymdfSmb3XB2G+LZX87NZP5p2CwoSC
         Q1siNi0G5wUttZ9vpfEnUeb1ZZ8zW2HgfdpBuSjBl1vfZV1tPsS54O6kzzw0kGWmURgm
         D6RdUDVf2foeRBq9yl45Dn33zVNH8K7MI/LRFu+EHk1xLBzPanx6M9rGCykDYTP85cHD
         z3gg==
X-Forwarded-Encrypted: i=1; AJvYcCWBZcdIMGfIPVkDDfdQ2QVgBizCzeqb6J3p+w95Ta8Q3N1Ktzh037ipQcscLjVJ0XSJ4mGjWbm6PlcTgl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylYmp9KjF7N/zklsSJ+Fpdwo1NXqD8kCjQxvco7XefT8yQ7+ov
	wm0jdAnS7Cp2G3uyn2d75KrdRdYkj3LGQVt1zs1bc+07snz9D5qnojqBGoWfF16IXjRxqEgcMMp
	3ee12fJ40b561h3aMB1eaJhIsCLUSn3cNNlKJgxIpFraZ4N6aDwLOpqaK5q7e4Rhd5EE=
X-Gm-Gg: ASbGncuK2jL7vOF60shPqP9nqfKsHqHVAMUjmzZqhoib2aepMdTQrFl/gh5iHnD4+Yi
	b7tzYAu6mvpxpYYtxl57wyDEL1ckv0wqwFYEMml2J83T/k5vJOMINjxAJAnNdeQTxSkwUxliMjQ
	Px9077M2Vrg1IJMUeTb9FwYUEvaPl9cRBjwWMqVf56RVQ6kVSZ1ys2O5qXM+ZZp8bTNLSDodfno
	t18qqMpd+cgDnXYn4eWRT5CnHswroXGxTCQlxTJmkLQ47rzpuzTcxrQQB3VGe7FHve3vO9ZyWSi
	ODe6BiBnPS3KIgAwuLgVolf+TtWB9VrG+7+clNcUFJjhEzF3dy77VDNOQW0OLPwo3VWc8dI=
X-Received: by 2002:a17:903:2f8f:b0:240:8262:1a46 with SMTP id d9443c01a7336-2430d10f333mr24296915ad.25.1755063943179;
        Tue, 12 Aug 2025 22:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKxGK3btWcsA2MMJlDGujnyNgU79WdDiyIV0PIuwBRiNdl1y38tWiB/pb09bnsoSZftYKpXw==
X-Received: by 2002:a17:903:2f8f:b0:240:8262:1a46 with SMTP id d9443c01a7336-2430d10f333mr24296635ad.25.1755063942755;
        Tue, 12 Aug 2025 22:45:42 -0700 (PDT)
Received: from [192.168.1.7] ([223.230.83.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a51esm317556405ad.115.2025.08.12.22.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 22:45:42 -0700 (PDT)
Message-ID: <7c96f881-23ae-484c-82b8-d388a5c637ca@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 11:15:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sa8775p: Add clocks for QoS
 configuration
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-4-odelu.kukatla@oss.qualcomm.com>
 <857f56a9-0fe7-4c10-a55d-b00740a8be02@oss.qualcomm.com>
Content-Language: en-US
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
In-Reply-To: <857f56a9-0fe7-4c10-a55d-b00740a8be02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX/69es9V4cAEe
 RB5K0XPFdXru5fUMKR6XVOJwypTH6afa+tw62JABxdPe1uqZJEBHqCrFbeKbQSh5N+xxOOMOEIM
 HJyjbxw3mWi66G4l8jA817MUm/thoEoO1rriHQ50I/cOrx+zcsngASDkA8gzsh2JNET/kDxUCQj
 HWvGmlMOowMj8Y+7GeEK9u7WKemL7qCzeyd2OayInTFyY7lanBANCGBm3UClG20PyLv6JDfsLDL
 uNQZZxjnsdy6R5br6jQ0Bs+26zUnaT551r9uXvlhQpe8CFBrOfW/JBczC1uF9u1ygwhd+VFT93w
 K4w+4IwUpsCw8Jx0hxFqjT7dKO/cUED9qvVfMrzgwgbiKSl4P3v3aEZWsb+2Yo+dtMlkIvSu0Sk
 3QpbKqKO
X-Proofpoint-GUID: r4e97djYL5QovaKBL7NJyY42zuRe89r2
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689c2688 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=SiMmawhtwnuHYgKqZ0PRSA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=XLPuD3OmIq6EDVKOuGgA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: r4e97djYL5QovaKBL7NJyY42zuRe89r2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057



On 8/12/2025 3:21 PM, Konrad Dybcio wrote:
> On 8/8/25 4:03 PM, Odelu Kukatla wrote:
>> Add register addresses and clocks which need to be enabled for
>> configuring QoS on sa8775p SoC.
>>
>> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +		system_noc: interconnect@01680000 {
> 
> stray leading zero
> 
Thanks for the review, i will address this in next revision.> I also see there's a camera noc.. are these controlled internally
> by Titan nowadays?
> 
Yes, camera NoC is controlled internally.
> Konrad


