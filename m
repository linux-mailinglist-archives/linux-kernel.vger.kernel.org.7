Return-Path: <linux-kernel+bounces-849218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AD4BCF886
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7D4F4E314F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 16:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA3027F749;
	Sat, 11 Oct 2025 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CFtwP9Uf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AF7DF76
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760201835; cv=none; b=sYs8MhjjNZJvKiEVJCdKDBfkRAZHEJwVaDR4PVfVo4ozqsN8Z9Xfmqw2mrM+h0jMh6x9hGY3GjfW3PgvUC8q0MWAjXIxMm149jTymlbNhuCfZ69mmIF6OlOb1EK61PdKv4RBI86NAX+JHf2951FwVoaRZnnoR4oB3xdO0xs8coI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760201835; c=relaxed/simple;
	bh=ubZ5obP2S7YNyso0NYRC7HlWeEc/ItiPs3nfk4GVzyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7aY+76HLnm015Bhwkc2DpaiZUEudBlEK7VJntPqGClpFU9ouAZO+dSef/wQhh/iWc7bekATIXr8jBezlyLG1ivHWsTmOK/XGuN3XON2naN0Qc7jRj1X5meflx4Hu7R03XvoJBGe5z5/bRc04PxcrsmIN7fUf2j4HQQK8C5/e1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CFtwP9Uf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59BE6fdJ006474
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 16:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Xy1TDfM9Hn+Ss3qcAnJ0/lo5
	9/hSSLBS4fspMrOt/L4=; b=CFtwP9UfiZHiCGMUOw1deU4fP4xpIF+oTXGJDPPE
	tIL89PvjLtTf/YbkszSYepRnEDxvkn3PVliVw4u4TAkGO3LUgC/Q9jdUNZLTdGwo
	gmqHB9xnY0fbHRymvvggtm+gwEPtfxmvem0N1+J5zGWuk/yAZ8j913d3wv9kfqCu
	znuNTU5DIfxEgKNV/JyFbG1dm0iQ8kEDixgK4WteCdzXVvJp/OSPlJHWMT3v+R9/
	ROSpe+5KfOguZ+K4VVqtIUghzCUQklTR8lLvDJ5jbRIERbz+7G+oGIRc8RvjdGJl
	wqvtgyUzuJ6JXTrmQZv4RdlrXbiRL+GtUJw8xbEOEC6jEA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdfru3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 16:57:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-854bec86266so929677585a.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 09:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760201830; x=1760806630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy1TDfM9Hn+Ss3qcAnJ0/lo59/hSSLBS4fspMrOt/L4=;
        b=xAnXPa8NBX7wlr96m9MY1gkm11AAm/YAML1v7JzKERSNHztx7aCbG9W/3aRwxriJT9
         jE+9Y0PhTpwzIY1qRwWX6UhsYje+bNZZYrkCGOkmrmDcFCzZcQ6tcni/dw+r3WUpDyTs
         AI/OQ7dPLWK+IrE9fJiyTO+osXkSiuaxAxgktIwNBO3bc/faPV0SRnCvp7sFL1Wlv9Bs
         yXdy41KBI5K5LVLJHyWDJigfQM42v6o2m63F1Uqm1jJsWVg94kBharv2sxTO6Mw9v80h
         NZ1AjuVlc/Ot+Qy+zPts20eF2mkmSpRZpmOcQ+2CJsNSKvxt6QnQ2IAae/Xow4rUovSL
         C+LA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ14G7EeMUoDDUIsXYv6ky4QriRERubreZjuT8myDFgL4EPEPQDilNDfph6kb7vNuwWGzLlaq+JwpUg8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAHCuXmfx+6BRkL/BGqYIjiGiaoIglKTh/hElI7D6XZ1S3ZHn6
	HXZZlz0DmzNFKzmihhUnZ7wrsE0RLbnn1eQ1uQDHTmVEadjKjoiIPfIXLm+WliwJIUbJvLWLt9s
	EHV73sz+xbVjWoZzJCF6QgkbbiaB8g5DpDC0/SszPPxA5gMJQkBVklXbgrhHUf/diolU=
X-Gm-Gg: ASbGncsFC0jHETziCWg5kI6z2zerPkrE2/6MPC35dAEbYkca44PyCfrhsDezQeWMqho
	DIQMF/kbLPxQLQWz54WJHtVrBPrtJ90LbzQTQep8ds1H/fk/YZOBN4V0Yebt9TRT+jOqQakxkLO
	6afs3Cbg/gsjf6jPsTPNosQqxwxYevrx4MUfOtYm1gPWWRt/kNErF2yaFOKJxriU6yPYdjUsr3v
	SB50LfgxSTvVkd+APT7fKUOhQDS9x8uf3NBUaeaZe0gJczIqJ2HgPCSNbet1YRVY6iB9sjVU2Jl
	ZLIEFXgmBDIYOLOiSKXoSQdjLaqW2NO0I1qYAxYWfWnXpVxp/3QFShSSZb2iVMU0lAx7XhYKF/B
	7SD4arO0i0FYt1Zge453QtDEZv5NBibeAN4BoSrCA+uKRaBDDFROQ
X-Received: by 2002:a05:620a:7116:b0:85f:82c1:c8b1 with SMTP id af79cd13be357-883525c06e8mr1943889985a.46.1760201830224;
        Sat, 11 Oct 2025 09:57:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkyWtOfdJ+0TNDoUMTrOlJySqi8eotm+EQmXbUDmQfKpz1vM/MTeAx4339cLuXyfh1vmmWVQ==
X-Received: by 2002:a05:620a:7116:b0:85f:82c1:c8b1 with SMTP id af79cd13be357-883525c06e8mr1943885685a.46.1760201829687;
        Sat, 11 Oct 2025 09:57:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088577f2csm2081972e87.107.2025.10.11.09.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 09:57:08 -0700 (PDT)
Date: Sat, 11 Oct 2025 19:57:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Yubing Zhang <yubing.zhang@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Amit Sunil Dhamne <amitsd@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaoyi Chen <chaoyi.chen@rock-chips.com>,
        Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 3/8] phy: rockchip: phy-rockchip-typec: Add
 typec_mux/typec_switch support
Message-ID: <xbblw4jfte7re2pyroanvzqv4ddwhxbgcui5ubpnw7rwuo4s4d@gkph7jqzf33o>
References: <20251011033233.97-1-kernel@airkyi.com>
 <20251011033233.97-4-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011033233.97-4-kernel@airkyi.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfX9JdTxCDe9pI5
 eRMmenzfvVA/BfOcbKxKAnLGlpWHMu5LZP/KdWqX7D3bkKDAyyycZfdLXTSVSjGJRfY7NXwLTh3
 qq7vuWLHdSGbMZIX91xLRcnroiE1Wsn7qJCs/M/wIVV74SluTmYQSQRzZ1imnYgmrIJO/+KI4HG
 rqyG6U/wXaiJ0oaAQFngLekmKY0UFnuEJsHyAsB0dk7OvOFHDMSorjbvUqDX/oh6sz+8d4+Khuy
 jOZ7lJq2Gp5v34zszu8amvNSM+i5ZNcikUmmEFKAgkQAvWZVxUone9dPOPCkSH6FGPUPJhz/UbL
 xp6KWV6lval/RW00tpMQT/YBMMUNh8B6dSxDwXFrn1Ohdin065j93SLhI4//ZeboHACPctsXIt1
 uhCB/pzpEEVMxSdLumIJIqgEuMgeDA==
X-Proofpoint-GUID: UCq6Y-3ZUCnYpCeALst711WywaVho1u7
X-Proofpoint-ORIG-GUID: UCq6Y-3ZUCnYpCeALst711WywaVho1u7
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ea8c67 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s8YR1HE3AAAA:8 a=MMthkAsgp7NQWkXk_3cA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-11_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025

On Sat, Oct 11, 2025 at 11:32:28AM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> This patch add support for Type-C Port Controller Manager. Each PHY
> will register typec_mux and typec_switch when external Type-C
> controller is present. Type-C events are handled by TCPM without
> extcon.
> 
> The extcon device should still be supported.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
> 
> (no changes since v5)
> 
> Changes in v4:
> - Remove notify DP HPD state by USB/DP PHY.
> 
> (no changes since v3)
> 
> Changes in v2:
> - Fix compile error when CONFIG_TYPEC is not enabled.
> - Notify DP HPD state by USB/DP PHY.
> 
>  drivers/phy/rockchip/phy-rockchip-typec.c | 365 +++++++++++++++++++++-
>  1 file changed, 349 insertions(+), 16 deletions(-)
> 
> @@ -850,6 +998,72 @@ static int tcphy_get_mode(struct rockchip_typec_phy *tcphy)
>  	return mode;
>  }
>  
> +#if IS_ENABLED(CONFIG_TYPEC)
> +static int tcphy_orien_sw_set(struct typec_switch_dev *sw,
> +			      enum typec_orientation orien)
> +{
> +	struct rockchip_typec_phy *tcphy = typec_switch_get_drvdata(sw);
> +
> +	mutex_lock(&tcphy->lock);
> +
> +	if (orien == TYPEC_ORIENTATION_NONE) {
> +		tcphy->new_mode = MODE_DISCONNECT;
> +		goto unlock_ret;
> +	}
> +
> +	tcphy->flip = (orien == TYPEC_ORIENTATION_REVERSE) ? true : false;
> +	tcphy->new_mode = MODE_DFP_USB;

Carrying over unanswered(!) comment from the previous series:

I don't think it is correct. Orientation defines only the cable (plug)
orientation. You should be getting the mux events for the mode
selection.

> +
> +unlock_ret:
> +	mutex_unlock(&tcphy->lock);
> +	return 0;
> +}
> +
> +static void udphy_orien_switch_unregister(void *data)
> +{
> +	struct rockchip_typec_phy *tcphy = data;
> +
> +	typec_switch_unregister(tcphy->sw);
> +}
> +

> @@ -1037,6 +1251,89 @@ static const struct phy_ops rockchip_dp_phy_ops = {
>  	.owner		= THIS_MODULE,
>  };
>  
> +#if IS_ENABLED(CONFIG_TYPEC)
> +static int tcphy_typec_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *state)
> +{
> +	struct rockchip_typec_phy *tcphy = typec_mux_get_drvdata(mux);
> +	struct typec_displayport_data *data;
> +	int hpd = 0;
> +
> +	mutex_lock(&tcphy->lock);
> +
> +	switch (state->mode) {
> +	case TYPEC_STATE_SAFE:
> +		fallthrough;
> +	case TYPEC_STATE_USB:
> +		tcphy->new_mode = MODE_DFP_USB;
> +		phy_set_bus_width(tcphy->phys[TYPEC_PHY_DP], 0);
> +		break;
> +	case TYPEC_DP_STATE_C:
> +	case TYPEC_DP_STATE_E:

You need to check that altmode->svid is DP before checking for these
modes.

> +		tcphy->new_mode = MODE_DFP_DP;
> +		data = state->data;
> +		hpd = !!(data->status & DP_STATUS_HPD_STATE);
> +		phy_set_bus_width(tcphy->phys[TYPEC_PHY_DP], hpd ? 4 : 0);
> +		break;
> +	case TYPEC_DP_STATE_D:
> +		tcphy->new_mode = MODE_DFP_DP | MODE_DFP_USB;
> +		data = state->data;
> +		hpd = !!(data->status & DP_STATUS_HPD_STATE);
> +		phy_set_bus_width(tcphy->phys[TYPEC_PHY_DP], hpd ? 2 : 0);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	mutex_unlock(&tcphy->lock);
> +
> +	return 0;
> +}
> +

-- 
With best wishes
Dmitry

