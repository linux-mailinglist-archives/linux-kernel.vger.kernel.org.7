Return-Path: <linux-kernel+bounces-866883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91016C00EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449381A07632
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6EC30EF9E;
	Thu, 23 Oct 2025 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jBArtMrM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA58130DEAD
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220759; cv=none; b=qucTjiC4lv66KNiXqEbiZOrJ3g5ML3/UPjyPLFLRYPofBu6udTK5GLCrBVF4EVeW0X/xvzjbeDmF5M8XG+lM0yOv/BowyOyUisUIMORleZkk06dIFuw/wdo8lkH2AqOEgWnrkgpwSHqkUmmP/IO/mHzVFPQ9276EWKPoWegUbrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220759; c=relaxed/simple;
	bh=xVs2J4y/MdwS4fSVX7wvxkuXXbuzU3K9MgRZCcODSRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dh/lVLpjtP8zyHsbz6j26+CMGYLfjTNCI24GmVOz/Zse7Vu6rFSTi6YibgXgN9Zri9tHrz9+7NeBGVx9bB9Voh6W6n4ONI+GtLW7l/P2yfU05UXL4uKswnhzvUxQiwo91fBDf28KuPWk6B3QNVMYSPp1pDRF5VxSJsoyGHQGcRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jBArtMrM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7Bekj032246
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6ZSrNBn4GN8xDjxxz5ymQXTF
	nfG4FbPwRaNc+3tmIX4=; b=jBArtMrMMQ3Q9zwl0FdCWDXTmxemZOWH+k4X6upE
	5DsDe8FZq+cVunSxeP79+MTQjhclQ2yqOCSEBg99GgD3GYnJX0xzajphfv1bgoSr
	98RjWm7LbNewP/hxEljbTXKmLf3UfsDd+4E84/QWEGaMaYhiSVeyFhSCJxf/oM/i
	3oolw/EivwVoiWAouOIimYGLuEYhtDFv/+JHB2LlUf+fCWry6OH8nOcWbnFkGUe4
	yl8tuuHgG38xTJ/Q+bJq10xagTk/lW9JSyTyFxNTBhySXQDgtS5UF9h0+J0khXMR
	BJrIcXWNrTI1WMUgmV+HbvlFbH8Ozn3ByOUmgZqfHbI+Yw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge88vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:59:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8b15de40fso34062601cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761220756; x=1761825556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZSrNBn4GN8xDjxxz5ymQXTFnfG4FbPwRaNc+3tmIX4=;
        b=ZeJDHXKO9hoSZax5tInU4lJW1O4apyrQcimhMQJ7RNO/V4YydMUCOJPSDL5fFkh2Mc
         FbRxkDysomuhU6Su1UYCARTtsTtWtHeSJsY4EAJBD+XhcYu8U/wZPWFMh52ZwyzgyNLm
         50t4hA9Bvruvmhl4dvQ47C2gUd34RUmeAEiRQDAzdHNnuPG1TdIg1oTc8ieGaPyBqq7a
         kRnnsXU3JS2NhZHsczRX0tcwevoY7uGkDVLrhbJVNRDMftzIZ07rIbfMz5OJoxT3K8sV
         yYfD09FQUbVmooGQIbc71a5F9KJhYXF4IN4bNFIfaDSFjVrn/SIE5P0mjK6+wEfALPC6
         eD1w==
X-Forwarded-Encrypted: i=1; AJvYcCVlA8y54sMzI5A0NxYECzVjKoSVOmFef9my6RX1T6//Z2rIuZ8P3uiB1zmgumqvwoju0VVl1w1hGQ/IqiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFmpyRTsMe7gZDMlVwv/9YDIj1L218VVSp/3HvKtGefUNzxJsR
	FL6Iq3vMQamViEpePpCduf0Swt4okZpfaxc+s6OnE/n8yRH4dvQdu/tFKlspJWy7NNMDks9McDZ
	FJVasc3EhnOGUD72yBgltruy2Fiyi83OdVmSxTU1t6QQza20fr5I4kopJj5SxyBPo54A=
X-Gm-Gg: ASbGnctX8iptqPCCYHelRFFn67LIo0E37dR8Lnsk+oV/eMNYnY9vweVKuRRtSitJir1
	fHtDs03oJOz7RTvckJFclv9Dwn0R+NPOUKzvPCjMf96up4OI3DNP5bp7HEFDIr5RAIzwagMD/xE
	G3brmTheLWCHZosBl88P4PqAsOUUEDFdV4/mqpulwXBLbBUyWWNOvAborLe9kq7rtSsVPVolGQs
	wwpUeWNtVXuwtPAoHyeTMDfazfPg2N46c1YsDN6nEKXY6BDhNcjB2FwrG8e0/2YVu1olX8ShlWo
	D3tu0Z9IoWhhyG3vQgJ88e/4dHxxk2JuVQB1YVSQjYx4VzRxDbmV2XY1kUXPX5wzRmNi5Ldb+Nk
	9wu8PbU3cLiHGDwrtZQxdtjOx9vtIxyO8J/Dxj1yfEK5TK4Qt4jE3m4T/4Z8knPVw4jcaNJVZ4I
	gfu8w95q+DMBTu
X-Received: by 2002:ac8:5dd1:0:b0:4e8:9140:f3c8 with SMTP id d75a77b69052e-4e89d3442b0mr300586691cf.53.1761220755726;
        Thu, 23 Oct 2025 04:59:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrkM4uYfq/lNpbDez8GrI0xNjJmLCd3bXoaTu6hgpwbrEYitSxf9CGp5WmH+cMNaQYf8QlBA==
X-Received: by 2002:ac8:5dd1:0:b0:4e8:9140:f3c8 with SMTP id d75a77b69052e-4e89d3442b0mr300586381cf.53.1761220755223;
        Thu, 23 Oct 2025 04:59:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4aded3bsm699017e87.8.2025.10.23.04.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:59:14 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:59:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 03/12] drm/msm/dpu: Compatible with Kaanapali interrupt
 register
Message-ID: <nfekr4vi34ftxzyyf5xv4tsb5cr3tokiyfkerypqjf26dos3uq@42wcn6ji7nnb>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-4-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023075401.1148-4-yuanjie.yang@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX73H0qttnk3Pb
 Xd4H33Qp4SWImGh3v46YtTw335JRFGVUjmneEOLHW7/Cfk15abfSF8lA2Jm+dm9O87QuNethOpH
 IhMGr0ADDdQ/FsXr9Cnk7BRW/8KVqp2AzrDHD07U7GB7XkVyZynNnNjQF+R41K3fy3q9y884iz3
 LaduM+UWmsVcwMFsJKJCYVflU9VasdQjtp1W/eiH4S21AtmTuQE/6hx8A+LjIfaKb5xv/BRDvcZ
 iqUkcD9wYI6jWf7y6Z5lQHOWD5t7DB44Bo/MhMc4u863ZoWMVsC4cHSDLWOKkMDfne9XqfV1+T/
 HapFLqy3/NfbTInJNC5+kj6AkBEydOdInwzFks6dihfMDzmzAWCiQz5hZvGFQ814xrcO/jIMVFb
 h05E37NWmEPEbzToDaR5JLiLos8a8w==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68fa1894 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=lgH9jh0Qp7VjnHBaTbUA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 16Eq3-pOtOZO8kDGt64H7f-Ckr_CdXOR
X-Proofpoint-ORIG-GUID: 16Eq3-pOtOZO8kDGt64H7f-Ckr_CdXOR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

On Thu, Oct 23, 2025 at 03:53:52PM +0800, yuanjie yang wrote:
> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> 
> DPU version 13 introduces changes to the interrupt register
> layout. Update the driver to support these modifications for
> proper interrupt handling.

So... Previous patch enabled support for the platform and it has been
using wrong registers for interrupts? I think that's broken.

> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> ---
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 89 ++++++++++++++++++-
>  1 file changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> index 49bd77a755aa..8d265581f6ec 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> @@ -40,6 +40,15 @@
>  #define MDP_INTF_REV_7xxx_INTR_TEAR_STATUS(intf)	(MDP_INTF_REV_7xxx_TEAR_OFF(intf) + 0x004)
>  #define MDP_INTF_REV_7xxx_INTR_TEAR_CLEAR(intf)		(MDP_INTF_REV_7xxx_TEAR_OFF(intf) + 0x008)
>  
> +#define MDP_INTF_REV_13xx_OFF(intf)			(0x18D000 + 0x1000 * (intf))

Lowercase hex

> +#define MDP_INTF_REV_13xx_INTR_EN(intf)			(MDP_INTF_REV_13xx_OFF(intf) + 0x1c0)
> +#define MDP_INTF_REV_13xx_INTR_STATUS(intf)		(MDP_INTF_REV_13xx_OFF(intf) + 0x1c4)
> +#define MDP_INTF_REV_13xx_INTR_CLEAR(intf)		(MDP_INTF_REV_13xx_OFF(intf) + 0x1c8)
> +#define MDP_INTF_REV_13xx_TEAR_OFF(intf)		(0x18D800 + 0x1000 * (intf))
> +#define MDP_INTF_REV_13xx_INTR_TEAR_EN(intf)		(MDP_INTF_REV_13xx_TEAR_OFF(intf) + 0x000)
> +#define MDP_INTF_REV_13xx_INTR_TEAR_STATUS(intf)	(MDP_INTF_REV_13xx_TEAR_OFF(intf) + 0x004)
> +#define MDP_INTF_REV_13xx_INTR_TEAR_CLEAR(intf)		(MDP_INTF_REV_13xx_TEAR_OFF(intf) + 0x008)
> +
>  /**
>   * struct dpu_intr_reg - array of DPU register sets
>   * @clr_off:	offset to CLEAR reg

-- 
With best wishes
Dmitry

