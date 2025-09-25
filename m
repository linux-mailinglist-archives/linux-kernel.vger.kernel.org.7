Return-Path: <linux-kernel+bounces-831920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0A4B9DE0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DC617005A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5CC2E92D1;
	Thu, 25 Sep 2025 07:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="foX1dx3h"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C40285CB5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785995; cv=none; b=qpfE1uZz4WnHqdct6Ql5tPtx1839xAOXQLuqX7yjcHsDunhsXh2C7OrJMjPVbFYx8BDzGT5vtic3SK84KE6RZOyEHjrjPh0v7s5xO5L/fs07ceFaWrRf4zopL3Z1O8EeGMIscK5dNpHnTLYN+rI1dNPByX0W0t2rrQ8hONecoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785995; c=relaxed/simple;
	bh=Y9R4WNRvvyMtAtnRGIuMD3fCanjscQi1bqGGZ2aeKWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXbjVSYrx5wUf/ZGyj049ao3vD9Dtqnp+7LzbAc7+Qg4M0Xk+Dro4rDKPssArNC/XGSm5mdtgjyI9j7NW+qO2RaekOfD8wOAs0IIVbcHJBIJBropELDBvaQr1c8HuVhsgelEeyMyi7mWSSSIvimsvlgdX0Hu2LU90qxPuILj1vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=foX1dx3h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0KfJH024042
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yHIf/aik58qJgO9OuFWD/cF/4E9ijlyj+qHMJjR5MNk=; b=foX1dx3h1cpwyoT8
	tEOb31eyOlz9jz3GG9xLSirs8wrysbaR6a/zUkPR3X//siefgOLbh9Ofwepac2bA
	QSfgRUu6YoUj7c/ZtQTkjvY4Ml0oXgCgxAplEYDUC5WLaYbDkzIHF3aGPutpJVsU
	EgMNhr7k3b+7Jh88eKfi+b0w3y3UUxEwMEX0pT3wQqKrtw4ysznKOqdlKmLFVDQz
	EegQC4hNtdVAj52cPkUWM9xDM1umxJeg4yw64zPn0hQxTiHlOF7NUlL2vIqRndum
	4b82pV4N6rRbGgp9w5zJGl1If8/pSxWCgllQAggzfHC6RjvhE8k5GX3qOoZDdYel
	hVni7w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0e8kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:39:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3309eab05d3so196959a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758785991; x=1759390791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHIf/aik58qJgO9OuFWD/cF/4E9ijlyj+qHMJjR5MNk=;
        b=a9laQcPAdueoceis0iFcgNd12dHQd7NAUZ17XjzpKZbYD2euHB5LViAWZEjqpkBhEn
         cYyegl0DUSc42Lw5+bZD2SDQ0v1YxHHwkAsJDhlwwgDjw4nKhbIlals1vrAYjJ/Lae6t
         r7E/OgQLx2UX+eAl1pXDvzHkYr/pl2AA9yXHvHkSuhx/6F6/CPT8TwWp3pZj/dza4SX+
         Casqg0ZcfTVxOCWfuu7siu3QFk72huvYa4659L/8/BNbhCVe25/R73/CriKZ1w4p0x8y
         fPtJt+EjsDJvhLFk7KliYIdyIxxJfaKAN52vYrKe5KsSTLs1Sbd50r8mt1kw/QO+j5jh
         Jp0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZYhbaW2O1T5iKSVIO+dHnczGY3sGR93uJi2piVHuslPbwc9nNBBIPmh+KD3/P0sduo3IEbuVETRdZ8Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2dIMIsAdnCl03PbmNcyNj/g3FIQVGAW43jVCnFV9QaHZCTVI
	f//GCkFQlLKoy31hQlp1k4hqDc5r7SiTJou7xueBerLzrNyPYyrrk1+H1H+PqzG0q+vqey97iLL
	1nwO2hSpVndEOUxGdaxXV071hxmfAgRTJUS43MPkr0jzws0JTEZnt18KP4BM/kOFeL94=
X-Gm-Gg: ASbGncviqWqvmMzfVnaefvmYZlxGs4sU2NRK+2mXIMGrENf0CHEd/KeM7IpaVbExre3
	TRb45SMbSevAlmVZ1MkDb93EYMXM0Ga/7IPgGLnkGGAWrwedmRKExBEPUs+wZSG22XdFTpdAS6+
	cOnm4rMCZFYUADkWcx1G4urXK2x4HNf35Fk5SAVr/Yq8m3BiOBrwmYfogqnHuUfDOB5G2PGy5op
	W6Q0MXscLgK1fAz9Fg+EINYsFSwHJrFQhq9NnO3+xJ1wwAPxfT8KMlkXG5jp0wQdwJ+aPktf/Cr
	iOddFx2hahnccEyFf6X9RxkZwBP7uvZTlTcu6HJmvlUqpHDs/31feLG5f3wZpEZiKDQbdR8tHbN
	UDYqkdUil2u+Mpeg6zJ3EdnWwhH723E0=
X-Received: by 2002:a17:90b:1e0d:b0:32d:e71d:743e with SMTP id 98e67ed59e1d1-3342a2df3camr1263926a91.5.1758785990810;
        Thu, 25 Sep 2025 00:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPMQLLZLbgPWPx8Cf/VV7OVsL2aUE3K8upcbyu4SvZDDclh+hBTJvNPsepYgjFfqtBwtGnDQ==
X-Received: by 2002:a17:90b:1e0d:b0:32d:e71d:743e with SMTP id 98e67ed59e1d1-3342a2df3camr1263903a91.5.1758785990305;
        Thu, 25 Sep 2025 00:39:50 -0700 (PDT)
Received: from [10.133.33.140] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be36bdesm4757664a91.24.2025.09.25.00.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 00:39:49 -0700 (PDT)
Message-ID: <53d63dd6-a022-4e80-a317-3218976a7474@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 15:39:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] arm64: dts: qcom: kaanapali: Add USB support for
 Kaanapali SoC
To: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Ronak Raheja <ronak.raheja@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-6-3fdbc4b9e1b1@oss.qualcomm.com>
 <CAJKOXPcbJY4JEjfZLvOAXEWCTYFpe7En+Riis2t3K5fWJgNU5A@mail.gmail.com>
Content-Language: en-US
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
In-Reply-To: <CAJKOXPcbJY4JEjfZLvOAXEWCTYFpe7En+Riis2t3K5fWJgNU5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d4f1c8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_8C6HiND3MtPFSYwXacA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: jN776p-tBnj3QDDItdk9t5LGgnKnw0If
X-Proofpoint-ORIG-GUID: jN776p-tBnj3QDDItdk9t5LGgnKnw0If
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfXy/Wf5Ehg2dRP
 P28zGYg/kPWgukl/gA7Wti1zyk2ztAoZUyzwbgoriZDsg4dF92N91wUN6Jjwnl3fEbK2MGMOM5w
 1/78rgkxVzSoChoB5lejgyhn8hbA46hAwXsxG8S2ELMMpFl6GZP0Kha8EdAnL2zCoF39qqbQ73N
 Ciu4wgZ3CFX8AQgNem7P/MfgOitdAsa9bY8XxfyogQf7bAmUlbdKkjtBxXjZfCzL/+dRAhYngpm
 RflRg7FZGK8aIpgxCMLQX6O7sGE9a5OlnJy0Bv9dnZjVACZ6xg7ccp7ypfhnLrdaXuDnYvMuv1a
 +xepnqKjrotH26bQvIDzrKPMc+GZlUMK8MUm/DGe+QQTGp9mjexR3IiGBngoJ8gwhD9vNxzm8Xi
 Xn+5VtN3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

On 9/25/2025 9:50 AM, Krzysztof Kozłowski wrote:
> On Thu, 25 Sept 2025 at 09:17, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>>
>> From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
>>
>> Add the base USB devicetree definitions for Kaanapali platform. The overall
>> chipset contains a single DWC3 USB3 controller (rev. 200a), SS QMP PHY
>> (rev. v8) and M31 eUSB2 PHY.
>>
>> Signed-off-by: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 155 ++++++++++++++++++++++++++++++++
>>  1 file changed, 155 insertions(+)
>>
> 
> 
> Second try, without HTML:
> 
> I really don't understand why you created such huge patchset. Year
> ago, two years ago, we were discussing it already and explained that's
> just inflating the patchset without reason.
> 
> New Soc is one logical change. Maybe two. Not 18!

It was previously squashed into the base soc dtsi patch and mark like:
Written with help from Jyothi Kumar Seerapu(added bus), Ronak Raheja
(added USB), Manish Pandey(added SDHCI), Gaurav Kashyap(added crypto),
Manaf Meethalavalappu Pallikunhi(added tsens), Qiang Yu(added PCIE) and
Jinlong Mao(added coresight).

While it is over 4000+ lines when we squash it together.
Also as offline reviewed with Bjorn, he suggested us to split out the
USB and other parts.

> 
> Not one patch per node or feature.
> 
> This hides big picture, makes difficult to review everything,
> difficult to test. Your patch count for LWN stats doesn't matter to
> us.

With the current splitting, the different author as each co-developer
can get the meaningful LWN stats.>
> NAK and I'm really disappointed I have to repeat the same review .
Currently, there are 10 SoC DTSI patches sent, structured as follows:

SoC initial
Base MTP board
SoC PCIe0
SoC SDC2
SoC USB
SoC remoteproc
SoC SPMI bus, TSENS, RNG, QCrypto, and Coresight
SoC additional features
SoC audio
SoC CAMSS
SoC video

Which parts would you prefer to squash into pls?

-- 
Thx and BRs,
Aiqun(Maria) Yu

