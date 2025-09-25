Return-Path: <linux-kernel+bounces-832152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5502BB9E7A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027393219E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C985265CDD;
	Thu, 25 Sep 2025 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BQVuRwxR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F02701DC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793500; cv=none; b=XqUDXUewiSdo249aTW97ikq4zOW+pWLw5VzmTwPOX4ZmD83YPEkKrrcob+vNHDaLb9Pw7vCaBfQ3MIlKdMzRwxYGhmqBgN/JrOSIAotvVs1/yxI7Jq6KlMtRRyMDZfeVKpQ5O/bNjmxgTmoDERpAJwGIOC2Z13hR8WeboNGBtu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793500; c=relaxed/simple;
	bh=ddDJ8WhOB803sw1GS46pySj8WpA15wcm9XtdsSV5R8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBKlLJc1WxtE7YIwHKPqDBOztsdkGBG2izvpcMr/u2rYJ8rPSJzUoEj/eAHNojEWrw0F2RQ/6qEzHTFhuBY77iIf1YUFZcFBCF1gJ3bAFRt+PFIXf5DgqKGtLj8/ak7BWgoCo8dRoDCjRUMiLghny3zQV/S3EqSIfXtJgsW0LUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BQVuRwxR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0rTkJ025119
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NikL2akQ68hM9x9+VetR4PdPN49gGnpQhrngMFrdspQ=; b=BQVuRwxR2YoyFFps
	4Y4Z/Urhjm3dggVs5w5V6EHhY+jyBAglFiXJUhIlgzkS822fTnjA1w3khwM7rrAg
	QokpBXoUDX63Tk8gS89VqafD5Dq8AN8G5XJfZ/MBlQSOJAK7JIVuaAEcr8m1v4K9
	h8YuMZMEoX/QPE5Eoi/HkuzU11E0zOKcpsJQi566TLnQLfdnaGboT8Jv+nU38FS1
	SOn4PhHp5onM7qztmEpxf9fqVriJvWfK5Rj8VD24O3MllcTPEpO/1/Gu5s2WRaJr
	+2P3oj4g8k9JcpI/yqx4dN8yAynPPrb7Oufinxa3TetJbyIr2/F+6CcFnzc6mNwW
	PbglKw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv17mkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:44:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-85d43cd080eso10373785a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793497; x=1759398297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NikL2akQ68hM9x9+VetR4PdPN49gGnpQhrngMFrdspQ=;
        b=KI2YDMu/CFBLopBNl3SpFg28aoJKtXIJNCpAHZi3Kc/ew0FDmudWWPNyYoOMBNkTj8
         EW7SqG1aay97U9tET2XROeR2J2dhImrns/dq1XFvHyW1teWo0hx64fp736sacN427IbY
         1/RnOIB6rfj97k5XWpKpMjsO0m3bmhcNdpEHXAYwK7nvQYtTogW0QYK19qqgJsUNojMG
         FB2rfC3scUthCXXOhBRS+CN8GJQJb0BxwQyfru4IGx7VmIwRe6tc4zQFXhDJoHYfH+db
         0x3Q6t24gwMZiRQjuu6BTD4IQ5tsRQ1VNGW/856SKMJXDO0ERE3p059yVykcjHLbiAP3
         PcgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmam75FHjUefALrCrSErqIiGnQz2BHTIC60LRhGJAR7v0F4fOua1fzEH77XjWoHgoZGDbLeZ7jrd3/zak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVyV3DZBg4J1+lo8GSrBQdymozCeJTpyNVy83WSRO5whmdgbC1
	Ohd3tOlYvU9KfrsluYV6TW/btCwXbvYr37+2rJAmgLRX+FxTNoe+/R0EHXDJhYuujkUKzJVWqvu
	lTdi6dybikasmA0Ap9KcW1QZaB3uBWy81922DMIcj2/24UBYPAS5Bq0Cm0bHbZM/YV7k=
X-Gm-Gg: ASbGncvqPx7XefqS7BBnGz+XPDonkEpvOXDYfzRn/pHd+FdRU93KrzPuqnyV/LIpF6j
	j/JQgEJkrEgCRtGDEeaJUvj9vHiJmGBWx5FZP8kBXYT1mpBvjjIrJrqxnZZhawZqJJV0zX8DhRp
	esLDIgBrcxqoVUBGgH4bzbtLlprdMoMAxs2UykAtmzeuUa8BjAEic7mpyEbJ2sHaljSV+ofkePk
	nMmXIx2D3heN0eCuWqVVVCrZGuxOfgycknbu869uAyvK95Ut1twZ/bt66R4H/sH5WAdpOx3VPQa
	ba36qcUqxOWAQIXncnwt3UTqZfJUVBdVl9nSVqt9C0s1Lr9GNZPZAW+2oi1jXjd2CzrCUhZou37
	9qvs3X0jMqACKQzMEH56vmw==
X-Received: by 2002:a05:620a:568c:b0:85b:27dd:84cc with SMTP id af79cd13be357-85b27eccea2mr163416485a.5.1758793497248;
        Thu, 25 Sep 2025 02:44:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPPxZLLNWBTCD5r+mWJbKzzYp43QUCoEx4ni8RhFH2hQfUjAzXM9z/WGLeyICmCEIzVqFcFQ==
X-Received: by 2002:a05:620a:568c:b0:85b:27dd:84cc with SMTP id af79cd13be357-85b27eccea2mr163414085a.5.1758793496657;
        Thu, 25 Sep 2025 02:44:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f5c36sm130884366b.54.2025.09.25.02.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:44:56 -0700 (PDT)
Message-ID: <f647523a-d8b1-4bd7-af44-1893ed7aafb1@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:44:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] arm64: dts: qcom: kaanapali: Add base MTP board
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-3-3fdbc4b9e1b1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-3-3fdbc4b9e1b1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XtBQs1zjIIKD2KNDUwy0tN42JNSGAh1u
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d50f1a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=mBYT-LOj6LCiw4TiknMA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX+ufm9y0IbetU
 fdLV1u6h6IaoC4NauLfUhbjmc/1hckwqGUHJcHpKA5fyKQ/AzCPuYV6XwhbmAcVWl+2cDH2VBy0
 NPH0DufttAMl5lSczXAbQXita55kCmgeYgaEUwnqOV/EVBqb+CAhWUAtzkY+huEAoKLIYva2s43
 o28LEFdLPkoQVdXIX+F/dBO7jMa4uGujJLfGpWMcA/dEyBsi0jj+DNdGjTCJbnc+Vx34bZZA3VW
 A2dEdes+4uiUXBlarvCBP6rVUUcnyKbd60CqRjbaNdcdW78OmG7MzmuaxN7m8hAjjZLDhc0joCB
 2MBvWUYrP9irC17hdp8or+ewV5ZFIm2Mi67JRsXUu56RfXhWS7PWm50NFk6hxS1XYVn6yNRO82u
 0l2Tuscw
X-Proofpoint-ORIG-GUID: XtBQs1zjIIKD2KNDUwy0tN42JNSGAh1u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

On 9/25/25 2:17 AM, Jingyi Wang wrote:
> Add initial support for Qualcomm Kaanapali MTP board which enables DSPs,
> UFS and booting to shell with uart console.
> 
> Written with help from Jishnu Prakash (added rpmhpd nodes) and Nitin Rawat
> (added ufs).
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

With the commit message fixed:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


