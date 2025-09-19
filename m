Return-Path: <linux-kernel+bounces-824386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25279B8907B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91E47C6E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423C63093CF;
	Fri, 19 Sep 2025 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YO3VnQy/"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE7A30C112
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758277717; cv=none; b=fMbp/zkqD2h4tTI/pCBvoLDsdbvf/zExi4x4+88ldu9BS4M/sBgpytKNiSwDeWyTcujJNAuVQVAmGZYA/Mz0JLfeu5PXUeM32VQGiY7UzumTPViQhlOW3dhOWVwSu5R1e/qarJvpna626wknVyM1wrR/tk0VcZ+Q4Vmv6T/lXYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758277717; c=relaxed/simple;
	bh=jPptXR8NGJB64pS2KaBD1Hd4nTNBbsT4o5H8w9yHHrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VS6953Tbl1a+oHU2G3w6c8jfTkD6Q6hGYae3EayvmfBkiXx1I3Dei9pUQn+fjjUkccZSt7JNI47aDzhAXF9gOfPHAOl8ndE+lJn8zaQ0J7DDc6KFBjxWQIkjcln13WA2Kap3NylS0fRWa9Z8nnvLmc2sXTKg1KHu04UGGtyrTYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YO3VnQy/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f7b6e4145so2339433e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758277712; x=1758882512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qQQVvpAmXSFXhkPIfMzRXcNKNt7LSya8fPUUSNlSXhk=;
        b=YO3VnQy/UCZXDNmtBP/IpOgHKs6heyNppYtUAEegtIaeyQkpehG5iiCLNnU9hh8K1d
         UNBOKjJRCuSpcKar1auLQatgeH8Xe3tDzXfUSYa9Hd9HZPLoVGP6iqrvQfo5M4pSWeXt
         o+Ci5kWZFZ0IAzVBSUecgRLUqoiGQ8JvxL+ss1nKpW8WI7JLFSJDErrJ4N5RG9M3EGoQ
         DIx51u/TMkWkhxT9KLhvAjCDEwP9QrjPIZ+A5fNnYvs0i2Zo56+BbwO0d+M51KLdt6n/
         bFjatjMADg33SKaYA+iN5IGghd/6Hbc38OaDLX/8e/S0qlWwqgt9T8eX/eT6gfSMXFUw
         rPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758277712; x=1758882512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQQVvpAmXSFXhkPIfMzRXcNKNt7LSya8fPUUSNlSXhk=;
        b=hgS4m5SVq0kTJ5c4ON8TwWanL0EwwM27HTzXzFfOaMiRuLU2Cs7N7LKRaDOJnu+uuo
         v01m0Mk/+M9Axf6SO96GyHjfVwLXrVCglowZnyqTtsynRstIlurp4ZYlMa8ytuS07T7F
         X3jV0swGn3e6uzNwX/Jv0P8xrJl4HB61YkBhwBDZPvdU05MHF/fzxjqX0aq+4VYkiA0v
         jfSqMjXLHUJ2ESnkx4cdfLNALpnKMyqvy/4Crzvy2o5WMFW+8l8UN0DBhDI0FftQ3awS
         XAAveePzhr2kTrxTybHhjJGeSc1WcxtDsxMOy3hBXguR+IjTrSNMZI5gIqJtdC+ImDjL
         5FJg==
X-Forwarded-Encrypted: i=1; AJvYcCXFOA9WjNSOT6kttq2hTTpD0oGjjF9hZ0MhZmaL29v2AZT4ACw+jBKLkAUibTinuI/ieCPkehLL2aJw8Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFjF4It9eoIBRDEmZDQ90dCvwSD/BUs94uI1L0uXUQjGgCB5wG
	b+sVDBIQ4pGw6w7N5uBxWKrKPHJdZenc6o2CaPM4fNkYlSSrpv13zSOpiHChkXTXjgI=
X-Gm-Gg: ASbGncuCpnaW6IgSr4S2gLQ6orX47cXgqDJvhLVCQeuM6GqKvQAXegowxYPaBNjDnqa
	bhA1nyxKAwFDXD9OIC0P4MEx3U7NFvfCeGrjWEaX6XdDLOsSCY8uJoOJmFDB/1zr4tO0ZAVhARA
	XDTZmTXpmlppRr3/gRM0MR/2OxjPL8KktbQ012f2bqNrsK6rl2NXGgmfrPkn9MXjckQO0B2ncWV
	LY0P9skK9wE+V7qQqSwyGx0OMrB8QMBjoCeXtyN0a3nAFees2fBFNLc0uourkZRNIuyrdCIJydH
	Vv7zHvi9KOZOwcnpNAZnAcLNZRxjj9XNpi5um+XtbhIMHHYeOSnMoiDn/QB30wAU56RQdBR5TgX
	EvllgrnkWFwvY5JT2F5zFBruYP0zGT4Y8JEP3Dp7CYIOoJIMWMekxCQmPGzl4/L2TzoUMxO98
X-Google-Smtp-Source: AGHT+IETmUnQlGUARBZSFBOrd6464VLoS8WXVDGEarMvcetfBwFqWJjqKJS/dx8EIEPRIYxLAxnydg==
X-Received: by 2002:a05:6512:79a:b0:55f:595f:9a3f with SMTP id 2adb3069b0e04-579e1c5f94amr819145e87.15.1758277712193;
        Fri, 19 Sep 2025 03:28:32 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a9950683sm1280054e87.114.2025.09.19.03.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 03:28:31 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.17-rc7
Date: Fri, 19 Sep 2025 12:28:29 +0200
Message-ID: <20250919102829.151957-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a couple of pmdomain fixes intended for v6.17-rc7.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.17-rc2

for you to fetch changes up to 303010f4658cb134eb27cee88026fb5d065a48cd:

  pmdomain: renesas: rmobile-sysc: Don't keep unused PM domains powered-on (2025-09-11 12:36:55 +0200)

----------------------------------------------------------------
pmdomain core:
 - Restore behaviour for disabling unused PM domains and introduce the
GENPD_FLAG_NO_STAY_ON configuration bit

pmdomain providers:
 - renesas: Don't keep unused PM domains powered-on
 - rockchip: Fix regulator dependency with GENPD_FLAG_NO_STAY_ON

----------------------------------------------------------------
Geert Uytterhoeven (1):
      pmdomain: renesas: rcar-sysc: Make rcar_sysc_onecell_np __initdata

Ulf Hansson (5):
      pmdomain: core: Restore behaviour for disabling unused PM domains
      pmdomain: rockchip: Fix regulator dependency with GENPD_FLAG_NO_STAY_ON
      pmdomain: renesas: rcar-sysc: Don't keep unused PM domains powered-on
      pmdomain: renesas: rcar-gen4-sysc: Don't keep unused PM domains powered-on
      pmdomain: renesas: rmobile-sysc: Don't keep unused PM domains powered-on

 drivers/pmdomain/core.c                   | 20 ++++++++++++++------
 drivers/pmdomain/renesas/rcar-gen4-sysc.c |  1 +
 drivers/pmdomain/renesas/rcar-sysc.c      |  3 ++-
 drivers/pmdomain/renesas/rmobile-sysc.c   |  3 ++-
 drivers/pmdomain/rockchip/pm-domains.c    |  2 +-
 include/linux/pm_domain.h                 |  7 +++++++
 6 files changed, 27 insertions(+), 9 deletions(-)

