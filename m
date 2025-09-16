Return-Path: <linux-kernel+bounces-819147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 811C8B59C16
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315903222AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9172E30C372;
	Tue, 16 Sep 2025 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTQyijc/"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D75820B81B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036534; cv=none; b=o0ORCYbxn7NEDTLDVDqaM9ib3g8ataoY4p1yB9W9Q32hBenYOwFamINKqbZqusaQegneomp6MK+scF93eTfT9SmcZQF/9S6xfkafpC41DGGglwlfajQRSrei4I3cwgdp93w2FmR8j7wN2eVYIq/j2HhOywo0z1DByOHxE5lx1i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036534; c=relaxed/simple;
	bh=ZLrXHuO5JPlfORruq1YX5Wwdp87X6JTNMvWIVnA+YX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zq4CGjzfq9gmDcCbIzqGvJU7nw7uOZ5xsvAm2Do4cwldqOAav7S8xJb76O5hlddL3N+gtl8u5O4OQltweCmwybVfsbWwy+rJ1g8HBYT4i3TReur5F0AkkuKqhzS3PlGofQI3MNT+ma82BZLjexaep43BzmcO8XJw2mvLrMR8Xdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTQyijc/; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b07c081660aso817350366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758036531; x=1758641331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RF3WI9lwfvZNWeJ7kfn1lRX1BxBApCYMK3bTcDdRZGI=;
        b=GTQyijc/Yzdos8TYbXpmA0ba54cyTWnccJihkyOc/IBlfirTqnuDoSD9K+x/5NiqGe
         za+8ulGD/UoAox/wdtGdyEfybS7SfzGab6qomjl8aiNNw6x9kag29zyt31nQOxzzAmyO
         xabAu8ySgMfLw4I6kxYD7eOtG+dDNyv8Uj4Q8mAW6YVfE0haW8LoP+2y4bTVG7/Ltn8I
         IoS9RrrOoKNxeftnUfmV87ijnoRQIUo+MUdM9F4kFEAVOe+vaddhy9fMYv079bh5rni8
         JgLcZgEadI2JLBpOdJ2zdGVxsfpBSDYAJb8phRMWkf6BKnGR7FoC9r158SeoHGOmryIA
         BCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036531; x=1758641331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RF3WI9lwfvZNWeJ7kfn1lRX1BxBApCYMK3bTcDdRZGI=;
        b=R6xd8W7KmvDV+oW0ihMOwiu65jMbxn3nCzIvJ1bFxTbZTNqbuCD4IuemZfepPYr4fG
         pnDBsOwQFRD8vkZk8jimdceHH3J2M6hSLZPFNHYDU1/Y20iHDzcOAzNM5A3RaUiL4AAp
         M0Z7QQ9hqki7KrzJ7u7cmuOJokZix3YHJkuwuXmFz6eMSt/GVvNko3CzT0Xq/fDKbDQ3
         znS0Il0QLNHSw2JG1TpeDKdiGESqsVmLbC+0zuRtbB13Hk7u7UmneO+fwhYmZUlgycBq
         CeO1BBQ68VtkAEvIEUNE+02rA8OVWVRHPKqYIc/5ok9X+hpRHqzG1Wlgc3zdC6cghZLP
         R/xA==
X-Forwarded-Encrypted: i=1; AJvYcCX9vgDXpp08Br3TYutcMSgxiZN6tek5UMeO6O12oLEJyiYitOBp9Smq/mwlUSehbkNaZjor1wvvkly4r5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCRvRnC2+dQtamI0pYqUU0d4M0qY1Q+UKtzo1h2ankIsVbMiJp
	TPatyNpgQfWi0Meiu0RagffhxpBU2gCdODoYViOL16sOpaXC6Y9IM7MO
X-Gm-Gg: ASbGncshsfZqQM6PXWdAiPBeOFrbH1Vb78I1XjTTauwzaxeBh7v8WuaKu73BXP1UHp4
	Hwm7u6dpAFJmCn3S+22AJgqU4CJZ/qx/ROFUVhlA0EVNcztISW6PTPbbX/Tklr92CnU1NPigpkZ
	HLn3w63xaQ3AtMYW9yKLo+sGuEqm+Pg+4As5DHIoSFtdW+PVs7f+qYzp0YLlwgmVfvIiTC/3r4A
	cv2hll5pd7xtM9WtDWJlAw3pD3unV/zZDpJuuiylgWnlkP2JsWNBqfPImfVtL1wd2S6IUaRs2fK
	F/5pOLMK9arou4f6Gs0++MpH+awYQKibl4f49tIeE6+Lal1CrOtFiAF19Y6db59oYPOpaAnAOiu
	3vfqm11qaHaEL74f9N5filw5oPYRnUHVVEQnRYjn8JbdncDEyXKVeCuT0pBGxDNs/0Ci/BERCV2
	7dsbvxYSwIpHrqccca
X-Google-Smtp-Source: AGHT+IH6lZbtHxH/7gxxN1MDdzkJX12I6R0YroM7gEIo/uBKwFu86PByiOXZ3s0NICwjy+v5YWGGwg==
X-Received: by 2002:a17:906:fe0b:b0:b04:392e:7168 with SMTP id a640c23a62f3a-b07c37fd0f2mr1648080766b.42.1758036531087;
        Tue, 16 Sep 2025 08:28:51 -0700 (PDT)
Received: from [10.0.0.176] (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da27esm1198473066b.6.2025.09.16.08.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 08:28:50 -0700 (PDT)
Message-ID: <6e886700-24a8-4127-9324-7245b6cbf6b7@gmail.com>
Date: Tue, 16 Sep 2025 17:28:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/bridge: ti-sn65dsi86: Transition to LP mode on
 every video line
To: Doug Anderson <dianders@chromium.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jayesh Choudhary <j-choudhary@ti.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250916142047.3582018-1-ghidoliemanuele@gmail.com>
 <CAD=FV=Uftrv=x6CuG7edLCSAi16Kv=ka7qxPViuLM=BEG8pC3Q@mail.gmail.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <CAD=FV=Uftrv=x6CuG7edLCSAi16Kv=ka7qxPViuLM=BEG8pC3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 16/09/2025 16:45, Doug Anderson wrote:
> Hi,
> 
> On Tue, Sep 16, 2025 at 7:22 AM Emanuele Ghidoli
> <ghidoliemanuele@gmail.com> wrote:
>>
>> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>>
>> The component datasheet recommends, to reduce power consumption,
>> transitioning to LP mode on every video line.
>>
>> Enable the MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP
>> flags so that the bridge can enter LP mode during the horizontal front
>> porch and back porch periods.
>>
>> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>> ---
>> Cc: Douglas Anderson <dianders@chromium.org>
>> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> Cc: Robert Foss <rfoss@kernel.org>
>> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
>> Cc: Jonas Karlman <jonas@kwiboo.se>
>> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> Cc: Jayesh Choudhary <j-choudhary@ti.com>
>> Cc: <dri-devel@lists.freedesktop.org>
>> Cc: <linux-kernel@vger.kernel.org>
>> ---
>>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> I put this on a sc7180-trogdor based Chromebook and the display no
> longer comes up. I don't personally know the MIPI side of the spec too
> well so I have no idea why that would be.
> 
> -Doug

Hi Doug,
thanks for the test.
According to the datasheet, LP is recommended for the front porch and optional
for the back porch.
Could you please run another test by keeping only MIPI_DSI_MODE_VIDEO_NO_HFP
and removing MIPI_DSI_MODE_VIDEO_NO_HBP?

dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_NO_HFP;

Kind regards,
Emanuele






