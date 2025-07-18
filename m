Return-Path: <linux-kernel+bounces-736619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9D5B09F99
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3541C47967
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D08298CDE;
	Fri, 18 Jul 2025 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HRxMhSIS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F929898D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830900; cv=none; b=lkpW0SsEPh5HJKUqfVFJNCIgFeezrVDjvUalfJNuB94pdZa0L0yP4FKwCKbKxGsIP+E/fyeWkyknUrmVsCn7DqQ3FSHdP5LrjbcXGL6phtIlLUXkkFseL9IctQ517djsBTBUj6GEhhIIkTCDKHDhRiQ0TiLSW2MbzXOJ4eixwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830900; c=relaxed/simple;
	bh=NbnKZfzGqskNbEfXayr5hGk/GwKuQRNSeP/X0NfYCeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRMTmtHMi9fYpxUNbDm9QFgx7v9i3AwsWvzVGSZRq3UUGddZynMl/j05ZH0YLAMxziZE77Sc8Y7gx7iBrY6Eo7jEkfRJwkYp2+zIhmnEuU6igLSSCSm3prfc8RhmdqxMjW9HsFXkVMTkR+XXi7S9khoVB8x1wJI5YBYuCtGwQqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HRxMhSIS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8Sl7r000554
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1+VRe0Ju/sp1iGJc3RkyEXgFVAS/G2F4yjLjeyBrp8U=; b=HRxMhSISSIU/oC2I
	fbV7H+d23qjgP3ITqLd6VHqpcNpA1JPdwO4DhtdRFd/Cio4n93BywGXELX8Ck3/7
	oVixkQM2nHiG3W20ztqBz4RWvr9tIqpBucgGLvldcAcWgtaTQtDMRUSu6sNFdCAE
	1KGyGGtiiF64hAFz2wzmx4pUBusBkKAD4Z0n5VM2CVvQC22WEsfQ888XrCkz5/f8
	FZfNI8uuS3u+G6vJT18ZiEDtcmofujrxe5AuzCqElCrvxAnPjnoDY/SEzv5UdlUU
	/c50vngyayo0IQE83pyZfflmEy/Iz1Dk2VeNK5ck5hRu6UGamiuJk/LzLcylGzSo
	T81KzA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drx0vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:28:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7de3c682919so42807985a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752830897; x=1753435697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+VRe0Ju/sp1iGJc3RkyEXgFVAS/G2F4yjLjeyBrp8U=;
        b=L0ov0zCikEgtGFffXcpLr6Wfn0qPTJKFS98AtfoDBVjmmRSQRzL8mkM7gJWJ/RG9Pq
         UoTF43rhtFHjRhHOWtCEjQBKZRUH0pBhUOg+E892EkmpZAe8V+LIUG9YBTQ4ZA252uJy
         RzSmneLyocYd1S8Ch/SrD0UZ5Zt2db1zyXLsosf4gIHGkWdS2fo8mH+ptrmj72bvGeEN
         If/ymf1CI4MZon1RQlnSYBj80scQZQ9QgezNJSRMHaK8EEpYotcAZCRHNT5HuHfdNlum
         LRe6UvIFR2VZqOZVo1FhMHbqw1oR2lHKqKVFjSyomf0tBwzrTrhn38ykG2iF2sm+semF
         rGtg==
X-Forwarded-Encrypted: i=1; AJvYcCUhHyUN3+pO/sJygjUfL88PzTtJ/X3XIrOLpsjVr6En4b2I0TppwyFiTtZJ5htXhEqFFF+34RsIljZnuFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4G5QsmeQ4A462ZABDg7Q4HU0PLkQr+991YwnSeEqKZKSQwZNb
	SPaMzAf/oggGcFskJ5CqyKZ1MAj2d2wX8B4+QbhX8gGEYeVUb1e7EN5EzD0HmL5imX0WWWKB0cR
	xp0KnB2anjuVPTTaxIwjG1yChrEjov50IaL/tPJjkxSObvCAWPV7lDgNzfDR5cuyGzY8=
X-Gm-Gg: ASbGncu7iUUW04lEOHEE1VnWMjRkA6vdcFjrQQzeTVtCSy+bLDlX2TvBD70AaLfQC6C
	yIMwP4vqWYgJPXURgyoSB+5dJUCNClgzZ8F1INmqgYI1QiMRq4y0LwR/5fb8hFLl9ApwlsYa4PV
	RsoWE0QjKpkUx3hkPus7++9gGgVreOZ0m/gj0/fiVaS9l5bo+AhfIQKnAmnUcbhqiyHA4on9icp
	oo4b70LK4xfikCLwzZwSzLqPYxLJqB+zLy3aAu9V7s5VhswwurbkQzm8eGrvKYNNQ9EB0cZlTfB
	5rh8IlJVpDR28ANzFJTYuH1Pf/Y5mNucxcPt8vUrwwB0MUhIHk6x0Bh55fU+JKRs8dQR03THYCw
	Sw57Cx9XP26+VVUUOZIzs
X-Received: by 2002:a05:620a:4153:b0:7d0:9ded:31e0 with SMTP id af79cd13be357-7e3429d39b2mr559975585a.0.1752830897025;
        Fri, 18 Jul 2025 02:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC1R6EIQ1c6MEMXvvejqhCbTPlrLcU2EQqZ1eX8XkE7MU2u6NGRZ77ayYNHvIednR+yi5YWg==
X-Received: by 2002:a05:620a:4153:b0:7d0:9ded:31e0 with SMTP id af79cd13be357-7e3429d39b2mr559972685a.0.1752830896492;
        Fri, 18 Jul 2025 02:28:16 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c907bb58sm696134a12.57.2025.07.18.02.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 02:28:15 -0700 (PDT)
Message-ID: <a383041e-7b70-4ffd-ae15-2412b2f83770@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 11:28:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] dt-bindings: clock: ipq9574: Rename NSS CC
 source clocks to drop rate
To: Luo Jie <quic_luoj@quicinc.com>, Rob Herring <robh@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
        quic_suruchia@quicinc.com
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
 <20250710-qcom_ipq5424_nsscc-v3-5-f149dc461212@quicinc.com>
 <20250710225412.GA25762-robh@kernel.org>
 <93082ccd-40d2-4a6b-a526-c118c1730a45@oss.qualcomm.com>
 <2f37c7e7-b07b-47c7-904b-5756c4cf5887@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2f37c7e7-b07b-47c7-904b-5756c4cf5887@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LPADAEJD9xhIsNFO3G6AkQFKKTUyRiYz
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=687a13b2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VT5E6NTcuoebdF1Bc4oA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: LPADAEJD9xhIsNFO3G6AkQFKKTUyRiYz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA3NCBTYWx0ZWRfX/yUQw1imQtNK
 7G86hkqjBN6g37DrGzicHllKoMp0KQEAVwB+iiytm4RfPJstFqZ0aqSzTUFDcloQC3hbIEorvc9
 r5qYDjz092PkjcCnFzfKS/tgNaiZDCwHFcMGOfAXyv1FGWmX0dbpfHYyMnNrZAw9d6CkXOR/oFh
 fgwgt2M7ydS9NlAegTl2jHV4xel+TS2yYfIGrqvMde9ok8rdypEHjNuPdfrAsJTcIGqUEb3waR2
 eyNeWuXitcX7HFgEcMi5weF/7K/sj49500ccqAphZ5qK+VrEzAGytszyxdbKU6BhJDC8sQndNWz
 IH+49cEJD81A6dDSy41p/sTQzeAbqfLDkd865MGktJ/bEJhDrqHtDxIiBRu2OqHgiM9FtTg/1du
 e3+tNYF00sfWuDFg6pCfrWj5bAVGNB3Cl2fAgCNXFrp9rkoPp2V0Len3+w4/iR7ZvA1rOWgK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180074

On 7/18/25 11:12 AM, Luo Jie wrote:
> 
> 
> On 7/11/2025 8:15 PM, Konrad Dybcio wrote:
>> On 7/11/25 12:54 AM, Rob Herring wrote:
>>> On Thu, Jul 10, 2025 at 08:28:13PM +0800, Luo Jie wrote:
>>>> Drop the clock rate suffix from the NSS Clock Controller clock names for
>>>> PPE and NSS clocks. A generic name allows for easier extension of support
>>>> to additional SoCs that utilize same hardware design.
>>>
>>> This is an ABI change. You must state that here and provide a reason the
>>> change is okay (assuming it is). Otherwise, you are stuck with the name
>>> even if not optimal.
>>
>> The reason here seems to be simplifying the YAML.. which is not a good
>> reason really..
>>
>> I would instead suggest keeping the clocks list as-is for ipq9574 (this
>> existing case), whereas improving it for any new additions
>>
>> Konrad
> 
> Thanks Rob and Konrad for the comments.
> 
> "nss_1200" and "nss" refer to the same clock pin on different SoC.
> As per Krzystof's previous comment on V2, including the frequency
> as a suffix in the clock name is not required, since only the
> frequencies vary across different IPQ SoCs, while the source clock
> pins for 'PPE' and 'NSS' clocks are the same. Hence this ABI change
> was deemed necessary.
> 
> By removing the frequency suffix, the device tree bindings becomes
> more flexible and easier to extend for supporting new hardware
> variants in the future.
> 
> Impact due to this ABI change: The NSS clock controller node is only
> enabled for the IPQ9574 DTS. In this patch series, the corresponding
> DTS changes for IPQ9574 are also included to align with this ABI
> change.

The point of an ABI is to keep exposing the same interface without
any change requirements, i.e. if a customer ships the DT from
torvalds/master in firmware and is not willing to update it, they
can no longer update the kernel without a workaround.

> Please let me know if further clarification or adjustments are needed.

What we're asking for is that you don't alter the name on the
existing platform, but use a no-suffix version for the ones you
introduce going forward

i.e. (pseudo-YAML)

if:
  properties:
    compatible:
      - const: qcom,ipq9574-nsscc
then:
  properties:
    clock-names:
      items:
        - clockname_1200
else:
  properties:
    clock-names:
      items:
        - clockname # no suffix

Konrad

