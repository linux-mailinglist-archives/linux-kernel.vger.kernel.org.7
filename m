Return-Path: <linux-kernel+bounces-832339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE63AB9EFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31832A0B72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898B61DC9B1;
	Thu, 25 Sep 2025 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mOIzC4YF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A8196C7C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800946; cv=none; b=smjNkzoYbbhTGnPMUW7aoecsvQHOiCVtuljVMZUm1PMhMI6wP0LQJGNmmT1E7C8UNOWH7qTT4bGMLSjHgcC+ZnROxFYgq1Gv3NU3L8RmgopGAplYtS/P2Fj27tfzLkVB8sz5rEwgOECtc2BvTHUHTBtPl8gH951qJ807cFujA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800946; c=relaxed/simple;
	bh=toxgSbOuMYd0l1zBSSHDfmkI9Q5eCWB7QxXd6A9cDi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atI4gZFITAYVX1+F7L6wReFYu9xmTF22uiecgrhq/mKnAacPGTI2MaxeYuM/mR/jxiUMSP20zJ4VukaaLYyg526q73HPZKnv8Thqw6btFvH9k49Dzo0Af3RAVz3xlXrwr/UyUEp0WsgOv5vYfBWFJw/uVQ+uRuSoqJ1L5fZYrZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mOIzC4YF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PA7RrU001948
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nX/7+Es5CEXVgmPLU51KFWh1W5gFD+wvMunPIFeNs98=; b=mOIzC4YF+zV4gcYV
	DVX2M16FN1bj/oQfzLXzFrje37j2ogmMyB9d4Ols67RKZOTJ6WdzGxVyyTiHHL27
	N2TpLQWURenH+h1Q1Pv2+xoWYZ+VTZEBuUtRaMVmBmKsyqB+OHa96CXOt8w3MF9N
	aR9dpanx+JpxN5TzuMa5Cd//D7gHlYpS1kW7aQWEwsPX8N1coiG9yUEZpN7kpuvW
	WqGUM26PdwDavOH+FRNtewWGg67tWfNQPP3M0z/taVCJBf9V0gKgKE/L/LaK2UMn
	alZE+bwczoVPCgDZo1GLvGRz94vFOB4b2TdWiUFNsEXW3W7qgDOY9oBi/3zldFIj
	nKqAbw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98qwy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:49:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4dc37a99897so409961cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758800943; x=1759405743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nX/7+Es5CEXVgmPLU51KFWh1W5gFD+wvMunPIFeNs98=;
        b=bbxVunFSu//4lQfVvtwdPJEtPP2S7cHU7LliY54lWoa2ixVEq672snkGv92HuZs94y
         kkZMj7CYXRJ9ep8JARo7V5xd6yip8hBJWdH7wteJHgKnF5oSfn7zeD7/569GDNf61lNG
         d+sTsn+XMVfmyW9ErLjUiZoUXsM919umH5RGYpxOf4dlSmA12eK+gOTQJUMLBm5rambt
         J/JUvGgaEunRhTFFZZSw6gqQP5c8ICudB1PqGUtM5KbH0A+VvaHEw167VXAmpUtP7dfq
         QCRPcSqyermmmW96MKX6+kR2C4yPVD79cL9yRVBriA7PztHmobr7wRL5Dqz+U7vaSdSA
         rhMA==
X-Forwarded-Encrypted: i=1; AJvYcCVzUJmldnq6jW7Ys8Hqv779qjfXv+EHovrOpchtAxW7xYvBQ6SPm06dLDFMQCzXo0PYiTAakeUV5gehRjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8QDkb3H6Njo82OyK7bThPcc0ck7HAxs0K0AgYEdDqIP8DUWPn
	PSEHoloa+r/f6sYQ36Wnu2XVHOyH4Ht3Onv+MeyMS5HOFolLIl7kyigquvRtJ5E7ej3E35ou/9M
	xRjxiDll3m5vr9gpb8u97fa4xBOgrUn4gtOu1pdqIHX/2oH9b37gKfThz4QKhun3KfsA=
X-Gm-Gg: ASbGnct90f2WjMjvdTJM/e+XfdvNONl3lrpeZR3S5Sn+OTdFFuEYza/3X21w46Y/ibg
	L62C9IA5Zx8S5pO86PtloIZk9eWeS8eQ7BtSzhIL45R4gwmQqnLhZIN3qraQKa2nN6wXoLrvG6I
	APWeByPzMlKzrV76n0uM+jS/jQqL1fdza/41ipItYlGzmuPgaubVjoMXV7Tehv4BzWrBuaFnViH
	8X2rxAcyFK9B4Jtn8Ad9p9Et/tTbEf9jXh8swaqe+BEC5Yep4eRJOo2nr9344QSdSrZgsv7H7uk
	jGz2suk/Pow9HkIKPH66RfE/gUKCCrQQEpWkKpDbQ9ZzrVmwckzwUuEKzQ1I7IflnG1TitPuZsg
	yiuSh4+lAokjcfbmDwTrNpg==
X-Received: by 2002:a05:622a:1988:b0:4d9:7eeb:3f76 with SMTP id d75a77b69052e-4da4b42881bmr27497641cf.8.1758800943283;
        Thu, 25 Sep 2025 04:49:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVDTxNrr1MXCU1YXwmH3hI/4HBUQONc/+oEm+jljQypOdh5NlhLYUBxtFh9nstaa+aDjP86A==
X-Received: by 2002:a05:622a:1988:b0:4d9:7eeb:3f76 with SMTP id d75a77b69052e-4da4b42881bmr27497281cf.8.1758800942641;
        Thu, 25 Sep 2025 04:49:02 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d155asm159172266b.6.2025.09.25.04.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:49:02 -0700 (PDT)
Message-ID: <39f6f7af-4b0a-496f-9391-880932634551@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 13:48:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] crypto: qce: add support for QCE major version 6
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
References: <20250924-knp-crypto-v1-0-49af17a231b7@oss.qualcomm.com>
 <20250924-knp-crypto-v1-3-49af17a231b7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-crypto-v1-3-49af17a231b7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6duIdBRQqqJFfZo5EAxd8DJJ2XsBXcFt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX8O+y9dmNYAYs
 XfGa1TP21bmPr1LMp+yCAt2EQ6vqkcpbDP8HPliJFmMHSfeyCLX7Ntndr3gz/dIEa0cFkHAfkDx
 34KijR0ZjRzm8Gk57O/KlHqTVlrCQqGEgTiXdvaiDXalggJaGQsNDACzk6K9wN7a0RveyeQ+/+L
 Uca0biPUpUbQmN7b3wj9xU6cMkpsEl7BCXg4pZu/xWBhgBQE+cHMRAvf7WUcH0OfYpeR50EOEqU
 +5vVc3RKXLu5si2frmst1nqELLzsO57sdyB/6UnpShi4nn15fnHO2h2lM1gQ7ZOOEOqEO8tcxW/
 R85cmPdnCv0DQghsGPrTMyZJC7UEaQBXk2V63dvKBO0u0ZXpSZw0co/K/vrg4jMqADCDx/n45cW
 rNQmiETe
X-Proofpoint-ORIG-GUID: 6duIdBRQqqJFfZo5EAxd8DJJ2XsBXcFt
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d52c30 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=um4aV7xw4E9mcPOvuVgA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

On 9/25/25 1:38 AM, Jingyi Wang wrote:
> From: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
> 
> The Qualcomm General Purpose Crypto Engine (GPCE) has
> upgraded to version 6 on newer socs, this makes the
> version check logic obsolete and needs to be updated
> to account for v6.0.
> 
> As part of this, unnecessary version macros has also
> been removed.
> 
> Signed-off-by: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

This commit message does not reflect what the code does (or at
least it does so very indirectly)

You can instead title the commit message "fix version check" and
mention in the commit text that this is necessary e.g. for v6

Konrad

