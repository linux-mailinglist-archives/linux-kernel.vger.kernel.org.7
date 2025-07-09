Return-Path: <linux-kernel+bounces-724173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AC0AFEF66
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C071C416C8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E6A22425E;
	Wed,  9 Jul 2025 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MGtx7E7s"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A2122DA15
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080817; cv=none; b=nBIFoVCDJYvuySrUVlJ+EJBCyg10/fasGnVOkgaIeT7V0SaKTuelYqZIxPmiuTnNCotIwGPdFcP8a/B2vvV/X3GQjTW33xRaUw8kzT3gJPX65yneGGQvvP6stAutL/ciaZKAROIAA58Spn0fBg1F6Vz9zRzEflg9q5fIk+/mD0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080817; c=relaxed/simple;
	bh=Dd21ohWnuUTS/BXEfrNOepJdRU2lCK7un9IzRE42mpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0FpKzZ5QsQcBnIcODvwMAokoWAdXVvtiqN2zLIN5cTLR6fqgLcGyzK1XInEy3YZGcrBBcWjoVy6WWCqeV7O9STCa0wIkxvyL1YE4XSGZnkA+dml2ImiD941hgI5OJedwVqBV5MfgErh+RwS4EtRd6reOnpPOj/838EprpLfYoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MGtx7E7s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569CoihF012560
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 17:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wh8yuaaHqpeTognyFmCrL3eiw6cJgczdQVoN39qvEms=; b=MGtx7E7sFI2v1NhU
	9/x6p9kRuVLvZS9Bgv+Y1AVL+bl8gQlirZkBOqoD4ZaItkc+J8+ioyES2sM+XPmO
	cmNne12dEhfxazHku+TMtcD3QGnVRoB8rejhzCCmjhVdOwI5E6xO80Sg1zZkL6bX
	ApjCCEP3PInBtkNqQ2l563mg6vQjKPepDQsyLK5qCqvn9+PX+Hs8bs7MTcuZypzu
	vBAyhvfUyDxO1tpGLxmLQeptUUl7sp7MNwy4GMWVBN6ZrThpQyu62ndb288Jn24X
	WBjpzBrgs9+Y7f9DUOQp/8P1+sEByaL3UpfVSOv9tLTMfQFMcb3WQl6vQUYWWHfZ
	55OtWg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucn5ewg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 17:06:53 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb030f541bso351306d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 10:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752080813; x=1752685613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wh8yuaaHqpeTognyFmCrL3eiw6cJgczdQVoN39qvEms=;
        b=NWosSHVlU+l69iRVwqPL5yVuPxfA7WkUhsx2SEvdQv03Mvkr02nC9GEB0PhFupXPBp
         hl1MrvlQ/fmJZ8Uezyo8wT32SVtDnTTl/NeqJGL368Q2T6ZEo/Gq0Q1nNiJ7vFCv5uKQ
         8iMhfDkmM+WmAl70ge2w2xGZWYI5WIu5iFxe/nb6C7hs49121cCKUKz/GDPMbqYvKL63
         IdWzw4aKOj6mq4ercO6z45dtf9XxMZFbRBAgbFdjOhgF17mCpmfM+FopJMhHEOzIcHv7
         8GYSKq158VDhZctcIcIG5508GktDNiU70jxVcPGDu2OCchWWKfvvdeeXqZCwgHuNSzNJ
         vSZw==
X-Forwarded-Encrypted: i=1; AJvYcCXCk9DSUclo/3ScB8YOky1Lyk4gh3aQggHCagi4wsjg2skgkxyu5dnkKqSn9/Y7RfjA16f5PjpDMOSywJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1GEbWVD2n/kZWjaZyikM1W3yMfZr6gjb0qcjWoqItULGLjKYs
	VcDysMy7uzR3gVyBPZ9LuaQDWfF11CEzkAw4pYwfH1vc1rfIq+HQJ0fYrQ7CP9n+u24mQdoeFn5
	53AvTsDGkqvjjyYlpWIOxFE2scXpZVyV3/GLIalA1XBnYFjKavWAfnaekixvlhG2oDls=
X-Gm-Gg: ASbGncugIQTB9tr/c6OaPm/CEXnLLB14jiTsDE3TghW8dSXKuvxMYTT5OwE8UPPJqo9
	yFayYPqRS+ALidAXgeQKtHGEvLYF6pqgjQADwviYxYMtmn6TD5g9XxoW+hDy+ngkcTaO6pIt/HR
	Nh/fKbdHtp0iRIZEpaoF6ycisX086QD1sHiZXA2/+lzErJ777tCZFAS0AJKisa2OF5CjT3R4/fW
	B+OxmteXr0iyLjMEm/2oIOEjGPq94Z5yEQfabvGF7FO0lc4UZKVWM3TQ7blSYBGjqCjq++8ifW4
	qQM6ICqdq1SsfasPf+mLj+7d9yusiZqV5MnQvt5zTLQrkYkS4pmm0TvUfXudfvTTkkhi46LE+se
	IJfQ=
X-Received: by 2002:a05:620a:318b:b0:7d4:5d37:4169 with SMTP id af79cd13be357-7db7dd6a732mr172205385a.15.1752080812947;
        Wed, 09 Jul 2025 10:06:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlkcqXa3BSEjEs9eL1FjQsITzwJ/IuC4Kr/+Nt103WxumFedL2DSA4y2nT1n/tQD+IDxMScg==
X-Received: by 2002:a05:620a:318b:b0:7d4:5d37:4169 with SMTP id af79cd13be357-7db7dd6a732mr172202485a.15.1752080812237;
        Wed, 09 Jul 2025 10:06:52 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6abfdb6sm1137405066b.78.2025.07.09.10.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 10:06:50 -0700 (PDT)
Message-ID: <141abf1f-2739-4ccf-8a2b-3451c299ef49@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 19:06:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: add a sub-entry for the Qualcomm
 bluetooth driver
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Shuai Zhang <quic_shuaz@quicinc.com>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250709144728.43313-1-brgl@bgdev.pl>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250709144728.43313-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686ea1ad cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=rZnPLpBaAhPpgNZSqhoA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gxZGWFUWnEui_dZ1qGXdxWIHQZShVelg
X-Proofpoint-ORIG-GUID: gxZGWFUWnEui_dZ1qGXdxWIHQZShVelg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE1NCBTYWx0ZWRfX9Sdy0nFkkfnu
 gQ/Wpxn6J5Q5blaBXU9Gb5vtIx0BCmbpslgK01tYJ+o53pzEJXD1vnKWoGsvUeOrx/Bv5L/7t6G
 OtRvby2qGVlUg8X79XaUnP0sHpkGenTBxn0kvt1Rzm8fNDu8is9WpyFguhM+wHjzK73mncQ8Mvq
 qE7BAoqawGCMbE+u+kDsNfAreZnHXS1PsfmI0seH6mai7pO0EI3+55fa2k+y4iWmH5WpRJZ1npZ
 YHQh+IENSGcw+BI/TZiqxtbkTCGwsN/lMm8t1vjmeBWSK+8TxslrIw0m66hdqRhjXrjdM8IN24T
 AjfwdBuF2T5E3Gzw9QBvKquJ1NtpwaqplCoBltVhRU5mVDeloyta1tKgwpN6H1Q6Q6CfhJAGGOP
 aJBNh2V+4goe9DHM39mWYDpyffvPA+TKE5tu4iKzp7cb8DOJAtYZ0GU7B2a5cblPmNG/fsrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090154

On 7/9/25 4:47 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Patches modifying drivers/bluetooth/hci_qca.c should be Cc'ed to the
> linux-arm-msm mailing list so that Qualcomm maintainers and reviewers
> can get notified about proposed changes to it. Add a sub-entry that adds
> the mailing list to the list of addresses returned by get_maintainer.pl.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Changes in v2:
> - add remaining QCA files (Dmitry)
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index efba8922744a3..d018923ddd3eb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20464,6 +20464,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
>  F:	drivers/net/wwan/qcom_bam_dmux.c
>  
> +QUALCOMM BLUETOOTH DRIVER
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/bluetooth/btqca.[ch]
> +F:	drivers/bluetooth/btqcomsmd.c
> +F:	drivers/bluetooth/hci_qca.c

+ Jeff, maybe you/ath would like to be included there too?

Konrad

