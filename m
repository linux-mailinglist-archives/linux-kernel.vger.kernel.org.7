Return-Path: <linux-kernel+bounces-745708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C71B11D58
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE7A1C87A83
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8D12E6D05;
	Fri, 25 Jul 2025 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RqFT9LD2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B4424A04A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442136; cv=none; b=gj9vZzl1Qlw9+jNVY4P+zKMYjjmVayN53Hw1Tw5H4Qzm//0F3HHU03FuJDeH8ietI5LSHkTRU/sJOeZch6+RHYNQ6AXqLhAq4tepVugLHejJJPnA26f5gHI+ECf4W00PeZfuYX+rolLFDv/ZbvY+3AO+LFPmYIi7g2rrw9zj4fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442136; c=relaxed/simple;
	bh=OSeqncM2dX7fMfBZmA+0l06FrlB0CNn9hMzKvIZiRvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv7adjiIv7fHQWqFuuWSEVfca/Us3KDdt28G8UPkq5bH17tpRmAYkpQlf9uzqIeM64P5QnT7ObxytCcjbUzEBNMPmPAWhW1PTyIQIcxbZmnE1lOW2BKHfBn94I/+8xL8OIwzYTBZTWQSvbYTDDGvCwWrcBBnfrRKWSw4mfnPNOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RqFT9LD2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PAXZeM000775
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+d6fz0EHEv9D/K1jXUDJQkWp
	0TaHWL+EOqiDWQcysec=; b=RqFT9LD2k3CtCw+OeO9+pL23DKl3w0JrfG0UY32L
	bJ/qJAngW/YP7HFppZHEr2fHRD+egFn8wazcfL20XcrPgS5CBJJd9o3B5+vf4a63
	Ok0p2w9NVSR4DL9SiZO2T0joiNBB+onBdfwq9grdFIBk/U2v6mtLx31wr99yD6VO
	50vTPvFrD9HMMURtjhpjXjn2fdI2ioi+ZQit6WBCX88gLRDWfH15jUlXRFlU5tPm
	d8AnyQnncv9z9LKuTeiy6YW9SR8I/FV1CARdvVMlfwwrtNxqxFoiX283/0MtPPFo
	Y4/Jc1BbTqylONL3lNN9F2XEvyev1Dp/bKk2gFMy1Dbh7w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48489703mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:15:33 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb01bb5d9aso31110846d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753442133; x=1754046933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+d6fz0EHEv9D/K1jXUDJQkWp0TaHWL+EOqiDWQcysec=;
        b=UrMCmhwVAknJ9oJqn+JtK2dWBf65ybnPyYeid9jnlNLr56m6U49Vo5jLRZWeFXygMl
         y29eAmTAnZaGk4eklaZuPnE3BfHOj1huQp8RW/zbIqfZkHS6iYI955KY8Hn8MQq4phZV
         j7Q/lvjVDi6J3va6rFq/SKP/nLT6wcYQlkVZYOmzNp6K2TFKEit+CND8yBVGkqB0w60Q
         JT2Spg+RYyW1IEEFl/a7J2+UCsD3NT9X6qCymBh4eReIMk5g63QqRZmZUDpjcebn/TXq
         41K0sGdJ89+uWvAD5AfT6D7iqJL7fGykN3vVz7fQ7iPRcViNGBetH6RALRigVEAiwtVO
         y7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf97sZWcD8QmmJ4baU0hMgKAlZCZ3/fYNIxpcLw1+WLic6nj1VCSsOCPE88RyaEJfKLtk/b93Zrpe5Q/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7PDC1uVMsUYW+VF3AxK20geUv3kbs1TiDDle7Wbp63ybQF5FP
	xzS5+5aAMz3UOuZr4Ana7swaBfDfDwXHKs+uzpXANLHQN44dWHkuOr/hxa413ewivWyNLpChTTX
	gBmZYAuJqBtArmQwuyuqv2q3d432sXb6FH4Du+xL+f6iD9MWBI0rL9+Gyk9/ybjUhUnk=
X-Gm-Gg: ASbGncsNF1bLOXiSJsYCn8Acq55fOLqn2rckYJTcA7qzLa4s04xy9jW2FDC1A7zUwUH
	FIGjcK5E0otUMatIS6LCaLL49sUCX9q6hc4bCRqxknE60KzegEMPxLifLHscAjqklRYRzkXjNsS
	/UMBItTETVKr307LtpcO3ttIq5/QpTXPK4bSysbIY08peppqb3W8/xvH9LKuWzeEfGyOanTJiDo
	bwQ6s/beoXB5o9NamGP+6PrmCADP4qgzuBKfkNhHXLYFnftx+uwoHwcaDFufpr5HQcFQIIQ760C
	NZCCqALKukr9gfETGkKNAX3DHJ4g0rCA8doIZYZyZzyXYAH9hQEG50cv1bAl4e5rxY+IUNlEdMA
	PAiAe0pR5uaxLCMTc/8qr9z19UdokrKSLkWdzGcNB9uQrIohuwjkA
X-Received: by 2002:a05:6214:224b:b0:6fa:c5f0:bf57 with SMTP id 6a1803df08f44-707205d3de4mr17249306d6.38.1753442132370;
        Fri, 25 Jul 2025 04:15:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESU2wE4bOnOUGPBSZO0tkF4LSJGzJmhvaydJbduRXkqSSNO4+Pqqddr17Ym6JSe+xBXleipw==
X-Received: by 2002:a05:6214:224b:b0:6fa:c5f0:bf57 with SMTP id 6a1803df08f44-707205d3de4mr17248146d6.38.1753442131229;
        Fri, 25 Jul 2025 04:15:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53ca1973sm882413e87.198.2025.07.25.04.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 04:15:30 -0700 (PDT)
Date: Fri, 25 Jul 2025 14:15:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: hamoa-iot-evk: Enable display support
Message-ID: <h63j6zveofatmzk6zj2ffvqo325kiqu6vnn2vekb6t4lniyipk@k55zwfhga6uy>
References: <20250723-x1e-evk-dp-v1-1-be76ce53b9b8@quicinc.com>
 <6wwcxwgcf4wm4ekb3d4ukkyyqsseaawo6l66umzxim4kcilynm@fc6mwj6ymnes>
 <c7041754-7be9-44f5-89a4-03bb21e2d342@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7041754-7be9-44f5-89a4-03bb21e2d342@quicinc.com>
X-Proofpoint-GUID: UGpFWWCI71duG-h6EL2lhfPdNrTwZ_NL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA5NSBTYWx0ZWRfXzF9TktNohcTe
 XQuRvmml1E/nEXWYfwsZfd6XSewhGUlowwalQ0DmMbaOW5NBKH8BM9oiMO51s2boGYdqFXCdzWw
 mpVxJRBtGt1LGTR7Xlm0E87VLsjfiK+f5Amdcyq7+uj7d8Be+HJ4EahnIqGxfPNGp9+xWaqTnm/
 GiiagfEbz1zQXJmusDudZOK1Z2Rq5S1+HWlOg54wkAd9PJ5uBQ54O/9npD0pdf/fkdLJemjCPOt
 38pLuzfhfdDnOlq1Fbs3EeGb89Z4RrlLyyjkj6EVyrNR1fQkrfd06T4t07QownGsVCdEv0QfPuj
 uTn2ZbR/psKW08AXMD+2Z4p43c+0YmtYcuvCJWRHvi3E9roPhM5vXlWWKt/NEWgA5pVIXnSAlUs
 aiIBK4bC338LM5zOUOH5mdOUR32i2/1RCzZ3/CFbNqMCY4s7P7U4+TfMpZploR8FB5oTk4s8
X-Authority-Analysis: v=2.4 cv=VJjdn8PX c=1 sm=1 tr=0 ts=68836755 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=d_ojn6GSUL3iYoyApoIA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: UGpFWWCI71duG-h6EL2lhfPdNrTwZ_NL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250095

On Thu, Jul 24, 2025 at 03:40:52PM +0800, Yongxing Mou wrote:
> 
> 
> On 2025/7/23 19:21, Dmitry Baryshkov wrote:
> > On Wed, Jul 23, 2025 at 02:14:55PM +0800, Yongxing Mou wrote:
> > > Enable DisplayPort support on all three USB-C ports of the
> > > hamoa-iot-evk platform.
> > > 
> > > Unlike most X1E-based boards, this platform uses FSUSB42 USB
> > > switches for the USB0 Type-C port, while USB1 and USB2 rely on
> > > Parade PS8830 retimers for Alt Mode switching.
> > > 
> > > Support for the PS8830 retimers was already included in the
> > > initial DTS, so this change adds support for the FSUSB42 switches.
> > > 
> > > Due to limitations in the USB/DP combo PHY driver, DisplayPort
> > > functionality is limited to 2 lanes instead of the maximum 4,
> > > consistent with other X1E-based platforms.
> > > 
> > > The platform also supports embedded DisplayPort (eDP) by default.
> > > 
> > > Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> > > ---
> > > This change made top of initial DTS:
> > > https://lore.kernel.org/all/20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com/
> > > ---
> > >   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 156 +++++++++++++++++++++++++++++
> > >   1 file changed, 156 insertions(+)
> > > +
> > > +	ports {
> > > +		port@1 {
> > > +			reg = <1>;
> > > +			mdss_dp3_out: endpoint {
> > 
> > Add empty endpoint to x1e80100.dtsi, then patch it here like you do for
> > all other DP endpoints.
> > 
> Hi So i need to add mdss_dp3_out: endpoint {} in x1e80100.dtsi and
> +&mdss_dp3_out {
> +       data-lanes = <0 1 2 3>;
> ...
> in board dts..  is this understanding correct?
> 
> i just wondering that here can we just follow other x1e80100-based dts?
> others 8 x1e80100-based board dts all introduce edp-panel in this way..

I've sent a fix for that. While squashing this patchset, please update
it accordingly.

> > > +				data-lanes = <0 1 2 3>;
> > > +				link-frequencies = /bits/ 64 <1620000000 2700000000
> > > +							      5400000000 8100000000>;
> > > +
> > > +				remote-endpoint = <&edp_panel_in>;
> > > +			};
> > > +		};
> > > +	};
> > > +};
> > > +
> > 
> 

-- 
With best wishes
Dmitry

