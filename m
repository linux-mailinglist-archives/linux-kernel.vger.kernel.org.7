Return-Path: <linux-kernel+bounces-810161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F5B516BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069F77B599E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7224931984D;
	Wed, 10 Sep 2025 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wj/r7+F2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D76B3168FC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506911; cv=none; b=vAR23cDxphbwMDLNyYB2YMmGMBIch1sa12YfIQKefuSV+TWpgjqSQszQ329yLbFxi5NlUvVI0Z2xWtGGQlPiBN0J9ftKXhGrcmW2SBRBpw6ynXhpaSgoA/NhD5M0SBAOF0JgUmiizAbV/U2yXe7iY3m6CtwwhL/Wdf1UpVN6Ahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506911; c=relaxed/simple;
	bh=X6KFvaVVEp/dLB58ZazXkEEJ/edkPXleLAnQlioyPKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XO067joMPRIB4whVT4/VsppJ3OzOoWQW4sExF0Cc8CQFYFtY0VBfJF4bZNpEbNOU2ByRO6YhG0dYHVBq47SQCYTaLMYtOel7vsxggxBm73jvGx11Qi1BKa+EcINAoBXDfW4yLxcVqlHESS2KgWAGIh9pjhYYrcd77jhm+B0sqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wj/r7+F2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AAFJiw012722
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0vMWTcElNgxy4rtHU4PlXXcjyINdBlSlLR0M7KQ8Dho=; b=Wj/r7+F20oSLhcZm
	gR7IlHEw0gGVfncRIWGRYXpijto16adl9ymBPXPuthfLEojRI5Av1bSHNvA49oIj
	aCUo37w1MOdFQk2HGeF+I4PlPmtIitFaGpFFNZwwkJQ+sYMmaUVYmGwHwgduKqyo
	88dNq3C8/tWeLOKZiMmzocJYh2hsmr24WCHA86087SNLdxn07jII9v5S86iR9b5s
	WTNpjisCL/gnTjGLu6uqZAK4S2AVnURN7MXCr8nJbzcj6xRTrDHQK13KyqOHy0g3
	9WWrWrFoZiHu31WeP+ksnlF1BMVx2VVBarAQln7F8AZZBIiMDx5iQqldQ5r5t+4/
	2YFssw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqg3k38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:21:48 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b612061144so7704231cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757506907; x=1758111707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vMWTcElNgxy4rtHU4PlXXcjyINdBlSlLR0M7KQ8Dho=;
        b=vRw1P12lvCH+K9lluD+QdyQ0IM+Lcar2yaUT6QODtbR8e4BRTH3rnTKR834sf+OI7l
         7jR9hrvNOrVbBCRJpD6m2F2yvaILoEpV7pMaHGJRdaq8HcWbeJYgSVGAjpUEZaQnbo2I
         ZbLSKmFqe0rPCxcAdO3H/ZCXlgshfBWL18+WecoxNGoF2XdVZxIotbz9NkzNfIMHhszL
         +URN8EduEJtf/W1FpOvbU4bhMAA8GZZcKLN0W3pKkx9MDxrAW9B2VhC04keK3LxJRhXV
         Igr84LXazaQWV+KWK1xW3xyN3TIggXmsHDOM/vN0oY6IvL86nefI3uK9GHE/CiU3hyLt
         brnA==
X-Forwarded-Encrypted: i=1; AJvYcCXR1UwhUba0m2tASvn/x5bYy2Pc8YWT/Cft0niYMkZM97MzOgx93TeVItVeln7Bk3Vo+1Py56PTwUl7X4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFgmx6dajtoLEQbQJp6M/KODSU24ATJ3Rxx5wWafYe2+5PQFUt
	2PMAOptiBAjoGbY6yE2mWwWOFSglu8wsGCCtd5ZjUiMdIs25IBpqafVbUCTWdKIg3hzJ2D7GBlu
	WzHW7ZiTOitGjSoa1l9vYQAuhmRgMW6YaGsgD0rCcNr9meNHNKecNSoH2s/C4hoKGsVU=
X-Gm-Gg: ASbGncvsAgHnqyp8oN4gX4st4sYz+yWHg6E9s+ipu6E6L/QTQxQANoTU7V091ECWEF8
	R0tpnwCY9k5N6f9bA34uZ8ywxxhjL1XA7nZySBlc3DNW5tXorhnPi4mHP29Nkkzi+eLek9UXyMb
	nAsqyN9oERRFFw1wKCxSV3ea2V0ZrduNom/AfB72IaI8rlkcZIf7VDJh6E9U+14wtJr9T0ChzQS
	rSTTs/sS3uPUH9B/51I3rSDAGv9We27BK+QNnYq6isEH3M8vrw31gG1woqglregSPkSmy2kNMAp
	gZG90yKJf1PhC5uBenz3hydO99AWRYUc/3zWvkzY23huba7ssQr3nCqKPLzI2cUF7/cGxGcbK5x
	9jGL9a+i6TRM+2YKIQ8bxNA==
X-Received: by 2002:a05:622a:1787:b0:4b3:4590:ab6d with SMTP id d75a77b69052e-4b5f848d05bmr107672701cf.7.1757506906952;
        Wed, 10 Sep 2025 05:21:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQM2ETnZwgBv+qedS1fE1v5n9TD61CTWqUhCz41J601U3LDyveBpzWSkY3wpyOOnfMzFjhOw==
X-Received: by 2002:a05:622a:1787:b0:4b3:4590:ab6d with SMTP id d75a77b69052e-4b5f848d05bmr107672451cf.7.1757506906461;
        Wed, 10 Sep 2025 05:21:46 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078334e86fsm158892366b.56.2025.09.10.05.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 05:21:45 -0700 (PDT)
Message-ID: <1f979b86-b45a-46dc-b926-64f5b1b84f7b@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 14:21:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: sc8280xp-x13s: enable camera
 privacy indicator
To: Aleksandrs Vinarskis <alex@vinarskis.com>,
        Hans de Goede <hansg@kernel.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Mauro Carvalho Chehab
 <mchehab@kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus
 <sakari.ailus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Thompson <danielt@kernel.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        threeway@gmail.com, Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20250910-leds-v5-0-bb90a0f897d5@vinarskis.com>
 <20250910-leds-v5-4-bb90a0f897d5@vinarskis.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250910-leds-v5-4-bb90a0f897d5@vinarskis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oYN8zuBYG3gZvmWZ0r560_2jRBrY75Vd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfXyIjtpneJkSOP
 BbweNFrDPP+eheTuMAFlEsHJxEs72esnOt8AHvsz3vP3WiBQBz/tx9pmase6Uk23jLv8YXDvZEu
 xVMgp+fMh/s1lo4jj9Me/rqm5SPxIVkVlX6FkMU+9wyX5VzdzEhf9vwMCccMtQDUJObE5dJstVv
 ARAjJlj9zOkhYS48r1agQq2pRsdirhB8ktaKt3jdwnPSXRkFX8VgyZRj6iXGe5vRfc4hpdey5S3
 vWKO0I3mc50d2fxyo67L5l5f57Ufc5yfFLSb0M1QuA4YRrbs9hLbqJwet0+Omg4PlwOtLTA0z/P
 yKnYSPXNS5cpQk7jGG+Ug+FH8MteGHydAVozfJe2ZvfoDsSBZUlRoOViXxXIfLOXjuBo4leOB/N
 JxbSzGHa
X-Proofpoint-GUID: oYN8zuBYG3gZvmWZ0r560_2jRBrY75Vd
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c16d5c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=I76Qk8w-AAAA:8 a=EUspDBNiAAAA:8
 a=q3hGUckLsqYRD40seJgA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=vUPM0Wvl0xcrLs4nqPIT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_01,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

On 9/10/25 2:01 PM, Aleksandrs Vinarskis wrote:
> Leverage newly introduced 'leds' and 'led-names' properties to pass
> indicator's phandle and function to v4l2 subnode. The latter supports
> privacy led since couple of years ago under 'privacy-led' designation.
> Unlike initially proposed trigger-source based approach, this solution
> cannot be easily bypassed from userspace, thus reducing privacy
> concerns.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


