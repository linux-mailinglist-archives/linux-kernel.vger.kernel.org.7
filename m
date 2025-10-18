Return-Path: <linux-kernel+bounces-859192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C8EBECFB8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199B419C49A2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F0528469B;
	Sat, 18 Oct 2025 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE4He3+x"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E172472B6
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760791588; cv=none; b=cr5Qv8Pz0NFGZTTnYLFhrZz41VnPYlD72f/aJ7NqoWTxzRf5ClSIc+O/cr4xedsUeysVPEh2wwqh38D5/xJBbviJDJ7otiWGfbOv3Zz3MeEBRJ18UPYB8Gtm4KRfFRGBq05hrjojBMSBn/9SLoQmxFJVr1whjtyWPg1Y2Y9xIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760791588; c=relaxed/simple;
	bh=ipty/4H7+5rl8fNwSsr6VwqgKEA4Cfr81uIfdpGBaNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPpOyN7m44nAPl+t8RmnwRvHgF+uU3wjslVg8kkpzveB6yoqipu+BptXgCDefoY9VvLBBBZjAZC8pWoqQ+DdfU84IzhV1RGyrvEzpJ6ug9bgm6urgQjJidR31DgCZj2HxGa+9FtH/TeaExiXLcwzEThaG7PH55g5RsZROhaT8VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bE4He3+x; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47106fc51faso32243445e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760791585; x=1761396385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRDae27n+EW9z3sFe7xVTYXCCUSru9GSplX7TwKn6SY=;
        b=bE4He3+xBZlRA4G7v73b0x5cn2qwVLy9rqib8/aOIh7zLa6DVS6dJVQNxcjP9/m3/q
         VxHqnHiRghHI3EiHINb29ipZXBfToNJ2iSdLkWVhLq3aLicC2iQP7FA1K4zAJpfR7/Vd
         ebkzbuoC9yOrplU5mlNB6fv4yL8HrYsdoBNzrfBhVAvxzq+3MiUgLGnIzjSRpKNBHveg
         tagwD3zYWEEoojpiFa+cx5Tybq/5hoOlqE6ONUdqbtPb2X32+yTcn2rO/oXGT7lPejWH
         aN4MKHLxASFfnEW3F2q2zTRU1MVJN5FzGlN84OwKpL7Rbz/KMY6vGU5ld0fWB27zEWMK
         bRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760791585; x=1761396385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRDae27n+EW9z3sFe7xVTYXCCUSru9GSplX7TwKn6SY=;
        b=gFTIQC8l7KL1GawS3wtAlk3mv8FPg/BxeYvxkvVPJm8ku3PdoYehU01Ex+3Dvbxq5Q
         NAwFrACDJU6DSD8AMAD8TL2WBSeuJ9G4vF3mdrZlzIrSgnXRsMOn4MCZlu90eA1NgT8Q
         QWsDYvV72qafuHDGmwBbS3iH0/ncRbpM1/oigktP8XHf1TQs3U89zgpvT+QxH8mfCyyv
         7sz5FLE0iHwNP6own7v2nMbdM+6qd2K9Bc8c2JJmmSzOs+ZrKGXe3XgN+u9jS058OyuI
         3J3Tf7YTfxDexJVl4lI1eAwoVdbUg6SIvpx3UisxBwBsHZiQiJEU3g/0yJlEPoNYvMEt
         mPjg==
X-Forwarded-Encrypted: i=1; AJvYcCUMK+dfZH7brTQLRm1uB4KJTJb7gTjEEkkABuhfrhynx4wwoWmfcaBYa07B92qiluPMQEZaD0Jm/c2E5zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM2PrXtIMvEnLMKRX6xG5ncZeHZpTdJB67H3EXZDAsD4erNMm1
	iF/SRrQOKoyg1J0jaRNl5RfP+3BYkFwlLEz96RqWw0B3p2SqCrPdi4mv
X-Gm-Gg: ASbGncvVdBe6fI+VkVDA4MlwJV9LLxqXdmZfazYveTBoBa8LtD0Ys9s0BllU0+x1R2b
	eaDYhIxN9sX164GrucydWRBnJSnZ2cBvYoh4SCYlE/HkoVNbmOIJ8AN5qfFcPQuQyO+2edqRHbn
	GakqfTNMbZ/A2vHDpCd5Hu0gwnuvxSJh7gpWfki+4AvQthyDW2CZ22AS8DnaizBVe/OPQPW0A9N
	D1r69kEawC/IN5VvGFpnr+sOSnB5C6Bzx32AyfympZTDHta23BaHO64dCB++6DGMi4BTP44DJU6
	5F/t6h+ydUXQN8bQonsVSSsX0ChrV1V/2iAJoIGgxwZ8Ib4MS939M2GBYD09jPpubU70l/JTRP+
	mPGfxQQB4xplJJFepuZ6XOykS5D/weY7CGjPeTkWvv0fvZl4Z6oYsR34yY5Y5875rWwajikuyiE
	oAepknycL8FxY/VWsn9cBUY6OSlyLmI5ICrgA0MBp/YZevgop3
X-Google-Smtp-Source: AGHT+IHciheUaedaQWFrdBB059jOtAnHjQgXhJiw7swZ0lJsz0WMoNbXw/S7INuIJ01go/odvMDV6Q==
X-Received: by 2002:a5d:5f82:0:b0:426:da92:d3a1 with SMTP id ffacd0b85a97d-42704d74d3dmr4558479f8f.24.1760791584863;
        Sat, 18 Oct 2025 05:46:24 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:2acd:89a8:83d9:4be5? ([2001:861:3385:e20:2acd:89a8:83d9:4be5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3acfsm4914970f8f.14.2025.10.18.05.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 05:46:24 -0700 (PDT)
Message-ID: <048d5e20-8683-413b-8eda-cc1ec901ac54@gmail.com>
Date: Sat, 18 Oct 2025 14:46:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/sti: hdmi: add bridge before attaching
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-0-92fb40d27704@bootlin.com>
 <20251003-b4-drm-bridge-alloc-add-before-attach-v1-2-92fb40d27704@bootlin.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-2-92fb40d27704@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/10/2025 à 10:59, Luca Ceresoli a écrit :
> DRM bridges should be always added to the global bridge list before being
> attached.
> 
> Link: https://lore.kernel.org/all/20250709-sophisticated-loon-of-rain-6ccdd8@houat/
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
Hi Luca,

Acked-by: Raphael Gallais-Pou <rgallaispou@gmail.com>

Best regards,
Raphaël>


