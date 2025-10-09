Return-Path: <linux-kernel+bounces-846548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1F2BC8507
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A435A3AA00E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A702D640A;
	Thu,  9 Oct 2025 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIDG4Fop"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701581D5ABA
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760002292; cv=none; b=GeKMSalOjY2RrjigL1tdShClYlRKcauNDXK97NXHjKx0un4Ij42EfSpsWYns6z7dxUOJFRBVG1Cytkn+MKwAmNdkJowoDINaTV1vvFpnC1GH8BZcSj/k8P01K0aY/nquQS/nHymNmbY8rcIMIlLiLj85W5R3nUBhgSjUyU5fQAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760002292; c=relaxed/simple;
	bh=NQ+MP9UQFifKSu2VgBLJEdIPCQK7TBnKXvvEwCt38zA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lyaEchUQfVd/UG7YwKqyK0+9wq5iLRZnntAVD1o+9EXyhgH1h1VQUHbYTn4NPC+hxNtFh+OirAIDI4xLmGCcdefJ5CBBobZUaBxnqYY1SnCTcZZC5uq/a82NJLEQYxk1278SV5+FH2mXNfTC6UzaXwIYRiZQYjdX4bgtOuBnWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oIDG4Fop; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3b27b50090so130954466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760002289; x=1760607089; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D8Y2hQ4PF+BjFgeq/9cHEzG8SplUoZPxKltHoG6YiyA=;
        b=oIDG4FopgDy4ZLRQWEQbN3zxezy+v0+ZOG/dnP+3Kn+CQjmx22HaT+jUfCotIW7QWp
         Ezkt7bkg3Uyn5ZYLgqWLI/LSPPb85jHVkQM8vq57bdJytF09o1ScaF5zJ5qoQ4gVRSfj
         SWIrOG2QD04UKo9SuV/1pdMmnHiaSTf0nwAg/eDPLXqms6TOKKv2RcVPDMvcdfy4Zd6E
         Bl6nuXHR6ZTam+CJnWd6y2axftlmYfXKmQCYfteIob8C6+Qcwq+YW9BOaElLgj6CXROE
         SfQWU0QI8zbrNUKqDGAzIsD+6fDqYrJnCuU5MmMasMVu7HrENNpCMFgmYsji2xBp7qpL
         V2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760002289; x=1760607089;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8Y2hQ4PF+BjFgeq/9cHEzG8SplUoZPxKltHoG6YiyA=;
        b=QSqwR4YpIMa9YSWWkX6mQa4Hw3+8uBzV9QvdOEJMFVwW2zD8SjFahnjgLu0Z/PggaL
         O17GCRH5uw0r0tBMRa5B6EwpcLInS5/TmgSGzHlpfc6KZOVzmJS3jNFE0+/CVDUe23yD
         s0o/vE86AhQa3hTKGyVQkuGZbI4Iuy1JSHoS8jbKafnbzsYfBRJsaazU4su2zKBFN+0U
         /9rLGXJajRm/q7oZEyho1AD4YmgR1+1lk9e2v23G2Q586Ou5OI+28R6AJp5e4WzDiP0T
         2TUobiBRra6x2UB03vQRAcfPhP7FmUigCYUDrT/Ub0mWAa8Z8Py00e3q2WUtcIS3WC2C
         lILQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuheJ/pJb947wQAYKHfWF8pgLXZTNECWrOzJQREPMvqdrWT+80lrPOFdVALKscDEIgNUDhrVDnK53je5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpkZDi6lIziXfSZLWzaToJ6BkH+kOPzmxigy7AU6y9Hesa7lw8
	0janXrVYBm3pj5gpgbGDJFpvyYkO222FTrjXcSidoak+jjomMsgSFklaOSZ0eo4IgKk=
X-Gm-Gg: ASbGncs8bOAIRYaSXvtqpf5uNV6bUo5QRASAjnlMkeJApeEuPWQMH5npipxlhhKT/5m
	QZ8Xsv8SMWAfWXmqRay3931Uqfb6LJ4q4gnG96tU6TDEuWo6Mw/1lMVImhyybIeyzwDhH1JlWc1
	x7fpjyv5kwmcmnGooch6dtpq1qegownw3Xb6cy9kaFKQAaUbNPVzLjk2ySyt/zBbVO9gRjoEj9f
	pRe1jqLh9Rtq6Ud6EHF4Mx7LkbbjpxcQU8PthcCiNLa2wEArPjFlwz1yWwUjxRxyjRVfP+vbrq5
	P1AM2/x20MbjdiahwbJ99PGXAnnLosO1XR4L7YI1wDdw0umCOc/npk2vfwj7QsnBEHCX1L63cRK
	xNqyrWwK5WNhYGwWVTo5YV19XwXUB32m1h77lU5vaUfx5Rsy6+r1Fe3wDwMNjhlf6IC9CLOEBqg
	rT2rreTNKZCQqLXZYn0jmSl4X/w/J4tnF3Os0ROke7XdcTQWW1rjw=
X-Google-Smtp-Source: AGHT+IGbdEUE3PNoZYCS6NfJhqFXaPk0SnM9PnNIqtON966v5IoYDwxlU8rH3tGA/l00b+ZA3818Uw==
X-Received: by 2002:a17:906:6a14:b0:afe:764d:6b22 with SMTP id a640c23a62f3a-b50aa48c4cfmr690831366b.9.1760002288707;
        Thu, 09 Oct 2025 02:31:28 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a173a41sm1855670766b.87.2025.10.09.02.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 02:31:28 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 0/3] soc: samsung: exynos-pmu: gs101: avoid SError for
 inaccessible registers
Date: Thu, 09 Oct 2025 10:31:24 +0100
Message-Id: <20251009-gs101-pmu-regmap-tables-v2-0-2d64f5261952@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOyA52gC/3WNwQqDMBBEf0X23C1JRKs99T+Kh2g3cUGNbKy0i
 P/eVOixl4E3MG82iCRMEa7ZBkIrRw5TAnPKoOvt5An5kRiMMoVWSqOPOuU8PlHIj3bGxbYDRaw
 uprRd7aoiJ0jrWcjx6zDfm8Q9xyXI+zha9bf9Oc1f56pRoXZ16VRtFLX5beDJSjgH8dDs+/4B4
 FuICL8AAAA=
X-Change-ID: 20251001-gs101-pmu-regmap-tables-8726ac9f853e
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>
X-Mailer: b4 0.14.2

Accessing non-existent PMU registers causes an SError, halting the
system and rendering it unuseable.

For gs101, we can avoid that by creating the underlying PMU regmap with
the read- and writable register ranges in place, because on gs101 this
driver controls creation of the regmap.

This series updates the Exynos PMU driver and gs101 in particular to do
just that. For gs101 this is easy, as the exynos-pmu driver creates a
regmap and we can update the regmap config to pass in the registers.
For other SoCs it's not as straight forward, as syscon_node_to_regmap()
is used which doesn't allow passing a custom regmap config - those SoCs
are out of scope for this series.

With this in place, invalid registers (by drivers, or even plain
debugfs), are now simply skipped by regmap, leaving the system useable
in that case.

Cheers,
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- Sam:
  - add regmap_access_table forward declaration
  - add kerneldoc for struct exynos_pmu_data
  - update gs101-pmu.c header to C-style (Sam)
  - ctx -> context
- update commit messages as appropriate
- collect tags
- Link to v1: https://lore.kernel.org/r/20251002-gs101-pmu-regmap-tables-v1-0-1f96f0920eb3@linaro.org

---
André Draszik (3):
      soc: samsung: exynos-pmu: allow specifying read & write access tables for secure regmap
      soc: samsung: exynos-pmu: move some gs101 related code into new file
      soc: samsung: gs101-pmu: implement access tables for read and write

 MAINTAINERS                                 |   1 +
 drivers/soc/samsung/Makefile                |   3 +-
 drivers/soc/samsung/exynos-pmu.c            | 136 +--------
 drivers/soc/samsung/exynos-pmu.h            |  37 +++
 drivers/soc/samsung/gs101-pmu.c             | 446 ++++++++++++++++++++++++++++
 include/linux/soc/samsung/exynos-regs-pmu.h | 343 ++++++++++++++++++++-
 6 files changed, 824 insertions(+), 142 deletions(-)
---
base-commit: 78578f59c6d2d7ece395fa438c7c82a25c9ed9e7
change-id: 20251001-gs101-pmu-regmap-tables-8726ac9f853e

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


