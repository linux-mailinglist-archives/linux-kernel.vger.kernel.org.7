Return-Path: <linux-kernel+bounces-813860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEFEB54B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 366A37BE871
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7336F301485;
	Fri, 12 Sep 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P23j4hUn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8A3043C4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677804; cv=none; b=Pcf0UDBaVkPj1DLHIF6nxN/Fc+KssZf3cJU9trKbAdTfl06m55XUa/dG+DlWlDm2zS/f3cZWKPA1I+jLLoO15l5APTpz3MtwS2U5d81VMGbNG3QvuPjVd3IAt8iDYcfxPpaDHH7TpGW0OLQEbNLGfUyF1h50baeJIZNxzrwlN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677804; c=relaxed/simple;
	bh=isdUtD0RZVWdZOsVxmU9OJKyNgeg8G6d6TYmpVtZEsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMrzthHhz7AYrwDG9goNWVm7xyQUG8N4hilD1uoeD/xwWipfd6hMmDrMiDxt3SfBEzDcPOe7rEC/Qg+l5zbptidGchJ5E3Tp6zxEWeQaNpMU0tsh0SUQ7a+ve9FPqImt4KPCHmg+MnWiDC3HLVbAigMDt+pK9VfY4eM3XtK3Xbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P23j4hUn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CBCAc4019810
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YzF2SVlfGn1ORuyJ7oHhWEvFtpmrZnuITZV7ypXxf3c=; b=P23j4hUnFVWwLMnE
	F6LQig/a0wxm5UQUp6+G2DMXP9+ABR6T/n+Vrkeyh7Gij5PeMMKBvcx6GqOfsAOq
	RYbkeeSi3QkVqV/wERaGFMo4O5LNwhCqJRp06Hka6FzLMCwTYGeNUczVcetKbIaq
	wsyqNdMz/SfG++cNyEF0jGuoKumN+3/tKNpvVrQVZTVCKDSO5XPqeWDesXYXMzxr
	KFK524t9rz3YoMeCM3MdmwdpgYwzdzFNckeEBUaYUDPvCC018hCc/OTh2udHLqH5
	OrxfprTgNkVlRxle6E87JTcncVrGwf9w3pYId9ESgnvabCpdkcB6cGjvqKUHqJxj
	zp8ZEQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494jdx039g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:50:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4fb9dfc94cso430252a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757677801; x=1758282601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YzF2SVlfGn1ORuyJ7oHhWEvFtpmrZnuITZV7ypXxf3c=;
        b=XREO8fq4ZPmlpa5WycBFUAhDC6yGgb6SL4KfbC2Kq4XHoRt4cs/IOr9Yxnydl6fdbD
         nXD5xQPM2rsryp6yhOP6Rl7s+Yj0CRGDUMLUvF6XTntYC4SQ/smZYSK8d83Ldl0pSe/k
         +ufGKbGRO7mOt0xp0uQ+c7bT/lVinRFMLlXXM8HTz9e4WgGi3zzrhTKafX316ZA2zHVd
         5N7FNkQ3HhFw0wj7sPw0b/6qeV1wLxjjQw3oLPjvpTQdOzekD0E03m4rmHuwrksL0IdO
         wkWUtqAnP93O6tEps5Jr6lImB7qCTzkWz7s/4f8laNgEnIpB5b93O2aFveFEB2WJhYW7
         4thw==
X-Forwarded-Encrypted: i=1; AJvYcCUWiK8FeGx03etnViY2WOgVoOnSM351tjtgimkIjiiDbBysbEG8K2D7RIoO3OKcNkC5WpHAuc2QT5hhivo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymkgkhUlw+taDCkafsT5DGlIuqCt3WAz6O9hIhI+OT1iKiVyMX
	ImUKMUGJ+18mSMBDHHRkBzH8Xl8pAqsCuXYQ5ZhNFbA/3XMbgzkFZoGtTT31bKMl21NbfUgKoMv
	YHutIhW9ofQ7zaMVVtsynlCuyQjtELTyTg3I7SJ3TYNfjY9eJPJDeFWS/kx0wJSgOEIc=
X-Gm-Gg: ASbGncuOLzvy8KYxIYlYd3/L/AD7YnZuXC4iQXL27kU7XuEgY0EU+ngeADml+Y5ZMs7
	9MyFUFkChVHfhkhQN9qvcAMyD9ihYa43+aHxvP7rqhVR4ha56mrS5C8cJvuBuA4ZyAvEc8fkI0g
	89mzvU5h7OOxvUd4DhaMz5jjXxeB8QK9x5TQV/Eh4/GAWFPGUP/8bHP6pkSTpuVx7W1i6yqciuY
	doXnPX6ssOiJufZn5E3OjfRNkaSt2cTzWEo7aFkRvCHVS1zZ/ld4uzlp3mVU1De+Cl0K6RWFLei
	Y26ofFyAf5WlP9YYY7o/S0DwEpfmSHoPa8+Cd2zUxlxvVQZKtq99KUAhLkXizTFFE+syh89ee2g
	hyeIacPHP+6YImTDLDV/UDEVgYeTpNw==
X-Received: by 2002:a17:902:c406:b0:24c:b36d:637 with SMTP id d9443c01a7336-25d246da083mr18921365ad.1.1757677800639;
        Fri, 12 Sep 2025 04:50:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWi4TjYFXB7GnUvOOedYDlXm03TtmgN9ypPJ2FZ+xs8IcitlyLZkYRTQqPLihrLpPvtOZrUQ==
X-Received: by 2002:a17:902:c406:b0:24c:b36d:637 with SMTP id d9443c01a7336-25d246da083mr18920925ad.1.1757677800095;
        Fri, 12 Sep 2025 04:50:00 -0700 (PDT)
Received: from [10.133.33.174] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37294b5asm47417025ad.50.2025.09.12.04.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 04:49:59 -0700 (PDT)
Message-ID: <5d25d05e-d545-4b2f-98f5-40bfbcd24d7a@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 19:49:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/13] phy: qcom: qmp-usbc: Move reset config into PHY
 cfg
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
 <20250911-add-displayport-support-for-qcs615-platform-v4-6-2702bdda14ed@oss.qualcomm.com>
 <ejwrkogssqdzxraacvxdbasxg2ud4t53rb6da2g4vdryyjuzoi@evdibveq7w46>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <ejwrkogssqdzxraacvxdbasxg2ud4t53rb6da2g4vdryyjuzoi@evdibveq7w46>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDEwNiBTYWx0ZWRfXwlmz9eywjvj/
 dtOfwTlgOUOOKAmUR3R+PBI8nLnyjqFuhq7hQRsEDxq0Ke9bcTW6uhAr6jwXkgvZFvGyNsplCPo
 wuz7FOyJTYQpMXnU7Ki87BoWvt+Sv8vSTRfscZyPW2mZbPnU+k4+SYOX4iCkpSydnFRju+QbosS
 PGo0pD5KfS3c+ZdJgC7QlY+46VCo3LRS6r/UDcfwyslQixtjTMLmz1J7hQLI2RzvCPnUbGuBGpD
 1fBgk9T5oFM4ScgZ5WqVvaH8DAhbcFFqtRHYOjwpfMYw2C9LOvmLaIUESj88GSivVFMAeTij0k7
 SgYfUeAps41qwUtgALRYjx6oxwCSKrx1qV97uhr0PVZEcaPEuKqgz4wKoQuL61J0JOpE3l+w7le
 FG1nIA9T
X-Proofpoint-GUID: rhnXrC-9VRwuVxbVdTe9a_92WL4t-Cli
X-Authority-Analysis: v=2.4 cv=JMM7s9Kb c=1 sm=1 tr=0 ts=68c408e9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=vDXniOzG41h6BQfMLKwA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: rhnXrC-9VRwuVxbVdTe9a_92WL4t-Cli
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509120106


On 9/12/2025 5:56 PM, Dmitry Baryshkov wrote:
> On Thu, Sep 11, 2025 at 10:55:03PM +0800, Xiangxu Yin wrote:
>> Move reset configuration to be managed via qmp_phy_cfg instead of
>> hardcoded lists. This enables per-PHY customization and simplifies
>> initialization logic for USB-only and USB/DP switchable PHYs.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 56 ++++++++++++++++++--------------
>>  1 file changed, 31 insertions(+), 25 deletions(-)
>>
>> @@ -1147,11 +1159,6 @@ static int qmp_usbc_parse_dt_legacy(struct qmp_usbc *qmp, struct device_node *np
>>  
>>  	qmp->num_clks = ret;
>>  
>> -	ret = qmp_usbc_reset_init(qmp, usb3phy_legacy_reset_l,
>> -				 ARRAY_SIZE(usb3phy_legacy_reset_l));
> You can not do this, it will break compatibility with the historical
> DTS. Legacy code should continue using the old list of resets.


Ok, then I'll update it, since qmp_usbc_parse_dt_legacy still uses the old
list, and qmp_usbc_parse_dt should use the one from cfg.


>> -	if (ret)
>> -		return ret;
>> -
>>  	return 0;
>>  }
>>  

