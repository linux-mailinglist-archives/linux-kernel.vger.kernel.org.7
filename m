Return-Path: <linux-kernel+bounces-805964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B05B49006
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7123B4E1AD7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8880B30BBBF;
	Mon,  8 Sep 2025 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZAYTtaB9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D274306B32
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339131; cv=none; b=gqHSyakBR7B+dV9MUvUxmJ49CrVENKNiw3+lhU8ZFNlQm3j7d2sl5xKVrE41GTGJCTRqh0U+RQqfMQkiKKAlN83AP72W5cAS6dNRbxv+mepLLeRZb4HqNGLpYp5bbej779K5NDZdTpcrcH10EoOhMMjGvU0PeUt0tMUbYE7ZNsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339131; c=relaxed/simple;
	bh=hIc4P2K07XlvYmHQkfI0woteLpw/ikjw7KN9mYvCRiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/rtmSQ3e4giV4LD6XHTG1EYEer3rMSXuZCikkh7wcg1LUV5RzOkUv287E4IP/ba4Ybu0s3ZJcae3P8EMmn9PJveGkF7DeNlr6Q7ooZxKV+U3U6n02HGLIZ3C3/9aLOoJZip/zjorLKXoIgBH1PtW6STgux3s3o+fIc3BvG/els=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZAYTtaB9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588BI8Ht013554
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 13:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=esqnV4GgtEbrquLS/zK5rW3W
	tt7Z1gs3taNjcse55BA=; b=ZAYTtaB9Y7SMyW3MEsYa9Jw4FcBylLtuUJgggnT1
	ggSBjKQSPM0bXafiZrmUzWnhTeDn/elXOFafxMai3AEAY/kDCKHX+MBKB8G3DTBX
	6L3JeQM9UJFDd8i9sHQc5H5BnSv/a35X3UP8bEwN63u8E9Ci+V12IaNx3mmrhCNv
	cM0IA7wrC+tWa/DrMDlLdScyBmtmsSlRQjLjNSMjc1GCmXrwxmM7uKbXVkuoVEbE
	CxU30u7LffSpJh+V7iKVEVU0tZWX79nGews7Bfu4qQnMA04l4zl+P3SfICmk14uE
	hv0GFp4UNlNkeuLjD5Ui40WyB+CPsZn+nTG1unjwpxj0jA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdsjyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 13:45:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b47b4d296eso113285841cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757339127; x=1757943927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esqnV4GgtEbrquLS/zK5rW3Wtt7Z1gs3taNjcse55BA=;
        b=NFrsdz3qqfKHTsoE8fpVw29YXAPuZI5vIuBFAqcgEWEekneJxXXHIofci+tWyh/AQw
         GQCUGwOmfy/A//2nsAMlL7NyFQIU9mHJ646vvI3Bkyhrx+gDnrZW+VgJbbsca6JypKSa
         e9nitlAU1UOh2KwsnU8L3xEjjH/G2mb+NCJLAZI4KqaUrVGv69/6bLW9YLckiwSHtZRS
         wfi2nhxTybtDB+lXigaQFV4mQiWUOme3TuTzlhXNejUYi0LdLQFMWdQTo1dg6Yag7nq3
         ZDUJlUC3LRsxjgPzY+N+WpO5KZ5khquCEkTlhTP9JeoEbKIMWY1dbvwFb+Zi1HsQRN9E
         t4HA==
X-Forwarded-Encrypted: i=1; AJvYcCWqkUddF+EptqlQ2RObPE6KtWsHgIPizAD9jPKNKv16Peb7vovaY2qVgQkJEFr/p5abyWO2v/JFBMgdFTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWH09Q6Dpkq0p9a4S2Ms/rzLhT5iuT8nmQTdVgivpbpEQ4xkxi
	NJeqekf/dZlqs3AsfJPMux2z3hQwTRvYbCwZaFEOH5eu1hAvNH6BOHZRA/TI0CRR4dPpEYq+s/i
	X1e0m/W/e9Wv6JDFd3Arx8hMSzOeLXzmlIbOTJRlZabLcsIn8+rABa6oN9cksluc4SHY=
X-Gm-Gg: ASbGncv2gXcVR2er312GSEBNCOiiGbjF83pB9gUCxbEp05OiA3tyQOyNKFRGKx2NVGF
	XOG1wIotdkaJgLwc3OpBvlhmCNB20LkacHwXxL07RJwdqBYP7fexnmFY0sc3EhJJ7DegiL904Do
	WHQJQ/Dy1yN+EyjCZ4CEOdVkZLounMPPtFQyMoavqkzsgXp+7NQ5TWk9OBij5SbDiNtlWYxP1wh
	FgxelMp8jAxkK81CtC3wB1MA8ffkRS/0vfODzn2WDE1HCzRjzEYj3knFjAUJLpstArUynQagxcw
	ru5F6AK6cpG9d3p1cPr51Tc5PTpAh+FO8D90RplO6vIFkd/nrv8D7+81x6r3O8r+qRActt3cHXR
	NE3T/OSbUKKoRqjbu54vQr4HbUk6Kiszbz5imDNOM56HOm9isC8y1
X-Received: by 2002:a05:622a:289:b0:4b5:e9bb:846e with SMTP id d75a77b69052e-4b5f83a51d3mr96781961cf.21.1757339127121;
        Mon, 08 Sep 2025 06:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6pGd+MdXBZbW1TIlirM87MxAFCUjEO+5IJdJhKbmEgdqD6cBDX43lwroMqHuWkohubp2b/Q==
X-Received: by 2002:a05:622a:289:b0:4b5:e9bb:846e with SMTP id d75a77b69052e-4b5f83a51d3mr96781021cf.21.1757339126299;
        Mon, 08 Sep 2025 06:45:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5032aaesm32757861fa.37.2025.09.08.06.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 06:45:25 -0700 (PDT)
Date: Mon, 8 Sep 2025 16:45:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maud Spierings <maud_spierings@hotmail.com>
Cc: neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com,
        airlied@gmail.com, andersson@kernel.org, andrzej.hajda@intel.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com,
        jonas@kwiboo.se, kishon@kernel.org, konradybcio@kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        rfoss@kernel.org, robh@kernel.org, simona@ffwll.ch,
        tzimmermann@suse.de, vkoul@kernel.org
Subject: Re: [PATCH v3 2/5] drm/bridge: simple: add Realtek RTD2171
 DP-to-HDMI bridge
Message-ID: <u3qwrzwcr4knq7ueinws3siz2frugbkj75r5zp6i7qmkhnyauf@lrmiqhtbgzfj>
References: <20250908-topic-x1e80100-hdmi-v3-2-c53b0f2bc2fb@linaro.org>
 <AM7P189MB100924E3244B953F0EA6D462E30CA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM7P189MB100924E3244B953F0EA6D462E30CA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
X-Proofpoint-GUID: OEupFlnonBlUwjRNaXJhzDnCJrPtpaJy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfX2yD3nx3B3iG9
 R/YF4xEXwuIxyQCkIBreNLQbXP7TwnfnC/MAepqY+JFCpQTjBZdI8Dm5oJg8vEFOzxTCdAwmcJn
 ZIj0g1FEMMfZF0kDsbomEwlc78C4w9A7yqqQJA7sfJ8u6hfZYD7c9EcoVuMsIRLFYj3JeQCEaXe
 RbjN93Tf2BTjmNB7/I8FGSceNP8I1j//MPrRDoIHP20aI6MD3FD/aByXzI4UG7MEhajqPynuMRW
 8UCZy6SfNTvy0N675jJdM/fUYfWoxrWowBmixdfAiH4M3fBshoYG0oPMLS9lhqNUXENmDvFWpOK
 5fXJbDHfhkCOQr1DBdNTRRpR02w6iIo6YBWu6C0eSOgu/trRya3elDEIrt9QuZ2TxAe8BouEkhE
 mdr4fChX
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68beddf8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=XwVbCjRl897ke_8r9AsA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: OEupFlnonBlUwjRNaXJhzDnCJrPtpaJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

On Mon, Sep 08, 2025 at 03:35:23PM +0200, Maud Spierings wrote:
> Hello Neil,
> 
> > Add support for the transparent Realtek RTD2171 DP-to-HDMI bridge.
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >  drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> > index 1f16d568bcc4e0fb56c763244389e6fecbcb2231..e4d0bc2200f8632bcc883102c89c270a17c68d0c 100644
> > --- a/drivers/gpu/drm/bridge/simple-bridge.c
> > +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> > @@ -266,6 +266,11 @@ static const struct of_device_id simple_bridge_match[] = {
> >  		.data = &(const struct simple_bridge_info) {
> >  			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
> >  		},
> > +	}, {
> > +		.compatible = "realtek,rtd2171",
> > +		.data = &(const struct simple_bridge_info) {
> > +			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
> > +		},
> >  	}, {
> >  		.compatible = "ti,opa362",
> >  		.data = &(const struct simple_bridge_info) {
> > 
> > -- 
> > 2.34.1
> 
> I would like to ask again if it may not be a better idea to introduce a
> fallback compatible, once this patchseries lands I will be adding the

I'd say, that's not a good idea. We usually don't have fully datasheets
for those bridges, so we can't be sure that there are no strapping pins
/ other GPIO controls.

> parade,ps185hdm. I don't know how many other variants there are that are
> just simple dp->hdmi bridges that don't require anything other than the
> connector type set to HDMIA. The Thinkbook 16 and zenbook a14 both have HDMI
> connectors, likely with simple bridges too.
> 
> Kind regards,
> Maud

-- 
With best wishes
Dmitry

