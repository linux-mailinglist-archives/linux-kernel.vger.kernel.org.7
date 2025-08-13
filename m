Return-Path: <linux-kernel+bounces-766984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B320DB24D68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2826B171531
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C66F23E32E;
	Wed, 13 Aug 2025 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/jh0tFg"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003BA237707
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098868; cv=none; b=WF47Gkl/RzFxj9At5Zo66h/WqHkqpkaCojq/SpNji+000WDdV1JT0QZUKiY+NSK6KIo9+QkxswxJD/vdYa0k9+Iz5sYMuipS43KjffwokKd0TVU2cjLkBat8wTUJdnerN3CevRaS/ewc3EMmxff4wn9CcxfQU+xni6v8Df6/nbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098868; c=relaxed/simple;
	bh=Lzac6iPMPMkmcukIyTQAqLBbU0BSbzL5A4RpEQJBcsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m61UpE+8JZRd5SIAUFQjCo8lWrmVfTqVhOn5uWSKbKi1CMpEvIiUfBW6mr2y8mJSdz/vSUfcuunJeZt7EthjR6LV/26giBb+ftcTK8QAIpLNa3Ux1cBA1iO9VlhVxv5IXEa5ZMlxy4ecchkuwA8I158pnclF61tfmAhN2/LmRFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q/jh0tFg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b792b0b829so6756918f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755098864; x=1755703664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCkdDKNXq6wDLo33MR/q2Ghmev4Km5m3xCZgpzHMzdc=;
        b=Q/jh0tFgofTQ7b1duayrMvbaTGQns0i0c0jT2HzNVJnWM4/BOb7sADC/jkSTvKnRon
         dmyXmUV3FczYbki1cntf4JNEMCSUwTFxEzyrQAkB7i8BKmWhH7ANSWw0FjrbyOVAlUoe
         M994Gmu/5O9rUiZyIg8xVmq8nKrtOMJIlCr92K93tE23l5LrxMDreQQip08VFl/IXmuO
         mvf9AE1ECrXi1nzKnXNdOlevc3nCKvIzPZBSVlTvhoovG0lwPFYRagkQDTa1SZ8niku+
         pogDRhtdo2RAPERq7nvLWyfb42rbE6upImBA1rLsaC6Wi6bqNKHPXMwIJ4axI0BIcMlw
         wLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098864; x=1755703664;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rCkdDKNXq6wDLo33MR/q2Ghmev4Km5m3xCZgpzHMzdc=;
        b=i7HrjyNtyZIBIAnlxeKlyhKt57jP83zEkFfa4PWEqsoQ2A/DBBabyI8J+s8SckEya+
         xQVFZ2zHfJ0gwE4IA+unS6pr4ZjgtwKjQG2Nr+j3YSWf0SqpBOv7bDmgakodFdxtuoQo
         QQ3Vp82xoxJl8rnaZUMgzpQwfdjB+w4c27vGOulDKuQt1FWhf51o3h0KloEMkt9lLoRC
         zVx49i+vQWndN2sc56xfR9d37poNnOSwr5hMcOYNzUGBulrzbgjieNNPeaZ1vjq2Kqld
         4MbEpR6yWFZGB0Qf3C5RgffnSa4f1BqBlIAeyz7cElV6NLTfzmwbNGxoG6esIV2+dPhX
         EtiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2SeV8CIU3NPr9L526eAHaQM4Fvx4KfEE1rUyvommiMDBGr6Khzi2fa4cLHTWW1yHr6r54Nio6LPV6W/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxA600tSMr1vrTk4Dl6mgBVSZmUK3K8U4s0GabFyM5G50lbTwf
	JvFn6EMd1uel3L5v5fzcjik5JEzqpNFMcpY0GQZ584kpTWh2lZ9UT6dzLTx0p6vaoOWmhQuqf8L
	Vsh1w
X-Gm-Gg: ASbGncspxxVcF1Rnfg+QitSShIFPkWTzpfxhxb+tbvKvX1LtM8Vo+n3ZUd2Ss1I1HVl
	bZFwoUk2rS/3yIWpy4s+QncFjZrzHrqA3LTpFiYl+MGdpZXRtKyrzZpDlNmCbzMJqEJC+vZVaA1
	XU5SopU9X9ZzmprgL2kQm+9fg4ks0hPsZscU33Y+lddr/KDbZvmE7J+3lIc+RmQCGHWjHnquMYb
	qQlEM7r7WoWD9ZoBba95TI0+nLSjkuG18jGgw0B815ZPGWdiquCDwibIdTa9knl0FHxr22yPtOg
	G7F56lBhxIjd3d/pJYemg8bJEy9ILDCbcsOOonhqpAAGpxPUDOX2bd263sK0URMddRVat4WLxM4
	L7e/+OSJqEz8oxEfneq2BTfrVA0fBqBfMElBKERbJ7ZEbO1X+0kx3GNwsUM+kzH5AmpJ2pPfd
X-Google-Smtp-Source: AGHT+IEaxxsDJSIT1CBL80NvUz4xR3hSUZrp1Jw94CaqbYGz2T9SEUFylnlaIJ55Xlc3dxSYVJJ0tA==
X-Received: by 2002:a05:6000:4203:b0:3b9:1443:aba with SMTP id ffacd0b85a97d-3b917e76c0cmr2844288f8f.9.1755098864210;
        Wed, 13 Aug 2025 08:27:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3667:2ab1:8ff9:d6e? ([2a01:e0a:3d9:2080:3667:2ab1:8ff9:d6e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c46ee84sm46821722f8f.57.2025.08.13.08.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:27:43 -0700 (PDT)
Message-ID: <3f60cd7a-c9af-423e-81ec-678ba441dbc9@linaro.org>
Date: Wed, 13 Aug 2025 17:27:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 00/24] Enable H.264/H.265 encoder support and fixes in
 common code
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Stefan Schmidt <stefan.schmidt@linaro.org>,
 Vedang Nagar <quic_vnagar@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Renjiang Han <quic_renjiang@quicinc.com>,
 Wangao Wang <quic_wangaow@quicinc.com>
References: <20250813-iris-video-encoder-v2-0-c725ff673078@quicinc.com>
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
In-Reply-To: <20250813-iris-video-encoder-v2-0-c725ff673078@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2025 11:37, Dikshita Agarwal wrote:
> Hi All,
> 
> This patch series adds support for H.264 and H.265 encoder in iris
> driver and includes a few fixes and cleanup in the common code that were
> identified during encoder bring-up process.
> 
> The changes include:
> - Enabling support for H.264 and H.265 encoding.
> - Fixes and improvements in shared componenets used by both encoder and
> decoder paths.
> - Ensuring compatibility and stability with the existing decoder flow.
> 
> Changes in v2:
> - Fixed sparse/coccinnelle issues.
> - Fixed the kernel doc warning.
> - Removed unsupported PEAK_BITRATE property from SM8250.
> - Dropped patch 04/25 to fix quality issue with encoder.
> - Enhanced command handling for encoder to allow start/stop commands.
> - Expanded rate control condition checks to include additional rate
>    control types for HFI Gen2.
> - Updated default value to MAX_QP for all caps related to max QP settings.
> - Add support for INPUT/OUTPUT_BUF_HOST_MAX_COUNT caps for encoder.
> - Link to v1: https://lore.kernel.org/r/20250704-iris-video-encoder-v1-0-b6ce24e273cf@quicinc.com
> 
> All patches have been tested with v4l2-compliance, v4l2-ctl and
> Gstreamer on SM8250 and SM8550 for encoder, at the same time ensured
> that the existing decoder functionality remains uneffected.
> 
> Commands used for V4l2-ctl validation:
> 
> v4l2-ctl --verbose --set-fmt-video-out=width=1280,height=720,pixelformat=NV12
> --set-selection-output target=crop,top=0,left=0,width=1280,height=720
> --set-fmt-video=pixelformat=H264 --stream-mmap --stream-out-mmap
> --stream-from=/media/cyclists_1280x720_92frames.yuv
> --stream-to=/tmp/cyclists_1280x720_92frames.h264 -d /dev/video1
> 
> v4l2-ctl --verbose --set-fmt-video-out=width=1280,height=720,pixelformat=NV12
> --set-selection-output target=crop,top=0,left=0,width=1280,height=720
> --set-fmt-video=pixelformat=HEVC --stream-mmap --stream-out-mmap
> --stream-from=/media/cyclists_1280x720_92frames.yuv
> --stream-to=/tmp/cyclists_1280x720_92frames.hevc -d /dev/video1
> 
> Commands used for GST validation:
> 
> gst-launch-1.0 -v filesrc location=/media/cyclists_1280x720_92frames.yuv !
> rawvideoparse format=nv12 width=1280 height=720 framerate=30/1 ! v4l2h264enc
> capture-io-mode=4 output-io-mode=4 ! filesink sync=true
> location=/tmp/gst_cyclists_1280x720_92frames.h264
> 
> gst-launch-1.0 -v filesrc location=/media/cyclists_1280x720_92frames.yuv !
> rawvideoparse format=nv12 width=1280 height=720 framerate=30/1 ! v4l2h265enc
> capture-io-mode=4 output-io-mode=4 ! filesink sync=true
> location=/tmp/gst_cyclists_1280x720_92frames.hevc
> 
> The result of v4l2-compliance on SM8550:
> v4l2-compliance 1.29.0-5270, 64 bits, 64-bit time_t
> v4l2-compliance SHA: dc947661089e 2024-11-11 10:25:38
> 
> Compliance test for iris_driver device /dev/video1:
> 
> Driver Info:
>          Driver name      : iris_driver
>          Card type        : Iris Encoder
>          Bus info         : platform:aa00000.video-codec
>          Driver version   : 6.16.0
>          Capabilities     : 0x84204000
>                  Video Memory-to-Memory Multiplanar
>                  Streaming
>                  Extended Pix Format
>                  Device Capabilities
>          Device Caps      : 0x04204000
>                  Video Memory-to-Memory Multiplanar
>                  Streaming
>                  Extended Pix Format
>          Detected Stateful Encoder
> 
> Required ioctls:
>          test VIDIOC_QUERYCAP: OK
>          test invalid ioctls: OK
> 
> Allow for multiple opens:
>          test second /dev/video1 open: OK
>          test VIDIOC_QUERYCAP: OK
>          test VIDIOC_G/S_PRIORITY: OK
>          test for unlimited opens: OK
> 
> Debug ioctls:
>          test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>          test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
>          test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>          test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>          test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>          test VIDIOC_ENUMAUDIO: OK (Not Supported)
>          test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
>          test VIDIOC_G/S_AUDIO: OK (Not Supported)
>          Inputs: 0 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
>          test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>          test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>          test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>          test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>          test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>          Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
>          test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>          test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>          test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>          test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls:
>          test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>          test VIDIOC_QUERYCTRL: OK
>          test VIDIOC_G/S_CTRL: OK
>          test VIDIOC_G/S/TRY_EXT_CTRLS: OK
>          test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>          test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>          Standard Controls: 37 Private Controls: 0
> 
> Format ioctls:
>          test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>          test VIDIOC_G/S_PARM: OK
>          test VIDIOC_G_FBUF: OK (Not Supported)
>          test VIDIOC_G_FMT: OK
>          test VIDIOC_TRY_FMT: OK
>          test VIDIOC_S_FMT: OK
>          test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>          test Cropping: OK
>          test Composing: OK (Not Supported)
>          test Scaling: OK (Not Supported)
> 
> Codec ioctls:
>          test VIDIOC_(TRY_)ENCODER_CMD: OK
>          test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>          test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> 
> Buffer ioctls:
>          test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>          test CREATE_BUFS maximum buffers: OK
>          test VIDIOC_REMOVE_BUFS: OK
>          test VIDIOC_EXPBUF: OK
>          test Requests: OK (Not Supported)
>          test blocking wait: OK
> 
> Test input 0:
> 
> Streaming ioctls:
>          test read/write: OK (Not Supported)
>          Video Capture Multiplanar: Captured 61 buffers
>          test MMAP (select, REQBUFS): OK
>          Video Capture Multiplanar: Captured 61 buffers
>          test MMAP (epoll, REQBUFS): OK
>          Video Capture Multiplanar: Captured 61 buffers
>          test MMAP (select, CREATE_BUFS): OK
>          Video Capture Multiplanar: Captured 61 buffers
>          test MMAP (epoll, CREATE_BUFS): OK
>          test USERPTR (select): OK (Not Supported)
>          test DMABUF: Cannot test, specify --expbuf-device
> 
> Total for iris_driver device /dev/video1: 54, Succeeded: 54, Failed: 0, Warnings: 0
> 
> The result of v4l2-compliance on SM8250:
> v4l2-compliance 1.29.0-5270, 64 bits, 64-bit time_t
> v4l2-compliance SHA: dc947661089e 2024-11-11 10:25:38
> 
> Compliance test for iris_driver device /dev/video1:
> 
> Driver Info:
>          Driver name      : iris_driver
>          Card type        : Iris Encoder
>          Bus info         : platform:aa00000.video-codec
>          Driver version   : 6.16.0
>          Capabilities     : 0x84204000
>                  Video Memory-to-Memory Multiplanar
>                  Streaming
>                  Extended Pix Format
>                  Device Capabilities
>          Device Caps      : 0x04204000
>                  Video Memory-to-Memory Multiplanar
>                  Streaming
>                  Extended Pix Format
>          Detected Stateful Encoder
> 
> Required ioctls:
>          test VIDIOC_QUERYCAP: OK
>          test invalid ioctls: OK
> 
> Allow for multiple opens:
>          test second /dev/video1 open: OK
>          test VIDIOC_QUERYCAP: OK
>          test VIDIOC_G/S_PRIORITY: OK
>          test for unlimited opens: OK
> 
> Debug ioctls:
>          test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>          test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
>          test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>          test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>          test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>          test VIDIOC_ENUMAUDIO: OK (Not Supported)
>          test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
>          test VIDIOC_G/S_AUDIO: OK (Not Supported)
>          Inputs: 0 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
>          test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>          test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>          test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>          test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>          test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>          Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
>          test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>          test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>          test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>          test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls:
>          test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>          test VIDIOC_QUERYCTRL: OK
>          test VIDIOC_G/S_CTRL: OK
>          test VIDIOC_G/S/TRY_EXT_CTRLS: OK
>          test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>          test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>          Standard Controls: 19 Private Controls: 0
> 
> Format ioctls:
>          test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>          test VIDIOC_G/S_PARM: OK
>          test VIDIOC_G_FBUF: OK (Not Supported)
>          test VIDIOC_G_FMT: OK
>          test VIDIOC_TRY_FMT: OK
>          test VIDIOC_S_FMT: OK
>          test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>          test Cropping: OK
>          test Composing: OK (Not Supported)
>          test Scaling: OK (Not Supported)
> 
> Codec ioctls:
>          test VIDIOC_(TRY_)ENCODER_CMD: OK
>          test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>          test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> 
> Buffer ioctls:
>          test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>          test CREATE_BUFS maximum buffers: OK
>          test VIDIOC_REMOVE_BUFS: OK
>          test VIDIOC_EXPBUF: OK
>          test Requests: OK (Not Supported)
>          test blocking wait: OK
> 
> Test input 0:
> 
> Streaming ioctls:
>          test read/write: OK (Not Supported)
>          Video Capture Multiplanar: Captured 61 buffers
>          test MMAP (select, REQBUFS): OK
>          Video Capture Multiplanar: Captured 61 buffers
>          test MMAP (epoll, REQBUFS): OK
>          Video Capture Multiplanar: Captured 61 buffers
>          test MMAP (select, CREATE_BUFS): OK
>          Video Capture Multiplanar: Captured 61 buffers
>          test MMAP (epoll, CREATE_BUFS): OK
>          test USERPTR (select): OK (Not Supported)
>          test DMABUF: Cannot test, specify --expbuf-device
> 
> Total for iris_driver device /dev/video1: 54, Succeeded: 54, Failed: 0, Warnings: 0
> 
> Looking forward to your review and feedback.
> 
> Thanks,
> Dikshita
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
> Dikshita Agarwal (24):
>        media: iris: Fix buffer count reporting in internal buffer check
>        media: iris: Report unreleased PERSIST buffers on session close
>        media: iris: Fix memory leak by freeing untracked persist buffer
>        media: iris: Fix port streaming handling
>        media: iris: Allow substate transition to load resources during output streaming
>        media: iris: Always destroy internal buffers on firmware release response
>        media: iris: Update vbuf flags before v4l2_m2m_buf_done
>        media: iris: Allow stop on firmware only if start was issued.
>        media: iris: Send dummy buffer address for all codecs during drain
>        media: iris: Fix missing LAST flag handling during drain
>        media: iris: Add support for video encoder device
>        media: iris: Initialize and deinitialize encoder instance structure
>        media: iris: Add support for ENUM_FMT, S/G/TRY_FMT encoder
>        media: iris: Add support for ENUM_FRAMESIZES/FRAMEINTERVALS for encoder
>        media: iris: Add support for VIDIOC_QUERYCAP for encoder video device
>        media: iris: Add encoder support for V4L2 event subscription
>        media: iris: Add support for G/S_SELECTION for encoder video device
>        media: iris: Add support for G/S_PARM for encoder video device
>        media: iris: Add platform-specific capabilities for encoder video device
>        media: iris: Add V4L2 streaming support for encoder video device
>        media: iris: Set platform capabilities to firmware for encoder video device
>        media: iris: Allocate and queue internal buffers for encoder video device
>        media: iris: Add support for buffer management ioctls for encoder device
>        media: iris: Add support for drain sequence in encoder video device
> 
>   drivers/media/platform/qcom/iris/Makefile          |   5 +-
>   drivers/media/platform/qcom/iris/iris_buffer.c     | 220 ++++--
>   drivers/media/platform/qcom/iris/iris_buffer.h     |   7 +-
>   drivers/media/platform/qcom/iris/iris_common.c     | 232 ++++++
>   drivers/media/platform/qcom/iris/iris_common.h     |  18 +
>   drivers/media/platform/qcom/iris/iris_core.h       |  20 +-
>   drivers/media/platform/qcom/iris/iris_ctrls.c      | 675 +++++++++++++++-
>   drivers/media/platform/qcom/iris/iris_ctrls.h      |  15 +
>   drivers/media/platform/qcom/iris/iris_hfi_common.h |   2 +-
>   .../platform/qcom/iris/iris_hfi_gen1_command.c     | 485 +++++++++---
>   .../platform/qcom/iris/iris_hfi_gen1_defines.h     | 112 ++-
>   .../platform/qcom/iris/iris_hfi_gen1_response.c    |  60 +-
>   .../platform/qcom/iris/iris_hfi_gen2_command.c     | 357 ++++++---
>   .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  44 +-
>   .../platform/qcom/iris/iris_hfi_gen2_response.c    |  46 +-
>   drivers/media/platform/qcom/iris/iris_instance.h   |  24 +
>   .../platform/qcom/iris/iris_platform_common.h      |  74 +-
>   .../media/platform/qcom/iris/iris_platform_gen2.c  | 522 ++++++++++++-
>   .../platform/qcom/iris/iris_platform_qcs8300.h     | 352 ++++++++-
>   .../platform/qcom/iris/iris_platform_sm8250.c      | 234 +++++-
>   drivers/media/platform/qcom/iris/iris_probe.c      |  39 +-
>   drivers/media/platform/qcom/iris/iris_state.c      |   9 +-
>   drivers/media/platform/qcom/iris/iris_state.h      |   1 +
>   drivers/media/platform/qcom/iris/iris_utils.c      |  36 +
>   drivers/media/platform/qcom/iris/iris_utils.h      |   2 +
>   drivers/media/platform/qcom/iris/iris_vb2.c        |  58 +-
>   drivers/media/platform/qcom/iris/iris_vdec.c       | 249 +-----
>   drivers/media/platform/qcom/iris/iris_vdec.h       |  13 +-
>   drivers/media/platform/qcom/iris/iris_venc.c       | 579 ++++++++++++++
>   drivers/media/platform/qcom/iris/iris_venc.h       |  27 +
>   drivers/media/platform/qcom/iris/iris_vidc.c       | 299 +++++++-
>   drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 847 ++++++++++++++++++++-
>   drivers/media/platform/qcom/iris/iris_vpu_buffer.h |  20 +
>   33 files changed, 4970 insertions(+), 713 deletions(-)
> ---
> base-commit: c26e8dcd9d4e86d788c5bf7a5dd0ea70a95ab067
> change-id: 20250704-iris-video-encoder-b193350b487a
> 
> Best regards,

I have a successfull encoding on SM8650-HDK with the following commands (ffmpegs segfaults en encoding):

wget https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/1080/Big_Buck_Bunny_1080_10s_30MB.mp4 -O Big_Buck_Bunny_1080_10s_30MB_h264.mp4
ffmpeg -c:v h264_v4l2m2m -i Big_Buck_Bunny_1080_10s_30MB_h264.mp4 -pix_fmt nv12 Big_Buck_Bunny_1080_10s.yuv
v4l2-ctl --verbose --set-fmt-video-out=width=1920,height=1080,pixelformat=NV12 --set-selection-output target=crop,top=0,left=0,width=1920,height=1080 --set-fmt-video=pixelformat=H264 --stream-mmap --stream-out-mmap --stream-from=Big_Buck_Bunny_1080_10s.yuv --stream-to=Big_Buck_Bunny_1080_10s.h264 -d /dev/video1
v4l2-ctl --verbose --set-fmt-video-out=width=1920,height=1080,pixelformat=NV12 --set-selection-output target=crop,top=0,left=0,width=1920,height=1080 --set-fmt-video=pixelformat=HEVC --stream-mmap --stream-out-mmap --stream-from=Big_Buck_Bunny_1080_10s.yuv --stream-to=Big_Buck_Bunny_1080_10s.hevc -d /dev/video1

But the video is 1280x720, if I drop the `--set-selection-output target=crop,top=0,left=0,width=1920,height=1080` I correctly get 1920x1080 but the color keeps moving like if the colors stride is wrong.

Neil



