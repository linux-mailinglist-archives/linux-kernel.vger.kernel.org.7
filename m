Return-Path: <linux-kernel+bounces-809606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 540E5B50FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C68E1C8144D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B130CDA1;
	Wed, 10 Sep 2025 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ex9SIpBB"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E446530C34C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757490093; cv=none; b=L9anBWOHEgjg96FP9iQHcsGn4drS/aDX49hOGNEar+zSBCf9bXocvHWIP+xSVhkmRo+y+vNO+lgU4JcLVY6FqqaOrJPriJpz3GzlPS836Wo7zKkMG9ebE5oUa+jK4GEnnAd+M7sveX1MVUVsI0umMo8+DlaqR0P0XBQ8P6JKiJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757490093; c=relaxed/simple;
	bh=TurTq2vFe7uDSAQE72/3WsN+FsxxrdvX1f5DqftHi8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cTsr49mayFH4RRLddeqN54cAcFcWSNIuOo5lHAJk01FoIOcxtvAPBaInbRcasehlE4r9lrwtyugCse9Ah7O0eAB+i4spaPPsKVMgxYPo1GILue2exDF7l9LksdDFWNtB4de0831sasXOhOLf3+yhYUMVxwzpNuJ6vM7LEJOIuk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ex9SIpBB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45ded619608so14232385e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757490088; x=1758094888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFi9l2xoUcPdKDTlp7DtxIMxRchiKoMRzV8J34u2n6Q=;
        b=ex9SIpBBv85d4NMr8/AwTht4O/nkoVaYFsWm8u9HRM+kIXQmcrUnweCS+2TSIbZcWU
         SB5mXgjFZh0dlu9ENH7hr5uRUMeEruySNRfr21/XZuO8O3RtbNUi47BHq4jaY+LO+LwB
         QWZ24p0uDLKK6AH2D4rtNFjiu+cwE7cMa6+3PU7lDOK4tbvlOKnsCHAVgr7UsAVA/RkR
         DDoV1i0TpzH1oWf1tqlPwbFFpKGp7FKGmtx3lc4PAVgBHCA0DH51HdHCf76hUF8NeIz8
         dEFn/70i3rY2N7BYbPOzXJxpOG6JDD4AKlDCeZEnWanO4KyNHD2GQUQ0BFuyaDwk/i6L
         bRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757490088; x=1758094888;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFi9l2xoUcPdKDTlp7DtxIMxRchiKoMRzV8J34u2n6Q=;
        b=roOsCeG2C0emnsjGfGDyqXbkRZU4zjPsrni2JYlR7hxtz0e/7rmTlJQwMiUs76Lx+a
         nKL+XEYrzhIBTW0LZyoOvTVMakHwEetp5BElrPvOuSBqBYhV1JrBfLDIupqTIbp366LB
         QzLpxPJhzJrYwvdEk26UREmZVwo/T3y2FXH5qzx6p1QZSrpkdk2woZ2J1/X6ZLFN981A
         Tr4MmZ70EbZrDbOvajPqfagAMO4VhjBaP2G2ygjBzgaWPYUFilybjI2wS6wfBWF74TN/
         TV5m7EaRLYWhPfRRk2QDM/QI/LM1iQe+L9Sd92TxSP2BOeAikzzZ/qv3RHmckMZj3Si3
         DfRg==
X-Forwarded-Encrypted: i=1; AJvYcCWEK0ptfNGwmwmcxX0gKOvWCyCze92b4ZgYO/kb/e1C1/UjScMBpRX+kv7Z+aY3GIbxKLKwPR56cO1ARlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMczOSXrDCicdREDm3dccJlreMRphpK46DxLjAkX3ojDJbH+Rz
	Tdp3XHIbdLUW/cNRfRA0mOX0z0UZiP3FQIKB0HFItf8qF/XyJOqNOqKMdTvFqurjrTg=
X-Gm-Gg: ASbGnctkqBt27duq3Jg28/QC3n5BvE5GNh7gYTfMFHZdsHZuI2VS+Cd4Cq/EiARhysR
	3h+kOnSy2xkrSSbIKG0IhiXOy3CnJN9/KXevrY4D7LWyOJadVM1mavOal51hm4DDQRmWYFopKkD
	Tbiul5xe0y3vOl1z61BFq/DEbMwTWLN9Agd3xh+STCSTAUw4buE3x0XjpxQQeo8cFgVp1gvrG2Q
	ys1O1uwtFecnagZjoBq3O5igdh5fg3DFuZXJ65T6sGFDXX0nYlXaGtbJqyI8wsQ+q/b6QOtYBK2
	tmmMFtoS3O20QjMWXMDzeNQPwt/Jzzzu3uvqQLImj1ReIfpo1lavi5wWqI8RvH5QYtlcG2Aif7S
	tO07EfRCQfii+mup/Y1QDeWr1GVkfr5k/0K8tCxEtpNaOUZPb0X+uXQ==
X-Google-Smtp-Source: AGHT+IFsU3yXlWlG1yOOb7EeI/0GYa1ze44ob0J5hkt+SyO3sFYx+UnxBi7g+7gTTu6mB+/M07fxiQ==
X-Received: by 2002:a05:600c:4b19:b0:45d:d88b:cc6 with SMTP id 5b1f17b1804b1-45dde66c652mr88230185e9.25.1757490088210;
        Wed, 10 Sep 2025 00:41:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df8259cb1sm17003035e9.24.2025.09.10.00.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 00:41:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Valerio Setti <vsetti@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250908-fix-reboot-v2-1-354d0e57c855@baylibre.com>
References: <20250908-fix-reboot-v2-1-354d0e57c855@baylibre.com>
Subject: Re: [PATCH v2] arm64: dts: amlogic: gxbb-odroidc2: remove UHS
 capability for SD card
Message-Id: <175749008761.1189257.11203428787242176794.b4-ty@linaro.org>
Date: Wed, 10 Sep 2025 09:41:27 +0200
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

On Mon, 08 Sep 2025 21:50:03 +0200, Valerio Setti wrote:
> This is meant to resolve reboot not working on this board.
> 
> The problem is as follows. In order to be able to switch from HS to UHS
> mode the bus voltage needs to be reduced from 3.3V down to 1.8V and this
> is achieved by the "vqmmc-supply" regulator. The ROM bootloader is only
> able to manage the card in HS mode (3.3V) and the switch HS->UHS happen
> at boottime in the kernel. The problem appears when the reboot command
> is issued or watchdog expires because in this case the "vqmmc-supply"
> voltage is not returned back at 3.3V before rebooting the board so the
> ROM bootloader will be completely stuck.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.18/arm64-dt)

[1/1] arm64: dts: amlogic: gxbb-odroidc2: remove UHS capability for SD card
      https://git.kernel.org/amlogic/c/663bfe77b6f70bcb33b2607e16c94fcb1029580e

These changes has been applied on the intermediate git tree [1].

The v6.18/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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


