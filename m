Return-Path: <linux-kernel+bounces-810303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FFDB5187E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D623B24A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9636C320CBC;
	Wed, 10 Sep 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a3WoAPP2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC4289358
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512641; cv=none; b=YbSkcTxWlYENHazu5kmYihoLV/9BvnnodSapjUA9WzEf3kT6efVscrRmXRp2Au4E018CueOCMMcIKW80dzfQRdgKSHvszuHRtvfprC/vqvqvAmme7d87hB0mVOpqfDTagorR6NUImiixEDEOOism509BSm5XtYqEaMsZYMB5n7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512641; c=relaxed/simple;
	bh=/wfQDim4ahb6Q6nDJIfOnfdyp76lezfBLoVX/eGVN/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cF6EqNWWKMrVpXt9p8v1vKe+lNwTFOQG2ib+HH46CUzm2LjJRqUWnnwMVSbqPnvTu2Jo8hdURzo3cOMDhn8azmwApxYXLLv2PfXo0uCwMr8CgXXdSOijXtESxXhcVIgsIEdYKl8sMJrmGldSOQrNo7B9Kqp86FTnvsuzHZVKQiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a3WoAPP2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgMQL011447
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1fJ/7ym1FXsoeacKSkxLjPWBg3p9UzUEwVJxmblp4aA=; b=a3WoAPP2Zo4Nisbx
	ovOxDjIrrUpORZ3g8bUG13XOPuAV2Cn8KtkDRg5PknxvPkgJ8aYOsAS8+41Riwkd
	s1ogfvQgtzGaxpWo/0xMwGZq/cabDK+DOqzFCLqKAXxnMFfkzfRTcEORsr3Pmofw
	6PteGyHzEHwhA465q/9yL7dP1+0o0h2HiSrCWnjsgjTftKC3ilEvB1VVdhG2FV7s
	TrdT71vaiI4d15wSD63aCDhtTKWzKymQudYSmKHfB5TKrVlndQZ91+PHaLcUdHO+
	fl6j0Ud6371/vLoisb+y7ZgCLvAHDEcHlAtTeaRbw1kKOjN9QF7PYIAYEIT5eaqA
	5rUHdw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0v05s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:57:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b601ceb41cso16627421cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757512637; x=1758117437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fJ/7ym1FXsoeacKSkxLjPWBg3p9UzUEwVJxmblp4aA=;
        b=Qq37f2RmuK4zTgrs0wrDJpN/7hhq6eiF97mLN2jmCeV6YAO3NdFavERbTLNP24qsAV
         B4qLn7TIwi3TAREJKX9Esbta9hdYMS7uXN0HYVVZyE7/kOZtC/zz+nvcukwK5LcopzcW
         Xe5UT6g+UgbT67eT0GCpcmkHap1UWB28ANUCcIxHJp/Y/yuDCRih6NOSy1FHo+ZtMtaw
         J47dqVzZoAeu303BqyWMM52ANSH9eLbjszHLSOMP7t8TzSGqX4CR0gsrEPmprz8DUl4s
         spEH5NGGsgsWzubAybIBdPos8TnX9aSbRttj+Lhq/G+sw0EqrVto9sAvPFxYIU3j6vgU
         aWbA==
X-Forwarded-Encrypted: i=1; AJvYcCV4tNQtadNoGqXdrHSXLkehsZMxxxDPTO/v9oinJUjdIpwLgGZRyuaIhxGgRGU5SSVKvPZ/Ngq5g9U1y54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm//q1HDC6yPeic8d/lULjiLmQKk19YudXy4ZzjbPWjXmlXWp1
	62PR5/scC17hT0kMXEts3Wmc2iTpO0pMnnp+0QcGsdzWWrVNvhYDtoJv+0Z+agETB3RQgRd2mkm
	D00F6kSNZJ4uJWw47LJNR6o+et3Q0yknntepjdqVZ5SGh0evJa8Wz+6uMV/pscG/QT4U=
X-Gm-Gg: ASbGnctj2NkacgDEFUqcbxCCHDwOb0aAr7ZL8x+kghMd6EKUXXphHOdJ5R8TDiwR3xE
	qFmmIuuNd23H01P4BEbEosOV/MW7KN9cgyeI9p4j0XuyQK+99c7kBPp/9Blq0kyh1yW+NHBhHKK
	88PwsdPI6oM69QaBLpYmpmWs3vlQ1OXSAUcMJaOZmUUxy9h/0JZEaJA4OdWuf70HhngUbbkXmP2
	dJfvTchEEMNzfSs7L1Xc7FNxGn0FEsIyEROF56Tw346+tqNl8Ol1xTzQHwyKnv8Owg1E+uuQrMI
	Mq3l4uMGEtRU/9wquBkehJqJqij/NcmBp5mqhKMCMZsY0UJz3LRdrs7aaK9ZOi4NlGTqGyfKZNU
	IgYM1QzIVF4GEGxLX5OazzA==
X-Received: by 2002:ac8:5981:0:b0:4b3:4d20:2f9 with SMTP id d75a77b69052e-4b5f83a513fmr119935531cf.4.1757512637398;
        Wed, 10 Sep 2025 06:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtPKK5PUQ+h2E5IfRB6yeYQejWcIdFPwadPZHwUcThe6XnDwjitcbDpSw8Cmgn/hL3Cw7upw==
X-Received: by 2002:ac8:5981:0:b0:4b3:4d20:2f9 with SMTP id d75a77b69052e-4b5f83a513fmr119935291cf.4.1757512636836;
        Wed, 10 Sep 2025 06:57:16 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01bdb952sm3333151a12.52.2025.09.10.06.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 06:57:16 -0700 (PDT)
Message-ID: <10b8b0c3-5c1d-4631-9feb-c83d08d619a3@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 15:57:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-sc8280xp: drop obsolete PCIe GDSC comment
To: Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250910134737.19381-1-johan+linaro@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250910134737.19381-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: k7EYsS3sOIjfqVA9Djv3f1XFrGI8EHz6
X-Proofpoint-GUID: k7EYsS3sOIjfqVA9Djv3f1XFrGI8EHz6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX2Bv+we5MdHcV
 DRo4NUVyIk3SgD2zlsb6E0m/l2dqf3qHvWaJRLm5RBbn8VXomdfsABIu96RIYCXJpio2hXZzFPc
 JX8kKXrOcQYMZSYyc8/WHFGlQiuly2IHQ8p9demQzUBxpbFORKveIuL/yezrYgT1AQYIrEn9tuK
 N8nX+Uq7jfMNt3xIMpLyPR49iGhHdAaoWNBBLoZpQ08zBVLSXkdzDwvKNHuAa2pomTN/mEGqrWM
 mGenbz5mfSwCvRYL2IYm6zU6y4iv1gqhUHw7zxmCtqfx7bwGsASgNvnllBW9zPhfa/stVI5fXZo
 EuhwG0BgLqOzaSNDGGPoRiMNXa35onO8sY0QI7p4JZII01E863D4D7iUJP9oTSADYgm/bvPOLRd
 kptB9XAX
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c183be cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=nxTl8UUStihZDgUTFOEA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On 9/10/25 3:47 PM, Johan Hovold wrote:
> Drop an obsolete comment about keeping the PCIe GDSCs always-on,
> something which is no longer the case since commit db382dd55bcb ("clk:
> qcom: gcc-sc8280xp: Allow PCIe GDSCs to enter retention state").
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

They're not quite off yet, but they're not perma-on either, so I
suppose it makes sense:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

