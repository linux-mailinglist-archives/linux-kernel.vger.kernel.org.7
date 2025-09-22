Return-Path: <linux-kernel+bounces-827012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0169BB8FE26
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08F3421F45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0BB2FB96C;
	Mon, 22 Sep 2025 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qq4XOYHG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CCA2F5326
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535127; cv=none; b=Ly4EVrFkKT2sY5u98fXvBr0wcsS50wrZtPTGAP5vOGZCmQoiHiq9tZkIF/+vAqrwY7gB1rodUIqxWTtFS2iQ9p75UymxOFnmA3DSuY2vU0xdzAooYKkO1VE41TLWDhliDU9LhpgFggubuqunNhjifRHOY6Sb5jdqI9BzA8X3+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535127; c=relaxed/simple;
	bh=AsvAAT2u46FqG4eX0py+EYfURRCs48I+UGQOiRi3pRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIAuQOpwcjZm7LKG9EJkerMyLN42Ai51IaLuBoPA+JMza5XX8LLigykLq+QtAaZkK7EVvYppQ4+5rqmop73DXL2duDqh9Xca7V2ng2InIIGLOx9XQMNmjP6PMXobR6PKUWcYngGampH9CODPaQWcxGap28hvsgk4UD8ZLADIs7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qq4XOYHG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8iRPX007448
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IW9nZTpAUTWb9o/++g/7GLgt
	nAqVsaz6ptGNBZO+z5Y=; b=Qq4XOYHGcj5UjpfNhhWI+pS57JToMKI3A3wZj8UI
	e8VxbtMbKQqcnO3vgHJjiI1PtRXRLcdpXP8THPDyHLUVRfVFCnbLkmNwHpu89D86
	Tmx+/g5eHlLvK5Y+fdgcwQV9Hd0yvJ9Dm2vPkwNP6Eb3iblyKwO533H97yiCsNT5
	DjFscqzWPziW45E7jsvjglu4Eh0VVhx833W3X1UJFtZy7TbNCNrv0zXds+vCOiF0
	6OVB6ZsjxP+3gY5A2r3OnsuUzzWhe2z6In7YHB8EI9fzhifCEfeBHGnDJHLgswT3
	4DVBAqOwZYt0Rmw69CVPr681jEzwGz1pS0tM9EmEUndu8g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyemk4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:58:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ca8c6ec82eso17539831cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535124; x=1759139924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IW9nZTpAUTWb9o/++g/7GLgtnAqVsaz6ptGNBZO+z5Y=;
        b=RfkmE39oMbf3OrjRTO3GDWNcWyDdpTC0ePtJqqAQM7dectRm1eG0Xgl6jK75nC2QPM
         Ktiud3HHMwz0sw9I+HH6SIa59fG6XSWcw0koWfJ4cZnza8PwnKchnbgyeBkKbBU4BQtb
         9T5SNIVWENdL7xyLkxSWpk0SJjFI1ya+An/7OL5W85uWbm5C1II2lR4FXVoJHWHiUctx
         2H6RvPfEnuSIQleLatSXOiP7UAUYJm98V6KKuRDdPdyJ6zMdzMVcmizsjRLE+6jJioV1
         e9dmb9R+Kr4GB7jKf/2twVfX+LbBPDJtkOGi0WeqnhrjtN7Iv/CvGvsOF3qRefbo5zWf
         /q+w==
X-Forwarded-Encrypted: i=1; AJvYcCW3cSmTEiWhzkUeP9I7yKMk0Ef2wfTwr52FlgKtYOA4eDf7fU+QvECdUwzBuN1BjrAvicm0/v/bg1iFyO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysMZ67RWJM9gLhR4PfjmobHU/661qMyUt8+05l8gagmBaYxA0d
	Vz16SgFwOdBJsPFWpYftYaALcsVCaXf+VVXrvnMlU7KH6AEWo2OXLwPl6W6W16JNf6JuaYJCvRW
	QXL2Ezhn3SVF37L+ly+4iqO+x9uh01347PY9UGhMMd6qjCNxGS6YfDV2adXqTRE6E1mU=
X-Gm-Gg: ASbGncs4iaxb8oACgibjRTs/UR3Q+bUtrb1tjfOv/tAs6OES2zTwtso0IeczAt5r/V5
	CXsgBFScZN0P+OcnDE5kC1t8rzPWHJ/C+xBh0VUJBNzBfEa+n33NlJdL9K37Eo6TJboJ8/36lhP
	PCulbVaCfUs5lQVhytbTVVqO3jX1yogOh1W6nBm1qVs/ttjBcDQKbI9J3nj6ayIPmB/610nghyN
	BAJp+BXMEsLNrbx2tJoOnIQ8T+g0yImDZ/46QvwSEF26Kzs4BGpuhb3zAVVQR1TH48GTv+tOLfe
	hsF06Bc/CyPCAoRRsicHyGuEn5tgiEAbE7ydQXt9Rp2xdO2gzHI0bKPZzr9rM1PN8j6v3pOPeEV
	Y1UxpggWbBASiNbD/CHF12iBGcFjjBCM4d6A7nZXnpray7WtrjqLd
X-Received: by 2002:a05:622a:5c17:b0:4b0:edba:5a47 with SMTP id d75a77b69052e-4c073e88e08mr153125081cf.53.1758535124067;
        Mon, 22 Sep 2025 02:58:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZrkbJMOE8oi3lEYxkgH7mxWyV4vRf+Ti294a6hd808l4xFyp1mQDl/IreW2vbGpM6xLJBJA==
X-Received: by 2002:a05:622a:5c17:b0:4b0:edba:5a47 with SMTP id d75a77b69052e-4c073e88e08mr153124541cf.53.1758535123374;
        Mon, 22 Sep 2025 02:58:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f44b29sm3181298e87.24.2025.09.22.02.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:58:42 -0700 (PDT)
Date: Mon, 22 Sep 2025 12:58:40 +0300
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
Subject: Re: [PATCH v4 3/7] phy: rockchip: phy-rockchip-typec: Add
 typec_mux/typec_switch support
Message-ID: <75xs2vy4pt7c6qtc4tmk6j7jdh6hdmbz73pkbv5e2ndid2gj63@nla3q6qdb43h>
References: <20250922012039.323-1-kernel@airkyi.com>
 <20250922012039.323-4-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922012039.323-4-kernel@airkyi.com>
X-Proofpoint-GUID: pVxFiqCpB52WKtHtLavbq4OvI5lehhAA
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d11dd5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=E19HVUzDLkS-Nl9glC0A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfXw8Jt/m7NSiGG
 gayuaWnAzH8xsOlyS6QyuF0H9DKWociPO/TRE855EfVbKvv1NBRAMsN/sapgyE8aJgvJ0sno+JN
 AjIL5QJDNDJp+O5fyttS0fEdn6qvPhKy+aGfxkzPBjaypbEi6D2WEYco7Hy1+3Wjfl6YtVqAm2e
 TEpOXxAQWclXz2vYe4O7wEM5kpHMkvI+yZSHBo+uN95dgtheJQlsc4iHFEEzWG3zbnShJ6fliMP
 wDPDWHhgNYXRaJC4CgunL+ga12uZqOMaunLxMelM7VUehBk3htdlGtzsoiu69w6oX0493djVBAR
 dYiQUh4Mw+Yfzvd4SdFwPybGWeKF3l856FJfC+pOTXTguNnkS9k8mrBE9S8Uakxk19UYR9+wQFy
 ru9j7Gba
X-Proofpoint-ORIG-GUID: pVxFiqCpB52WKtHtLavbq4OvI5lehhAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

On Mon, Sep 22, 2025 at 09:20:35AM +0800, Chaoyi Chen wrote:
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

-- 
With best wishes
Dmitry

