Return-Path: <linux-kernel+bounces-727720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A940B01E94
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C171C80BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB4C2DE6E6;
	Fri, 11 Jul 2025 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VAy65oV7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E72836B5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242709; cv=none; b=ovOP+B4XEl7ro0yw1kmmrFOpV9gkaf99HexhTjYs2p2/W6aTkMC5Rg0dUNJIwWzzYHNywzY+EfkC5q6He168FNemBPlcERiKlFDo7o5NgNZ6EMNqxHIFX1MOaTlcXG+b1qVEKJdj7Nte9O3+t+Mxax1+mhbVofNWBwUURQS6GVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242709; c=relaxed/simple;
	bh=4dxKcU9QbXvfSTxSoaaJNGfgocccWdv5IS5lc1JXfVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9lz1tM+ZlN9p3bwtoB/eY6FTNx1UNkKeM+F6DOeZFAifJ2xLUhMq8oJv4hpU73YaJH2f5g7/sE6U8JijGFmx3ku3fce43akFTpQCj+wP3IFNJzuw3ArQRnLxWpi4d8VI54ioA4DvutrjoQWKvfAfIHLN6t7YuWFLUYB6Fo2cWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VAy65oV7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAxfAD003719
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U5Nc0v310TzKIAnAmF8x+4SO3r6UNoo8gbSPjOzoY9Q=; b=VAy65oV7XNcJLDJu
	knAnjIIQ3b3mb6oIf5yPnJSK8hCKFrr4hkRa1+Za1kdRWMp6hBZAOjBequWvhWmE
	KFreuKTkSC56juGiHK45QY2YhnPDBcejUYolqd6jWyNbMrNd1DIo3ILTYoUOpPdT
	4Z9Cs43Il3aVRQYqaV77y6xWNeq1/1YRjpuRpHJ0LAzUxxky+2wyUR+xcWfWXjV3
	KSNWc8dozyIHNrGkzcUo7/X0F2DSvphAhynzeYaG7upAPuPTGK8Vh4+yR7d0WXzU
	EU4ywXgXBLeJjJPZJm5ceXpkLZ+lJDIk2HkJaEqOGBF0uaMBc3jXtE52nAY38q8n
	BP6wZw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbp0vak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:05:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311e98ee3fcso3013255a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752242706; x=1752847506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U5Nc0v310TzKIAnAmF8x+4SO3r6UNoo8gbSPjOzoY9Q=;
        b=drshRn7tXoRYnJMybcbQ227N3L20OVkEiBZ5zFg15eizj4vuzyKsrPkX7W5hFdunsS
         XU1vBW35nz6rFysbbBgdt5o41K5iqMiRFpxAA0xeBHF++qhh1LuQSN6YbtDNhjdQR0//
         Xd/0iGZwMlro8ovo6whqbnatAiZb2H4X5hF3TvXEy06ImBkbfz55kudZq443fBAu1RT5
         CrRzXmDWOGbyEQe+p7K9agCWYT2Dpn76YPTyejuMvxmdR2MtRjm6f14cxN6jGxGUsBCF
         jDmbMfMfOCGGOS2HH6IaeeYAgfnfHBj+17kNhUesreU+dbJfJFX38eMQcEUmJfkPXdSC
         Obrg==
X-Forwarded-Encrypted: i=1; AJvYcCW3aVCyOIixBdXHSo2TyIHoRmSKHxuGmdiU+JpnTJ2ynUUlAXxrbe07DSR2X7ufKfxlB+Gscvx55LDyw/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8DRxHQXX3g8LZd/OOOufw0LnwYKolOFw7de0X4ptxrgvEn8YN
	V1JfHwM13HZzmm4FUwTTHR+Wj6wEe48T4Z8oqX57o/f+jKO/gjhxLD7yPaQR6CCp6jkuS6spECx
	w8p5U03vgyzk7iarOpES06Robg2qrHLzvB/iQxzDHU4SNOmUbkHLMHPLpmXwuhxOsayE=
X-Gm-Gg: ASbGncsjSIMRejvonH+yWcEzgm7CZop0Dks44CpfIzkluPFl3DILJWnXjyUYNOyO59P
	OFm9QHMIaTHnXMbrlNMmmU0G717Mlf6mu405qP+fKtfH13bwg02nZWaZ0eZI9H138EaAHXtGvwk
	kyHhPE9p6snhgjZLUNyYDOmH31FS0tyb4871LqiaYVMJPanZdnoHHWJRsqa7+d6hdXkG85KAKgO
	pJRs6O7VLV5bIvhzi/vIeP7D5DvuX72UVtTqRJPudNkvlhS8xN1ugcI6XWJInukUJ5MXlyc3bSB
	QmR8iF4JTVBtqcjEH2Ury3F3Bg7tdcTC0Zpbuo3zLmoWETEhKFstRJxxG9uP1GCaN+rxqcrsDXo
	bq4Fc
X-Received: by 2002:a17:90b:17cc:b0:311:b5ac:6f7d with SMTP id 98e67ed59e1d1-31c4d33afb9mr4837913a91.6.1752242705759;
        Fri, 11 Jul 2025 07:05:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK4OdSQYYYilSR6UhytLzDAwYXm1kM9qOhyxjelukYnu63ROBiibMyxnLbzEyNZ6f4jBGUyQ==
X-Received: by 2002:a17:90b:17cc:b0:311:b5ac:6f7d with SMTP id 98e67ed59e1d1-31c4d33afb9mr4837843a91.6.1752242705009;
        Fri, 11 Jul 2025 07:05:05 -0700 (PDT)
Received: from [192.168.1.7] ([122.164.82.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb6136bsm5603555a91.36.2025.07.11.07.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 07:05:04 -0700 (PDT)
Message-ID: <536ba2ff-35cf-4543-b780-0cfdfc753e61@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 19:35:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: socinfo: Add support to retrieve APPSBL build
 details
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711-appsbl_crm_version-v1-1-48b49b1dfdcf@oss.qualcomm.com>
 <3cd5864e-e6cf-404f-94b5-b85866086d76@oss.qualcomm.com>
 <e5bb0197-70e4-4b4e-922f-baaaa2e514c7@oss.qualcomm.com>
 <493987e4-2b1a-42b1-af5e-85cd9f2a5d7c@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <493987e4-2b1a-42b1-af5e-85cd9f2a5d7c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA5OSBTYWx0ZWRfX3bReO4dYNOhv
 H1q7dthRPyMc38iXu28m/OP8J1ipIEMV4HJoGlRHSGmN4RgnDu2WmTl0wrflQ4LHvRKh0BzTGtd
 btmovBA8e2SIGHlM5n6LvryvJscvq8iCVAMi7SmVNiarwsVUkXqraQY/cum9nA4xSNgdZ/Kf6Wz
 OvtVjx44CnYQGCRA6yJ0TwUg+XrUBxLEo4fRdhYZlVDRDI1w4HqPgwt0LGkOIHnt9o8VjLvOovP
 X2HVJ14DkOphi5BHzK6WafhX0tiAVjgyOkUXO9wEMHxvkbmZ3bgiQbqUKtP4W5lASHyj6en+irK
 i7XXxFbRdwwMwAjRdCAkWJiLiFHdspLI9myNnMDYkqpPLg7HoEA1zs8iVsXDmnVbwgm5jwS6l2a
 kFsMJtm9WAHH5mp6ysF5geGVT6K1bQC1Y44jwLIxSX9I3tX1aMW7NRkCH9Xzz3Tzkq9ylfyy
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=68711a13 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=DYBUwgo+T13nltTf24vfMA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=fqPq5aWTcRkxbabmidcA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: e1ms2vuf6uUZltyfUrIyVxQShvox4ERA
X-Proofpoint-GUID: e1ms2vuf6uUZltyfUrIyVxQShvox4ERA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=607 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110099


On 7/11/2025 7:00 PM, Konrad Dybcio wrote:
> On 7/11/25 3:24 PM, Kathiravan Thirumoorthy wrote:
>> On 7/11/2025 5:41 PM, Konrad Dybcio wrote:
>>> On 7/11/25 1:03 PM, Kathiravan Thirumoorthy wrote:
>>>> Add support to retrieve APPS (Application Processor Subsystem) Bootloader
>>>> image details from SMEM.
>>>>
>>>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>>>> ---
>>> Can we expand the driver with all the known IDs at once instead?
>> With respect to the IPQ SoCs only APPSBL image detail is missing, which this change address it
> Next week someone else will come around and say the same thing
> for e.g. automotive platforms
>
>> I can expand the list, but unfortunately don't have ways to validate them. I can check internally with folks to test it or even send an RTF. Till then, can this patch go independently?
> There is nothing to validate here really, the bootloader either
> populates the data or not
>
> For now, this one alone is good to go, but please look into the
> broader scope
Got it! I can send the patch with the remaining bits for the 
completeness in a week or two.
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad

Thanks!


