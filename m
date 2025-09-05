Return-Path: <linux-kernel+bounces-802887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 784EFB457FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4201E567977
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05C534AB1D;
	Fri,  5 Sep 2025 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yrk2MU6b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A545B32A81A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076054; cv=none; b=UCpKjR1dRP17UuKfu3hRiAxWgTg3QOwt+/mAvt3qkpKuqz+gB/WP/4rnKdXB6PTlr48T/7PtUF2NJ8fV35y+ruYjHfrq12dF0zBDKBTIEf+9uT36/vAgG5GztEG4hPyCgzY8Uq0EmpFoDXfl0OcXusL5C2W46BVHKMOhOy5p0wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076054; c=relaxed/simple;
	bh=RCvW+v+WM4Nm5wMAGPraUo2CrUGI6VSVlbDrWsaLXAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptZzUygdh7ck3h4lp1o5gziEy5bOe5gDGWAEYIeaGGFP49eeQvLU+Uf8OAP3ptWy3CQZN7lG9qGLl9PYyGgY3RhslBzKBd01m1yVqdlEuYklPhW58/9b4DynvY5zxq1oFF0zHGFLy0O/mwVgUGxSNHKVDCfxxtOaQJf+EDWEbUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yrk2MU6b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857GZF4031853
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 12:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RCvW+v+WM4Nm5wMAGPraUo2CrUGI6VSVlbDrWsaLXAY=; b=Yrk2MU6biv7gcNOl
	dkOKktv5V14eoWw9FdK0pOkhfEqLFuX7WIcDIU9fjNeKTcKAHgIb3eGLRYIY+a5x
	foIbnY+zxbT6ldQesjFPyIftRKGfafC9eW+Ym5t1gUJleQNreJ0Q+6862MnJUYdN
	u/V01tJOrqBEFUE4N0SQMRiJawdklu14kIHgPe/Ui5A1BU5l2qo3U7bjp7BzXek/
	u0sPinUXpmUEPW9KvkMJ4w/P8rh3ks3OeARDuDhonAmMKcWGE0MuIv0ith7lXIfl
	E1XKzFJStNLQ8YWDFFmkZmfj5dvy2HbfAdEX0cELQ0/fIwNQ5RGgqJmjGQhj0llQ
	8NdvxQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw0b709-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:40:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b48f648249so6571761cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076051; x=1757680851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCvW+v+WM4Nm5wMAGPraUo2CrUGI6VSVlbDrWsaLXAY=;
        b=CB3mEAxp1SSa4diYlJEHCdk63cGkw3UWXBJoeFTYYthdrZBm0qx1yN+JRtzzw0LB1h
         2BzwuvST6Iu0+1upAMQnP/9P/WXhXg+mqHBadBHIJ3VBbs4i/RYk3Yibg9YTBVeUULmF
         7i2lCpPzGWK17XJgqwh98SMpfI+M+jnRNMF3pQkpgSEAjAt5VN+slYCcHFPRYlblvWbU
         DLrNjvUuuNzsGvvl2OoIxjqQ59YCZ0kEQ/RSMLMH1HI4l6rkdJQzDQnRvQWxXctw/DJ1
         4TgovMs/VHA/Cn4Pxg1UG0z6BfDLTyM53rYl/gSBo7B7ExMmIphfGSBP3g4NyIdQbtgV
         +MrA==
X-Forwarded-Encrypted: i=1; AJvYcCWvw+n0P6l4hGnviecsC9Qnv5U1rPY/Cfi+/TOxg2vz2ddLeeoAX9oLoj8Xhw7rbGQHs+AK3tGBqiywefM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdb8nIuv+Kzce/YJeB+k2H91K9QKNcCTnfd57LB02IFYqlBedJ
	4iULNTlBs36zT4agm8XhA3kYIi7o2sQ2VGrO1GqE4qNYyMwgGGWL3fwFYSHjitN3VPyVR3DBfCS
	IEY+1F1T3/nIhaSXBSZ2I9L1tqJic6pb4TU3OauCs4RrVuubP3BXhk1V/tSwuEzKI6xE=
X-Gm-Gg: ASbGncuxvKK5/lx45mNV+FUor4mRykB4B5PdEYnB43LWaPVY3EbTfQM2CxdaDVQdNam
	Geia1TbVycBBB8ikg866isV3en5Re340SKV66bdQoqBP1AyayiZX9RST8MoqJVH7KdoF42Jscpi
	aAj6N/UX6oBwj1PZrrBNrp+UHcgaOe7+y3VeRGaaX70nT3WvDkhdfyXEOuF4JDunKB2f9Z+7Ild
	SK4hJJuCADGVamQZ/SuPENmpAM6MStDSE7/EuWtM9io8URtcORX7exiC7IfBQGqEMAbpn+Xrmgr
	+YDYqzYeslKgU5icc0mMqCD0TA2VhH0MKY0hUon/e1LO+P45B+OVgS81aj3y01UIEfRaJllsk0J
	Wn4u1gEeLelbJtD9ViBIemg==
X-Received: by 2002:ac8:5a48:0:b0:4b5:eeb8:9dbd with SMTP id d75a77b69052e-4b5eeb8a299mr9780801cf.5.1757076050536;
        Fri, 05 Sep 2025 05:40:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhwQd/eQ/Fwu0ttahhKY21yFepGgyDfwsgnKKPIe1LttWQUPiyRGUF7MyOygLic0H9YbExGg==
X-Received: by 2002:ac8:5a48:0:b0:4b5:eeb8:9dbd with SMTP id d75a77b69052e-4b5eeb8a299mr9780531cf.5.1757076050011;
        Fri, 05 Sep 2025 05:40:50 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7a27sm16591905a12.10.2025.09.05.05.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:40:49 -0700 (PDT)
Message-ID: <daa84fc7-b191-470a-933a-b41b8713d1d6@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:40:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: qcom: sm8250: Add egpio support
To: Sean Parker <sean.parker@viasat.com>, andersson@kernel.org,
        linus.walleij@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250904170613.68855-1-sean.parker@viasat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904170613.68855-1-sean.parker@viasat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kpZgOD8-TMaHCcoN6IIAEQI7YYlcSYzH
X-Proofpoint-ORIG-GUID: kpZgOD8-TMaHCcoN6IIAEQI7YYlcSYzH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX+8CMc7DxEcTP
 JHG0AMyRgfAfye7xNn1K4Z3pGi2dZqZVfN+JivN20GPH/7XLTxCvdf5M7uFR+JeOrRcN4gIEg4V
 7lquLYcU7vBUul/fOCRo1azpgNm1Dcz/YYoUz76s3Eg6jgwSMPWN5WY+2y6la1sLitT/nuZLI28
 sUYFqxIzzhJuHW2i4iV6tu3wBv+iBTFhVn3UcZLlcjHOYs9qsSMSQn5viFaWBQuyT6MRKyBfSkM
 rSr1kix5McTSo3Ts8tU0BoOYKJZBplpwmi8LZkX5/A2iPFknTsJJi2ZUl5assk3luGZD318qJuD
 osXICcKz8lH3ahZuf62aZZQG4XRPlgLz1IdF5z0unDg60BeXyf9vw+S9zPb48laD+pMM/K3u+PO
 VxeDONj0
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68bada53 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=o8bG7SlRqXj42srI09MA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On 9/4/25 7:04 PM, Sean Parker wrote:
> This mirrors the egpio support added to sc7280/sm8450/etc. This change
> is necessary for GPIOs 146 - 180 (34 GPIOs) to be used as normal GPIOs.

* -179 (in line with the code)

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

