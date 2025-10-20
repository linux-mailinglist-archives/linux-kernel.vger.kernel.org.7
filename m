Return-Path: <linux-kernel+bounces-861311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBCABF257A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A25E134DE4A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BB5286425;
	Mon, 20 Oct 2025 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IdUH978P"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A602857FC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976908; cv=none; b=ninz4Zw4/eQJNrMUIoFyBLlSkIVsxkNVXk7KSt4bPQ/+EgUQZgsim3UHA/l53tzi5ogMtN6kHnGIiXVh5YFE+Ai7aXOdpAJwO6AD8thZq8ITZrUiOZL6nwU7jie2aWeazc+QPTtSfT4AwIOeb4YoYLyBdX5pLgUu26mlviepsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976908; c=relaxed/simple;
	bh=Jua4BIwx1wftC9YUkccQgpopg9gTW50dQgVx8gQLv7k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GvN32uthD6nnzpSSTvEkAICGxWtmiZuHgCK90RI+EyzNhz/s8XkvfSyF5C/nGMfslySaWvCV0lZB8sot4316VXPYV7yvvU0x+f9Nco8kqjDO0Nem867eBUg8eIdirRPUTCXt/fJcaXZyero0q6ckX1RotYPsUevPFoloGoTnqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IdUH978P; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-471bde1e8f8so7948725e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760976904; x=1761581704; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sni5/6MbmNzQeyCmE1PCgBk84A0B0wyk3qAYIl/S1Js=;
        b=IdUH978PtIEnPcNnfYf0AbosmOVgeSuiNE/sUZIoNV6/30qFzPSYmIC/rRKylImZuA
         ZUdw+e918WMlo9nGKTYgh20oqbI7wqsqRcnSQXEqmk4cUY7OSTLy7s1TjFao78dFdwjS
         uRQw7xMznsVtXcLGdHwWWXwTdr0v1YL7Wu99dLqsqyPHfdB4vbPLks6FNQoZpk/nNdGp
         DoNy56o5dTxZI/YG5MpQCfbnFursh2lPhN+VU6Gp/UpBft9A7S7iQGUmOz7XRz0f4UoL
         hJZpYHziIRol4jidLH96XiFQfcIhciyBtfqkRIE0s/IJlsIQIoVBC65YiXhnR6pu2xeq
         l/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976904; x=1761581704;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sni5/6MbmNzQeyCmE1PCgBk84A0B0wyk3qAYIl/S1Js=;
        b=e6LxR+ElWfoFhOzolw7Jh2h1L5SMXiRZPQoZNMKXHGqTdeyZbH+roAi07FQxgMFc1N
         TTYC5lTuy/coVoGaXdHm9qRjQMlsgnQVFwcWG8IP35ZNzN0tvESEpuJuaBiCdEm7qj/M
         MsndVnIr5CWfrigIrCOFdCUadAhIlS2v7awJl/ir70nR/XVTV38JaM9OmSiiHQay8JEy
         0JfnMAzreILJ+MrLtLPNvsf91nd252NkGhGOb/mmtZS/eFEB9uE+BC8cYtcquMMFRU2W
         H+ZsbCWLo5sTORlrsYb/0iVJHiKesRnMXIEAg5NHBhMgerTryUO40etRixOZbNU8X+Z1
         /sfg==
X-Forwarded-Encrypted: i=1; AJvYcCVTd4C5PnBWmGzMZss6pRbD9gixNKH7eqzcq2YAIhD4dIshBRMPViDumKr8/L3sioelIMBMhn/kbKt8JAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuRdxXuoVPUkmVWpytC6pkYHdvNSnThWlZ4We3z0OmReiXRQk6
	IyT1lOpMxvbwuPAgTJA0xkobxbsywRotEV4Nn0rc4hsqOBUP25bBSQ4IVRS2l0vECcE=
X-Gm-Gg: ASbGncu7vR1ZAzxrs5PWMiZ3ywugTerPkauWuMTvzZnyMDK0fwTqhcEFyvwL/OwFh6X
	eLh4jmtGPUYGRYq2nu0kcsErTaqNHRRFpdbFATIoJRi2Z1eS9kfinY3AdLXBU2CSa2UXpBGZ6kr
	J4u16Vztt5OqImM+sytJHSKdmP3fQrbqBd5usxMQG8BCFPNcuoZ+hZhz6SL9UFzZv+yBXxUE2dd
	epuoHn3PH8Fh6QGl9vLtvIv1uJRctd5L9/aqpmiwaqoeusuCVP1Ko/E42HBbjmopvyT+khfrE5F
	dTbno1qaL5EolmwlZJAUweabC3sFK+6SZSw2zgGdxz1YzCHr0iu/QLupYaEmZfEJqJQVZsi78pB
	Q+Lwl2Xg3OcfaZ7OV83Bsg01gy7GhKGymkrxH1YGz2bIylZFUuE/njJi7M1spuAKrPjr3sLRUsD
	s6P6eZZX57rFz7UI0qQDSW0IZ5
X-Google-Smtp-Source: AGHT+IH+gc9K2IC1kig15CAHz3blcIpeF1+MZI8wwLj0FCfsFcBo1OSzfR+iD09YwCtZptUMS2gWQA==
X-Received: by 2002:a05:600c:670a:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-471179017f3mr85002415e9.21.1760976904492;
        Mon, 20 Oct 2025 09:15:04 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:9f99:cf6:2e6a:c11f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ba070sm16146014f8f.42.2025.10.20.09.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 09:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 17:15:02 +0100
Message-Id: <DDNA7OTLQ0GF.2YAUOG3GYV50A@linaro.org>
Cc: <perex@perex.cz>, <tiwai@suse.com>, <srini@kernel.org>,
 <linux-sound@vger.kernel.org>, <m.facchin@arduino.cc>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 0/9] ASoC: qcom: q6dsp: fixes and updates
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Srinivas Kandagatla" <srinivas.kandagatla@oss.qualcomm.com>,
 <broonie@kernel.org>
X-Mailer: aerc 0.20.0
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>

On Wed Oct 15, 2025 at 2:17 PM BST, Srinivas Kandagatla wrote:
> This patchset has 4 fixes and some enhancements to the Elite DSP driver
> support.
> Fixes includes=20
> 	- setting correct flags for expected behaviour of appl_ptr
> 	- fix closing of copp instances
> 	- fix buffer alignment.
> 	- fix state checks before closing asm stream
> Enhancements include:
> 	- adding q6asm_get_hw_pointer and ack callback support
>
> There is another set of updates comming soon, which will add support
> for early memory mapping and few more modules support in audioreach.
>
> Srinivas Kandagatla (9):
>   ASoC: qcom: q6apm-dai: set flags to reflect correct operation of
>     appl_ptr
>   ASoC: qcom: q6adm: the the copp device only during last instance
>   ASoC: qcom: qdsp6: q6asm-dai: set 10 ms period and buffer alignment.
>   ASoC: qcom: q6asm-dai: perform correct state check before closing
>   ASoC: qcom: q6asm: handle the responses after closing
>   ASoC: qcom: q6asm-dai: schedule all available frames to avoid dsp
>     under-runs
>   ASoC: qcom: q6asm: add q6asm_get_hw_pointer
>   ASoC: qcom: q6asm-dai: use q6asm_get_hw_pointer
>   ASoC: qcom: q6asm: set runtime correctly for each stream

I tested this series on RB5 and RB3 boards and it seems to work.

It becomes a real pain to verify things on RB3. There is a regression
related to slimbus regmap and linux-next is broken on RB3 starting
with next-20251017.
The tag next-20251016 works just fine (after applying slimbus regmap
fix).

For the whole series:

Tested-by: Alexey Klimov <alexey.klimov@linaro.org> # RB5, RB3


