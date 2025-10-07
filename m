Return-Path: <linux-kernel+bounces-844173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 926DBBC1390
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CE854F4AFF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C140E2DBF6E;
	Tue,  7 Oct 2025 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pt1FOcF3"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1011223DFB
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836748; cv=none; b=UpxdJvu93s/WrcRjD9gk7qPjUxB5Q9zVznKsjBc4gWmqTUSpic7SqhUFGSRnJTSRTDT16/TbK9dFAys9AJzQDBzgdcp/w+Dx9ArVDDwf8IZzMPfSgI6Ln7+hcYXRxz2zbsTi2DuLqKwurwvN12SAuVovhgVP14LVyV/GBGABr08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836748; c=relaxed/simple;
	bh=A4j+7JTxsbiZRzdRZU7yWqXtGFdx3Ok4jN8NDV+qcoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bT3HuyLkGa5WeXE53kXI//e3ysuj0+tocunJWKYGDi8d1b2+RTwH5j/94ZT24bG3euZDIhmZ+2/VW+R3jpbDQqW7b91taL9o1k4Mdj9wVQVIfVpGOCO/g0xaFoT4HorCKRYqoCD2ps/YKcBIYrMEHys+hWOa7ZyNM3ebveq3B5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pt1FOcF3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb78ead12so1106499166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759836743; x=1760441543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZC6d70RCI062m/NmlsWdu8eeof6vN1BlqZdvcy2VsBI=;
        b=Pt1FOcF3RTBT5yloMcq2p9lwgpCN1IgOzyOmI1JflZvqpN80MCkjKkD3lTi9INjkpK
         0PRNpeU2G4v3oyi2EeyDt47h2rf02Lc86qf4wpOl3Kqr3b7gH25d1Z1S1GCQ6+2Aee5H
         PFmIDTVILWL757DkV0L66wgBlQQVHb4UyeKDZcJKCysc7NaOVJ5s8bgRAeLNhN+ocvX4
         lK4JzeuOE7pqyoqFyP2XeSXmho8L3h19tiankhIHpRqRzzLgIXNiyaoX7gORPuITKIow
         MnXBE7GnzIw5TzpJIomffd/yHLq19B4tp/vX6NGwe0ROZQ+N2fP3Gk1bAD96vz8Jw8/a
         B6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759836743; x=1760441543;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZC6d70RCI062m/NmlsWdu8eeof6vN1BlqZdvcy2VsBI=;
        b=JtCryN9LK/OSX5sqY3qgNxgJslMEAj8NnOSXL8qLB3UIP7o1/oUyZU9F7K90c6P5CO
         RpArK+4LajjVg8iqIC5YV4GHlVzAeYfhKXmzpi5G6jNwFsncd8ZZX8DFoA9nDtyhZB4h
         VnIT4y40lczdeTsK1JEwlSrOYsTnrYXaN4T6evuN7G7ybFCNsh4T9OBK6Xp7hDK8qxGi
         gAa/3cq1J+WP1b2KcIxh+OmSZuVV3Vvep+yMkZHmWUtmMiNxx6SNgRmAfFLs0sx1nwNr
         IdRnei0v9CtZeQ/WQjT7M+b9PKWpM+L7Iu5sUYVphZCGswrI5G8kQsN+eqhRfWDqHc31
         +/9A==
X-Forwarded-Encrypted: i=1; AJvYcCUx3SI1fm+Cfr3zk3madPRJnUkqLEFjCzNjc0veUAjwXh9sC87WALX1PT2n8m/a7cb+3VDiOANAqKDGbHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywqyDZOZbnGNXp2hDOZNEbHwjdNS/CBY5ApaORFUBCVTZGPXrA
	OJhFfoY97DsJitiPcp1uaM48J5T21QTsbwx5z/PtCBSqoGhUcLycnavpiQaKJRign3yZhyUouVP
	y/lOk0RI=
X-Gm-Gg: ASbGnctjpPfBd9TuOOr20ywaehkFWo78Xu0sOk51ChQrZPHRjucjmgpNO/GvtsO0qOF
	jHPk3gb8aOaEjvY8+SstJfXaddgu/rWoAhhpVWMvrVhWbuaSKBnya+eFho9ZhtcisIgjsyFhHXy
	EbXE8azUvMthX1Ln1N/4ZZJiz6UDLH+M+sDaD5evDERepcgibYWkw1w0Qb0wDklI0n7ORq0nTP1
	kdUcfIe19PnOUFy1PSqnIB9meIKl76jdDpSq4zq6En4TfHSzmfAknNdsqfV8FHt7DVdBtY6w2Um
	k/JWgoTc16ZvP6kdZNh+KviZ6W4jlucxsmMe39EiHN4dYVlVMH9eNvR3TeYfwpTdlkm4OUuB8Aj
	atAz3PusR0o+iVAJij+7z2ynVtKGdw2b5/c5TmLvEQUkdFFMdEK1qwDOW0SVgrA+DG8gMIPrhcL
	+vpe40Vleglen2aSZK
X-Google-Smtp-Source: AGHT+IFjZJgPkdCZvczYKSg21gtQzjZuEg71RmQ8o+OjBKMXLb1coIMLo0/KuBwAPewegCHdx5P6fQ==
X-Received: by 2002:a17:907:268b:b0:b40:6e13:1a7f with SMTP id a640c23a62f3a-b49c2a5788dmr2192509666b.27.1759836743118;
        Tue, 07 Oct 2025 04:32:23 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788111f1fsm12371986a12.36.2025.10.07.04.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 04:32:22 -0700 (PDT)
Message-ID: <3a07850b-90bb-4035-91ce-9f361c635df5@linaro.org>
Date: Tue, 7 Oct 2025 12:32:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: iris: Fix ffmpeg corrupted frame error
To: Vishnu Reddy <quic_bvisredd@quicinc.com>,
 vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
 abhinav.kumar@linux.dev, mchehab@kernel.org, hverkuil@kernel.org,
 stefan.schmidt@linaro.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <9UYDQ7nzBQ9Uqb5q4mG8WWKGLEZNPSvgV1vw6mmYS0wY2VKS5F11n8IaesvJsKYBvndy99tKFqGoak5MzQVZIA==@protonmail.internalid>
 <20251006091819.2725617-1-quic_bvisredd@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251006091819.2725617-1-quic_bvisredd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/10/2025 10:18, Vishnu Reddy wrote:
> When the ffmpeg decoder is running, the driver receives the
> V4L2_BUF_FLAG_KEYFRAME flag in the input buffer. The driver then forwards
> this flag information to the firmware. The firmware, in turn, copies the
> input buffer flags directly into the output buffer flags. Upon receiving
> the output buffer from the firmware, the driver observes that the buffer
> contains the HFI_BUFFERFLAG_DATACORRUPT flag. The root cause is that both
> V4L2_BUF_FLAG_KEYFRAME and HFI_BUFFERFLAG_DATACORRUPT are the same value.
> As a result, the driver incorrectly interprets the output frame as
> corrupted, even though the frame is actually valid. This misinterpretation
> causes the driver to report an error and skip good frames, leading to
> missing frames in the final video output and triggering ffmpeg's "corrupt
> decoded frame" error.
> 
> To resolve this issue, the input buffer flags should not be sent to the
> firmware during decoding, since the firmware does not require this
> information.
> 
> Fixes: 17f2a485ca67 ("media: iris: implement vb2 ops for buf_queue and firmware response")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
> ---
>   drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
> index e1788c266bb1..4de03f31eaf3 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
> @@ -282,7 +282,7 @@ static int iris_hfi_gen1_queue_input_buffer(struct iris_inst *inst, struct iris_
>   		com_ip_pkt.shdr.session_id = inst->session_id;
>   		com_ip_pkt.time_stamp_hi = upper_32_bits(buf->timestamp);
>   		com_ip_pkt.time_stamp_lo = lower_32_bits(buf->timestamp);
> -		com_ip_pkt.flags = buf->flags;
> +		com_ip_pkt.flags = 0;
>   		com_ip_pkt.mark_target = 0;
>   		com_ip_pkt.mark_data = 0;
>   		com_ip_pkt.offset = buf->data_offset;
> --
> 2.34.1
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

