Return-Path: <linux-kernel+bounces-843562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2919BBFBC8
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9655F3C01DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032CB1DF254;
	Mon,  6 Oct 2025 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mlcXeyhK"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC91A01C6
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759791749; cv=none; b=JJ58WkEUIHdN8UfEzgPJmIEbwWKW/F6xkjLW1GxGRk2sXuduUXwTrjsQzSVVvlLFAj935nzliCio54rz1uxa3qgZgNCWK8B5Ijj78X5tpV9j+mdVgB9+D1PFmdaEJEFxbGgDKks+2CJEoOJ1VwqdLcEyWxBai7rrze10rnVIQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759791749; c=relaxed/simple;
	bh=1yVzmTVpaOFv/M+XS6u1tP5/jEOlFcdq7mYw0JifY9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FRu7mNDlVdEa1AQC5ksS6gCyM+SUyUTT3hqKxuPmS5UovZs0e1JO0ExHQu0QXl94pZl63qyQKa/76pCo5J9QzCF+PPHja+6h+qDkl+L+67yFftBefj4bHwphVXJ5MG3dkt4V+uwkanMqMxfGvChuRWj4pSlv2/4Fs3igwQdcL8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mlcXeyhK; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-93b9022d037so217555639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759791747; x=1760396547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rPUqxHqoYN9o/nXYPPPYebq9RP8korJ6LZObH1VKs1Y=;
        b=mlcXeyhK6ezWt7oXhZxm3Iv/pE3IaODwEYTgPu/KDNTC3TiTm9bT2oYbDx4B1wtx8B
         rBJAyKhUGMPvHgFySJQeZsF1+04GlougFA/HPKwAnO7Narb38950CDGve1ltzMSWKwv1
         mIM5QIga0tLnjNxFTSGzJkMWsFzCVkh/NS6EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759791747; x=1760396547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPUqxHqoYN9o/nXYPPPYebq9RP8korJ6LZObH1VKs1Y=;
        b=BjT5aApS+iFwGmZNXTM0iS7+dfkauwMQq+QZOkkVbSztbjoXwxWi78PHDbpV2u5AQG
         2qyMHZXp16El8VTGklAjLdx4yu9ztUj+3jXWKkBhmZdi6BoMJij70eULB9DUtSbFpUj4
         cXSj74Ip7lTV90l9AkS6TLx/qJQq6Sp0EUKcVW+pjyPMrq/mp2y4t6HvuUZ+Tqbtx/5Y
         4TtemVA3BD9E+o+Wg1ZZDvizLWYG5pKN+d/xI+YvQh3ZPLwq3Yb7CV6+dbB8k2/bKp5R
         HfJqVzH3bZIDNieY2zdj+pg+9ESyZmCJmB4qhpzB9oJQZMqDNDNd+QzbphypfEiEgMPs
         gDuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYq1tuaOkFkxtuZ2GGtackPuj+7kbke2hhvAt23jhWTpjRDpglkB+bQ83kcB3ug6shAeHGOm5DWDrG5nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdYEMpqbBF/MSUqpE9Trg/nnvdauZeUB/nR200AyTUYapKgXa
	dBLXGPVEyubUYoVCYmKrnFKK9uwic3CebyocBTVtL2QveKPG7Ei8B2KrrDpbiIjfhA==
X-Gm-Gg: ASbGncul57ew5kWsTxtypaUnjAz1zwOlM39cL0Pg8H8o0iA9YTcFvWpid2ar1EDn8Ur
	E9DEjKLwDEhwpX3YJe+Z50dIkzhaB01uIXhXFFQlt6tfR7yaLSXY9Ri/Vlr47s8PcQsgPMklhBc
	PeseO8cbWNmSm5j1vWxb7cOKRgzW2GHM8oq+TorU/4ygFRTntqoUWGAhLLF3JZujbkE5LeZ/3B2
	EgvvZ6Vs934nzs4gxlTOi4ZEqT5dDoZwurry0Juu6OX3xNvX6ROYPApQ3UgFaT8tXBhQ5iXIaI5
	xOK97id4+BCGXspJuKEwthDSQb14xfRdWIBQJcKnUVnmoGPkktzjXTqzPak8hGscMIpLJ1fdUpt
	uMjQAGT05eEqdv+/jSRsQY6L4mvCR46PNvOb/xyWCIXERUSFhLxUKsQ==
X-Google-Smtp-Source: AGHT+IE7/YGoPn47lQ3d5uWVlrWlTdbeR9OUwTMznvi5Kz+D26CuC+sguo/JsRy3VZbgrzZGikj0VQ==
X-Received: by 2002:a05:6602:1405:b0:887:574d:dfbb with SMTP id ca18e2360f4ac-93b96a5a9c7mr1831470639f.11.1759791746857;
        Mon, 06 Oct 2025 16:02:26 -0700 (PDT)
Received: from chromium.org ([50.235.115.130])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ec55bc7sm5422226173.69.2025.10.06.16.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 16:02:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	=?UTF-8?q?J=20=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Sterba <dsterba@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Terrell <terrelln@fb.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Rong Xu <xur@google.com>,
	Will Deacon <will@kernel.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] scripts/make_fit: Support ramdisks and faster operations
Date: Mon,  6 Oct 2025 17:01:51 -0600
Message-ID: <20251006230205.521341-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series updates 'make image.fit' to support adding a ramdisk to the
FIT, either one provided as a parameter or one created from all the
kernel modules.

It also includes a few performance improvement, so that building a FIT
from ~450MB of kernel/module/devicetree files only takes a few seconds
on a modern machine.

Changes in v4:
- Provide the list of modules from the Makefile
- Reduce verbosity (don't print every module filename)
- Rename the Makefile variable from 'EXTRA' to 'MAKE_FIT_FLAGS'
- Use an empty FIT_MODULES to disable the feature, instead of '0'
- Make use of the 'modules' dependency to ensure modules are built
- Pass the list of modules to the script

Changes in v3:
- Move the ramdisk chunk into the correct patch
- Add a comment at the top of the file about the -r option
- Count the ramdisk in the total files
- Update the commit message
- Update the commit message
- Add a way to add built modules into the FIT

Changes in v2:
- Don't compress the ramdisk as it is already compressed

Simon Glass (7):
  scripts/make_fit: Speed up operation
  scripts/make_fit: Support an initial ramdisk
  scripts/make_fit: Move dtb processing into a function
  scripts/make_fit: Provide a way to add built modules
  kbuild: Allow adding modules into the FIT ramdisk
  scripts/make_fit: Support a few more parallel compressors
  scripts/make_fit: Compress dtbs in parallel

 arch/arm64/boot/Makefile |   4 +
 scripts/Makefile.lib     |  10 +-
 scripts/make_fit.py      | 264 +++++++++++++++++++++++++++++++++------
 3 files changed, 239 insertions(+), 39 deletions(-)

-- 
2.43.0

base-commit: 4a71531471926e3c391665ee9c42f4e0295a4585
branch: fita4

