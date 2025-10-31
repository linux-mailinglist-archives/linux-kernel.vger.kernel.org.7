Return-Path: <linux-kernel+bounces-879780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37F0C24067
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A8458150C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E779132E12F;
	Fri, 31 Oct 2025 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Qpak3mQ6"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC8332D0C8
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901489; cv=none; b=GJrZbDc9e/30cGeTsF9NZY7Fnd9cQFtfJPnxF7uMTp/T6QfUW5O5ak/OJVb9Y4VUDG+C13uVoZ0vtqsLus39C/4S4p62CDwP6i3aL5dcqiH3JcfmbPrP+iYBzB2VLBS69JbjGIKsVnA1LKolsFoHZpSt13zNlWDSJIpVUPV4cGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901489; c=relaxed/simple;
	bh=78mpbY+1AP+HcV47YAi+QuuK2I2YpptrD3Iqg/3Y8ww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jmE1eDO+wyN3HtiASM0oCD4fjKYx17ts91af2Cxhq83A/MK4H5e0Q0AsgFeY56W/Rm4wxL6RdLBr4Bl1c2c/6pt6B1Z8RYpNklEFDxUIen8HflVdkyFpcaSx77SOnQju8LzojIJGQ03IGOs+H8fQLrSXk25Fda63O12H4DfdlUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Qpak3mQ6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429bf011e6cso628204f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761901485; x=1762506285; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NTUxY2QRsBa4YiD8QVHQP1f7QsWrz+ePLEmHRSCQsCg=;
        b=Qpak3mQ6IWqd+s4a689VSD+ti3WuketECUJbwclwfDnmrmriCq7yWejaN7IRyu1rxp
         adYTCXF5xHjpfM/d0RXvEex9T/W+i9SqbbldHXTtSR/en/C/Qe6pLTF+UsX6zj1NVNbf
         6SKIvBT3u4Kh9gw7PoDUZkpNVoSmu2UWVGio2T/6EidEW8uqlHRaKVzQFBZPT6rn0EXQ
         U/x0w7gYqaEAvGn9AWmZFaYD0gb8mlqpgSeRaUPUchOu0zQAUbdyH8FXvmV84OhyL4U5
         j6sNlPheK5UGW5gc//1mq4LwkhzDApNvH34vOobtClkoaGO0Qkbe416tyNij3MWmofzJ
         4NPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901485; x=1762506285;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTUxY2QRsBa4YiD8QVHQP1f7QsWrz+ePLEmHRSCQsCg=;
        b=ALfpmVnHyI51C3Vkb8Nnif4AtrOKix7h5CEfWWwFGftm5m1yrEhdAZoL7Mfd0QWkgX
         Lo/qWtpr/jVKzXqe/K0upexDZOFR/kEaIm6LC8R1Zs9/bTDfz+PpvAhrhWGAnThqYwWF
         Hml786raZtLPbMz9LowcsAHueWyWKOveXHMrh6AkHI4iaRutYml2kgjw4Ai0Dvmy+Qf9
         YYbda8EtjSRKhwiD+YVE4fnKtlMqUt7KBLwcknl1C9G7Qv/uMi3B8U/d8gU4VZaOIp8/
         NikdU/Ze+zM0fiDPCedRUhSiOQKmfLAkI/TsOeF2I0iK+T6M5FOs2el208OcCKJq/S2b
         wi+g==
X-Forwarded-Encrypted: i=1; AJvYcCVasHTY03HZ6YuI4cArtllNoDrSSEfr3Uoxx1qs58G5C7zJIVef+lfNwmNRD9sfLv55rbkCcKUwCkC6uX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5032S8GUvqWDjZaBKZ+iVeD71mlO03qYkyqYMe8bvHM0RVPDJ
	wKE9vOcucbM8MTG32UKeua280Mv9JbJWYrNXAJ+cYiSQaGTWkrb5QD/wkp/0k8Bv+Xk=
X-Gm-Gg: ASbGncuKB4e4ad1hZUxd4JR5y4slaMytl/jvYCU0GTB3FncY2+AbkY8j7BPU0a2pjRM
	I5CEZjHHy5NW9uFTzNL2xeDeo1rMOJY43kTNlH5eH50XUUoFwLntCo5krvBX0rI7KcqI9JoRDxI
	ee6g0tZbscifa8pm0D2bXZ+CeizW7iVVm/nafdaNmPWhzC3LCXvDpfHfuQXovhqhezExKySa2Ry
	zMrth8rxKJuzE+OJzGqwq+lBT0WXfbau0aKOE10Lv1W0cweCfR+574OfWcMQ3dGqBzugG2AXq8a
	gPRIjQuAl3hRKpSKMDuHaFeCCUSShJIlXIBHG6NoreumqQFyKWKdX1EsoMqFsPEuw3Q2sk1LAQj
	PFJzEQ6zonoKEFit6R0LkDMb2LwuSyVkfgc32HORFLxDBva/3lqQbOAMMzu9eemivr/9iAyNqa3
	4=
X-Google-Smtp-Source: AGHT+IHz9Ep06R4/artcngFbJlB1bKA2Girkc8hxPw+EQjUGEBiqGYPMJZdtFD7tESCBa2KyIazeYQ==
X-Received: by 2002:a5d:5846:0:b0:428:4004:8241 with SMTP id ffacd0b85a97d-429bd6aa277mr2136641f8f.40.1761901483472;
        Fri, 31 Oct 2025 02:04:43 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:b8e9:e124:10fc:8444])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429c13e1d47sm2392315f8f.23.2025.10.31.02.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:04:42 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  chuan.liu@amlogic.com,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clk: amlogic: optimize the PLL driver
In-Reply-To: <20251031-optimize_pll_driver-v3-0-92f3b2f36a83@amlogic.com>
	(Chuan Liu via's message of "Fri, 31 Oct 2025 16:10:07 +0800")
References: <20251031-optimize_pll_driver-v3-0-92f3b2f36a83@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 31 Oct 2025 10:04:42 +0100
Message-ID: <1jms57xx05.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri 31 Oct 2025 at 16:10, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:

> This patch series consists of four topics involving the amlogic PLL
> driver:
> - Fix out-of-range PLL frequency setting.
> - Improve the issue of PLL lock failures.
> - Add handling for PLL lock failure.
> - Optimize PLL enable timing.
>
> For easier review and management, these are submitted as a single
> patch series.
>
> The PLL timing optimization changes were merged into our internal
> repository quite some time ago and have been verified on a large
> number of SoCs:
> - Already supported upstream: G12A, G12B, SM1, S4, A1, C3.
> - Planned for upstream support: T7, A5, A4, S7, S7D, S6, etc.
>
> Based on the upstream code base, I have performed functional testing
> on G12A, A1, A5, A4, T7, S7, S7D, and S6, all of which passed.
>
> Additionally, stress testing using scripts was conducted on A5 and
> A1, with over 40,000 and 50,000 iterations respectively, and no
> abnormalities were observed. Below is a portion of the stress test
> log (CLOCK_ALLOW_WRITE_DEBUGFS has been manually enabled):

Okay, this little game has been going on long enough.

You've posted v2 24h hours ago
You've got feedback within hours
There was still a 1 question pending
The rest of community had no chance to review.

and yet, here the v3 already ! still with bearing pr_warn().

Chuan, the community is not dedicated to reviewing your submission.
Time and time again you ignore the feedback provided in reviews and the
documentation. I've had enough of your sloppy submission.

I will not review or apply anything from you in this cycle.

You have been warned multiple times. Every time you ignore a review,
you'll get ignored in return. This is how it will be from now on.

>
> - For A5:
>   # echo 491520000 > /sys/kernel/debug/clk/hifi_pll/clk_rate
>   # cnt=0
>   # while true; do
>   >     echo "------------ cnt=$cnt -----------"
>   >     echo 1 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
>   >     en=$(cat /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable 2>/dev/null)
>   >     if [ "$en" != "1" ]; then
>   >         echo "[ERROR] PLL enable test failed! (clk_prepare_enable=$en)"
>   >         break
>   >     fi
>   > 
>   >     echo 0 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
>   >     cnt=$((cnt + 1))
>   >     echo -e "sleep time: 1 s."
>   >     sleep 1
>   > done &
>   # ------------ cnt=0 -----------
>   sleep time: 1 s.
>   ------------ cnt=1 -----------
>   sleep time: 1 s.
>   ------------ cnt=2 -----------
>   sleep time: 1 s.
>   ...
>   ------------ cnt=42076 -----------
>   sleep time: 1 s.
>
> - For A1:
>   # echo 983040000 > /sys/kernel/debug/clk/hifi_pll/clk_rate
>   # cnt=0
>   # while true; do
>   >     echo "------------ cnt=$cnt -----------"
>   >     echo 1 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
>   >     en=$(cat /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable 2>/dev/null)
>   >     if [ "$en" != "1" ]; then
>   >         echo "[ERROR] PLL enable test failed! (clk_prepare_enable=$en)"
>   >         break
>   >     fi
>   > 
>   >     echo 0 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
>   >     cnt=$((cnt + 1))
>   >     echo -e "sleep time: 1 s."
>   >     sleep 1
>   > done &
>   # ------------ cnt=0 -----------
>   sleep time: 1 s.
>   ------------ cnt=1 -----------
>   sleep time: 1 s.
>   ------------ cnt=2 -----------
>   sleep time: 1 s.
>   ...
>   ------------ cnt=55051 -----------
>   sleep time: 1 s.
>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
> Changes in v3:
> - Fix some formatting issues.
> - Move the 20 us delay after reset into the corresponding if
> condition (no delay is needed if there is no reset).
> - Move the code that releases rst back to execute before current_en.
> - Remove the patch that changes the active level of l_detect.
> - Link to v2: https://lore.kernel.org/r/20251030-optimize_pll_driver-v2-0-37273f5b25ab@amlogic.com
>
> Changes in v2:
> - Modify the judgment condition of 'm' out of range.
> - Split the PLL timing optimization patch to make it easier to review.
> - Link to v1: https://lore.kernel.org/r/20251022-optimize_pll_driver-v1-0-a275722fb6f4@amlogic.com
>
> ---
> Chuan Liu (4):
>       clk: amlogic: Fix out-of-range PLL frequency setting
>       clk: amlogic: Improve the issue of PLL lock failures
>       clk: amlogic: Add handling for PLL lock failure
>       clk: amlogic: Optimize PLL enable timing
>
>  drivers/clk/meson/clk-pll.c | 64 +++++++++++++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 25 deletions(-)
> ---
> base-commit: 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
> change-id: 20251020-optimize_pll_driver-7bef91876c41
>
> Best regards,

-- 
Jerome

