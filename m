Return-Path: <linux-kernel+bounces-720647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 868A8AFBEBC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D689189F6BF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613A327A462;
	Mon,  7 Jul 2025 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrtuIotJ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3017A1A76D0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 23:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932002; cv=none; b=PVqlO/i/to+nFPYLZKo0uhhefPJg6R06eXqh/riP6umaNdPeCSCtwfJ2ZdQHvUHQXFBTnmx2bRwgcQ88r3ng9fsaaRfF+es9Q27qb7I4XkLZASxy9ohtuiqSjUont56bDyMsgjcDoQAVT//b+oV4wuia5fJ879rZin2HC9Cg/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932002; c=relaxed/simple;
	bh=l8PSFBASLdJut+GU1aFbNRoDFl03raPJNhniXdjfRfo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uPoukofPIjPnO5qtXa7F4lwM1N0d5xJiEwfV7iP+zUT93zbkWtoHdhY7ib/ULmfnuloKnB161ijDtdI7Ww4vDWXVym0tV9aoeyZk+pBvyYzfCfkuFuvPJzXPpnWppvn3n7dhKXHMT6SQeu1ojU51IHjuWeUO0/9eajB/ikrAiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrtuIotJ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so625632466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 16:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751931999; x=1752536799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1fi5w0DR+FyqjgkZcHHsVS9qWZcL5DthmO8OzA77qp0=;
        b=RrtuIotJNO7g8O3vMwh/j5IklyeGz5058aBlBVALqIilMrFFEvBdEtRvAi++Yc55dX
         xWV+v+6CC55kOtZeYXMhdQG8pMwzP6KSlJO21Urlfaxa6fENAN/A8yv9VxGzVqioKpbv
         qpAKRYGmgM0s8t4Gq4z8eRUDsI1p7YjlJGlbvSC5ZSU6wG7HddiYqVOi3o9Z6mbGOIR/
         AUedRlEPaFsxzFM0xol5DrBBes8V5YctR58/R0ODvJqCOmM+zWCaC1lTyl4DEE6QSsv9
         tQuufCkdzmVwi06gQI7VbiPUeaQ0y74K9Wp9bX992+He+UCZPg6tdyNxP9QVV5O3aCud
         qR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751931999; x=1752536799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fi5w0DR+FyqjgkZcHHsVS9qWZcL5DthmO8OzA77qp0=;
        b=Wc6TjD2YXdB9VeB7m4aHY6KxHMUCOvwnwPflfx2SZ4EH8h/y24KGE7E/vt3FXCN7OB
         Sausw6ZEm3BaQPWQmX8hteNz4Tqt1eMLzOFXGpv4T8D3UkFFi6duSj5Gw2o/1kwjfRTP
         Rpa8+HqdQJOuY4QTJrOuiI/uJpbiwpzgOLK5JZnrZrKe5rocVMs1Pw7LIIio3PVvZp75
         tmtKZ89aohGoshDMME/tcpWi2ddpqfBsQcZNV1YjOi+xn1u9xr79KqksJNfrJ0iFiyYs
         2MOq0vH7NJOP8GTbDLuQXc35yYizRulZ4p7OnypFhSqFX5CG9oHsjl73EvfjuKx93Ts2
         OlBw==
X-Forwarded-Encrypted: i=1; AJvYcCWKEMm28SRfs6ms50C4+0ircpULEU/3M0hfUddyyjs18S/A6Y7JtRCJSNkc7R2+i645Fbl3zDv32UYBtG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBy4BETR3twflgMdS3UIz5EMOK8pfnmPi2fpYqtBHbHjmvTAtQ
	Z4Mm1Na4hzUNSKD8Z/1CrWdBJsE8py3cGSpeeD6XbDJZHo59/sDFLX//
X-Gm-Gg: ASbGncsP8YomMWt1dQ/rxjmG1af0iVhgz/2Pk6MGTUCeOpclCwMcJjKEWwy9BQvj/yB
	+FgfSOIBT5PFV2tmp2QnWdX8/XEMBc7IQZKtXwfHkRT7P0lRt5eMygGEuLLUqSdbWo7C/Ei64fn
	Sa/EbncCdnYD9iafyGTu4Ew8v0kPlE+KiLNaL0IJhtTvLlhhJENqZw6NVIdFfBhlLNqZJg/gkhd
	oYAi9VMFM6+oeOBuIWzAqRM6F2dLS1fD5dD+RmWv1q4mJlIBMcfpyMlt6jlScDRrzMdPdOJqa4i
	2Mmp+NcMLYwL57GHX4ByhWkkd8Xskh3Aq0+uimJkNF9vlw0CyaOfF/TLTuyEjDcJE3dvV1ncnQj
	MIFdEYkMu6eWg1j8xU3cy4M4=
X-Google-Smtp-Source: AGHT+IG8IzAN5Gc72bWerrOtzcRkbpj2JL0dKhrGlpVZA2c4kmwm79VJMsV+AFaKrJkxF9i66kiHGw==
X-Received: by 2002:a17:907:3f0d:b0:ae0:db23:e3e3 with SMTP id a640c23a62f3a-ae3fbc56f54mr1529856766b.16.1751931999299;
        Mon, 07 Jul 2025 16:46:39 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d1ae3sm781539266b.7.2025.07.07.16.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 16:46:38 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mark Brown <broonie@kernel.org>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 0/2] bus: imx-aipstz: fix probe-related issues
Date: Mon,  7 Jul 2025 19:46:26 -0400
Message-Id: <20250707234628.164151-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Since the introduction of the i.MX AIPSTZ bridge driver via commit
796cba2dd4d9 ("bus: add driver for IMX AIPSTZ bridge"), a couple of
problems have been reported by Mark Brown and Alexander Stein. Namely:

	1) The driver doesn't get compiled when using the ARM64
	defconfig [1].
	2) The children of the SPBA bus do not get probed [2].

These issues are addressed here by:

	1) Enabling the driver config option in the ARM64 defconfig.
	2) Replacing devm_of_platform_populate() with
	of_platform_populate() and passing a reference to the bus OF
	match table to it.

[1]: https://lore.kernel.org/lkml/ac1daf6b-ee06-4076-b86f-b436ca0acd6d@sirena.org.uk/
[2]: https://lore.kernel.org/lkml/5029548.31r3eYUQgx@steina-w/#t

Laurentiu Mihalcea (2):
  bus: imx-aipstz: allow creating pdevs for child buses
  arm64: defconfig: enable i.MX AIPSTZ driver

 arch/arm64/configs/defconfig |  1 +
 drivers/bus/imx-aipstz.c     | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.34.1


