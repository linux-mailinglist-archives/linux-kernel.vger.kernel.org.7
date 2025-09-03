Return-Path: <linux-kernel+bounces-798101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE24B4197B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28071790E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7008C2ED85D;
	Wed,  3 Sep 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m/QHDpo6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E02DFA2F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890043; cv=none; b=sT0uzXvJli1qwl+KTw7TJdOXYHnus33bXkoyPZoFVde/VqMshI09VYnBaS/9ihY4phZeQRyWADC69bysfOh3eb8M7SuL8lLg1G0doPTDLEvY2FiHE+sbNVp1QOLssurSaPQXEtkqLn8IVkx27o+EwNH1mi2TAJ09g045YBb7vqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890043; c=relaxed/simple;
	bh=SbOOxV6Xe6CCn43EVipuJCMXzlrEjAWOJ8RB3sOYs40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5jUA+r274cUEKBMqVykNbdX7gjmoh8Ap2NmNU1n3GNKmbAUH/vF7PS2G/Vul5L+BR+EH90tkIebTb7wo81gnk72iZZ3DMQkptaZdoONysar+9dpTQigpN37QH6yw+UVlP3OPnuShwnNcc0MDOWma1upluTbIJbSg7SoKUUqksc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m/QHDpo6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5832I5JL004336
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 09:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k+LEakHcMi5MUQWyBYBQ5DPF7nqZWUcEjlntDch+SZE=; b=m/QHDpo6ewiGGnsx
	V6Ae1JGQA5xNOELboQVqUHP360hdBoyxKuB6UsUSUzYLGVLIhdAQcbhAB/7VuTAQ
	sXKLF7bjKErAg0G/YpDnzQUMdqw0PgX4xLzHCfLoF2YnoxsQ5/hWC9ak0HloTQ77
	ABoxg0pMmRNe7eUog8wMsleDrOsreXlzKVkHheyHcq/dYhwAktK+4B2CQ5fsMU66
	gv92CKC4FcszhmM8dv+nHeQoKmiW2hGZ9TSE0ZS7CjCF/n2Tftct/TyIZblFF+Z3
	Hi9ICIFEq/lyTuoLybwtWuf15zeOsuSqluEK3tzOkYRB3RREZAlMtnRGZiqoXZAR
	CQ91/Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjjvmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:00:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b3349c2c38so72329211cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756890040; x=1757494840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+LEakHcMi5MUQWyBYBQ5DPF7nqZWUcEjlntDch+SZE=;
        b=qg4Ui7a2qZjv8IfiXmnjyHBEHQGwf6wuzNPs3xqprKX+pTwkNAVQ4/dbA97+qjbEV2
         /gXlm8r3E994DcaUKWf10HOVdr7+EkN8IGP6j8vRGtyvmajncMcDizXL0k0WyUdbC7um
         Dlo8jbfZO3kKmoRO5RDoqrVoiR/P5B1pwNZ6wo5RXieeHLt8bxrhOIVUJeDglapII2AF
         /Xg/Lwaxrkf5q0EDZpPYQZaaP/pVlfP2YxAYp+JumyQ04xyYWir6IqXfmByQ22/LG9Ic
         /xYSnUg2IwsLMJTbwREk1yovHxnJNkheo/Hn6L0bxIRDWQsFWeiiTlercFp7Kc49hv/n
         aGhg==
X-Forwarded-Encrypted: i=1; AJvYcCWXov7YZKHC7KKpPgR+Cd1kEeUIP1QelUS1ijyjFd7fE5d2Ma+hDXL7XIevR4f/h2UcH5jLg8nXCKySI68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJTsPoeySyvqbC3jAa+jlN4tT8am/OwmWctYAT9FAUkPKmI8C7
	PcDgbCzghrpI6rWVugNAcuKmz16ewzKBln8uzkyHO4nGXlQxWBBmJ5dQ1wmqHUzOvoTnYdi86KO
	/oeErAV9XgLs74Y9Sd8XFTUn2RrtDKurPMQwX1Pvuztuh8N7J06IKjZz6UHa04HXVWwQ=
X-Gm-Gg: ASbGncuBvErxfkqLW2qpkamvI6/1Dvgcf9+zD91L9Pq7IS3f8biFzKLZW9JaDNjc80D
	qquy6OzsqLM7pz4u+2rbK+3Vt7lmZslYEsinJTA2E2vepATdMMUwB5RczGc+JYyYPwjpeR2VfsQ
	N/gNsjQqnjne49ilMi4XCsjJCVOab2xCcBm+iPCi75pDAySspxb6cURw6CuIN2PTmEBJrAppszn
	ANnCvqd7zeHHARX+H86SpzLxPd4xHVv8Ch6hl6WbcakPZplxhTlXcTsAlM7DKyYiKIuI4GDd0pt
	28BZXXY4tabIOyIFmu2dJ+cpb+u9t2PSMF0NSa2g0klGrFIE2bbTD8XXvFdHWejrXlc=
X-Received: by 2002:ac8:5789:0:b0:4b2:d1c5:ee8 with SMTP id d75a77b69052e-4b31dccd8d7mr171353931cf.74.1756890039884;
        Wed, 03 Sep 2025 02:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG1UDc3HGeDuXiKdWk0dURpTABwshxbMsyQ9pUNYSRcUghr0tBI4RwEEBCyMHDrmUtaG/ajQ==
X-Received: by 2002:ac8:5789:0:b0:4b2:d1c5:ee8 with SMTP id d75a77b69052e-4b31dccd8d7mr171353561cf.74.1756890039313;
        Wed, 03 Sep 2025 02:00:39 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b940bbc0dsm75958965e9.2.2025.09.03.02.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 02:00:38 -0700 (PDT)
Message-ID: <e6ae9e25-1a92-412f-9916-4c92676b8c5f@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 10:00:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] ASoC: dt-bindings: qcom: Add Glymur LPASS wsa and va
 macro codecs
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: srini@kernel.org, broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250902140044.54508-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250902140044.54508-5-srinivas.kandagatla@oss.qualcomm.com>
 <20250903-diligent-tunneling-angelfish-bae3b3@kuoka>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250903-diligent-tunneling-angelfish-bae3b3@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b803b8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=cQA_P7Yw0F7ou3pLjNcA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: DBrQpTXRvrEE-j6V7PpzwoxIfBVmxs4A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXxN6CtMEoolsM
 CoIzKUTH0iaWJ0WbL66z63jEFZAM25UAtw0o6d0UIBiSlTtc9WfqwR3ko2kNfO4EnuWNtCsHotQ
 29B0kNEmPCMiyNk43bnQNiThJh1eUbPvgPfwhMrTx/lwkB7Znb5ObSX87czyd6f7mA5uxUAbCps
 RleqjiQth+6yTDJUoJSU2nyUWE9f0URpveQHMBLQSsZSntD9iObifm77MpjpLAEn39AhG1oD2Ng
 GUdbmAWXz1cmkuMC7r/lNAt8tz18IYaOexOBPGaApqteDv+VhQuvO6hlD6VxZcwA67jzMZQEb5z
 9bqOj6ToljQtXHSpqaw6ldizpbyT7kXYhlsqLRTu/QMda+dVbV4KnABskuO7izl1ttBiydTjml5
 GIoVScku
X-Proofpoint-ORIG-GUID: DBrQpTXRvrEE-j6V7PpzwoxIfBVmxs4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024



On 9/3/25 8:57 AM, Krzysztof Kozlowski wrote:
> On Tue, Sep 02, 2025 at 03:00:42PM +0100, Srinivas Kandagatla wrote:
>> Document compatibles for Qualcomm Glymur SoC macro digital codecs
>> (VA and WSA), compatible with previous generation (SM8550 and SM8650).
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml | 1 +
>>  .../devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml          | 1 +
>>  2 files changed, 2 insertions(+)
>>
> 
> What about tx and rx? Not yet ready?

Correct, I have not verified tx and rx yet on this platform which is why
I did not set the bindings for it yet.

TX and RX codecs are using SDCA so its possible that there might be some
delta here.


--srini
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 


