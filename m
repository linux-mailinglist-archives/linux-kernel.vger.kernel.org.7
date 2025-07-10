Return-Path: <linux-kernel+bounces-725628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FB3B001AE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031D75A74E2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5A924DD0E;
	Thu, 10 Jul 2025 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eFUKIqib"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8352571B6
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150425; cv=none; b=BfTA8qvV8+cUf23r9cwhKMW+KQrPmqu81mx8UWOULHC6lwcmwZAh8PY4f7h0zPoHlCRAUZZAU4VlriopkTLDUT9OZyIlSysmC4BzNdoxQiq1EmDOOWGkGBSVVnpAbKiCNriufwnQUr78TtWGwd1xaNxco8G3ZqIDPq/qZUVA6jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150425; c=relaxed/simple;
	bh=FGr+3z81ddvrH7/BffsfT9dYxkrFwM2vo7onaWUo//A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjwMCPNaNVDoB0GJbM7rZmaXNwJfjr5zQpNq8CTmajt9SecfvcWDl/m+kew3e1qRjqa+5GaHgDc3A3OccQ7t7mFZ2N3BifmKMfnDbpGQw3U0r/G3IKCSYMRvtlLkrbgykuoY1xTmj3ye+Zu05oC1tob8A58l17Pw+PEOhT84IQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eFUKIqib; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9MPXA002622
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/gsxZzuhHs1VQ8fIJ0Ja60LkQTuMCXNEcv0jiU2RnU4=; b=eFUKIqibmHQa/Oc3
	mOZ2IxHO79ev8iFx0rwsLYPmj+8LOzK0repIcZlCB8QJgMk8vRmxkSSArFLaTJ06
	gFk55narTCvPdmatYCLJ+/j3cL4LMUQymNWrmUaWcqAZaAekUMu7GjT7MTM6ZghI
	O4eds/ndX6NGGFjFml5pD/q9v1MEjuDurRdcvVJpZuB97tWWsIhbkKQjwxN5ziai
	bor7NTv/pwNpcug5Kmg3Spn/IU7ao8sZfAujPC2QRgrpeNB9h4MCB10FjNhWXNEh
	JVac2Mkru0gpcPtzqa59/UCnxYd0LGWTwvX/30xqeNTEnJeqj1MXRMRr3g2RVW7h
	/yrB5A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2bg6ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:27:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d0976a24ceso25647485a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752150422; x=1752755222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gsxZzuhHs1VQ8fIJ0Ja60LkQTuMCXNEcv0jiU2RnU4=;
        b=LOOmnnxBMB1szKnPgQubTfAhVFBBxNJq0wrOukTkIS6RJZ1sAMnxGsrJjWDP2x71Y7
         kD8s9HK+BUJcwm10lm604zobQ7aVDRUrPRqflVn8nUKM5rK7yl/GuwXa4WKNOgebojh5
         NrMDdRIRKoEUfFjGSfl9OS59VZlfJF7nDlNS8fGCZ2gQIO5jYzu9BmbZnVsw3YIdcEtF
         1cXPZO2vsFMEgEMD/KuN1894I05YCDzHAaD6vjJnkNpuD4hnhDXyRsUu38ajwbhOqYG0
         B6mDkqI/3qYZQy9gDMduImmc6gk9qokBCyD/RR8RgD3DIN6yqRlqESRQpqVBaTI6Pf0G
         1Exg==
X-Forwarded-Encrypted: i=1; AJvYcCWaOeZYruzv35y7BlHdVaJVc+du1BQNUTRta+hccmzInlL0r8AChFi/Yzqf/S6c894Kkphel+ExQj95l/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi29tsL98BwEihF24S1SxE/hwDv+KWenaTlcJ9ZgPdUC8XvGa8
	Ka3eaqMblwCUX0VipGba8hOi20+ZqZ0w0nej1uHZhrJv7Tp3/k+bxomEnnDI1v7PkPA4QK0pd7e
	4ftZJp14YgMKy/S15C7ygDLQw5lZZV0BsIc5jy0gPATS8CsSWvHP7cL6EDQFwQSBfi+0=
X-Gm-Gg: ASbGncuDsofaZSV4PA4Hj2II+GctDmsOpqd230Ez20xjgu74NagGFkEjM7+sfzqEo76
	KTBsRy8LeLv9SNFdaIHL11cbr7b2NXelmuwZE2o1eijaADNKbx9EyFom7d+URixAk92cRHUNGSk
	TBrU5FyY6vAq/bDflmQt8XwwitDi7EJWFaw4RvLlsGMmxyw/enaBNNgg88exHvGWrO73TAEOd93
	4dG2aKUZ/HAw7MBV9c8+hkyhBz2evvV4eSMK2ncRyYuaPJf4b7FXS0YFtuwuWa6kXp9Xf41hrbx
	8heUUk+FyC0eQ4LS+OsT6PwEKBJTL5muv8FHqLRoO0eTMWo3uF5Rj3IZxi91J4EYHcd94tzeieV
	2mrk=
X-Received: by 2002:ac8:7f54:0:b0:472:1d00:1fc3 with SMTP id d75a77b69052e-4a9dec6ff93mr34751311cf.8.1752150422085;
        Thu, 10 Jul 2025 05:27:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9Y+86PvXbITAApB2WEa/o9aQTNYOeca3v+/D1E7vOqMYvryP/+xVmZMto4EEa3ckQLg37Yg==
X-Received: by 2002:ac8:7f54:0:b0:472:1d00:1fc3 with SMTP id d75a77b69052e-4a9dec6ff93mr34751011cf.8.1752150421567;
        Thu, 10 Jul 2025 05:27:01 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91b08sm124778866b.8.2025.07.10.05.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 05:27:01 -0700 (PDT)
Message-ID: <cc6e8ae1-d63a-4f90-8752-07251b3bff04@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:26:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/3] scsi: ufs: core: Add ufshcd_dme_rmw to modify DME
 attributes
To: Nitin Rawat <quic_nitirawa@quicinc.com>, mani@kernel.org,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        bvanassche@acm.org, avri.altman@wdc.com, ebiggers@google.com,
        neil.armstrong@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250709205635.3395-1-quic_nitirawa@quicinc.com>
 <20250709205635.3395-3-quic_nitirawa@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250709205635.3395-3-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwNiBTYWx0ZWRfX3GqFcME0KVWD
 RFRD4zWA+Hyhkps6u3IQNukt6ukyXtYfQ1ya0RmaJjpGmDpag3AVe2U0e+eZjWWJI1HOVBisntl
 O7FB9wAPU3f7iWIwBgn+aPM0vsU0/dqzTzHLsg6pfT5frnasFtOHStU468XrYLhOTqCy8qvigZ7
 TppxLc9dj3l23iE0XdTYIj70U0FYNH1hTyE0elJJR3PHVckPAdfZCm/3swaUB2ZNBOXEWBoErOl
 74+hJpJM7xiLF88y/iZBNsDWdcSx1nfb8Y9XeSVwF45Vs0wQQqaWUhbTiunySCXgZtkw9VoGtzm
 hD6M6FqlFNXm0tgKRdiMRoes4ve9vK/LXPkD1+GXw19xQVJ6WpwIQCeb/36U8f1iV6azGLbwUmM
 st5JqO04yWhKzsq53MM8+puFAojf2QLtfTtces0/5hgb1xn91U2B2AQwGaFyas7WY/Vdx3dB
X-Proofpoint-ORIG-GUID: auoBXNtiqd9N59k-dJ9qHZO56uz9RTxI
X-Proofpoint-GUID: auoBXNtiqd9N59k-dJ9qHZO56uz9RTxI
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=686fb196 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=QyXUC8HyAAAA:8 a=B7Yj2uzDBv06dT-is-cA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=834 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100106

On 7/9/25 10:56 PM, Nitin Rawat wrote:
> Introduce `ufshcd_dme_rmw` API to read, modify, and write DME
> attributes in UFS host controllers using a mask and value.
> 
> Reported-by: kernel test robot <lkp@intel.com>

This tag makes sense if your patch is merged into the tree
but happens to contain a build warning/error. Using it here
makes it look like the kernel test robot suggested
introducing this wrapper

Konrad

