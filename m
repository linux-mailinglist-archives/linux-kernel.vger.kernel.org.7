Return-Path: <linux-kernel+bounces-840095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BD4BB383F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D35919C6F64
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C2F3064B5;
	Thu,  2 Oct 2025 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fhk3E+qT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67AA3054E9
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759398558; cv=none; b=cQ/rut1T5jvGBYF5xkYRly36usinLWKDgz6xAWe0AvhOGEEyg+e8aDppBSMZNNx1RZbx63xkRnfOJ542ahbHRzzqb77glCUnjwxa2pq/OHrtPMv43JLhxyeaRAOCph/G7SP5j5drOLLDgu/4/LqxPlWQoX8BPDIHtQ1fRRP7j1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759398558; c=relaxed/simple;
	bh=VrjKFZQItoT4n8OhJi2ZmRlOxrb1AlRNjg3CoDyZnpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Beu5vE9lPtydkq2VoAbxqdzIIOZ5ZDVVFETyzXBQJejTd3rbpVtHpFurWJNkpXptYODIzdUqQxZVTbsXVYEFOU8BSMyj48s2bO77r5dMMPEwOCMFkGwZfj+CNlcJe6o2qK9LphYfT1MlAqed8hMIa2sRF5qOWyKeKDqwlZmWuzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fhk3E+qT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5928LvtN022677
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 09:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Img6lQjVNXbCTpDlJrOjPGysxpr6pRA1/ab4mNuUpA4=; b=Fhk3E+qTmHWIlblf
	L4ACNzgDuKRMXG6WHcZtGjMwrGv7gd5/1vFj9oGuwZrgx8t+OTHNdJ1LrYl0hMRA
	+jvULuHdc8KMXY0nZ+1UjtqTRkVnGOpLjI9K9MMzS96p0Guva+XB8AjZlDa6TyEw
	ASzsAqCPfQbdSwcH0+2iv+MeQf3hIaY08+pEO4hBicuKyux0lL4ezYGnEBHrjNid
	TqIHHAwwPV4XzIgnJnlyEwPxz9G/j/QqMw0YdeLba+ypFP9TwMNvPMZSHM+G9Fv6
	XZO6uiyWGilIovJ+2WCQw6WUnLJyEF14o3pfS3yvKez8+0zr82RwYRTG74k7hbFM
	SY8TiQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59n7snq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:49:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4dee3f74920so1270071cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759398554; x=1760003354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Img6lQjVNXbCTpDlJrOjPGysxpr6pRA1/ab4mNuUpA4=;
        b=twFAj9v2ScxUoMpFTbRp2R+fPIHk3oO0pIyQekgyloFFxSHW6lW8Wuq8D3wRqFq8YM
         T0OfI2yWqla3Kt3GrbLj1P7Ze0hbScefvKcueS/kSqlq23DZxpxngVLc9WwLx+PuqpFr
         fTLLlvGOrvaRUoQSvYaI56kwpGYxHn0mfOF9hojodRl/onc7kLl6Iqdq2T/hiLPKGQLM
         wzXs9ZIfFeOoXc0jYdNrt7dGpnZ4By1K4SpXTLn/V/+BnyoHJ4SXnQG0mHOJHb2bEURG
         zEFwfP2TXnVLIaxvayZixI0qGv0/B/1zy26jnmD+awK1H5/1MzlVCzQVBg2KEQmeqi+0
         nKYg==
X-Forwarded-Encrypted: i=1; AJvYcCW8PDVsOZuf8obXJpvJGAOXSSijPM9Al+HyG8at1AZ14cOrNiFa/4Y5uBJyNkUYHpeeSqvmT82rDEvSi9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVtbJmXSdq05PpTMn8fmICro9iXIJvq/aMa0z3DHJWmkUSOnoA
	knql09fOukCXj94reH42lcLk6Bdsdxi62h3RaFnb2HLyKHNNQy/e8DFVpvJdWGHqTBEqHVev3CB
	51QMgf6h0w+fAVZDrlpZIRZblriYTK7HyJ5oHaesogJe9CGc5eZtSwUJS6guuJqUtnl4=
X-Gm-Gg: ASbGncvVOrVlK+Dt0tfitOozTgHBhRgZ22GogUx5MnM7jSOgnwJOvir2NsnCQcBJDK1
	yzxCuXZD6VE8KSzdQ/hIlI1vP3PEGMROCb7Ylf8cZx0gbHUCfFd3DREE050SrC8u7s10123rDN/
	IA+lSbQOsQYQUHkxLjwv4lky1BKCKTYCtMa2utbsdx1TNcZRJ0BWf1fbrkoKhAAR3DprW13J3dC
	ynRQV2DcjTIJ/UtK+g28ooVngWmwakeFerhGbqlK05UfGhTEjyA6F4sXoG+bvMqAlmjA/yRRNNV
	gf2P4gvRUXOFPKc1e676+f1N4nG1bDeFo0G/xiPSlt2ahRd2Uz8dH/VZ9wZkxKAQa0H+O8XjGfy
	uAMPtvDwnQdMRSGIWVFbDPLuvID4=
X-Received: by 2002:ac8:5d86:0:b0:4d9:5ce:374e with SMTP id d75a77b69052e-4e41db86a34mr53924291cf.8.1759398554358;
        Thu, 02 Oct 2025 02:49:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYvtszzD9G5JK83jzL3QuBgXEB9+BD1IDAQm/hRuOJNgt4Zwb2AsOe4RoybiEw3lrFnoG0gA==
X-Received: by 2002:ac8:5d86:0:b0:4d9:5ce:374e with SMTP id d75a77b69052e-4e41db86a34mr53923991cf.8.1759398553536;
        Thu, 02 Oct 2025 02:49:13 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3abcd7sm1524345a12.2.2025.10.02.02.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 02:49:12 -0700 (PDT)
Message-ID: <3e9b1488-7c87-4e2d-8500-30cae30e828c@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 11:49:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8750: Add PCIe PHY and
 controller node
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
 <20250826-pakala-v3-2-721627bd5bb0@oss.qualcomm.com>
 <aN22lamy86iesAJj@hu-bjorande-lv.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aN22lamy86iesAJj@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6gbI3b-KsOeMi0o7aQdLpKTnOXFUptXy
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68de4a9b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=kZOsEFAOBhkG5801Qn8A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 6gbI3b-KsOeMi0o7aQdLpKTnOXFUptXy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX0MUFg6o0YQjn
 8vw58X/VGrZw6mYTInuD4JIQxuSICanJqsuXcCfy0DywzhETnUx0QsR8GrmajCZviR5pJ15rcrB
 9ES2ex+q51fuQX/Kgakmw1rv1QsDkHiytyNFD5IM2syjlHbw9YZyNjIb4jRtG+z1SGqjAhuesfA
 II/l+QWKeBvIgSisOzJHtQ5qwWt6ohVPpDtnF1NyTs+ONSjEh/vxHQCQaAAIg9mSKcDmW00Xs4U
 JLOtuquPjPTDttlYRbYsnTiWgzTH4eJ14NMW7zPmmK48VGobOpQtmpfR7m8TLbxPw9PyWHs0i4s
 HmdSL4XTb496fCNUXW9xKuRj/MATVOqwXq8haPSgmyEz/JvOphwjVfmOPHPZx9f1YVdcUloRt9l
 AOwDrEbAAQpsXuDOKhiNVejMxlwQ3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_03,2025-10-02_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001

On 10/2/25 1:37 AM, Bjorn Andersson wrote:
> On Tue, Aug 26, 2025 at 04:32:54PM +0530, Krishna Chaitanya Chundru wrote:
>> Add PCIe controller and PHY nodes which supports data rates of 8GT/s
>> and x2 lane.
>>
> 
> I tried to boot the upstream kernel (next-20250925 defconfig) on my
> Pakala MTP with latest LA1.0 META and unless I disable &pcie0 the device
> is crashing during boot as PCIe is being probed.
> 
> Is this a known problem? Is there any workaround/changes in flight that
> I'm missing?

Would enabling USB fix it? I think we went over it with some other IP
block due to funny interconnect dependencies, but I'm surprised the series
for USB is still not fully brought to completion..

Konrad

