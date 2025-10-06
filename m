Return-Path: <linux-kernel+bounces-842724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C90BBD65D
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B9744E2CFA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7374262FD7;
	Mon,  6 Oct 2025 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NyuYs5Nj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE577262FE9
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759741005; cv=none; b=EJG1bvt62dchX1gPeZEa4NnDUdxndiXVVvv6185oNJPeB6VYswJBwcRAVdMb7K+UckS3nmhrDWwFr71nYBcTe9QDrXJlp/6EFZ4kb5yrwLhFoavUUEax8hdudmxxn6cAD8xxQ29jPSQ2BgTIFPfDJT7UiOBb10aF6pMkF5YWO4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759741005; c=relaxed/simple;
	bh=C2omfl574gD2ono+lv2W/kKwtT21KCG21bqTSBm/BVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSWL9zyv0KyQycMq4c8PlJDPFYY9OxGMUOXWbfsa4fq5sqkda5iXbxsdWdR/sDI2VR0K2Pv4TOUxxZpLhs7UHQpVMYoFeJ1nzX4DatEAzbH++fBUOuHqMZNQyr1X+AjN9bf22xt/u/DZQCElQrXoDfGLEzs2vKbkH5NKzhA2XaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NyuYs5Nj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5961V5vk012073
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 08:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yjh2mJsH3wh8l1hz1Vv8zbtvWkAVhWXkLeApwLwy7zE=; b=NyuYs5NjvEepiQWm
	nZMOJJf2FCCimlJlK7Tm56vv4SJ7HeGblI2ANNaG3osV4ktVSFEjh4z7Vkg23vfQ
	1zJniOP7x6V8QhKbNbDRzVHl1ZRmTRpTEhlGBPhBcyrcfV1MZpUtJ8n6OHy79G++
	/hxwQVvehYMosbBQXX00Z+Z1GPl1bqAvOu3g0XKzklmYwBvjrsW0wZE9Fz+i0uyH
	nQWDXudsQLRiO+Mm3Ok4GPuZ57KkypDqtx15cClfvvJBdPStA06i8ReluFysriXL
	FgZVJAd8lQWN+NHJKes15aoJ+tcqijO0Qpu5p2uLsXxS+dwfB+PoSGGIfzTrg5h6
	BxFHXw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxn3mcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:56:42 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7abea94d621so10475946d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 01:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759741002; x=1760345802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yjh2mJsH3wh8l1hz1Vv8zbtvWkAVhWXkLeApwLwy7zE=;
        b=tK9Yok6bQCQRb+ilrPv5o8VvYFpNvlokRFaavGz4HJNIwq06dRL/b31yX/R9L403hX
         awUY+xQFXq53yz5fJfreXJFm0n7LaULVhkB860cNb9jmCaKUPjNSklztarLzz9flNeE+
         wH7EwUEzZJrl5apcELYczWZ1ZHfYsotRiJTvSTEdvS8o7UiwLQJsnWlT8ilvvuriuLy9
         Y/DM4Hn+3HJ5M5T3c9rB18IQ+khwfoz+SH5EeuJCwqutOzmC3gdw9KGT3up7M0wByDLa
         4tIY4R3oT4X2xDwRbKrSSWmDo7+ERIzGv9fapKakx8biTxTIyIRUhuiEz+7dH1vJQKAt
         IVtg==
X-Forwarded-Encrypted: i=1; AJvYcCWS3t8EI2VS6Bv0OfK4+XZ2Tpiqy57Xz83e2SvSx1Fe22dUUJ9T6UlpQcVsBC5FznZqh7MY+rSmDtZSudk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSOEqrAkshQ95kvN7c+3up/mrPTLSYdXuRmkEU5tizmxzmeVR
	GqUJoC9En5tRN/k3OTEvrFrkAh44z5SmnK8k9MCqXVoigqRukS8yV4Fe0jwHHvdz6Km8KPuDdcQ
	lL8Ohj7YddDuD8oMf6Q5HPBHVBdAzvYml9iYJS+RBeL+dK0dCoMum/7teH5ZJ2vVMLL0=
X-Gm-Gg: ASbGncsvx2lDA1/rzzz8AFVKOAKkp3xpSar+n0CVkeWP3+ju2Xlvdi71cEpCOZLBl3A
	kMCvwkm9ApXOdXfMIWEQ/1c8POW4IVHK0EXH9hhtrq7ZYuUJsMs5hg1+fV7q+tPaDNbUhkp2xGp
	ERv5KTLIVdSxV9S41cIGQKOLUCEPUq8gqO0NpXSom57noeLYPBmH5l/yArBd0+aAvGaiMHkAXlc
	yQlABoNi9sslUVsStH+HDNLuDEYvMZDE3ebSxqqjqnsWmYJGIlFokfAr9YYlW9GSBF8skLKGSTP
	Zim+ZRy9/PE2lOfOMXqk4tEjztXLyKGmx2WC/APqw5ceFnSPUsiG89E6rcb6hE5u1kUWp233TbE
	7IMoq2P4K/i5/tIRBo4SinhRvZWU=
X-Received: by 2002:ad4:5c47:0:b0:798:f061:66bb with SMTP id 6a1803df08f44-879dc797715mr100210366d6.1.1759741001453;
        Mon, 06 Oct 2025 01:56:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0OQKFczpahw2O8L9QZwt7i0MonSjf+thtwOfz9wrUrSWSLA9gRN1ddmOoMuJB4neL7R5W4g==
X-Received: by 2002:ad4:5c47:0:b0:798:f061:66bb with SMTP id 6a1803df08f44-879dc797715mr100210196d6.1.1759741000877;
        Mon, 06 Oct 2025 01:56:40 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3ad614sm9601450a12.1.2025.10.06.01.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 01:56:40 -0700 (PDT)
Message-ID: <72561ba0-88a8-479d-8f9c-767bb00c964d@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 10:56:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/24] arm64: boot: dts: glymur-crd: Add Volume down/up
 keys support
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-16-24b601bbecc0@oss.qualcomm.com>
 <cd91e7f2-72bf-48f2-891e-4e6cd36b1e24@oss.qualcomm.com>
 <CADhhZXau4EPEvf6Ngo+p4Jv=NPF6TYxcWtt2tV+MyrmOxp7OOQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CADhhZXau4EPEvf6Ngo+p4Jv=NPF6TYxcWtt2tV+MyrmOxp7OOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX1O4EUfgcnyt6
 vYqf6gb7BjPs2u0R14rgu9ldz16zeHqZm9539AZmKtL6U+ohue+GJ/MjEB3ml563rl1UP7D04dU
 bDzpigh7tcIL2QXzSHvY2RC/b6GztRuMx6Nk+HBwRtmCXUblGJBn4/nEESBkFeQfILl5YmR1lDj
 2cJcev5pbbEr8cmjqU+OpMuznw3D9gmwOYQBlp+MARPxQX0N46/Ol20rE6PK8sHzPOJm/ifOpeF
 /3uxajHZJzYlw47GntKGBbG+vVUt91WUcdDob/f9LTpUCs0f3QcS4Gz8jrYgVq4DhiXbukeYXsa
 J24PhcDQKRqS3YeKUkhynaYHjrq5TQNMkwzX4M2SHVa2m37EKV/EtUukCwcvQotrGf4lHMOY1ZI
 AVKMmfMCuB+NK8nQqS3+WoGmM4RX4A==
X-Proofpoint-GUID: 86ZiSNlL6UIyFm1cGXYk4O2e0s-SoOFw
X-Proofpoint-ORIG-GUID: 86ZiSNlL6UIyFm1cGXYk4O2e0s-SoOFw
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e3844a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=ldoIggxhy9b6zNnRIFQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

On 10/1/25 3:48 PM, Kamal Wadhwa wrote:
> Hi Konrad,
> 
> On Thu, Sep 25, 2025 at 4:46 PM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 9/25/25 8:32 AM, Pankaj Patil wrote:
>>> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>>>
>>> Add Volume Down/Up keys for Glymur CRD.
>>
>> Does the CRD have these physical keys, or are they routed to the
>> debug board?
> 
> Yes, it seems to be routed only over the debug board.
> The keyboard too has the vol+ key, but seems no direct key having
> vol+/gpio6 on CRD.
> (sorry should this patch be dropped then for this reason i guess?)

I think it's fine, but it would be nice to mention this

Konrad

