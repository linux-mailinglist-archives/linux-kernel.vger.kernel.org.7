Return-Path: <linux-kernel+bounces-893585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B47CC47CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E03F4F0D67
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A873E272E51;
	Mon, 10 Nov 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BFJ1lc2X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F1sIlN6v"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA1822FDEC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790316; cv=none; b=jazI7ho9agbqRUytjEcm+YAljCoBVnN/5CmtlzEmfHmpQ+0Pp8tMUW2RTlcmPBV5iqtM3BsaZBNRbdgtM4dRR3IKeDdgr53RRCYbY/Vb2TPOmh9SQ8sl/zF98IytcuEvqoYT3xU0Od1h3HFzCCYWmjYarmX5piXILST9+EpEGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790316; c=relaxed/simple;
	bh=tPy5FwvJbQCoIpidnLoxpz6S1F3GlO8FzytxOrtPRUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVKHDyPBqgSkHRiOnhhrG1/akVckBKB9EVnOzPgvcl+4MHN854mzkS2gsN8Rr1uJD+Fyxoeyb2UK7OWmBw1S8j6gENhKSz5MBhbNPkOlxjMJVd0Jv+SNi4qAIDdVfdhhWz8H/s2D5AKzL1ZG1NXl50W+RZ7qXG+QllTJSgU0Y0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BFJ1lc2X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F1sIlN6v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AACGOHo2407319
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3FpMNZu3Cz/i/gtRUzS3IU2S
	7zzqm7oC4KvJHeoPfLU=; b=BFJ1lc2XHNG+0LM5ble1t1dK52FEyS9F0XI9O4tu
	wioUk95WQClFCtoj0YlfuU0yzQK8zfNSKxdoBPG2zNhOr/ch4MGk10wrf+ilpULB
	rnplI5O6FAa4Evd2CvRTC/vD4llnPG8an++R9MbDS8CcT7sY2StxUFMqbl52s0Px
	jjoF13eZpiZdJArh9CnMWTbj+jFH6IAboiHsUhmK07gi6pm3c6mNdFol6WVpei34
	Hugq3F5e7ZKF8fSv0aih8ZufAbsfK4jZJZ3Y5ZjG1iMO6GMiqyVoTjbgx7Wbc+KK
	h0nUxxM3aEF3Gutf5muXrHvJ+XLAMfaDcHk2aGIoPcm4hg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatd9q6c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:58:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edb35b1147so39171351cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762790313; x=1763395113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FpMNZu3Cz/i/gtRUzS3IU2S7zzqm7oC4KvJHeoPfLU=;
        b=F1sIlN6vyugscdp0nrjz4scbLFUcyT+o8dDGC5dIxzQ/Q1gIVlMYW6Gc50B8MoudQV
         3Trv+0RUslKQyiYdXdQ0wVIro8Y+QTJJQaYMSn1XoumiZCp9pusJorRmfP8AldXQ8nA2
         DFAjWOOzJgba/vVrb74nyEG6C0JDZ0MIrYlE4z+l8NeylyptmJZ/alyIB3oNy+92iLvA
         tl7jQPjp8jziSL26GcF1axW7nmwzcNV6FbRPUrdNb8TvaPwVRdWO5xl8rlfmCnT5rUAL
         76szv5cLVASp4o3L0UkXLP4uNTwD+HDe4HIOGbTqQgkQSqB39taJug1lwPEnIG5JULwN
         wf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790313; x=1763395113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FpMNZu3Cz/i/gtRUzS3IU2S7zzqm7oC4KvJHeoPfLU=;
        b=ctgDaE9KQTBYOAwcedme+Gm0FUlz9O6tiqlNkbhdnVpMiZscPCklyalehIHXLVWhYd
         84VtqqUqs8VFr/kKYM3wH1S+p9xFxm7FGGg8i63IOLoiKuyWtwAF60eO6fJS0cdx72GZ
         +ntXpEXF2QqamE4JA1syIpXalLi+yHWX4ZAoqazvOTHGUCb0q0JPRV+gK+SvTEfupPNG
         dWq4zxxzySTZS345XwCwOrRl8BHjfm9evchiGkJMPDAsiS3yQIZ49WCMR/5aqYJ10vzX
         hzAR1kquDbOHvLEtCVZnsp1AApBvuZ+Ak/jU1tf2u2eL+teRqpRL9IoIlzGYwGLQmMrH
         4Mbg==
X-Forwarded-Encrypted: i=1; AJvYcCWAwYs/udLKQnS8O73a7zB9JVrUXrgrTcu5bBXsre9vC1wy16/S2u+xMPnG2Mc8vtZwz7Fi0wVvXM6pZjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfFVK/Oq0suberQyFBsRXkAlwW4GD5igH3Mw8WLMO4QTJRcXuC
	QQqhULlB3dWWyscN1wpSmg3S/7PjisKfpcKeZNYik/oiu7bj/C00GOqZOWCGRmnMtQj2bBAF4aF
	msCvWApkVCG8xOr2iW2zqM2st697LYOz6ZUsCupVJDDQxHmdkFzx4Syj7KEbTA0cDnpA=
X-Gm-Gg: ASbGncvkYZVsTJ5nxKJfGUJyr4Oz1QfCyDSGO0KJwEXcTOg18wKJvGDRrVc8wmqk9ZA
	TBrXc61dUzYIFumbhFrvCZUYJHiMNlZdrm/zEm2VYXWLzlmrIJDPdwJn76LFpWi4k4yVrFx2B6X
	+Xlm9IoIFWvRuKpQ1REXFF9gICIeOL90RDDctsREw/0RRQcH3pCFQVtfAUwE4qtq6ru2PT9T5Ze
	cGm1YHKk6OXmjal6bt/690pnFNFMUBX2EtscxVN5Hl9dbTKer8NHiITq4InDdibSJgpVBK2xgfG
	ycYsxEkyD8pbX0w1CSYVfg/SyWuiaI4mNF+kgZyimx+B1k3mgzIekViWtmIqkpg/jukdOsDzc0+
	Lzn0JByMyXHFAI/i0V4XVXe/SpwYS3XtfQqnAXzuRN/3Sf5REcLT4HJyUWk5s0OLmS6DYR1ta24
	zhiEzeO96l9lCw
X-Received: by 2002:a05:622a:2c3:b0:4ed:b75d:31e0 with SMTP id d75a77b69052e-4edb75d360bmr59124931cf.6.1762790313419;
        Mon, 10 Nov 2025 07:58:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdPbMW+KH/OaINk3tcMozx8h+ra/8Uj6lYcYx5kCxoxFDoZTefGVQa7IEjxe/FgWViePPf/w==
X-Received: by 2002:a05:622a:2c3:b0:4ed:b75d:31e0 with SMTP id d75a77b69052e-4edb75d360bmr59124641cf.6.1762790312957;
        Mon, 10 Nov 2025 07:58:32 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0ee99csm38202821fa.45.2025.11.10.07.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:58:32 -0800 (PST)
Date: Mon, 10 Nov 2025 17:58:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Dylan Van Assche <me@dylanvanassche.be>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845-oneplus: add ath10k
 calibration variant
Message-ID: <wqjil4hhrbsozvhwdf355dqpwu736z4x2nwnurug2bpx23ed3g@c4shkwfyohky>
References: <20251110-sdm845-calibration-variants-v1-0-2c536ada77c2@ixit.cz>
 <20251110-sdm845-calibration-variants-v1-1-2c536ada77c2@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-sdm845-calibration-variants-v1-1-2c536ada77c2@ixit.cz>
X-Proofpoint-GUID: lkkC755Tpr8qFE5F0TAov9BxMfq8RSrF
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=69120baa cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ahC5f1j6PEOMoUp-Vd4A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: lkkC755Tpr8qFE5F0TAov9BxMfq8RSrF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEzNSBTYWx0ZWRfXzYr48UM3h9lF
 r6/a/ct7cgVVlgmffiQFKjQALsbweO3GRFJpaZdwzR0XCa01h4zQKA8Z71FPALi2q+hq41SqkrP
 NXlkSIXG9WYgUySK9eOX7U7KNmf/s0yI7FGxCXVn4h3+m6B8GJzkTBpjLgqb2Sl+1MfVK5UWRgJ
 6sDTg6Nr0EgRyOl4QxRAQUTU5yqdxZTwVIPjy6vszMMJtEiDVuRTbxyrMAxddzw784gqbWSXYgg
 6TCn3gunszOAFilqsK8KD2sUKl8mML8WDorInV2faSNlqy0KcKij1aFy1ag2ssfCgi95xDoc6bm
 E4XoukzsJZPLiaM52hpdHYfb0BcnCW1bVD8pTo27jDq3/4By1ay4+8V+V2Ormaf1GGTVtLqq69o
 AvxldTB6E4bfWzEh8yHMp/g2uTLa9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100135

On Mon, Nov 10, 2025 at 04:37:46PM +0100, David Heidelberg via B4 Relay wrote:
> From: Dylan Van Assche <me@dylanvanassche.be>
> 
> SDM845-based Oneplus 6 and 6T have their own calibration files
> for the WCN3990 WiFi/Bluetooth radio with the ath10k driver.
> Add the calibration variant name to the DTS to reflect this to
> allow using the calibration files from linux-firmware.
> 
> [David] Adjust the compatible as ath10k-calibration-variant is deprecated
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> index db6dd04c51bb5..a0c2f6efec59d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -929,5 +929,6 @@ &wifi {
>  	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
>  	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
>  
> +	qcom,calibration-variant = "oneplus_sdm845";

oneplus_sdm845_6? or oneplus_6_6t? SDM845 is too broad.

BTW: Were those board files sent to the ath10k ML for inclusion?

>  	qcom,snoc-host-cap-8bit-quirk;
>  };
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry

