Return-Path: <linux-kernel+bounces-827140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4845EB906A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C8716F46B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2F42FC01B;
	Mon, 22 Sep 2025 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RFl7+RoV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18130506F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540828; cv=none; b=RfJ7tNzbSZufjTL6Mh/2kUgEJnwJSpkEy8DKO0gQvGkDknVE/wiplowpY7kV6a7xirfFu1/2bIPTOcC6tc2S3ww6qVc7eLNCSGKrTh4u1rVtiGuEsV5UrFQwp4+i29ezV+CribRPu78w3QQC2SsgfaB/8bmycc5XDhk+walzR5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540828; c=relaxed/simple;
	bh=fTu3I016k0UfmLefAcsCbi/L2QC3YPl16aRqBTC1hHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i53iyiTFvVQGEBkPb0dV/yt+jN0i3cwhWdeYNUMfmBHyQZ29a0ZaqZ5a2u/ns8eZoP6b3nUZvQXNAQzws8CjPDvx6dvy1dwPTaR2BJ8Rre4hDIlrsV1IqHgJ/YMoTKZMddylMhR8qMAWjZec8OIQp8iM6ZCTCplGuaDcRBOsVYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RFl7+RoV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8vRsC005777
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8ny3tRDGyVpQC4SF6j/gk9PZ+S1uMs0oLN9O/oVrvh8=; b=RFl7+RoVThr85vGk
	0pq84J2kUfPoEE3WsNh6VQcoF4kb8m2Z72K5ej3yZCzlaicskMi9BVCeN+AUwxt1
	maMW7IHkViPYAXSrvKlt3G8y8eswCIT5/+Jhvi+08bQoJtAQB3J1K7tsLcBnlO/r
	uO0dEFeC5s05UDFPUQl/QxFe1XN1psGPHiCo0fcYOAOUaItSHLkOoiQoXfJKQ7f/
	0QZGJhEANzPFktT2Ik7fCZUzgYdl+kQHmjf8S86CC08zyN9bfehARY4q/WVGU6Mm
	YAh024zFm/pDMktZtYjzHzxCTDk7uoSkG2NVvroSVEqb1M0ypux5ePtG+JYMyCC2
	dukhcQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn7ck25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:33:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-269b2d8af0cso8563025ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758540824; x=1759145624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ny3tRDGyVpQC4SF6j/gk9PZ+S1uMs0oLN9O/oVrvh8=;
        b=JulvHlXj4kjnIOVBtZ0JxewOBpqBKSxSaHPcXNVdPuJTHdCFP+YxxMhOaT0eAxvdqu
         gn5osMkYdEKOSUYQEtGyeKJvK9ApsEzX9f5ffIi6jv5WRFBx7lJVWbwFGOryrm7X9tKz
         JjaE9zhpdEqViEfZgvmQGwH5aYJAS6Nlpq2BQoRM5Ia6fGxhEDD3fgg3dNnQ4Mud1eUA
         edppHGQVNg4rXRVTsdJlLMcVCbG+5Qb1O92v2es3i4Le4hW3hK3Q68X75DwsttwZK/jz
         SusCuRb5DiGHba+Rm+wQo8OSYoRYH+GXo3BZOpuBNljGGvIXrBCFwpY4U1OxfPvJ1rmP
         2YOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgltn/56suwgkMMD20NhjVWYFLEqPj+QVuUFq3YJNLGzJfOYWCiReVmQ4pS2RoaUa64fKgtEq+/2xspaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPOEnka6Gb0Qqc0mO0jFzoy0BHR3T6Ez3+FbcSXocQMeAWRpRB
	vPenr+EJRInW6W03myreKGocEF1v1Hy6sLIFEVXnJaDf8XXtq9MQ3KJBLrsHfHsi/s+utEFG1z0
	XSq4eJRqjJUM7bve1que9j62nWwkzsyk1eUKgwoOD7RAEolzUKktATA5A+8FiRTxuIMs=
X-Gm-Gg: ASbGncsa3/Y8f++QntPHzIJtRqRkvc0Blex1K5AWOEG3DRrrZ4Xp5n3z/aso+sUXtDS
	+H6IE62OfQYmZJNecCSsgD2g9u/QedeaaHvuWe0pZ9OCxkAccPcSga2ZUK51mNqk6ZLh1HTIwIp
	JPivJuCRaIuGQDIiWkydLSsVvxDCNASHcEYWqFujXww6OYhHzDVV0qu7fK2xyWeoHN+NGjIaiXl
	J+8JsKPLReIqAqP1bf9z+SGMmZ23w9dQjcTsb8qlTAEKJ5Z0UOaQvSSxbjWz5FY58eZ46Tdz0V7
	L5tjjV9Y47iyc2mkDN4cE/mbeFfSbhBkbi/ma7MQpURDxS7ndwf8Z62GvvAa3XzHeGCt/qdoA6N
	KaIsWjNPxXUiQD41j7dgQRWxu9ci/Oti1E+4=
X-Received: by 2002:a17:903:110c:b0:266:914a:2e7a with SMTP id d9443c01a7336-269ba50450bmr97853025ad.6.1758540824170;
        Mon, 22 Sep 2025 04:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDHH9Jnyu/wz0+fPUoAUMxFXs1lC0P7l4A/wqHWPTtDgp9+q8Jyik+xPio2B0P/RaEWdFbmg==
X-Received: by 2002:a17:903:110c:b0:266:914a:2e7a with SMTP id d9443c01a7336-269ba50450bmr97852675ad.6.1758540823742;
        Mon, 22 Sep 2025 04:33:43 -0700 (PDT)
Received: from [10.133.33.111] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33060828031sm13050240a91.26.2025.09.22.04.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 04:33:43 -0700 (PDT)
Message-ID: <f53fd974-f3a9-4efa-8cca-ff639d75196f@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:33:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/14] phy: qcom: qmp-usbc: Move USB-only init to
 usb_power_on
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
 <20250919-add-displayport-support-for-qcs615-platform-v5-7-eae6681f4002@oss.qualcomm.com>
 <zjegjucwluzzh2x56mn7dpk4ocmbdrhyvubkxprpiuko5cifvv@ygvbal3vpssv>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <zjegjucwluzzh2x56mn7dpk4ocmbdrhyvubkxprpiuko5cifvv@ygvbal3vpssv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX5Ad+JywB2IX6
 Z7WhxXG5o9qieJO5sAJ3djkMFRYqh48WJDKaENDvSy6jpH45+38+3aSwypuRjgLPQDldfP2Ol6N
 hdAlob7s5Gld1WoZBVI40vfypgFQj+1pWt6TVCrFE/5Ubg1SFv7abX5PnCuQEcZjD1gavh9tIG4
 TFfJeZRrKj9r3iXKXEM8AYG5hrq6+SOilncATMwn1LjxGJlmdTOywqEs8+Xgx+VFSYpAim6Iaq6
 EyeXwKd29wYcRfBI6hlEPna8Inz9yOuJufrLpgCeS2JL/g6nAS7QEfAH3QuuGdZFkE2Y1kztt8w
 6SpJO8Nb4ci15ZP1crgp0JtRM7aIrWwzmw2HuXmJCOgYsHNVYZc32rpULDKjRfSmPE0sIDA0sPq
 0j5f3mzr
X-Proofpoint-GUID: Jct5vK0s-yoU0WSn0QObgIYWmNH925C3
X-Proofpoint-ORIG-GUID: Jct5vK0s-yoU0WSn0QObgIYWmNH925C3
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68d13419 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=MW-FMpQjATtQXXRqn1QA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033


On 9/20/2025 2:48 AM, Dmitry Baryshkov wrote:
> On Fri, Sep 19, 2025 at 10:24:24PM +0800, Xiangxu Yin wrote:
>> Move USB-only register setup from com_init to qmp_usbc_usb_power_on,
>> so it runs only for USB mode.
>
> Please rewrite the commit message to start from the problem description.
>
> With that fixed:
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>

Ack.


>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 22 ++++++++++------------
>>  1 file changed, 10 insertions(+), 12 deletions(-)
>>

