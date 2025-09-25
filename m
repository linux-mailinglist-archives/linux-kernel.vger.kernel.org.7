Return-Path: <linux-kernel+bounces-833336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1428BA1B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7248387E00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6118B27145C;
	Thu, 25 Sep 2025 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SpaBbqkK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406D726CE11
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837358; cv=none; b=fPpE9axaJ5FyYsMjYN6k5aCbkECbmTTkUGfSYJ0HWJ4+OV0CD7WRUB5Rp2GAbMhreRzqpJaQcm85eUplGiqmbytTQn2BzL2MMZL09YFrRnJNtM7VPkgUdBJLlKmuJbMoKut+nFkzlTyW1GhpOj9T9Q997fm/NiJ/fq9cUm2UADY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837358; c=relaxed/simple;
	bh=3m92Yqle0P1klnHDM3h+RYJoZCOb72eoZFr6yQR+E98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CY9TYLNFs7oM3e1jCoskB9PP0LJ7fok6bFRCpngMGhVY5bEP9ch0CXaGM9GpUGRK2e0EQySIBCfOGjv21SSOIg7EnQuErrgJB2UJ1y8wZpaQUZwb+kQnYLdyTHU+EKGk6DZsuwX/P7bD65v4fOMHN+v1cz3kZxeBZ5D+bZrmgt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SpaBbqkK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPd4D027613
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=a4ka2QLj2dY6T1dJyHEA3YJ/
	IzOlBv0wCYfphXRfYzY=; b=SpaBbqkKOy16rASA7DbdkbFw3KD6rcnU0gSxUHUF
	lY/Q8ztIO9imzJT/UI0c7DxYFgUtMxMUa3zjSpivmlL/bSpUZECRbouC6DOA4NL/
	de9raH2ZzvwUBijW9Ss3lHS62mUtu3g7pCsSoJV8Wu1yAcbaJL0/iO6Nbqm6Z5n0
	FG/11qrHgE7sDjnLZTCqlO3l8ZHirCqwPtyBbV29wHC04gOPtLhxm0dj3iYDF7VX
	J3dmjhvAtjxDFwrW/bnSIvYq3AHKvwBrOj3kpzPK5vJ2jhNCa+0QCMyJrHXQH8yf
	4XV1I1a9AUnBQdh+P+TAfH3jkoUyuifYye5PtG2iHJCuyA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0q0gfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:55:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b47b4d296eso32373791cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758837355; x=1759442155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4ka2QLj2dY6T1dJyHEA3YJ/IzOlBv0wCYfphXRfYzY=;
        b=jFqm0r7dQyecjM6QtfHiHBnDtFvfTJGIMFq0/vcIa0/CkU+T0VKsMuiDCw7CFqBsdc
         144KWs/Ffj/dxHFgn6zhkmWkrVNhg8M/ESTDOGnnpZI+BBtP4vbYV3XYwV4V7i19idu6
         SKTjA3YQiJ02cMOxJfG5VRHf8E0PM/n28VmqUBdDoGqfEnwGBGePSa4cd+gMEbRoGG3S
         NVqJ/YZQNg8Sw2+VRvFK2IL3xgEDudP9i1KEljBU0wafReHkEwW8uBffcmTpv08TsJXw
         PtwNzbuDOKJzG5vMnNdCteyFmfz4ketLS/EacMxhDzx5MDg0cePaD1YjC6GhGQf734Po
         DAGw==
X-Forwarded-Encrypted: i=1; AJvYcCUmwL8enuwRmx0R4+XXrEPtcZgd4PvatlWtJVBsEEK30WUvqJ8NxgGiYpQV2jR12nNvY/hLN/LvlvTJVvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbOFCddekKPm6qwTmgsuD1C+TXjXIMLh+r1zAvndxt6NNAOhqz
	voknb2wCrAgOAqjDtcga1b7h/KUvPIWlniy/vlTnt/TFrDzAWFq4/5nUonKX5S3iabmGcR+ZNtY
	t9TEO5JEyf4AAj+5NBxoXn6hHehmcUm2B6qaB+OGSC3vLoEzuB8WkBTyBld5t2cfkEyo=
X-Gm-Gg: ASbGncsL0WUK5Wrkb3WXGcN0kPl16eVjzYyCR5vOQUgYRgGP4UIojpZTJxXTY0ml4U3
	9c0TXbGU4+cyLHJh4dKaoGHxByscAWRhDds5EQfgVVO0TYSWR5Jo84QlBZPwertTNUMJ7SZ6M49
	NspcmVmJQExqT87LgjJiRyjl5MtEbiymzDEq8XUHr/9Vz5AS5WAY8KIM6xe8JbYZ9vt5OUrhuVP
	hLFIDso2ZIMnPM1x6r05DWZMKPYbQ4g1+qWocGsSw0vTX2QIheVsCA5/l8eZZ0nuNhm2glxtHPq
	mjv8LL3t4eK/cO4xD8mJycnswBil/87s7crL5pK5W/fvPUW5DoLnEWcyQr3mRwMDBelfPix+lOa
	qlTuBOGIp1S5a0i4OabRrcXqPGhkdYmiKVW1Nf5nnlgnfXEuHxti9
X-Received: by 2002:a05:622a:7717:b0:4dd:7572:2165 with SMTP id d75a77b69052e-4dd757228f7mr2468061cf.35.1758837355057;
        Thu, 25 Sep 2025 14:55:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYntiu6xF3k5Ru1LTdNfPxLb5elSDEpGFN8h/DlxytsTv6aBQLG8p6laJbBjAkaRxRB3PDog==
X-Received: by 2002:a05:622a:7717:b0:4dd:7572:2165 with SMTP id d75a77b69052e-4dd757228f7mr2467661cf.35.1758837354550;
        Thu, 25 Sep 2025 14:55:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5831665624esm1154346e87.69.2025.09.25.14.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:55:52 -0700 (PDT)
Date: Fri, 26 Sep 2025 00:55:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
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
Subject: Re: [PATCH v6 10/14] phy: qcom: qmp-usbc: Add USB/DP exclude handling
Message-ID: <af7y4m6pcaeavwyxmswkjwugya3na4r5uaq2hi7cevt4bu4573@3zzfjxpc6t62>
References: <20250925-add-displayport-support-for-qcs615-platform-v6-0-419fe5963819@oss.qualcomm.com>
 <20250925-add-displayport-support-for-qcs615-platform-v6-10-419fe5963819@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-add-displayport-support-for-qcs615-platform-v6-10-419fe5963819@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXw84sSQBcediM
 RyL7vbvU4sk6ijQfvhSSpMeTfwzstwB3vuO8WrzCe5uyUUvCU4iMsXy8/xHVGf2f/V+VlTdYgCU
 v+ZDFZ9Z3/TcJ0NGyBUHN9sAoC7P0FdCOOOjHej8zMYc4wp6GswNLUwSYhHCFA+UFdiglKMOa57
 VrbFPu+2I6MrvnNZeyHD/03ng2ZJigt52D8qTeunOFjXbpl4ZngqAvA0W4t4bzS6r1DVHIu8fPJ
 S9BK/b9nqtj0ADH1jPW/Gk769puBtl2g588LfQaO9hNK8ZKzIieWzVL3QfnVjP5P7yl/9CeZHxb
 i3VBavGxNSlPRjztZhMPEiwzzs9pKRTQTl5YgsBkWAUc5LdwhHZCoNbhmuHYvt81gotX4neOfNW
 Ghvt11wPjeUpVPomJBrQaZhwaAQFVQ==
X-Proofpoint-GUID: wYepJqCEG4TokcbR6yTmLQQTbfgzoGW-
X-Proofpoint-ORIG-GUID: wYepJqCEG4TokcbR6yTmLQQTbfgzoGW-
X-Authority-Analysis: v=2.4 cv=JsX8bc4C c=1 sm=1 tr=0 ts=68d5ba6c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7a1U2GcbA96CJLvzQ6EA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 03:04:56PM +0800, Xiangxu Yin wrote:
> When both USB and DP PHY modes are enabled simultaneously on the same
> QMP USBC PHY, it can lead to hardware misconfiguration and undefined
> behavior. This happens because the PHY resources are not designed to
> operate in both modes at the same time.
> 
> To prevent this, introduce a mutual exclusion check between USB and DP
> PHY modes.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

