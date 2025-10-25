Return-Path: <linux-kernel+bounces-870141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B99F1C0A04D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 23:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78EA3B8725
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 21:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8061A9FAC;
	Sat, 25 Oct 2025 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6Fkef1E"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F432AC17
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426929; cv=none; b=vE/Q/Pam0C1xi2E8tjNOZPcuJhIy4iWTUsuUqP5DFOqIWZTOVCDDsYccJacvN1pWT9Zpwz3J6xiiY8P5Y+aXmQa9pVyZCUy+J8HyPJGVEfO5hQo6P6fH0gmAoW/yl990WZFJKZy8gTo21p1jTVeS0cbCggWvw0L2UfGevGBPV5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426929; c=relaxed/simple;
	bh=WyWUawK+/N7dsJRPDKxuShqOiXTcdy6QCMPboNalpLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MNDebCFA7ydLsMxhRNcSaVDE3dJ6RexUN/yNv78ajYSrKvtYLjWCbyT3t/GQSWL/2J3ayG5+MzEu3v/WzR1C51mgV9FyesKxv4BDpWqyVtTNvAyBeI7Bce0tq2sU1tVE0tVGaEgKk7BS5PUAn9GNMwGv+vrC4aH1OP9Zj41pr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6Fkef1E; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-430b6a0eaeaso30451175ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426926; x=1762031726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hGg7RgLm7u7Aps0+61d/iPTOlPXVnICEyxv1QEpHm98=;
        b=l6Fkef1EbgQ4hzeJ5GEsB+yrhAL2nhhknjaujuipONCTAO0BIsoj91X6ONOShfSvwz
         xRyN1OEcVl02FvQXULELaLEOlC0DWWnk0zBQRxs0ToxJB4gC4cc0aZVdUCdmcz6cxNiC
         iEhznzdUZg952oomc7z1E3g/O6f1QLUItVSJTIgPGH4Tf+XbI4L343f29T18Di+WDBhI
         K1pWsre0iam/2wzmqm8AIgnF/PQ5K3HsM2nB2GQwisZHVsEICxsTgqbma3OtmJb2UOFS
         3pWoWjc0WCoHshSiIOEG9dJgHVy4QyVoiPSUyKxJv5+NwFcgFBQ6MZaEDRsLghoN8D4l
         EFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426926; x=1762031726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGg7RgLm7u7Aps0+61d/iPTOlPXVnICEyxv1QEpHm98=;
        b=hBeHjmUrK3r0IrMFiAiYrqmnsK/ZsDJfZ4eYiLdWmbRYhtU0WghWagttlwY/MvCoJg
         toHvdRGcd7HcOftg93UIjb7cp0EkRWju7s+yDjBP3TLFgXfLWAdgaD58Esjlul2w7mJV
         51av296/RLA2s7OBM/XRvrN6V6nMQ0B8GZofBljzGo5ggUvdZ/tMB3vGJ88vV2MPDTCr
         nNhSPB7Npoi5xKOsdQP1WGQk2x/S7Crd3Y/OPL2pfMANaiUUDvpo6nfVnXMRbZ6A8R6e
         vcH27GIUGGWz95jsLkL7Y1QN8XRR8yVdjQtZqZqqGc9N5emEDe/eF0J9/ytv8rU7Vgd6
         uacA==
X-Gm-Message-State: AOJu0Yz7s/R4fD870oq1WPKvSPjMZKh8IGPTImCIQJGVjPwE+pq76MBE
	nME0nQ0CK4JvPXogbZE3FhArhZCTjRB2EJ3Rl/rioPOcQMGCXc8eSTCxLG9Zjg==
X-Gm-Gg: ASbGncvnfmquZAcGmNNTdKA4rvx4S6IwFjNUDRvVDNlshLep8pMCMDG8ln4J7icdbA/
	RbZpua9jFYrEuUvxPAxRoq0bR2Fjk35qPduBh70gJLwTqDFeb+JusMp3uIYpN5LkDal1KNJBcJF
	HgvNVuU1kvu/DceXkyuTrnHn0ghgOt0JUjiCEm4/8eMZFeR53Fu63aUjKMFXk9WN4vqJ2yjoHuF
	5vflNzaxaVbvuqvFISpGTmHNelXrFTsq22Qj1iArS0J1n8vH40kak+q328dZvehUs6LIQDhYBQU
	vpFGP/MKsBe0g0z5JWUGUqfvRBQ6AUJaU/C/SLjlV+68ELAhLoyVlWNRHry5FVOB/v1AQMcm7tc
	9jKzLUaNHDe2UWBhcuXVAT1MbuohW5T/DUzNKtckLPRhID8+SwNTr7IVrm2Uqv3fmoNeJRp7/LJ
	UWWYXuKELkX0rPfMQMZayUHmTpxQnZFJrGqqyu86sk0calXIrTYLwsU+DwTpiV46IBJ1M=
X-Google-Smtp-Source: AGHT+IGKJCONmRK/nZ8xhEqRC7k3CPdqJWFaSxz7MOARGNF3lZ2qUjFhhoVz04rGNDvI02sft76pYw==
X-Received: by 2002:a05:6e02:1947:b0:430:9f96:23bb with SMTP id e9e14a558f8ab-430c522319amr407365685ab.8.1761426926413;
        Sat, 25 Oct 2025 14:15:26 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-5aea7ce584bsm1212138173.27.2025.10.25.14.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:15:25 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/3] checkpatch --strict | ci-pipeline improvements
Date: Sat, 25 Oct 2025 15:15:15 -0600
Message-ID: <20251025211519.1616439-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several CI-pipelines call to checkpatch.pl --strict, so CHECK reports
there can disrupt pipeline flow.  This patchset addresses one such check.

  CHECK: Macro argument reuse '_var' - possible side-effects?

Multi-statement declarative macros (both top-of-scope and file-scope),
commonly fall victim to this warning, checkpatch even has a list of
named exceptions to silence some of the checks.

This patchset provides a more focussed approach:

1 #define __chkp_no_side_effects(...)   /* nothing */
  so no functional change due to its use.

2 teach checkpatch how to silence THAT WARNING on that _var
  find the macro call in macro-body, extract no-side-effect-vars
  process the macro body as usual, count arg expansions
  before issuing CHECK, check the no-side-effect-vars

3 authors add the assertion to their noisy macros
  active assertion of safety, per variable, not full pardon by name
  indicates they tested against --strict

Jim Cromie (3):
  checkpatch: add --drx option and drx_print() helper
  checkpatch: recognize __chkp_no_side_effects(_var) hint macro
  compiler.h: add __chkp_no_side_effects() empty hint/assertion macro

 include/linux/compiler.h | 12 ++++++++++
 scripts/checkpatch.pl    | 47 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 4 deletions(-)

-- 
2.51.0


