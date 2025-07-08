Return-Path: <linux-kernel+bounces-721746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A415EAFCD62
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FBA1BC7239
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9422DFA24;
	Tue,  8 Jul 2025 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F6rnSQtO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF96E2DF3C6
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984494; cv=none; b=txDrwCo+s26DQyZwxs3nuJu+uLijQSRwcyn8dANbCipMhIaov5ktSgS1wnLZsRO1kdtpU/Bdi27OuobP9n2CxqKM8nMnqbw9fwb0AnzECxAKQSjrz/+rEj1u33NiJKLT5sRrRV9t8TObSL6nJgvHJHTu1ry3tQpD2gR0/PbSuyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984494; c=relaxed/simple;
	bh=W4WG1v9sXb2I/kGtWhDxlxKX3X37hHMOqHpkdeREnn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDPja2diryLKlEcgAcrg10IPwUa8dyMwx+RXA3zPGO6rnzSqYsMbspvIBe9y3q22syNBs+Tb/4T9zXYro7qeeJCWHCh37Hk0YJ3gTLaC0XK7nP4r/6eySV+Ua6NzAAu5oHGUg2q08IDKWubwAHoRv7xkHlFDhIu+MApZWwkHz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F6rnSQtO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAPD5030392
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 14:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UZ7nubB7WVGwzRgwv+MpJw9qf/qLTu1tPlRVviWppTY=; b=F6rnSQtOru257SeK
	Y2leoYkWhu7c1K3eh6DmuRYHYXTxZU4AbtlK6zA5UDvrHP5LdaYLSO9vQZUOGH86
	IA13GBjYBGzXHCl7bxYAgvYRt93N2OM25dH9g9IJD3YnqN5wmuotrPnVbvbYbNG0
	nUvC+W+Yd1L0+72XqnZSQLC0pt/vMinHqCfqUAC3ipVCgMphys6RSoA+kKbfD3nP
	s4yDHjKQ2KS/XuYYNBbFezPMwwajkUOfUl8STd27AVcXQOonP7c1yrqFbRTQoLS7
	c/K7H5fkW/PXY4ZFOocijwS3+u5olUFBBhftMB2sr0qTjeNkRJYbA00csDfg5iKC
	DYIAiw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b0usmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 14:21:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7cfb7ee97c5so25476485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984490; x=1752589290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ7nubB7WVGwzRgwv+MpJw9qf/qLTu1tPlRVviWppTY=;
        b=vYxhbLkq31mpgxdkHupIqeIJB5pcWJR8p15x/2f7lqnR2qFeXzJ4wKqQFzLEjCxsRb
         jtDWeR99VIVkrH9RsnalWImUZmSvslnEgU9WJj26vO9A/SATtXH7kxYdvKnqlzJnhf1S
         5HxsBDVD0n0gneMl1C5ixCzjKL8nZoV2Flh7uRD5ubEyH9mF5iRWLKK+R8u3KNvQRWjK
         GcvuOd31iCYY6xXeNFjEBc1h+etyZle/Amw5mGvbC9Ug39XzJC3kO/lI9fPBa9kbdSO4
         vT2M9MNBrETxwWX2GpawGW883lhkCbg3DDBybjKtqmZzILQYqMXRV3vT+VA0z3b8RaSg
         rpyA==
X-Forwarded-Encrypted: i=1; AJvYcCXwHO4KcVVa71flbuGWCLU03TBU6pH0JZvXL//bS4BE5u/3s0+SO/K48cg9BhS71EcUD46NhAvpUD1jhrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQhmICzJWJbRL7SEsQihIye7vsWxC3mjow39QnwFv6qNKYrUxl
	xiD+BSPNs5FPjHfMUwkI9R8VubBPlSIRYNUjgvVlJppEIkdppriyvaCaSjATrL8ILfcHVX/Y3K0
	CdU97vuqUT4wIMNAfqhu3I1qkUyVFjL4EcxR3BWuuE3ZPJKOfKUPNQulFdxCwbUAAYrk=
X-Gm-Gg: ASbGncvW7lMwpff8b6bPqOBP1JsQFqp79WyqjfsHDj9OaAPbfCGi8Czr7VXomCBYE7F
	rMdyeL5Dy6eX7hsGhB68rxed7MvUIOcs0qaY5S8NLFNSD3xjupVv6298Zmnme/gn/R8riNeljUQ
	+M6y5fQBKFmD0og9Lv7x8qGwZFKBHjlTGHC1nbr562+V4JZIAGOWY+Hy/iN1gnLNyfvGpR35NCA
	upRwhwKhqHPM5oy8QMVOOsj1FuldQ8PnDX5oBqriypfIvSawEYE099MY1WVkHh0gsqNg6JhdjEB
	BDhJDSJtKkYV8U/ZGzG659x6GZVZuS0qXSLNKGXTp/pWTOVtne+aAzPabhaVqhGK1fYEmHfpiL3
	otDU=
X-Received: by 2002:a05:620a:27c4:b0:7c0:b3cd:9be0 with SMTP id af79cd13be357-7d5ddc71ca6mr869696285a.10.1751984490541;
        Tue, 08 Jul 2025 07:21:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvgYYz7XLm/4x4hZmgdO8MpRNdLKTE8PP6W2tPZyVwIH2dwlcYWFonQij2vtyzfAieaxs4Gg==
X-Received: by 2002:a05:620a:27c4:b0:7c0:b3cd:9be0 with SMTP id af79cd13be357-7d5ddc71ca6mr869694385a.10.1751984490100;
        Tue, 08 Jul 2025 07:21:30 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca6676a2sm7153168a12.5.2025.07.08.07.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:21:28 -0700 (PDT)
Message-ID: <29da8704-5369-4001-8a0b-04a5d1c23dc4@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 16:21:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: ipq9574: Add the IMEM node
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250708-imem-v2-0-692eb92b228e@oss.qualcomm.com>
 <20250708-imem-v2-5-692eb92b228e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250708-imem-v2-5-692eb92b228e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686d296c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=owAxAYLDMf__z6yt7SIA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEyMCBTYWx0ZWRfX2EOF4B03mVTm
 HpQIc0R18kNDrRcG0IjxJ9hJKON3kDkuJf6D0MB+P2+gAwjtoWOVPi9zM06WbCLNUttJmsPw1j4
 nvCpbNJmsu9jhbUxtnjh22h+jKkRY4tdQTR5pgaBow4Hjl0RK1EjP4l9D2Npu9ELBE7S3avSkiF
 kHVSnBmYRVgtOMcRr5GpYJKLog1BvcGYo+tZFrSDb3DfB8NeVHJLhFZB2mYydOlDdugHp2zhtdk
 JbDik7GLQaY+z/F5nbA9gcKXxLdUrOgQyHW5qwoFtz1mZZCMxsoTY+bPtYjkliqzRm7SC3Qmwpn
 OFxEOzSfjgnfzaCKs7RfdXG71ydPNgXq6wCL1FfevZrMsI0u/5XPyCC7bs4dex64KBeSZovCUx0
 MyBC/Df9I6MgQJ7n6CKYXrGTOPehMoDQhKuLADN8QFaxOJgDoA58ZSG+SYk7UQ/oetO3PG+G
X-Proofpoint-GUID: FLpygLxfmmFktABfPEapq7VzlRjei_rC
X-Proofpoint-ORIG-GUID: FLpygLxfmmFktABfPEapq7VzlRjei_rC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=744 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080120

On 7/8/25 7:39 AM, Kathiravan Thirumoorthy wrote:
> Add the IMEM node to the device tree to extract debugging information
> like system restart reason, which is populated via IMEM. Define the
> IMEM region to enable this functionality.
> 
> As described, overall IMEM region is 32KB but only initial 4KB is
> accessible by all masters in the SoC.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

