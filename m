Return-Path: <linux-kernel+bounces-880097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9767CC24DED
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25B65625E4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30132347FC5;
	Fri, 31 Oct 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p8G702Ah";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K2kfGk89"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37D7346FDD
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911405; cv=none; b=oNrWBx1rCySjKRhamZ+zfcleRTkfETI7py0XsK35l+Ez/H3Hd2U32ZRIDD82e5k8AqilhCb3n4v/kFeolMR2HeLSApnHKFKY4n7RLqjTcqygfcp0Rv1dU4NcyUruDK/vFJ1KLTVRD1+DjAgReCLdFfjuy5oEdQbNJsLt5ariNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911405; c=relaxed/simple;
	bh=eoVbHo7aC1vVS9/BhWqWBi4mcYDKQTV0DCH1R1NJ3jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2BgTdhtm+E0zzLG6OE/7rho8oEpPeTr2M4mdNCP/2Gj5lq3cmsPhWbXdUK7WTEVjK0qXR/XKnl/fwRmRkXLv+zzkjmwyucrxJTnpY+tziOpgn6L1L+w+R6N7LMCAXGUjATYmGcI/40gwaUWdmB1Xnlj+mDDSfDcLywrQrYeK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p8G702Ah; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K2kfGk89; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V8HwbG872728
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gLRZg0S+AE6oEph0CbBMONDhQ2wpbW+QzzCe2qY2NRc=; b=p8G702Ahp/V4Bhu3
	jwFIha0OnUWN1QfNncuJ+KkaGHvLHpZxP9bZ5A+OjRtOTinXZJQFg3qp59evVq6Z
	yuHk1IV5mo3WMwfTR26n4YH/l06MjGYCwm5t+jPeKtcaUITGqHlcdEaHuT2puy1w
	Y8T16N6yzpwl82kqsFCnC4fNnKA5YLgOTn6h7qparFGEzXpOC85ZrltzlYeVeUmg
	J4B4oaq8SR3NpADgp2Wa+FN9WYfHiW82E+48xvI7saAMh4Dv25FlqfV/+3uuyoTf
	mFd7vzFEXsnSUsxxMWj4FuhTfh/DTHfCae+KvBoHGthiZ4SEeearGBqiqVB1yUFY
	DxdESw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4fqn20ta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:50:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e89f4a502cso59807321cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761911402; x=1762516202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gLRZg0S+AE6oEph0CbBMONDhQ2wpbW+QzzCe2qY2NRc=;
        b=K2kfGk89uM4+5ot93ZlaPj2T5eA4vRXKimViNuhyhHLa/aVZA9PK/K6kzOIgmWld+s
         tT3e80WEY/7SM7Wa7piho5Q/pIerb1wCFax/leW1JWhhhFL2KnkaDYQFsU7rsaBQKudZ
         zH4GXgO07+FavLTc+R6XWWYPRvUrT1sqxZQ+OF1uxSgku9I2RdJTkkoxVxPTPZbGg7XH
         5w3pduQJgaELqNleFMAwmDjxkpYceASWiFGBo9pk2S4eA6WEt+XvqFCXTbWm8yiwl/2f
         hlst2g3p6t1r4GKs1lgr4xpobVT385H0xt3ymop5fsv+MlLvoKT+KsZA6jQ31t1F4726
         rL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911402; x=1762516202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLRZg0S+AE6oEph0CbBMONDhQ2wpbW+QzzCe2qY2NRc=;
        b=TtZTIpnpx8cOSkLJxU1BWanBeoNPvcs+zMpFHM0z/+i6XRNZ6DhcOsFDc2cHdnRWHf
         MP31gUrKajDDU5jJNJ8YGtNmy3HSxwsHU6ZUqZdNUCHQqLzyq2r8JbS6tZAfOIJt8E2t
         3d+1j74hsZ3C30trN7VAfgGchBzZVgmBu4n2o+fyysL3PjxlErbIoDGnqKw3qVLaalIP
         ekH2hHBvT1NORBD5nSKcXoIhbqs5RN9jjapEnIr9v5KAtVU+YLsD2dELPa2tvvlAkeEu
         BlJwgBAeB5WLq6UesERbNpU8DUGhj7ZiWt+XPuF97hoXsVnllvrQbjzy30JKnqKFlF4P
         kVTA==
X-Forwarded-Encrypted: i=1; AJvYcCXHMozPJWBNKbIn2jmdrFAQOEh+ncoXYtePrkZ0fh8811MzAtPuCQmt9x4/PmWrC0EJnlt2I8jfYAOIUZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGiuBph8jvI6+02QpjXfZ2yZ7nBZKuXGbDDf6s4em4hRgYV+iK
	gN7uDkmSkOxqr+LFX2RuxFqfN6vtdpiNNkEya5Pgjptc47kMzM/ltAcyI7BCJVahFLQWDl5dxbG
	QOuPwf3U7nXMCegCDEfIAxDxcypQrai8ylsQlxQMxXTVzk0a3O1vzbRdADWU53yfaNvA=
X-Gm-Gg: ASbGnctCqbzU3f41yvvqO7hCgisjx7s2Y9weGEiP3W5vGLIQsjt4J/TB0ZARFUy46ra
	IjOLFZTIhutuk40T7dlgx9PHDx9Zt0qkURHj5BOelPl8TLK/LHeSfyTPfyXjCC1D+0nGC3ndsl5
	thOIfwuWINWsbOLIRwn7nCra9CRwdesIHFTQlzdmeOSO5ijzA8vDqzaKMPU7URz056UzIrOJykY
	Jz736Xg3Sq910NYnR4CHLxxRpQxQH8xmy9IMhRXxzwevfVELFEPQfiyt+DCZTImce+pM593nHhO
	qtgLQCEJPdGgLYNOXnzSyVdPK7SdZ4yAIszhHy7T9mbQd00ei6MrntaP601/IRTo0gpNMoSXtLO
	fYd/DaA22FTwSaGhbonXFH64ZdA==
X-Received: by 2002:a05:622a:20a:b0:4e8:b446:c01c with SMTP id d75a77b69052e-4ed31009474mr37044871cf.58.1761911402025;
        Fri, 31 Oct 2025 04:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEWPfCzEgB1x7tlVV25/AaqTH5SPGouZCDNOaKdIMjMHxQEiVR/bwWZMHsFaO3q/nxJufbjg==
X-Received: by 2002:a05:622a:20a:b0:4e8:b446:c01c with SMTP id d75a77b69052e-4ed31009474mr37044551cf.58.1761911401600;
        Fri, 31 Oct 2025 04:50:01 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429c13ebfe8sm3170057f8f.35.2025.10.31.04.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 04:50:01 -0700 (PDT)
Message-ID: <c3120458-e493-43a8-b5e5-0de62377ca29@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 11:49:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] ASoC: codecs: lpass-tx-macro: fix SM6115 support
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        konradybcio@kernel.org, Stable@vger.kernel.org
References: <20251031114752.572270-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251031114752.572270-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20251031114752.572270-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RL2+3oi+ c=1 sm=1 tr=0 ts=6904a26b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=bqFBmpm2teb5LxhVygoA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: Ikbui11Qsl-p7marMx6ZkE2Hqr7WNSRi
X-Proofpoint-GUID: Ikbui11Qsl-p7marMx6ZkE2Hqr7WNSRi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwNiBTYWx0ZWRfXyNkUpJLqZuBL
 M+mDmZ3nhXSd3f7ZxbgaE6qxge2s2LdG8bJs1BC6fPo57jhBOGLz8YymuV9dqbVH1u3+zTFYcHB
 8Rnp75E75E4CLzqRISi6T9kaUqmgbVMHxmJY4CiyzZz3uAfmusJoAw/rT1MkHhN+mcDk5KKQLx3
 fGkzt4i1vuj4dVCx53rucyHKkoR5urAYiRuxd35Y10J4e+yQiIER31p88T+b/6LDusQslKnO1ok
 PzCUgG+xTZgWFR0KMw7wJltUvxYMn3GZ851TXgiJ2ccYNfFobPhenud6IUuGxWiQBLqHt7w+4FC
 ZRE2cuOcTOdFEQ2cAbFXvtY1BTZeLAwPESVo+nNq5N+RGHVfsX4lsMo4Zar3PgVkX3EEBofaQVY
 aZenTdo3RjV+sxLl0gf0ok3KtNWyVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310106

On 10/31/25 11:47 AM, Srinivas Kandagatla wrote:
> SM6115 does have soundwire controller in tx. For some reason
> we ended up with this incorrect patch.
> 
> Fix this by adding the flag to reflect this in SoC data.
> 
> Fixes: 510c46884299 ("ASoC: codecs: lpass-tx-macro: Add SM6115 support")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/codecs/lpass-tx-macro.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index 1aefd3bde818..ac87c8874588 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -2474,6 +2474,7 @@ static const struct tx_macro_data lpass_ver_9_2 = {
>  
>  static const struct tx_macro_data lpass_ver_10_sm6115 = {
>  	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
> +				  LPASS_MACRO_FLAG_RESET_SWR,
Looks like send a incorrect patch here..
will send a v3

--srini>  	.ver			= LPASS_VER_10_0_0,
>  	.extra_widgets		= tx_macro_dapm_widgets_v9_2,
>  	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9_2),


