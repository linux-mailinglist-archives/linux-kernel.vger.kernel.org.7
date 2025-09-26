Return-Path: <linux-kernel+bounces-833947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75637BA362F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FB117ADB8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3782F3628;
	Fri, 26 Sep 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KFtKmtpo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148CD1DDDD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758883403; cv=none; b=mRUV5Je6vx3nXGeOBtoduyhexUc7Xos/Hri528EqW43iU27UQFn20e2mAU+SSq8lQV5Xv8jDAFHBNyk13FLTrZwXtdKVzOUVWYVp3/hrU8uzwZYsG9K1JHx6NyxGCtXmTq2nECrgGwWpe6sNNqfCg1fv4pAFXIqxYbrbfyf44Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758883403; c=relaxed/simple;
	bh=lzyUulIki5aKGPpP5fVxe5nwy/H12MYEtLFh8WNx5qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gu/jkkq4VZcdyWl1XcpRUMuE+/l2grjRO+RMluQMukN+pemy+H8D8+pw9Zb2WFG9DlsD3cNLHess2OcB0blLwzmdMTs2k7+Zn4UPR7oi1DOB1Qah/JYytDmEKgoatD8/hr1aOvRY0WidvvfIw/ORj9IPWX/PVpFn/kBCMWSj8OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KFtKmtpo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8veL8030681
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fBCHSYPAc7F0Qe+9c+6IkF1CaX9YY3oLMq9wdEIkFIo=; b=KFtKmtpo/IoZsy6E
	tBx1P3mAM2BtU8j+08faoGeAuRj9mj2nkv5i6Qt/udLmmNUwoL3bYcqkymPQ76oq
	Hd6dHseH85yFTiTD5EKnA+HQd3vrr/mLY9JrD08jpG3Zso5PMG8bJRH0bPaBXTPb
	21NI2l5gIxArgTAXjCh1QFHIPNuj9Lvh0uBRka+TQ2qgWeyGwfDYJ8SHgB39AX0i
	/IGFhOpoCDJeb09Y0sy+3JjSS171NTxTXQdH5OaQKfbb6IdMr5nltjEZoQzrG46U
	rLo2wdjDGVFSMCeFNl/Grp40o6PodLUKlpzo48EjpIM9RnAuGy3XmslrYydEgRxH
	4qdZFQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u2gyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:43:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8171dc0dd7aso46679385a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758883400; x=1759488200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBCHSYPAc7F0Qe+9c+6IkF1CaX9YY3oLMq9wdEIkFIo=;
        b=PbNo64XaoD1zfvmph0MvCZrZOjQOcQwXtjJGhwBpZTziMH+cqr9ycUun/yU5P3bCCH
         /TwTSAWHk9+gFlv6zqecN3lR1oE2cwb9eAV5jBnbMVMc5r2PqKLeMmjnvTttH9Gzp9JE
         LJCX1zylryHGVYnnMgHpiWyMG3kRFEs1+zj85PiMX1yYZzSQrpDso0hknk2nSkoURsgS
         Tff1eiLkN8EG3vQ/ELoBdIUBea8Sx2eLmaMB8EyanEFh8NEEaQrytNip0qNtWrq3PiAN
         QxHiIDc5AGxB4BCSynDvdJpUzWij11h5hG9qvm4N5xMW6dli6Gw5f88dxolbFTLrj+6W
         KSSA==
X-Forwarded-Encrypted: i=1; AJvYcCXVa5JkzNKFYohHMpE7fohF/MtSf4RjhAlygYqqpv4bVE8eRnfIFnyhycoaD2Xc43AD9gQL9sNe78+0sXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlIXEyDAiOu2FjcmWyTJomrpazYRMypgC0cWLP8RHEU2IZbMPF
	LWawq170vKqFmW8X7AjjH2MOA3VEVx/hxKnXCotKJOH/P9OiGVFr83taPINx8X3gZwwvWftYTbU
	V1h0PWsuHP0op0+6we5sas8/b6y6R7nsSnriTM89AjX7osgr/nYV6+GmE/WF14IzgvNw=
X-Gm-Gg: ASbGncsJDh0LINFbFvW3g//iK93EijOk5vB+TTU1yFuBcVyoQUigNVrf1uZ+X0a4yvs
	LOzxUFAxZq71MhaHN6qo70jWpMd4f0YvguX/pwKKvndX3Yz5zUF4nZBETVuf6gv9C2PjRtpYvu8
	IgRy5Lmv/IP6t1rGitF7j+1zd1tyUgJbzkdD/vj1Yh9RWTGX64+fUj24gkxO+byTMStStB6/Zho
	4YhWtYLsDQAmOfl7eTZmE5HF3oXuRhBbL2Ygp/N1LrL/lSvvvABBVukeXw5Kv3EuXTe6upLpOXi
	PsEe4MHx8cz0Q/jzSHSFEO0ITCUfZ6SX+X3sDDGEyTICCcoXG+nJ4ZeDCEh6x0LWHCHqMu7U444
	42FPWWTsBTKXbwnc6vIIhMQ==
X-Received: by 2002:a05:6214:27c3:b0:7e3:3baa:961a with SMTP id 6a1803df08f44-7fc3a977b11mr70955196d6.3.1758883399989;
        Fri, 26 Sep 2025 03:43:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGVx19skRWQQlR8EDWFUgJT0cq0EvuBNJ2BsNp3bV9umJfPc4chZbhX8d3bAvp9/otYjBeqQ==
X-Received: by 2002:a05:6214:27c3:b0:7e3:3baa:961a with SMTP id 6a1803df08f44-7fc3a977b11mr70954016d6.3.1758883397116;
        Fri, 26 Sep 2025 03:43:17 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3b05779sm2734879a12.49.2025.09.26.03.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 03:43:16 -0700 (PDT)
Message-ID: <57be4253-485f-4a24-afc0-a25a3c33caa4@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 12:43:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: lemans: add DT changes to enable MDSS1
 and DPU
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-lemans_dual-v1-1-9c371803198d@oss.qualcomm.com>
 <nnvjazbxpywrmjnt67isba6m3ld6rqdaiid4qeczunmuablntz@vlbrjnxj5r2k>
 <d451f8f0-d2ab-44eb-bfcc-ec1e9dbba060@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d451f8f0-d2ab-44eb-bfcc-ec1e9dbba060@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DqYsFeULtt0YeiwByUlnrR2qN-sQSYuZ
X-Proofpoint-GUID: DqYsFeULtt0YeiwByUlnrR2qN-sQSYuZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXx5QlDWptOECK
 YI0s5pcAkA2sxWLc6Gd2YHLWnoGRG1ydktnFS4SUMQeFDNiC9qTXn3g0cjQ5JmjHreTSv53MMHN
 3zRGm5YDmtW/Qi30wl5GD+Nj1eFJs9KibStOBYxfpfvk51vXQ5nypMaFFd1abgd1Oh9L+496sqg
 +07LxLKUhAVreunDGxmv2EhdYVOUpp8aZhloXHZxeKePN8xTCllLhszKR1gqWH3lVKyuIOA4g0D
 yaIeRT/IBj9rJuGWlVCXWds7saKp7qncwGe+OtonX3ef4slhnuj14WaufMyEXL5UDR7ecbHESo6
 8sAZRi0bo2bkZ3qpW0OETaMfX+RrsiU5Gvpdl0bAdS9himnQYhu0izwHiohGBzlB3pHeTleWumz
 +ujYaSEVp/YwiDirU0KN5lwEBXOhWw==
X-Authority-Analysis: v=2.4 cv=ZsHg6t7G c=1 sm=1 tr=0 ts=68d66e48 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=_fRLgir2w6SQuGl5B5EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On 9/26/25 11:24 AM, Mahadevan P wrote:
> 
> On 9/26/2025 3:11 AM, Dmitry Baryshkov wrote:
>> On Thu, Sep 25, 2025 at 02:28:07PM +0530, Mahadevan wrote:
>>> Add devicetree changes to enable second Mobile Display
>>> Subsystem (MDSS1) and its Display Processing Unit(DPU) for
>>> Qualcomm LEMANS platform.
>> No outputs? Should it be enabled on any of the devices?
> 
> Outputs  and enablement are include as part of this series:
> https://lore.kernel.org/all/20250926085956.2346179-1-quic_mkuntuma@quicinc.com/

Why send two very related and interdependent series separately?

It only makes it harder for the recipients to manage and track your
patches (there are ~100 emails flowing in daily, now more because
of recent SoC announcements)

Konrad


