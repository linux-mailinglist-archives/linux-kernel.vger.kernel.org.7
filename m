Return-Path: <linux-kernel+bounces-717602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD4DAF9670
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 17:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731441CC2F1A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA30B1D54FA;
	Fri,  4 Jul 2025 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dINeEi1k"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD72877D5
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641883; cv=none; b=gHA9lWuh4mHu7jXP6Rupun7pVZnt6Y1fIBjuI/OOx1dPW+pmIWqsPj30Yn54sIqt2SlxiBSwaZIsUFt6BoWtPrXzvBy6Kna0iSjIJbdm3GmIS5PWWQHKFcesI9rBNX1AxaSrXBgDBhgFvQJMgCo5XKvpH8EgjNE94BYO6+nRuNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641883; c=relaxed/simple;
	bh=5waSe9JNG3bmoZ4Dl76hVYYd3LVFKdDlnURf+9XosaU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HG4Eza7POgoZqcDELmYd2zvULKyyOUb8j2j7o6GotZEUqMlXfHbLq85CEZtl8RW4cH+i/jQVeah96xV1nNacpRiKlv8fg5tTH8XarH3e4q/dSdPn1wZDuRbxF9Ne0mYnakdqGpOfvu69ReU9ME4L0N2nOLnAD/dxl+dPldICsYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dINeEi1k; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a528243636so613233f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jul 2025 08:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751641879; x=1752246679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0fTEoeFH2CCKRZ2GxYERj8nq+92LKFVKj9HqnOJJLg=;
        b=dINeEi1kgZWQgFEYAJ5FVwmFBPT5EzLOv33qfoPmv7r4IE0mgMMTfMsGwcRyuRe61K
         FMkjIBZSJIecG2RitvoOimj6hMLBTAIV1TaS5zpnBYcGTdxIi3lr8/Up6IzFeh1D2qja
         39f4WyarFFq255vcCosZ+jh7p++fRISzDvr1ZTaGDlZnF8iivGDatb1CKjKpbUkvJlh7
         yu08I2szKq4Gx4MvWFPB27Ys/njhieh/zhJjsYoPaL/at6nIkKl0INB+XBIUPMr8fldA
         /pefZShXVZnyVxYycrUDATLgiTbIU2NNQ5i4XxlIBUsOoN01fRuT23OGkjx3QerUwVZ5
         1HaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751641879; x=1752246679;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0fTEoeFH2CCKRZ2GxYERj8nq+92LKFVKj9HqnOJJLg=;
        b=QkcQSJ/0iaJA4THRLkRsEduEQiQDNL12gAL9mPQsD2GrO4pOKjBV8hZNzxCwenkAQa
         w23XuDzQD34tJHdAR4YlIeK8IjF5oJba5GrUPI1yWblX3NDY/PCHKIj2f0xjfXnN/OKz
         JU0TrxzyZfri7cx9S+2mCvpT6ftW3ESHmNQMCdlATIY8XzLOXeaqZVQ4cbnawzK31Y/h
         PjGRqrIKuAxKJ6zP8SJrjOj/fQurwMDGBPWLt6sTubr7fQ7k+al+p9zc7vmivyUjC4/A
         /efupZlPVhcLrebxlmuOhcU2HGFCSLvxkwODv3q3SiGyk/eOkhpc6nqdHozLFw/T8hWh
         C65w==
X-Forwarded-Encrypted: i=1; AJvYcCUpG9ICESJW+X2aXZwQJr0ZIhyhzkeuFJVaogxFuMxE0+ODpdoTiVW8owXzXqoyQCxZLXyT9WGPxNBJyPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI31/DzupqONms6Vh4ng9ggPFJqQVa9qMHHRhOkwU1ba9jZD0h
	l7c6Yq6OM6We6qAK1wfXvphCubOvDq4UhH+hwy/mVtkzkBElAqaQqDWuG7xh29lLnGc=
X-Gm-Gg: ASbGncsks7CpPG5eqFwGL/F7m2ZO4Grf/yk7ina27uALNoh8XrHM8bn3r7rjn14Q5Ib
	6inENkMkSf+jLg3PF8+Xaal7TJjSxItDjxAw5kqBgaBQzSLpjqG5PRajivLRw5y5uEK2HY/xbQK
	DDreodVTmvAjM9/LaZXqLbaoIHBScaBEUAza5LZihWLLrti7TjlkqnTdhGr6xqfjpd3gaAY298Q
	99OwW/JN1VNKk+cj6MTSE9TIv3F4gt31mRaIzr1+q/xSyByjDvl3VIVSCwqxYdJh344KSo39vuo
	bu64JRVAem6WOC+MrPBLsOiUB5tzxwxAENkcB9NjMp72qfpEwN5g/68TelrZ5Xh4lSMNyrlBWxu
	8Yga+KDE=
X-Google-Smtp-Source: AGHT+IEK4aTwZb/t+iBAfYaNAla4w2TjyMyeRG101P7FjyngDibQMih+NwFX/4yVby7V0AceGcPGpg==
X-Received: by 2002:a05:6000:1a8c:b0:3a5:8905:2df9 with SMTP id ffacd0b85a97d-3b4964dc1famr2429125f8f.37.1751641879342;
        Fri, 04 Jul 2025 08:11:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b470e928aesm2675416f8f.44.2025.07.04.08.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 08:11:18 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250527-s6-s7-pinctrl-v3-0-44f6a0451519@amlogic.com>
References: <20250527-s6-s7-pinctrl-v3-0-44f6a0451519@amlogic.com>
Subject: Re: (subset) [PATCH v3 0/6] Add support for Amlogic S7/S7D/S6
 pinctrl
Message-Id: <175164187861.2868628.1382846991470897290.b4-ty@linaro.org>
Date: Fri, 04 Jul 2025 17:11:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Tue, 27 May 2025 13:23:27 +0800, Xianwei Zhao wrote:
> In some Amlogic SoCs, to save register space or due to some
> abnormal arrangements, two sets of pins share one mux register.
> A group starting from pin0 is the main pin group, which acquires
> the register address through DTS and has management permissions,
> but the register bit offset is undetermined.
> Another GPIO group as a subordinate group. Some pins mux use share
> register and bit offset from bit0 . But this group do not have
> register management permissions.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.17/arm64-dt)

[4/6] dts: arm64: amlogic: add S7 pinctrl node
      https://git.kernel.org/amlogic/c/9291207753c733dcd9f1c08749950323f7f071e8
[5/6] dts: arm64: amlogic: add S7D pinctrl node
      https://git.kernel.org/amlogic/c/bd42a25d696e0d5ccc9e27de388d4ca9ff52f710
[6/6] dts: arm64: amlogic: add S6 pinctrl node
      https://git.kernel.org/amlogic/c/fb183c8d7a5a90cdee953701d8a5b92642a2e917

These changes has been applied on the intermediate git tree [1].

The v6.17/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


