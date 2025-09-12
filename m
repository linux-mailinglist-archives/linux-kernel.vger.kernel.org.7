Return-Path: <linux-kernel+bounces-814865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F499B559DF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123371897161
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDEA28D8ED;
	Fri, 12 Sep 2025 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KQRUMNRz"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34F28726D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757718601; cv=none; b=WGX9K7ind/z3ouCfGxPE95As0Vj+Qkm6x4NIM2wN7y9/WMi3NAl9617zsaCzH6t6idxCEKRebFlBwDfZKnS/4I9AOsNpQl5Nn/icM4hmv7ZiZc5+FqXXbeLjjHfK+p0rCa7GLrarKI/U0QDanEoqBhwgGNRf9n7zqqfM7fSoaGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757718601; c=relaxed/simple;
	bh=YEh//s+EtsJjGeLO13TxNSxxYq8mSsN2ket2o0T8fSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFNHfEcMAdzEb8SR0i9XzqTEwG/ZZRxwDMyfSZsQaPxBJusF4FeagvtxzjRse4PUgyMRhVZZkGjtXv5huGiGrOlfGOXYokXjlu21UuKihFVY3Prw71+nVIFQB0VQSFu58Iymjn4Dkblus1tGfJwpQReX7tOhivm8JXWy6lvNm5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KQRUMNRz; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32df682cba2so545153a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757718599; x=1758323399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aqQsfYpqczFMN6xd995B9cIuPxzc6IeMNO1DIuGzJc=;
        b=KQRUMNRzLQIwOB9SGgCZ1b7r6/r4gdYltSkJpKKYpVE0gy/yOkd/lgR2sxXv0RsNZs
         bb1tIWazv+Bj/yXnD8NLciEBJU/5oUttJVhftH88p4beIUfOkrE+fCxcM1ez6l63Qa0y
         NgQA7SH+iE4cEOkAMfz/iB2jsQ9aTcB8BQbYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757718599; x=1758323399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aqQsfYpqczFMN6xd995B9cIuPxzc6IeMNO1DIuGzJc=;
        b=cOueFUjdqlCVw27/NYsAsqRuhiAYc0VqyIb265Ris0Gd/ES1qiFZtjW5hhkW10bCWr
         6W3xfygIHl+AbKZL/Wvlw21mAdIwVj4EpW4zD/Au97cnJdfjJn19LCodUAvEZyIavY4Z
         2z+6V+z70eRioV9ZJDwqH0w/O+R1pcYo0rbtSDwzBRs2ATpDK9ANimzzdQ3dh6O9umUN
         IMFszEvpccsUNVVxNiKN3qaDAroT+6TptKIFsLQpzb2GvsDG7lyFvPfbbOTZ2HkEi54Y
         qDPBp+KR0RZu2SJQHW4A0sU2vsEGgCgpqJNaNghvzCXps1ScwWfFurK5/8D3tA1M3iVk
         LyAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd3aXw9AS0woUmemvbwyrL6hS4rHS0vAAEvkjXpOjTtSxgZuSW1Q3dVXa1Y6v+VNPslzXEqlXMnyVM79E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/YBQnRLeheVNuWOEptxyu7+p3n/j5adwngVGgHnmoPnxI+V4P
	9vN0y3ikX1fs5l8JqeGOBmKNuOR6mGDgnsnLhHGGah3pjMqkfobf/vC/XK2tJVk5Ig==
X-Gm-Gg: ASbGncvbaCfaTq8CnjuA4Rj0FpJlKF+Ugfq88Les021vr4LxPkBIsaCR7gp3lGmzuM/
	NverJiM+UPUBpuC7UHLBKX0REhOVu70+Kxdtdwyom856yd8R+alHajENVB+q6Z2hSpYyDTygMkz
	JwKtf0BJUPoneLc41hdMVkmrIV24ygheht0DmD9gkvQc7KDzQttlpnCrIf7C/3WKXLAVlmUbpzZ
	WJBAI2nosHptd/8Qh1amzhPnbccW69a9g6o4/RtvUcBHFDd/O+RysLLlK7Gj7h9LTkj/ybkyxxM
	gRZ9fyJdUuKXh2Jv+nV73+VkqTPaxTmUsfLTQWNL25OoLbieehNtdKpxlenc8AveIqMV12TRpt+
	3XCJTpGM5xZLUadFR/f2oafDNv4DrUJ9+lTIMJ2K70ohGPmqyInCbLllyHu0=
X-Google-Smtp-Source: AGHT+IHahHShoB5Ii1WzvFIbd2LUrSYt+MXYAQPhHq31+WasztFuE5rlFSFzEb7dWV7UvuA2EIiQ1Q==
X-Received: by 2002:a17:90b:4d0e:b0:327:53f0:6368 with SMTP id 98e67ed59e1d1-32de4b88595mr5567635a91.2.1757718599221;
        Fri, 12 Sep 2025 16:09:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e464:c3f:39d8:1bab])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b54a35b7e31sm5643608a12.11.2025.09.12.16.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 16:09:58 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>,
	Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 4/4] kunit: qemu_configs: Add PCI to arm, arm64
Date: Fri, 12 Sep 2025 15:59:35 -0700
Message-ID: <20250912230208.967129-5-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250912230208.967129-1-briannorris@chromium.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To get some more test coverage on PCI tests.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 tools/testing/kunit/qemu_configs/arm.py   | 1 +
 tools/testing/kunit/qemu_configs/arm64.py | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/kunit/qemu_configs/arm.py b/tools/testing/kunit/qemu_configs/arm.py
index db2160200566..101d67e5157c 100644
--- a/tools/testing/kunit/qemu_configs/arm.py
+++ b/tools/testing/kunit/qemu_configs/arm.py
@@ -3,6 +3,7 @@ from ..qemu_config import QemuArchParams
 QEMU_ARCH = QemuArchParams(linux_arch='arm',
 			   kconfig='''
 CONFIG_ARCH_VIRT=y
+CONFIG_PCI=y
 CONFIG_SERIAL_AMBA_PL010=y
 CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
 CONFIG_SERIAL_AMBA_PL011=y
diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
index 5c44d3a87e6d..ba2b4e660ba7 100644
--- a/tools/testing/kunit/qemu_configs/arm64.py
+++ b/tools/testing/kunit/qemu_configs/arm64.py
@@ -2,6 +2,7 @@ from ..qemu_config import QemuArchParams
 
 QEMU_ARCH = QemuArchParams(linux_arch='arm64',
 			   kconfig='''
+CONFIG_PCI=y
 CONFIG_SERIAL_AMBA_PL010=y
 CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
 CONFIG_SERIAL_AMBA_PL011=y
-- 
2.51.0.384.g4c02a37b29-goog


