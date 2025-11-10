Return-Path: <linux-kernel+bounces-893069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989AAC46750
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180EB4214F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C95309F08;
	Mon, 10 Nov 2025 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d6Hx6yxa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XXoj39u0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18DA309EF2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776293; cv=none; b=VdbdFUbSlQD6ORv+HWK8KtaWyI9zI79EgzDaUH7nUMzENubihQg61MHeYUavZFMk6w/E3BjoqmawPVu4tkh8ak8XMkxW0yGIOo6Oge/nvCy2NHzRYD9dFYXj2SXJfldWCCiSyHXuXttH3j4p1ThO+EjXjjp084J3uYhiKEVG6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776293; c=relaxed/simple;
	bh=cOexLxwVZ+7RbJqpXHMGiW7UdplvSqF86AoVD2IzWmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rprMXFN1wl0/sD+hJzHbi6MyiMfNXJm4UIpzNFIAqrUpXv5jgDRXdUdNB/c2ifafBLplaC1tTX50yMPJEo/Kh0hGCc8GgWjqASS3datlmplu9klBw5jipGgtsGs+GhzW8in7lvwt3Gr+6gdAWWd0X1DRI2BAFEy6og27Q/YUrAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d6Hx6yxa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XXoj39u0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA7h2EB2860605
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fAMlSP1cES968wwO9rlfMbzdj2xWrLcU9q2FW6trd6I=; b=d6Hx6yxa60IwSD0d
	RH28GrzDrKbhwrb8wZ0rihWmrZoldrXU1Y0mIJcC22Oo/17Z3w9TMLawCmn1lLlR
	L0CwwJAW5Oi4UskmEZgZ1CBhpz2F+upHpEGGw0yo7bHyPU9zIhK1wBxom14k5UOV
	cmTG8otm9uY115nKigNPMyvC0GanGB0jHr5RoJDfQXHRzqu+EtVgbIpP7wobv9Ts
	lsmeDYTYO9M7maPPfrWwtRzUxj6LBD4lJrR8D6d2LZB7mgsojudiGmtiw0BTjwoE
	tRgkxh/1yMEXO7TmWqhotr6O4tLJEj3W9Bi0f5FOcxi4GxaP2F7uzhrPwOm9RzCC
	6dhgbg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abbwe0usn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:04:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed83a05863so10712801cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762776290; x=1763381090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAMlSP1cES968wwO9rlfMbzdj2xWrLcU9q2FW6trd6I=;
        b=XXoj39u01KvSfnFr+bZgGSYLzqWN0Y3lzc/RTNOWsRCaneBClTASXTXGWJardQ+7DU
         PodX9CaS964MOpqWmFGvvxqJtr41TLXo1Rk7FDEKNpCY/YRmdssXH8faYcMspGxnhO7/
         Tja1uB33m6Qv7dy9awLlDwmenruLLlPWGX9p29JSAi2rYjpvBiwq/cT0+zoGsJNwH7jb
         COfktdJb7N1MnRdnH2ZGzSc4+npgCADgUJJQdJqDKtkOe2bNOz9YR37HGpK6SeCPU6WW
         hJBzE/LpdH/9V6amV7DrsUtjKFYgQvgcPSxMAtdrKSqyrLb6bWN47E9XVnSkjJO8PmqR
         oU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762776290; x=1763381090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAMlSP1cES968wwO9rlfMbzdj2xWrLcU9q2FW6trd6I=;
        b=fKlUSvAjGfB2vPMHCts2ju0dLQM9CVA2Ap1lfoRuKj6NujaFkgPCvmWxoyiPGEjiCh
         GnpNxVTnqSi1DogtSP8FjyDtkFSz0vbTDzKp0trvUvEbiTp+EyYW3hxaYw3K9kHS9Bna
         MQ0JdXimajWWAQwV93C7i3uM5XnxyIbLYP4aeNg8/r5L8DC5Qd0AdmP0tZfvdcVDttPl
         DBHM9xOcvDEjuGLjh6b9aZOIpt0uBjh+bISc0AceOCVzrbvTRL9dA2UfWN/Y3QfJVPY6
         XcYcxicq5h5BzBOmKhYpZxJ7Ifu1NfSEnzN05D++rjQX+Aqnb4RLrZVbXHnVRGdG7Giq
         z5Og==
X-Forwarded-Encrypted: i=1; AJvYcCVkb4VXwVgyca4SSO7bneBQAKSlxk8N5hl3w5phN8WscqHlmyIuSSjLIB9srQDOibYrWxpLkYiperDs5fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4M+fEuNUxJu+RV+WoYd75z0JpWpoQBfX6CABg6wnMPaDJjm5d
	FHSyW0nKP6hKinJKNy8NPANSBNb/kigTWkATFeI8wKk0C1X0k6XCNBhmCzywaLJLeUZdmebgC+5
	5+/wU1QzO6eNhae+d0Kwwyoh24OYKMusF5s/5Z+/QF74TJGm4Xu9fEyJnVEnHG2Uu80o=
X-Gm-Gg: ASbGncsLdMplLKDhCs3wzefNykNqbszAbyMwEUsPeVXG2wodQBioLbGpq2GUdV6Yihv
	NJzECl6jF2sSw61TPIdXgVwT83tFm1EFMCB7rmp0RcXkRIrsscQyeNbQ0Ed2bKvF2U17wClhk3U
	9iCnJ7PV7e0XuzGuMqkBHfCMQEENg5QOlVAO1NPKylHDBVpJK1Aw6GhsdIlHkAg4ig2/x/YChoV
	SQQpsPu0dxXOAf/qUbVUXIs4ojS97Z78k34Mru9i2lHbP+sXE5MTrhbjOV5erf6286bGL7pHzZg
	n7wuuRr5Gf60BLKm/tfVI7o52fR7Udk3WkfFbAtaYqYFLO20ssO4JQ7YBjc13DSZOG0KxyJlwtu
	ZyfQCpkyOv+s/UjlBignIyCWfOu/y2+l+G0/KlBVyBhaIYQfmUpCc8mML
X-Received: by 2002:a05:622a:3cb:b0:4e8:a001:226d with SMTP id d75a77b69052e-4edc6055c83mr3412161cf.7.1762776290197;
        Mon, 10 Nov 2025 04:04:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzDbbLjdzMiLA+y68+aSiGVjpIJDyiwSr5crhClqs7TwZ7jR7Ff37L74FLOF28viWzc1ZsFg==
X-Received: by 2002:a05:622a:3cb:b0:4e8:a001:226d with SMTP id d75a77b69052e-4edc6055c83mr3411801cf.7.1762776289668;
        Mon, 10 Nov 2025 04:04:49 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf4fbf3csm1069581766b.26.2025.11.10.04.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 04:04:49 -0800 (PST)
Message-ID: <454ad8d6-43c9-4819-b849-c123fa9d33bd@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 13:04:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] add vdda-aux regulator support for QMP PHY on QCS6490
To: Amit Singh <quic_amitsi@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        lumag@kernel.org, neil.armstrong@linaro.org, quic_wcheng@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_riteshk@quicinc.com, quic_rajeevny@quicinc.com,
        quic_vproddut@quicinc.com
References: <20251110115806.2379442-1-quic_amitsi@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110115806.2379442-1-quic_amitsi@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OHxlEGcZ2EU1UdHlheU1vdNBYTJpGb6t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEwNSBTYWx0ZWRfX6mS3ekT+Z4Yg
 q0AHBHqRMGIf0uOpa6jIbHhCEI+K9RlJXlMOaX48/x19TnQqn8IMG+mJ/ES4O9XaKHfffsOWbRS
 wx56nf47QBazsr4E9j0LdyjSS9UsXEsBMt7NLaoSvs9JjDJPG7ngPnZtK08OHYbNZdk0oANeFM7
 +ab9BvpcKHmLfo8wBNAKvrtgsRBytu/WHOYusDwY+DYFZpDd3peBeXBPgAInHjKtmVPqEEAYsGb
 ulwBnUjDvyjGo4FVMgLf2dRNNMuYGXdc2jguyj3/Da6HQOPbXe5o/5FUC+2dB0rN0hD3yE8IPfD
 EC4wx3bk2JSLhGKF/FaPN2eRR28wF4InLKrBV5ZW0mrHhhfSZ/VIVbbHCsiipockCZ9H6vB+Uj4
 W3j+mxyoPg0q0CD8cY8LVWPvN4oMXA==
X-Authority-Analysis: v=2.4 cv=GbEaXAXL c=1 sm=1 tr=0 ts=6911d4e2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yJhrbEhF6J9Oi74tKswA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: OHxlEGcZ2EU1UdHlheU1vdNBYTJpGb6t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100105

On 11/10/25 12:58 PM, Amit Singh wrote:
> The `vdda-aux` supply is necessary for proper power sequencing and reliable
> USB enumeration on platforms that provide this rail.
> 
> This series adds support for the `vdda-aux` regulator to the QMP PHY driver
> and updates the QCS6490 RB3 Gen2 device tree to provide the required
> auxiliary 3.0 V rail for stable USB PHY operation.
> Platforms that do not define `vdda-aux` remain unaffected.
> 
> Tested on RB3 Gen2 (QCS6490) platform to ensure proper USB enumeration and
> PHY stability.

I don't see this vreg going to the SoC on the schematics.

What is it actually powering?

Konrad

