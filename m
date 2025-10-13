Return-Path: <linux-kernel+bounces-850840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 775EDBD45C1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38E8E505C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B68B30BF7B;
	Mon, 13 Oct 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5KZpWXS"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4A279DCE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367789; cv=none; b=KgGbeZr0nohvpdmo1vTR1GbwfgoQjcZXIzrUELeMIlP2mnWAZHXyMvNluQtjdYCa/KDRpTA0RDBGcoamrBySvPQ2F99CfcAvK6rIujcFqpwmxViHgt0iJTX621N6yXeL1ldn95ihxk25zrWeR3NpmLF7mpmJf9w5V+XpvamxDD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367789; c=relaxed/simple;
	bh=yxmfbmFqBjhJPcGSJQ70GYxCJxcNkC5IerAsMJRG7zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rB0yr0eZF2fFx4zUIRl1kjsSkNwT1g1+SrSWkq6xO6rPkYJcn0SvCegbKXPGq2r5FpWVuVJc+qKNAmRidCtVxYo8mSn0RMzOttnwKgrMENEoQow3ltyQCbrreRAmgQITmGc9xaVShBxYaURAveT2tWQdMnh7zNcJDlAuhZl1hug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5KZpWXS; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3b27b50090so804215166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367786; x=1760972586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hz2YlG98H4CyxP20y5sm8rq4XvWnKRXPRfDLzFVO22c=;
        b=F5KZpWXSGiX0dtO5yLdxUx0cBShqBsXgLx7cFSrFGj1xcKY/GGOy8UE9/jEhQLETeP
         BD8yGEuMYb56trEHQjg6/Syrv+8MMayy7JZqpr/y/zNom2KqH/2W5LWYmVe0UBag5ybE
         TcTaWKpHRQ6neaUyJm59eRuxTqnDOeA1+Rkr1Ym7gL4+59BMBNpSy4A9It5gSMs5Hquh
         gtgxcCms1M2fl7C2Zf/rTZya8HN5Z8PLlwVyM8KNMkIYtwyM7G+gXZ5MXJ6CrxvFos9y
         375LzgOETrzV4P700Ba2HNlG7yXKfG7WpcjbgCrKg/JfPZr6M7dm7xSFUZPvtzkVQiPs
         Hu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367786; x=1760972586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hz2YlG98H4CyxP20y5sm8rq4XvWnKRXPRfDLzFVO22c=;
        b=bZP3nouFtWof5Ewl0iCc8xd/GycDpk64tYlo81z0jQTeu1Zy34af7XHDtwMp5CtX2Y
         LGw75EGWs0HGncMCkD/Miws7to1+GTTuAmWBTOlT3FB4AhoRCw0YKHLa4bZ65GIhg0gy
         tYeM4dVF6q6ERFcGGw4DuzenZugwgpSNOd3eQ3CXv+e+CZEeinmedC9oiik+Ttr0Ggi8
         CwC8JeSG2+0B0R/DuZJjaBdsQsJnf1o5Ia3ri9ukD3PheJA18pTgGFErIB5oPav9o0dM
         s4qOunGewAFJS4uT0DfZmCKxpmqwjpcSBI8rJoP4yVTTy2QmKgwBwTiehorXqdH0s74/
         GfjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdWGb8MLEC403uzlygvQhLOoiL+TUnd3Cz8Ntyk+588HhT93aWbVbXCxx+/oOxzI0KSYbfG92vJ2dUX7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUne/GnhwFnIXfUyQUluj9+68P2Gw6Wy1aEwW4G1o5f4gNyGu5
	otoY6NlelKml2ny13fO+cwqm1D0gDdVa5qrnZi1QG8AJntbX1cXJdTpP
X-Gm-Gg: ASbGncurse3D4jRH6XXPui9Tmk1uud6ElNEc8sGjBgj6yvnRCYpSPj59GWK8/JtmOYJ
	q8vcAb5p9V/1SheMl7Yes111cdw46IbkA71BSdt9BUH0or4jOTMdYoU0xuaOB7pxYSqHwanu7Ft
	VudVRly75V+a+Qab7ws1EPA1qWQ2JR8STm2cJtW4V/RBIgEXjPs4ViHj8Db9LWv6Gn4dAjXRxeY
	rI0f2WnWDzPEFscjJTN8hhotIzwHp+s099mTTU2cNl/McnFq0j83Z4X5yFqyMlrYxuMwz2sI7fl
	GLVubVi9070dkM+aDW/UOj0c9//3pxDAawBgO4dUfRwWzqCosLGo5yVfqV1C/KANT4NLStoXdaI
	xgLYhB26HvQvFKnDg8lLXIaa1GoN55S9xYd1bLdtdcBfKtWmAMX+V0evczxPmBoR0ykUjWRifhg
	==
X-Google-Smtp-Source: AGHT+IHyoP91IrU6Tkmbf3ko8vntpz06pZXNHtLm+QHSlxS7L0YQX7eZaI3fQOREDGaGd1ZiF+to1A==
X-Received: by 2002:a17:906:4550:b0:b50:b539:8be6 with SMTP id a640c23a62f3a-b50b539915dmr2017845266b.43.1760367786225;
        Mon, 13 Oct 2025 08:03:06 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c129c4sm957903866b.41.2025.10.13.08.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:03:05 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 0/2] dmaengine: dw-axi-dmac: PM cleanup and reset control support
Date: Mon, 13 Oct 2025 18:02:31 +0300
Message-ID: <20251013150234.3200627-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series improves the dw-axi-dmac driver in two areas:

Patch 1 simplifies the power management code by using modern kernel
macros and removing redundant wrapper functions, making the code more
maintainable and aligned with current kernel practices.

Patch 2 adds proper reset control support to ensure reliable
initialization and power management, handling resets during probe,
remove, and suspend/resume operations.

ChangeLog:
  v1:
    * https://lore.kernel.org/all/20251012100002.2959213-1-a.shimko.dev@gmail.com/T/#t
  v2:
    * Remove has_resets flag and use reset_control_assert/deassert() unconditionally,
    as these functions handle NULL pointers internally
    * Replace devm_reset_control_array_get_exclusive() with
    devm_reset_control_array_get_optional_exclusive() to handle platforms
    without reset controls gracefully
    * Simplify error handling by removing redundant flag checks
    * Remove has_resets field from struct axi_dma_chip as it's no longer needed

Artem Shimko (2):
  dmaengine: dw-axi-dmac: simplify PM functions and use modern macros
  dmaengine: dw-axi-dmac: add reset control support

 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 66 ++++++++-----------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 30 insertions(+), 37 deletions(-)

-- 
2.43.0


