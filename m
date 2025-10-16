Return-Path: <linux-kernel+bounces-855957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E44BE2C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0413C5E02F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83060303A24;
	Thu, 16 Oct 2025 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ngSVI82t"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E05E319609
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609131; cv=none; b=iBt2HbdmXpeKhnzWIUDsqn7JesXFMGAMMLVuBlHxYCrWTu6k4mhJg8X9hEl2Os78lOy0GkE6laj2aWLfpBs8rBiA12+zEXPS3xoFkCJzK5YS8jZn5WNv8zsRO9QDkj0YWwRA16E0+AAZUZB2XPI6mDcDSUbjRbihOEH3v6VI/5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609131; c=relaxed/simple;
	bh=cWcu3Ax4DtLLzYh8TBE+qD5Mbh/poXOPZlGQ2j7waPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h90/aoCFsvSD7KfB2Ogcf6snkgiDPkmB95vUeSz6EQbEnxB5NBsx1Kcu+uPcPglts56u/4LV/TrFXAtMm1Rrfg4sfiDL+TTppVRygFCe45t57vAOjnMdH0icqLstibup5VOWFezNw9NTewT2s1E0Y23MQTcFi+CrIcFFDdAodMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ngSVI82t; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so397297f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760609129; x=1761213929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbRkTY0r4UfeaobdwWGJ7pbhy9oy6EGUrhUtAkEQNXI=;
        b=ngSVI82tWvVDPOV4jF6NrIxkxHD1v2TZRJ/ARvuuJTOoWM5rTm5xzXAuPUt8NwG1Fw
         16P2jrkfc10ts04GUPd1ZpFrkE0owlDWEvGy4ortejmduWZcVTYOnOHaj7iiD3q8PzYe
         dVHySTAjJKth2/737JpOOe7P6OkCB1qgPFD1HvMf3jGOsyqb+cgNJ5v3nkbyramUHFfU
         RNp8Iw7afTE46qmY9RT7PeZXFWrWy3aiZ2FYojmZwMp6mMACRG+QQSHlIk8Go53W+Upx
         YpUvXNeO9wN1So7YN7YhyRAmyGp7QHYQ8wKBpnUIVLUyyYrG2FqCQOw3+gKIUVYinyIN
         bmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760609129; x=1761213929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbRkTY0r4UfeaobdwWGJ7pbhy9oy6EGUrhUtAkEQNXI=;
        b=JUeXuoJZXA1gtnkuNlxNMpGPaLulwSxXc7SMrRdZhoC0YdZPCYNP4YVaXVut6yz7sb
         WEvW1DdmkPT3nBEnWW3AVXJhrEx9w0DaYdxfVblNy30Mc57NmKFOU7BSLQQlsVFp77w0
         NwwYNI4nJ5aueknKd6zvZbxBl7j/im1QJulugs0GHcE8RlYWgQY2NoGzyGseofi/Zc6X
         hB+qPcrl/T6WnHDt2rtCAJUiNyiaQsw6NYA4/Gvf6SET251HEdisxqQw2mrLxYAYSUqq
         yDo0DiXm7s2rNL+UnRzkwMCepmIiQ8VLr+mKsvDtGvTXptGMzxw62NybaDIdYBqwALjG
         CgOw==
X-Forwarded-Encrypted: i=1; AJvYcCVS4dBfYX+tUMDO4qU6e3sizgWwH7pqC3sgpzpB21xN4O40K6hz0Eks8YoB6BRO+JwhH5EPgZ/Yk3UzjjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj6Z/ClFjhQTjjtJuHQ42CEW1jB1hwd0b5eEI+9R+64tE+x3Iq
	ui2LGYK/cqAb2HIhgRSihBl1K/BqN9t6wrxnU4sXSrqNZq6prJ3G2nu/JfK8/VcjDJg=
X-Gm-Gg: ASbGncumguXKcXJ5Aeewg+KGZ9MfNC4WXsNyoYqmChHf03rqPEVGNPejdr73HA0rp2K
	+MbSXxwEa2GT3sFfzNXFguBcxlmFFfAK43Wmhf3wEzqtz+qHp3hyd4nuuYpUE277qwoeLMSBUeX
	WL6rNpG3B5ZcGQ3ko0C29r9oiJGWW4cuu4cRSjbup4dApRnCV79WRV7zMaucXCIWNeUwnpbzZCT
	JO2pxXWX8fzzShihmJvloeMsd73ICpWyoC54YMXllDFuGRCNrZn2HfI/yjpN24c47S9CxnofE0I
	MhS3q9lGPmtEyu3jQvOrS028Kule9qZhN/vODSz2ddnogeLtiUdzGemZ897/WSoMVOOiu+F0Ube
	RCSmJY4EYSBfUU4cBi47X9ye1XNoSJejt27SVqHogMweEgnoSPfWOzyLUvWyLVdleCWQCw/eIDs
	qk
X-Google-Smtp-Source: AGHT+IHDKsfvqCwt3ncOL6/nII8RAMltxRMuxkPPio2iyUMSFnL2Ai/Qs3jx0un5E4aQb+USZeFKjQ==
X-Received: by 2002:a05:6000:4305:b0:3ee:13ba:e138 with SMTP id ffacd0b85a97d-42666ab9934mr21320424f8f.26.1760609128627;
        Thu, 16 Oct 2025 03:05:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ef97:57cb:86cb:f7c4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1024sm33475547f8f.42.2025.10.16.03.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:05:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Shawn Guo <shawnguo@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: (subset) [PATCH v6 0/9] drivers: gpio: and the QIXIS FPGA GPIO controller
Date: Thu, 16 Oct 2025 12:05:13 +0200
Message-ID: <176060910602.64650.7023197009719546944.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251014155358.3885805-1-ioana.ciornei@nxp.com>
References: <20251014155358.3885805-1-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 14 Oct 2025 18:53:49 +0300, Ioana Ciornei wrote:
> This patch set adds support for the GPIO controllers on the QIXIS FPGAs
> found on some Layerscape boards such as LX2160ARDB and LS1046AQDS. At
> the same time it describes the SFP+ cages found on these boards, which
> are the users of those GPIO lines.
> 
> Before actually adding the GPIO driver, patches #2 and #3 add and
> describe a new compatible string - fsl,lx2160ardb-fpga - which would be
> used for the QIXIS FPGA found on the LX2160ARDB board. As opposed to the
> other compatible strings found in fsl,fpga-qixis-i2c.yaml, the
> fsl,lx2160ardb-fpga imposes a unit address for its child devices. This
> will be used in the next patches when the gpio controller node will
> define its unit address as the address of its underlying register offset
> inside the FPGA. This requirement is described in the yaml file and it
> only affects the newly added compatible.
> 
> [...]

Applied, thanks!

[1/9] dt-bindings: gpio: add QIXIS FPGA based GPIO controller
      https://git.kernel.org/brgl/linux/c/d5896130a8781de5ac8970dbb7083ce4cd6fe57a
[4/9] gpio: regmap: add the .fixed_direction_output configuration parameter
      https://git.kernel.org/brgl/linux/c/ae495810cffe29c3c30a757bd48b0bb035fc3098
[5/9] gpio: add QIXIS FPGA GPIO controller
      https://git.kernel.org/brgl/linux/c/e88500247dc3267787abc837848b001c1237f692

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

