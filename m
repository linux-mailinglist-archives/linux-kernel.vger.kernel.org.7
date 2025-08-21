Return-Path: <linux-kernel+bounces-779493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6065BB2F4BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 576FE7B6A39
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858012DCF4E;
	Thu, 21 Aug 2025 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UJDL5LB9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC091D88D7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770429; cv=none; b=oUrfvYaz0uBegqEQRFoMHPkpENN0yR5rxPMiq06U59yUtNlQRRh7H8UDhYDVLDHNIFsAuSBvzC+81Opfzzep0KWXhHFI71h/vGETQbejDql5jB4tc/QNKmaLPVuAofp3lAb9Tyz5QFF0RYfNWbWaTLMMYlwcvrTsbXxu9efelGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770429; c=relaxed/simple;
	bh=Y8oFffjKoApbub4tCKt/v9xVNo7J7Qh09vDhx0yFE5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpExP8wKh3bVwKThJ2/OBRfxXFVpyPnGyx/C4AJREe0kWKvvoShFgHslWvzEqcbotFuzMS+q8u3xXqWvC+/yTB9vtg7+WThjgkA72ioe3r43cMtCmY+wiMaMCRV/YQsCaDeQBaz/HMd9Nn/xXzE9WCm1QtgQimQpK/7kKR04cIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UJDL5LB9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9bC4t015666
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BEHubwHefQwrPqwhX3iHGRRX
	J/TlvHydnjvXdxeW7/w=; b=UJDL5LB9WOYnkibCHOzq+rrOD+RcdU+K5gaJYLOe
	yQuOBq2CFD9a4vZHWTnfMIIC9dMefUY3h5wbKD9wgLuBI4+dVjxRNtUKo3EJ0Udu
	Oy8Z0T+UFugboBg7OWS/DQG6oJ5ctOHJrWXq1sXMwjKTgA7Wj2/qQeu8gGvHIuhL
	szd6VVKzDc2kzjcoyMsretV51subasHk7+OSBTxxAIDoRKjcdCyPcxVhtZ1BzSJd
	3K3CIPwlu9hWMnmO3EaJI5X1ZTliZmb9LoDeBOuij0jh2/3Af+mFx2ZU/SK91ToP
	PddmZOndf+A8rqTHta4j80P9aRtol1giG6X6CkHjpKZskw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5294y2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:00:27 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70bc9937844so19861526d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755770426; x=1756375226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEHubwHefQwrPqwhX3iHGRRXJ/TlvHydnjvXdxeW7/w=;
        b=CxeWpApgDcIoMb+ZWss8Xnnq/1Je6ofv2PlDtOQgOvTp9x9lgMcC/vWOaICaHRTT0K
         4thHqsYwv9Cy0Y29E5xZVCNNiSxK7+WaFnHjDg4WmDDJTuGlwCW+VOqtdcdRcUU/zzp2
         hLRjq2FeCob7UQfixJnoIbUB/4yyXDFITH8SLo4GC60078MV/YgFh/WwbHAch9zA7xN9
         JoM+4TP1gyiVZJ/Mo+fe3dtSFDyEo4x1ugqiRf22UMI63BNVHGVmFjWxnpF4CrHfNYVA
         t+W5qLK6gnYNxd3P8SrSWQ9vM2tplnRKnrjjEIo2okvZsEVGgsB5Nl2htBjtz04r62rX
         ss/w==
X-Forwarded-Encrypted: i=1; AJvYcCWZf6/vLoP58o7HVhII90LhNSadt3S5q9LvNumnr6Ttlf2a56OU/62zzJW0tultp7aIi6xA/y3hPSbsSNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YznYqZQOWoCSpHRk6ljX3xOTl7dyLQXWKJH/4RMFV/jrcdNijfg
	hlbNhFSXVtYHTg01BTD4so9QUA1Qf1C1LTcCrbALD270dzsuwLv8gyoUFGgqrcGyyw/x0d8/ZRY
	0Cf2/ODbiMwHpHq3tGWw9nHMrG330keBUH1/Hl21yp/shWsQAH8XEF47TBAgOcxSH1Ys=
X-Gm-Gg: ASbGncsMTn8ctKZmjKT2pK8FQp6laHc/VoACQV5PdfWD0GttNJ2WhGDpoE6/EbFPsZV
	7ThwofbRT8S+oJY/x8l1/YXLRk1GIyQbli3Lfq0ve8lNkzxfl3NqMtqpSWsGtz1y3S/zyLOo1mS
	YcTGheJ2+Q+k25M9tKNtUASgg2mzmmgH/hsvJ49PZ5WlkhqAhNEEseMZxOf8fhap+8fcFHOwhxg
	qiGohxnsUwi5mtBdg16YQPERYAFMe0PVRkiqyEOJ0ZOJqt4PIoMT01aUWUE6u9m6NVrtFdunWWD
	T01H7cEyBDqsl0gBCMmD4ite+JPDrrUVRFdwwYO7ubH3mOg3ovGAf4jlTvu4BTOCwDFGtRqg8Ok
	Tw14FcN2dw3Yu8QMQyBRy27ukgCUuPwlB6u/MhixU47rAcVxSP+Hk
X-Received: by 2002:a05:6214:20e2:b0:704:9239:bdf3 with SMTP id 6a1803df08f44-70d88f81867mr12888406d6.40.1755770425846;
        Thu, 21 Aug 2025 03:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7GWcK1Cl7yi0H9LNf9qwylu6UzN+J9gWKQiC6yB/eosOSwsmqO6HT7DI9oxpCQE6vFO0F8g==
X-Received: by 2002:a05:6214:20e2:b0:704:9239:bdf3 with SMTP id 6a1803df08f44-70d88f81867mr12887946d6.40.1755770425174;
        Thu, 21 Aug 2025 03:00:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3517f7sm3049579e87.31.2025.08.21.03.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:00:24 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:00:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Wenbin Yao <quic_wenbyao@quicinc.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3] phy: qcom: qmp-pcie: Fix PHY initialization when
 powered down by firmware
Message-ID: <opdbvesy3gomk7k7fmtd5dqwycfc2wjdwhjrjedsud7zrxwnsz@zlmx5sdjdk6b>
References: <20250821-phy-qcom-qmp-pcie-nocsr-fix-v3-1-4898db0cc07c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-phy-qcom-qmp-pcie-nocsr-fix-v3-1-4898db0cc07c@linaro.org>
X-Authority-Analysis: v=2.4 cv=Aui3HO9P c=1 sm=1 tr=0 ts=68a6ee3b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=t-ghYzj4duJAONndmXwA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: saYbGOEYDqlOtTCCDXffrIyMYnQ2njjl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXyr3WW6vEaolS
 j6ZkyOtsyvQAIAIiizRYAKi8oYAcVa5Hz6eu+I/PFkczr+/fttx2rXTouoj0h/fwcdy+iGHeghc
 IqJ+fvtDJu+QbNeK07/p2D8zPPIfwY4ohNz9dKw/o84ynETwAuGntA603LfNrG6imNzTZMozl/e
 s5MGptRjDUHXPXW91H2BjiRJW8rFu/Vj6hAauI80j2tK6shfNNHocPpkeFpylsPWTf1wwh1/srv
 R2OykPh18blX28XVr2WT9uF9fYuKkM0wuKF9BKUkD4BebPOpn51v61rMNNW9reNaAjUtCTLxyh/
 uWt7deB6LCb1jZ6g9plYHQRsqHBsknyi4kxBbOx+yfvGDxK75j3ZkC88LyIvNRAcDdaSn9bBWbx
 VkMfnlxQEicfxy28V43nR8whAbEedg==
X-Proofpoint-GUID: saYbGOEYDqlOtTCCDXffrIyMYnQ2njjl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200013

On Thu, Aug 21, 2025 at 10:01:47AM +0200, Stephan Gerhold wrote:
> Commit 0cc22f5a861c ("phy: qcom: qmp-pcie: Add PHY register retention
> support") added support for using the "no_csr" reset to skip configuration
> of the PHY if the init sequence was already applied by the boot firmware.
> The expectation is that the PHY is only turned on/off by using the "no_csr"
> reset, instead of powering it down and re-programming it after a full
> reset.
> 
> The boot firmware on X1E does not fully conform to this expectation: If the
> PCIe3 link fails to come up (e.g. because no PCIe card is inserted), the
> firmware powers down the PHY using the QPHY_PCS_POWER_DOWN_CONTROL
> register. The QPHY_START_CTRL register is kept as-is, so the driver assumes
> the PHY is already initialized and skips the configuration/power up
> sequence. The PHY won't come up again without clearing the
> QPHY_PCS_POWER_DOWN_CONTROL, so eventually initialization fails:
> 
>   qcom-qmp-pcie-phy 1be0000.phy: phy initialization timed-out
>   phy phy-1be0000.phy.0: phy poweron failed --> -110
>   qcom-pcie 1bd0000.pcie: cannot initialize host
>   qcom-pcie 1bd0000.pcie: probe with driver qcom-pcie failed with error -110
> 
> This can be reliably reproduced on the X1E CRD, QCP and Devkit when no card
> is inserted for PCIe3.
> 
> Fix this by checking the QPHY_PCS_POWER_DOWN_CONTROL register in addition
> to QPHY_START_CTRL. If the PHY is powered down with the register, it
> doesn't conform to the expectations for using the "no_csr" reset, so we
> fully re-initialize with the normal reset sequence.
> 
> Also check the register more carefully to ensure all of the bits we expect
> are actually set. A simple !!(readl()) is not enough, because the PHY might
> be only partially set up with some of the expected bits set.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0cc22f5a861c ("phy: qcom: qmp-pcie: Add PHY register retention support")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
> Changes in v3:
> - Move up existing comment block and clarify it, so that it is more obvious
>   what the additional checks really do (Bjorn)
> - Link to v2: https://lore.kernel.org/r/20250814-phy-qcom-qmp-pcie-nocsr-fix-v2-1-fe562b5d02a1@linaro.org
> 
> Changes in v2:
> - Ensure that all expected bits are set (Konrad)
> - Link to v1: https://lore.kernel.org/r/20250812-phy-qcom-qmp-pcie-nocsr-fix-v1-1-9a7d0a5d2b46@linaro.org
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

