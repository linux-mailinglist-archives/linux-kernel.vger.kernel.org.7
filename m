Return-Path: <linux-kernel+bounces-833025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F889BA1019
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225556273F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297B23164BD;
	Thu, 25 Sep 2025 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZIZuhyS1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E3315D53
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824821; cv=none; b=dE9DjPzaHfgSCutq42PY9R27bzd1Vx79MVVBaWr8Qih/+7sOShQg3+Gw6fTrv94ZqQPB4I+am7v1phg5igxE/peBjYdljLteK+2U4N1G7qUhihTRkQC0fcHQUuARMU7PCriBrihSFKBkRlewH8ghKdMoJNUP8g9yQ1JQUfoig28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824821; c=relaxed/simple;
	bh=NMbylAYq7CYv0fkWtWUtjNn7VgoOmJ+cVhEKuBkCKu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=noNmoX+TIHTautUx+C62j9owRdtGJGd2A3i/XM5IsUPkG884aTMhCqhd8l4/sv7aubST2r2Ahg6OkWQO/NauT5vDEZA/HksJuTQKTi1g01qdJfH7Q6ud6yFMqLhWIF2namg+JRgSqKb+bDr8+0bBosBgM8NeFijFTFktdYZGPbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZIZuhyS1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPpe3025387
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PqPeS5NEfA2UAdvDycz41izyD8C9Eo6POeSmVFtB8KQ=; b=ZIZuhyS15etcwleU
	PGcLB87EG1ZJydefJk/eNnc18pUtxkC3uGPQjqhQrrQfa0AH9aPC/yAkRp+1BNCS
	A+k6ueej0xFtzjOldX5E7KNwo5l+OhINoci5awS/iFm2BeMFz83m85PV2UQm5yXM
	KE2doRndk00DnfkJAe5GNWf904f56B10p8svxl8ZSpgNbe8I9m537bD5M6p04JoP
	q5KjvB/udC1fGqd/mK0uxbPHCm/592WK24GZiaGvMo8bugLgKX+VsMmzraD3gPwA
	lL3BNUY59qpi+yBBR1iB8KYTSxBuWNj8iVRynSM92fkI4qCSlvZUjHhVILqVuOe1
	QuxYsg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u002u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:26:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3307af9b595so1251956a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758824817; x=1759429617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PqPeS5NEfA2UAdvDycz41izyD8C9Eo6POeSmVFtB8KQ=;
        b=iUYcuZEeX2KEwJioVCF9q9G3Ko+GP3h88SmfMP+y2ZUqqoShGWH2otRbRkc4ycVyvw
         PKqIcYuf6BreFR1llifND5Gsz50R7KlRKBVqqlDgNn0iDDK9PNShPmljL15jEt682y7P
         FBsCnumNLBa+2rOUAWwIKo8tyEp1TKRF3Gk1dqrWhJey/DTLS/ql0d93gHbSVbe5AQ29
         N1Mdxbn/E+SI6Cnj8A2VoTlhe8s8+f4HJNB1rJNkaqQCRDaZws2KezyfcoB1oupw76no
         Oo5A0mg7urV4WQRR1yOFx8avh0+aAQaBcVCf3SG708DQRkXnZyUX6jYkplOes/TWoIfd
         A0WA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ1Oy1ztKhCDZDljiHxZabFA6L7kRMyYb14B0zrevE0k/fl27B+ghuMlzx5JPqws3oFydfif6ZZQbSOyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8xPiQq36Opvmr6NcjpF5ePQGEDGgiRNwnCaGlt+tT9zn6NcHi
	kUXf2zVYI5V9BHL/g6ek8ODPgahzAt2NJzzZQTVhtXPD+LB1Pzkq29sfWFjAcVGvzJttjE4bzKK
	qFhFU0CIkS6Bhk/iCfg9g+dcHXe5LoPGulpNGta2A/GEDYqIFuk1gYHqrv+WC70KSNZpusqn9Wg
	A=
X-Gm-Gg: ASbGncvOuFOTZURxBoPbjMbAUL/a+yJ28DexFNXz/YYqvWQB5gjM+rQRCe3+ncRcwtv
	UF/vKBQZY6v01vNcv6txTSntwdQFn6P0BXW8zZ5M2OZGM+wrcG5N7WnQO4QXf/Q2aj9E69UKgaG
	WxCYbhvi9exjCnS5y3blElOa8dj7B8zjP5WWJ8LrCKAA8y3+/inbRBrb7Ev/CpnxhzA2yE9puJv
	w+YZ/+ZncgkfhLGPAiUAfAK+EqIpNaB3gwvVgEKK39t27BYnOkNLNdXqKUFc14giJbVFE83IBg3
	gVgHEMrKui4PC7S49u2OGNN6jLzRkSwODD9GuO1adfJuzd5ej/GeMcTbuYWodMzS4HodlOWMJUo
	Q0dm9wzSCyizrhhprek+TeVaOdJ6vVi8=
X-Received: by 2002:a17:90b:3d4b:b0:32d:d4fa:4c3 with SMTP id 98e67ed59e1d1-3342a2ef04fmr3451092a91.31.1758824816740;
        Thu, 25 Sep 2025 11:26:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8VfXlVS+KwPpyYFd34T8pPu8mdtcmA2+TC/qpR/h7izvQa1fT2HATDC6sqAu3sewVGidgrA==
X-Received: by 2002:a17:90b:3d4b:b0:32d:d4fa:4c3 with SMTP id 98e67ed59e1d1-3342a2ef04fmr3451074a91.31.1758824816203;
        Thu, 25 Sep 2025 11:26:56 -0700 (PDT)
Received: from [192.168.86.246] (syn-076-176-048-107.res.spectrum.com. [76.176.48.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3342a3cab8fsm1456102a91.1.2025.09.25.11.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 11:26:55 -0700 (PDT)
Message-ID: <cf043ce8-0e83-41cc-b294-93dc1c27fd91@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:26:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] arm64: dts: qcom: kaanapali: Add USB support for
 Kaanapali SoC
To: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>,
        =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tingwei.zhang@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Ronak Raheja <ronak.raheja@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-6-3fdbc4b9e1b1@oss.qualcomm.com>
 <CAJKOXPcbJY4JEjfZLvOAXEWCTYFpe7En+Riis2t3K5fWJgNU5A@mail.gmail.com>
 <53d63dd6-a022-4e80-a317-3218976a7474@oss.qualcomm.com>
Content-Language: en-US
From: Trilok Soni <trilok.soni@oss.qualcomm.com>
In-Reply-To: <53d63dd6-a022-4e80-a317-3218976a7474@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1yQ40Mt2zo2YRI3zt1A_Vi1DkGGVd7_Z
X-Proofpoint-GUID: 1yQ40Mt2zo2YRI3zt1A_Vi1DkGGVd7_Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX0m+pykzeti2K
 Js3I3xeDFxqFmxwqs+LJMvNFkqFkG1yAWLY3MMUyAxlferKhhRg91rWBwCEXTrK4kB+y3yyNqVG
 s8V7GtTMs5G70ZlBUddhu2ijsuCtBSDNKg9LS1d2qsORLEJRpUxCxyBVXcqzOSgOYrr8r5pZFcZ
 BS9u0eDBO9WQ1/kHVIroQvwVbppSc12nUs1zWe3yQ3d1iFMC7Aib41MoCzAXtzhj0yYXa4aVDrr
 w/4c8RKWWW3VPZYdJLF7FxddTUqqerzqR1TchM2mBVywpk7JCX1WuWqSG5B6cnFUmFuA2uV8Qs9
 2xrrR5vPIK9d838IXFOLJd7v8wQ0DfbLXwJN0ihfJpReNY5689JXLmChs/i2ViEDQzzxTUu/8sh
 /fTnPi5yll+5LgM+p2tTJ5dPklLaJg==
X-Authority-Analysis: v=2.4 cv=ZsHg6t7G c=1 sm=1 tr=0 ts=68d58972 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=lsoD3MMNObdLvy1227ExmA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_4E2EnyzloM2vKAfYDwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On 9/25/2025 12:39 AM, Aiqun(Maria) Yu wrote:
> On 9/25/2025 9:50 AM, Krzysztof Kozłowski wrote:
>> On Thu, 25 Sept 2025 at 09:17, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>>>
>>> From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
>>>
>>> Add the base USB devicetree definitions for Kaanapali platform. The overall
>>> chipset contains a single DWC3 USB3 controller (rev. 200a), SS QMP PHY
>>> (rev. v8) and M31 eUSB2 PHY.
>>>
>>> Signed-off-by: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 155 ++++++++++++++++++++++++++++++++
>>>  1 file changed, 155 insertions(+)
>>>
>>
>>
>> Second try, without HTML:
>>
>> I really don't understand why you created such huge patchset. Year
>> ago, two years ago, we were discussing it already and explained that's
>> just inflating the patchset without reason.
>>
>> New Soc is one logical change. Maybe two. Not 18!
> 
> It was previously squashed into the base soc dtsi patch and mark like:
> Written with help from Jyothi Kumar Seerapu(added bus), Ronak Raheja
> (added USB), Manish Pandey(added SDHCI), Gaurav Kashyap(added crypto),
> Manaf Meethalavalappu Pallikunhi(added tsens), Qiang Yu(added PCIE) and
> Jinlong Mao(added coresight).
> 
> While it is over 4000+ lines when we squash it together.
> Also as offline reviewed with Bjorn, he suggested us to split out the
> USB and other parts.
> 
>>
>> Not one patch per node or feature.
>>
>> This hides big picture, makes difficult to review everything,
>> difficult to test. Your patch count for LWN stats doesn't matter to
>> us.

Maria - the point here is to not design the series / code for stats, but
per maintainer expectations. Though it is difficult to know one preferred guideline.

> 
> With the current splitting, the different author as each co-developer
> can get the meaningful LWN stats.>
>> NAK and I'm really disappointed I have to repeat the same review .
> Currently, there are 10 SoC DTSI patches sent, structured as follows:
> 
> SoC initial
> Base MTP board
> SoC PCIe0
> SoC SDC2
> SoC USB
> SoC remoteproc
> SoC SPMI bus, TSENS, RNG, QCrypto, and Coresight
> SoC additional features
> SoC audio
> SoC CAMSS
> SoC video
> 
> Which parts would you prefer to squash into pls?
> 


