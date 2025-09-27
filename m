Return-Path: <linux-kernel+bounces-834971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA43BA5EFC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE601B202B7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6BF2E0B5B;
	Sat, 27 Sep 2025 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LtAHyxdA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F52D949F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758975956; cv=none; b=JQ2W44MSdGsISNg/+VfgXOHbKApkaaGCa2/gmpHGQ140Gdol+unIbhnDUd7xKwGUzx6H7mJ08VfHhUleITwJT8Gha1fMUmQmYvRbkBeqUVp+JS86J8ReHfDsL6GIq3qVNoJodmcgnrmPzO8cnE7IRPFmeNV5n2e0eigD48IMMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758975956; c=relaxed/simple;
	bh=8LxIxoEuK9oDbUJERTI0um1igrwtdtq0Mq737gi/9CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAGdULViZFQJp0YNOxVdXkIykplIu9QurcDFRpBwColci4ou3MVV8tdhduZXrNQA5j6nEUy6q9l3Ey3BbIwLUJQI0NiYBN+m3JGRheCmc+qWrAArg5V/ngnTyQpFhgFQjZWyd+Q00YKNTOVqic/pW+Kx1U/SgKoa5wdaRpxSGJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LtAHyxdA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58RC8JPd027765
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8HTZrkSYrqPPOE5aWwuZ/eo7FP1KIcHRJKoII1rHuug=; b=LtAHyxdAoERLVHjZ
	JbX115ejTnojvTKRZuUdPj0fYaO0C0eczNiv43mvnGuxSSJNaGnD1UyGLqOKGQZw
	G6Z8Q4wwd2Ef0gn5ZI/RYEX6KCE9ujwfgSiAauKN4FHhV1deKSpo5TxFND3UzPZe
	a/m22yMSkF1Y95uwOT82TntEsXDs0FDo4A7UtkQSo4Ffb/RAhRoAxf7UpC+Hejn9
	dBDqQ5oUq1zp2UGyeq8b/pdQaPlJDwifMdhRvfRmyj2zjLLzCq/bEqDqvYgL58gh
	0cxqGGcLeSDfy3a2BnH23sP6+bZyfHJCaPBgeMZiMsF9R+KK8+uRnuMOnBeresZY
	FVLe+A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93h8m5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:25:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-85696c12803so133985485a.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758975953; x=1759580753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HTZrkSYrqPPOE5aWwuZ/eo7FP1KIcHRJKoII1rHuug=;
        b=aFedjhCXURWvCVnygKdqd3zrOScNz6+ozwxrlt5vBaVtp8XaRkjupyRrwv5rYbc7+I
         9yIxF3NJlnOG3epHJRqrq/ez2QTXzFsor7xhevAyYl3JwUv+6zoSmzpuOOhR2S3A2RJD
         QMKD7MzZlS2/qf3/gjiFBIpx4cY954mhnMHF61hTaVnEdMpHCXe+3RqEka0nomgV5k3q
         RYYAz8VjJjPU3MalU8SgJezTEihZcYCMCuDoJsGKWlx+npbqnT7n2JDHXh/Ym/0O8+ts
         rJW+XbsPRcOqzMWUX15mRLdxrR/Ep5tgbkhyugWMO6pYpCR4SiTjrTkiiqGvl+EoHCgD
         tSnA==
X-Forwarded-Encrypted: i=1; AJvYcCU/HwyTUBGRn8lmzc46YW6yPxZ4h9th0DEtCv3OKLcD8aBUpdTKVYT45o69dY1LVPmILcyQKHd06jqgt3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJOYqBJ0z4Yz5wTCtr48MlJtsBK+/xlj61ZwxaoWpzdXt2lLIs
	cPIrEsNtOOh9m952XE+f6ArJxlgaYAb6erxfvZovKMgER0TESpN7DTBZmIkNEb1WWrg1bM1n4Ww
	tLEqSfoamvID7hPy0BdqEgEe4t6bVWLsqMBujieuwZ2jfaHzV8hCVMHW6dYYmRipjvJM=
X-Gm-Gg: ASbGncsXpGpEKkBxPHpHUAoq9DAdUWogKSfNQ1zAggi9btoTxIMzWezZUh7WMgV/2wH
	Uo/F8zr925H2G/0CfJ5IGfQLI3mdXjQT5FZ1pzwEEaU6FTWj+avfYFtgjbslGngNF/7vOAgYh0Y
	ZM0K7xYvZtY0YYqKTd0m96PQ6HAgg3l1vouXDQBmxPeXZorbVTdJtV/mDL50aZXqVUN3626FBGY
	XrZUcLkod27SP9dyHG/33Yxbkyaz+123wWGYj3/3ZTKew596GGgoeIQRUjTsfhip/Flg1pBdmku
	zGU6Vjit/sb9T+z3X8jnTBpMC2RHVYa80tIKeu3QtTwc4rJDh/Aw6FPX+MWQ2O7hv3ek3H6H17v
	KrsN/wG3zUsB0PPEDpWJilg==
X-Received: by 2002:a05:620a:3182:b0:812:81c6:266c with SMTP id af79cd13be357-85ae6d81db3mr926478185a.9.1758975952990;
        Sat, 27 Sep 2025 05:25:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCG2e/ZW9GFpuGzcSJqt6X2AuHy0M9fiQ/EEgWD1R6USyO/kkVUy9LiI1L21B8ibFVZJ2N8g==
X-Received: by 2002:a05:620a:3182:b0:812:81c6:266c with SMTP id af79cd13be357-85ae6d81db3mr926475985a.9.1758975952413;
        Sat, 27 Sep 2025 05:25:52 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353fa65a62sm554412366b.47.2025.09.27.05.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 05:25:51 -0700 (PDT)
Message-ID: <7cfa782b-07a5-4f0e-9151-44a42c77badc@oss.qualcomm.com>
Date: Sat, 27 Sep 2025 14:25:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/14] phy: qcom: qmp-usbc: Add USB/DP exclude handling
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark
 <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com,
        Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250926-add-displayport-support-for-qcs615-platform-v7-0-dc5edaac6c2b@oss.qualcomm.com>
 <20250926-add-displayport-support-for-qcs615-platform-v7-10-dc5edaac6c2b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250926-add-displayport-support-for-qcs615-platform-v7-10-dc5edaac6c2b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfXzRtI/jozw/O1
 2ESOKwa7Dm//OW2nl4tQJPB/PFGWpTL3nN38vRF8XojKpdEvJUK6Ykeu44UB8ybWujsvb3dTkGP
 73/F8n6nWq4NnY48Ki2BtELITfYUCgCVnHq+Md7WuJujdWhZ92RT1vfWI1Da+qNy3RUj97P5MPH
 O7k5xUaKYevyGFE9qam3gDPCjr3J9muP7R6N3CVaZlvXOGerClCA7f9uBewGmhmoSZViSPCaFSP
 LzKLHR/ouz/8+BmZb2RxtleBJw+w8y64wYvNusRnRCQ/yzA8L5KPdNn9nKHmaXdT0sGktYHtBTr
 poF+QU3wK6VZWljZZXnZrYekCywaagoL+j2nayyCdUGfWN8N+n0ofEmp0bwDbrItSYIWAdTtUAZ
 u2g+gZFQ48TGpYJIrJSDi+UDD+dXJQ==
X-Proofpoint-GUID: -GZvtXoM9Icgap_M-iNRRlmEa8lZTK7v
X-Proofpoint-ORIG-GUID: -GZvtXoM9Icgap_M-iNRRlmEa8lZTK7v
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68d7d7d2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7a1U2GcbA96CJLvzQ6EA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-27_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

On 9/26/25 9:25 AM, Xiangxu Yin wrote:
> When both USB and DP PHY modes are enabled simultaneously on the same
> QMP USBC PHY, it can lead to hardware misconfiguration and undefined
> behavior. This happens because the PHY resources are not designed to
> operate in both modes at the same time.
> 
> To prevent this, introduce a mutual exclusion check between USB and DP
> PHY modes.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

