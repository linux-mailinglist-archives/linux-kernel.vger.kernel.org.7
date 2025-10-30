Return-Path: <linux-kernel+bounces-878049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D3EC1FA88
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843F518911BC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FD4350D52;
	Thu, 30 Oct 2025 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="okcTaOwi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="anz8CrSS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EC1351FB5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821687; cv=none; b=MBLRSVgJrlkArTovmcFBGOiCBn2g6/OLOk1MURanv83Imbv20j3FooqSkOo3CPvp66F+Dxx8Dwgug9oGvSkd1ffk9+0Wk3zW42iuefgofV4/BOi1IA7xAvcyFeE/FUKmCXB+kP3Ms1VTaHhvhA9oaekNR/4H1NiIQ6nojHLsraY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821687; c=relaxed/simple;
	bh=x6ubY0xKm7Gv909xQycMEQpIwpOBfuZgYU0dS4xiN8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gr8vsT0yQ/iVlzMa0FbPmjI4iyU9qPG5Su1qdbr+Ec/b25Wk5T1xGeZXuSI9ZMuSfNm9xbwYkCBf8FdMwSkGlGHo8tC+zNKXUKWCiEFU5WKQydeCVEU0SosUygtKbru2BlUX3iPkZ0XR5RVorXcN3Ux/XmpS7tHYYAAr2KjNVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=okcTaOwi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=anz8CrSS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7tjfe1693583
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PT4tKn/R8h2W4C0ZG4ZvRE73+O5zr/xSAQM0yc++plc=; b=okcTaOwi/XrjrMKN
	KhMXAW2c+sD454OmZGxWBBDXXYW68er9PX6bBxp2XyQBNOcezGuXzCxhhXo3J62N
	JowHPIr9sBAHikxNDMw0DcWyUZ6lmreiYfkjqRLmZexzuVEj8ZJRGMBvb1Otq9Wj
	q2NHlXntvV/4X50SgnRz75ctZbewCLyYeabK82gT6dNxzd2T8ND4MyZHB7fHhJN1
	SBrp8Hn0TJMSuUpP8VivVDUTqXY1qovWP3aRekL5e6Qgcd/Fl5V5tpt3Im2Apxzj
	LM9zqld0qnw8d9FWU3gmvDkknz6bTcHIn5xo55VVQhFfzxBp8p7ZH39j+CUl0j5k
	NUyxeA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3trv21f8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:54:45 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87dfd456d01so2907026d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761821684; x=1762426484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PT4tKn/R8h2W4C0ZG4ZvRE73+O5zr/xSAQM0yc++plc=;
        b=anz8CrSS9blaHgVsGDN7kyfAMCU+MAm6zK1lgLN+JCMcydpYWnzM8y2RyXq2zofpgh
         pmea2EPWhPQvfrG9/Y5BFKTTgG7ewnVDRm67GQzPtkAPOGg39GLFJzvQ0YTwzovePcm2
         pArGUfxBDRM06gkajffFZzXsbtKRuvI6ewSAYUwKDpKvp8d7jGqKd0YBzRIzTd5nFHPS
         ovzq21gbnHu3wopnsMFAqw4ep80vXI3kn+athK0m0b6hl+BSioaAT2onF3McaEyYJuTo
         Y4qxyeswSxpN+7DYoTTTfiZH1M7Cy6ZA6Ptu0YMNzzQGrICWzDTlGaqCrIjH6QHi256w
         IfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821684; x=1762426484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PT4tKn/R8h2W4C0ZG4ZvRE73+O5zr/xSAQM0yc++plc=;
        b=f9EkmYnXyxboas0xyDKe38u+eq3lw6JlFIbGhfoUa8XnMREFFhV4bbgvROaeEeYHZR
         1UKm0yos8HLvN/+foVcDeuaSvOjREtFpKU2etZpD2bjWXnFcDe0+8NwYSBIp8Amw7gXs
         XsTx/wCeLlboXDN8uT7NeGqZA1DxZQHy/4fNGNX7mrmxVHGZBfrfF/Cr/ac7ZNla4lnz
         LdKMIg4hGkGM+QYbl24grbKU0uyUkn3Uml6c9C7dqfW07iW7eSNfy00I32zcQNRnedXa
         OO3/m9K/NCROYS0dKXXJsFIMk5OGRh8ZM7vgOPl4Jok93i/GeviMoDYOCbyJlth0v2fV
         1yVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFD9Ih42O9QrY9ndLtP7if3Q/ED5ptYKm6N4V7fpQNh5th51PNJgE89jiKLMmKaSwk8if2rJJK2PHm3FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTgQc4QdsjMXJ9grdx84YTT+/pjK1LdFxSuDab48JoqsJ/dChO
	PGzmd8KtiP7/fXWMPonZQrjmqmxP7GfAu085PXx6iHuo0Nh38amagWIt1REuaeqstSXRIrBHxzK
	5Zdp0bRasPYakQ3O4EV3Yfd8AUSmHXM+91AnZJQ6+zK86uG06JWnsNY0P2sq9f1k3bjs=
X-Gm-Gg: ASbGncuXCUt2QspLYyHb4qIgCsvR2BYDq7KEY33d5UuExCekGNmO3KEWVKbRw0tRU3b
	KMzAy3ro89EvRi8tOuyCFYwyaQrUbsoYziLJHtHvEys8hZfkLxWTuf2pLGEzU1/9ZWWEhH1U6fB
	qHkTtty3REHX04LS1+IJZI9RRqLdMxhoJZj9gj0nPjNOkPBpKJSXhDwFiNK5as3wUXBV4V1uL+/
	Y+MpVRqFqsA72IjDL6pINYZ+OMYfdciWDyawAlXCkmUHRK6KGUZp6ip5DHbATpwKeLZpFp9TWiW
	2zrIBeOT/bFQF4YYplZWIywIk2A2S0NVU8+1v+re4jqiyDijjYDYj7IijpNuDd3DEtaXxoBlTML
	dn3cDS26mKGPGs4Tam9mhzNxecEENOLkLpmvdfCViYC72iBNuhVVUYWpl
X-Received: by 2002:ad4:574a:0:b0:795:c55c:87de with SMTP id 6a1803df08f44-88009bfacf8mr55052226d6.5.1761821684397;
        Thu, 30 Oct 2025 03:54:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/PbghJ+epgDdI+nm7Jz9SHZWn98Ad1jChd12W+AwLx6K9fklYXdtyeIhB/z1yWb3Fz7Jx3A==
X-Received: by 2002:ad4:574a:0:b0:795:c55c:87de with SMTP id 6a1803df08f44-88009bfacf8mr55052076d6.5.1761821683905;
        Thu, 30 Oct 2025 03:54:43 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd116asm14852614a12.33.2025.10.30.03.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 03:54:43 -0700 (PDT)
Message-ID: <c9801322-2184-4f04-9459-960580ecf6a7@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 11:54:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raag Jadav <raag.jadav@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
 <20251029133323.24565-3-ansuelsmth@gmail.com>
 <9343108b-7796-4783-afb1-afe758f78414@oss.qualcomm.com>
 <69033de7.050a0220.34ea6.780b@mx.google.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <69033de7.050a0220.34ea6.780b@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UwswEs7S-NHzzdJg25w58VI0INpCuf-L
X-Authority-Analysis: v=2.4 cv=D+ZK6/Rj c=1 sm=1 tr=0 ts=690343f5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Oh2cFVv5AAAA:8 a=BxZim2421LoXUn75QUsA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-ORIG-GUID: UwswEs7S-NHzzdJg25w58VI0INpCuf-L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA4OSBTYWx0ZWRfX1rPH3p8MU3uG
 710HEdi8c5mN4OoZNV7gHqa2DO3OD6YpWd5rJL0wf7ULNj+y9DpNRqZOCKbnmOcFlWsd2SH+54z
 CZvpN/9GiMGg5/quBgAbu2Sejlur5+zWzVnzcDFlv0TkWTs927EObqy6/tAL1+UI5G/uiuXSwT3
 TMJr6Y1jrrC0xZ/+oWmptwUdg3CHNhC0p3h7u17brm1Ya5PgnnKvp0z6LpTxyoOurGoQc86J0Z8
 btrB0Lk0PJ4FscsbdXGcd6ZeqeHPt3WFGBNrdVQCSZY5dcvA1DKZm5J3cyvTxA6SBnyjXJJLmDb
 ZGs1xtrGTNntcw8mo/poME/aDFJmXCKpc5GikZXBYkQG1JP9+g++LlSCyGft5RbC/ps4XnqY2T5
 xv6WPQ0POWnvihbx/brKiJ0iN4g9Kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300089

On 10/30/25 11:28 AM, Christian Marangi wrote:
> On Thu, Oct 30, 2025 at 09:56:24AM +0100, Konrad Dybcio wrote:
>> On 10/29/25 2:33 PM, Christian Marangi wrote:
>>> On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
>>> case for some Google devices (the OnHub family) that can't make use of
>>> SMEM to detect the SoC ID.
>>
>> Oh this is (the unpleasant kind of ) interesting.. Is there any sort
>> of uboot/kernel tree for these machines available?
>>
> 
> There is some sort of source but quite confusing. From the info they use
> coreboot and chromeos.
> 
> Looking at the source they comment everything related to SMEM
> (confirming the fact that they actually don't init it)
> 
> [1] https://chromium.googlesource.com/chromiumos/platform/depthcharge/+/refs/heads/firmware-storm-6315.B/src/board/storm
> [2] https://chromium.googlesource.com/chromiumos/third_party/coreboot/+/firmware-storm-6315.B

Hmm odd..

The patch itself looks mostly good, although you e.g. assign
qcom,ipq8069 -> QCOM_ID_IPQ8065 even though QCOM_ID_IPQ8069 exists

This doesn't cause any difference in behavior within this driver but
looks slightly funky

Should we perhaps do this patching in smem.c instead, in case other
drivers try to retrieve the ID in the future?

Konrad

