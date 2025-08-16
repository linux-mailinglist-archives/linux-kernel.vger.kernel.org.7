Return-Path: <linux-kernel+bounces-772258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03052B2906E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 21:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053B4AC6A70
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7217F221FD8;
	Sat, 16 Aug 2025 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R4HlaAu7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213EA2248B9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755374134; cv=none; b=BzxWmzv92YVjTowtWiz1spDaKy+fqw0BSbLMrCZ1Hy/t/aPnTy0LqEu3hLYlV+Cxc11jFegXy2wjhEJxCpsa9ccvAGQMyrleQNR6Pk89NTvYboMHwTcyUubtpwBL+GjtOG9NKnqbSFfI2so86lLxtd+fo79M01hiLZmtSCyLA/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755374134; c=relaxed/simple;
	bh=e3FZEhgwb++WMPNO8YC31DhvcI34fDLOhbAzSiHc9jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvc+PA5D4rdAM3IhCbpSqt7xQpUMKJQLrAHtO+ytwZW5vopzPRDsiojCBg4/aAWTzWtzTKQ/DJMNv0DjtxmEPRlfMloeDGxDd/bZFtjGElQxW470O1J2sZz0SaGGEH1x0jJAtbZxn1Gv6oO5J691djC7h9Rv3FyklpgJxPKriEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R4HlaAu7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57GJGGwK028514
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 19:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DcxZsjcJPbB2/vOoAnHCt2p2
	V782/z2KJdD+dGyjoAA=; b=R4HlaAu7MKhmT9Vjyk9Y5mb6c8nCw0co/MTACIKr
	xJ7tdsyC8Q5RgR3l34CKGC9hiR/Suii/YhG7fODAospZ3SuvbhFHNlKW4fCT44DE
	8ZNVkSdRAWLB2PT9dQu3QmsFwPtYVTnGyFeIL9qRteDCSmSA9x5DwiTVnCUhyjDQ
	PND+oBpOnkLbP3yg6wzlSp8UUbbN26nVJxSf8SXQYPkYiNtPQyKwjUNFPiKD34Bc
	DcX/X1QZ4ikPSZ2v3u7x7/wMt/E/anCOdXT1/Asudh1yJTizVsWG9Y8Ok1Jl8uq4
	YSIHfbI2fHvEGecf/sx0IbBmFhQF96CrZjA1NRE8SoAPeQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jgxt97kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 19:55:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e870646b11so744377885a.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755374130; x=1755978930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcxZsjcJPbB2/vOoAnHCt2p2V782/z2KJdD+dGyjoAA=;
        b=I1FmTDVnDgQztXi5XUntJUrYznvgtbnGrz0OgAmOBKrfQmMIxYROUnVV8Hxdyq0cZq
         RHyruPRqLH9D5ATCAY1Q3tRl7TW+c1i6mwSakCA6XrrCDH3kFskGUcZUZ1kfDPjgz1co
         BaKzoXpD465STLk7vuCW1FnR159mAP59BYA+FcyXlEEAfAR6PzDHmdIsz+UC18AuEZM7
         gWrpEGf9qqWoWMeRRCodVxCmiGAUdnNy1S4R4UInn/X4d8KTo4oJh6TgI3TJuKAdN3MH
         5Yg1s63lZKevJAcdexwOnVWofd85RMo63nx4cBDL4zoLHY/ific4+/qYpBjWkUzb7nRU
         v1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcjsb5Hh8cnvglbMVecsUt52dTjH/CXVfAhUg9i1D9069Nbs55oO1xXw6zfOFsK8Lnkw5717dx71E+CB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXBXMs1QTsXVnthqj8Q5nmE3mQqphz9NiZNm+5xHyooTKicpdG
	I5ozPzE4uFK+XT/0XLwipg5h87dznOl3ZvwYBizQ3q/NsEWrzayI/STojdTsYkT3fQlgC03TUDs
	W92WApAt/SEzY4sG86VXHi24ws3BtXW2g6qhGlwHxYHdSzOWHQwLOhzTfZ3KCFzjSbIU=
X-Gm-Gg: ASbGncvDc63qr5ldN4T/zVL9qb01hVf66ICEvYKYbzgKFZ5zJGvSNGS8bbIyuWX7Uaw
	LqzpJ+fDhWbuaykKgjm1d+pgMLBOvkHSt5q8aSNtNy8N1hgSv28QnLw9knPGZkxAwbnUrW8j0uo
	aGqEnyAM2bWQ92lwkDEb+8CqUVGA02ARlMVdZZjat7jzP3F0E/jtwIjK9ysH9pRV5jeL7DJhYsW
	FNlhgZl6mER2hF1V2m/spkzwNaFiq9z260/0xHTgCvWhsWy0FxZdHcUMf7qpt3OjcSi1k05Kh6D
	0YpnvXPoNExMSOFRQ/K+/PM41bkkqaLTTffVu1Fw/uYvgfrK913dy4t0/xFeF26GARxLE89nxyy
	MIIFNu23E1ld1/Vhm2coW+qmR0IiSo+9/bGkObVUUiidzKi5rD7dS
X-Received: by 2002:a05:6214:1948:b0:70b:43c2:3890 with SMTP id 6a1803df08f44-70ba7cb06b0mr82349086d6.49.1755374129762;
        Sat, 16 Aug 2025 12:55:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/qz/f4sYiNsg+ywR1haD9LivBgWwvWG7o13H8HrW9MqL/DBKpsEOaCvZlDPs4BCrfaUVuMw==
X-Received: by 2002:a05:6214:1948:b0:70b:43c2:3890 with SMTP id 6a1803df08f44-70ba7cb06b0mr82348806d6.49.1755374129306;
        Sat, 16 Aug 2025 12:55:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3516c7sm987953e87.19.2025.08.16.12.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 12:55:28 -0700 (PDT)
Date: Sat, 16 Aug 2025 22:55:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nishanth Menon <nm@ti.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, David Airlie <airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Robert Nelson <robertcnelson@gmail.com>,
        Jason Kridner <jkridner@beagleboard.org>, afd@ti.com,
        tomi.valkeinen@ideasonboard.com, devarsht@ti.com
Subject: Re: [PATCH V3 3/4] drm/bridge: it66121: Use vid/pid to detect the
 type of chip
Message-ID: <ffdyawzggxva47wl3a7iukqiikls5aoovnfdjyuouqhr7vucsx@ilk5hrpszjnd>
References: <20250815034105.1276548-1-nm@ti.com>
 <20250815034105.1276548-4-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815034105.1276548-4-nm@ti.com>
X-Proofpoint-ORIG-GUID: EO9-6wICgZvVmXXktGBadAHKLFLZp2jB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfXxKHra786xuoG
 cl18r03DfALp68jzlfVarn8THcsqgNz8pqMsh5YrFXZZWgzAJFNaob3cWOCV9FVkAmKaYXhMOb9
 SoA+U/KQ7fHYsHt+rFMXN89/m4KEaBWlCTGBkih0akQsofJUMwHLznhkCTYMLi2HyNkUC1LkznN
 NsWVWlWNtfAyQ6rddPG/q+Huc9oDUFBsb8tMsjCcAu82V81pHb/JDAFwZV2ZyHJj8YLGk8qfYCv
 Dg5UQft/FV7Iw61RBaubIsXvOHFz3waUgKnJ7AFQI1q5K1ayJfKnLEoG72IcTWHd2iicuy7z2V2
 LerPoFCxYZPKzmhmBI2Tp/PkhOZSeyFYFt4wxIsmmh75GY+t6pSRWhYVgzAyXKfikl09EKBuHn4
 sVPwdbhl
X-Proofpoint-GUID: EO9-6wICgZvVmXXktGBadAHKLFLZp2jB
X-Authority-Analysis: v=2.4 cv=V7B90fni c=1 sm=1 tr=0 ts=68a0e233 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=Eu1ZELVgde1a8Dhk3PoA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160020

On Thu, Aug 14, 2025 at 10:41:04PM -0500, Nishanth Menon wrote:
> The driver knows exactly which version of the chip is present since
> the vid/pid is used to enforce a compatibility. Given that some
> devices like IT66121 has potentially been replaced with IT66122 mid
> production for many platforms, it makes no sense to use the vid/pid as
> an enforcement for compatibility. Instead, let us detect the ID of the
> actual chip in use by matching the corresponding vid/pid.
> 
> This also allows for some future compatibility to be checked only
> against a restricted set of vid/pid.
> 
> While at this, fix up a bit of formatting errors reported by
> checkpatch warning, and since the ctx info just requires the id, drop
> storing the entire chip_info pointer.

Separate commit, please. Don't mix unrelated changes into a single
patch. "While at it" usually means that it should be a separate patch.

> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes in V3:
> * Converted the patch to lookup ID based on vid/pid match rather than
>   enforcing vid/pid match per compatible.
> * Squashed a formating fix for pre-existing checkpatch --strict warning
> 
> V2: https://lore.kernel.org/all/20250813204106.580141-3-nm@ti.com/
> 
>  drivers/gpu/drm/bridge/ite-it66121.c | 53 ++++++++++++++--------------
>  1 file changed, 27 insertions(+), 26 deletions(-)
> 
> @@ -1606,28 +1613,22 @@ static void it66121_remove(struct i2c_client *client)
>  	mutex_destroy(&ctx->lock);
>  }
>  
> -static const struct it66121_chip_info it66121_chip_info = {
> -	.id = ID_IT66121,
> -	.vid = 0x4954,
> -	.pid = 0x0612,
> -};
> -
> -static const struct it66121_chip_info it6610_chip_info = {
> -	.id = ID_IT6610,
> -	.vid = 0xca00,
> -	.pid = 0x0611,
> +static const struct it66121_chip_info it66xx_chip_info[] = {
> +	{.id = ID_IT66121, .vid = 0x4954, .pid = 0x0612 },
> +	{.id = ID_IT6610, .vid = 0xca00, .pid = 0x0611 },
> +	{ }
>  };
>  
>  static const struct of_device_id it66121_dt_match[] = {
> -	{ .compatible = "ite,it66121", &it66121_chip_info },
> -	{ .compatible = "ite,it6610", &it6610_chip_info },
> +	{ .compatible = "ite,it66121", &it66xx_chip_info },
> +	{ .compatible = "ite,it6610", &it66xx_chip_info },

Other than dropping the match data completely, please keep arrays
sorted.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, it66121_dt_match);
>  
>  static const struct i2c_device_id it66121_id[] = {
> -	{ "it66121", (kernel_ulong_t) &it66121_chip_info },
> -	{ "it6610", (kernel_ulong_t) &it6610_chip_info },
> +	{ "it66121", (kernel_ulong_t)&it66xx_chip_info },
> +	{ "it6610", (kernel_ulong_t)&it66xx_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, it66121_id);
> -- 
> 2.47.0
> 

-- 
With best wishes
Dmitry

