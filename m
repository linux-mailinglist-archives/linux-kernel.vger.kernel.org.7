Return-Path: <linux-kernel+bounces-845709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC533BC5E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA102189D9F5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A3529CB3C;
	Wed,  8 Oct 2025 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SkUW1Fc0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017B25EFB6
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938861; cv=none; b=YSI/nRMAZBSc3WvcaF0uwmghjey/oFz6coakErdQ+1xFlweoqmGu/WlYMTX6mj4ADpB5XKbhkQkGwwNBwy0EHU6+/1c+beEFjYcGJRiaokB/bGuynMnvXDBBAoog5clTCirb/u4aq/armCQ0ialbuYbL7jlTbg2L0gVqdj7dEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938861; c=relaxed/simple;
	bh=fontDzsPl8l6lmNTuJ+hWqrLyNDfBne4+rzXzxuEZjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFPYyAOUtwDYnJprJkVhSxTB+xVqWu+UJz5Vy8j5yg1QwEPEzWWQg0Ftn+4KiwIjtkPI+eiUcmIdFdx85kfdAaCU8pnGM2XZrHv4168L3huwtrlJirzgEM8ziBHFwHy3kK5YAZfwc5cqosQZffwJR+vPmWaEOnAvlOtu4J0RwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SkUW1Fc0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890OtA011740
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 15:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LE2fUidSmHSribNBEy2MhkAI
	ghJZNhUt1M2wqROseQA=; b=SkUW1Fc0E6PkWi/DdQpY6g48sxwJZh9WRl5HWW4p
	W+FqLoUaxDgKwG0906XJW+yasUsYRPH+lDGkkRzBeGi9DiUWOp+FBmleAqJaCdFi
	fcd5CnyuTnhDnzAaqPfad2BrmewWDJ39C0jBrMVYaRukHcdZrFubcccS/38pu54q
	y1cEBKiTXvUb1VE+rV03x98gPyDOSY7ka+rM78snG8sH5MThNgsH7rbT+i7Pvzg3
	5ifO/abyPFXKhHPu7mUXHu6PZ8mpQI0Z9+pw0zZMBBUsx535ab7nLWZOSX1HezAL
	SETvrWnRK89Z6epwmClBXj1clF1+wf4HGmD4OmoLRlorjg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mnkpwyhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 15:54:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4df10fb4a4cso285413091cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938858; x=1760543658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE2fUidSmHSribNBEy2MhkAIghJZNhUt1M2wqROseQA=;
        b=CTvrxxJUYjLGy3dJrzHdkH75Nogf6OS/vOJZDgIOD7VO8OWyFnr/r/qXdtygAprJ7v
         i8uv6aaBZc88unDnQOl80COuId3s6WGBzJmE4yw2h5DO2sp+yR2TtuqxjuDI5f2awmjq
         sUVCKKZZBe1lHMI821Bw+GnsTtCPaNA/Mzkf4m37G7PbiStIHNult7vBQWWTKx0wisTe
         UeSLy7RvmscMToTtieP+ddvk7iL4IKresVSK/LKajXM4xzK65oSDlm9Hv9cbpfeYnw3q
         HXSi3xC6F7HZ0ZQ4h4YE+S60iWH1On6K3kr6P6nDAv8eiD9oXzW3K1AQH+ft410zByRN
         jsDA==
X-Forwarded-Encrypted: i=1; AJvYcCW6lKajK8097p20LEmtMkSMDOjh/zcLqw4KoNoTPaFsXxL73fDcg18mDas9MPqxR/aIYiEzlQi+4sIHXco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7GmY4M8ql4ZNTHje03L1Gp+VLw47IQ/HZkfOw4ZfrxKtKyFmL
	mStApsZGrZgYvX6mIClFEWKsXvfcE/Ca7o4+rR2+cR+n6BUF+GAJ/Y925ulcnTSghLx3FJ29WSf
	OzIFfpp6r7upq9zuWwOw4beuXEY8YXe6MQsuui8wx1n5FcPwxlVeJ7qvyTnD4MTj6mU8=
X-Gm-Gg: ASbGncttW5Z25r2ROQf8GusgFSbTX9Uqy6M0AwQ+Mz0ppMAtotfYntiRGpTp5w55GIR
	jpVV1hL9X55I61Ty/TL0vAGRsJvKOxZAuv4xIS0SKQ8ONHZxg8PZxbK6S5q2E5KGLTnVddHBlc/
	BU+ZVxJ8wbUgcT5Nbmp+XWupFySN9v46Li95j2h6LBq6clHxiyCnrOOcHTUQAo5xLG1/NJ4iFEe
	GG8lO217t/wjHy4dGmUU3gQREKFM8LMI33khAS7ILicDKgRmVFChKf1J/+lRH2+jSaBK5Mge/vf
	dfwBPViRy9ikTDEwwAqmZoSsBnDaAaNoVspYDvw0M98R8xYCHKRobxk9ypkmGgaj9bjQg/Acb32
	48gbSIT10DiZxfN4J+SnStDkRoPUivq8gIifkKRdxBK/Vmq47rRuo3z3WyA==
X-Received: by 2002:a05:622a:5a08:b0:4d8:67fb:4185 with SMTP id d75a77b69052e-4e6eacdacf4mr49493591cf.15.1759938857567;
        Wed, 08 Oct 2025 08:54:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvpXymT2Zr8z/4eTOthDjqXP/fGceLamBVGehb/FzKKGCG3gKvNiaUfAY1peyOGsUvFX0bMw==
X-Received: by 2002:a05:622a:5a08:b0:4d8:67fb:4185 with SMTP id d75a77b69052e-4e6eacdacf4mr49492571cf.15.1759938856560;
        Wed, 08 Oct 2025 08:54:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ac00a83sm120303e87.11.2025.10.08.08.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 08:54:15 -0700 (PDT)
Date: Wed, 8 Oct 2025 18:54:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] arm64: dts: qcom: sdm845-oneplus-fajita: Use the
 freshly introduced driver
Message-ID: <visvxwdwh2mcympwre6kx7xesvsysdjw6j33kewwibzfbgrbsi@dkcilnw7gk7c>
References: <20251008-s6e3fc2x01-v2-0-21eca1d5c289@ixit.cz>
 <20251008-s6e3fc2x01-v2-3-21eca1d5c289@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-s6e3fc2x01-v2-3-21eca1d5c289@ixit.cz>
X-Proofpoint-GUID: xvuOCei9cnuaxev0LEk1a8ZrM--2zo1q
X-Proofpoint-ORIG-GUID: xvuOCei9cnuaxev0LEk1a8ZrM--2zo1q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE2OCBTYWx0ZWRfX91q9QlVsZc8g
 8CpB4wXA+wBjz4glsGtC/nDDzINHQAwtwJ9kOn8BFnxrGTm5xc1J7YtV0PotiNt3i7DEfADIHGH
 BEMVcd7rUouv7K0uq78xCEGFJh3YSRmaCPO/5oROu3EL5BlfZyPcHUHzkGe/BpO++MUiNlz5Z5g
 8nFiwbjrQSa7u6rsNJs5jhI5clCRsS/PQmv0RCzr7tiQSfKFlhB6mRKdzYclugNBHQDOmdJhMYO
 f9uIYj4c/S238LWk8sRkJGRrupRLm3XTTB+qHYe+GSxnPGTyqqv7L9bDtgduAYl5QY2Vfa8sdUD
 XD/EdL087rzokmY4PMVlTaIziWgKsrlGhOvEZRwbqRevIik/1/x/8O3KbPz4jr5MeKDO5NAmu56
 OOl1AxzzfUQAFAOfRM2vJIHXpCaJoA==
X-Authority-Analysis: v=2.4 cv=BuCQAIX5 c=1 sm=1 tr=0 ts=68e6892b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=DPUHggLApdFq0BbWEEcA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060168

On Wed, Oct 08, 2025 at 04:05:30PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Switch from older effort to support different panels within one driver
> (which already dropped support for the HW) to the freshly written one.

Please disconnect the driver and the DT description. DT can be used by
other instances (U-Boot, OpenBSD, etc.).

> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
> index 7e75decfda052..55b3e94dd9726 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
> @@ -32,7 +32,7 @@ battery: battery {
>  &display_panel {
>  	status = "okay";
>  
> -	compatible = "samsung,s6e3fc2x01";
> +	compatible = "samsung,s6e3fc2x01-ams641rw";
>  };
>  
>  &i2c4 {
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry

