Return-Path: <linux-kernel+bounces-742390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BA6B0F110
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A15217D751
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3342E427D;
	Wed, 23 Jul 2025 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZxK2IUO+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8A5298CA5
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269706; cv=none; b=amkyblWGR2/6xxqgCEYMrwrZ47Pqq5GwCNbjS3Jm5IRH3iuU/EJnBzA/VTqIQUFcZibOHNkOnwUi05iSeZjokP3wx6J4p1ZHV7H4zQMKLkubwgSgHsUBJ4q7qyv98hYlgIa1xb9YB12uL7oAhSGRaVwVQG7rqO6g/5Flc6yk6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269706; c=relaxed/simple;
	bh=xiHjPoZ1Ch+WHyK1NS8LeVxkzMAb19jum18ZpdtDhw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HElr4vIxlHvOLwyv1MfI0gIpN4Dg+fMZj+lOvwIPOinrUXqT/QqIGVY6F8ovGUQ4ZE97sI87BAL6/RVjoIZMibMIit202SrIj7kBr4OqTQqJF7D+5Y1NVcuh7qgt7FzKyz6gxeOCbaXodDssGF23U7BQUeFHPuABrk8iunVTL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZxK2IUO+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8xiGQ008190
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2+gD+y9pyiuUumkiPvbz0Pru
	9JWie49LumrPX7GQnkw=; b=ZxK2IUO+0YFoi5xXH+EbAoHuWmBBG25g0RuJ3M0R
	WUZ5xc+1rwleMgRso6KHrwlowF7twXbEEAxYFFRGHcxRs5A/4BHVluKpD6cmsMOu
	eSdECwsAdSaFLC+rWhZS2EHTIVZdZy1K1eS13LbouNx79qt97GCdw5fGUxHcjNUM
	6MDR3pEwkVpXP1280dd5AFLONIhnuWECO4C/d4moBnERpj6XHoGibU8Dyk2Q7NZP
	Ozx3sY3JGONNsw5zoUq10mIklh9tKFsBnJBTnuLfZWRcpICx8pt0XHUjFjip4CNA
	0P90ktKRo8tofabzn/SgpqilMGABCAcTKsnGsMnb38+Kqg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3htybm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:21:43 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb3487d422so99482346d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269702; x=1753874502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+gD+y9pyiuUumkiPvbz0Pru9JWie49LumrPX7GQnkw=;
        b=WPxEspQcoJGbUzyZIGFCWxik9LzdKHRD4O41KuBquu//vggIq1/nNp2mXQ6suNEino
         bxwCtp94K8EnT8fd0E2L3LYTbyiknhT8Kz23h0EqcW9HS1s5vyKnXXjun/fNFExWmH0g
         c7JRFVtbrvFxeoqCijrTarvF+Io+O/8LiYzxgZ2QiCaNLa4kO9UPR4EO+oueRoBshq3D
         2riUoSOEsutQ5Y/Uo0VnWc3Zg15eeCpSPzyJN5JeBnAsEvftmRUFxXuTOY/rbTRkBZ+V
         euim10fufv4NbQzogI8qJhijZlQsoKVr3+aQPHKakLi1ehH+x2VOZvXJtQ4A9djDQweP
         Qirg==
X-Forwarded-Encrypted: i=1; AJvYcCWtmDA+TwHZgxHCHs2PxNFsa9G7UOLX+xabF0BVhIT/3jerfiYJZ/YNM6Wz2DMg7RjgQSa7IuEVA+KHa+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgFkb3xKcLgck6+VBCsavvV10C5MOQ59Zpg+TQWAsLEg+1ms0
	HDMaQJ2Wn+yGjKxUQV/PTSe888Y8hhYrzCq3LCS2FRtMp+G1OnjATXrrkLgo47IIyi6EIokWEIR
	31v93bpmIUxZd00uc1wBCgP7vpGhEdJpmJJfhqSZ6OM7Lh+06bmJqqWrvaoMjRkd7oIlufYIUHY
	g=
X-Gm-Gg: ASbGncsKrFMsULgYPfTq5fjTu/5oQKspsTN4Mv0NbgHjoOtVuOFcJYGnDgwwIAB/hQZ
	1gbRVxcG8Ta7+hRlPGx4+4g0KNGW5KvHNIg3lo7tMSmvb8QH0gvluekN+DoqvGjkvDMylkpzU5h
	T3+lh5GWZ+EvXF5h1S/y8rS7CyBzoqZjG0rPdiH3Adpa1/ZexMbsgG5WhMPrxpu6OV7SZGRPcY8
	cvoZj6wgkmFQZrvUYE+SzhEBtbGhkptOV8cHnkOhItYafb/1oXjzL1bXNxeaE3cq47vAM7k9B0J
	CUhc2XLNU9HOGKT5LB5xJdAo3eOtlncAbZWECUDFidOhqCY+x+xZmzAtQCBfzyF+SCFkX08MHHR
	zI7cS3B30nk8fMqR9yKuq6DdihdPhJbFlwxVb28xahO7iujI6al4D
X-Received: by 2002:a05:6214:529b:b0:706:f753:6b1e with SMTP id 6a1803df08f44-7070058f7c7mr37003866d6.18.1753269702384;
        Wed, 23 Jul 2025 04:21:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/jRwjTFDhjdTQ6agzavI4ZAmFD7F1mUk3/N3mbcvr6gWVlMoJQxSTH/nLA14Ob6QuV9j+zw==
X-Received: by 2002:a05:6214:529b:b0:706:f753:6b1e with SMTP id 6a1803df08f44-7070058f7c7mr37003456d6.18.1753269701946;
        Wed, 23 Jul 2025 04:21:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d7c7d0sm2238663e87.121.2025.07.23.04.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:21:41 -0700 (PDT)
Date: Wed, 23 Jul 2025 14:21:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: hamoa-iot-evk: Enable display support
Message-ID: <6wwcxwgcf4wm4ekb3d4ukkyyqsseaawo6l66umzxim4kcilynm@fc6mwj6ymnes>
References: <20250723-x1e-evk-dp-v1-1-be76ce53b9b8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723-x1e-evk-dp-v1-1-be76ce53b9b8@quicinc.com>
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=6880c5c7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=FtQQbC5FwJ0cWtqdlLwA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NiBTYWx0ZWRfXyxbyJkbVDIaI
 L2UvRo0alB4nCvcGLd+Uk39+pnU3twulMWXnkIXwkVOPnsMox7gyebH5JsST8+hHnLyZVG5+E/B
 VzWSYHMQgQ71iSlfLb9q03M/8X+DyteVzZioIgBCvck5xZso20pWaGbDJ2K92aNxIYeSU2BvlVn
 OLB+L8hA307oeuhbJRMjWGizR20SsxfQ5jHX1LOLKeQVyEiiAso4lkvHeYc0/VVB5wSND+omhsi
 NF/dzWhmd5XLxNanNweYzXuS7UhmYEp61K0UEU3MPF0tZ8SOdXddnas4ig87IlE1KqBND++mB4N
 SI72al4rLraqbk726bqniuQ3GUBashizUBoTZwT04qylwF3TgsskIs0HziW6hQDk6RQTTi5TX98
 EsvUWuu0iOESeMuG+SNZrfFaNsHxEm/6lD8586AgLiq4ThzFM0bplcY9FVmC1+QyvWJWG/kZ
X-Proofpoint-GUID: PYCKbLid9ZtK14pBjd5qy3vfdRp43TAX
X-Proofpoint-ORIG-GUID: PYCKbLid9ZtK14pBjd5qy3vfdRp43TAX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=974 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230096

On Wed, Jul 23, 2025 at 02:14:55PM +0800, Yongxing Mou wrote:
> Enable DisplayPort support on all three USB-C ports of the
> hamoa-iot-evk platform.
> 
> Unlike most X1E-based boards, this platform uses FSUSB42 USB
> switches for the USB0 Type-C port, while USB1 and USB2 rely on
> Parade PS8830 retimers for Alt Mode switching.
> 
> Support for the PS8830 retimers was already included in the
> initial DTS, so this change adds support for the FSUSB42 switches.
> 
> Due to limitations in the USB/DP combo PHY driver, DisplayPort
> functionality is limited to 2 lanes instead of the maximum 4,
> consistent with other X1E-based platforms.
> 
> The platform also supports embedded DisplayPort (eDP) by default.
> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---
> This change made top of initial DTS:
> https://lore.kernel.org/all/20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com/
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 156 +++++++++++++++++++++++++++++
>  1 file changed, 156 insertions(+)
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss_dp3_out: endpoint {

Add empty endpoint to x1e80100.dtsi, then patch it here like you do for
all other DP endpoints.

> +				data-lanes = <0 1 2 3>;
> +				link-frequencies = /bits/ 64 <1620000000 2700000000
> +							      5400000000 8100000000>;
> +
> +				remote-endpoint = <&edp_panel_in>;
> +			};
> +		};
> +	};
> +};
> +

-- 
With best wishes
Dmitry

