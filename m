Return-Path: <linux-kernel+bounces-827076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73254B9030B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313A12A23A6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EB730AD0D;
	Mon, 22 Sep 2025 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SK8+hF3v"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3DE303A1C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537546; cv=none; b=rselC7UNSPmf5lPNPLTMstuovQNf6HfEViyrbXOFfxPYbdYvMJWkz78OkXd0It0ioBwquj48mC2zxBHAZGrAGPYFGzvgX7qVlOpEoS3g4KzHA4NMmXGT9PRME6bkhlqqJiQ9tZa/8Ht2vkh/jc8jYGuj2l5V9/H32J17spoKgJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537546; c=relaxed/simple;
	bh=n9IiNcHVzF8wSrGZTJKLMTVcm6rKQY2sKCgE2XYStcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyUyRv1a7fLCkeatsoosTUlPT4OoCPx6O0+LIXCtu7vG4yxvWhXfQlNtYX4FWBBt6yJIJOlHPFs8NQOt/0jyNRyhWM1uxP/TAawUd4EuMsCkOcSq0LReEINZRONz0YpeQ9a9sLETFHQZFutparfFXqgNjcayFa3silvows2Uz7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SK8+hF3v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8n3Mr018783
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	//qK6wXZg3VBUfn/3y6cWL6qPfASe+TuJHYX2mofcCE=; b=SK8+hF3vd7O8Lkok
	QQzy0rGVxV80rkqb0+J65HgOtyQdcWLlD3vOxhhv10WZuEgLf3R3m/X32WC0JCjJ
	JgwHbMi5MCiP3W4t6183/UiCst1mplMxm5Gb53dPvydfSOjI/9ks13DF+VmtOTCS
	+yzH/r+Q9spXyOp4u6fmjGvm9be3Hs/dbqpAoHnrtzFUBc78NTGM+Iv9LCYpYX4k
	Foi88/C9kPkuJ7t+t2xERB/IwsFFjA2Fpzamllt+yLQDM8pV69utChBW0fAPpW2d
	W1/jEzh2xNRf9J8D9mo1LaVjT2R8z1ympQlmyUaBvIkkq/q7Oj0uErnGq3LtlHpl
	6PfKbA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fcb80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:39:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2696ab1bc16so12120325ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758537543; x=1759142343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=//qK6wXZg3VBUfn/3y6cWL6qPfASe+TuJHYX2mofcCE=;
        b=mSLv2/ZsRw+rgGu5mDb4ECNZ6BdLFCYKWMOM4o8a5AdVAiD4DiGfKAxVfrmNLQZc13
         KXuP+NH8qx3hRRIpE+pIZcKFlSVMvf42d0oGLi+Ctt/YTloLdyv+1iaGc2ukXUl+4j9z
         VsdELUgSeIO6r55+MiYM80UKD4pXtHNRvg1/hTWDfEC+CgVv+uCpBmk9DXfY6qd1+hC9
         sU3gmOmzv8jlxu087IoNNapbPzHTS9MY1KB3WOArLtPsJqjoMaTtPXg4IAB5a70gNco8
         Ul22GpB0S+uiJOqWKsdeUsMwkZvdAL03KJG05FgIxDU1Hb8FjLxOI4kNKauBvq9d+uUW
         0u2A==
X-Forwarded-Encrypted: i=1; AJvYcCWh4JaBamJ+V1QolbiPJ3NLhhmPQ5hzfo0YAHZYYJ7jvpfZcsgGDwK9KtQzTaXwVLkDh05xfaIuVabCU+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoldKBHpXEUno5J4ChE/pIUZ/LgwCI7JzGyh4nKr79U/Zd0eTw
	4fGqC0Bp9aiihS3RDLlghRU5/oUOfuJaSSWJ9uZs4TbcEO0sJNh1rxzSSsfxpw1cEr2WvR6v6Jp
	i37qFbBa8cngvVDfe7Lp9D8VfNiHZJbFoHfe/GtW1pZnb9t7YZ9ysEmVlcmkFMi0TYXA=
X-Gm-Gg: ASbGncu0zOxg5spRYHoyi0yZuLqMP7di9KlX79NdUpsaFzFsnBPJvjgmHpcCvJX8dlH
	hHekM4NhlTQcxDt9jpVQjc3dbJw7JGm/bp7By+Zh9PVzi+pfBVr8dwFiJltSXWOa+lvtxtYOW2d
	c52VsLd79L6VSXq41it6o+IslAylQC92LNEoh1IXHPT2yOLXvXrXCBIGna//gNaiRSB0sM3rmT4
	4FLoHS+TQw+JaU8STpATk++/540oZQC70cNdZJ02Dg2LeMIzQCYw7K3XoIguSalt5i8BZxlXBmW
	h2jlswHta898vPxDFk8b8UP4HvG/1vCJ6eOKuLVBYQEqmFVnAZVaOEDqKBwCXEc60w==
X-Received: by 2002:a17:903:338c:b0:267:af07:652f with SMTP id d9443c01a7336-269ba5443fbmr57183035ad.10.1758537542557;
        Mon, 22 Sep 2025 03:39:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ8EgA46Cot4VHvbFVkU1N3hyNZvluBxUAUjIVdbYP7UL9NYQ0X80HJxHmx6fYBf4OwquS4w==
X-Received: by 2002:a17:903:338c:b0:267:af07:652f with SMTP id d9443c01a7336-269ba5443fbmr57182785ad.10.1758537542098;
        Mon, 22 Sep 2025 03:39:02 -0700 (PDT)
Received: from [10.64.16.135] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803611d7sm129020115ad.143.2025.09.22.03.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 03:39:01 -0700 (PDT)
Message-ID: <c95870e8-e481-4d3a-ba4b-b990381b3d45@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 18:38:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/14] phy: qcom: qmp-usbc: Move reset config into PHY
 cfg
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
 <20250919-add-displayport-support-for-qcs615-platform-v5-5-eae6681f4002@oss.qualcomm.com>
 <z3phuuokrhonbukct2siz3ujear5ymtnoviea2epxzvjdmsvkj@w4puf4c44tmk>
 <83b5a265-1c5f-49f5-a89e-22f466df3304@oss.qualcomm.com>
 <ysxjabaah6rcbsjlreteo32zdljjcd547vgqeoxototwicjj74@rwovxeg6rnli>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <ysxjabaah6rcbsjlreteo32zdljjcd547vgqeoxototwicjj74@rwovxeg6rnli>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sDz__hQax30dSBSN2_-Zx9KnzX2euuXE
X-Proofpoint-GUID: sDz__hQax30dSBSN2_-Zx9KnzX2euuXE
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d12747 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=F9smdMtuN0WkDBw8KqUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX2CeDXCFri0eu
 SvXsGmCbKGVBqaaRErqn+yVJPmItU//fsc+ilTbi/b1zkCfjUYwKNGaKHQnA+rXZpM26MT+EqC7
 uJnaHguSJcm+pPsATAzu6HzGderAJX13CcYdWI0z/NWaBRa3Jo5MNWvPPt1jqaWaDaXSbviSxhF
 LJYDCMtk2Ci3/rxxeghAUbccstdXBMaCy9Vj0IPJ+ZLUnFK8+ZuNA9xgMkmT+lGJxBOzXiMEuOj
 hVDsXS7ABw4lspH983wal7gg4d8hBm4dn3XCiIYsq0mv5rRcYwsJDH2flJ/qnBtaHSX++nYh0zw
 NUsVxI7TLYXWTYE2xo1DFzIFmdyBP6iwMq62crGzbWSgnB68Dk1pAuJ8YvCqu9bIzNFx2nxGgRc
 DztR2d9D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037


On 9/22/2025 5:40 PM, Dmitry Baryshkov wrote:
> On Mon, Sep 22, 2025 at 04:04:42PM +0800, Xiangxu Yin wrote:
>> On 9/20/2025 12:45 AM, Dmitry Baryshkov wrote:
>>> On Fri, Sep 19, 2025 at 10:24:22PM +0800, Xiangxu Yin wrote:
>>>> Move resets to qmp_phy_cfg for per-PHY customization. Keep legacy DT
>>>> path on the old hardcoded list; non-legacy path uses cfg->reset_list.
>>> Why? Start your commit messages with the description of the issue that
>>> you are trying to solve.
>>
>> The original reset list only works for USB-only PHYs. USB3DP PHYs need different
>> reset names like "dp_phy", so they use a separate list. Moving resets to
>> qmp_phy_cfg enables per-PHY config without special-case logic in DT parsing.
>> I will update commit msg with issue description.
>>
>> Or do you suggest using (offs->dp_serdes != 0) to choose the reset list instead
>> using new attributes?
> You can't because othe DP PHYs supported by this driver will use 3
> resets: phy, phy_phy and dp_phy.


Ok, then I will update commit msg with issue description.


>>
>>>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>>> ---
>>>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 18 +++++++++++++++---
>>>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>>>

