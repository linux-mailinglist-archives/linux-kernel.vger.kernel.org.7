Return-Path: <linux-kernel+bounces-879308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B941BC22CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA8214EF494
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB391EB19B;
	Fri, 31 Oct 2025 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/iPZChc"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625201E521E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761870672; cv=none; b=RYYm4ceje/gwU5vMmVCqeNUBHiznViM2kISZEIuaABFuxR2jtQ6pRQsFrQnCgEQ455rnSM2TPWTalhjcCemDmWqg7JDBk1lVLNgJEjpivwtICw4ViXkfiSV+ffCexA4LLxkF6VYkYi4YH0luj9WBoflcU/vhznw8wShcjSesr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761870672; c=relaxed/simple;
	bh=KMzDRKv5vA7T7CtnN1YiylERwCfSkYzsAuzyPy6DuS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+foGtEOwbjghd54o014mHfE2cVqGjHI25wwq0UKop5Bv6rOm6SbOe1tUZrNU71vPLkxqsMDoeJeb7PTBhRKpxHCiZJjj7kqU2h7B2hx0qV/8SVXsOuARmgYe4nHuMlAAnpWYvpdSs3Ak3H2tj+5jOurwyZQxPX7pqYWwFXcqjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A/iPZChc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-471b80b994bso20768495e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761870667; x=1762475467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQyM+gpE1/R8XB7auHos6sn8eyFYyrQM/uv08lULwXc=;
        b=A/iPZChchR43f4h7UeGjo2dAGs1KBe9fc6oP9w6W1oJWCBBQXsxSdpyugvLTzY87sk
         O9NLOvtYWWc/DIMaW1tqBhPTT1IlBOTtIa4yN26p0DdX1nNrIv5Rz87en4leoeYGnEBp
         EEr1pD+kpp5zVxE3VEw8WimXA9P6cpC9fZ0o09+ftNbWp6KPgskct2DpcX9KnXag4/9f
         od47Zd2y0CZ1P0LjxruKRAg8M8fIKFxzcDJAItnzZ8K6DytU0LNc31X1pB93HT2RW0Qd
         Sw6MeqLR/qyP/UPR27hl3ngZppBGc6M+iUoGRfFBHVK8P8pCglwIJxk57pYYP4bFsLZ+
         9NEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761870667; x=1762475467;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQyM+gpE1/R8XB7auHos6sn8eyFYyrQM/uv08lULwXc=;
        b=QwxfbHjBA2JvxLrT/5D2Z5Kqj5Eqj0YZoNd49V22pCW9z7Taa0gevVgYN2vnuyotko
         3Wq1zItEatSYqaZA/5ZhrTFZqM2A4vW0DwsodjjhaIO6QDcHpw38lzAXfin8Yosu5S0K
         RONf1VskPqWyXiwsAtx5fKo5SemtgHTr1x2sNO0DZqi0Cwkq29snAIVJEgVz048lljz1
         VRKX/s7OH/w7ZqtcKunfMLKbssbKYd199b4F/ixYsz92kjZVQL7IRCXkHjXZIx18B/gK
         rY/oixE274QAIX1f9WsXhI6psSCZIcHABcu9oFQbn66FdfHBiahG8fNIMJLpJsybLi2r
         yckw==
X-Forwarded-Encrypted: i=1; AJvYcCXS5LYDUTVMej1xmRbvTfTUf8cqZvyJ5HFgNAKaCBUssT6PuBfo9PrUuLPGofQQih98LUxpq196pQUlJSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV8pp4gNeXi3KFne4AEDVOVm3SLTfdhQJfrOeQt39DED4BWnU6
	aq4DSyEsmhK2241/v/zq3iYXQ5RlFUldSBATKYfAOYG42Rqxey85emixtwdCZVGHhlU=
X-Gm-Gg: ASbGncu7ZP0tREsmAfNYYygbcJnSN679wf0RottLw32Eu9B72BlAFDg+FvLAyb7YVy7
	9RwV1KpsKuIm6k1vDF7DGXbmeXMhODIRJamlSm3P9EHSieugxGUMasp7z9NLpFX1QZJ4k+0w98g
	o9G2PBJYdf1EO3l7n1uGJLiGk1YNg+Rt5A5pQT7U/jGLOnaVMj5Dc1lOT7djUY8gs/144Ml334v
	XtN+8Wn1h7hmS+9W2OQZIhlcgbOfOLrdiBGPi6yzL41kMLfpVpOiapEB2Ik5dVtsHIfY0spNJtc
	wWPs7j+LYLVv60O+TULN519+SA/b5wkPRAeip9bFch5Q2i8khJIKuL1Rw3FsOB2LN5Lc3pjOASa
	+rKb4h0yhbrmlul746UrybDcm+iF28Sn+nUgQA5N3VSTjRrMfsWJdL4yO6ZD6jJcwZfMR8V6u0i
	5tTCQQabzgwiL4ljU3NGWFzIOxax8uWUWug1IX17/MxoSWiQ2ldb9y
X-Google-Smtp-Source: AGHT+IHXcj8ihCaJ0joDQKKDFiMlVz4FGEpmj/DtV4mCnROhkUQEtdynsk+5jYqiPYBn1KFHIFfjeQ==
X-Received: by 2002:a05:600d:6352:b0:45f:28d2:bd38 with SMTP id 5b1f17b1804b1-4773163825dmr4196955e9.18.1761870667522;
        Thu, 30 Oct 2025 17:31:07 -0700 (PDT)
Received: from [192.168.0.21] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1d8bsm286786f8f.25.2025.10.30.17.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 17:31:06 -0700 (PDT)
Message-ID: <85217da4-3ba5-491f-a771-40c95a31f1f3@linaro.org>
Date: Fri, 31 Oct 2025 00:31:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] media: uapi: videodev2: Add support for AV1
 stateful decoder
To: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20251030-av1d_stateful_v3-v3-0-a1184de52fc4@oss.qualcomm.com>
 <_CZHQqm9UaYWFVQTen8I6llGxozVDgeSVxCp_HGBttKghQ3or75NV-dfyGOXiKF-bPIDdgsTtNtKJjED0nko8w==@protonmail.internalid>
 <20251030-av1d_stateful_v3-v3-1-a1184de52fc4@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251030-av1d_stateful_v3-v3-1-a1184de52fc4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/2025 07:00, Deepa Guthyappa Madivalara wrote:
> Introduce a new pixel format, V4L2_PIX_FMT_AV1, to the
> Video4Linux2(V4L2) API. This format is intended for AV1
> bitstreams in stateful decoding/encoding workflows.
> The fourcc code 'AV10' is used to distinguish
> this format from the existing V4L2_PIX_FMT_AV1_FRAME,
> which is used for stateless AV1 decoder implementation.
> 
> Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
> ---
>   Documentation/userspace-api/media/v4l/pixfmt-compressed.rst | 8 ++++++++
>   include/uapi/linux/videodev2.h                              | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> index c7efb0465db6480fe35be8557728c196e0e530f4..0c70410ffd4d58e0719d3cf13ad336c97b454ae9 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> @@ -275,6 +275,14 @@ Compressed Formats
>           of macroblocks to decode a full corresponding frame to the matching
>           capture buffer.
> 
> +    * .. _V4L2-PIX-FMT-AV1:
> +
> +      - ``V4L2_PIX_FMT_AV1``
> +      - 'AV01'
> +      - AV1 compressed video frame. This format is adapted for implementing AV1
> +        pipeline. The decoder implements stateful video decoder and expects one
> +        Temporal Unit per buffer from OBU-stream or AnnexB.
> +        The encoder generates one Temporal Unit per buffer.
>   .. raw:: latex
> 
>       \normalsize
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index becd08fdbddb857f8f2bf205d2164dc6e20e80b2..cf0b71bbe0f9d397e1e6c88433a0fc3ba11fb947 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -775,6 +775,7 @@ struct v4l2_pix_format {
>   #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
>   #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
>   #define V4L2_PIX_FMT_AV1_FRAME v4l2_fourcc('A', 'V', '1', 'F') /* AV1 parsed frame */
> +#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '0', '1') /* AV1 */
>   #define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenson Spark */
>   #define V4L2_PIX_FMT_RV30     v4l2_fourcc('R', 'V', '3', '0') /* RealVideo 8 */
>   #define V4L2_PIX_FMT_RV40     v4l2_fourcc('R', 'V', '4', '0') /* RealVideo 9 & 10 */
> 
> --
> 2.34.1
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

