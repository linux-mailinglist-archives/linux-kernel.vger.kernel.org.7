Return-Path: <linux-kernel+bounces-891706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B5BC434C4
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 22:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A15C934878F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 21:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932AC28312F;
	Sat,  8 Nov 2025 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lIk5OLR3"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879BC171C9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762635860; cv=none; b=CLOS5p6cTgNDpNXK+7zsZAJJtIzb/XUmvOk6IilEYi582AUJzvesp0M5yL1sJ+yzZqgk56E6G4S4LMX9WujvIh6VkNzmasCLuv2olFsF7QqMlX+a97QNnW5M1bZYQov+98MqqW17QVBpINWeDvqGXy07CqXVMMtndeMf+gLS474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762635860; c=relaxed/simple;
	bh=RMpaqWIHb1GpGEFIyrRCs/9EV1CvK/Ir7Bz2Pp37Q10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pogqoS2u6gqRLAL7+e+oe4EP7/Kh7ZmY9TGJsLIjKQkif4w+j4vexmFobrUzoDX/lbdN/Hq5Sbjyj1hY3gBceu7RZ3PaxGszSlpbVgPK1oiPawvMnsQQbJ+rGStuaCEBfZIpV1gkasEiUbHZk4G18u8st59NE6FZVCxOPu1pEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lIk5OLR3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-794e300e20dso1225269b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762635859; x=1763240659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/7GraEMhRfGX80xNeYuFThBogqrpJru9RaOOCG7cpM=;
        b=lIk5OLR3de2fqYe2alimFp2uLysPGH04vYM5/nz7u1JIv9s8Y/ogwHEPPGx5UIoWFE
         e91kDbMnT4Nl3Baf6US1SU/y7xt+OFsN1Rs8QGohLv6ktwsCVrUw5w3saw8J/UzuWVzj
         3uZBOqNDypoOGyCM8Xt/imJi8EPVpYS2Pi6sOaSDmrhZraL70yRsZDzBSOTdyh4Ztq0g
         fNfGl4AKJKuK8+kY6Yn8bhqO54Kr4HLwP9eDmlJJSQQKw5Tbr/rmGRhr8eTsTyG11P/b
         NNsrpjFYsDEbSjX10kA5HulVQBMKCDYArTb2x5Fl8WJ4Jk0DpZehfk0Fumayp20SprJT
         m9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762635859; x=1763240659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/7GraEMhRfGX80xNeYuFThBogqrpJru9RaOOCG7cpM=;
        b=r3zfpmDa8lqa6aCa+dJEPeSrGtbrzE4iTgpZkEbFXaOe99Ndkco0Z85H4MpB77Zpk3
         96mhm9BlTiP+RSVIts8QANRiWxenSZLveKKDmjEDzhFCljxiLhPYd+GikVTCCATUOMuW
         xcjgIJQgLdViSLzcpUL5S3iw9TZ2IOZaDDu+liqJnPv+6D6Nn5guaO8dM+umTvhqsBU7
         MtfaebjRvoHbxWzWQU+LjJR//gKyEFdOjiMx2fCSdE83xM1G7Zk4knGHuEvOVal6SY7e
         MW79WwQiQ/CpB0paWkfLglBNFD84Wc/oQjJyN9YAeOw3XcNGhRnATUWeNVf1auhC/Ily
         O9gg==
X-Forwarded-Encrypted: i=1; AJvYcCXRX1aq+eUuNdybn8D16v/NKAr6PHC5ocQQT4FueecjKRTOB3vM2PWHtSSmoQoPGC+t9b2uTOPJOtayrKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+C/OsFcB/zrF8lC6iYwoX5DP27yRwhO8uwC2YwfizymTz9jC
	Jig/FY0HhwDs5xHKo8lKMLYWcJmRkWijrVj7FIcsgOJE8JvXMjt6Hw9qpaZK/VcGi/tab9mz0UL
	ytvUCsjKGDO/E5wRAcDtZk5IqBCWUTCU=
X-Gm-Gg: ASbGnct/nAVtbJFh0mRxhVgARXLQSMzYe5t+kfGRjwFzDxbb11sp+d41rcLqTw6sW7u
	VtNvsjp009UTe2Y5WLJ5QAo0K80LRa0Y8HhaN6Uua0bak0Pr+2wL4gYLCMb+34wsttvFt2rQWWy
	+1s8a7JGH+0Wk/zxhQ1e52pOb29YJOP6sLHvsUzMVt/c/nHrKc0PlzAqk1U0oit7f/TUc5zak3F
	g2ho7kWSTYNGGIVb1gvqfYdj8RPw+LDzTLfV7eylMIMVa4/huw93FD13QF6No0c2tGZK2Y3iPLz
	tcShAc88zZ56HWcZG1wwHu4sCm3i
X-Google-Smtp-Source: AGHT+IHYseG28VeVAj+noWF9xeZjKVsK8sMaLAuq9kZaFRIKXzdbOlTmekGRfg/kBIVHWNLoWwy6INlqqqY7HWNBhaU=
X-Received: by 2002:a17:903:1a26:b0:25c:43f7:7e40 with SMTP id
 d9443c01a7336-297e1da7480mr46581775ad.10.1762635858817; Sat, 08 Nov 2025
 13:04:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031-optimize_pll_driver-v3-0-92f3b2f36a83@amlogic.com>
In-Reply-To: <20251031-optimize_pll_driver-v3-0-92f3b2f36a83@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 8 Nov 2025 22:04:07 +0100
X-Gm-Features: AWmQ_bmagaCbCEB_Hmpf3J-UvtRMuC04_pkThYtgGIcc82yezqw-vegzX0N5NQA
Message-ID: <CAFBinCBSjKzHZ_k+c70B+YsJHiOS4qbjAgtnWaEeQy11xg94cA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] clk: amlogic: optimize the PLL driver
To: chuan.liu@amlogic.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 9:10=E2=80=AFAM Chuan Liu via B4 Relay
<devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>
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
In the past I had most problems with Meson8/8b/8m2 CPU clock scaling
(via sys_pll).
So I tested this series locally using the following shell script on an
Odroid-C1 (Meson8b):
#!/bin/bash

CPUFREQ=3D"/sys/bus/cpu/devices/cpu0/cpufreq"

echo "userspace" > "${CPUFREQ}/scaling_governor"

while read -ra LINE
do
    for (( i=3D0; i<${#LINE[*]}; i++ ))
    do
        for (( j=3D0; j<${#LINE[*]}; j++ ))
        do
            if [ $i !=3D $j ]
            then
                echo "${LINE[i]} -> ${LINE[j]}"
                echo "${LINE[i]}" > "${CPUFREQ}/scaling_setspeed"
                sleep 1s
                echo "${LINE[j]}" > "${CPUFREQ}/scaling_setspeed"
                sleep 1s
            fi
        done
    done
done < "${CPUFREQ}/scaling_available_frequencies"

This has been running in a loop for two hours (at an ambient
temperature of ~13=C2=B0C) and I haven't observed any problem.
Since most patches are a no-op for my case I'll separately reply to
patch #2 with my Tested-by (as that's what I've been effectively
testing).


Best regards,
Martin

