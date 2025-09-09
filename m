Return-Path: <linux-kernel+bounces-807455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC14B4A482
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9C21B209F0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082B1245022;
	Tue,  9 Sep 2025 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJLeQMvg"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E4027453
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405208; cv=none; b=lKQSs+vtr5cEpUw4su6yZB9iu6wubltPu+MyKAOjLDI8w9W2bkFRBKF7l0B1nm2abR6bn0yrGo3gLT7LPRavEptC9FGTPUBNbP5///0dgRcsK9wvAOiTvluuH2uVoSUzgVQH0Gcnpw8ioqOuyRaMdCs8C4U8LuzKTFshoZE9WFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405208; c=relaxed/simple;
	bh=d+U0eD2Lcxv9wkXcTK+OW3RwnExlgkzA8OS4vnSNHMw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aY3sTTLnoTjE1XrTCJifzteGZGvYp2F8E+NeEXiiZ+xiaHIvSeSiLKExxOvwyyJ4ZMnLXOetVsGKKl7N44Q/QKMYO3tMbjtEeVA2DvNCAwaSL0xkTdVonjlWfYdfhJMj+puHH6bDVt1k/0NI7ZBuWSsB0nBxW7xwjUai6nK5TzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJLeQMvg; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45decfa5b26so3347185e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757405205; x=1758010005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lj7lB1schWgm61Svtbzr4eTVgknBz4beDUKMEIQ/p4Y=;
        b=uJLeQMvgMBF9H/i5F7UxmCDu/JzmHxg5jmO2Sr+MQDhAo7n6aCdeOa5gujhMB1Ait1
         ju+Wmhl2jUuQyeXWeNNhbWB1dtOv+RcpYNUCLGt+/k+tCePYhlOsFLTx4Rd7m2ypKxOY
         ATTXV2Q20QnVb39HBQGCDUTrp3xMuYiL/56Vd5Z3i+zmbTogH4u2GRob9wQEhK/ta4Ag
         R1WModOn8S6U0jsUEFPu/DTaMqfun2nKfPwfn/yNCltIrr+oZ35EacTMdapFYk274b28
         nVxzBBMhWVY59br/OL09rAZQ19cX8uxGLzihwPdyBeekkM1B8B+lySE8uiKRcJsh6A/E
         RMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405205; x=1758010005;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lj7lB1schWgm61Svtbzr4eTVgknBz4beDUKMEIQ/p4Y=;
        b=mTew5ZvGlcr5c8ina69cG2ibuXpeyrOvLmupeTi9Vvs3OgRUKKN5RRF29k44BIzlm4
         VphApfODkagFm9hQNkh1hdSFZWe7rE1Bs8WCWQmdldmZXyxIsAYGRPHRaDRcgGLOtxKk
         PBCY0Law6Nv/t//MHhNakK+qBV2jIbFSF9Lrw6hBPp8OytmSkTtkbLTTXIuEy5+TYJLS
         WLcG15R5Vtl51+dOCbo1ytfO8qu9Endn3cZAhyRZ67PhfAZyuh+xn8/KtuTQYOiUrdrm
         2oA8Jn8s9ds2aAa1ZbYFdiaDnhB2F1DN26IHKazATJeoeg+DoblSKGvBRr2fJADgaabb
         ROyA==
X-Gm-Message-State: AOJu0YyV8qTOhnq1zohI5WeHo4XbPZ76sAvPq5ajj9plIgZnHlk6gely
	H5WUlKQYmdpMbwB1oTdDb5KOwMxDhJBO5kTWQ5jPA2a4QH1ihYTver7w4In/QAbHTbcsI1gBbg=
	=
X-Google-Smtp-Source: AGHT+IF4OTna4NACnPq+n/I1xm9kNRy09/XmtQj6sX9SDuKm85EEljFNhS1+t7H5b973gSnfiDWY/uS1
X-Received: from wmte16.prod.google.com ([2002:a05:600c:8b30:b0:45d:d60a:8d7e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2285:b0:3e7:4334:2afe
 with SMTP id ffacd0b85a97d-3e743342e6cmr8173379f8f.5.1757405205136; Tue, 09
 Sep 2025 01:06:45 -0700 (PDT)
Date: Tue,  9 Sep 2025 10:06:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693; i=ardb@kernel.org;
 h=from:subject; bh=qeieuoLZLIUqSRVQV57BfK2vQHUwDzAPKV2E97/EPQs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWP/A46d3fnXnq+a7zCHocb53X590/4ip0dxFuXt1mGh+
 hueykR0lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlwrWVk2NA4Y/+CM8rfi2aw
 RrCVH3HVOr88TNfze6ikRrXI+bZDGQz/I9evYF4ak3uE5ckE9u772xucy8tmuMn8ljy8uqBu610 3JgA=
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909080631.2867579-5-ardb+git@google.com>
Subject: [PATCH v4 0/3] efi: Don't initalize SEV-SNP from the EFI stub
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI stub no longer invokes the legacy decompressor, and so there is
no longer any reason to perform all SEV-SNP initialization twice: it is
sufficient to rely on the SEV-SNP work done by the core kernel.

Changes since v3: [2]
- Drop patches that have been merged in the meantime
- Rebase onto tip/x86/sev

Note that the issue pointed out by Tom in reply to the v3 cover letter
has been fixed in the meantime as well [3]

Changes since v2: [1]
- rebase onto tip/x86/boot
- add patch to remove unused static inline fallback implementation of
  sev_enable()

Changes since v1: [0]
- address shortcomings pointed out by Tom, related to missing checks and
  to discovery of the CC blob table from the EFI stub

[0] https://lore.kernel.org/all/20250414130417.1486395-2-ardb+git@google.com/T/#u
[1] https://lore.kernel.org/all/20250416165743.4080995-6-ardb+git@google.com/T/#u
[2] https://lore.kernel.org/all/20250422100728.208479-7-ardb+git@google.com/T/#u
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8ed12ab1319b2d8e4a529504777aacacf71371e4

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>

Ard Biesheuvel (3):
  x86/boot: Drop unused sev_enable() fallback
  x86/efistub: Obtain SEV CC blob address from the stub
  x86/efistub: Don't bother enabling SEV in the EFI stub

 arch/x86/boot/compressed/misc.h         | 11 --------
 arch/x86/include/asm/sev.h              |  2 --
 drivers/firmware/efi/libstub/x86-stub.c | 27 ++++++++++++--------
 3 files changed, 16 insertions(+), 24 deletions(-)


base-commit: 0ca77f8d33e8136b8926775380506f78a8d04811
-- 
2.51.0.384.g4c02a37b29-goog


