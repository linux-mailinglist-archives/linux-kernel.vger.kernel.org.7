Return-Path: <linux-kernel+bounces-880010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC62C24A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDEBA4F22FF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3486E3431EA;
	Fri, 31 Oct 2025 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U2oyjWhf"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4606E3431E4
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908086; cv=none; b=rXxozvmSe8DZblL+2cn61KpuU8vzxqY3nMHrLaPw0plXesK6o12sD5IgrCmtNvP+b6BoMho6CTVA9snIBpCg3wNhxUa231MdWWujkPK9D2Rcvd1XljvunExXvbxlnj9BsEjY7pJbais0cBsyqh6WsxD00GXAd9ynOeCpIoiZAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908086; c=relaxed/simple;
	bh=G3/YU1QordgrcT8LsqQ5yEAOA2Fbkwsq0D8nhkPPh44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Usenwhp/lVrAGdUtmBIDx1m806frSpZPbRRD50b22HyUgZMdgO6j10mna+Efjh8IyIRTztkQ8U5kECesKauGIjCeqzycn2YvXUKa2lTtPrq/VH7+gT7k68I6lEIchjJNgka2HCk1zKe3O2rF9RSniwmfp/3tU19nGQX5RW60KpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U2oyjWhf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475d9de970eso14504965e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761908082; x=1762512882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrx14+IMecvzAl4UiexDkJHLOgwmOpHv9KRq9o4Ztbk=;
        b=U2oyjWhfPZcGSkvBcWXDnN+o34YXVgN5rultADkRIjQwb2nxzMV3NuHeJDSNUwWTqh
         RGbTsgFomotZAvZZMDDAFFLmjUXyUGZNN39VeFoDM7QwydUsQlYmY/vOAJyW8jk/iFIE
         yWNWQf5k7S5dNNC50OfSt5Wi++CGetqkyiZY5jdQZldhgLJLX483Z9zf8lmV9N2Y7rXB
         HUSeljoLCl6gQhgnADiIjdFitFNXJdgNpH8+RHBY1uRjqepIXQa+L1UGSDTJjdOWcmvj
         0SWUPLtEeP4X1aF94xQxY/NGwf89akmb3zMX2QBfwaYQ3zScsE6RGCgvY1Ykl0V6p6e4
         +UsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761908083; x=1762512883;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nrx14+IMecvzAl4UiexDkJHLOgwmOpHv9KRq9o4Ztbk=;
        b=tFr9Q1Zag3OEI8KAKMYUZf2k+JzFHoo+Jn7h3LEkdvqC2clY7RH8tkg1eV4KptBeJo
         s1Etvb6qZ7u1cm/uFrXqRKEaaukCXB3JdsuETPijjOuRH0rDb2s50pGyRKo+lwiOcCe2
         QVl2XPWJ6kIqI20d87ihi6TpAYoLftcu9JbrD/8wHsXNUDbF0mMrvVQTz4NhF/Ff4bxL
         129QMNHOxjFO1Sy2o3dmCiCuRC94gJTIdoBCdfc60T4wEPiXrCrRPgCIoN6kuxi3u4MS
         GbL5JG0uf4KhnRQcvDmQMk+K9sJP87RRoahTS9kKc6qGWahNn+UZZeHKLVy8Rhp9BcbE
         02Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWkK9tfHURX8qPxdyzQsU9sMsPlUEUmK8iGUW0SqeE5XqARvgOMo0lVQ7JN9Fl5NmYeGKtLYvQBpz8xGYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDpFGQbpfAklvV6qJfgado1V6ww7dGuy5mtkLZ5vGR2wAivj0c
	rj0PynBAD9OskSYhBw8mi21bVtPh+iGVwIhMwHQrRyMEysysreIBrdUoIvWb9PAeV7U=
X-Gm-Gg: ASbGncuzh2eLCfehZK3R3NDPGPWtsz9QmRwMR6azPKibIdwAZAOwcB7CSlNFVNwzJdM
	b8p8uEAyi60lP9W7HiNJPWz7St5fbIrIde/2rMdXp11sSZp+s05IJDG94u/TRXmATWRTGogeEJ8
	C82Z8I2FTU8gIiwaZl8YTS3aOyrC9wErMpD5kuP9LmN6RwqvNVaVyxrBXeiz1h3HujC6dKzm55t
	mTopiScDdRkT3XWXjq9JIEu6pf+THs4MvO0pGWabQbNYwFABF5+nhOydlD3BgLoE+LU0KYT4Q+w
	4G2yO++87Y3s2uhA6nQMajojcgTGVEI+92k93n0IDKjnbHNvlOAydFtlGlGl/OPkL+h1TZIgrbi
	twdmZ77teQdL0JFopuTp8e8jqg4mRq4fT6i/4bcNbaAcg56+8ILgZCLz2A/NCZA5wzZ5sB9/q2c
	fK1JDa4fN+cnCuQhXYttA+ab+ScO9PQbI899K8mZ/+gxWKwbNWuz2gVLDROgxzYUg=
X-Google-Smtp-Source: AGHT+IH1qwkEmgqVmTN+ivxafY9W2GaHGk/oAp1YQ7VELJ5K8DOaakj6qrEcg5qy1AZEt18IlcwCmw==
X-Received: by 2002:a05:600c:3548:b0:471:16b1:b824 with SMTP id 5b1f17b1804b1-4773088be8bmr33966175e9.28.1761908082467;
        Fri, 31 Oct 2025 03:54:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:d967:2bcf:d2d0:b324? ([2a01:e0a:cad:2140:d967:2bcf:d2d0:b324])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732dc28d4sm26747545e9.1.2025.10.31.03.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 03:54:42 -0700 (PDT)
Message-ID: <796fa6dc-d2a0-4f9d-8dc2-6e64d90deddd@linaro.org>
Date: Fri, 31 Oct 2025 11:54:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 4/5] media: qcom: iris: Add flip support for encoder
To: Wangao Wang <wangao.wang@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
 quic_renjiang@quicinc.com
References: <20251031-iris_encoder_enhancements-v2-0-319cd75cbb45@oss.qualcomm.com>
 <20251031-iris_encoder_enhancements-v2-4-319cd75cbb45@oss.qualcomm.com>
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
In-Reply-To: <20251031-iris_encoder_enhancements-v2-4-319cd75cbb45@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 10:50, Wangao Wang wrote:
> Add support for V4L2_CID_HFLIP and V4L2_CID_VFLIP controls in encoder.
> 
> Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_ctrls.c      | 27 ++++++++++++++++++++++
>   drivers/media/platform/qcom/iris/iris_ctrls.h      |  1 +
>   .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  8 +++++++
>   .../platform/qcom/iris/iris_platform_common.h      |  2 ++
>   .../media/platform/qcom/iris/iris_platform_gen2.c  | 22 ++++++++++++++++++
>   5 files changed, 60 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
> index 00949c207ddb0203e51df359214bf23c3d8265d0..8f74c12f2f41f23d75424819c707aff61ea61b33 100644
> --- a/drivers/media/platform/qcom/iris/iris_ctrls.c
> +++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
> @@ -100,6 +100,10 @@ static enum platform_inst_fw_cap_type iris_get_cap_id(u32 id)
>   		return B_FRAME_QP_HEVC;
>   	case V4L2_CID_ROTATE:
>   		return ROTATION;
> +	case V4L2_CID_HFLIP:
> +		return HFLIP;
> +	case V4L2_CID_VFLIP:
> +		return VFLIP;
>   	default:
>   		return INST_FW_CAP_MAX;
>   	}
> @@ -189,6 +193,10 @@ static u32 iris_get_v4l2_id(enum platform_inst_fw_cap_type cap_id)
>   		return V4L2_CID_MPEG_VIDEO_HEVC_B_FRAME_QP;
>   	case ROTATION:
>   		return V4L2_CID_ROTATE;
> +	case HFLIP:
> +		return V4L2_CID_HFLIP;
> +	case VFLIP:
> +		return V4L2_CID_VFLIP;
>   	default:
>   		return 0;
>   	}
> @@ -917,6 +925,25 @@ int iris_set_rotation(struct iris_inst *inst, enum platform_inst_fw_cap_type cap
>   					     &hfi_val, sizeof(u32));
>   }
>   
> +int iris_set_flip(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id)
> +{
> +	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
> +	u32 hfi_id = inst->fw_caps[cap_id].hfi_id;
> +	u32 hfi_val = HFI_DISABLE_FLIP;
> +
> +	if (inst->fw_caps[HFLIP].value)
> +		hfi_val |= HFI_HORIZONTAL_FLIP;
> +
> +	if (inst->fw_caps[VFLIP].value)
> +		hfi_val |= HFI_VERTICAL_FLIP;
> +
> +	return hfi_ops->session_set_property(inst, hfi_id,
> +					     HFI_HOST_FLAGS_NONE,
> +					     iris_get_port_info(inst, cap_id),
> +					     HFI_PAYLOAD_U32_ENUM,
> +					     &hfi_val, sizeof(u32));
> +}
> +
>   int iris_set_properties(struct iris_inst *inst, u32 plane)
>   {
>   	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
> diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.h b/drivers/media/platform/qcom/iris/iris_ctrls.h
> index 3ea0a00c7587a516f19bb7307a0eb9a60c856ab0..355a592049f3fcc715a1b9df44b4d1398b052653 100644
> --- a/drivers/media/platform/qcom/iris/iris_ctrls.h
> +++ b/drivers/media/platform/qcom/iris/iris_ctrls.h
> @@ -33,6 +33,7 @@ int iris_set_max_qp(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_i
>   int iris_set_frame_qp(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
>   int iris_set_qp_range(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
>   int iris_set_rotation(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
> +int iris_set_flip(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
>   int iris_set_properties(struct iris_inst *inst, u32 plane);
>   
>   #endif
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> index 4edcce7faf5e2f74bfecfdbf574391d5b1c9cca5..0f92468dca91cbb2ca9b451ebce255180066b3a4 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> @@ -92,6 +92,14 @@ enum hfi_rotation {
>   };
>   
>   #define HFI_PROP_ROTATION			0x0300014b
> +
> +enum hfi_flip {
> +	HFI_DISABLE_FLIP    = 0x00000000,
> +	HFI_HORIZONTAL_FLIP = 0x00000001,
> +	HFI_VERTICAL_FLIP   = 0x00000002,
> +};
> +
> +#define HFI_PROP_FLIP				0x0300014c
>   #define HFI_PROP_SIGNAL_COLOR_INFO		0x03000155
>   #define HFI_PROP_PICTURE_TYPE			0x03000162
>   #define HFI_PROP_DEC_DEFAULT_HEADER		0x03000168
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index 9a4232b1c64eea6ce909e1e311769dd958b84c6e..284d6bde6d6bcdf70016646d1c92e6ae7f067efc 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -141,6 +141,8 @@ enum platform_inst_fw_cap_type {
>   	B_FRAME_QP_H264,
>   	B_FRAME_QP_HEVC,
>   	ROTATION,
> +	HFLIP,
> +	VFLIP,
>   	INST_FW_CAP_MAX,
>   };
>   
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> index c1f83e179d441c45df8d6487dc87e137e482fb63..e74bdd00a4bb2f457ec9352e0acaebc820dae235 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> @@ -598,6 +598,28 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8550_enc[] = {
>   		.flags = CAP_FLAG_OUTPUT_PORT,
>   		.set = iris_set_rotation,
>   	},
> +	{
> +		.cap_id = HFLIP,
> +		.min = 0,
> +		.max = 1,
> +		.step_or_mask = 1,
> +		.value = 0,
> +		.hfi_id = HFI_PROP_FLIP,
> +		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
> +			CAP_FLAG_DYNAMIC_ALLOWED,
> +		.set = iris_set_flip,
> +	},
> +	{
> +		.cap_id = VFLIP,
> +		.min = 0,
> +		.max = 1,
> +		.step_or_mask = 1,
> +		.value = 0,
> +		.hfi_id = HFI_PROP_FLIP,
> +		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
> +			CAP_FLAG_DYNAMIC_ALLOWED,
> +		.set = iris_set_flip,
> +	},
>   };
>   
>   static struct platform_inst_caps platform_inst_cap_sm8550 = {
> 

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

