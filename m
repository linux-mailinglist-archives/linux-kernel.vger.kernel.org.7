Return-Path: <linux-kernel+bounces-813913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597C1B54CEB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D498E178576
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2446330DD3F;
	Fri, 12 Sep 2025 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AlvPbLkw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2530DD2A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678621; cv=none; b=s//kVTeeOWRhVzqChWk3uZLnpX8im0GBvg/bP9YQtYxBVzpGSO1xJ0NIIqjo/H10IXb02lbVpkY++P7eckOS6SFTABb5KinH56L9ObxM+1vZde3463QmwHjKb6rdrNq4+tvznfxQGHj5d6swTS5sOhoFfWuqBG5JtRbq8l5PncM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678621; c=relaxed/simple;
	bh=zz8o30m9RMDywni5m0nG378AjKh7Tlr5V0xeoanNaAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2Cy4iAFuzG/EQfaGUdcVk0HLwJ2NOjv/WEQoI3nR1zVi3+yqLGqLFg9UEH1EBkvG/YhQ3PScDZ8n0iEEuxVd+S6udY+C+jfP9HvygdkqOY3L0pU6LC+RQxAeUIzkbebhy77w3va/cJZ/ddBlTatYNgCk+1tlUGue6icIz2LpaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AlvPbLkw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fELP001284
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OC306+JLRzCtQu+HZoUMCL3Oa/U1/T4cictyJ1c0fJU=; b=AlvPbLkwvvsKmqNm
	f6Y2S2TTjOVpZGfIGtO8m6/ajO2w8M79nskwbh+1y6U1BmaWpYPIhsEplNPCUy/m
	Y+qYCkgf/yRC0tNSp4uFEinRpX4c7Mna3R0cYelOJx16RnTOAUZV9++6zpfviV0H
	12NNz+qZqZJGrNUzKpdgttXqJIp1TOrxaPCINyMRcNZrLXLTogG2WYJNt1W1i93P
	iRQHAh25vUwksHjRX8E6DR42yQ+eROeGx9kNbYTua3AmD1S/pDcWJvSE7zxCaCSV
	ekNLDJ5cxAfNgmw4fCn9hGw9yVu60KbDODPCM/1VTOcTW5SkiKFs0qUoRDDzJRsJ
	+9D/5w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493f6h6ja9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:03:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24cedbddd35so6300275ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678618; x=1758283418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OC306+JLRzCtQu+HZoUMCL3Oa/U1/T4cictyJ1c0fJU=;
        b=q9hSBIECAtd6Rmv8ttVHN65V9bMust2zt4LVaEuxe/poLAiY3cBFewFBFeFKSp9rkS
         qK9bbRUgIZwLLvfAXcxVNYkXeqY/IKMUZwNzeKxgocanSQoXvYDD1IcqC1sgAEHDFVDt
         Jc1bGXiDScBV+ED+rFKonDMdUy4+pWXPIXLiUk+V0uOt5unDKsiX+3yV2Y+qBYiJ4AgM
         DV0YAqwYW/Qa4yvY8UdArVa4iJOPl/Lm5r4YKam02mx3cFEm+rjA7mEp4hvxF2iUZrIp
         d+jQrLAaaHhUs42Iv7KZpN0CcGLtyOuy9YzBLQn8vXmS35Zmzs849jGwd4uhOVjmhtuN
         O/iA==
X-Forwarded-Encrypted: i=1; AJvYcCXnD8i9OFRFZ++D2xjvOjV4P+0VcOPKcaeIS4KNdMkvj+61aRlfGxEweR2PJvOEatdRuqtp33NDdNS0BnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoxpFY5Mw2PO20JVn1gWepFfv7nioVUVzaq4UOTcic5SLlA+er
	64zYDaodM2FBacxFTbtT5BHietRmwZxF9bOGkEKS+RqbKQR+IOcOI+da5GA9H4OIsKu+t2goiyL
	eauLQK/WTU/Y39YaneRn5v8Du7ggFc8Tq1kqiX4AsgWFiLnJQCIuCOovxly6YvgSRzOY=
X-Gm-Gg: ASbGncvD/vxqF5F1zlceiLTd5kh0MaCq+p1w+rTn84DwI1Of9cxeobm0cxOdCOg6aN8
	EPl5SfNNiOPf1h+5SO7aILVr5RR462MKAsoYiTF1pO4hF7SavnT3H1OJqwQg9uE2dBX4ixHy8U8
	RiV+XEBRnkvVfvJjz/HF2OrhiIvnQwurzSjH02NTK9fM3gVSrMSRSQN9BuK5H7BBE0UxV3e6i6F
	GE5L5ObN0nz+h9iGzWPnJX+/weaHYGAgea8aMq4jQx867wDJm1JyWicJdS4qf5grxyR3cOFQvbY
	l/+j7DJi18c5vnmbU/wPTY81hLxiAfb83wFzG2pGmsvPptBxKULtlk8rdwPCzV/HHInTxUXt1h7
	g1NibI7rcSbKaQdY843Ei5DD5hOfrSA==
X-Received: by 2002:a17:903:1245:b0:248:dd61:46e8 with SMTP id d9443c01a7336-25d25a7294bmr16547655ad.5.1757678617834;
        Fri, 12 Sep 2025 05:03:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0bcpdWZ5JtOcYfmEEQBTJNc9tzJlPspC8jR11YZhBs8DDVX3VE8+HBzzj6SRFPVGJrjwKeg==
X-Received: by 2002:a17:903:1245:b0:248:dd61:46e8 with SMTP id d9443c01a7336-25d25a7294bmr16547335ad.5.1757678617295;
        Fri, 12 Sep 2025 05:03:37 -0700 (PDT)
Received: from [10.133.33.174] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84957bsm47241905ad.80.2025.09.12.05.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 05:03:36 -0700 (PDT)
Message-ID: <70e9d5a3-53b7-4e2a-9a2f-19e3be1e197d@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 20:03:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/13] drm/msm/dp: move link-specific parsing from
 dp_panel to dp_link
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
 <20250911-add-displayport-support-for-qcs615-platform-v4-12-2702bdda14ed@oss.qualcomm.com>
 <4kajb4imv4mvpf4bdzoqfw7f4qoqxsu3ca4pbgsunhxnortfig@kmsqgsj547hi>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <4kajb4imv4mvpf4bdzoqfw7f4qoqxsu3ca4pbgsunhxnortfig@kmsqgsj547hi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FS5Fz0mOETX6p3SCbmf0qkrRpn9BrVTu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDE3NyBTYWx0ZWRfX+MW+rggkgkTh
 P7B1e3JKWEj3fbI1Gzg5yGO+2fjqr2pCTH3sK7guz77HpPD0DWXgZNyO7ijYNcCCS+m2oMe90m1
 WxkX2voNEIaB1F89qblXfygbXmNttvohw0C5pRxgk/4CsoOVHcTz6SisMA6x0RqJ+POab1IvwXH
 a82NYbVuOLohFbIJL6NwGAenmKz+m7B263PkxqGUdef/wOFH4JkaQRptmwc+UmVET3QWaKszcqL
 C7LYWKzeMmf0fktErQlpR8ofqumUnI5XlQIUPH8UBKduxPh0un/bxZlEDQJF7Klakwb3JVZdCDm
 F7mrME9RcqWKJLLA/89NXXhY2gscza0DH8harpLe6RMU4BRkM3mlZms4IOzcicseRZmmaiJY9Dh
 oz04BMdq
X-Authority-Analysis: v=2.4 cv=WPB/XmsR c=1 sm=1 tr=0 ts=68c40c1b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=3J_imRUleR0CZ10obY8A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: FS5Fz0mOETX6p3SCbmf0qkrRpn9BrVTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100177


On 9/12/2025 6:39 PM, Dmitry Baryshkov wrote:
> On Thu, Sep 11, 2025 at 10:55:09PM +0800, Xiangxu Yin wrote:
>> Since max_dp_lanes and max_dp_link_rate are link-specific parameters, move
>> their parsing from dp_panel to dp_link for better separation of concerns.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> I thought that you've split all DP patches...
>
>> ---
>>  drivers/gpu/drm/msm/dp/dp_link.c  | 63 +++++++++++++++++++++++++++++++
>>  drivers/gpu/drm/msm/dp/dp_link.h  |  4 ++
>>  drivers/gpu/drm/msm/dp/dp_panel.c | 78 +++++----------------------------------
>>  drivers/gpu/drm/msm/dp/dp_panel.h |  3 --
>>  4 files changed, 76 insertions(+), 72 deletions(-)
>>
>> @@ -1225,9 +1283,14 @@ struct msm_dp_link *msm_dp_link_get(struct device *dev, struct drm_dp_aux *aux)
>>  		return ERR_PTR(-ENOMEM);
>>  
>>  	link->aux   = aux;
>> +	link->dev   = dev;
> It is only used during parsing of DT data. There is no need to store it
> inside the struct.
>
> With that fixed:
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>

Ack.


>>  
>>  	mutex_init(&link->psm_mutex);
>>  	msm_dp_link = &link->msm_dp_link;
>>  
>> +	ret = msm_dp_link_parse_dt(msm_dp_link);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>>  	return msm_dp_link;
>>  }

