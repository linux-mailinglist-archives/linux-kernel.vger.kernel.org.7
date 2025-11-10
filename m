Return-Path: <linux-kernel+bounces-892550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16033C4556E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B44D4E8BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832CC25C802;
	Mon, 10 Nov 2025 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hFR3FZ/x"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273DB239573
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762736; cv=none; b=o3AF/e+dvXJjqA1iDjbZlEhjeiBvX5jKlBYI2EKqo1WBZ6yBNAEOnNDuEGjrLvooyUuvkH8hozSMrT6bVThKyUrz8ovDCJKa1a/6kjWvjDmTlVe07bIic01H21+rigJ/2StCgVEpKHHu47Ah3l5MVPEEIsTmUtQ4R0CKlIzdqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762736; c=relaxed/simple;
	bh=LUwREsvCB54P+nF2qMZzK2Xq5d8lmHU9Yu4Uy90Zjvo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H5qUDlzb2dFsBclXT2f2AQ22IgGUYNR+4uqnGBVtNLOtsUk6kLvpgILkKd01PbQttpBTqvAUyg6GGIHgfwucWB1slHwHp82C6if4tQXhCIvHCCIyUjq1isy9vw6G1M+t0QBOnuMzVh5zZTUGAhqtkeL4tBpmG2HkbIgNrz4bex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hFR3FZ/x; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso13495355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 00:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762762733; x=1763367533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ow0jXvjkh77pOXWIP6I5DYsF4xpz6igLz3RhPzX2Hc=;
        b=hFR3FZ/xshkoNyuZt5jSfQ+VXYtbnH85AAMhNYL1vNq0ObRVZo3kqTd9pRB5ePgm/T
         FK/fRHmQjsHC4g9/MseoRElf+XkPC0tJOTg8N/Stpjo8x5mUBUbqeCClPC+EbHH/6d8Q
         SQL3RrYP+E0fGsZ9lWIamvwlL44kAdsxwcnpUdp/5jA07ytfRiCP5wS0vkoPV1hnmtSI
         0Yx0waezk41ae0tqyTFN2nVywJslB8Ub5aJe21eISo5PoIqkd4T5OZ4nAVu6j3/DxHU6
         Uqc8YpasHmX/uagAe4/oeprsq9vTZrCH8l8L4/syh0rxsCPEs6vULAysGDLK6y9YRHHC
         /gGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762762733; x=1763367533;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Ow0jXvjkh77pOXWIP6I5DYsF4xpz6igLz3RhPzX2Hc=;
        b=IJ+YVIDXDfc48UswbHUDegg2GQKZMmNqVOknBhntKji+CB2bYuq4I96fFDqMTsSHqR
         vRCeEqE01D4IXT7UQoP+XhHg1eNtgxP6tF6mlCvt179XKtXcSyONXh3MQJS2xHe0TXBL
         b5Vi8hsHUckc1MLBfZT6KaeaWlghKSEMv7+t90UJ445BdZ33AIOVNF+Sghmd/SRwf9iK
         qbLNOsOTTKJj0aLKDoRAqzC+BT1kzP4gR5OOfuSYvsyYRI85zx0X+w6q24BS9hM0i+O4
         VunTogmhAHHMebAB5t3Pl3y2QTD9taYH6loz12aCJLXn/fYT1e95h8DpvLTxpwehVkOj
         qiBA==
X-Forwarded-Encrypted: i=1; AJvYcCXAe/3vv4lw+CeNlfHeXx7uphgsXLUiUgQ3XTFezIiiFBEra7Uz+o6r7dj31BQUilyAuFq0ayzRlBcKUow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE0Hjd6TIBVE/tcUkvB3r5J/VFytLRfGWmBSq4wwrz5xX6Plw0
	TJWfLwlKzGUG/tt0hrMoyGXcmA8GsipGMpkpmu4gFER+hB0KEJeugEG/UT/0CJ2eJE4=
X-Gm-Gg: ASbGncui8NuZecmc9fmXJG0oZG2ujg1rW/mb/75A30rOXtQUdfR3LMDUFE3L6NmQFai
	6uXDZ9jG4JOXrCmAwFN79mvdPC9glt4gsTmYbjjk+43h/2el1Y4YpaKLPdJzXydffAsBx9qrcNd
	JoXLghyMvvPI663r+KghVDQx8tubaLJ0TiypMap8IH2U10Tc+1J2TsibV1CCaIZMACNnotgSSeU
	UsY3vexfQbuInjT80SoW3n9+uiNlc+VEWV8PJxQjbAC4t83/s90jHBGE1Scx8Sb7wmgvq2VCzMe
	Xgj7x+Xul+Gx9rR2MIERnVQVuFO9uYg6aKvvPPdGRdR2+fwFpLAHCSisUvFZfcpk9z82BuF7aRx
	6HRvTylBj5gqxzOlzi1CI8UnwvaRu0/ux8pEoIU3stihFBl3Cc8I0ubW+RQiJJtys7x1fFPlMyc
	oBgPgm55vhksf7fDLK/a+e
X-Google-Smtp-Source: AGHT+IFNAJ6Bn4FpyZtFF1NnxwYE2SjgYr7mpYVD4++XybQIbWpInXbD7iemC8JYoesp/8+j6x9DXg==
X-Received: by 2002:a05:600c:4fc7:b0:477:6d96:b3dd with SMTP id 5b1f17b1804b1-47773236f6cmr51381675e9.1.1762762733314;
        Mon, 10 Nov 2025 00:18:53 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bd08834sm192070105e9.15.2025.11.10.00.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 00:18:53 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>, 
 Yue Wang <yue.wang@amlogic.com>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, stable+noautosel@kernel.org, 
 stable@vger.kernel.org, Linnaea Lavia <linnaea-von-lavia@live.com>
In-Reply-To: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
Subject: Re: (subset) [PATCH RESEND 0/3] PCI: meson: Fix the parsing of DBI
 region
Message-Id: <176276273239.834148.1225755186046227156.b4-ty@linaro.org>
Date: Mon, 10 Nov 2025 09:18:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

Hi,

On Sat, 01 Nov 2025 09:59:39 +0530, Manivannan Sadhasivam wrote:
> This compile tested only series aims to fix the DBI parsing issue repored in
> [1]. The issue stems from the fact that the DT and binding described 'dbi'
> region as 'elbi' from the start.
> 
> Now, both binding and DTs are fixed and the driver is reworked to work with both
> old and new DTs.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.19/arm64-dt)

[2/3] arm64: dts: amlogic: Fix the register name of the 'DBI' region
      https://git.kernel.org/amlogic/c/8b983ae355aab50942c72096beba30254c5078bd

These changes has been applied on the intermediate git tree [1].

The v6.19/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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


