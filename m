Return-Path: <linux-kernel+bounces-826855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1CFB8F7F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BC13A5A49
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031792FDC4F;
	Mon, 22 Sep 2025 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gBPOekuy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FF3246760
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529614; cv=none; b=WI4CMR06+ltdBxoG/foIslCm9PBT2cWfDx/DA3pESZobvVQDOLKNm3QkvnNjslv3wqYUHOraFlA+8IhGc3FYTmmCwRnC6vWqx6/lN7d2sa8FN0X6TV2lBFxlK6opJrWgZQQVyPbJ+7vW8EOrJ/ynxOVyM+4LiXyOoWjT/ChAcog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529614; c=relaxed/simple;
	bh=eJTcISvqO+tecWyVFFheT/EbDB5c/sfz/eNRt4V9iq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRs9xVaMYl/dPRX+Wo8NCb799o/t5zYJpRt+OBhNwLoqRjNeHtSh33Mn8pBifILj4fkc3iNp034iSPjDZjjTKhANVFb7Ladu1ieYGdM+pEoOdkaSZzjuJYGRYMMMFF6lMAsld2cTjK0JwM9qb2P6Dlvd45eUtUJnKBDzyLlFAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gBPOekuy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7GPrA029201
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5eooA/d0wFv524HBbqhcxXG4N6t67PHtqPoAMp99CLM=; b=gBPOekuy/TAuLDuw
	fYHLEtqZoWeB+TuYqIynVldqPB4Chu8KEJrz1Y/nSNhuA6KVMrMWQ2WMMALQHrWG
	tod986QwqjjTGkCzy0fa+kxiXGBnjh8DweQfKaRl66G52sKinHv7tfu7RC2y5Rqz
	gp6hEqCM7QaZyXb+OaihpmJz8RupD7umBfduqMvKLonFBpPYC6XyaGR0eyctEYub
	0qiIPjB7Qz/4lElNdcKVUsRRTbJ4YZHTvQKU+nhID+XzLCuz0eGaS9049JtfUR7s
	4xFFQALX11PAjG9og+4qFjMu9eeDSQeDgJcyXmVmopS+uQHJvYZ1MkSwtYczbRyu
	sXMxHA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyem75u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:26:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2696ab1bc16so11869695ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529611; x=1759134411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5eooA/d0wFv524HBbqhcxXG4N6t67PHtqPoAMp99CLM=;
        b=qnj8qdQyGp+AcPw4jQzNmW/Q7elgd9Ihg7XCriFaktI5MXjurvQIHGFXcUw/pjXX89
         TDPvZOemHZten3Z6iBVk2jR9ygANMRCQPENWgRTceiCOsWmC92eMWyXt9aVqthsW35WL
         d77GOhOhAa6Q1pC4wBSgOyA5FCKwJyMsVjaEiwCQnD0uX5j6QCLv5Ylmx/EvcAO0t+Be
         LYQCTuKGVnRLp5QWcGbB0ux8VEpuHPyMfFCHCP4fpdnqpoMjL64Ktgb+iitxYnWlL2Hn
         zVNG2jxDNWWzwKPniHSShxQrFs/lxULMYuE/uR83ESuqOSqQOSNVfzmY0l4tTdTSW/H9
         bbdw==
X-Forwarded-Encrypted: i=1; AJvYcCW08GdXy5XKpj6WUIbNcYIOQertiI3hJ32d+MW94/ptxqWEQcavfxyplAhPPSxoaQF95VjC8ZhBDnK+xgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM2fIyQBgdTYJvtctZHSkSpxyAVHFNQkqeHGe9SwQYjTdgAdjl
	Z25XPqhk5MVPbKqtPno6kbS5m1CHcpFaTXJjSnWX2McgRdu3ByCiZdY3dKo5AEUiqgsZN+kEpqU
	M4Z8olS3yXgB2of8be0++RsI49PpnpbSWAREOEe0W29Y7n3z8e0p6idYR0A3xKdiT/lk=
X-Gm-Gg: ASbGncvwe1BVvpRLFLjKS0err0ZMrv+mhhZ5044caBrzqHtNFcLf2uabxGkJp6pPg/u
	tGQ71E3c3GU9hL9FDovCWFDFJMvAGVFu2m36rvAXymYtP/yUgIBhj6ejxgrNCfD9r/g+q3aqCvB
	h7bhIGXv1CcQDJh/4KX0qiCnvMkwCT0zz7m8y3GqHJbeT0yqOV4THgRKIu2ASt/0xaQNDbXjoIt
	x0mbeb/L66m2eD0hC1yl5gyJ0QUL5ChE8xmHb9tFHc1fw7yJcHgAeClLeO4ba6+qzbAEgfJ6jT/
	voPQmtKgTEQ0vpiqKIaRmPNCcQy5oOcF5/iwdqhX2a66Tr4i4HsaFzRFjKH/iSoEkQcu9UeabeK
	ytHOhe34vTslaJcYVQ+Tj+m18hZtTcX2zew==
X-Received: by 2002:a17:902:f706:b0:276:624c:6cb with SMTP id d9443c01a7336-276624c084cmr28410425ad.2.1758529611169;
        Mon, 22 Sep 2025 01:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMC8JhklyE4iNEbU5+yB9CJsS1vFjF44g3zzVBlwELKRKjUfowiE8AinFLeQimo+OvsblUHg==
X-Received: by 2002:a17:902:f706:b0:276:624c:6cb with SMTP id d9443c01a7336-276624c084cmr28410225ad.2.1758529610654;
        Mon, 22 Sep 2025 01:26:50 -0700 (PDT)
Received: from [10.133.33.87] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053078sm125956445ad.10.2025.09.22.01.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 01:26:50 -0700 (PDT)
Message-ID: <d09b2b45-3ca9-4808-8ff1-72b98d6fed2e@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 16:26:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/14] phy: qcom: qmp-usbc: Add USB/DP switchable PHY
 clk register
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
 <20250919-add-displayport-support-for-qcs615-platform-v5-6-eae6681f4002@oss.qualcomm.com>
 <xtosrpz6rzdvtmpyq73gboeckl3c2x23iqehlxzbaszqmzugjd@ixhj25qujqxo>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <xtosrpz6rzdvtmpyq73gboeckl3c2x23iqehlxzbaszqmzugjd@ixhj25qujqxo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CHI-OZgpzn5OIXLy5wRGifOfSN-_Yi-Y
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d1084c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=0ewKxBccC1tKemf2ImcA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX+9sFtovwSeto
 8MNrOP8dfjocBMaDpMd/hBP8Jiy0rB7J5mEb+iNKro2vnb9BxfoC/RkB5IJZ8qAe4vvhmOcX1ED
 mx+esIsYP4RWWCqZUmjv9Eu6rG3RXRDlHv8Raw5gXx2Wy8VP7x9G5dxASywXIigjxiQykgkeHFc
 ZHo/1iUiG1WGgvj9h107N90/HnJvF/MPwqK/MlJ2ZugI1J6YdxroiiITSPA0QNLDVU0UXddAItf
 WKxhUcfmr8WD3TSewZXQOylnJa8fLynKrDccPBJCn0HbqsAClyJLAIjqTUEDq2rTE8nettTefqT
 LvQzjLT+5beIm1xsBwnUMzaFUU1tdwTe+65UzmIYbSpldUKjla1Gk1nGE2SA2OnY/VeoXRWo7Xb
 0MQzMToS
X-Proofpoint-ORIG-GUID: CHI-OZgpzn5OIXLy5wRGifOfSN-_Yi-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004


On 9/20/2025 12:46 AM, Dmitry Baryshkov wrote:
> On Fri, Sep 19, 2025 at 10:24:23PM +0800, Xiangxu Yin wrote:
>> Add USB/DP switchable PHY clock registration and DT parsing for DP offsets.
>> Extend qmp_usbc_register_clocks and clock provider logic to support both
>> USB and DP instances.
> Why?


Shall I update commit msg as below?

"phy: qcom: qmp-usbc: add DP link and vco_div clocks for DP PHY

USB3DP PHY requires link and vco_div clocks when operating in DP mode.
Extend qmp_usbc_register_clocks and the clock provider logic to register
these clocks along with the existing pipe clock, to support both USB and
DP configurations."


>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 210 ++++++++++++++++++++++++++++++-
>>  1 file changed, 204 insertions(+), 6 deletions(-)
>>

