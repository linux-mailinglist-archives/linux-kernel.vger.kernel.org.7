Return-Path: <linux-kernel+bounces-874774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F71C17100
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042D41A22C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32CE4A07;
	Tue, 28 Oct 2025 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVCZt5Nz"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8022DEA9E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687265; cv=none; b=mdW9N51NQzHd7d4fE3AwxjThobP24SXWXE412meLJjBKjeRSesBxf5URxGR+2pcHGs9eXrG9PPHILebcriiuneqoQmGuzaZWdLpLDWC2RZUcXh/lR1ylLZuWp0/SmEOGdfpXV84+/qMO6+zW+a9QjmarMWxeg7fkJhi0fWBLpN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687265; c=relaxed/simple;
	bh=XSoBT935MeJNZXpYqhnHPZODSP6OKb6SjpmCd7CrNbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VVXuhNJkCOGOKENMYL1vNvuayoOyYSDyAhd2VHLd9s8juQG5ZuZYfJmsbj+jd52dolMmXHLGmUASdYGUXngjM6plFmR6juCjtc8dXMsjK7Zhk4+nXYF+hN4qNSRgiKsyT8DlVWrqqcRkIa7rvIVC06YouXcUxi46/9oqONdfoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVCZt5Nz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d3effe106so1451155566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761687262; x=1762292062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GRMPPaG2+hLfbr+lXXCnX/ORmYimK9MpoVFVvxUKG+Q=;
        b=NVCZt5NzdzrB245TN4B5FlbKyFwDb2NDPa2FhqG2wdxL1F3n+mkAwqTU2BucsMEsNx
         eTbltAaaXTE5eXjQeCDlO9FeAp8+Emk8lfCW7KzIV7r5P/DVY9Y2QhdVTJon7FK6ZYOV
         n0KxjNDajhtWeToCSeSUgEdUzI2MnI/vS3Ob4XdKJ8X69pPtM3KQKJ4ckKSFkTosl3O8
         J8k4+dy6ck7bzcQNO3rv/QlaAWkugU7+KYL2tiSKc9721BhCSxrROBCRJbyDl/edlx1q
         ShgQVczTzwQ5RWNXuTcqNmyyh372DhAoxN+yJmCxhDYanxJWDQgdR5lbBX6EN7nn4wFu
         DXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761687262; x=1762292062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRMPPaG2+hLfbr+lXXCnX/ORmYimK9MpoVFVvxUKG+Q=;
        b=MiSzL6NDPH5T738TzOQpN3zFChh7ZMD7zRaBVuteGRCjQch4gfk7qeCg3qvFqUjU6s
         M5Rlrmxc34se3/VVfg2izNL9i+F0z5p+wLcCN3eTszuZV+xxFO+OQA3HXUQs02tpiYFi
         ibK/UMpxyauQK17lxzLsyjduygLig/8GIIw+khBuuSc/7v7Xm33p8GgHKjqCE6U0aHOe
         WEZ9PJjwcnY83SutOQdTMMjWtlQOOUVg9lRSM5NDMes2SKuOXfb845yfIUPhEyt6Md4Q
         Tk3akMfmMUzGeS0d+VKK1dqxJGqNfzj2fvYWlm7HZr3U2nz0n+6+g4l4D9E2DFwlW+qm
         56mg==
X-Forwarded-Encrypted: i=1; AJvYcCVEBRTTZhuQamPni5uqtUz02RdPuc142e5tbUELAu0j6m6yfVbQGUjNUdxXjV6zMiP1vs5TIQAvthd1oIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJWxe0zHQQebdAncKBjp7I58nCV2GdNNWhYxE2vNFxiPFC9xWg
	4UA7TksOBFFv3t28Wzfq8fxSaWAfLu/Az69v9X80ZTW0VX755apWU8Zs
X-Gm-Gg: ASbGnctOqhGyKd3Jjp3xFcHVesf1ov7M5YQhsI+MvEWfpQhVlca6JWvra86RH6dzcfH
	Tb8YNR9n+IK0vTufOhj26NgH1xqHri60f5njCFp1+K7VsOUW5LGs+eQCUgwPplrQ/adc8k/vJMZ
	jlO3tlREIAR1d71jXGMbnlROMW3SaJPhnpcH0opO8CgriJ89g8Pmv8Y8x/iONbz2foXoo0reJHZ
	wheJeL8fkTAIuUN0fdiYvVmLFccw07hfaZXJI2LlzzjzGyuHiR1jCJSrH4T9U1Pi7EHYWZF1+oF
	45ZSpm6OquPki0Cf7Ub4m6Uen6R2sYbk9wsRmHRn94Z26mOqjhG4bQIZLcJUxHPfuev9SYup2Gj
	asmr5QAvxcvzII/lC9A4c3lV4jFbWUpyyHQOjwkQ2Hpbqn0qe09DY0b2Kv+v5RuWPjgCGFbtwJU
	Qk52AKOTGk2Cd4sLY=
X-Google-Smtp-Source: AGHT+IFA5KTD3XK2W1v7i6BjNBnGtkR4nOklKEuPf8kgVk5BcQQrml4UCNESneaNwggUppbZsaZoyA==
X-Received: by 2002:a17:906:c150:b0:b6d:825b:828 with SMTP id a640c23a62f3a-b703d2fe70amr50873866b.25.1761687261568;
        Tue, 28 Oct 2025 14:34:21 -0700 (PDT)
Received: from localhost.localdomain ([37.161.59.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6db9b86c80sm451303666b.43.2025.10.28.14.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:34:20 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 0/2] iio: mpl3115: support for events
Date: Tue, 28 Oct 2025 22:33:50 +0100
Message-Id: <20251028213351.77368-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
The mpl3115 device can raise interrupts when a pressure or temperature
threshold is crossed, this patchset adds support for them using IIO's
events interface.

Patch 1/2 is a small cleanup, while the events support is added in
patch 2/2.

Kind regards,
Antoni Pokusinski

Antoni Pokusinski (2):
  iio: mpl3115: add ctrl_reg4 to mpl3115_data
  iio: mpl3115: add threshold events support

 drivers/iio/pressure/mpl3115.c | 226 +++++++++++++++++++++++++++++++--
 1 file changed, 216 insertions(+), 10 deletions(-)


base-commit: 1d09cf18cc91d29f650ad9811ed4868d9304d6c7
-- 
2.25.1


