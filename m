Return-Path: <linux-kernel+bounces-785013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5E3B344BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89EF37A5111
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0562FC008;
	Mon, 25 Aug 2025 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Wq8T7vpv"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F4B2FABF7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133852; cv=none; b=PK5yYi8bRwiVLBZuNilvMqZLTGoliji8zhg1bvCf4IQZhj1hwDp7c2YTz/kyTQ7Nry31fAkLNyYaCSjZFRNZDf64q2J7qxKGGz6GvKUGIWAdUpf5RQ43p5Ydj8n0GCAN8MpLV+ivirRCvTZOgxx/Fw1A6dOhOW6xQMsbnxPkw5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133852; c=relaxed/simple;
	bh=JH2YsonV3EAZH0DTcNFaxzu8DrMdoOtLh5Y0M8Z1pxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IV7JtBSFq5erEOdxfdLnTtA4qizdBUSdad2Fh8OktatnkL7jnKwbyNw2dXfdEEuKHek8wf8Lyh61LzbV0FPkJbpXsG5iApmFJWBZO9hv07Fl5f9eQupURM0sKYyso54FNOTcUEYCATY7lLhF6OeVb4ooZgjVP9c9ePeguI8cP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Wq8T7vpv; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso1288545b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133850; x=1756738650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VdEVZ5TCp58sTeVk+nfvlA0Ah5Y1WxCmV7eSgrEVDls=;
        b=Wq8T7vpvbumuM+QXjaLEY1TP2qh2kJHJu3YqtFom+RFIwnK1M+P1LX20aJaax9nl3x
         6B0Uk0TbkLM7St7EiWUyaI837MyvGYPaQ7zIVmcNK1g8U/4IyQaAOo7gOZfDKDPdnJDU
         j0b1vItsmLEGso7AlIoMsheOXhaZN/+rccp2Fr6Gc6CA+wW2T7pF8+u1+VrNwteZ8GLw
         f/6uTpcrTqVRYBmI9Af0D4bZB+yjlpsNiUykTDoGtuhMA/BYM8q+0ZlTnVkIR61ejjAY
         7rabhmW9n6e1JHz5dO3sMUuojeT+4Dx4XbjxEU4HmcBLmRZ1UFr3IwaOALvk2f9hBqXB
         zgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133850; x=1756738650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdEVZ5TCp58sTeVk+nfvlA0Ah5Y1WxCmV7eSgrEVDls=;
        b=QshEXkW7ynU8CAWjOhKQmeiLV9PkZtJHgmk0cF05S3Jucb0xNCcYV4kjMLyqWxOxfo
         M+lR/EMkyovxdSN2G1EkXMfQ6pzGlBN/gT+EM91UqoGBUoLDekAkDua9DeL/NTNFQYjY
         ZMtQ5cdlV3TowfCgr8ydElWh83fEshPY0cKrud++OtA72hG1iksjXhaUDnlubJA1GZCs
         GeN0kAxBf6eRzc6V3bzq9OFJmX0WU9Cu+EbYHGv7zMVFsSFiJ8Ou6uOs6yIDF2Lrn2f7
         7CNS8bxmCChSXqywjzUck10r7yk8ozBlTKGqIhA4bffEKicAhgXuYnG+1vZeFapWXTtm
         vucg==
X-Gm-Message-State: AOJu0YyvZk26H9pWneveSLgHU+o1saz7mzm6SKwC++OWqqHlvWGbe4n3
	mouI0k4yypuI4ictdwCF2XUbOHToDAztOzamfzaPi3RuALcfkDzoWX3dNWujBuhS2l0=
X-Gm-Gg: ASbGncuLKOQ3gA5Hjmb985vnX1g8Dt3eBX9SbG+h3uL3lPHbGZ3ioYMy3+KAyeikIRj
	ohGAlzS1dip+auYsafd2SnmOB76/UutGq8qCKdJLfHjKrQ2GtCezIokDOAu5DLrmKvv53RnwUkl
	m7X5hshiCcTdLTnZLmFLygT8CKxzu7gAHPJ0VH2C1zUDvQjtCnDx8rEd7is42OZH61jw04B4/ur
	XCuQkPWh6RUGRHCHeeu+co6hmJlvtl0DL5rSm2+ktXenmACZEFTAb6nbGRqeSMieigiUGqzHZQz
	5mUi7ozH+0VPEEZyrUTVvfUscYccrIxNKh7lEHos4lEewsW+UD6uelQQVgOCiwoRCOg8t6CbQZm
	BgB188w9xbG6bnL7XAdx9QXDpSRlNH6Zx4RGP9ruPRd+bD+qUvY2QWpLhkIB4
X-Google-Smtp-Source: AGHT+IENPQBoFqdndLCJHhCszx3PtbFlasr7HlxuUT0VwFZeQm4kkp41cyvWYH6QXY7aP4DPdWilzw==
X-Received: by 2002:a05:6a00:bd92:b0:76e:7aee:35f1 with SMTP id d2e1a72fcca58-7702fc09f00mr14592628b3a.29.1756133849771;
        Mon, 25 Aug 2025 07:57:29 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.57.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:57:29 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 0/8] Add selftests for mshare
Date: Mon, 25 Aug 2025 22:57:03 +0800
Message-Id: <20250825145719.29455-1-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mshare is a developing feature proposed by Anthony Yznaga and Khalid Aziz
that enables sharing of PTEs across processes. The V3 patch set has been
posted for review:

https://lore.kernel.org/linux-mm/20250820010415.699353-1-anthony.yznaga@oracle.com/

This patch set adds selftests to exercise and demonstrate basic
functionality of mshare.

The initial tests use open, ioctl, and mmap syscalls to establish a shared
memory mapping between two processes and verify the expected behavior.

Additional tests are included to check interoperability with swap and
Transparent Huge Pages.

Future work will extend coverage to other use cases such as integration
with KVM and more advanced scenarios.

This series is intended to be applied on top of mshare V3, which is
based on mm-new (2025-08-15).

Yongting Lin (8):
  mshare: Add selftests
  mshare: selftests: Adding config fragment
  mshare: selftests: Add some helper function for mshare filesystem
  mshare: selftests: Add test case shared memory
  mshare: selftests: Add test case ioctl unmap
  mshare: selftests: Add some helper functions for reading and
    controlling cgroup
  mshare: selftests: Add test case to demostrate the swaping of mshare
    memory
  mshare: selftests: Add test case to demostrate that mshare doesn't
    support THP

 tools/testing/selftests/mshare/.gitignore |   3 +
 tools/testing/selftests/mshare/Makefile   |   7 +
 tools/testing/selftests/mshare/basic.c    | 108 ++++++++++
 tools/testing/selftests/mshare/config     |   1 +
 tools/testing/selftests/mshare/memory.c   |  82 +++++++
 tools/testing/selftests/mshare/util.c     | 251 ++++++++++++++++++++++
 6 files changed, 452 insertions(+)
 create mode 100644 tools/testing/selftests/mshare/.gitignore
 create mode 100644 tools/testing/selftests/mshare/Makefile
 create mode 100644 tools/testing/selftests/mshare/basic.c
 create mode 100644 tools/testing/selftests/mshare/config
 create mode 100644 tools/testing/selftests/mshare/memory.c
 create mode 100644 tools/testing/selftests/mshare/util.c

-- 
2.20.1


