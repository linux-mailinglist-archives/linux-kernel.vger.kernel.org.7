Return-Path: <linux-kernel+bounces-861175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8612FBF1FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBF5462201
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14D823C519;
	Mon, 20 Oct 2025 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCIyZ/am"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B118C234964
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972670; cv=none; b=OjbEpb3R6pK7zncjhEVSGMevh27ShkcOCykm2DrCPnJXAZ+0eiH+O0HyaM2uTvaA/VGpxL8Omg2V/u9q5I9q0+xyHsdMKXW09SdhXbyHGRMtR+kMaDMQdPCc1ysh1kaQ2nMy/A65Aa/9n7ALTk/NhD0epQUm5KQNv/WektCHUMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972670; c=relaxed/simple;
	bh=NQTt3yR3wb555kAg+WKMiqLQ3QOmGXvQw1+WcPNE6mk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=db5s91j3tFWkk1aVCvs92BrC+ye4Y/HUpzYgEvP+Uqx2um+hDrT1lh7CJMsufPOL2BYWctpSX9O2hSEGQ8LJhQWIzECnmNy4w1oK0iOsNHTkXGocUc/lUhGV6GpSE0O5W9JRjVayz6ztJcW8WOGqskU0je5s0Px5y6ATEAFOND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UCIyZ/am; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so29366535e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760972666; x=1761577466; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7j5YzMBOCDrFLrL1gjEGQ9zi19aLgZpxoO0BZALkK7I=;
        b=UCIyZ/amgYCUKpmSi2zCw1JGpsCsGWkMe4lwWX6WkmtRk6juK6CIbkwBYZ57y8ZdmM
         jmqWvtxnzwfo4+Q8tHe4MdEBPRG/baug1JI5umGrC3+QKypZ2W1TmHWn15N965W/BkjY
         ZFIYYiX7Iz3gO534fWQ8k+/LzP9mR/Q1I5QmcDZEIPFp9nZ5cP/jdLxJtAdtggWFI4rk
         pLZMtSs0k2U9KEcu7ZGg/TJpvHn5K7aiULdMXqRu7HtUnt+K+WIFhFhcTLda75cPrPP+
         9OnOhxRkyCXkAyGo5R1comx9x1eNq0s7m7byvwMmjIayGMdOwpVtbGHVUsa0alq7MKAI
         nnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760972666; x=1761577466;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7j5YzMBOCDrFLrL1gjEGQ9zi19aLgZpxoO0BZALkK7I=;
        b=DYjlvIq9Zf/60NyTJH2tMvCPoqu/Tgh/TBRuM3loYUEEKsN73WKVf3AId6iPyE7wBG
         4z442YBrKxLownWl64MDPU9zBAeqkKxWBzeXaYCOKiCWt6HB2xKe4fPOheLdU0M+G9Jf
         s22gzUs+4B46fmGzufnCVW325wELr14UWF46xn188KYs5w415OW2DfQYpR7T4ZxL9d6K
         UIgp7aHWcYesOUvj1zw6i8NZT4JQWFjoTfFLfb7ugMLqGCiOCNBXMtmc60MwqWmmroCD
         Trh9LsN00ylW+ut1490Yya3NP1e6wFnYuTW5nGg0zOFM3z/5zxily7nBgtL7gumDEkVp
         vExw==
X-Forwarded-Encrypted: i=1; AJvYcCWFxZnr9qB7c97Vs6YPPEqSkVUPtLY3tNc3HZK6nnipdsjIsQRyjWa45Me+b8zY0uNRF2a7vwkGIHd4+0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMDZJcOp9GCM3ib9Z4Rw0hjsG+NL52bsKfGjnT4d7jBVUhC+qv
	AxxsKkOiszj7UkHwKg5R0rNyYftOZDO5VmCaVp0+O5TLFQSV3haru+2RsJsW273Tmmw=
X-Gm-Gg: ASbGncsgPrOAHY6z/gjpfFxfE+YlWUy8lMtRjKZZ79eNnnJj/0ghixuoGSYhs9z3fiO
	LYXWqOboKTtY7k1XySuB9ZWzgjDt/cG5VSHALj7aR5A9E94cvi/09yj/2WQqfHf9+0hSk07hyZM
	HXsgnu53qn5DC/92H4uQU2rBYMDsXAgAAdK0vLSM1PtySgGYUDUS7uL3IyEhuSZezf3nv3b+mQj
	6ntYr7Bry5BMYTrHMb9HFb74uWxhjFTpGnzfXHZeMMEszqpv3i44gAUI9rqAWk38Y28uCEH8+0d
	KqviXHFfRf8aU8isQzxM20QWCi2OnZLYegDWElokk12+dK0LenDGeEMTAVuGWLCIl9fnzgYqUMR
	faPXv3WGpl6GnNmPagHvnVIIVheF9XmL+SA40FiPvB5Tl1TcEqZMSVG3isG6wXVBAbguObF6F2N
	fydbXzuzoTGYyD6Q==
X-Google-Smtp-Source: AGHT+IH+kjVEaLAgrhbcv9wCPGNvII0B3F+6rlxLJXUsp++tlTBLtRr0Ji9BepfUMnPNIQ4qAWtnfA==
X-Received: by 2002:a05:600c:5299:b0:471:95a:60b1 with SMTP id 5b1f17b1804b1-471179192d4mr122728725e9.32.1760972666014;
        Mon, 20 Oct 2025 08:04:26 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:9f99:cf6:2e6a:c11f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9853sm15747079f8f.33.2025.10.20.08.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 08:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 16:04:24 +0100
Message-Id: <DDN8PM13DWWZ.BCXRTJIFB7PD@linaro.org>
Cc: <perex@perex.cz>, <tiwai@suse.com>, <srini@kernel.org>,
 <linux-sound@vger.kernel.org>, <m.facchin@arduino.cc>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 7/9] ASoC: qcom: q6asm: add q6asm_get_hw_pointer
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Srinivas Kandagatla" <srinivas.kandagatla@oss.qualcomm.com>,
 <broonie@kernel.org>
X-Mailer: aerc 0.20.0
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251015131740.340258-8-srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20251015131740.340258-8-srinivas.kandagatla@oss.qualcomm.com>

On Wed Oct 15, 2025 at 2:17 PM BST, Srinivas Kandagatla wrote:
> Currently we are performing an extra layer of calculation on the hw_ptr,
> which is always prone to errors.
> Move this to common dsp layer for better accuracy.

The subject says that the change adds q6asm_get_hw_ptr but here it says
that calculation of hw_ptr is moved. Where is it moved out of or from?

Currently the commit message is confusing.

It seems to be potential confusing split with commit.
("ASoC: qcom: q6asm-dai: use q6asm_get_hw_pointer") where calculation
of hw_ptr was implemented in q6asm-dai.c.

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/qcom/qdsp6/q6asm.c | 12 ++++++++++++
>  sound/soc/qcom/qdsp6/q6asm.h |  1 +
>  2 files changed, 13 insertions(+)
>
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index 371389c8fa7a..643ca944b1b5 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -6,6 +6,7 @@
>  #include <linux/mutex.h>
>  #include <linux/wait.h>
>  #include <linux/module.h>
> +#include <linux/atomic.h>

Ideally this should be sorted but it seems it was not initially.

>  #include <linux/soc/qcom/apr.h>
>  #include <linux/device.h>
>  #include <linux/of_platform.h>
> @@ -248,6 +249,7 @@ struct audio_port_data {
>  	uint32_t num_periods;
>  	uint32_t dsp_buf;
>  	uint32_t mem_map_handle;
> +	atomic_t hw_ptr;
>  };

Thanks,
Alexey

