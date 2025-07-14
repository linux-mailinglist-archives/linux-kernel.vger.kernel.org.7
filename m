Return-Path: <linux-kernel+bounces-730647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87966B0478F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30AF1AA01E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCB7276052;
	Mon, 14 Jul 2025 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Ueewz1F"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE2B2222B7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519211; cv=none; b=lRcudnvNgBWL9a871O1NMjRPYCL8yia/OTosUhBTjoEScNmCbDmDMYkVjMImaPSHqevp8/mtF8MRCleoqZY0mv3fwpBThXj+z8CHkGamr1C/A31IGGE4lid7ue3sDEQGrM87qPdNegjCiLg5fHLEMzlkPxoB+w/TVFNfqsGMjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519211; c=relaxed/simple;
	bh=risPXDj3ZE97v8mJJ667EAITpJdxezJ7+lZmuf9qg8I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=llfIulMCoTG7hR8qTUSQZpUr+TTmIjkaUyCs8XcWkAhvKlYhUC8w1AfV1MJgWeoDhSAVMSrxrW9+eJAZ7WbwHbf5znt2iWQgM/FReOciKvRNPyjd7anoHK1duG2JCqIL/hGs6EM7LUR+b4TFR1aVaiNFnkF3DvniCDhYW4zv1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Ueewz1F; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31bd4c3359so2632007a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752519209; x=1753124009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q+xgwesTSILPgyLCGoIs7ePcEq+ry82PgVAHVTCzBcY=;
        b=4Ueewz1F/CJ3qbuWZM8Ui8AHSdSBjE5ovda541sstDrFWifpib8/qOuwKhb4oYlKSL
         7ZIyFVTKHFZWuWFGx40dTvQkzQuTw4OXmzl6JUUygkM+aZeuQctwmv2J2MpvPYoQ5RSi
         eyQxnfJCUb59o6W6BhaOL5GJLjYFDw+Zu6n3AgJbQf+PbNq1zY24pcoDJafsaP2dROuR
         YwiOPNiWP1/pbbOD85cvlFl4ADySj7oDg+DrbKHyJQ+6G4wER5sRZKT89qUTIVJsdBcO
         MQ+vrweman6Zm2JAj49O02FRRHw5JfI7LO62xsY7yZyu4q+1djVgIY8HZHiqv6DoMvos
         aeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752519209; x=1753124009;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+xgwesTSILPgyLCGoIs7ePcEq+ry82PgVAHVTCzBcY=;
        b=dwAboS9uqvrAnChf2zhqo9FQAcUXC1GOxIQpRwuPG/fcsmN+2wplKio9y79vhGumkv
         dN+EBE2zjUwzmySdataFSeOfC8a4Cv98L852qBagooENorqAKeQhpDHZWyzesaiiwGQ2
         w7qIKAibOw4XWKPSvvbB4laW5BWW8ClJntVQDK+w6VyDSlFxO517gsfznzc12TEVMrHU
         fudDUIv0EGPQ2n+aJExk/jvGNROP0XQJBKi13S3eotp4KMpXvcGWwgeYidd3MfezLhn4
         IvaF3PZcPFxvckFbZTTs1W76gl2mJ4X3cjQ6OVRMl1yhLOJBCcKb7gOlrnLZBL6oPdMW
         tZPw==
X-Gm-Message-State: AOJu0YzksEO40XWlgdxtC8lDfDeXW+n9ZMHoz9rgjvX6UhYUq9k9dcd9
	4MBtJnEqGhyxq/R1f9f0aftaNKVlJitwHfZ5WyHc3VwcTaY8oAtztE7HKxpKBxOAvVJShAmJP8P
	EkGsHIoLjktDskisTLG/CpYNNUC0kfSkrZBsmBWmX9pL3Ak5nBFN/YT2d7N7D14tyhf8QSRwZNr
	vCQ6j0o8xGEmGM5yBAD42+aLPIiOJCagpYODul1BuLztk+fRsf5w==
X-Google-Smtp-Source: AGHT+IGSxDfyVQ+AlcvCfHNaTx/qi0MWma6wabzsdqo+Mm0Scra8QIkBiktjFo9tWCkzTTnfXRPym5tTQn1j
X-Received: from pjj14.prod.google.com ([2002:a17:90b:554e:b0:31c:2fe4:33bd])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39cc:b0:311:ffe8:20e9
 with SMTP id 98e67ed59e1d1-31c4f5127ebmr23378221a91.17.1752519208906; Mon, 14
 Jul 2025 11:53:28 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:53:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714185321.2417234-1-ynaffit@google.com>
Subject: [PATCH v3 0/6] binder: Set up KUnit tests for alloc
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

binder_alloc_selftest provides a robust set of checks for the binder
allocator, but it rarely runs because it must hook into a running binder
process and block all other binder threads until it completes. The test
itself is a good candidate for conversion to KUnit, and it can be
further isolated from user processes by using a test-specific lru
freelist instead of the global one. This series converts the selftest
to KUnit to make it less burdensome to run and to set up a foundation
for unit testing future binder_alloc changes.

Thanks,
Tiffany

Tiffany Yang (6):
  binder: Fix selftest page indexing
  binder: Store lru freelist in binder_alloc
  kunit: test: Export kunit_attach_mm()
  binder: Scaffolding for binder_alloc KUnit tests
  binder: Convert binder_alloc selftests to KUnit
  binder: encapsulate individual alloc test cases

 drivers/android/Kconfig                    |  15 +-
 drivers/android/Makefile                   |   2 +-
 drivers/android/binder.c                   |  10 +-
 drivers/android/binder_alloc.c             |  39 +-
 drivers/android/binder_alloc.h             |  14 +-
 drivers/android/binder_alloc_selftest.c    | 306 -----------
 drivers/android/binder_internal.h          |   4 +
 drivers/android/tests/.kunitconfig         |   3 +
 drivers/android/tests/Makefile             |   3 +
 drivers/android/tests/binder_alloc_kunit.c | 573 +++++++++++++++++++++
 include/kunit/test.h                       |  12 +
 lib/kunit/user_alloc.c                     |   4 +-
 12 files changed, 645 insertions(+), 340 deletions(-)
 delete mode 100644 drivers/android/binder_alloc_selftest.c
 create mode 100644 drivers/android/tests/.kunitconfig
 create mode 100644 drivers/android/tests/Makefile
 create mode 100644 drivers/android/tests/binder_alloc_kunit.c

-- 
2.50.0.727.gbf7dc18ff4-goog


