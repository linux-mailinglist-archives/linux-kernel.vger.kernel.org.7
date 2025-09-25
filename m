Return-Path: <linux-kernel+bounces-832154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A30DB9E7DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107FF3AA1DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEA5279DCE;
	Thu, 25 Sep 2025 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m7eaxLLd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B881ACDFD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793723; cv=none; b=ORU/tzD6LTBdDpE/N1EuO7C6zS/fHrnovnR3LR0BtF33wRt7KvPZ9PxUEJhhcdZ6yWKWxyuA7ThnFlgfHi37L3hjZq6qDQj0ftZSlOaENrBKzBP9QJSM7WzDgyHJlc+8nvYBSllxkGEcffZv3gZlnPan/EDGT+wnK2uLWsO56z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793723; c=relaxed/simple;
	bh=fwqz9ukGkSB7nQ6RVe6CRYI/1cDROkzR8BkzCK6xgws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAJ6uJwqPlzkaPHw3s9kQCtUS1kTHJGTFI3g503LOu+LdNy7I3pM+nABRbXDbvjEM+YCcGZMXtnj8/s6DbIXC3dauoUSeooQq/flOZXJqmDssv1COK9ioUKUCsmbj1gSg9HjUZ8zVS06YP+Q1sBoJyaZFNAUihOdtHWyEA0CflA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m7eaxLLd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P4aNQJ027602
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GR4aDHZmhZBwmaG12GtJDL8oCuro3wUhp6sGrSaguaI=; b=m7eaxLLdH1g46xFg
	urwnknI2nzrjPOU3i6E8gVZkG0nasuC09LhubfNqUUJ+mHaEkX//gcFJyHIbI1Mk
	mZy80NDu/Z8HDb38x9bmmdZKjtna8AzNFr/ZYb/pz5YwwcpPKmZzqIPlxU+LjOM2
	HLb5Jragn4FDyQ9FloYcEDFG8UZAwVmc1RWn+vHKG00aALvpIC78bifXOtJIc4TV
	K87KAtgPp3x2pB//y++UN2XJ6N3gjc/jmU/QiU/rqoUbdSlu3OVOddTuFWY7klgl
	fjArjnHzq70UCbqqtnJquEE2+VZUPiSsBg0q/QVMCDASLH5YTAyM/7v/8s97EqGH
	uSqxMw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49cxup0uhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:48:40 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-721b84d7bb4so988346d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793719; x=1759398519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GR4aDHZmhZBwmaG12GtJDL8oCuro3wUhp6sGrSaguaI=;
        b=ErgBLdz0lTb8BgIDMwO9LjInHDMVwBlwMqAs6Zc9K7iu7eBRHM0dPpoMCE21p1kaCV
         d4a1xEfadbhwiQ+KZ9Kwf1/OpHEzMLt0gyCMjIBPW8RVnNeZo0PQWCHsueq9LBxNZsaH
         s7/4IgNj/geAFje/2/+c8EAl6mU5hz8RJerT9k2cmpDEUvdPFgW7sKapLgkTbqxxRPzN
         Q0Acxc+3Bss1kfOB1rJU+he7aTZb/CSi9HndUHuoV5kX4qL9G1KhFVVYnlvYGgCIvl7/
         xF0khlDnfSHVxI2HYlf53yV9evEh418Q85JOes/0FsDg9se77ITxXhU+skdr1Nfx4djY
         Fc2A==
X-Forwarded-Encrypted: i=1; AJvYcCUEmEU46dPk1kz2syd1pDixnuhERGxu6tmQ148WBSdDcIfr431kOiDvccYfx5ZnEgT35a+WgbOPT4yuqQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA1sfQO8gGeRXXmO5warO2vMMLOv5HT147nQOS5detOWVPi+bm
	/US3Ek626dvHXVOldH/LeRpTxevL+BC5rmB8hohJ1MRC/UuI7tWNVo/RNbL9iCppjH9DSVMG2xQ
	d4Wkqvd/+IbRGe0C6NOf8FQGlC6exNSri6W2X+raFZTnelpL8x9PCWtZT2JrjyaZvo8A=
X-Gm-Gg: ASbGncuvrmuPLROcC0ApR6spcRGGlWKgQUCCygwpY+UBu1A3l+A8FaMKUTt++Z1KtLO
	56FH55UzZSE7kRgAcaGYXQE7M+oBraoCZhwwZN240PPbMnBDzYYVP2ThCYM/W2iGKl7hlGH6sH7
	mIDGLSbU3zJEgaz58489WVFcVi7c83sTngC54dhHIXIz6vjWs71dQMUqi8XtwJV5cfMW5pBxID1
	EOdQncQ2c0tJQ+iniEJiBsAiG1wFLphDvR+8QsHUXvOd3qzQ+NSFQluiflmo8oY528OrxA08Q6w
	RMADusVEORXbbbAWeohkuE5vzyvP5LBglpxwc+aIWGtS5tEdaMnKI6nbgZnKv8R8pH3fMHcRamD
	Y8zI8rFn034rSZyZTvGOzjg==
X-Received: by 2002:a05:6214:f2a:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-7fc39460be1mr21832836d6.3.1758793719152;
        Thu, 25 Sep 2025 02:48:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENwkiAkwLrvqAp2PIFN0hMMx4wQy6rf7aMEP/NqMglaCPy/Vd/ggqXiqJ+HQHH8XZj9B8+Yg==
X-Received: by 2002:a05:6214:f2a:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-7fc39460be1mr21832636d6.3.1758793718628;
        Thu, 25 Sep 2025 02:48:38 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af5483sm910511a12.42.2025.09.25.02.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:48:38 -0700 (PDT)
Message-ID: <26467336-3322-40fc-8dcb-efc06934162e@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:48:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/20] arm64: dts: qcom: kaanapali-mtp: Enable more
 features
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-14-3fdbc4b9e1b1@oss.qualcomm.com>
 <ejcchgc3isc5f6tmiqbxqihmk5efmbcyhv3ehuoerb5ulkd5an@g7a2wc422l6n>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ejcchgc3isc5f6tmiqbxqihmk5efmbcyhv3ehuoerb5ulkd5an@g7a2wc422l6n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=B4a50PtM c=1 sm=1 tr=0 ts=68d50ff8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=8xtE-M9Tj1n2mnedfNEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5XHQ0vS7sDUA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA0MiBTYWx0ZWRfX6Ix+wlgXxNjd
 e4Xam+5mwIsm4k2Jv1t+2iDMyyMwptdElU+Kp63l+zU5xpG9Pgt2HpfejR65B5/bnAC+uaMQFrD
 k0Gn+qgVOET/yOlYNUesnNebnFsCxcJYYz44MOd2ivttlr6kOnksajkpKvz16ZCgyMHfDCesVqc
 OxVQkJV2BDOEdnnknAFAGkvf45lLCixJYMzYuCt5SQbX3TIQP9nR5CfDcdZbBng8VbxFdPpc0bH
 ehrJMKBlwGgwqlhkgdhJM4rv2qI7hMiJVZyuGQWaMDKCRXtKqudiaY6KpALlzZmpTvmzEBf4lkM
 c0ECRlr9Wg5gZWxVHaAw0cCOlA7HCuNK7+eEuuz4vo01Lab8vkN7PHauKh+KP2Fch5KTC9MUggK
 mnzyBexk
X-Proofpoint-GUID: 9P9BVku6BG8IeOgr5RSIlVdp3rYv4zQ_
X-Proofpoint-ORIG-GUID: 9P9BVku6BG8IeOgr5RSIlVdp3rYv4zQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509250042

On 9/25/25 4:09 AM, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 05:17:31PM -0700, Jingyi Wang wrote:
>> Enable more features on Kaanapali MTP boards including PMIC peripherals,
>> bus, SDHCI, remoteprocs, USB, PCIE, WLAN and Bluetooth.
>>
>> Written with help from Jyothi Kumar Seerapu(added bus), Ronak Raheja
>> (added USB), Manish Pandey(added SDHCI), Jishnu Prakash(added PMIC),
>> Qiang Yu(added PCIE), Yijie Yang(Added WLAN) and Zijun Hu(Added Bluetooth).
>>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---

[...]


>> +&tlmm {
>> +	wlan_en: wlan-en-state {
>> +		pins = "gpio16";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-pull-down;
>> +	};
> 
> Why are the TLMM pin entries sorted?

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-nodes

"""
For a few node types, they can be ordered by the main property, e.g.
pin configuration states ordered by value of “pins” property.
"""

Konrad

