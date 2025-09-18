Return-Path: <linux-kernel+bounces-781546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF0DB31388
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F4AEB67E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE2F2F360B;
	Fri, 22 Aug 2025 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9SsYYFh"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26D42F0C4C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855362; cv=none; b=lG0Ay3MHy2+LVu+T+Q+QbpZ8/T3/uJ+4KYu5HhQpf4MbguzMO2urLRdBgCeE8Foo+1ut6KvTaA3CTmI0QH9zPD93Xu8TJxkuzGTYzws3pTW0E/ZBGCRSk6ammN0ePC0xdDq3LGAduDcr1kkh7ntZW0QEBHnyUGhlL3+55oNuMmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855362; c=relaxed/simple;
	bh=MTlchUltgi318NL8GEvOv45DVuKXV+5fSlbX4wr8Va8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xu46nqZsmecQcRisx2n2KsXyswnUh5nwxCREKIWvueWy3M0Yw6eiSeBh8QNBG+DmCDfOwEH4oUFe1Q65CJCf5VytJRbiaw8Ymc1KhQqwW0GALZ1NjlpfuC22/RTzx9znrw5WVbTk5rBSGO3HxBSHlA8uADXq6tPH2cI52xFSGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M9SsYYFh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b00f23eso10961095e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855359; x=1756460159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxLpTKOOWK60iUyTwkthGNDuDdK23AvQqmpjQR3hIsQ=;
        b=M9SsYYFhoiU6GBPExsU90Qmm074iO7z8uPKWdCQwyB0EjROSR55fqemQ3glhZhwRd2
         i9N7p28BYTVLxIEiDkCWDzOlTxYyYi3t8+ghEqLeaFoRPJ4YAk4TRYz7CL2C2o0lQake
         6cavriNqS3jeWbJiAhlVCsKULCO4xrzQ67acb8Li5vYRQjBr3e1Q+YtvilCF6rMP8R3k
         2afQOo/PH0X+zLA9uZJdJshwtzy9D4LykTDhH9fhW50GsjlvlwydLKp2/jkmulIXjdfV
         iLAPcnBMGyhrvmxlE4A65eiK6kUKM5ouinxnvqLld5HfMmxHN7uCIo+yF+hRGBq7UQq5
         rOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855359; x=1756460159;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZxLpTKOOWK60iUyTwkthGNDuDdK23AvQqmpjQR3hIsQ=;
        b=t0Sx1WE+oz6CikpNetDUr3BUULNhqFQYihP9D/noDaVB4GX/OWctLLxTOIJnd72ARk
         h6PegzqI4bgFhkzZw9E4aVDIFfCY+R50HNm3u+1gLD7KVSMeKc06gADRD/NvOUTGkLB1
         nULIb3wYmVIVPH/VCr0eNQhVQ6ieU23ms0gOxbx0dSALtuxxDMOU4aOVlD9vDtqkt2Lu
         xuZQ7UKmiFCFm3qDQL93rl93zLnQLWzOZNzhGuTO7YEjxcpqHWmytjtuydE1BpoQlRrd
         eUedMQknrBABKXapJrv/eeFXRAOkO36GmKindiWxqrnpi+HjZD9KHaS4sOQ9UYyc/zsY
         rQDw==
X-Forwarded-Encrypted: i=1; AJvYcCUo33lzUCx//ECFhxH+3qp/srdjsKrbBY1f2aQOgppLtJcOAPZqo2uZXeZ9DrNxmTBRqWxNAJIngEn1db4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuilCGtiRITO8WHsyicyiZwqo8k3uSy/pzAzU/9H5EtQwCJe2s
	lxWiRgoNicgkHEkeKyRTkmVpaYaQeZ/lK5fYoJIveKhpa3F+yWBt1K532yS1QT5CVRo=
X-Gm-Gg: ASbGncvIU1DHhRsTW5f7EtcP4xG9/RZp9gc+0HitMF11vmEG6uy53/yMquIrLy5YXBS
	tD8SY3HNp/S5woUVw/6bwM7pXxtY6WID9ed0s7EJaIchzJ1tfp8+IVbToxo5k5lV07r9efPqOBj
	d5VZSb4AqHviKFmirbZBE3K4+A2dt0OttiC4b6Vy9vrYL3TiPEqIfCPQSQsdS3oDE2GygR4yY1z
	hafbcCnMSwiumz6F6CX2K9GnyLgNvewmGIxx6rP84OCU3yxi1IIHYhM83wZymYBke5+RhOBx70j
	9JB8z1Ke720O0gdFMh4mQAC71gY0ZR2OOhcSAy9pKO1RpJY+RQDR/h4s4HqXorb4fDyNnq2joIm
	N8Gk/HadmVZHzAT8wK8LCnTrvAD9pmu2tPpdWjXRDnlVwszWkXxAxYhdVQa0pq0F6iWS1bMMRUg
	Y=
X-Google-Smtp-Source: AGHT+IFovM2SabCJH2b5MRiF8TjGggfusVSGcoBGMzu394048iNqTSwG6Bm7+5IKEuykg1H96jwtJA==
X-Received: by 2002:a05:600c:5491:b0:459:db80:c2d0 with SMTP id 5b1f17b1804b1-45b517954ddmr17227815e9.7.1755855359262;
        Fri, 22 Aug 2025 02:35:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3dd7:7361:c101:6a77? ([2a01:e0a:3d9:2080:3dd7:7361:c101:6a77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50e42433sm28546625e9.23.2025.08.22.02.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 02:35:58 -0700 (PDT)
Message-ID: <cae41451-39ca-4538-a74c-39701d30073f@linaro.org>
Date: Fri, 22 Aug 2025 11:35:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 04/10] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
 Add missing pinctrl for eDP HPD
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
 Abel Vesa <abel.vesa@linaro.org>, Xilin Wu <wuxilin123@gmail.com>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 Srinivas Kandagatla <srini@kernel.org>, Sibi Sankar
 <quic_sibis@quicinc.com>, Rajendra Nayak <quic_rjendra@quicinc.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Christopher Obbard <christopher.obbard@linaro.org>
References: <20250822-x1e80100-add-edp-hpd-v2-0-6310176239a6@linaro.org>
 <20250822-x1e80100-add-edp-hpd-v2-4-6310176239a6@linaro.org>
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
In-Reply-To: <20250822-x1e80100-add-edp-hpd-v2-4-6310176239a6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/08/2025 11:28, Stephan Gerhold wrote:
> At the moment, we indirectly rely on the boot firmware to set up the
> pinctrl for the eDP HPD line coming from the internal display. If the boot
> firmware does not configure the display (e.g. because a different display
> is selected for output in the UEFI settings), then the display fails to
> come up and there are several errors in the kernel log:
> 
>   [drm:dpu_encoder_phys_vid_wait_for_commit_done:544] [dpu error]vblank timeout: 80020041
>   [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
>   [drm:dpu_encoder_frame_done_timeout:2715] [dpu error]enc40 frame done timeout
>   ...
> 
> Fix this by adding the missing pinctrl for gpio119 (func1/edp0_hot and
> bias-disable according to the ACPI DSDT), which is defined as
> &edp0_hpd_default template in x1e80100.dtsi.
> 
> Fixes: 7d1cbe2f4985 ("arm64: dts: qcom: Add X1E78100 ThinkPad T14s Gen 6")
> Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
> Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> index 4cf61c2a34e31233b1adc93332bcabef22de3f86..76d491f085db2eb6ba8c8358063882611446ae72 100644
> --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> @@ -1010,6 +1010,9 @@ &mdss_dp1_out {
>   &mdss_dp3 {
>   	/delete-property/ #sound-dai-cells;
>   
> +	pinctrl-0 = <&edp0_hpd_default>;
> +	pinctrl-names = "default";
> +
>   	status = "okay";
>   
>   	aux-bus {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Lenovo Thinkpad T14s OLED

