Return-Path: <linux-kernel+bounces-825739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B266B8CB3A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AAAF7ACF85
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9812F546E;
	Sat, 20 Sep 2025 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A6PnUeVT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA978F4F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758381415; cv=none; b=CXNwYDpEtAkBVBprhcIWNxDzk2c7p3ZKWkn7EPshA37vjCMsEIIhs69BYSg2mUAcoMZY2Mfl9kdhhyQp7VQ/+YikM9y+NyUuYJT/iWbaiGwzTv0/cJRk3az3bTdh1j4rLvLa7Gdxc2V0C8tnyqZdISNU/wxTIetOxZLHIMDm33k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758381415; c=relaxed/simple;
	bh=Z+0u+9STtBAglCiAhHSu7ZcwAT+Rzjx2rUtygJZtGUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHabgQDMEMMW+8lYfEjdi3V/XrLiJPuPwc8brNS4ycOKXFs1Wnzv89SIc2xMY7SYiRR+2S9lQVXaQaQ32VzDKOha+ocYdh+BoJjYEvZXfBKqUoSnjw1VXdaRsOahx1N5fCSSScIJnybb81b8MtjkbJ0hxUwTkvIhzSKC8RSq070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A6PnUeVT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58KEUj7v029992
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+jyAldBzt3O+lpQDlvl0UcYG
	go7Gu4oMJKsbVtP0MDg=; b=A6PnUeVTj7ZnjzVlvTD5fHTS1hZDMEWC/O4i6+ng
	rf8ufIncul1Dg9Zi4jDcvu8j5Y/Fclmw9ooIssX8GxetaMbuA8ILhrOa7rukQG6Q
	Pw8BTysufhYO5a8JVvDphR0n261nPTHP4cH426FN24l1kWeBD42YZSjkcNOYG6YR
	uJi7hlsh8Moj7B2FawhFRvlS8oeOy5rsqDgLHjRQvkw2kTYUqnnbIZWEz2NA03RX
	X/iK2Ix85fxI04suFZrQG1blLK43SCxjctCIXZ4VRc0c0+8KbvnxNsrYCBt4KU22
	OSSX2zSOYe6wN+T0YPA8NVVQ+Y123cRUc5MhKa8hKwH08w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mg30vac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:16:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-842b2ad7c28so116990085a.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 08:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758381412; x=1758986212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jyAldBzt3O+lpQDlvl0UcYGgo7Gu4oMJKsbVtP0MDg=;
        b=rg53Y6Tntar2EW0+5B0jlaXo6M+utlEFX/nzIxPfofDH+RmYLtewc+XTkt6CaFWlj8
         G8N0PnjaMwXZ5EqqEPCzUtiPQGSC36PphJIVK/55mVQeo0MJQCdseKFNDsWp3xmDlgek
         a0YFmKJHCMCz/uMPhQg5+b0Di+YxWpdwFWSJAfRDuRth5embDj4VH6wMB8CFbTcdJhES
         1fyDnCWKHb0vU532MiiUZAjrACWl+4SkGHf/IAfPJhbv6J4jDU67ReybkYJdppnKe6ju
         wN1YYLzorhxeHRJupOPxkZn72CtQwFIgDddfCt87MZTzorp4VV+AhzyIyJyO1tvClUYH
         HFaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEfJDq2Sp8ht34zPSti2Y7r5fks1zgBhDqbKhWAgEZiSzgq/yRkrNfVTrOT96ccSU86j3lz7IOzZEfVVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEES3CVEhQNR3RzRzEJ5Gydd0CsmWfmnBJlihSXyZiaEiST3W7
	6MVtyh6XS5nEF40l+gjvXxp+0JRgRzjADcOW08wA09oRZJuzF4DEJK0pwwOzrPXh3PSF9UBMXxZ
	EGHvrA9NxO9uT97P06ey7RMEen9KWG+Hm0FEiYP4unKwxbDhNDo8y9lsLWxNnxJjPwqE=
X-Gm-Gg: ASbGncuSELM2YqaJxAJasBa1TmrzDdeVTGFcNC5GX8Yd68g307i898SHGC11DpqGdSF
	75lQ9WOdn6Jp1uiNsiloDDJ+LLPRV4Cc8HWnTG6mfo1o4lZAVa01EfJhByJ3s1bfp+EQvq22G56
	YnA2nRvh5eM5cOejZMWfdvc5tFQLaxYua0W/jYXoBf4jpuxCTJIodyFmR4FGSZZMWEHmbMzdymt
	xc2Iczpz56gBWYYdR6AQmEsLEvqt4D4x5BvocFSIVABpNPSA2hTPLttWFc14XIV8yd3I7dponkp
	/ZzQQHWiOfCy1bp/WVcITWXtx05XmDaWn599t1C25rMl0oeLXbeuOc7QSstZaJTRnVUsXkafKaz
	nSMLk7dEGOX9NW0dCkYGdKJUEAKNklah0ME5OAkHyRSdp4lqCi3Rz
X-Received: by 2002:a05:6214:aca:b0:740:f45c:5d49 with SMTP id 6a1803df08f44-79910ca7108mr77889836d6.1.1758381411514;
        Sat, 20 Sep 2025 08:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWdSx0mnQGk/Nq/NA5PY+5t7voihJHBZXCh93RSAaAbgvzjBcB3+3BAVhRHQ14TfWUTCc6KQ==
X-Received: by 2002:a05:6214:aca:b0:740:f45c:5d49 with SMTP id 6a1803df08f44-79910ca7108mr77889436d6.1.1758381410917;
        Sat, 20 Sep 2025 08:16:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a6508483sm1996183e87.49.2025.09.20.08.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 08:16:50 -0700 (PDT)
Date: Sat, 20 Sep 2025 18:16:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: kishon@kernel.org, vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ronak Raheja <ronak.raheja@oss.qualcomm.com>
Subject: Re: [PATCH] phy: qcom: m31-eusb2: Update init sequence to set
 PHY_ENABLE
Message-ID: <qpw26fqn322tprf7ci34sn66codluytg6rnkmppdr4jpjwp6ud@hbawghyesvdv>
References: <20250920032158.242725-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920032158.242725-1-wesley.cheng@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMiBTYWx0ZWRfX1M109RFddq3c
 EF+T6Ji3/r3fNdI98CtkGmV4hP8UPOZGvw0KVRAknoP2BfNycsYazRePFDwPU5javS32uciRRRu
 VJnB3lE3i2kAt+H/6KqOWWz6naLg4fdsAuTM0iuyoWzJZeXX5EATCCryVj0y7HWyYAx963hw/LV
 WaEoOWaLnMe1WmN44QzoKESEwhVF+7pzkhihUawEVlUWzAAKPnBczO8vJXg3KCtgC3G4QK1tcFI
 oIQFBIDAwd0+U0a801al4j10Qj0JuYxB+NSF1vD5rPpqjBnjqA9uK6+3z9hMuNc3BsLiWRTA/on
 Sga2T2kNWfEP9vleBuyZSrV0po9QnquKA8RSDucib159E052n+6mklfy2tIM83rjAZoQKc4Mtw7
 8I6wR+KG
X-Proofpoint-GUID: -DWtD2hvNu5dgty_HsAPx3pzR2oMsH53
X-Authority-Analysis: v=2.4 cv=UvtjN/wB c=1 sm=1 tr=0 ts=68cec565 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=UHvurfnqH0zupzNQNmAA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: -DWtD2hvNu5dgty_HsAPx3pzR2oMsH53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_06,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200032

On Fri, Sep 19, 2025 at 08:21:58PM -0700, Wesley Cheng wrote:
> From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
> 
> Certain platforms may not have the PHY_ENABLE bit set on power on reset.
> Update the current sequence to explicitly write to enable the PHY_ENABLE
> bit.  This ensures that regardless of the platform, the PHY is properly
> enabled.
> 
> Signed-off-by: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-m31-eusb2.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

