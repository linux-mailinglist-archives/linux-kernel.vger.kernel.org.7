Return-Path: <linux-kernel+bounces-842745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE16CBBD72A
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FFC3B20E9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B541DFDB8;
	Mon,  6 Oct 2025 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FtI2+KdI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561C946C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743059; cv=none; b=rGfADtq7RYhxsCYtR5ZpPr+aPjuJbDAURLkmH/IWmnTtATffQqNOoWfs7AF1HVry6/GfpXHS1tCZqOAaWCxTqaFKTIesIvvojqbFbdjFynpOucGrWDagdtUxl1ojUEYiqbovmIqzYKAfHFdR02sjqD3kzbasAEiy6VEqpwOMUnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743059; c=relaxed/simple;
	bh=leaPRdjhUAhu65EKAwyIHOe5Bt9yDIhBkariT72x9hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4FA4x4QNxgzgEaxfqh4BZQizpCmXIC4MlAgH2pTOpJom4ONEDthurb1a8ocuXdvLAML25rF13oRUQZgY3Mp7yPipKXZHlvigiJsucBXO3RVIrmXCiBmZPONQ7XOj+hgPEydTF3PzAGF4kVL7bfz51VC6Pg2fFc2+P1pBQ6mSZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FtI2+KdI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595NSlIf027970
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 09:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vops52gUYvZ3NLTbdfUXQSMexbJtRLHsZnvJ7nngDMo=; b=FtI2+KdIXV07hdY4
	laJIJAarmK+hNExe9mi4lzgX+cXYQ04PSC4NXTEkyBjBALpo8h+B2Rh8hleKTZ/6
	PegV9Tqbq3bEp9UUNHfhHUjnZOcRWIrclthWn8LjIUlvQKzNMvuBebPIeqeoKeDj
	PuOtS31KiwfW1BFEwgq6xEM0LK11c1HIAWNas/2oWvkopE4PFkAuX/kIEk8pgKpT
	kE7170gd+B8MA5WsVOXcOG5b2zxzfE6Aiwrt2xcotbDA4wsfjMErbqM/6zfUCPv5
	HMIYeiehPpm/J/UeSkBChO2y2gnQshIBdV8kBC8MtQtqDowCdLFu/JCmrfoeGDyt
	H4sUhA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvrhk9w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:30:57 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7f5798303b3so11547326d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 02:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759743056; x=1760347856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vops52gUYvZ3NLTbdfUXQSMexbJtRLHsZnvJ7nngDMo=;
        b=M0i+DZQSjujwuR5Np2Oq9/1hp5hgvGHDwFChIJKQSa3pkcZvAqUv2Q2BwaCn20wLA4
         Q1XUhbdvLvSniRUMIuntziXZ9VDJZXg64dMbaAKlHTJunhn0n/YR0HS7TQ9Ds0dbRji6
         nsndTT+2AwOt3C84+uFJDOSR9xvXcFVqV/x8uC9MnQnTiZP5bOwa/WWAlieDCFe2YN9C
         cZRDdXJHPL5enLFBzU2VfuPA7VwGHuEU3/52xSNjz+33sae4li18Acih6oGelYcrM356
         JAoKNI1peStHa0gBu9OzOjMtDv8plltYe92XmTvO9gcla7eBPo/1o4tHht1Pl4lgwtEG
         fPgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy2E51tw+7DSbrfvHBM/VKe9pjBH4ZVrsJr5D3FsAnhR5ROfHaxar+qYAjJbolBhbOXVrV+jermEpGVAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJSDKd1KLN/bybv5S8EAbEOMFOWijDWYxA3n3A85PwxxgdWsVD
	zEFUA2jNrVF/ZFBejCQrbgFe4UYmLZ98FP3WWbXXrWOrar8ja6kOu3bSijZXMfOaRwuEY17tQSu
	HBbdXM9qswprWdphBEYC5a9Wy1obRCOchNK0Kr7fGQe5FFfVC000XFGH27CkE81EnWjw=
X-Gm-Gg: ASbGncvuoFSwtq7S+Hjj+kTvmvDvfkqhx3QqQTZgAjMs6ThTpD4U7YqAZuVfFcOJGOM
	MZWaxalQA2hZKq0dE2/n1GHIUeeJm8T0/7xFY/tY96QK+Jaq1TYQBiApTGlFc/L2d1YG0HYt+Yd
	GBcJTT6NxCvwmkhWsiYW+vNJEJLHSizWhrpMNCd22KRmWzDTckdwr0vkJpHuVIMTIVROzLN9fI4
	aocUpHgov0ohv5L+2XFVdLO/v4Ycs1q8uJcN8X2iFr0O/xd3P8GIbTjglYUpq1EY0G3gnFPgfBt
	6cY0ktS5UVZDF/Sx3S0+dHGNXK37UHi/aimBJEg6ErdTYjGtFti/t2Zr2QMhdGyTsQKdT09etp8
	ymJ/uQRVQgnIZjZSFj6XFujQSWwQ=
X-Received: by 2002:a05:6214:f23:b0:80a:9ebc:33f9 with SMTP id 6a1803df08f44-879dc89535cmr103756836d6.6.1759743055707;
        Mon, 06 Oct 2025 02:30:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBKGVvuT/dS5+zF4JwZxmMHMvCe6TF1FwUlsq3NgesrwmiFqhiDCKZ77vUMID+5OE3Uvgp/g==
X-Received: by 2002:a05:6214:f23:b0:80a:9ebc:33f9 with SMTP id 6a1803df08f44-879dc89535cmr103756506d6.6.1759743055006;
        Mon, 06 Oct 2025 02:30:55 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637880ffa4dsm9810213a12.29.2025.10.06.02.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 02:30:54 -0700 (PDT)
Message-ID: <7ef8ba74-4e9e-4b19-998e-40917d997ca8@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 11:30:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8996: add interconnect paths to
 USB2 controller
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana
 <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
 <20251002-fix-msm8996-icc-v1-2-a36a05d1f869@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251002-fix-msm8996-icc-v1-2-a36a05d1f869@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNiBTYWx0ZWRfX5Pur44A7BP53
 sRFNINLKJ+wUMEliv7abvJjxaBCG+qHABkle6sz/mqkJjCc5LZDfiZkke/GlfOCP4HembV6gRTN
 eVwGEOtiC6vsjEubJjihl0zItGP9v3w8YnYmAVOmztKl82F6ADB34GBtFLA9bL37GEZQU6nNWkN
 RxtHClzwVj+2Jo4FqR4RRf7rwPNV4k/AqwSlkR81XvUDCNmJif0oWMPvVxULL9y2vtbiaaqlsN6
 zZPO5fCtrLHrFBGtmcx6ODaripY4PQgEkQxvHACoXO1Mq99BAOFhSIT+Y9N8HVJtF/WBlHtb7Rx
 nJy5VtU2uzTaavwazOfzB7lIhLl9rirRSe+TPxDqcQpWiM/xbQUjVT3nPJV1F7gxdh0LyRGE9Yq
 qcjHX6Dv26N2hydSE9hm23nrU6NAoA==
X-Proofpoint-GUID: yu-BjylzGX3mLIaulxv11HbZfl0w8qu8
X-Authority-Analysis: v=2.4 cv=XIQ9iAhE c=1 sm=1 tr=0 ts=68e38c51 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=T_NsP1zJ15PqFYLLzu8A:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: yu-BjylzGX3mLIaulxv11HbZfl0w8qu8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040036

On 10/2/25 10:53 AM, Dmitry Baryshkov wrote:
> Add the missing interconnects to the USB2 host. The Fixes tag points to
> the commit which broke probing of the USB host on that platform.
> 
> Fixes: 130733a10079 ("interconnect: qcom: msm8996: Promote to core_initcall")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> ---
> Note: without the previous patch applying this one can result in the
> kernel stuck at booting because of the EPROBE_DEFER loop. I suggest
> applying them through the same tree in order to make sure that the tree
> is not broken (or using an immutable tag for the icc commit).
> ---

There seems to be syntax for this, at least for stable patches
(which we should probably either use or add +noautosel):

* Specify any additional patch prerequisites for cherry picking::

    xCxc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
    xCxc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
    xCxc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
    xCxc: <stable@vger.kernel.org> # 3.3.x
    xSxixgxxnxexd-oxfxf-xbxy: Ingo Molnar <mingo@elte.hu>

(deliberatelly added a bunch of 'x'-es to not interrupt the maintainers'
b4 workflow)

(via https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst)

Konrad

