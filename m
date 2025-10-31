Return-Path: <linux-kernel+bounces-880437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20230C25BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7C7F4FAF96
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968952C1589;
	Fri, 31 Oct 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GaUlG7Kr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e4Y1UnDS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C41C283FEA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922285; cv=none; b=J7uzDCv21+3mXWn2UU7umI4eTy/BGq2Z8ifHu/eou9czwTfB7bkvSAErBpHCqQ1++dfUXk8NK0RYrRmqzuFsXlxOsvOHeKl2NSxMg5HywVqW43jzj5ZOiPLccdD49GDOkhpAVkqgpXgWJ71KzX+5HJBeiO8XSvtfotNLxTseGho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922285; c=relaxed/simple;
	bh=6PvX3Mn7d/srGE8PUw02gWJHJ5kq5GVJeIMKoqGjFQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glz9u90DpUGaI43klmp65qsdF6ohrCk+SK7aHyEg7cDq+mqQzRgeDCe3k/gaXTq6DTimehLkQi9hLyifu8Ie4tTPwMaRRb2HGS9RvgFNXUErRpSiv+ysrdVzfsLUS58eLUgdSO4FDK9rYajGqMYG5OLZqlXseErP4ZfIReqLh9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GaUlG7Kr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e4Y1UnDS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VDDrJo1827335
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	25lyvdDjDQqOSKonxMTWI6lwYX4gVE6aW7eDSRoi110=; b=GaUlG7KrueyJWuCq
	5f9zW6Gud+VKZ+IJkUKnRo937G6LI+X81gYf2Cyb/V0bD447Kg8w4Do3eGMzdoGe
	iJmpTzlVcq+RrYRZxhXgJS0tWqGMXkZCEA65CNh1GDGZp7w2tTegDlvatCmhPfma
	HHf9vNJHG4W4+uFA3kirL6HMjm5zIa5R1YcUGd/+OTlVpLyiASjsSPE2lo87z/ZG
	xW9KLezygMeucGYWzkq96AhUOUP7DzD7zRwaEj4vhiovA+cDkB+4dST4A41IVbOy
	FpfDS9WcuGBq9/SKi/axPP954A925UzlGhiepuzXPkiIeUNyTBfBeD91b+iXtR5r
	cstiuQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4p11smab-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:51:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e88a5e70a7so69196261cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761922282; x=1762527082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25lyvdDjDQqOSKonxMTWI6lwYX4gVE6aW7eDSRoi110=;
        b=e4Y1UnDSAeeTDNQ9W4sq2A2TsM4lAqj3KT7Zvp9btPToM821C2iqbhV4Qwi+V6kgJb
         gHuB3+g1ZRgem1JQigdMoNv2YGxsNk+2/SGpMlI1TvVnJzHWVnXyIwtszhXqK1ReUfAn
         ZoQcu+PeRB1ILdaDBkmTdgnHcCViDll6Qp5Zz9ORnS0pb95S1WAwmm9hHqgKlBhlhnkh
         zzLk3AUWtA1Uc25M8doahEzpnOVvOwjiCWnZV+ZEMO9e4aNGsECPqRgnp3JvfRCbeBsM
         1+MIHFMF4hmeIPHrqCfDVpxN+txG28YmpXTmFxtTVFO0SpHMW891xVdptu1/pGXTikvI
         zGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761922282; x=1762527082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25lyvdDjDQqOSKonxMTWI6lwYX4gVE6aW7eDSRoi110=;
        b=aqPbb4Bt1IuWC907SZChFPZDs4pqif2cYsUqtiKRCWA3/hE0AbsNrlHXDLmJTLw6y4
         Ahrn5u8Dzeq7ldAPVVIWvheAZSuWwqCkVOtCqZFJBR53SA/omuflXrgkEH4S1ssD19Nh
         SPXpQtgf9Sqq0qQlafXGyT1xanH3ko/VvPDLuWQbOGaNl9QDsN9BctqGqR9J3TXqzPCJ
         9dYioV+G92zFxQRxzgogs08ZAbVd6sXzp2iNVZEqJiQPZoGkgtdgLOebYsnqTRhy0OYD
         b1jgT7DaBU0J4xt5ZaXsWgLMX5+jJQjLwj6NDLL+c0QlaNFW28E1oU8kPtFwCpmIhLEy
         mLmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXczeGC+2UTa9uOdw9zIf5VJ7o4hF0brGsUHXEBCexlg6CtNcK8vMLezNcYWuhLRN8EIBDL7wdiiRuV7No=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+TYGFkMU58kd//b6bda3wq16osyNOihO8SPLNXaCXLmGcTUPR
	6TTLtYa+cNID5NdcQ/9z6qVdlv1eBfbeHLVFArzOhgEL2eBvJESLD9Gl8vjE7ObjkgrrdhbRbeH
	10biH7UVqEKZlK8PhomNqD0dRKwC4wH/Yi1P9cUC14iYImjlbiAR7OqNmK6AAVSjQ1Zc=
X-Gm-Gg: ASbGnctMxLGLVbCKpAlqS6lf23tuj/stv59uU4nJV+8vxvh4N+dByhDZi4uLGhz+XG+
	vSd9BJ0jApC3VBHhiZ3Qyvi8eg1hrYVuK/OaaFI3cEvkwCqShsA3RD9fhvhx+fyFCg4Pz9XiSgm
	wz7qaRYc7TRBsCe2rql4XGNbQMPUTAJfUtt96UouDuhWzuq8T4C43DS4VVGjhns/Vcy3gSQ/BfI
	YfVjF68CvqeaaCPhuIxLT58qgeKldcOeWxXiMrL36kjzdf9fKuXZlwwUrCAdJV+2OJJhVbJ6m48
	/+BAWO1F72/UIld07h7niAilTgF0PA2vYeDYj8MI7S/mBuZSV1zzNLIBuH7NTnPUhNK+hC/wkum
	GFHA8odvcJXHhgBD/7lJ/TF22jA==
X-Received: by 2002:ac8:5d04:0:b0:4b5:dc4f:7d67 with SMTP id d75a77b69052e-4ed218b2d97mr84166711cf.27.1761922282466;
        Fri, 31 Oct 2025 07:51:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiqlPMTbBzwyiCGaE1HoFoxKY7o0FlGWqZYGr+NFtP767aljy4Y4P8W3NpsXWiQgKZbZKCfw==
X-Received: by 2002:ac8:5d04:0:b0:4b5:dc4f:7d67 with SMTP id d75a77b69052e-4ed218b2d97mr84166221cf.27.1761922281971;
        Fri, 31 Oct 2025 07:51:21 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4773c53ec43sm599235e9.9.2025.10.31.07.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 07:51:21 -0700 (PDT)
Message-ID: <34f9dac5-b872-4384-882d-227f0ee06453@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 14:51:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] ASoC: codecs: lpass-macro: complete sm6115 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: robh@kernel.org, broonie@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        tiwai@suse.com, srini@kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alexey.klimov@linaro.org, konradybcio@kernel.org
References: <20251031120703.590201-1-srinivas.kandagatla@oss.qualcomm.com>
 <dsgivtqhje3wnx2iuma3ngnq5kanmt6eautay57raf23vcxi2i@y5b3sg3mn5mh>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <dsgivtqhje3wnx2iuma3ngnq5kanmt6eautay57raf23vcxi2i@y5b3sg3mn5mh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pF6DTPwCnWvPNGQ8ZZjCAVf299HWZ-Jo
X-Authority-Analysis: v=2.4 cv=RbCdyltv c=1 sm=1 tr=0 ts=6904cceb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8Xdm6kdhLhAbRQ0PksUA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: pF6DTPwCnWvPNGQ8ZZjCAVf299HWZ-Jo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX4VKP1hS6ET+z
 sXJNOhOWZqFA8RWK0e/UHSJ/+yD32sVPCp1Z4PkW+SFVVuHNsVMeBeDo/86eQagAsJqY/XJduWZ
 Tx8ihcMVLwwhxfcIIGF46hx9P4M2FnOekGfVhkoQGOphFdJ8HHGJcJp/EjtfpKdwStkg5cRddGE
 nDthHjbvCe9vSvhtPS7y+8p1wX1LtIJdLdUk3810xNVAZGxj6UyVtAOhl5uGSPb1KHAh0vSiZuo
 i+zDT7RSg2PvCn/gFI7BnvImPpFUEHmhAR8Oljusx2H9pY/E3DV0ejlNlzgGHKDEpH0DqxUfv7D
 SXlLRLyabEeBiIBYVhl6hdOzHAuopkhQ6nIyKSJn+TicdtxiZBGQH9EBQvI7oMeszvUBqNAKO8Y
 t/0bfNeeZXaxLuzO7zRTnzaFbLC5Sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310133

On 10/31/25 2:46 PM, Dmitry Baryshkov wrote:
> On Fri, Oct 31, 2025 at 12:06:57PM +0000, Srinivas Kandagatla wrote:
>> This patch series fixes SM6115 lpass codec macro support and adding
> 
> Nit: adds
> 
>> missing dt-bindings to complete support for SM6115.
>>
>> SM6115 lpass codec macro support is added partially and broken to some
>> extent, Fix this broken support and add complete lpass macro support for
>> this SoC.
> 
> What exactly is broken?

lpass tx macro has soundwire controller, reset for this is not handled
in the codec driver, First patch in this series fixes that which is
also explained in the respective patch log.

--srini


> 
>>
>>
>> Changes since v2:
>> 	- fixed a wrong patch that was sent in v1.
>>
>> Changes since v1:
>> 	- cleaned up va-macro bindings for clock-names.
>> 	- cleaned up va-macro codec driver to include soundwire reset
>> 	  for sm6115
>> 	- updated tx and rx codec driver and bindings to have a dedicated 
>> 	compatible due to changes in number of clocks.
>>
>> Srinivas Kandagatla (6):
>>   ASoC: codecs: lpass-tx-macro: fix SM6115 support
>>   ASoC: dt-bindings: qcom,lpass-rx-macro: Add sm6115 LPASS RX
>>   ASoC: dt-bindings: qcom,lpass-va-macro: re-arrange clock-names
>>   ASoC: dt-bindings: qcom,lpass-va-macro: Add sm6115 LPASS VA
>>   ASoC: codecs: lpass-va-macro: add SM6115 compatible
>>   ASoC: codecs: lpass-rx-macro: add SM6115 compatible
>>
>>  .../bindings/sound/qcom,lpass-rx-macro.yaml   | 18 +++++++
>>  .../bindings/sound/qcom,lpass-va-macro.yaml   | 49 +++++++++++++------
>>  sound/soc/codecs/lpass-rx-macro.c             |  3 ++
>>  sound/soc/codecs/lpass-tx-macro.c             |  3 +-
>>  sound/soc/codecs/lpass-va-macro.c             |  1 +
>>  5 files changed, 59 insertions(+), 15 deletions(-)
>>
>> -- 
>> 2.51.0
>>
> 


