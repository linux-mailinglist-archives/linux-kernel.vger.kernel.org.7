Return-Path: <linux-kernel+bounces-761056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FD7B1F3CF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B52037B3657
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9779225F780;
	Sat,  9 Aug 2025 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ocsQvtQy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71B322A7E9
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754732544; cv=none; b=kyfcyZdGoTRTyeUWg+EYZWh3zpB+iluSjl6fpWo35NgDZJ76FPKJayQVjirKbGPSN/fUeN62S8EEWOWg/92szIAmZvN87D20HwbQk7VPljGvaXKqtcDCegyGP/TVaYUpLSWgdmRZ8uc1Ktd4KtDmZEdd2FKHaeFsz8mEdrNxWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754732544; c=relaxed/simple;
	bh=ifWR+5YTYXsRgjzxK77i+K01IrQXJ9sN/mQ5f08sldc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjuPttJ2PYIgXlif6EOBmbJTMmizg8GgjdfsH3PS5QSWosiaXkPSnu1GbeHK5+eCjrDIt1zt0cDK1Ae9zZk2Pih+n5nh4JrrySaJhMMfIMmywgsVqu3stru5/yrbKJ30zjaDDZ8QLPMu95mniWLlgiZcM1+CY69BsGfKsrOIv6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ocsQvtQy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5794BqDh029745
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 09:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0372A92yO+6UzrCsBHxULUhC
	eOFsZLUB9BV4b4k/xxs=; b=ocsQvtQyl+rIznivUSMnxJKWoVXw8tKVWP6aYCXo
	NoHoZ0Jw7brxIgxyFnV3yYdTcCN6r/UlIC/aMOEbRvK/8UerXk6qmA12Ct1TlBOv
	o8DCZL6Crc5ta5YkxutyQi73btgUpCaN6DjoONU69PTVTT+on3F2UQ3LC81fAbi+
	F/07w6P0a4NmCPipL2pp0TgOXi1wW5NbMLxINvBS0OFrhd+j5CWMee8VkZuWIWWb
	de+pYI4cAFy000ra0b0tHARUtRxrTEAVhlXPGaTzRiGSTIhgXzQDdBCJHyvHJZas
	HO/EU9BDjWja1gqrdSMkpIIoU97qVHocFssoAoSTHsCoRQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g0c8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 09:42:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b0680f6270so73239941cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 02:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754732540; x=1755337340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0372A92yO+6UzrCsBHxULUhCeOFsZLUB9BV4b4k/xxs=;
        b=W87BQ5wYs6i+zh4KzL3Cq2h7EDHBGo6gD9h5GVS7CUX7QCpF0KXxNRf/la3kbM7LRA
         DlDp3VYVl4430DwC+zUHG/Mla1luFK8A41PnEc+/9JDtCeBgwtclwQEx249BIkO+BmW4
         cSE6yuktGHdieUzLWejWU6eiiFdm7Y96Bd3dWH0E2yYuHzQzmVCcfP6IHQeJ9yocRqru
         laDerkmQBBDjx9IwsDc+NeipK7/ZJRtoOF93cKz5E5uQfuBhAXhLU+Si4eAZHVjz4OmQ
         CIRHLnnEUwcyboo+qWD6AgZo/gezmTguHnUsOJ58VSyXQMBbY5U/ucZpHfY+POCjr43U
         lE3g==
X-Forwarded-Encrypted: i=1; AJvYcCV+irLv3xC5UJ2BZOiz9PZzznVEs9TW61JtfJ7sjJV4p5Kd+EUwYngEw59jThpRBtTZuIXvr7pNAzslFgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx397ObBLvrJ7RY9rvoDYQ8K5wHRQJZg93hm8vb+19kFR8fiKWy
	cGJxy8X48JKxT+da3qgtanLjf/tejEtq8/ummR4+Ue45PeTIgDFia549gPELN911Yh+Ya6q/f8v
	JgMJdQNzIlyP/G5lMgj6IXHHZpMIVX5wKT9ehvMxsCFl09wLgkHs7w8/TCvhllJeZv6q2gi0ypd
	s=
X-Gm-Gg: ASbGnctp+enhz2w3xZp77jPgH3YT18L6VnC6BiLinvNgSMY27d5vbHYqZTbB0chNfTm
	+PyGEdDr5IDu6cqdUFZFfIOfSvrQ20JWpRKEteIrrvRinBHqnfV72KKAd2sPxb3z1cYRQY7cXxa
	09v/acg6zNB4RoNkV9GXMwEcPXz+Ni0R7M6HZlzUlU6s2z79Rv8C+NVmnAywADN1+UqDtpAxvS8
	sHF5G80JiXop42zGfJ9GN4mDMxPRu4hmEkYKTtV5yO+FcvnTN7AlkF+MGz9/BhT9KqMu2EkAWnI
	x/qgshBsiklO9zh5/ERof4z0uvqqTy3YYqqcMz47RSaPi+FIIHka23zI+oZBl1H8LIFXwBVUH6d
	q1+CX85OH0Csqb4IOvxQtTGVHFu7RfCaH/ysrxarsvqUChXCYAkna
X-Received: by 2002:a05:622a:5294:b0:4b0:b39c:af01 with SMTP id d75a77b69052e-4b0b39cb116mr61368451cf.4.1754732540291;
        Sat, 09 Aug 2025 02:42:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESERnHKkIRpuJX4iR1miZrmVl0om2FZb47EtMDQ9dwoDLbFFiSfbashWKXj5hwmlVMBtCJHg==
X-Received: by 2002:a05:622a:5294:b0:4b0:b39c:af01 with SMTP id d75a77b69052e-4b0b39cb116mr61368281cf.4.1754732539900;
        Sat, 09 Aug 2025 02:42:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cc8c2e556sm164796e87.105.2025.08.09.02.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 02:42:19 -0700 (PDT)
Date: Sat, 9 Aug 2025 12:42:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH DO NOT MERGE RFC v2 2/3] arm64: dts: qcom: sm8750-mtp:
 Enable Iris codec
Message-ID: <pb3yyyjpffjb5u4oorv2rfo634h6v52gytmevn36k5xeqxhjwn@xj7x3dmaxwv3>
References: <20250806-b4-sm8750-iris-dts-v2-0-2ce197525eed@linaro.org>
 <20250806-b4-sm8750-iris-dts-v2-2-2ce197525eed@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806-b4-sm8750-iris-dts-v2-2-2ce197525eed@linaro.org>
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689717fe cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=CFmXjhnyot7mmrd5IyEA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfXz5rN7sAv5Mt0
 6LyR3kgMTNxVO+IjoYU2BdkLKWeUvxxCEnmDwo7/Aw6BbRKrV8F9v02newza3MLAq2FTM0ODaJG
 1EzsZ5UtGFwj3YPDjzXBY53XlrSxALDRrQqgxKM/Kq6fp0vSx740Zeu6WEzp6v2bkQLErG8jpuF
 u6xhwmTFLD3dyLuYc+mbCaTef5QqFcJiH77LOvAT4wt4qqaePViOT6BvyjF35bCEp6B3SCY3iTI
 Bw3DXtmHsX6WGRB0wH+839hsbxolpS9VnmHl/JfOhsYJuDYG7mZrddNdNlH0YIqXlNtOTroKNEn
 L0XnvvIn27314ovZdQ8Vk/sUAZbZzyrPHq6DYlG/F9FMAJz8A1hHsY0TdyecAxWFslSQf/gL0V/
 9oxtB0KN
X-Proofpoint-GUID: que2pc0hAA03ClMVr5GSrV915DSRAgc5
X-Proofpoint-ORIG-GUID: que2pc0hAA03ClMVr5GSrV915DSRAgc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On Wed, Aug 06, 2025 at 02:38:31PM +0200, Krzysztof Kozlowski wrote:
> Enable on SM8750 MTP the Iris video codec for accelerated video
> encoding/decoding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Do not merge because firmware (hard-coded in the driver) is not released.

I don't think we have been delaying enablement of the hardware for these
reasons. The user might have other ways to get the firmware (or to
disable the device) in DT.

-- 
With best wishes
Dmitry

