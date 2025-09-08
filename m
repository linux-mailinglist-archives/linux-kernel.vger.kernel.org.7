Return-Path: <linux-kernel+bounces-805748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BECB0B48CF6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137D320072C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36C12FC026;
	Mon,  8 Sep 2025 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNqXUAAp"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602302E92D9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333443; cv=none; b=T3IS7fQuyHejT9wi1B5aM4mCPAcF4Yp8aT73+X7lddY+KabHVCeGfS1DtKSehYaZNKXdjrgiWiUArfoj1YCfQSZPeY0viQQUlwKu+W6ubpDJZRa5gy8ZGEfR5LC4m375NAXQAHso/FN0o0ONzRPv50G4eHvvLCdNuMDlF8wGLGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333443; c=relaxed/simple;
	bh=ioh+RrOLN+gJV2heq4myKOswgBP4J/2ilyblwg6F7dE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uCVkea2+A7iganBxU2FcOi9YPVp0MrOedgycovNtsWmXSevx+OFTjK9D0SovWAAQ5sSSbI/x9PnkmJjvgWb/klIxRMBG6pVf8nsr/Vz6LMid24o/XCGkIGL0++RL0SkG5BSGTJibqXyl6m3iMBRDBG1gY7QLfEampe+hq9aAV4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fNqXUAAp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3e4b5aee522so1255231f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757333439; x=1757938239; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rvTf8Il6f/mqfra/iGYvNWp4kf3icOzgbKsdoIlAr9k=;
        b=fNqXUAApn4ClwGKAeOao1enLjqBWJOKEJFRAAqJuqQAb9nPQg6+P2cPP3QweqC8cDI
         BOYRi09D1KXQ0NmTOZfyTAv4qeCIr3cxisGbeQuCZeZU5vOlR+TAK8PAnX+7/Lv1csDC
         YFJzWFTE9L/GnjmKE0YX/DDqhSVfou5/gq1xOL6bKTdSAmFz+hxmUGZhk1OvJLTdZ9Xz
         6rZWmupHEiHu+0/wlWunnb53Lv/IjwSOLaT0dqtInXnTuIL6+te9iW3AwCnyzQOlq51v
         ILVjUv6E8AXiR8hsgNHS/wgkqKeUyllenbLS8n/zGrCbVPjAsMpNcbFzoW9VTL3GqOaL
         zw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333439; x=1757938239;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvTf8Il6f/mqfra/iGYvNWp4kf3icOzgbKsdoIlAr9k=;
        b=Oho8KtDzij9d0kukHxgA5FFJDvGQdWAnCmGK/Gemn3UaRi1zqK+elnu/q4GS3CN+8N
         qcxYHB4OFFFqXj1xU6a2Ew89Br1AwyhWeWAoEjVhuz1qvsWJM/46Bjq42WL3TZlwumb+
         bWY40xx0Xd5sI9CuURlnQReER8VQyzjgOTvl0Jc0QCmXWOQ3IMAVx8dva/fTql/Mav/T
         HxL1c2MdE4/RPvpLtuKzGUxt5eSoLWC8glIuxl3gcodbDbHi42XuvXIQbrciioqk57Cn
         XVM50yGJWPdUH1vWocjuYfbnExbSUNawRfNJqp8i33MxUsMx25+PPP1ArdOyuCzKG4y+
         GbEg==
X-Forwarded-Encrypted: i=1; AJvYcCUsJdPbk1/hsv7UWiHLXYYnVHbXdURBUGTdl3QD7QsqXVBAb41WdttW0VwGZMuPldhP/2wbffR/RUfKoiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3OJb17VBQAIrE/s4UZtgL2xcp5g7qDmBiea23ClwOqXY/ihPK
	JSB7BNnV0B9CM0ND02aVxP+6KFC8AnpXz4IaFOqeyZEefZNFgbDPk3wqPEe3cnz4dh4=
X-Gm-Gg: ASbGncu6cGYPv+AAY5MAygpLj3bpjFJMqZnYvftaqD7fLIlmvMIBIE/JxOyihmstlWr
	yPiF2iODiK8LtQ1SM+Iam0JK3X8mzXEnsW6U9ThVUov3gkFkCXFOGuoHsWKTizteFVlSyyRfwZo
	fEmAc2qr9iWj+KT4Fnn2zV38RDdlWuyhKvl6oUdLhEIBv6WSlOq3QRVmXvk5O/pDD6whXRXV/qo
	Upgq/2cugZV83zgaSzspjFMf3Ovkr2GjUyRSOP4zA8rmwC+fqwr3z9YvBi4BTEsWgKXUvGxFrde
	5z9+NfqmijhkMEuLrK37QSvQIdR+BoMW4tkMwOW8QIMrHlS8D5rOWG5tTX93/atB+phkfCDd+5g
	xyCjzWMNEYscZqgdqOH87fjUW/8cwPfqH9oMMvkN5TQ==
X-Google-Smtp-Source: AGHT+IFEyhgsQFK+8cAvwVvaOJyzzhjwcI+1heh5zPX3kbpjk/o0y5jOw3y2xWOVWDMeF85EgycT/A==
X-Received: by 2002:a5d:64c3:0:b0:3d7:618b:293c with SMTP id ffacd0b85a97d-3e641c4d63fmr6143479f8f.16.1757333439535;
        Mon, 08 Sep 2025 05:10:39 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9fbsm41397825f8f.50.2025.09.08.05.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:10:39 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/4] perf arm-spe: Improve --itrace options
Date: Mon, 08 Sep 2025 13:10:17 +0100
Message-Id: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKnHvmgC/x2MSQqAMAwAvyI5G2il1uUr4qFqqhHU0oAI4t+t3
 mYOMzcIRSaBNrsh0snCx55E5xmMi9tnQp6SQ6GKUjWqxtVtJBgoepRAH/Axoam0dqW14+AMpDZ
 E8nz9365/nhfqGFC9ZwAAAA==
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, George Wort <George.Wort@arm.com>, 
 Graham Woodward <Graham.Woodward@arm.com>, Ben Gainey <Ben.Gainey@arm.com>, 
 Michael Williams <Michael.Williams@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Most people also want all the SPE samples (instructions group), not just
the flagged samples that are put into the various memory groups. These
should have been shown by default but weren't because the default
interval type wasn't supported.

Also when looking at this, it appears that the downsampling was behaving
in a way that would discard samples from one group but not another.
Improve that and the warning messages.

I don't want to put fixes tags on these because it's only changing the
defaults and the behavior, but I don't think the previous behavior was
incorrect necessarily, just copied from tracing techs but not ideal for
SPE.

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (4):
      perf arm-spe: Show instruction sample types by default
      perf arm-spe: Downsample all sample types equally
      perf arm-spe: Display --itrace period warnings for all sample types
      perf docs: Update SPE doc to include default instructions group

 tools/perf/Documentation/perf-arm-spe.txt | 14 +++++---
 tools/perf/util/arm-spe.c                 | 53 ++++++++++++++++---------------
 2 files changed, 37 insertions(+), 30 deletions(-)
---
base-commit: 75a7b9d29215c5aa813b9620f3c56817918f9f8c
change-id: 20250908-james-perf-spe-period-4711a566cba4

Best regards,
-- 
James Clark <james.clark@linaro.org>


