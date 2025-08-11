Return-Path: <linux-kernel+bounces-763285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C8B212B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392D43AA82D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1267D29BDB0;
	Mon, 11 Aug 2025 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZaNeQG7"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5731A9F9D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931660; cv=none; b=Kia4MwtctaG9f89ZNOr5CyO6nfX1NJHT5t/NV32ysFAdX2H4ayogl8UNM396jIWdty9abJxtbXaU59lgzaIj1RgaM3oay+J9rBCeXwyeNIm321HnsMy4OhSsyCMpkv2TniIhHrlmLABTcXajEQoSVR0pAhSdPKdC3XYLrhBYxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931660; c=relaxed/simple;
	bh=YYBsOSZTzGmwlXVdHceQeByVSwLLZRBjF7Okwkt++fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FORTpqCSIA/jer419+pRO416P103ywsLsbQsOjO+m0MfWetXyym5FJ8m/luL3jun6qkmIA/ruqMBiKzdtoeWBtIIUK2u4y6kLcM1bpilXLw+5PDpLjJWg/ZXn5ebU0bkv5qyuYsqaFq+gCGxprWrXDm8b4JhS5XP233fr2NR3PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZaNeQG7; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32117db952aso3815888a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754931658; x=1755536458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QPhhmdVj2zt9+8pHoVZ1ejD+Bo3wE8/FwKPpnpZx/DE=;
        b=cZaNeQG7srb0z+0OHermdI5hBPsbGBrWmDbx+PDaajAodE40IoYvytd0q0RotynQZi
         aIWPRzu/9xamAt/JsNr5es5ckHzxYFDww83/AE5gtx30PaACprp2gIxSJfkhbNex7emp
         UVAcloUnd9wLq4aWTIeg4J8TmbwVMKqnDa2YoQHCZI7qpnMc9r8lglQueOnK9e0hacTw
         FYEEiDb26FtP5M62NbkF77w7CuAIRh+SSRcW2I6qt7Vj75dXpKMrpz9PCXE4Lw1uGBDi
         VjDFB5FV2GIQSePZ7SQmvepFsbbDiJv6rRy7XHbbgSzM+niMp2J783jUGg77rAk19c4S
         oGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754931658; x=1755536458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPhhmdVj2zt9+8pHoVZ1ejD+Bo3wE8/FwKPpnpZx/DE=;
        b=wjk6P40FTyt3S0zv0wj56YtksPZacIuJQ9CBukocGK9QCc1o+f8nx+wtPeEhh3ILgf
         3zpm+EWeIbWG9SJdE5vWKLs3JvJG4fUU1tTSD6ValP04itrVRDcZ8YY00ump1Tt6yvgl
         t9njzBkETi2PN3JLuPOWuPEkOLwnidLTwS1XMlsN6/eZd+BAFw76Vg2Hk4dqv90TFSpC
         +QUy/CP/aJj93zXsjogrhSvR8lhm594M6CLg/mwPUosKW6NeMgQPxxtF2yqIFdOvE0jF
         X3XL5CLfLfwk12ImJSaz0sbTc5PyHfQjTdctoWKKciRPybxIVFJlEMC4QHOeMKfapsAU
         Rwng==
X-Forwarded-Encrypted: i=1; AJvYcCWJr4UgPKdBOmyTIa0qJN/KrW6nOf5/M+q+Q1TxQkgMwNqkZKsyjPHb8y5A0C+aRXO4uvHeL7a1dmbLtJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQvfI9Eh9CHmS5t05sdoRkrHQwR+P4wOiPOIqWHODovwPoKMA
	Mq44kYv+TBbkdLqunnkLs9uwnN+B1/2heznFii6nQUdxZEZJv921cZ6/
X-Gm-Gg: ASbGncvh+4D9OvrM0aDWdj7hmi0sL8d/Zd6MMxwgc9tImTD/UF9mOJ1vXFS6lxuV66s
	0efnc+4CBkqe0W6RfYSgnDRRf6WkDYTuibwb3JvsQTCalSPRGvsYoL+o1g6QV0kgUtR6WT/rb1o
	MgBNWx9/zPdvFGSeGcYxaZnUzoHJqD7fTiCee0Ik+bHkq9hQHJ5GwZFNugKszdCF4MTyowj0d6M
	aV3C57ueMGkcJ6ZWVEZ71sq0sWUYHnxVn6W0OswojNJrs2sYcjJTndDmtW0b++zjTiudaXoPB1F
	2CVYeNtzlPW/MYkCDpwdAsmaAhHMz8MXk/gdDImJL0uONqQ/NVvkjhJWJ4s3wpdQkWaNOOyQPrC
	h85ePM/aa51WfzklRMwAdW8PrHkuVGJ9+RI4vThURfLOkcDoXYI7fGtMMrBRkjmDqxg==
X-Google-Smtp-Source: AGHT+IFlUtkPL3MkM6BSJoR+uUdCcN1ck0aR8fv6x5sWJaoPa/EPzL9HUlQRBpUgrYZzO2RxqQELng==
X-Received: by 2002:a17:90b:3a91:b0:31c:15d9:8ae with SMTP id 98e67ed59e1d1-321c0b7e35cmr428564a91.33.1754931657951;
        Mon, 11 Aug 2025 10:00:57 -0700 (PDT)
Received: from localhost.localdomain (wf122-104.ust.hk. [175.159.122.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321612815b9sm15502255a91.24.2025.08.11.10.00.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 Aug 2025 10:00:56 -0700 (PDT)
From: Haoyang LIU <tttturtleruss@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com,
	Haoyang LIU <tttturtleruss@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V2] scripts/checktransupdate.py: add support for scanning directory
Date: Tue, 12 Aug 2025 01:00:50 +0800
Message-ID: <20250811170050.94997-1-tttturtleruss@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Origin script can only accept a file as parameter, this commit enables
it to scan a directory.

Usage example:
./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools

Signed-off-by: Haoyang LIU <tttturtleruss@gmail.com>
---
V1 -> V2: remove the fix of missing "f" in f-string and make it a new patch

 scripts/checktransupdate.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/scripts/checktransupdate.py b/scripts/checktransupdate.py
index e39529e46c3d..01271fb30cbe 100755
--- a/scripts/checktransupdate.py
+++ b/scripts/checktransupdate.py
@@ -13,6 +13,8 @@ The usage is as follows:
 This will print all the files that need to be updated or translated in the zh_CN locale.
 - ./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst
 This will only print the status of the specified file.
+- ./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools
+This will print all the files in the specified folder and its subfolders.
 
 The output is something like:
 Documentation/dev-tools/kfence.rst
@@ -21,6 +23,17 @@ No translation in the locale of zh_CN
 Documentation/translations/zh_CN/dev-tools/testing-overview.rst
 commit 42fb9cfd5b18 ("Documentation: dev-tools: Add link to RV docs")
 1 commits needs resolving in total
+
+Documentation/translations/zh_CN/dev-tools/index.rst
+commit d5af79c05e93 ("Documentation: move dev-tools debugging files to process/debugging/")
+commit d5dc95836147 ("kbuild: Add Propeller configuration for kernel build")
+commit 315ad8780a12 ("kbuild: Add AutoFDO support for Clang build")
+3 commits needs resolving in total
+
+Documentation/translations/zh_CN/dev-tools/kcsan.rst
+commit b37221cc861d ("Documentation: kcsan: fix "Plain Accesses and Data Races" URL in kcsan.rst")
+commit 72ffee678f6f ("docs: update dev-tools/kcsan.rst url about KTSAN")
+2 commits needs resolving in total
 """
 
 import os
@@ -293,6 +306,17 @@ def main():
                 if args.print_missing_translations:
                     logging.info(os.path.relpath(os.path.abspath(file), linux_path))
                     logging.info("No translation in the locale of %s\n", args.locale)
+    else:
+        # check if the files are directories or files
+        new_files = []
+        for file in files:
+            if os.path.isfile(file):
+                new_files.append(file)
+            elif os.path.isdir(file):
+                # for directories, list all files in the directory and its subfolders
+                new_files.extend(list_files_with_excluding_folders(
+                    file, [], "rst"))
+        files = new_files
 
     files = list(map(lambda x: os.path.relpath(os.path.abspath(x), linux_path), files))
 
-- 
2.50.1


