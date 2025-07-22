Return-Path: <linux-kernel+bounces-740733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806EEB0D861
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA57A5624E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FCB2E425D;
	Tue, 22 Jul 2025 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6laW8He"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A12E62C7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184241; cv=none; b=aRmIsUfAl9QGEk1VDKZ2iL5wPRpQi02ZtBbm7BFXHk1qQbvki4scy8vaouoatoeKidocz9bLd3nUBImidiq34IyjYFRiCdD8nzJALWn5h/7/Zvc2/3xHmqaq8AjjtaOf7XrqCqkjkHqZlKanOYtL6rqiJrGiet91XM/85IwWq0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184241; c=relaxed/simple;
	bh=DGi3Dmzp94/JDptqF2GdCgxRYzvV17KQ8UP5ygRsGb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSqtlI/6M3zCqZrxzDU3EFGnyjiq/s/xNJRHc7pdPWsAOD+DHZdxSkACJjFeiAtWHIrRnNnTg/qUQDEV9+ZvT4/jNlHc9oRjaJSX9FHCZotuBzEgo+oeTZi0clXZ/tTyO7kJUhHWql+CnS6CBOKLg1pXOTSP5lM9x5qc+yLYeDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6laW8He; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab6b3e8386so57711531cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753184239; x=1753789039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGi3Dmzp94/JDptqF2GdCgxRYzvV17KQ8UP5ygRsGb8=;
        b=k6laW8He2UgrjIB0O46riXzIWOeK83SjDC4PomJZBnvaV4Qsnqs36RCfBXiu7vP6eX
         PcvK3QaEfMVfHyEyAxmmJ2AtnNOa0Db5dmth5I4J8c9hwvV7agmwBb0OjUfbikrnSIPl
         2Zx95OTDFEss/hPxWia2QSiIZHepGmnEl+nA/Bsbnjyjadn0jinEsjqOfv9vpnKN1m2I
         WibbtBQhipj1O7jXFIN4BQch2xiVmTVG/SV1ciKvgz/PL1gog1QynrXGgPRJjloFQZfV
         hqsbpcipstXay8ygNi2VT0P0ISI3M1klHj8l/9bGNv7hwloziKwFC8tThtM5fHQ/ToKo
         K4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184239; x=1753789039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGi3Dmzp94/JDptqF2GdCgxRYzvV17KQ8UP5ygRsGb8=;
        b=ikF0Tdrl1oWfHEDKoSd0BqRudiWtcWUh+Zzcd7aXTG5mU6QaQHjLLQUVOyG9kzzRAK
         ul8Qqd4flI6ueW9XJnMstauQsvmKJJ1RsF3LDl88DvntMIfCq7eiX3oM1gbi0VienRSm
         UEcHaq9v5hc+WeMulwHvsGk2J2CFzBFiqndDuAl+Ga0vfM3yf+pfva3ZfDJbKFEBiRtw
         6DjC2rIyoenomVRy7A2R96XGIrycfIOTp7XRjxTrTA/61c+6axbiUv6Q3Cp8mYlo0ORU
         ODKzblJruKOKUk71RPaf5V/+7cPZcYBp03lvn2iHsGW2GTvRKXBDmmx5Ib4+STj7JdjM
         WGBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrSkrzE3Jxn3oLZaa890iqgBzMKL83QdQhR8qXon/XpWTjfn2I8kECdamsK9A1Km3yN+/Y1ihPhEYT1kI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpr4xbPu0L0G789M+AFt1DC+LeGtqQqOSSFzt1ojcQXrYBfnoi
	23dcHz2bBZ7aSUc49gcxpzNUEl6RM/pe9TD+x4dRJJ00Wzli95DB5gHdFyjra1JD66M=
X-Gm-Gg: ASbGncu+2LAjPom7uEEzQ8yKL9LarRJ7tnrDezCqB1uaOKwceHdDlVoNaHUXPM5uXyI
	L474T/1fMf/SzI6RKeP6K7pyja3QAM5xnLWxYERzDVXJj4hfhEJYrI3laR3XcJPYW73LkQ/fJWi
	UI7sqd4JlO5ZbMo5AFvq7bzjn1W96VNZGmuWexkbCCuuF5mmlfWBX2IOIGnn+BjHqTbhMPczH2C
	OOFvszPvQ+4XbAdbLbGpmTLKuXGPd4sPW8GRvpKMsNn+TyjXMU2JQa1nxJfBFUYEVxjMG/RHqhI
	ztb7SQV+7HzURz1/fo6MlC05LOT7loAW09SXXlGp7dhmUE0F7DBiE8e5xlv5rLOedx/EINkXXNw
	lOpt+ByAJnZ/Qperuj59N+KwWbyH0xPnUsg==
X-Google-Smtp-Source: AGHT+IHpvTQ5ItzB+xbO7QKI3e0YtF4SALJ3bujX1D3W4r4sLptNrzzYoNef7jRMvx8drSx4TpRhJQ==
X-Received: by 2002:ac8:5a04:0:b0:4a9:dc59:8961 with SMTP id d75a77b69052e-4ae5c505fe2mr29866131cf.9.1753184238832;
        Tue, 22 Jul 2025 04:37:18 -0700 (PDT)
Received: from Gentoo.localdomain ([191.96.227.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b25a18sm52457651cf.59.2025.07.22.04.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:37:17 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 10/11] Shebang line was missing,fixed
Date: Tue, 22 Jul 2025 16:47:06 +0530
Message-ID: <71942722ce7f681e0de4bc909369973005b2598d.1753182971.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1753182971.git.unixbhaskar@gmail.com>
References: <cover.1753182971.git.unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added the shebang line at the top of file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 tools/perf/tests/shell/common/patterns.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/common/patterns.sh b/tools/perf/tests/shell/common/patterns.sh
index 21dab25c7b7f..807c1bc7bb52 100644
--- a/tools/perf/tests/shell/common/patterns.sh
+++ b/tools/perf/tests/shell/common/patterns.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # SPDX-License-Identifier: GPL-2.0

 export RE_NUMBER="[0-9\.]+"
--
2.49.1


