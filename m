Return-Path: <linux-kernel+bounces-745536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE892B11B51
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB94DAA5A82
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822142D3A96;
	Fri, 25 Jul 2025 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LUijmzw9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73E242D6E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437500; cv=none; b=qTzUeos9N+jGinOs40FHv3mhKy2XtGUNYJT2kdbv5hgerCOVF9DSSyGB1PkBYtsSPAFGduHX6K2vre7F92d0ua/SJCSQQKfCd4/URW54HgB6htPvenSS2QyCAB0SiI3qM2zNFCiTOzMvq6R1FB56vgEfvj6A3z1l65gVwiUMAq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437500; c=relaxed/simple;
	bh=2tiAjB0z1k00ZNhCKVrTV+vcG6RgrZgG4F/1kGUZuvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6v45JyoMfNGhM5CBHIyt/8/Gs15+WgAx8yx7flh9om47Uc+hXSv5mT+j9oSYD+T6kbRilefhOtRB2xTB3OmMIH1Wo/VjhSoAgoIzHLQk+x8RR1O9FqPAxsqKXmXEmSscrRTGPNPEUNfF0rnVuRH14h59ngip7VqUEo2RRutDi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LUijmzw9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P8sdYJ017026
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PEnz4H6V/d/qO6cgGDmgOqec5WVf9pfPd1n4f8LtXmc=; b=LUijmzw9lOt/+t8u
	lzDyQnX+L7C65wXDSbeSLHBOvkp/lmMygm4rtqwRyincOqJzn9dB8bXX8qQ8Vqo1
	vh3CB1wewqOl0LgLta56aL/zv6s2dqNZ8PAUJopNeYbwnGdAG2CjuMSIqw2LuSwb
	6rwJke8b4KJ1xULroMWSE1aEKU7qolFYWLdfFya3bDUnRoph8izfdXKAGYQf3iSi
	5XYLisvOCDvGc+IPa3iPN+P+XylGOXrisqxxteGeNVbA1xkkOrtmJYM8sD1O2aDM
	s7YacLYBGyl/72XxPsAPQlCW+Vcf7hg5BNqzVIUJT2mSyaZxVtrWbAP50bqUpNLy
	hSVbUQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2qhnen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:58:17 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-75494e5417bso2144399b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753437497; x=1754042297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEnz4H6V/d/qO6cgGDmgOqec5WVf9pfPd1n4f8LtXmc=;
        b=ecpsOTRku7fpZnCOlC0bhwGDx3ynaEoxz/Yl19KKzEfF0qd5M6py7lTCnykjR8wckX
         MqCK0EKwZnFclxbW+njmGmwIncKu7aL8gPegvcalVWA9VQu/v7qEYHqnbeQ31Ui/DA0p
         bctxFdsvc0twX87R9XYsTv+5PfBvZ+sz7bvhUSrMbIUqlJ5Ok7+Bh1QYvzqMZWxIR6lX
         pOqM+bCJQDzcUY4cKczIpQrach/SexzfTBqPDvSX1oPDGrc5Hyoe7Rjj/MT2OPngH3S2
         3p2WZuD3J/z1f7HfiYY1zMY+L0/TuBrNX+9xU6DfZT5DzxYO6QQqKPysvuF0gZ8ZZIfV
         VQ8g==
X-Forwarded-Encrypted: i=1; AJvYcCXkHZSWIwnVncQhrShW91aI3Lf5vHqfw775jinB2bz0hF3LozQXqwgrmprKyya9ZI1af0AaxoZ00bGekJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKePEbV/xoxTMAYDYVFmVWuAZ0uJi7vVNHgcnKCWb1H6diApZp
	texudbASVIH+xnhDAxcdPZr19V+NXQl3LY6ES/wGpWX5YOaszc1IUplkJe63DxnzZ18B15wnQD0
	6H6zp34I0xdvQWc+y4Z37wkpj57t7p9iz/C9YiJNnOjp55X1oT5+jLlxbgkE1pR6L5ur//iX9vJ
	E=
X-Gm-Gg: ASbGncvelEjZPWw3uDrvQV9GYDHl+YqhKRt6aKRKW+MzhPjffvyPKdm21VAdaMsn0Lg
	yco+wTbgJJa1jv3aJkG3cjtvZertSS00WXGL/w4u/6p3dFo3OYTp+DK+vxISsdOLoQFR6gtoLh+
	thu1Xkmj2GZd2i92uFyzBbpMctVey1iVqFFdiQwSKzqYzaS0vTLVX67PLcBtoPlHCTYZoYFK6/y
	YnnXhBmjTS1OuwSsE7h87EzJmUgb3+32HXdi4yqdgwTNKVaUh7n0RfTMbDjdTWu91LIW92RaPdD
	HAK16ApDZQgdcs86OeJJvMOqX/lo1rbInx2h0Kfc8qaZipPvTG0B7IB8w/jH3HEasfMe
X-Received: by 2002:a05:6a00:2d95:b0:748:e289:6bc with SMTP id d2e1a72fcca58-7633227a158mr1964813b3a.1.1753437496660;
        Fri, 25 Jul 2025 02:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxeluw4+DDKKpWWuyw/4WDEMIRtuo5eBj0yv9G3SoYRav34QjHWJH5owQlj2Q3gmb8i/0slw==
X-Received: by 2002:a05:6a00:2d95:b0:748:e289:6bc with SMTP id d2e1a72fcca58-7633227a158mr1964788b3a.1.1753437496238;
        Fri, 25 Jul 2025 02:58:16 -0700 (PDT)
Received: from [10.218.10.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761adb7878esm3284533b3a.20.2025.07.25.02.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 02:58:15 -0700 (PDT)
Message-ID: <852ff03d-84cf-42f1-a428-ec747bea835e@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 15:28:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: qcom: Add shutdown handler
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250725062158.2418961-1-prashanth.k@oss.qualcomm.com>
 <2025072542-bleep-parting-3e7a@gregkh>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <2025072542-bleep-parting-3e7a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RbqQC0tv c=1 sm=1 tr=0 ts=68835539 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=7GsE9dd7f-aEGlja_ygA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4NCBTYWx0ZWRfX8iDMNDKJwyOi
 sKLAyO3uWLQN6dEpIsp7Lws6EhDRNsPLd9qEIYi+MKJsygH74tHVOOBGhuM2LwjWxYC73bxNqWq
 qT8XIOic6u7/qZ7WYdulXDTWZOEpIGGknWhy5AoyD7MzYgmKzCLYmKpln1LbCzeB8pci8MQqWYJ
 6GnrKgv9/1BQH2SQ7xT4j8cF++idsdOhvr2D2xx6Q3HcMG7KXkP0sHNbMbUT/X9JyYpbe/H+5ip
 W1UNIGNpCshvueFAgl5kYF1cj8IgMKhvcTCzsSM5WBMpfCyWfZRDi0POPpS+D4GU8INILBGjo2q
 YJnmM8haAaL+v7xvLlj7wnL1ZJInjQeh9bWonn+V/fAeFeBA1KUwXGHmmqsbQJxWvkR5DYWShN5
 1ap8havNbC8fFAVy5osyBwcvhOgmXbXi2wIeQ69kJXB0vWeyEyop4dTNcudGfn6gLVhy+rKp
X-Proofpoint-GUID: YtM9pv4JOMzvGUZRiUKZEeSx5kw8Qhip
X-Proofpoint-ORIG-GUID: YtM9pv4JOMzvGUZRiUKZEeSx5kw8Qhip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=993
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250084



On 7/25/2025 2:18 PM, Greg Kroah-Hartman wrote:
> On Fri, Jul 25, 2025 at 11:51:58AM +0530, Prashanth K wrote:
>> Currently during system reboot, SMMU disables its translations
>> while devices like USB may still be actively using DMA buffers.
>> This can lead to NOC errors and system crashes due to invalid
>> memory access.
>>
>> Address this by adding a shutdown callback to dwc3-qcom, which
>> ensures proper teardown of UDC stack and prevents DWC3 controller
>> from accessing memory after SMMU translation is disabled. Reuse
>> the existing remove callback for this purpose.
>>
>> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
>> ---
>>  drivers/usb/dwc3/dwc3-qcom.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> What commit id does this fix?  Or is this just a new feature?
> 
> thanks,
> 
> greg k-h

I didn't Fixes tag because a small dilemma. This patch is rebased on top
of the flattening series, specifically commit 1881a32fe14d ("usb: dwc3:
qcom: Transition to flattened model").
However, I don't think that this commit caused this issue.

Let me know if you want the Fixes tag.

Thanks in advance,
Prashanth K

