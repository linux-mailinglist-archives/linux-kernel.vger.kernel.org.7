Return-Path: <linux-kernel+bounces-818301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CBEB58F99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895E0189F952
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF60238C0D;
	Tue, 16 Sep 2025 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0Rp2O3n0"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A02797BE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008884; cv=none; b=QBaEkN7YEMfmQmeRS3byoNc/51NZmehGn8XYSrP6kZZvMz0EuSb+0EHTaP0t9M+16qSdcZFOEWAlC4L9fDVI4yYMWwgOl1GCZEUOXFPUOcMkG5pJUVcCsWoV4d3Kenb6vJ0fykunqprGnye5rSSKcg5qBWDoQpAuiBbXozyPdC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008884; c=relaxed/simple;
	bh=0WWtF8D7n7z6bitDlyHOYgL2Gbux8mCWx2KqJJwHlIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m+izIIzouxGGWlCJY6UMxxY6ZS9nBsz8dmNkFfE5yRSHMyzguhN04ncsmr4qHuxuOXVUlclvszacdfgVC/h/9VPTGM1DKo8574fpiGEcUnMeoSKtuJ5wIXynxDG3NyEW4QLehg1gQyaD7rw8r4jls+6r59qHb3ZC8LKWK0v2Dxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0Rp2O3n0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f2c5ef00fso18478755e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758008880; x=1758613680; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dRMshHgr9BfhwP+oJxFotu57YS2EOBaQb6QEmA5pVV4=;
        b=0Rp2O3n0dkInsoVww3kH4/Gb8djFbkwsRucoiJWGTEv+GcBvMHc1dVwpC7bEx+tQxb
         lglfW3/4CJbf+E7Gpd6iKdIgNdDpik8NkRzYkYLQynBj3DgBkJWrsMqife1ueQ4sKpuR
         uB6Z407ckDd2Ukuqo/lIfLHPhbS1qEW2zh2lBHhYAfgrTNn8Y4XZOCgqDY5bK5rCos5s
         rrNmlWTXmGVSg86Pd6eEItxfyNP+8Xp8uPF39l8v9mLM9MfdeH1bIy4SuKmCjR+famGa
         YUUk0RKq8/Tl6pPgnVkX16vjH4iPV/jZScUAycd6gYzUN7SktKZJGIKSzjyf1Q3AXirY
         AwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008880; x=1758613680;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRMshHgr9BfhwP+oJxFotu57YS2EOBaQb6QEmA5pVV4=;
        b=FMem7f/y9iq1ViHk0Lm/S7pAc9sxhWLyYVmKeaOHe90Ga2D/MNql5Yf6wx4DjhRAMo
         uQI6qY+3Zj/tHoIaSWHwhGP5hnEQCZIbs7jD0mXhyWeZChsjBeZmSuCQJSIUmqREI/iQ
         sulzbehzaHHE6pJCc5ilENwra7/HlAihDGTGaehsLr1C9Y7Kf4KZSUZ5EXwQV9f0novG
         Pg5CwD61iP0pzrPhGLQXSenVXVdb0/SLd9/mensEwsseC90SwGMwKvhem2y7vzShNxt7
         QoNWxhn57VpO++rs1AAVKad0AtuZ16PJAQTLCWByMQHsD0yPa7H7XPmbuuUyPYhukL7o
         NyKA==
X-Forwarded-Encrypted: i=1; AJvYcCVNzjlGPBYwTHwHivLrPz+HgNUke/PB7r3aUvG4NnTBptQ3xxN2jdqgCF7rXflir5byLUXY284cZSyBjYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPPnlNgAWfWxqitTxSWZelDAY1lXG5y7iBBnQFXzp+Yy9/2WQA
	5xore/3OkTvpFLXyztYDnTdSInODsXzC00SJOUXl9blNscAxZ2vlBEcR9y19TeeNV20=
X-Gm-Gg: ASbGncv3KS87rpXXuXDctI5NNvueGPdRvnWZMslYW8Yxlf1S5w+cH7X443/gTVynoHw
	2Y8fk7Q2HABZWx+B9JqlSSrYNMOmWwrVyJtTLGQVv8NNG9FEJ2ncK3JiSwNAE3XLDMhQ7vuNDM+
	H/OdH7iV9b8oH+9hR+LdCXXe/dxxcvQtaj0z/wV5LnVhU0rruQbW7F+cvECasSsLWEQ6OVLKy3F
	kfCLs5XEZktAYFwcaIIz0c+QY9wzCqRy7ZRruNEbd8h9kKXalIE+0DSASnyDkFDMTJC1pgY/sIk
	+DcmMslWg9Jd/HWNpomTE3HsHhe4E0W0NqNjTC2rGUbGzEW5qIE+oQJc9JtRnUoSEtkRt+ehjWe
	fx+h3XS8m46DvBn3lOVlx
X-Google-Smtp-Source: AGHT+IHLQv5am8Q5PjXuyp6eiNrR5bsV8vHLUkJ1Q6ondFRjcGxSGd7COuqKP3wd8LC/p4RSW+zhnA==
X-Received: by 2002:a05:600c:3b87:b0:45f:2d2a:e323 with SMTP id 5b1f17b1804b1-45f2d2ae5d7mr57197665e9.0.1758008880401;
        Tue, 16 Sep 2025 00:48:00 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:a6cd:21af:56e0:521])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e037d741asm207326335e9.23.2025.09.16.00.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 00:47:59 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,  Stephen Boyd
 <sboyd@kernel.org>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,  chuan.liu@amlogic.com,
  linux-clk@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-amlogic@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>,  Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 0/2] clk: amlogic: add video-related clocks for S4 SoC
In-Reply-To: <20250916-add_video_clk-v5-0-e25293589601@amlogic.com> (Chuan Liu
	via's message of "Tue, 16 Sep 2025 10:06:05 +0800")
References: <20250916-add_video_clk-v5-0-e25293589601@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 16 Sep 2025 09:47:59 +0200
Message-ID: <1j348mj0sw.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 16 Sep 2025 at 10:06, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:

> This patch introduces new clock support for video processing components
> including the encoder, demodulator and CVBS interface modules.
>
> The related clocks have passed clk-measure verification.
>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
> Changes in v5:
> - Add Acked-by tags from Conor.
> - Remove unnecessary flags as suggested by Jerome.

The request was "in an another change" ? Why was this ignored ?

> - Link to v4: https://lore.kernel.org/r/20250909-add_video_clk-v4-0-5e0c01d47aa8@amlogic.com
>
> Changes in v4:
> - Add Acked-by tags from Rob and Krzysztof.
> - Fix compilation errors.
> - Link to v3: https://lore.kernel.org/r/20250905-add_video_clk-v3-0-8304c91b8b94@amlogic.com
>
> Changes in v3:
> - Rebase with Jerome's latest code base.
> - Link to v2: https://lore.kernel.org/r/20250814-add_video_clk-v2-0-bb2b5a5f2904@amlogic.com
>
> Changes in v2:
> - Removed lcd_an clock tree (previously used in meson series but obsolete in
> newer chips).
> - Removed Rob's 'Acked-by' tag due to dt-binding changes (Is it necessary?).
> - Link to v1: https://lore.kernel.org/r/20250715-add_video_clk-v1-0-40e7f633f361@amlogic.com
>
> ---
> Chuan Liu (2):
>       dt-bindings: clock: add video clock indices for Amlogic S4 SoC
>       clk: amlogic: add video-related clocks for S4 SoC
>
>  drivers/clk/meson/s4-peripherals.c                 | 206 ++++++++++++++++++++-
>  .../clock/amlogic,s4-peripherals-clkc.h            |  11 ++
>  2 files changed, 213 insertions(+), 4 deletions(-)
> ---
> base-commit: 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
> change-id: 20250715-add_video_clk-dc38b5459018
>
> Best regards,

-- 
Jerome

