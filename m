Return-Path: <linux-kernel+bounces-826977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11178B8FC78
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC19918A09C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253452874E9;
	Mon, 22 Sep 2025 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bQdCtVh/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62D267AF1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533952; cv=none; b=o9fTSh8Vo8EQomCdAM2f417DS1VxPV6jbSd8xxWpd5re0LKmE5lMviHzjMAruRRS9gzFhXIpVbHWydtSpgjrFO3CgUnEw6HKGNnEkrYTavKWHd62f0G93WVD39vbvn0B0Ku16D18BskwsXHhX16s91cJMi/9DQpjjrIp7I6zlsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533952; c=relaxed/simple;
	bh=sYuFd35lcDhboPlpjlFr9bmZUXD05YmQrZz6vSdnrNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvKQ6B8tEKpg3WBpRDjo4C6jHepHnHdtIPfDWFa0xeASieHhVouSfUiIuW83+3D+FKMguk+G0rzXyR77lx0EE31ekvA9cfLsGcFtpqiGwjhLWwE3v0TvAyL6BLgLSwRB6JMunN0ZDyg9G/njNFvgxz/+a4CMhV2jHTNeA+Rrz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bQdCtVh/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M910FS023481
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jAx4FwcII6wbkb81OdZIPAi0
	xEvtze7qSPUTGq3+NiI=; b=bQdCtVh/6lGcmYm68OuLAMQHtqjheTJb/MMDTuIX
	knaM7VoUP44mrC3gDXYoNCsEzXPscI1MZ7D7s148GWcdxu8MbQd52HClZyWrVhXx
	mPxQ694jTIsDtrMxgrZ2vCjs0jyqW969j2NmSkqHohKGPjs/ZnYdQ8tmDB9tykzB
	7ZePQjlB33JF3CSz90w8xKrS3jKxF3sBEMcsEnEku9Fm0Dh94yW9t38uEXA2jnxA
	tUp6j/Otyf6HLRHGskP+gM4t/5fTeu+dFYkGl4+foWuRoMGpVj68W9RCMqMYUdwN
	J/T0bVU13J7x5HAOe7J8O56+q/T3+66SB06In7YYNCEjlw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn7c8y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:39:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b4980c96c3so152020371cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758533949; x=1759138749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAx4FwcII6wbkb81OdZIPAi0xEvtze7qSPUTGq3+NiI=;
        b=o7R2rdNm7beGQy6YxF9XY8bHLxRmu4ZnnF9UvTX8XksnQM08MM+QHYXis3Txl0QDh9
         jY7aNyWDEkqPc4IGa7dXmMyCauu8y8eRjW/0HcvCJs4liaRlfFXI/G9OAn76FNppz66v
         v2a3wwtGm05WDVuV6sKILCY/n93mF9yoFMlhKVUNhE33Hw+ihuwhLi9dtiOPEL946AeZ
         vxp9ug8/QsOfrdYIA9/qwzU3kbdio11chjwSn8SLiyAMj26mvNqISjkhAqF4bGhy4oLs
         B4qOwwYKPGN79oVUX+t2rLV/bzImixIYjGna46My3IbqU78nWnClBak4Y3Ge/046rwN8
         HiAw==
X-Forwarded-Encrypted: i=1; AJvYcCVfXTgAAAZmf1/wXX/QlTSTs7tipsjcokbzZxWOWgU5DEYmjTBmSL1iuU3gU83rlhWcu3or7+UTAIgJhZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRXKEqodm3Cl85/m8bUCAvXPEonGoPk+OIONozovBfXhjbOJsS
	+0cYv6h2NKs95TVfwOhYZYQWSSR7kvBvGbodhg+g5W/my0pJWcGQ4HRwUW9MPEvSaZ+IAWD+Uwd
	G8wZgxSCaYIoJ+eIcOoxWFvRF2VfLXNhdShvvXD97ccPO5NDSZKazUIQwzeBfVGrmU5Y=
X-Gm-Gg: ASbGncsFn0PEiWkPSdBLceRXeG2jVdqXV6k+LCiMoNPXJst/oh9oFtxVzAcPrNVOy7x
	mpydkSU/0voQlFk01m9hC7EteaUr1Jxvl6ibN0T2RSLiPGzti5BVQsV34uxoETBPzEWYrINTUz4
	DcWAPtmhiCI4chB5KP4jUCZfs3rV1T/vO2BidsUI8gjrtmq1yVjkrUhtX2O7T331kpxt9k4DZCu
	4FsR1yde4Lv/9cJDElSgM6UqU2c5lbXuSMF/6u0ynpMdhVL78Hb788TqRHjc7Jf6hiJC/PBp7sn
	3gDFdksJFPEIqgW07FxVAs0P8oQK+Hz02g++hJT95GwDt8E50EJeHUlwheNqWoQ2sqDJbyDpD+1
	Bu23wAEY7ei73fscmaUJCHcUlXLYVfpHcFjI5gnRhPgw2BI3gTOMa
X-Received: by 2002:a05:622a:143:b0:4b5:d60c:2fc8 with SMTP id d75a77b69052e-4c0734ea370mr157007771cf.71.1758533948698;
        Mon, 22 Sep 2025 02:39:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE35/RYNkp6gQyQPasMu7rVuD0sFyNJP9oENTXh4ze2R7ETd8aNwunTy76/33FRan7WDLixdA==
X-Received: by 2002:a05:622a:143:b0:4b5:d60c:2fc8 with SMTP id d75a77b69052e-4c0734ea370mr157007381cf.71.1758533948134;
        Mon, 22 Sep 2025 02:39:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57b78577636sm1624019e87.80.2025.09.22.02.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:39:07 -0700 (PDT)
Date: Mon, 22 Sep 2025 12:39:05 +0300
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
Subject: Re: [PATCH v5 05/14] phy: qcom: qmp-usbc: Move reset config into PHY
 cfg
Message-ID: <z6x3bwb7izywozeran5aq64uw4tiwlbwx4kekoy3vv3vt7qyip@2ibiat5focw2>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
 <20250919-add-displayport-support-for-qcs615-platform-v5-5-eae6681f4002@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-add-displayport-support-for-qcs615-platform-v5-5-eae6681f4002@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX262lNW7c/Nkt
 NG03AqJdQUQ527PL39ZipykGftAwBKaQmM/Ru1BHPSDR0uG1lgtF5BdtxKuepIb3Jit7ugJFAu1
 gTL0PUatxXPXdGnax9ax4SGfcHfVQ9c4IDOrcZ6flcpWHDiyJ3IiZqGT4BEUPR4g/MeY+oDbQIR
 diDpoayXA8NlZ4dGTVOm6Yc4DNSIA8bMC0fW0VKjXcD5ApQK3E6hAUBIWJ5ftFIZui5DXZ+CzDx
 6TBxs5NE0rqnHlSL69ywd42mYEUKi/f6JnFPnhS7Jlx1QKhiQxvDCSIXttu4RWWObvJBkYujDKU
 SE0QqGe1ifR7Q6j0GAbwx7OhhD3lFmvljtdCzIjD9gjRJIQw2RzkID4zf3hZlSB5nto5qJvWkyL
 AaUFnmBx
X-Proofpoint-GUID: lixIITXWRpEL1w1xV06dRvisXlZZjo_P
X-Proofpoint-ORIG-GUID: lixIITXWRpEL1w1xV06dRvisXlZZjo_P
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68d1193d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=RqUhitWEW_Btmly2q4YA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

On Fri, Sep 19, 2025 at 10:24:22PM +0800, Xiangxu Yin wrote:
> Move resets to qmp_phy_cfg for per-PHY customization. Keep legacy DT
> path on the old hardcoded list; non-legacy path uses cfg->reset_list.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> index 3b48c69f9c3cb7daec495ebc281b83fe34e56881..3d228db9ef0882eb76e7ab9e82f8122fa9cfe314 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> @@ -335,7 +335,8 @@ struct qmp_phy_cfg {
>  	int (*configure_dp_phy)(struct qmp_usbc *qmp);
>  	int (*calibrate_dp_phy)(struct qmp_usbc *qmp);
>  
> -	/* regulators to be requested */
> +	const char * const *reset_list;
> +	int num_resets;
>  	const struct regulator_bulk_data *vreg_list;
>  	int num_vregs;
>  
> @@ -428,6 +429,10 @@ static const char * const usb3phy_reset_l[] = {
>  	"phy_phy", "phy",
>  };
>  
> +static const char * const usb3dpphy_reset_l[] = {
> +	"phy_phy", "dp_phy",
> +};

This is unused in this patch. It should go to the patch adding QCS615 DP
PHY compatible and the rest of the config data.

> +
>  static const struct regulator_bulk_data qmp_phy_msm8998_vreg_l[] = {
>  	{ .supply = "vdda-phy", .init_load_uA = 68600 },
>  	{ .supply = "vdda-pll", .init_load_uA = 14200 },
> @@ -464,6 +469,8 @@ static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
>  	.rx_tbl_num             = ARRAY_SIZE(msm8998_usb3_rx_tbl),
>  	.pcs_tbl                = msm8998_usb3_pcs_tbl,
>  	.pcs_tbl_num            = ARRAY_SIZE(msm8998_usb3_pcs_tbl),
> +	.reset_list		= usb3phy_reset_l,
> +	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
>  	.vreg_list              = qmp_phy_msm8998_vreg_l,
>  	.num_vregs              = ARRAY_SIZE(qmp_phy_msm8998_vreg_l),
>  	.regs                   = qmp_v3_usb3phy_regs_layout,
> @@ -480,6 +487,8 @@ static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
>  	.rx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
>  	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
>  	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
> +	.reset_list		= usb3phy_reset_l,
> +	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
>  	.vreg_list		= qmp_phy_sm2290_vreg_l,
>  	.num_vregs		= ARRAY_SIZE(qmp_phy_sm2290_vreg_l),
>  	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
> @@ -496,6 +505,8 @@ static const struct qmp_phy_cfg sdm660_usb3phy_cfg = {
>  	.rx_tbl_num		= ARRAY_SIZE(sdm660_usb3_rx_tbl),
>  	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
>  	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
> +	.reset_list		= usb3phy_reset_l,
> +	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
>  	.vreg_list		= qmp_phy_msm8998_vreg_l,
>  	.num_vregs		= ARRAY_SIZE(qmp_phy_msm8998_vreg_l),
>  	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
> @@ -512,6 +523,8 @@ static const struct qmp_phy_cfg qcs615_usb3phy_cfg = {
>  	.rx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
>  	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
>  	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
> +	.reset_list		= usb3phy_reset_l,
> +	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
>  	.vreg_list		= qmp_phy_qcs615_vreg_l,
>  	.num_vregs		= ARRAY_SIZE(qmp_phy_qcs615_vreg_l),
>  	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
> @@ -1051,8 +1064,7 @@ static int qmp_usbc_parse_dt(struct qmp_usbc *qmp)
>  				     "failed to get pipe clock\n");
>  	}
>  
> -	ret = qmp_usbc_reset_init(qmp, usb3phy_reset_l,
> -				 ARRAY_SIZE(usb3phy_reset_l));
> +	ret = qmp_usbc_reset_init(qmp, cfg->reset_list, cfg->num_resets);
>  	if (ret)
>  		return ret;
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

