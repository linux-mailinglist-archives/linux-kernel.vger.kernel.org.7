Return-Path: <linux-kernel+bounces-807965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8248AB4AB7C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754F31683E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE1632275B;
	Tue,  9 Sep 2025 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FRKv1ZB8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7121E321430
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416374; cv=none; b=m4PHxIlKm8jdrPYs4RooPX4+P/27cwoPO4Vq7+U29zceZXl3xMdEJhQ75KPTy6cW6OvVeYixX8r78nxwwfV3lh7cCXGAacTZnSgR7V0yD6fXHVIYrN2hs6AYoUDeyqZ/H322KiWApIDK/XUptuS0ul1Z2ebbE8n3MQN3HAlyGOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416374; c=relaxed/simple;
	bh=ABXOdEgAp3ROJMFWb1n6PCoDt2CzTceYi5y9YjH8iXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELhpHoUdfIxolLPbGHpRZ+KqEZn8wfP/9GCiDnWvYSnogvshSs5qaf+M/xNgWJ0ORh2YNoC3txut1Ff7uNwcm8WwAE3+cZpTCdLbidXy1SfIELZ6OgPQ2vf9MYksK3fV1mHaplHJKM+deI5m2ZupW1nzWeOJXFzIpbn+bIYBNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FRKv1ZB8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LQgh009026
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 11:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=M9znp73XyVo8U1TpZOW4OBtp
	RYA4woIw+OLOhqqO3cQ=; b=FRKv1ZB87y1M/oF4ZEp1XPRLMZuxo8qzDytkd9dc
	/oz57l4HCdW/kVw5UOgKmTPh/Z0uAzsypvRAQHfCx2FhrztGBQ/WGG8xs/TdEhIL
	pBpwzMVgJCcVM76s+cjyLDAA8hmSK3byPu3rvKHNAp6qpSNrSZukvXaOlPu4eLUz
	/OMCVTxOn59h0IHU1ZPCEVmrbyNlZsHei/7e4lqvthxAFx81WCsPkWxheQCifoMp
	ik8DA8L4BUQvAVOu4a+UqeSBGLxRPJsosrQIP+yx5nK6WKJ49CPac4y+2XTI/YIa
	Un6x3T6wxnescOS3NIPh4vjmzeey/yWuFajqsNporbml/A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdvsrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:12:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5f31ef7dfso98227501cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416370; x=1758021170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9znp73XyVo8U1TpZOW4OBtpRYA4woIw+OLOhqqO3cQ=;
        b=FICmCILUwlpK6esTAad6G2t5E6/1y99jqUAqlmWzeYwqxUJ/mJ1meVGs475iTwdXTW
         ZsELsTXKn7ecztI/ZjF63zz3wjEVEuKxo8nteZHSkr0Trr/bnS8a1xJygGQZsfL/MJX5
         x/NB4crcOls4QWl+Gyz7qaOJp38fDQP9s+c+0Wqz6+DWb3xXoGUxyu97gC4vQwtVcQEW
         urTr7SAqNm02zcaBqgx+NDEiKpysMUj8yFaYFidHNhGvPY4+QTmMYSaqAw0j4p/576M2
         ggjFz7X2JEAA6XG1Y8CHulvJZ8TVUBQga//5xjekhmiFZg40iMEhdvtwPL8RstN8LJAN
         c4Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUUC0M05/Klf5i0/pLoZXAPrPEFaZlB4rVU/wkY+z2raebGvfsELX8Jn/Td5mZ6KBCcBT3tCZ3b6/ql/gM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rLECtXuP1nyOC+iRKuxssk/cFkD59Nr5mYWbdTN9q2DPxwYK
	YVlPLt4cBLqE8VjsXbLCWGyN9c5E2f8uWG5fvKl5gei1RjWd9vqjUMqZZbQ7gOOj8o0+eSjIlIW
	GQZEXF64vHNY8fUVWsm1mVHbLL5ixKy6tSyHTYN4kU8h/saYjy216UKsc4H3Rkkxo+K8=
X-Gm-Gg: ASbGnctm4MV/VFf7CGOe1bu0pY4xdsYrFQ0u74LGeOY4VVQawPCDspMBfX8C1l8kzDV
	kHwbdut+weuRci4UboGfnMQ7DcUx9f9A3pfuI6jyk4ZtoQubmV0hE/ZuqLhRbk5JcN8blTGpzNi
	8zzXo+XRje+eApJNob0o77iA3KXeHcehyJ2ZiZoR/vPAzAwrRzDq+zcO5NEAEuRJ0YgIw+keZNV
	BRiS7EmB7dihgcKhERx5N7WN7hKdnNL0s6/+oxYRja4aux+HPrwI0oISQbpuplfSeWE84G5EKHP
	bnU6GAe9movBGuKQiy3JVx0ToGvH90raYWCBEBkdu8gc2cmg6N5otRvfY8t/RIdVifRZzPdL6l0
	3W6SPqaXduZwLBOm3i/5KvRBEsJYy51fB6jPZoI0W2wY7+ivD0shb
X-Received: by 2002:a05:6214:509b:b0:70d:bcf0:7c12 with SMTP id 6a1803df08f44-72bbf21116emr132264816d6.10.1757416369937;
        Tue, 09 Sep 2025 04:12:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFihv061/0IeKHM/2H1vKgpbFBruOQN320dQw48xcHjkKFPI/ERP986jbIwJuh5jmZLJF3Log==
X-Received: by 2002:a05:6214:509b:b0:70d:bcf0:7c12 with SMTP id 6a1803df08f44-72bbf21116emr132264416d6.10.1757416369335;
        Tue, 09 Sep 2025 04:12:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5681795eac6sm454789e87.92.2025.09.09.04.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:12:48 -0700 (PDT)
Date: Tue, 9 Sep 2025 14:12:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] phy: qcom: edp: Add Glymur platform support
Message-ID: <3bo2xr3jb3hrzsetjzd62dmcif2biizvoanxwtyhr2dmkb4g7x@dgrcvzujcwgq>
References: <20250909-phy-qcom-edp-add-glymur-support-v2-0-02553381e47d@linaro.org>
 <20250909-phy-qcom-edp-add-glymur-support-v2-3-02553381e47d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-phy-qcom-edp-add-glymur-support-v2-3-02553381e47d@linaro.org>
X-Proofpoint-GUID: GxhDcT_jDHg8epe23bidEKgqVbc8SOdx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfXyeDIyUV/TO2Q
 +6xp+tXPqudoRVZ6yaivmFjriApi4dil0m1cQGRi/MIWer4lZWdDGiKOA5ys/2CYPLgQHDH6r8L
 8eQ85kxPuOPWZY/8Px22ClSag9R5pSjk4THRS1VzMBON3gp2xDXOfw31y8b0lw8DzpdWVZaLZDV
 DmTGLw6BX4GpYooozXVWY0kbq2Oqx3wVO/Wff+nG/CruQsVAdYf/ghUm6M+t/PvBIxrd2lAjQHO
 sC7IBFZe7zn+++IPY3rIROfRfTjbW1s66EvKGMGr38GL054sraoEi9JL7JZuUN9KkDqTCy5ciH+
 wi5Kx/XN/cLvuWeKgSw0Hqe+YDOdCf2y1MwUQM7Ww8dKivydjIf1gZYLSNSDSY/68YH1mpKoLb2
 nAOLRzQB
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68c00bb3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=r658mG_ugU-Z7oAIEg0A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GxhDcT_jDHg8epe23bidEKgqVbc8SOdx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

On Tue, Sep 09, 2025 at 01:07:28PM +0300, Abel Vesa wrote:
> The Qualcomm Glymur platform has the new v8 version
> of the eDP/DP PHY. So rework the driver to support this
> new version and add the platform specific configuration data.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 242 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 235 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index ca9bb9d70e29e1a132bd499fb9f74b5837acf45b..b670cda0fa066d3ff45c66b73cc67e165e55b79a 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -26,13 +26,15 @@
>  #include "phy-qcom-qmp-qserdes-com-v4.h"
>  #include "phy-qcom-qmp-qserdes-com-v6.h"
>  
> +#include "phy-qcom-qmp-dp-qserdes-com-v8.h"
> +
>  /* EDP_PHY registers */
>  #define DP_PHY_CFG                              0x0010
>  #define DP_PHY_CFG_1                            0x0014
>  #define DP_PHY_PD_CTL                           0x001c
>  #define DP_PHY_MODE                             0x0020
>  
> -#define DP_AUX_CFG_SIZE                         10
> +#define DP_AUX_CFG_SIZE                         13

If it differs from platform to platform, do we need to continue defining
it?

Also, if the AUX CFG size has increased, didn't it cause other registers
to shift too?

>  #define DP_PHY_AUX_CFG(n)                       (0x24 + (0x04 * (n)))
>  
>  #define DP_PHY_AUX_INTERRUPT_MASK		0x0058
> @@ -76,6 +78,7 @@ struct phy_ver_ops {
>  	int (*com_power_on)(const struct qcom_edp *edp);
>  	int (*com_resetsm_cntrl)(const struct qcom_edp *edp);
>  	int (*com_bias_en_clkbuflr)(const struct qcom_edp *edp);
> +	int (*com_clk_fwd_cfg)(const struct qcom_edp *edp);
>  	int (*com_configure_pll)(const struct qcom_edp *edp);
>  	int (*com_configure_ssc)(const struct qcom_edp *edp);
>  };

-- 
With best wishes
Dmitry

