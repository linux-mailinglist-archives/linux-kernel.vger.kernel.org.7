Return-Path: <linux-kernel+bounces-857537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F918BE70F8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786581A67F68
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82C526C3A2;
	Fri, 17 Oct 2025 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qj/wHkov"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86489247DE1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760688580; cv=none; b=OAJ8R8sx0K2psHSbJxqMb2ZVVyVBzWfFq4MUZD8/9ADRq4aVlg0WrLVF1upvVJ6/U1m4ILokiYefvbC/FO7QtqFVCauyaxaYb9X4JlyvGhHinaPdD2C/USe9w+hKiCXfZ+ysX2FqXVq+bJDEhjUY4cMRr6lbLqd8R/n8yS/fbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760688580; c=relaxed/simple;
	bh=LNWrns5YhKuMQe54rxHgfd2FWlF/9ht7hOYxgPyf8OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQ+O126gySMwzRF5gvbKB8AZeZWa4+vO59yIbRjfXSEZtYgj83HKAK9dzHF8tRj5nLoqGNhTjbF4gbwcQchm+PgkIv2xKVKtitZecelOo4iNgrdMXfWZB4Z9FklI/N8avigBNRtZQI6DOWNZF73785T34qF0ikiAl6tvULpPK9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qj/wHkov; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7kWjW020167
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GPz2SW5yw+njOwx1gSPLkLuFrcs6TqRr7O65/b4k2Kk=; b=Qj/wHkovQgn0aqLs
	ER3PzqkN7inUYLnBdXm+t46oBUht4q1t/a8ssfezM1LoHadHe8xDPN2ac2vCXLOq
	W6pTc0XYGbGsueYpaIgEG9hwyp1yoz0R9WkLhFwql3HfvmeKDfmkuBCiQRkbFzdw
	x77v8z47xo/+Ts10bzhB//qz8em3OcVNg9WLft1bbg/QZibNGW0P7QAUHaWeqed9
	gPt27I3cr8FIdxyGdCQ4rCEsE5eqgG3NymQYXDtmyJ0VF/YJD9nZU9gl/OY+urD/
	3BxnA92ZIS0OugTs8tTn9UT+j2sC9/uf/ZRu/MsHfe/uyub0mdQbEmhMZjvVkQvK
	bkQ65Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49tqvpmtxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:09:37 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c103b902dso6610326d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760688576; x=1761293376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPz2SW5yw+njOwx1gSPLkLuFrcs6TqRr7O65/b4k2Kk=;
        b=tgj2jW0ioF7bHMlo51kTNwN8R4oBUxMYmZIR8wAWY74Ryf+RlGFe3ioCjsInhojvrg
         H83VHXqA7kVPWb7NYhmt+8WqmAVqIzo/bzA8vMcT6zRmUc/kykXAFlwbkH166dM6SyRH
         mh1lVMX4b+OK6NncDTWDmsfdlILPnHJ6xBpJafRsTQjGxu78t2u+vIPQk/XpbF8Lc5kd
         4xYQQEe/n7/03HVm/tUY7hsA/bMPta6DaqKS+7aZYdaMkoGe7A4weWU6B3z/flMktcJg
         y88HnC1wVE08Hi94S5y1qGt+OpduTYrsKmnGG0nKiTqB+kudBHRhFikzMhLl/WASKYxN
         kd/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqayE8/dvPVRXVCWJFlul2zs3GkKrtTAaR0E16+x8Kbiemi7qrjOZ8adJOGeOcso6zczjKQXhnAnSZQ1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR6Hb6vywErgIX22wxWPhyY1dqwimgc7sX/ueCclv5nKBHx0QJ
	AE1+BQKSxU2VIPTYCrnQdkxOlnW+6C7VlkjHrvn8Y0lzANaJ2bBkzvnv6pr5a1QlquCfvANgtFy
	FP252iktvGLhtY5IVFzTQmDFTrU2QOfgry2JrS+fK17mmi4tyKI/Qspph8jk9B0PUBZ8=
X-Gm-Gg: ASbGncubGtzcy6ADLSy5KNKWcSp6QqRJYZrp6T8ez+GK4Fw+WMHi9AzZY9BVTVJ7FAo
	hb8/rf1lA+roZHt8rqKDL7Gc3XVGytkGz3sVEOZSiBgWp94l3eNoTNqWyd8jkKgZ53sA0NC3MWN
	u2UHZXXGwlDaRMW6QlAGly7fY/hM67z2DBIWOOXXBVb5BA3cMhp3hojPhUmgS+lmVOMe2KfsiK9
	Zdyrv0GnHJCnIMlEvHul2uejX2XxFMKBzBFb2+v39pgixp8d0VBrZywURj8F35kUE5npPmDxCkZ
	4/ZgYLmOqmjLSgFku4Fim6xf0b3yWjM6rzUFjBWFv79Dna2011DDlSNv9KA0j89R3RVLy8Wsnqo
	piyKyuF+rFaeZP/LCtxFqTgYGUeK8tC920byySc/UddwYnSNbA6XDPdEA
X-Received: by 2002:ad4:5c4b:0:b0:87c:cec:70c8 with SMTP id 6a1803df08f44-87c2068e2f2mr26023676d6.7.1760688576568;
        Fri, 17 Oct 2025 01:09:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRldwlmoIjqUWs+B70gDTcINWBj5aJRWNo73VY7mhDe+mTNIb2HTahu2VSMQY0UuncTX+YHQ==
X-Received: by 2002:ad4:5c4b:0:b0:87c:cec:70c8 with SMTP id 6a1803df08f44-87c2068e2f2mr26023486d6.7.1760688576165;
        Fri, 17 Oct 2025 01:09:36 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c0c6cc6bdsm3188044a12.8.2025.10.17.01.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 01:09:35 -0700 (PDT)
Message-ID: <cb973808-005e-4920-a35b-3f02a402a78b@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 10:09:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: hamoa-iot-evk: enable pwm rgb leds
To: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: kernel@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>
References: <20251017-add-rgb-led-for-hamoa-iot-evk-v1-1-6df8c109da57@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251017-add-rgb-led-for-hamoa-iot-evk-v1-1-6df8c109da57@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aPD9aL9m c=1 sm=1 tr=0 ts=68f1f9c1 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=faPRZvVwotbPnOTzeFAA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAxNyBTYWx0ZWRfX99uYG775laXS
 9vgGo6EPSlp9A9ZUVDsl1bz5+aUhwEZ/m9rRSZwgY0b050rOokqlsA0a5Sutq9PYHn/a5tVE55L
 dZt1+4k5uHcB0ZolkKQIRrXxnrzX8D9p7cN9CnLF6MtYnVpR5weDeD8/uY7It0fxNgzcFmn59Mz
 cpd+8PImti3jxM0aTc34S5dlPduC+vQ8BBzi9jGJi5VJx4TZwCDWobd9/7e4wyGytupnXMSMkS5
 XYyClPbX9iBkTjCm4d9/GRVARuuXkoxDT6Z0bBE35ZKb0w+tzLpkSnLSiW9epPxH9hKJkoRhcRQ
 SZ/IPsbHhO9yacZjU+2pFoMNhuARzOZDL0TYkiSlZxDG+UflQIZi1rhqEA4MTtqYH2VWQEhumEF
 wUGPmWCLhCl878y0oa3ALzs7aSw32A==
X-Proofpoint-ORIG-GUID: nzrW8HMZJw-wyLA1mRstqzDuVC14aDUH
X-Proofpoint-GUID: nzrW8HMZJw-wyLA1mRstqzDuVC14aDUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160017

On 10/17/25 10:06 AM, Tingguo Cheng wrote:
> Add red, green and blue LED channels for the RGB device connected to
> PMC8380C PWM-LED pins.
> 
> Signed-off-by: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
> ---

Just to make sure, is this a "multicolor LED" consisting of 3 ones,
and *not* three LEDs that are supposed to communicate different
functions (i.e. network, power, disk i/o)?

Konrad

