Return-Path: <linux-kernel+bounces-831017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ECDB9B296
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2BC3B242A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA0523A98E;
	Wed, 24 Sep 2025 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aIsBhjhf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D1E21B9CD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736930; cv=none; b=kN2eVfgWar7Tw9TobC2QjvKy8rJxIzhzh98YK2n/Ra9v9o+QEBgO80LwcgjwNne5T47yrcIvW66YcpQDTdVWWvjfKZxihzssLgJnWcbtdb4WnhCH1WZmw7ek6h8LzA22U4mt9Zdxc/yK96KJOPHZDtRHoUNnO2Kfj4ltSa4yQZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736930; c=relaxed/simple;
	bh=UYxYTt5+WfWAwY+aB6i20zZbM+/Pyq5iEdNwZp9YaAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLlDCHqhYn7sot6zCRXQ+jjBm9I8N/+1zjx4OxX6NGWae9uPlXEScmjIriWiLVIZPFXLs6FEwkgdC6Gy3yyisMeLO45XLuGbjlI5J83SeiJmX9L8j0sH3TSJ/YVgLQugRb0ECa/021rEDXCPV9UhjgqREggNN3r0uFTpA7hHB/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aIsBhjhf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCAukN002710
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pSWUBIP6OFTuLo6Z1De8G0wG
	CS7yFi6QHVszeQXIBZo=; b=aIsBhjhfmw75Lj2UmgwSjfiFQSyC5lTNEa0QzADr
	I0Tw8NoUyj6lGB7TDddj++G/U+DD2v5KJy2F54bHBz6sIl0qqPiTu0LUPguebZCO
	mdd1IVWYJ8PTVjddsRt+ZWR0RSF/+rpSBB4LiPz4svGae6c8SUb2wl9yVKjIgwmN
	dLr8f76/SfC1vtlC1yuXUHimv/4VhYGm/tGPp0ecxxZtgINrHwwUPD7c2KMmXVQv
	gPbqgkvtvcHfYPaBUhc36zcXniMG46eZ44RpQ7wNVWfuIPB5sdEw07SED3b4TGGh
	BB5qrISaYMPG5hrwvJqDgmlyq52/jBkZtr4FZBh9y8pnNg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajeyvwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:02:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-268149e1c28so856715ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758736927; x=1759341727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSWUBIP6OFTuLo6Z1De8G0wGCS7yFi6QHVszeQXIBZo=;
        b=LfBS89qtQsPGOHfZXrMUtb4aGbkPsvf1F+4QeIIN+DiCbQBq2JoF9PPIRd3Ivr2Zg2
         rBdGaW3aGOE4I15iC7qdaFMNjM6WFPYAwathNhwxbM4xVcnXAnTVghv9Hiz1SobgExcM
         9EueqiyEUpnm+gW4G6DpzDQ0YJ5nSt/sHI4omV4h2vPOvaIHhvM3kUk2MPmffgZYcUlE
         KbzbFTFxKZFbBLNJdYAkZH2BLUjC384DjIQIEWJvgW2XnIwMPymsKudljrpQNoKCo8ar
         h0ynTCAQkZSwRR8yBli5AK5EPs2/ZngX9BGsVtRgsWCjHqPYs07YMDSi94M2RXbp3W7t
         5uXw==
X-Forwarded-Encrypted: i=1; AJvYcCVCahDflW2Avsb5WREwjvC2D3pZFVIimwrTijK2Vcn/enBKnjI/SHao5RofGzg0zawkvt499ogrcn7r/Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTrh5meELRtleWKQgYYcCY2a1tMX+aPjR/4gLEn3MwtiXIbj/+
	pkIZrkHSq3CuwSctd58juADA6IZmnBOSQl8C3u3Vy4JaL8r+4sEyDX1i5QoQbQQ1q5mGFtGIQV7
	pBr5dZPWRfh+j/vPhrWZ7Q8jaVzb53WGWBylDMiTWmJHfrv3JO+kTZvSEOxoMBeNTynugyugAlG
	YyE14dIpKHaBZ5RWAtKTcJZLXpqeJ9m335eSdjA0XqCA==
X-Gm-Gg: ASbGnct8KntMJauF1u13uVc9pC36dI8TYSJrXiRUnN3tzed+vJivuFNWUht6MrcrchJ
	l31bL8vF9lCmydYkHvPM6JmPJdeJw3q88rpf+Ef5JmJ2qDOGSQLzUUZD2qVZSvqifNFqbBsgqrj
	PIc8UuzWXitpIIvLDqF6RgqBTQYfYghf3Ncjpi6DUbZzfI3UZR5+48Fw==
X-Received: by 2002:a17:902:fc48:b0:246:80b1:8c87 with SMTP id d9443c01a7336-27ed4a4974fmr8989335ad.43.1758736926779;
        Wed, 24 Sep 2025 11:02:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5VmtuJaJ4FUTe+FfHtk0uwoMs69qvC4ZVktOshLxRHet1WOOLGg/pw6UxmNBmfwikkG9MfLRfsTbV6YrLk6w=
X-Received: by 2002:a17:902:fc48:b0:246:80b1:8c87 with SMTP id
 d9443c01a7336-27ed4a4974fmr8988525ad.43.1758736926053; Wed, 24 Sep 2025
 11:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-dsi-dual-panel-upstream-v3-0-6927284f1098@linaro.org> <20250924-dsi-dual-panel-upstream-v3-2-6927284f1098@linaro.org>
In-Reply-To: <20250924-dsi-dual-panel-upstream-v3-2-6927284f1098@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 21:01:54 +0300
X-Gm-Features: AS18NWCTdNjmJ2KpP_0NKcgbLpYWYdnYEoHnk-FxT_mIPh1RGl91Lr1OC3FQLOM
Message-ID: <CAO9ioeW2AHDM3KSRu-WOvy+1De9tqfhrCNozw5Wkh=CJDHxFYg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/mipi-dsi: Add flag to support dual-panel configurations
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: h7a4M733XKIscvgesNeT_suPclBv-iGo
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d43220 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=KKAkSRfTAAAA:8 a=JmB1tVOSonE3mgEak7wA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX9EYcPDrRoBZW
 zXUuMP0yDfJrkyoIyR7LKX9LASiWeQKkkpusQicmJ0Qxu8oZIyt5/QxzxuXDlNABG5KFxqWFYPR
 KCeNNMsxxOcu3TCov4gybR0oPCru93rdlGhWvLGegO5ofCXdsv+SQJRWGqjLJB6PF99gxWIwsgM
 ncABPtW5aM+7IYyos4FMeIMKS00lUegkBaNXBa16bf4sJfjvjpVTvKl9yMRyyEi2CPetG/N6+ag
 w8Q229eQxkbkNdB3i3ZCJWWG03HEvoObJfoucP2slJmSzekeNXbEzr1M2sfEITJoPKkeh+8YvLw
 pUP2x676zEdCQNIoAGfi1hawVQsIa01Nf6dJMqWQtIvXwXyH3K622eVWs1jWkT+gnZmjv+cp5WU
 9Pco2Bwa
X-Proofpoint-ORIG-GUID: h7a4M733XKIscvgesNeT_suPclBv-iGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

On Wed, 24 Sept 2025 at 18:08, Jun Nie <jun.nie@linaro.org> wrote:
>
> Some devices treat two independent physical DSI panels as a single
> logical panel from the CRTC's perspective. However, two separate DSI
> hosts are still required to drive the panels individually.
>
> Introduce a `dual_panel` flag to the `mipi_dsi_device` struct. This
> allows a panel driver to inform the DSI host that it is part of a
> dual-panel setup, enabling the host to coordinate both physical
> displays as one.

How is it being set?
>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  include/drm/drm_mipi_dsi.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 5a85ba01f402a3866b70828391bb417bb8dd5956..0faff285d9ffeb19e4523cdc7bf21c1ec20e6eff 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -170,6 +170,7 @@ struct mipi_dsi_device_info {
>   * @host: DSI host for this peripheral
>   * @dev: driver model device node for this peripheral
>   * @attached: the DSI device has been successfully attached
> + * @dual_panel: the DSI device is one instance of dual panel
>   * @name: DSI peripheral chip type
>   * @channel: virtual channel assigned to the peripheral
>   * @format: pixel format for video mode
> @@ -188,6 +189,7 @@ struct mipi_dsi_device {
>         struct mipi_dsi_host *host;
>         struct device dev;
>         bool attached;
> +       bool dual_panel;
>
>         char name[DSI_DEV_NAME_SIZE];
>         unsigned int channel;
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

