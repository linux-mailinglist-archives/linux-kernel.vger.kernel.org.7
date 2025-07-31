Return-Path: <linux-kernel+bounces-751570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEC1B16AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C0B1AA176F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD05323BF9E;
	Thu, 31 Jul 2025 03:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rEVXsIRP"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5418F40
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753934029; cv=none; b=i7cnVuAJpOaVp8NVy0nUz3ihJVsY/xJnDLLSkhUzMBbKpWFynq8xPQeSC/jc5VrJiN9K7lWRL6ESx/bIs8FP3Bp28lGA7g+vs/PTTGBkD1zxEP9HqvnMeJIre+2PS4ROYyfyrlO5pJsM7DRTDMQoo3AniDCDHBmP52b4txU8mUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753934029; c=relaxed/simple;
	bh=EKMEnejPhYOqJjJf6SR4ZzFpk2mfA9WB6jMGfDQDfzc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=U0UU2kuDuBIMbRW3d30lvx2Vk8R10t74k3SsXqlq1aNEAk6b5A7TxNXQWHmME8EzLH7YyvbcqgdqOuuxBNLuL8lNGq1ktv9IXOFkp8VEVkymx8502AS2rHRRg7qcx/8IwTDmtu6Omscx7Gy02ik11aHZEuB85KyvNbZsVmuWx1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rEVXsIRP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2fcbd76b61so703309a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753934027; x=1754538827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A+yc40baniel4KIeYGreJcOrQl1eiTBZPlV7KjzQVno=;
        b=rEVXsIRP3CEzk45QaYsTI6WGMwfZXbslErcsEVik1JxHaTnS/mgFNKoQAMWxjde5gH
         qv8I1dW7h2WuvyoQ8XDFydCAC3PPN3Wzx0LEEeOcloD7C2xwDj/PumbdGAjuVvA1JvEP
         5Mg/PnHo4QIzp/g72zXUroy4p9LxltvKjpsp84GEQ+jhxwqEoafYf2/iTDhbrDyVe7tU
         JiaGdEqDzWdcdcojvPBNn0W2CIZ9zlIk5Z5zjOW83nyjvX8+BMvJwSaEv3lZxm9fSTFr
         uwyiEl9xw0qsJ3t02dwbCzirQe56Vw/Za2qT2diFTd8Yc3XVEILE/oN/aH5nk08f/6fg
         ZyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753934027; x=1754538827;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+yc40baniel4KIeYGreJcOrQl1eiTBZPlV7KjzQVno=;
        b=haBc/OCB8EYyYo703jX+fN8UL36cJ6eYvBHRgKV58XCHcptT2Kz11PCD95nkWsIZwN
         t4K9EgSzXDqkWElhZZZ1iUmUxybqGa3/SeXYi+U0wjB403jNhRAntZ9rQBRkEpYoWX7k
         9JwPdMK2tRUuhv9TFgoY93l57oMkaqhZ0uItZXxPqmmtlC1AU52zx3ELZl5JHgKx1BCf
         mUGbPyBfLQAY97YMekjiuXx8FQH+a+qgt0BqzoiUO6pP4JAPf5PsqJbgGDCKM7MIhUtt
         BVSy8mBrJOH3jw/AlH8IGkUUtjfMejmhLgAvryNjJvTSpQD6sczU8glqnvQgzAW2KmQV
         bEag==
X-Forwarded-Encrypted: i=1; AJvYcCWKygRuA3iyZFlZ8tsFEfIOLyz9q7pLl1tAvFkFnKSac2xxb+9rFHCkp6B+mRoqFLYRs1sYC87Ri3VeYWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0rvKAncE7/NmHxopTAQYMOavu9PcdXT3NAPQegRv7njsopK66
	iid953DUXMq0aS2GJduMrkF+eydERbNGQwW0Yd82R3kX/EImsu4up3QU84UaCbk2Qfd30OZxbAF
	ht0oZ0sib2AsZ/g==
X-Google-Smtp-Source: AGHT+IHNcoUDbn3/wxwckRMrajYDxbgZxVX11iycj/MrzPecWmu9a1j6FMGRF2xlgTtq2WBMqjTtKEbUNregDg==
X-Received: from pghr22.prod.google.com ([2002:a63:e516:0:b0:b42:2ab5:b109])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2588:b0:23d:d563:721e with SMTP id adf61e73a8af0-23dd5637442mr2072050637.16.1753934027213;
 Wed, 30 Jul 2025 20:53:47 -0700 (PDT)
Date: Thu, 31 Jul 2025 11:53:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250731035341.2598127-1-davidgow@google.com>
Subject: [RFC PATCH 1/2] kunit: tool: Move qemu architecture dependency checks
 into a function
From: David Gow <davidgow@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently the RISC-V qemu architecture config has some code to check for
the presence of the BIOS files before loading, printing a message and
quitting if it's not present.

However, this prevents us from loading the architecture file even just
to inspect it if the dependencies are not present. Instead, have kunit.py
look for a check_dependencies function, and call it if present only when
the architecture config is being used.

This is necessary for future changes which enumerate or automatically
select an architecture.

Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_kernel.py       |  5 +++++
 tools/testing/kunit/qemu_configs/riscv.py | 10 ++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 260d8d9aa1db..c3201a76da24 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -230,6 +230,11 @@ def _get_qemu_ops(config_path: str,
 	assert isinstance(spec.loader, importlib.abc.Loader)
 	spec.loader.exec_module(config)
 
+	# Check for any per-architecture dependencies
+	if hasattr(config, 'check_dependencies'):
+		if not config.check_dependencies():
+			raise ValueError('Missing dependencies for ' + config_path)
+
 	if not hasattr(config, 'QEMU_ARCH'):
 		raise ValueError('qemu_config module missing "QEMU_ARCH": ' + config_path)
 	params: qemu_config.QemuArchParams = config.QEMU_ARCH
diff --git a/tools/testing/kunit/qemu_configs/riscv.py b/tools/testing/kunit/qemu_configs/riscv.py
index c87758030ff7..3c271d1005d9 100644
--- a/tools/testing/kunit/qemu_configs/riscv.py
+++ b/tools/testing/kunit/qemu_configs/riscv.py
@@ -6,10 +6,12 @@ import sys
 OPENSBI_FILE = 'opensbi-riscv64-generic-fw_dynamic.bin'
 OPENSBI_PATH = '/usr/share/qemu/' + OPENSBI_FILE
 
-if not os.path.isfile(OPENSBI_PATH):
-	print('\n\nOpenSBI bios was not found in "' + OPENSBI_PATH + '".\n'
-	      'Please ensure that qemu-system-riscv is installed, or edit the path in "qemu_configs/riscv.py"\n')
-	sys.exit()
+def check_dependencies() -> bool:
+    if not os.path.isfile(OPENSBI_PATH):
+	    print('\n\nOpenSBI bios was not found in "' + OPENSBI_PATH + '".\n'
+	          'Please ensure that qemu-system-riscv is installed, or edit the path in "qemu_configs/riscv.py"\n')
+	    return False
+    return True
 
 QEMU_ARCH = QemuArchParams(linux_arch='riscv',
 			   kconfig='''
-- 
2.50.1.552.g942d659e1b-goog


