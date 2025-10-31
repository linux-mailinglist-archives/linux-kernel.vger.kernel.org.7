Return-Path: <linux-kernel+bounces-880062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 662A8C24C82
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46BB94E655A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D35345CD1;
	Fri, 31 Oct 2025 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/wCXEIJ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6F125A0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910235; cv=none; b=fi/Nzy7t/YcA+6IudDppJ7n6t19MIPB/BJnrxdUsaIdq2EEpftiX0r8s1XLCt6s20Zyr/lwQQvozcoAQfOBxtB6RPsgpUVYHJ/qJ8siTgv6MKrQlxmPbVEi5MYgtS8jx5vOwu0GYarxrSjghfOb7N7Lcr7HaQ9/SfQsf+iQxabg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910235; c=relaxed/simple;
	bh=ie6znrCNK/LudrsUZPQiI7XbOx2sgL5YtdTO4JVi7QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEYqW3iM/wBawj7voB1X8hNB+aPzmJdcJfbsBOvRyPXpPEEYQDRDUjh0PRTstCLo56DAUYR2dU0g1ImU0u3iUzJ6xmuBghX/4bIFFbQe5OXz0oelvuyr79FUGraIoMmvrxQU4fPDQyZ+LwBZeoBrh/ArKwiPp+9aoUD19bqUqjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d/wCXEIJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429b72691b4so1928632f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761910232; x=1762515032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tS2PhZL7XUJM1s7RUQ3B94skBzEvBjGc+MR5GlYC1yQ=;
        b=d/wCXEIJx19dO2JG5Dv5LaTheMvlX/svqSlWf97HyNXJVwV0Ezs5jXdga7pAoN61nk
         WxHYGhTfHESeOAteydGzM0ikyX34Q3qm0jLfE+CRjevPrkhhgaP/MvD1h4GKtNFGMNGb
         vF93fg1EyOoWvdKBapOyOb5JWYoC/Zb7GAWn6wAPlV/6Cp48lrK1vC+V8e9CjuTDAhnF
         JapIPYm+om+s8OUSaAksWMApzfz2ZolWzhuXHCCwZ0Yx1Zj8hm5dGic08A43is21VER2
         996+m+uK2WxmSWG+KWjhT3iekAJkzdKj0Yfikfpe3VNyBS+kCaXeH1u3KuiqXZjj2pHA
         jxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761910232; x=1762515032;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tS2PhZL7XUJM1s7RUQ3B94skBzEvBjGc+MR5GlYC1yQ=;
        b=uPzkvp/JOU1kQqteig8CN6wJo5jzcM9Ot5m6GWn3js+mkoeKZUhM69CgYwq7sQ0x3L
         xpF9k9+cYpS/BKUj3o3L3A3WIIZomNB4P6b95GN+d7IwW3cp1po1mmrLrOkMclE0dCXF
         TtOuqccfR/4nleqGLJwAgdP/3SBxi0IR4KMpYfMiY0xBaNzNQ66ZseA5+8EqlQYtb4sv
         boQJw9anrzCU4yKe6sqfgGbNHnJPlJAQPxyhrpBmC6c/02ol5o4osgOKMKdo3D+ONuUV
         i4/WiX/d9pVzyEzqmVR6a6k7nnFfRgZruZPQRxBMwNlpgh8Ri2hriKv6OkdDbcEMZRW2
         9bwg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ+QT5jxDpvsuuD0ONKF5OUMTbxtS4av05kAZInjVPwK6kPKOF0tTCe7cK1SSv2LXifCRBsjVEQZ1mkyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsCPBmv/QxCZHJw5Qp3F+7uu4aLwHv0kEcto6P0TLsMog5epJO
	Pmw/6R1QPAzAmuCs+EIIqq0f7B0T1N+hLFu6fir/z4HWTl11RIe2bfXZX4/f/p6NPtM=
X-Gm-Gg: ASbGnctHawpSCOLSKnSbGrGAnutkSPF1k3ZrMNCIOrzW3drMTTMK5YwzgEIMiQ8N+M7
	nknBgWyi7eWEjl5ZQqRQrjgiF50PFjW7MJKWPvF2DHAff40B19jioyJT4B/pehwOee0+sgMQo5c
	duX8LqwS//pDCziHtYwvAFoZafkRyXDzOFAfPpX1ICClkmSlGGZEe+uhw1os0NY8Qu7r9exexpP
	m8nJCA1AtiL4Gal5m3niXFFk/quo8cxoXB948+vtilS4wQ0w/rpQ7fJbAILXHQ7nBPfXNpbDZU0
	FUBsSpz6WlLeXpN0RtMR2UosS8KjVNNVyI+dxdd/ufcypmh4x6e2QmHGRB1d7bb5/e/Zy8Vt6KA
	zwJ3AC+Ag+VTeqLmLKXnc/JY4GAi0PM5Up77Yf5ozEDBDd+L/fv+fDwOOUh5kcBkil+PVQubFjm
	g6ZNNDhHy1g58ZZj6XmH6B3QxHHngNq2rJ3jAWljZ99NY6XH3sDWzvEbJMYQ4U3xY=
X-Google-Smtp-Source: AGHT+IF+iyyElco9VXyBMXEb9lk4ZkcEAKDKdVRl2XQBakgbVhtW1KsvgNAXUuNVlzzQYwQqI5cl8w==
X-Received: by 2002:a5d:5d11:0:b0:425:825d:2c64 with SMTP id ffacd0b85a97d-429bd6801aamr2396129f8f.17.1761910231450;
        Fri, 31 Oct 2025 04:30:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:d967:2bcf:d2d0:b324? ([2a01:e0a:cad:2140:d967:2bcf:d2d0:b324])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732ddd2d5sm27795365e9.7.2025.10.31.04.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 04:30:31 -0700 (PDT)
Message-ID: <1d653876-2df0-4177-8256-00905148fb46@linaro.org>
Date: Fri, 31 Oct 2025 12:30:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 3/5] media: qcom: iris: Add rotation support for
 encoder
To: Wangao Wang <wangao.wang@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
 quic_renjiang@quicinc.com
References: <20251031-iris_encoder_enhancements-v2-0-319cd75cbb45@oss.qualcomm.com>
 <20251031-iris_encoder_enhancements-v2-3-319cd75cbb45@oss.qualcomm.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20251031-iris_encoder_enhancements-v2-3-319cd75cbb45@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 10:50, Wangao Wang wrote:
> Add rotation control for encoder, enabling V4L2_CID_ROTATE and handling
>   90/180/270 degree rotation.
> 
> Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_ctrls.c      | 34 ++++++++++++++++
>   drivers/media/platform/qcom/iris/iris_ctrls.h      |  1 +
>   .../platform/qcom/iris/iris_hfi_gen2_command.c     | 41 ++++++++++++++-----
>   .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  9 +++++
>   .../platform/qcom/iris/iris_platform_common.h      |  1 +
>   .../media/platform/qcom/iris/iris_platform_gen2.c  | 10 +++++
>   drivers/media/platform/qcom/iris/iris_utils.c      |  6 +++
>   drivers/media/platform/qcom/iris/iris_utils.h      |  1 +
>   drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 46 +++++++++++++---------
>   9 files changed, 121 insertions(+), 28 deletions(-)
> 

<snip>

>   
>   	if (inst->codec == V4L2_PIX_FMT_HEVC) {
> @@ -1051,9 +1064,8 @@ u32 hfi_buffer_line_enc_vpu33(u32 frame_width, u32 frame_height, bool is_ten_bit
>   static u32 iris_vpu_enc_line_size(struct iris_inst *inst)
>   {
>   	u32 num_vpp_pipes = inst->core->iris_platform_data->num_vpp_pipe;
> -	struct v4l2_format *f = inst->fmt_dst;
> -	u32 height = f->fmt.pix_mp.height;
> -	u32 width = f->fmt.pix_mp.width;
> +	u32 height = iris_vpu_enc_get_bitstream_height(inst);
> +	u32 width = iris_vpu_enc_get_bitstream_width(inst);

I found the issue with SM8650, you did not update the vppu33 variant of iris_vpu_enc_line_size.

With this:
============================><=============================
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
index be8b8588a39f..4a4fbcbfdb46 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
@@ -1082,8 +1082,8 @@ static u32 iris_vpu33_enc_line_size(struct iris_inst *inst)
  {
         u32 num_vpp_pipes = inst->core->iris_platform_data->num_vpp_pipe;
         struct v4l2_format *f = inst->fmt_dst;
-       u32 height = f->fmt.pix_mp.height;
-       u32 width = f->fmt.pix_mp.width;
+       u32 height = iris_vpu_enc_get_bitstream_height(inst);
+       u32 width = iris_vpu_enc_get_bitstream_width(inst);
         u32 lcu_size = 16;

         if (inst->codec == V4L2_PIX_FMT_HEVC) {
============================><=============================

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

Neil


<snip>


