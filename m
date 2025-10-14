Return-Path: <linux-kernel+bounces-852179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC32BD85E5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C2C3E019F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC662E7631;
	Tue, 14 Oct 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LScykKpt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6522E7186
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433247; cv=none; b=VgLU3W0+S90ZY8M0EPdQG0D2eRLnD1+RSbX6nyNCR494+gCaUXQvG7SXK17xJ/MESzQHwxTrSAAasskGRmKkzvMtLC5Qx+ntXgC5U4kkUzvkOG2YGi/7kNcVNoCz03mN2kZg0nGb8dpQIrxF3cz0mjMJ1gxpMa1YqhtV6UrtyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433247; c=relaxed/simple;
	bh=IEO5GJ8C1882uGhUZV4QiuHcocIcs0hflxYhOMUAtfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZbz4nx5lgrRWYUC8mTzgKKdbgS8+GUJEw/QFfFg9yVyhdMrFsQkX6jk5C3F/mofsyVPEqQ4tTfhvWZ9JP9J6i+ugADZuN2gudZrcW50JF8hJRBkRqxpzpe4BnhVOGUkyCjxKioA0QGJKM0gmRnQTYD/MU0Wkx/3j13IAvHMV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LScykKpt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87LA5016457
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FZxoGMWjRHyp3BpafyTGdmS0MvS+yG7JvkclL1HE0Ys=; b=LScykKpty6Knmini
	6yKFH1hoM9+2LcSzxAtOsKXSYCs3j8VgHUutPfE+mZ1nGboSc+jESN0v02cUi7h2
	HY/YjjLEfvY1gooUBEtf26/kK2mBcs7v9trJ4ibJMJqJVQTTYXXgcviN5SBqv8e3
	ioQyF3pek2zGFhlnEXla/VCr9V4sTB5x3v93Qz2doPjdnSLcd6jrqzycg/MmTq4b
	Sdn9XQ8tu3mG81w0H3b/KXZ9YiI2zYObGKY6lFCPldByQCBpi9lf5Af7QEe4aWKA
	6BWHv9I9yBRudd9DoOCZkBDhR4uiwz6hSC5EBRVnSmlTCkjKLGJkZms1L9TDguU5
	i5O8Kg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd8yxj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:14:04 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6097ca315bso14814990a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433244; x=1761038044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZxoGMWjRHyp3BpafyTGdmS0MvS+yG7JvkclL1HE0Ys=;
        b=skEjEmCmqYhPfoMzXsrnRmwchzw6iFD3ib8Xv8Ur/NFMbAz0KsjpoVRYS3ntRPDf+q
         r52JTay+PxpUWi/YUD8H0+9iXbYYH5PF8y0sxZ+1WxqBC/OSnu3Zl6jOPbAl+CA3dMxy
         rYQf3hlbqR/qKEOKyA6xSICg3nNRgEsQSKWnwLdCYBIMWzLEV5Sy0mzi5R+cE7ZBvBeQ
         JyK/zf7mTyYMQCyt9q/1DYnWJZHmY5f6t5Byz4j5R0oU39a/qIUFLbDDV9ETyp/cWp0h
         Cy61T9Q9RI+Em5fTi0czuy5Pvvj0nxNYg6+z2my1J3H/y3PjFr8gm0RT2IKPnGqluCJy
         JOlA==
X-Forwarded-Encrypted: i=1; AJvYcCVVCuzAeLO3/dI4mnfxO37ZQZ9VMCTJ5PyVcfG0StscfFXRcWIBmlr4tetdSt5lkQdOBJ2/W4FvnY9LnkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+NWvCH1UtkiM8jUlVFFAypOxkGdoLIpqn1ePfsLnxrtGWuj+3
	d6Ij+vUglxTQpWuJC3niIcdb0z20RjMyJjKuWzlKdAOvBi/VIzoCeBHYppBeyVVkFSmHMOi5Irv
	WENmEifZHq4JXVLZznn2nS58EoSrDO7slPoXAdmSOTMAFTvHqAI3E/kL1df8keUUAlxg=
X-Gm-Gg: ASbGncvtEMJ8cCcuUL391EGqZqoh68/eJqHECOYxupebCgeSZDH9S7Ppcno0474JB6v
	CIQVhmjAkq3dOLVfLUosrvjgZagZhyytKbV6GZ/PdtJD6jGF7+RIf542X0fr4F/orJkISt9ZzEF
	U6QJpUhoYboRC+t96S7p8RAMqJVsIKvF+OUGU5M7REoGIbTdupHWcjEFIksrLKEK2yvaj99HLDy
	mO1mwB7Kde62Z0zZfxTJdYdUG5HhNfWq+a9U25IRg5s3iDXAX13QZX+WY0bN4j929ZLbm0WokPe
	xsn393clGOzpApG6/Y+TCk91rrxYsqE+/6v5mLhVsk+ItBHcmG4ppxEAcZXASNQaQjeuvOzT
X-Received: by 2002:a17:90b:1b11:b0:32e:38b0:15f4 with SMTP id 98e67ed59e1d1-33b51149231mr36293133a91.7.1760433243885;
        Tue, 14 Oct 2025 02:14:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxl1mdYLPfjFXnyezI4s6jG6hmqyysfKVlYnjTAiWTUfifmOTrtuiwT49TasynB4ClpC7Zcw==
X-Received: by 2002:a17:90b:1b11:b0:32e:38b0:15f4 with SMTP id 98e67ed59e1d1-33b51149231mr36293102a91.7.1760433243386;
        Tue, 14 Oct 2025 02:14:03 -0700 (PDT)
Received: from [10.206.101.41] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b67c6040d23sm5097761a12.38.2025.10.14.02.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 02:14:02 -0700 (PDT)
Message-ID: <3802fe42-0c94-8c10-7b6c-6c3adf863ef9@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 14:43:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 7/8] media: iris: move common register definitions to the
 header
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue
 <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-7-def050ba5e1f@oss.qualcomm.com>
 <b7eba4b5-1189-7506-4767-0ef3234fc6f2@oss.qualcomm.com>
 <dzorzudzpjipvlkwik3uylomwi2dy5ticxromzegzgi2jhibot@reqv5ul5ifuc>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <dzorzudzpjipvlkwik3uylomwi2dy5ticxromzegzgi2jhibot@reqv5ul5ifuc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: asGcx9r_Csjlz2dmP0nImKq9U7EJqI-1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX2QBkUKn34mxq
 mMHJVyoGpKpwD/EBofGq/iNyam5JOK8SCb2uEbg50R9sWazJsarfOrchQotO5XqKmw+ftt4oyd8
 JfCFERlzrwDXHhkGrn/xXCOOxkF6MN9IEzuUa77HWsjXvRYC2vdtrrko2LeSdTFu4tnVNUtDunA
 psB9J2s43+fLvCw8tT9s3O3ji/KLHRza1iSkj4dTEgV6sZxIhQr5x78xQQe5IUl+wOSqYq8OAgW
 +EY7qHH4RtvTsrSMsswr5cty/jLgGx90Pf/IWCNV0dyBb0GxvLlxxvNi0SJ/Qz9G6f7wc/z7aLV
 YRU3DjrCjRyG3TXJU5dCecneCb4kMaopJjt1TBW1lRPAvEWRboKuKqINNxuAoXfa8KoKGsvjF9o
 zkkgb2CVxIQ/xtOtj43he0HpqC9Zaw==
X-Proofpoint-GUID: asGcx9r_Csjlz2dmP0nImKq9U7EJqI-1
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ee145c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5uaAGIl7Ed98QgTpS4IA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018


On 10/9/2025 8:18 PM, Dmitry Baryshkov wrote:
> On Thu, Oct 09, 2025 at 11:40:25AM +0530, Dikshita Agarwal wrote:
>>
>>
>> On 10/8/2025 10:03 AM, Dmitry Baryshkov wrote:
>>> Simplify adding new platforms by moving common registers definitions
>>> from VPU 3.x and "common" file to the header with other register
>>> defines.
>>>
>>
>> Similar to
>> https://lore.kernel.org/all/20250925-knp_video-v1-5-e323c0b3c0cd@oss.qualcomm.com/
>> ?
> 
> Yes, but moving more registers. I can rebase on top of that series if it
> lands first. Or I can just pick that patch into the series, to remove
> the dependency. What would be yours / Bryan's preference?
> 

My vote would be to rebase this one on top of earlier one.

Regards,
Vikash

