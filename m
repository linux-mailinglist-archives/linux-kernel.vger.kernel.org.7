Return-Path: <linux-kernel+bounces-820888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D71FB7F9A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99ACF4A2E47
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB67C3161BF;
	Wed, 17 Sep 2025 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dFuV6j1I"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A0316198
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116673; cv=none; b=tbPxzTnzuSL/qUMPw975Bey+7Tvy/zksBJ/swJf6aPM48/pr5XpvDkYO3D6v/wThPfod4bgV2YTzNGOBYhpfis5HAfLmhxj7+JZ2yA++PsCxOASEXFeOxepOt4H8fQ1kpjnYWGx/C1OYb6T50JHGXQSaCqzk2Xpezduk0V51kqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116673; c=relaxed/simple;
	bh=KGJ89Ip8KM9yZL2AtmSDAZ9jlNfqx57J4QYJKCHMZKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaQbey3zZhvvST+fK6sf9NUCx+e7wN156elBYaHe+tJHESxlokeajKYUZzXFTJQykCRDUZoc1czFoZAz22vZOwl4o3Sn6fy/xzQkNiycYQ84UsydxtLzX6jpP6EqZuuvzHTepAOzdjOWtlt+9oqtccspj3XgvNMuu+tiw9A3BBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dFuV6j1I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8Xn2L027424
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TB+Y1i4qByytglaeJwdA9wSRh58asAd6J7+AJTfzU3E=; b=dFuV6j1I4rppQykC
	NjlBe/rH+YCmt9tVxfaQ+eea61I/aUWcKi7FfOPLC3tMoEljKbAT8UOsvlxAPOJs
	2NFvfXKfDc/wFQ6MVYCtBD3rWf1aZ20/aUQwdTEU8WlyAz03EXRK5OBzB0k7fbnk
	yb2nT3hULCJTXT9qhcfmljO4UPzP6M+o45vMy02uXLfwh4m3iRYPB/Dd9a/VZanj
	EMGW6jEe/xieIC8jn/4Hk1khE9cvBRhGDkZvG2nDKGyzzHlauy9HNOLTmhnGVxfg
	QuwdiLZL/50A1luObaJnRZt6gZuO39MRV6vj9VUYLv0MI+TToThkkjSeIQ5EHZm5
	mT3gzQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt2j5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:44:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-828f8db42c9so69998585a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116670; x=1758721470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TB+Y1i4qByytglaeJwdA9wSRh58asAd6J7+AJTfzU3E=;
        b=blaiqtn5O+LNDMvG42FuaBwephSKG3bHBI6jMrN66boyCoqdrDbski5oTK5akQIJLW
         jGwP5NTEI11hhZ7wPa8VHd4KY1hHTshKjqIpteiKO6i+rVWsn2FToCfc2LgGc6PS8NP5
         lHVfF0x/Z3wV7TmUwKWvzhWj5eo2q/F/Na8OSXqoWeud0BKgekpSYHtGCQRnJYGZJjAP
         555WYQ33ikTPeIZSqil49TRZwMFCOb3plP9UTidcTubsSKBMf0Mk2oaI8Ss8WD6AQ6ql
         NRONGXDl+GKF81YRQZtFCwsiFJQRpBVQd8B38V7glH/4jKfd6308uhgoDA+aR9XZ3vPx
         1aXA==
X-Forwarded-Encrypted: i=1; AJvYcCUv6D1VUtZc1uEN15hMBdj63c8yWSM4Skca3OeXANoEDHfhkZWY93V4a/qqYKlZLcWigYuxhoftRGr9PdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJemlsWGN2uxn/v+8OOtn2KpnB0ZEQbyTDvEJkxTe7sRhIunCa
	rxy0p8oK1c/tMcTy8ky3Sm3G6PpDAY2myy9UzNF92KUtQwELOA6xlB8YMmKPztcitJwzEy3qmUH
	iwASGdVXa+axmtqtxXY5DEX+QRlvRGBis7KbkQhhQ2jSk0ib4LFBo3DGhiU46RgRBgEk=
X-Gm-Gg: ASbGncsQNUNZW1GMA7yUqQc36cwyMCr2F+sk/2nFWYTp2rzByoi7xOm8AW209MaF7Bs
	MAdnbEAtecfjlC6YULCAfrIxsy5AptCSIRFIvt6agF+8Q7ahbftElfqYwH5R4sMEespY9pY50M2
	poTgkL06g1h7JOqcNeU6mxo2ydm4OrQRa1ZH0IEHtGpGK3NXafvyoAg2GGy3JQ+AvG+VuW7kn1B
	OJpH6g/SE51qUeCxFDj7JvoeMiDgCuS5/SpZYuCbOzQKFTd66+Jxdj6Oi0rtr//22d8AegMXULd
	fyQrnYT6uI0yCin8ahf1mNFqs0+n6OUIrPQS2yrC8CSr/aHRyk2txft6Nj4yd5x9V6n5oUiXXHj
	ZjSrDa++TEZxYJJReOWfqJg==
X-Received: by 2002:a05:620a:1a8b:b0:80e:3d31:372b with SMTP id af79cd13be357-83107192cc3mr144040785a.3.1758116669824;
        Wed, 17 Sep 2025 06:44:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH41xmt0ry6CW9CnoqIFFt+3vfrTnwf6OeUKuoFjN86Vs3RJMW2dcmvW2InNVBj9vsJSekDVg==
X-Received: by 2002:a05:620a:1a8b:b0:80e:3d31:372b with SMTP id af79cd13be357-83107192cc3mr144037785a.3.1758116669234;
        Wed, 17 Sep 2025 06:44:29 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f2122sm1376701866b.85.2025.09.17.06.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:44:28 -0700 (PDT)
Message-ID: <83d57576-65da-44f1-b9e6-3ca04c7e295d@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 15:44:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] arm64: dts: qcom: sdm845-lg-{common, judyln}:
 Add wifi node
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
 <20250916-judyln-dts-v2-7-5e16e60263af@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250916-judyln-dts-v2-7-5e16e60263af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: S5EcTmTE_2-BzrFhQModCnvNkOwolju_
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68cabb3f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=Gbw9aFdXAAAA:8 a=EUspDBNiAAAA:8
 a=GROcJi4qiEdEo-BvNFUA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/DKJ1UnyAU/G
 8ukPY9I60esmyaS0z2vgCuHOg1ADneVrxBVY9kGQ687gMQNLcH+3lmJE/ilYK0A55zJwvwKi30g
 +OFyoqKCm4U25O+DkChJKasAKvTN0CD5wSE7/Cxml7HTc/0nNy1Fd1Ft/qVW7jYoxX79Yx3LBVB
 BxKUzlwccBjks5CIz/WhpEbC7Ss+/jJLxR4zD9vGypm/6S0LWdrkz5xhG+Sc8TYLtwq3yszuDoI
 12J7+l9uUNaOJ9JYat0XVETtTzs6XWvp8tFcgvPKaumVjhT5TKoPtXLWyiviVA2qt5hOTTav9lH
 5g3YZ3hFuVy9xAouHWXbXhV1a9YX5e/yOanWwiyuddBShDcXQUrtvJYyV7HIDbY4oBJzhT0RmOc
 yymB0vKO
X-Proofpoint-ORIG-GUID: S5EcTmTE_2-BzrFhQModCnvNkOwolju_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/17/25 3:09 AM, Paul Sajna wrote:
> Wi-Fi now works with this patch and relevant firmware
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---

Well it hopefully does ;)

Would you mind adding a snipped of the dmesg, e.g. as Dmitry did in
Commit b6a56a5a25d6 ("arm64: dts: qcom: qrb2210-rb1: add wifi variant
property") for future reference?

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

