Return-Path: <linux-kernel+bounces-864317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5605DBFA822
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5370B4EF287
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE962F4A04;
	Wed, 22 Oct 2025 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXPjYZA4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199442F5A3F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117639; cv=none; b=n7gZjE7rub968B3OhzamJfN2hg5QvYAE/XNZuR6e145EMjXYJ6XLnUrUmO/AFPGTAVFXySQB20quB/NpsszhgKm+Hkyskf/3JHqezvR8ZO8HoMHxuD74gulkTDyBgUDngxWYLro/oFBHZRn7TqpUyM7XKKwpezzxpupiXX4DcS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117639; c=relaxed/simple;
	bh=Qx5ZLt0bA1gGhskqBF/wlqngo5r7KHvDRvvusdOm6+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aU/eaYaL9lDqXKzbjLa09GsMUX+O0zNo1sSym9V+CtjN2EUflnZp5L9lY7pqIRaR0SO+Jh/Ue7Gc7cXXEncbCkJj6sY7MQUYwlGPGOt8LY/GYLnvIZixq2PlddK0GOO8CNfv0ldEG9oWjLSgYivI1WHVxvm6fHTboHd4Bb+0FZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WXPjYZA4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LKgBYP013592
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k/P5qUVg0GWzdhRDecSxvZEOZjOjt3BobF0UUDc36ok=; b=WXPjYZA4Z28Ktasa
	LK09WZTV3aFaBq5LIRLzfNfKw82/YAbXnWBkJkw/zXclpxeLlmSYUxCEHOSFwSn3
	qi8na0idnipYIciPYz6JqfyXavpFQXrsngsZ8JFZx2zxM7OVHAKuyuYTuicl47+R
	n0tB+db7A3EgtqPbWS3HH8SJNz1bJTLeore2HBOp3jsnKJWTdsAQBEAHtWr8JKgx
	VyYEytcC+BXZKNdZxOBTsVqzAGXbkxOw6nDWFy/n9/DiqOLQKohLDhyMslz+hRmf
	eMiSZ5HV7dVDJojn3aCfyZvs+Bp+ieQ6q0lKtyQlH4MOZ1l5NLef6q5vrpuRp5WK
	+NBktQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0hgns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:20:36 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78105c10afdso6128518b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761117636; x=1761722436;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/P5qUVg0GWzdhRDecSxvZEOZjOjt3BobF0UUDc36ok=;
        b=a0F6/M8cr87ZFJBcUzazp5/URFKzOv82t6mbQhDPfidbk/gr7gKcyha4wJnAFoQaNp
         XC615pq5LCEaZq0UbRf3XYZc/hOA6/u4kTy8WNrTtC7E9zs1D3fe/Htf/8j9DNcIedyV
         nCS1ZMnyXvXLdbnXPytSEI7Zk3PGsQPE1OX+CGPv5kg2qjUe2Z2HVEIuAJIimakdGBLT
         cnicXHCK7uYZHFOXXkNuG4q0xyCMLLKOFR8qt8GgKaau45srl74815GzULywzr77KD4E
         hUgxeeHXI/cWw96N5ZEILTk5vWqmw2dUanQxOPzB+OurcLuS7QOxwgxDNGIFHgsLCt04
         lzKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxdCVbWTKYqpgm3OWzPpxWm0m0/5nnAYne0iAhteA6Q3ExLsPO/TS0Nn/MfTaYuAwRvEjNRYTYmx/UX1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkYRFiDl6D+ADz4fmDg0DCErddLvtDVbUj7dw+LXKtSzsf3fK
	3GZPIN0t7b6G3dIxJAZOcVnOa/9PVedLU3GvLdr03DMBQ/zYVNNJ0Iy2tvivc0K8GiqFplk7xI6
	l+AMEy32kSPKT86T1g1tCaEJBj31VMQnsFsN5+EMgknXsliNzyWjI3Ev+gvvmccRbiYc=
X-Gm-Gg: ASbGnctkRUmQFDuKo2kbfQAaxVpA/ajetsPVCg65EieMYLeUSBxwVWo/9sbzgTvVb68
	T4Zw5P+mEdtkfEsNjbP8tc5p7RcReqGNDm25199+YACEJS9Pt8xGt1qCPpVCyeBvSrCTM5R/bta
	xQsZAcBJXZ9AJVshW+1JYgKQ0/9Mr6VfiDybGSKKhLYLl6MOwfveHvKzGDWQSr45rfymua218fr
	4WTR1cC4pqCQIbJRB5C2wX5oIz3K4voJoGBgQpn3u0OSWiSWOEbA6pRAjXdz9L56nCxrB2S9wXz
	zvoaFptVDdEB65GijwsUmxfMuNdeyrJnyRq2maTwKTMBKGPgTXDunKubGa9NcMc4pR07ekhOtJx
	YJUtHfnH1H4uYt7KUXsuKPdgoddzBOgFhcQ==
X-Received: by 2002:a05:6a20:1611:b0:334:a3fc:797e with SMTP id adf61e73a8af0-334a85341b0mr27012253637.24.1761117635710;
        Wed, 22 Oct 2025 00:20:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQecOhK3VUMqmQQsVoBliqObRe9daZgl/gk+BlnDljUjD9z1dJCRLyXJIODKqTr58ixAIBLg==
X-Received: by 2002:a05:6a20:1611:b0:334:a3fc:797e with SMTP id adf61e73a8af0-334a85341b0mr27012222637.24.1761117635277;
        Wed, 22 Oct 2025 00:20:35 -0700 (PDT)
Received: from [192.168.0.166] ([49.205.252.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff157f4sm13707077b3a.6.2025.10.22.00.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 00:20:34 -0700 (PDT)
Message-ID: <95c93e25-a60d-99b5-c31b-9be321eb5073@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 12:50:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] media: iris: sort out common register definitions
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>
References: <0251017-knp_video-v2-5-f568ce1a4be3@oss.qualcomm.com>
 <20251019080212.142623-3-dmitry.baryshkov@oss.qualcomm.com>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251019080212.142623-3-dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX+TtwxUyKDAsi
 MwUa+639WlraolTNphAk3K2WLmWmxyvJx4tLAnubzWWjJRNAQVueKzBtzpfTd0whw3JDQ230+3N
 b4VcMhqv23S10DhGbh6ou254l+bDMfnxJ6ofo2VWzGYnhVOksq+R9FnEeAANAuwZoWLuhRKqShC
 qz7VvCFP3M/cHG0bfn7vvw5sknSuGsLvjxQpr7aJbv+WK1sInfmQSX/LjULDd9K2LU20PAc/lsi
 x87BdCtwbfWqsSOaBe50BYPuk/k+BW8/U19fLZRkX4Y17S+quwEG/gjbxthzwA872LQDnFHmyCI
 A55hnPoGQ4PeATsGJRwUPVo2Z5q/Z9Kie06dcosE3GqpRxh0lUoLR+dbRlJ549KG8yK2byRwbRe
 hF9rYVvqB3XY85Vwv+AwOOkGUWq0IA==
X-Proofpoint-ORIG-GUID: eoRs0s7lprV1Tz2yAwk1ng6aQQ-PyOvW
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f885c5 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=FoPg1IWog9mqHsjG+aRTFA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=M1YMS4I-2UCZmqrdDCEA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: eoRs0s7lprV1Tz2yAwk1ng6aQQ-PyOvW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167


On 10/19/2025 1:29 PM, Dmitry Baryshkov wrote:
> In order to make it easier to modify the file, sort the definitions
> by the register base and then by the offset. Also move bits definitions
> next to the registers which they describe (as it was done before).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> 
> Vikash, I have dropped these patches from SC7280 patchseries as they are
> no longer required. If the series gets resent, please feel free to pick
> these two patches in or to squash them into the corresponding patch.

Ok, will squash it in next revision of my series and add your co-developer
contribution tag to those patches.

Regards,
Vikash

