Return-Path: <linux-kernel+bounces-735546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1659B090D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F833A9616
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1612F85DE;
	Thu, 17 Jul 2025 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VfGPIsPp"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1962ED142
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767044; cv=none; b=PtYNGIslGFTwk145aFeYKDEx91UQAbVS5sWD+KsC6HcLSVsExVhG7CvCY8t3/FDTGjghXp8pS/BG/ES11PmS3+4Cmx2lbsz4Adxa7qxg2Ur89FePGfSf4idPmMJgn8k8iEtD5tBsb9QwEjHrpUJtkODAd0hQsHnoysb67qX8VlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767044; c=relaxed/simple;
	bh=C7O/W3BhYyiYs2/wjkkTBkEm7QxNqZ+p4PI8iml4Cxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ms69mrU4fXANpehTQbhZMo8HA5rYPkUs4AR+mIFZJUUtGInIhrLnxnnAgli9OxDuxQ+GyE22akFetb982yhGuCog9QMHq4R3dM050U1otwmqQhKzuLzlW4J7Z8kBBEhlOnC+ISvApWi2tkNNvaylanM2HH+wa+/xYy2slzMhiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VfGPIsPp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235d6de331fso12602165ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1752767042; x=1753371842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rN4bJ0MLHsMuhB36620IX8nWVKMPLDlQLQ5oOeKTkGg=;
        b=VfGPIsPprVnxMRP1pAR0T+esZeZHs+3qQip0G0TZJF7KOcIx8ZMy5muR4kgchlzpxA
         HpWMRAR2zp2A+uWnYTZcO2sOFezNwAZ35JBaswGOIanmCQhSo9YWwvWsyqfLurMcbb9s
         aFyJukZbpQLJRhw81Apj0J/Y+2EqT7tE8BCd3pJij6SHeCF4CMThNT+XITFQVSTrIxid
         JNKiT6aebL+hNdvq2sgcDzoSLprLkjzwk7vToRyEKCQ0XoPbr08mbcMT0rucCI7wwN44
         esgDtHTpsOPLV4dwAOy5LiFhfiwZ7THJLC2JOGj8QuqtMeIB9nwLf3gffc3y4ZEVxlKp
         bvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752767042; x=1753371842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rN4bJ0MLHsMuhB36620IX8nWVKMPLDlQLQ5oOeKTkGg=;
        b=LzVxDY15J+ArexhpO+nF8/yMKBSLa4t/UnhPbTjyvNq3omoL4CJrBs4f0vaZX+xJvQ
         OeDf0Pc3aZXX13H02Qwr41lbsznzA1g/LDVq+tgudxNzsYYEkD7gKjh8uUNy83A4MFmS
         9cEM160Xmooxp9n++RTzQiqMHt6JmZngELTuMEZCo9bzAVXAb+a9+elMLW825MRSeuQ+
         uTCFEXnI3nA/t9h9S5cO0ScknI6u70JjRpqBLZpcCNDBCQzgPQ0Pq2EuG3F6ar6o/dgS
         pfcZr1AIghBAsYxZkWs10Tdc7WP0ljOwre8j6FNuJZ/wsJCiut4BYQHdiFGT4qCg/qx2
         GatA==
X-Forwarded-Encrypted: i=1; AJvYcCUjko1KBASO6QFSLNyT3ABg8FCm/+aPqxAPAX0YPSSLN0uneXTqCY8RBXhfX90aRnzFkP9XxGuk3xJjCwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7dc9Bb8fqyHSpOeRNKhKu9hpg6aC9a+2MQZ4JvJ0SLAI5KnnE
	NYMi+SAxocwAGHi6MwPj6ZU5htLx2syH6zDYa+3r+5XhEfal+sAFo8+3F8EjGATkX5J7UlqsR6G
	KMVSwyrNE+02hc8r3EbWvNQq41y5H2sA=
X-Gm-Gg: ASbGncur27Z/avNJavNz89V2wwt6xdhV8/DQkw/4vHcCZBLz8NjeTwarQ3hkTC0IkL0
	lj/ZtcQOeIxEKoECeW/g8hagndPnpzFfMd5ijaaW2D+smWsGH91SE5s39pygdiXvfMp71mzieJr
	46uSJOJuumTlaxHwUhNmdWxQ8OCoPDgYhJ7zvsHhnBNETdSE1Ms5/iv6vOM3gNntrEvA16WQHm1
	fGwGtY88ZjPQQY6O+9/IASMT+Y8d/d2
X-Google-Smtp-Source: AGHT+IHA1ZrKnYuPXE4GXLTfL1TF9TCNgu66q+ocBubO7yF3+9AbPVtS6s8vpRxMX8NX3hB8Al+UyUorAl8wjgpvBEM=
X-Received: by 2002:a17:902:ebcb:b0:234:f200:51a1 with SMTP id
 d9443c01a7336-23e2566a7bfmr87576115ad.9.1752767042136; Thu, 17 Jul 2025
 08:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717-optimize_clk-measure_accuracy-v1-1-3b82d7ccd743@amlogic.com>
In-Reply-To: <20250717-optimize_clk-measure_accuracy-v1-1-3b82d7ccd743@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 17 Jul 2025 17:43:51 +0200
X-Gm-Features: Ac12FXxyJdrkT0-Udvls8NBCEN5HDOxcf-2RPU7Aaa4UPg2Q8zxybsDbpxTtPl4
Message-ID: <CAFBinCDyjf7MOE6f_AGEEwqV8z68qRv6JAUxn7zt5ZZqwFLkPg@mail.gmail.com>
Subject: Re: [PATCH] soc: amlogic: clk-measure: Optimize measurement accuracy
To: chuan.liu@amlogic.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

thank you for this patch!

On Thu, Jul 17, 2025 at 5:08=E2=80=AFAM Chuan Liu via B4 Relay
<devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>
> From: Chuan Liu <chuan.liu@amlogic.com>
>
> The cycle count register has a 20-bit effective width, but the driver
> only utilizes 16 bits. This reduces the sampling window when measuring
> high-frequency clocks, resulting in (slightly) degraded measurement
> accuracy.
I checked the Meson8 downstream code [0] and it uses 0x000FFFFF to
mask the register value -> this means that old SoCs also have a 20-bit
wide width.

[...]
> Here are the test comparisons based on C3:
[...]
> Here are the test comparisons based on C3:
I have tested this patch with Meson8b based Odroid-C1:
pre-optimization:
# time cat /sys/kernel/debug/meson-clk-msr/measure_summary | grep -v "  0  =
"
  clock                     rate    precision
---------------------------------------------
 clk81                 159372396    +/-5208Hz
 a9_clk_div16           24000000    +/-3125Hz
 rtc_osc_clk_out           31250    +/-3125Hz
 hdmi_ch0_tmds         146399038    +/-4807Hz
 sar_adc                 1140625    +/-3125Hz
 sdhc_rx                94443750    +/-3125Hz
 sdhc_sd                94443750    +/-3125Hz
 pwm_d                 849921875    +/-31250Hz
 pwm_c                 849921875    +/-31250Hz

real    0m0.102s
user    0m0.005s
sys     0m0.069s


post-optimization:
# time cat /sys/kernel/debug/meson-clk-msr/measure_summary | grep -v "  0  =
"
  clock                     rate    precision
---------------------------------------------
 clk81                 159373438    +/-1562Hz
 a9_clk_div16           12000000    +/-1562Hz
 rtc_osc_clk_out           32813    +/-1562Hz
 hdmi_ch0_tmds         146398438    +/-1562Hz
 sar_adc                 1143750    +/-1562Hz
 sdhc_rx                94443750    +/-1562Hz
 sdhc_sd                94443750    +/-1562Hz
 pwm_d                 849992188    +/-1562Hz
 pwm_c                 849992188    +/-1562Hz

real    0m0.173s
user    0m0.008s
sys     0m0.109s

So there's also an improvement in accuracy. The only downside I'm
seeing is that it takes 75% extra time for the measurement. For me
this is irrelevant since we use this for debugging.

[...]
> +       /*
> +        * HACK: The input clock signal path from gate (Controlled by MSR=
_RUN)
> +        * to internal sampling circuit in clk-measure has a propagation =
delay
> +        * requirement: 24 clock cycles must elapse after mux selection b=
efore
> +        * sampling.
> +        *
> +        * For a 30kHz measurement clock, this translates to an 800=CE=BC=
s delay:
> +        * 800us =3D 24 / 30000Hz.
> +        */
> +       fsleep(800);
What is needed to make this not a HACK anymore? Is there a register
that we can poll for the number of clock cycles that have passed?


Best regards,
Martin

