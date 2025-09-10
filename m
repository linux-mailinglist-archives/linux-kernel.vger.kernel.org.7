Return-Path: <linux-kernel+bounces-809750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CDDB51190
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBBE1C253D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D572C11F8;
	Wed, 10 Sep 2025 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H5AYeBDd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DB119597F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493475; cv=none; b=Nh6/x/WwfBek5DE3wgSjpRpQfSpHQxbfGgYvnTGgVZrel2JED+KRIMoZxt5OorEGHgP85WveXcPCw91SmQxgOA772Z4e7VNUSG6wxYazJkfat4pKSXIEYb+UJQXILwRARJt7hdmdOGhDJb+9try8zysK9FAErKFA3xytoK9DVSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493475; c=relaxed/simple;
	bh=BWGBbMRYr4HuFrGx46ITqeu+2gtKn3PhByFqYcAPrI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRSuWVM0MxdWfQ65faqNC5AE4Oibbyu6UUbabyurOXfJMXtvjM3DLYishztEqUfwMcsOIcxnKmwB2cy2g+QrGrVC72J9z4j004S4CIpnNpK0w/o3wvERj7tVeAJz3CSQtw7NvuXpPY8aZ4l80SXNiAxjvTP25CGQ/uWNFkwQdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H5AYeBDd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A7cjH9002868
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	21u6bcbJ3lyG6GKemCvFCPvqIQDuRSBmxwYo3F4Ym6U=; b=H5AYeBDdly3YmeFV
	gUAaGRENvp2RaT1yVoP/1ZNPxsOKEvvp2J3jl5zRRx36ACltVspq+xfxB0LFgf+v
	Q8sC6venfb2CBx/A70z5QM2D51dvqpubES/pT+bWoZh7HtC+NOOCG8hk1ImPLXcr
	LJ3pj6j2hZ27qGoq5Cc96U3eshrr6ID2ZIC2RsiXDCs3KRkqatTJl+NFo4lG6EKO
	85HRLzdXSh+fLXMrMkL6GIpz2Fj2znY+sPETu35MASLEpI8wAOS/R8omobVVk5yL
	WSWuINft94u0/qQWvu9K7x0cCPuUYRc1Pu+NZ0IJRVwXbLjaLLyPXMZAzNetfzXP
	XbL9oQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8ab3bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:37:53 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-71ce3c952c1so10538536d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493472; x=1758098272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21u6bcbJ3lyG6GKemCvFCPvqIQDuRSBmxwYo3F4Ym6U=;
        b=Aq3h4DopDEpPp2dpE+JZqwhvXjgLpsJr9whfzVdhgsxDnF9xyQHWxf9PgiHSKufIfw
         T1QKnWqc5KcNhod5dRqZzKY/PLIwIx0FyNYZ3WajYAFprIv7lBC/G6WoKjsajdIY1CUt
         qMbswhLikXGjwTt1dquBgD/xQ6t79kVB5YW5j07Br8yHqW9b4tnR0vKdgQAUSu5GJP6H
         egUVEqkAtwidgtDMI6CpMi8flg/UW2xfugJc1zqjXFDm+aJ8/BGRbL7lZsoVt9NOVr6h
         DAIfe6nZoa3nNJg76c0hkFarnCm0BcYCdxM/ufEFECYLpd7WkWPYo1WZYR5jV8Q5mgB+
         EFJg==
X-Forwarded-Encrypted: i=1; AJvYcCUGnCV9yvuGvSHmM5h/mfvYUTyCD5avEq/9jjNrpKgZau8Zazpprrrr+jZV2+62vPTWeJL7hkbquWFjNpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZEmgToYHyOi8/Nk0H3CoPYQhr5KOOq/yie66zMULru2UXc3ck
	WziMoy9Y6Miy7qF6/QLPyWkJ5s6GotcJhSHcuQGmxFbuzuv40hRvTe5GBIjXm1ulNSwk0BI/8Jh
	4jaLNLh+oKUErzgMIvZt+JDv8M+jj5IuQu/5GVHkSBkSCqYrUdoLffBDv3Y/4ZVT9DIWdA73A4i
	A=
X-Gm-Gg: ASbGncvO729Az5YsVtuBGDLQL4nuFDiYE2Sz40kn1hWAN5fnxyxyD4IHfvjPE2RY53j
	MXSur7bPV950lnRfHQxI6TM2BZLakD/zhrRkIF+YzJ0vvcpqildqw7YBziEaY3HMWws0QJGlOvA
	Je5n/lRnuI0wTNzC2mgzr/XsbnmMwccK8eRO4Gw4d05k5kNU3Qd5vPeOJe0uXC/uF3+xP9ptgRN
	xPypASM+XH/GyfUYyMs1B8c8iF7FCUHWpHspI/HhE2oNigW/cOIkyitwfRaMqChAkvFaTbu9L/P
	eGEWTBMy1GoqbRmIfrngnGyk38Eea2/iPSKqZ1LB0617Er1aXF3JBHFAqU0A0/XDQ8XSOymdaoD
	e4zdr9ai1mrviwJIa/qGa1g==
X-Received: by 2002:ad4:5b8b:0:b0:728:dd23:2e34 with SMTP id 6a1803df08f44-7393e935346mr98937426d6.4.1757493471915;
        Wed, 10 Sep 2025 01:37:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErFxd7DKjim5PFA227aBvfe9SUcXcSw3gbPmvfu53+B5+yp3Nrd8csJWabn4UO+eJIZ+tr1A==
X-Received: by 2002:ad4:5b8b:0:b0:728:dd23:2e34 with SMTP id 6a1803df08f44-7393e935346mr98937376d6.4.1757493471490;
        Wed, 10 Sep 2025 01:37:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018f660esm2794149a12.38.2025.09.10.01.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 01:37:51 -0700 (PDT)
Message-ID: <66f67ddc-93c6-4871-acdc-01623468f7d4@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 10:37:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: pmic_glink: Add support for SOCCP remoteproc
 channels
To: Bjorn Andersson <andersson@kernel.org>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250902214544.543038-1-anjelique.melendez@oss.qualcomm.com>
 <y3jxi3xmm4lkvgud5keuu4qv7enqfe3z2y76gho6eal32k7cnk@zv2lat4mjqhi>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <y3jxi3xmm4lkvgud5keuu4qv7enqfe3z2y76gho6eal32k7cnk@zv2lat4mjqhi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c138e1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=3t3APiGufTZyVCF1T34A:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: tveSU1HJmvpUjVdA9iJP1XyyNGlILPya
X-Proofpoint-ORIG-GUID: tveSU1HJmvpUjVdA9iJP1XyyNGlILPya
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX1P5d1DoRzfyR
 OEO/+PNgHimIEmppQwZIHFFH4MVLbNyIzMDR/Nn0mK0/khL+Xyqa4Xln88TsU4J/BYVpk6p5wha
 7f1HFKWLYdXrXxp9876Obk/CYaSwbfd9mv7Az+QmycJ0RBRWY/dh860VY2sgbFvV0PHx47l076p
 fCbzfi52yuYkKWH4cG6xH2MEKQ5oM2HCCJdUJMPQewGnyf5xpoPqtK5Lrk47zsC2FYColL8MLB7
 ChZeylKvlbWGo6URCIIXpC21b/FR0+EVlFvecfu6ALDrJFRUZGIcJcI/9r67Vv30jTnZ09O1GkQ
 NPBg4WAu8f9FxMDGljDEEtNGdCDVcPifl5mofHXsOSBx4C8PHp2GvPX7vHSUJrvpp5FAeydyMRG
 uXHE3Ljs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

On 9/9/25 5:26 PM, Bjorn Andersson wrote:
> On Tue, Sep 02, 2025 at 02:45:44PM -0700, Anjelique Melendez wrote:
>> Add support for charger FW running on SOCCP by adding the
>> "PMIC_RTR_SOCCP_APPS" channel name to the rpmsg_match list and
>> updating notify_clients logic.
>>
>> SOCCP does not have multiple PDs and hence PDR is not supported. So, if
>> the subsystem comes up/down, rpmsg driver would be probed or removed.
>> Use that for notifiying clients of pmic_glink for PDR events.
> 
> Swap these two paragraphs, so that your commit message starts with a
> problem description and then you talk about the solution to the problem.

It would also make sense to briefly mention what SoCCP is.

Konrad

