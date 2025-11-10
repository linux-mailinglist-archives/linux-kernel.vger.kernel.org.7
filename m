Return-Path: <linux-kernel+bounces-893513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7853C479CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68993BBACC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA38257859;
	Mon, 10 Nov 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dDzrr5WB"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAED16EB42
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789001; cv=none; b=OZYupewPst1YG/3S8/sJa00di1mAojw8PpoHVJs/mpxi6kOduVZp97w1R7UcxcEp0wWuNqma9WnMQSSNryrZN1xkFwjwm+W8fxmQErqlVaSab9CerIUPrgQMqqmwbmo7h2kv6zWYsW/j/gbxl38S8d29uTmR7PnjhC/mxS0ldSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789001; c=relaxed/simple;
	bh=uNaQu/Q9ekThqQDmD6zJz09GyNvN/wxUvc2BUIZOTaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxa/jfEskUwFWXcNXK2z9aZn8W9FheVB0sYexveXA6AcFqQ4fqODPjogTit5z/5GsqqeChPQCVJmELOHhyYKnmOYYmiFr+SQUyZh28ckAAwZxN6R2hxNFhkz4ojp89MNmkv4bd9GgRBA95kRxTXblOAGfLNivCvUUlU8ViFsx3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dDzrr5WB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47755a7652eso21162865e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762788998; x=1763393798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5Bd/tXItEBXiIJloafWDp26fh+vqPiEInUwjV8UvKA=;
        b=dDzrr5WBufjrCoJ90m04t2gdudcMhJxYfk/ZbjMGcMDt00JdTS+9NlR+obpva0uuy1
         yfw4GWYQt3mLOdx76sfQQTHH7G+HjCdw/q6dvEhO4+QnY7sJtpohMjNWld/dn8l9DCbu
         l3j9Xdd373yjn9xjNPFLla4FcBXSpzt94XBqIVPlpNRhliw0Lel+m+3m8w0Q+X4YSHts
         Bbn9ZNxeuqTu9599cFEnvpujFLwgtT+NF4DdpufvPF6xWfj06ydpF0rZwCNie+2QZZY2
         FQB+tj9ku/T6enwxJvmwa4r0PUCe+9k7is9vv5jbDE5V5OgO7nWjCbLH72PExrAyoWkq
         VM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788998; x=1763393798;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5Bd/tXItEBXiIJloafWDp26fh+vqPiEInUwjV8UvKA=;
        b=MVM0hWJiuE1owIR7gsSlZclww/5/9BhN+FD810mNHepTuVw8ywAWG1KCeBl42V+hrL
         Q+sntH1H0kYHMx+orcMRLsAv8QC+s86Js4OPdrjub/Xgou+T9fTZO/1qyQYaF3knpW0V
         QZ3ZTUc1gok48/8VOG27RqTPxULzb7jkxyJUv69w4eQdIWJ23SRC6aIy8U846s1f1ZhW
         PYCKwOgcujnZC5EWHl2mtriA694SiMaLLaXJXr+vjnXC7+Qb+G5cVqM3gPhEeBFTptwF
         q5TPa6GALM+54mQDrngX3wPNFP0xweOEI4gAv3PUP1sWjfMMIaDz+2Rl3Y+QP7jRPpZg
         3IFA==
X-Forwarded-Encrypted: i=1; AJvYcCX8P9Ve4Z4wiEr2T6TbYwwkBzC6cBDzEQVnJhzaRgNupU4wS+v7IMyBjWqU2LGNC1kFujHAuesIlnKC04c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJQfAc62amEIxpdjSOvc9kSlskMpGMipCYJKJP+SWSOAWVkclN
	vsg9ERUjR2KA9gMlAg8XRKvjDvZp/UM05/iH3djMfsdoTZm9TxTeQOyeGGVQsEuSZrs=
X-Gm-Gg: ASbGncsyVDP4RsOwB2tCEBOV0iz0uNuTHG9E3/BJ1p7nPaoc2yxIDhv8lshgShr0ivs
	N5loSjAFq8t7IZbfVL2O8EUHDtOEUDA7FBHdYDGDcqCAoIwvBdI8HJdJw+gv4qJvhnXiO+h8SET
	5DcZOF+U2gyeZRnFBvJu/pxTRycSO2smJDj7d6qgUJyaGUYtI0Y+Mhi64htKZ8z61H9VjztKlnU
	N/221KDnbiw7BoJ1E+ExkpFWDCjRPcAimoSad7Pf9ykKUVMwjAAh3AWXiJa6wipgTlYUVgDKQNX
	B81mFYdFVEciw2k/nr3n/tsS98oLGINZoW4sqxFDxTXjEmE9cpPR5sOrhD/WDb3NzL4nLtuA2kw
	Th3V+PlSfsTad0XIsLascrk4QvcWQRCSzEAJtpFr/ySR6YQlZRMMjAVFOpB1iN5H39zia1cP5Lv
	3YzsHZ+AuSRtzesB1WQbM=
X-Google-Smtp-Source: AGHT+IE9qv7R/OTtTxm4cyE+W6NnDq81Hw117g+4APUr7JY/9kd4Ue3rk8z43sXSS7BU9Q+6UaWtaw==
X-Received: by 2002:a05:600c:4453:b0:475:da13:257c with SMTP id 5b1f17b1804b1-4777327cf62mr77057595e9.27.1762788998113;
        Mon, 10 Nov 2025 07:36:38 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763db453csm122413775e9.1.2025.11.10.07.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 07:36:37 -0800 (PST)
Message-ID: <8c654a1f-2513-4afb-b33b-fabbafbbe845@tuxon.dev>
Date: Mon, 10 Nov 2025 17:36:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mmc: renesas_sdhi: Handle resets
To: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org,
 p.zabel@pengutronix.de
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/8/25 07:25, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds suspend/resume hooks for the Renesas SDHI driver. These
> are necessary on RZ/G3{E, S}, that supports a power saving mode where
> power to most of the SoC components (including SDHI) is turned off.
> Resume from this suspend mode is done with the help of bootloader
> and it may choose to disable the SDHI clocks, resets after it is
> done with the SDHIs.
> 
> Reset signal was deasserted/asserted on probe/remove as well to
> avoid relying on previous bootloaders. This is also useful for
> unbind/bind operations.
> 
> Along with it, driver was converted to use
> SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() helpers.
> 
> Thank you,
> Claudiu
> 
> Claudiu Beznea (3):
>   mmc: renesas_sdhi: Deassert the reset signal on probe
>   mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS()
>     and pm_ptr()
>   mmc: renesas_sdhi: Add suspend/resume hooks
Gentle ping on this series.

Thank you,
Claudiu

