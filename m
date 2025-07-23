Return-Path: <linux-kernel+bounces-742152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65033B0EE06
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7596D6C4738
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29826284B2F;
	Wed, 23 Jul 2025 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJ63pBtV"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636A283C9E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261507; cv=none; b=R6Pn6+paEJv46a1U/ruHO6m4ZcvhQgo3CM9Z0H7TTwTic25hY9DzSC/uWB9OP5BDcMiaZEgauA5ehYhLX1VhYH1dCOnRw3ciebTZJpK9QZaM8vsCO96Iix3l9HdPCBYo9/GY9oyKCIumaaVOYZ5fIz0YwKgDiIcn6FSkbN4K75M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261507; c=relaxed/simple;
	bh=k3GjnkVYrP1B4aQik37L6qakXOv0eTA+cuGhbBu9yp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psPuB1n2GXxZ7JdvKgmmHW4z/ujZlTs+SAzE0eWajCTIrOH5HUq9E9y0He+YlLmwo0+77YflJpP9xGOQknsg2tlXrz065uMz2Gw77NxJp1+bD8qL5XYZIB012TEjc5GVu0GRxWCIo4UzqCFAN1krtPk8lCDyr4WXi08Acb1fwEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FJ63pBtV; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af374d96046so6589966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753261504; x=1753866304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCgbja/gOTY6PAB9qzS6fOz3VhDsGQwTh8VHxpGStNo=;
        b=FJ63pBtVkQAyu7mvzuj18M7GkLkfgk0Q0nN7DizSc62/ZrnjpNUBhHW+1Jn90X1e8C
         HX+78PHoZLew1ncvpYZQtn1KUkS1L4GWMkGC4PPKPRHI+QILc9d+VVYeoyPHR3xJfL2D
         M5yWmBiKtYITLQJk2hPNtBnSzdl/FHnTw4DpKwLZSpd/3dUiLPbcBVFbsSGfjQuF9tbB
         Ox1cSq+R2FVn4etsXNmqL46zt6oIQovdUyaEIj5rqlxDfUg/g0+zcq9cBlSkeYr0JIPh
         IXJn+cdKasm905Z+A7u0qCFBFFrvvtEl3mAgjFiix12NGDx6pwePclkzBlQQLfAiRXS7
         Bbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753261504; x=1753866304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCgbja/gOTY6PAB9qzS6fOz3VhDsGQwTh8VHxpGStNo=;
        b=PzbWYBdfQby5YE0lQfoYfDYytRifvMkl3nb7aWqhevtaUl4wJbqwar8MkcPSU6XhbG
         EifTvlDstAdFN1DKsuRORiNQ8OxvMfiJgoAOTf8hmS8t+g3+G1wN3oXpZyl+6RalstJK
         M/fA/PALjNvYFLWtRjPRoReGi/EAXvJAmB7r0WhxQxuF/4TnBcCSsmlC/rSdl5F85gco
         0gGU78bb5Euh36dgqv98Z9pYspJ6pCeD0Gxz4u7pmAMdFKbD57cRKygI+EajjwCaH8ck
         DWjJNy3FhehlzuCL7YCqxoQPeHX/owlnmA2RunIz0V27HNo0IVj0vjIdI/I3dUYAkMkj
         LxaA==
X-Forwarded-Encrypted: i=1; AJvYcCUl926wGBu//oJrXt4sxdTcBMWrlga005sn7tbVMqc7awtNcIPyB6XjfwBYjktvd8D3/6oYTW3bF61t5RE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo/Cj+/mruUuX9cPiHMBMeimRT91nIBPRzQ7p6nRJdf+SCLnhR
	gyRm9M3O3U7UsnKoYf8+X5hqUtyBwkIjVYYP8bWkQwuubDRRn+ybmvCYj+tyF4zmj8g=
X-Gm-Gg: ASbGnculyBHJ/c8w6WKfz7jx850apA9OCcJUgxXks/bvA/T1PnH7J9vx7fLd7sGmcit
	lxPdH84N7b9fwyc5F2mejy48ttrJBUm0xq6m31MAlvRmcFUzaq9AIupNhiVio5vYREVNCQKwjbx
	O/uTPCZ7nhI9YvxdY+p15Xl5QRPyaLE40nFX1z5ve4z0f4GYvqfXuBBeSnedbBlP0/BQENe46PI
	5PD3elatHrUpVGhHHnw1pVu4NolbvynAHOEwuYDQ6miUjm5LJabP7TOwwAjpgQ/o0xOuXJmaaON
	07RLM/j8ZSjo9XXruDIfNqnWyPcC+gv7lMMwCSmoX+47TKJ/1drllbPzapXzhFAoXiUvVStoOI6
	diiYCPxaxhDdOQj4mAYX/LcIJk1k5sSgU
X-Google-Smtp-Source: AGHT+IGDvi6weUHt1zBLFFABHti+LtpFg4sB/fcxjNLis7RjEwnRTt3JzWNz/nbQdoKPmX82/bVYRA==
X-Received: by 2002:a17:907:a07:b0:ade:9b52:4d84 with SMTP id a640c23a62f3a-af2f9171be3mr83211566b.15.1753261503791;
        Wed, 23 Jul 2025 02:05:03 -0700 (PDT)
Received: from kuoka.. ([178.197.203.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af22f6fa6afsm208165466b.120.2025.07.23.02.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:05:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/2] arm64: dts: samsung: dts late for v6.17, part two
Date: Wed, 23 Jul 2025 11:04:56 +0200
Message-ID: <20250723090455.25295-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250723090455.25295-3-krzysztof.kozlowski@linaro.org>
References: <20250723090455.25295-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=k3GjnkVYrP1B4aQik37L6qakXOv0eTA+cuGhbBu9yp4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBogKW4P0UvirWoR64QHVT8sGAC5b3VZtif/zjju
 Tcgt15OsOCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaICluAAKCRDBN2bmhouD
 1/8/D/9g5Op+GBYMMSso3IjQEbVlUOXL50H08DRw5IhgOD8/JEC2MB9HI9A27GE+SOvvAuMn95N
 yAiQz2hEVZVBMhZRjSMvA/GgGL68YsFXodGDzrrohbVaQBX1Tt8O8pNZQg0un1MdSGlQk+xmEEz
 VAydxdgmYXNjp7x0DPiOKXgmUTtCBF2SI7l2gDJxZXbHeqx4J88M4eKos3AsLn/UPhiqOSbtOf/
 Vf/1i3bnQvPYiUYb/j+RJsA8O0Z1VsrZn+S81zDu+YmShmJ5K3hXRBPyhhFNvFiDSkEfAcfzh16
 ZhNgr+hH3eLnEBurn/mVIK3C86dvHdYHRRabzt907PbYvYewMqEHyciTIikc77zvJFcemeaKIn7
 NdTymOl0yn1JpbBmqQp3sz77KNHp872fGEBnPjNSW2GcrSERXkEYCjMi4MFD4QqTw/91G7z9AAv
 7jnvOxIoBDk3osWnb2TMCZgTgCm9pKnCyWsBfnm2KrgNVzAknGozS9iMV454DIR2b5Q+QiCltVb
 6/ZrFsnOuREufeR9O9esdGUlIh4T0uEawlYXyPN7/El2KsAWBhWLa3CxYFlBR6KF7p9Lmp9UQzi
 4YSy9Fs/jY70dFp+NG1E5y9nbX1sxvpyRYn0aCzBg+v3p2TqaMgjD/i43Z53S1X86c9er7h6DJg 1IkmyPCm1CfKkZw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Hi,

On top of previous pull request. Late pull with minor things.

Best regards,
Krzysztof


The following changes since commit 49a27c6c392dec46c826ee586f7ec8973acaeed7:

  arm64: dts: exynos7870-j6lte: reduce memory ranges to base amount (2025-07-05 10:23:36 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-6.17-2

for you to fetch changes up to 8e5bf103b3ada972ea890ae6aa2118ff9b8c321c:

  arm64: samsung: MAINTAINERS: Add Tesla FSD DTS to Exynos entry (2025-07-15 11:03:41 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v6.17, part two

Tesla FSD and Google GS101 DTS are handled via Samsung SoC tree, so the
clean dtbs_check rule applies there as well - mention this in their
maintainer entries.

Also, include Tesla FSD DTS patterns in Samsung SoC tree to document how
the patches actually travel.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      arm64: tesla/google: MAINTAINERS: Reference "SoC clean" maintainer profile
      arm64: samsung: MAINTAINERS: Add Tesla FSD DTS to Exynos entry

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

