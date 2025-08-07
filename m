Return-Path: <linux-kernel+bounces-759095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C209B1D85D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A893F3AC8F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194E0256C91;
	Thu,  7 Aug 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SqHaH9ZJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B125393E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754571421; cv=none; b=swggUrS0aZ8sTKVtY/ORUocNmUZTiYNH3lj9FXmPVSDjW/Twg1E4Q35QpwBpD4KBIjrWE3mMN/gzr5BgFJl4lrc+/4Y2vOPFMENwtk4zl2v2kwou+yANaoOeG81xhQjalZ1MKQSxzrL2dPfEApZVOLYZ04tmm4h2bWSiAWzP6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754571421; c=relaxed/simple;
	bh=+ti21F36hzIyeMi3iqLYoXGECEKA4dF5hB1/sbWmpNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPpIR9RtLVZ5Fd7nQ9JpBzyHyIPM8QLCi/VV1QsdY5YLOP7S+xnUyrgIOQX4q2/tzelyQLFpxWvCiP03Dmg+7O/Yl653o2is0SCSlYivD92/6Ajoswvh0fwzoUAocpeKQeH18RXwtaci1kQFj422zRvZvDL7WHSEILhOXRAeTn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SqHaH9ZJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779Cwhi007608
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 12:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rs/suGrOJP0BPrfZE4kiooTTaEQ8m0Lae2xORIeWkZA=; b=SqHaH9ZJWkJpW10y
	c0fiTZ79fUI+/4eeFZoqwHJn/LbUDVZ7Zrxo7ichxr8jG53VUxSFIBvCOZa1LpSH
	tbsHIwBGAW4VuCOmLK9Qg9XJgvWhJvuVBUL6QcrMYPnmJpa3Vd0lagG5jhPfCg0B
	TEFGguketGQPmMSf5ayc6NdgD6BzXyh6IZRk2GYKs2GTf4LW1xxh9FD0fKwRAzO5
	0CKJL96INsNfSf4lL+4mxvI9Ld/n/pSUQ6OwFkOYrxtaOTOFP7OtGjfbvP0B+oy9
	PNNUvpdJxi8wV7TOuheKGnYZnASXKsfcPkVGNheu/v70w7jqVfJwttY7BbA/iIMv
	GGiuEQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c8u23a8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 12:56:59 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b08f6edcedso3274751cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 05:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754571418; x=1755176218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs/suGrOJP0BPrfZE4kiooTTaEQ8m0Lae2xORIeWkZA=;
        b=Na4pOSv8jYA0Qx1kpYU9pTE8Yx9qbph9Nmyz8Dunx5DFv8lVmTg+pEbXv/9rXppocI
         S4F8G2n+v1/k9i/TGC7vRBDAPhtlu+vpf43umLRPxapGgQ9bjqg+Xa1OA13KGb7DMQgu
         pNsVDgeX65/ytxy42r4rZtVLGr6TxvsKLUdJIXfuczw1oxzUsjKEzzlrzymXFKKVaP8r
         ErKS0Azn3zn6kCVg3ucqlXktvTaSUfwuIxU2X8mYWX5OHZKivm8MFrvN0V72GRf79rB+
         W5i7y5oGDNsbeQwwyMIBVs0Q/GzXojglQ/mNLk5nHqkVhM3YsaYmuveV9cOiAI/IrBUj
         TG1A==
X-Forwarded-Encrypted: i=1; AJvYcCWyITsOFEiqbbqJWn9ryL0Lw/ik74D5VY11EcN/qOc+zV++XDSdy3iOmdf9hjpD8zh8o73SA6ZdZM2p0ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyryQtN2eRWdqul/cVt0KH5MbTIXiDXH5pDMZVdgwaCI0KJ350E
	x5YN8GUvcIt5fTkHydsOf+0E7FaNl1nFqZmKYf6EtznXvtcYJ/3iqedirikGuCtA1Dw+Q91Nnas
	LBZFm3dlA8b6iOD1xKTPzqZwqZWQWZJT3MC7thxTj7oAlI0ykM7d/uyK0pyOfrsJbEf0/v91SFt
	8=
X-Gm-Gg: ASbGncsG6Nry+cPsZ+blI8GbeJRv9K0x4daZ0brKrGTNftXzSXFJ2CLqXNKlTgwfGiC
	9OcC3eqZG/td+RdFWAlnaEXBrv7trO5P5ug/T/goyxvdjngsduEXc/9hPZxLIqArToq34LI/85L
	4wYkx+it0w5+wRvvuw/dr0e+HyjgyrMrV7VIg4HUC2meLd4+F4OCjzX01cY4ONcbOwdCHymqmBy
	2C9vQB2BDYGcBj5jATJLcghUsnq/J6SXTh09cabBGN78EnkCTG/Paomlby6YO3qMtqLk9O1UX6P
	ARLZy+dYe4JQ8cArRss69YTZpQGfaKZAn7k113azLX9JsJ39aIEnYI1LykAn9ghlR0mPsUFFQqJ
	J/xSHpTD6AR0e9NlhQQ==
X-Received: by 2002:ac8:5749:0:b0:472:2122:5a37 with SMTP id d75a77b69052e-4b09135e41amr53229441cf.4.1754571417864;
        Thu, 07 Aug 2025 05:56:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZnomUsqZ2CreTcOGq6BMGfm1RnWr01IsDdTPln/U7H3ddYFyVhGlaxBP4aHtRcryBUJPKiQ==
X-Received: by 2002:ac8:5749:0:b0:472:2122:5a37 with SMTP id d75a77b69052e-4b09135e41amr53229281cf.4.1754571417408;
        Thu, 07 Aug 2025 05:56:57 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23bedcsm1300244566b.120.2025.08.07.05.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 05:56:56 -0700 (PDT)
Message-ID: <abcbdb9a-f067-4bd1-be17-fe11b24dfacc@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 14:56:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] usb: dwc3: qcom: Implement glue callbacks to
 facilitate runtime suspend
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250806095828.1582917-1-krishna.kurapati@oss.qualcomm.com>
 <20250806095828.1582917-3-krishna.kurapati@oss.qualcomm.com>
 <83c54b3e-8e31-4ca1-9ca6-31703211d507@oss.qualcomm.com>
 <233c62be-c0fa-499e-9f8f-e90cf0b23aa3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <233c62be-c0fa-499e-9f8f-e90cf0b23aa3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: p7nJzXxw94syppK-qYkQAkwMpDjEheBj
X-Authority-Analysis: v=2.4 cv=Q/TS452a c=1 sm=1 tr=0 ts=6894a29b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=ft_1D6qkK9_HpyV9u2kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: p7nJzXxw94syppK-qYkQAkwMpDjEheBj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5MCBTYWx0ZWRfX+jrldqEXbaRY
 aYo0LugYmxNOd/qd7wqguULiXl5McouqRJZonx2/BoRmJIQhgt9ePmkXK3umwLx7vL56X9zgKdM
 3wNHsSVDsZbQMcm+ofm4hy96JUd420iA0ieE/gPUPsQBD3JjG/uGo/vA42JknAbQHajlpaI0QBg
 rtPafzSxuriiUSaWlYbPlQWYHApBubHxS3bjfHNmcqdoTHbc4v2YRI0ksj8G0fIJpvp5y93/vDW
 QD3VFllkSHNRRpkTPRsrsS0DfFyK+jRqTEJw72tQ0xEpQpOkm8GuR1c46XA99Os93VpSWP7EMaE
 9I1vCn+jOzClBIlOrDLHmF8+bEgFPu6Ync3qnrlH0uk1tYAfiyN0QUkaq5pKTF5Kw4KlTE1Pqru
 ibFUHzQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060090

On 8/7/25 7:17 AM, Krishna Kurapati wrote:
> 
> 
> On 8/6/2025 4:02 PM, Konrad Dybcio wrote:
>> On 8/6/25 11:58 AM, Krishna Kurapati wrote:
> 

[...]

>>> +    if (qcom->mode == USB_DR_MODE_HOST) {
>>> +        qcom->current_role = USB_ROLE_HOST;
>>> +    } else if (qcom->mode == USB_DR_MODE_PERIPHERAL) {
>>> +        qcom->current_role = USB_ROLE_DEVICE;
>>> +        dwc3_qcom_vbus_override_enable(qcom, true);
>>> +    } else {
>>> +        if ((device_property_read_bool(dev, "usb-role-switch")) &&
>>> +            (usb_get_role_switch_default_mode(dev) == USB_DR_MODE_HOST))
>>
>> currently this will never be true on any qcom dt ("role-switch-default-mode" is
>> not present anywhere)
> 
> Agree. But I wrote for the sake of covering all cases and just in case anyone uses this property tomorrow.

This is fine, just wanted to make sure this is intended

Konrad

