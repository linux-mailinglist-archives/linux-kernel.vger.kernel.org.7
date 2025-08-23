Return-Path: <linux-kernel+bounces-783359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8C9B32C57
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 00:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 682B74E0738
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 22:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218AC23ABA9;
	Sat, 23 Aug 2025 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU2uHIdS"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3892E413
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755989131; cv=none; b=KDbxUzC/R8ooyjpmj9JZnq0M2mguXagHElsbArG5eRqKWmS6MFG4sZcn5FsutSo+ipi/myLvnTzZaU/a5ccxmJsnrBfMrFvselwAS/1udtmuKqXk5mNKcWUaKEXExhfAFjGMgMrNVUZBpQVsd6fTzZFeoIBB/vy4l3rWIY3fJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755989131; c=relaxed/simple;
	bh=NWxVNr+6+P6bpm1PLbSJ3cHIhOGAgHA7M4dR2K7/028=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D426o640T3vCNJTJzML37GZBXd+ux14KIGW1vFix4v6qNC+t5tdyrpLNmKe0obl7muiUdPonKGu4W5/qeb7kGlB9YKGRy7VHAhXpGXXj99fiNnIy/lk273On8vhDVwxCFqlD84es+lLyQ2zhtao72njduZxSngVujXoDzrDvrAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU2uHIdS; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2469e32f7c1so1843805ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755989129; x=1756593929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHsBzKeueZKVBx8HPEoXrSSKWbJ94xL2ADXJvg8lJW8=;
        b=KU2uHIdSJnS00XehWmNQU7+WXDlzHfTYNeRGgJVi0zMPpUkmeZBMCvwv4apeF7y9WK
         003fcsIm06hzvadgGu3o3fZfZ6hsMol11FD1Yb+mMJLvz4HWaK0Ad9IAmDFxW7J/WtYx
         ad7YE4LQL63v0g/ATzm0b77HrjN79+z9OGnqjpi364uugvklvYLLyZO7SuVZYfUyZrY7
         W74ZqzswTKKglZRHNso5qjtUgmmfvjtwtt9TrvFS2cfdrSssdTtej6IylB8uS4AJsVfD
         v/nt/noR9bgCGzQIRrk+b25dv8RiSv/USWjtbiVbN5HI8B51AD/xWjpfBLLMyVamB2Nj
         9qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755989129; x=1756593929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHsBzKeueZKVBx8HPEoXrSSKWbJ94xL2ADXJvg8lJW8=;
        b=f0yLPRoAzFR9q7CBvlLPuL/kdlN4qJndPtmMxWc0nEFUDJxR+l1hlM0/WNl3F5mJmF
         IFCvAgTe/se+VU4orRrZ3sh7neUKsTRUnv9IDtyBqjwo8xzPWxqzGrr1uAReQfIojtqX
         /IofbkKHPZw2rsveLQXOBRVVhV8YPmZKwfY6eB07CcovjDKcDVfcf3qtAXrjjOiZIYng
         I/mCu6HcDgMZ79fBf3R7GOxhCK0YO6jHizdqj/9fu8v9DDmXHhoCof10M4o/K4GLdmtO
         PgRE+OZ5OH99btW0LrZ3/m6yCNWUiUOnuodPmhMHRJxbJ301j03iihPSHyC0cvptJd/R
         BaAQ==
X-Gm-Message-State: AOJu0YzF8jkGC4oTmqhqTs+Lu2VOU7T5Y/JGloUu5prAs0KJdo9BytMd
	Zc2xy0g8fnavyCZ3RUnt9pe5k2LX/tekm7LdWmxCit0zIoMz6vOniZaMS9ax92+1
X-Gm-Gg: ASbGncvVkJG/LwqbbIXRFB+lsKbsDnqCp5GRZx+RBVHwTBcD+VTVA2TfNnMODBZeDb0
	ecLqaL5DfNDJBW6gqhk5iDAMWtB6dqjJIDf2xSQgf7LNYD0iXP7fVzAZHVCNq4OA0ptN6HX2Z25
	b+Y3HRNtShFz7zY2ITpfMN8Wu0PA7EKxXdhb03B+XbNCvxpRlbmmxfqBbfNHZrCSZArf9lBNy80
	N8VBf9KhnwCOoHj8RtzFCy6NU0a0uNnONSt8dh/d7dOdhU2VniczrsHt0e4dbGxzj4dcW/aC+sT
	mtf0dbPd8/1TLcit6dFtKMLOTj4UDguR92FZUNVQZpaAyGDf4NbWos/dacbfI+sBfbY1GXh6qOl
	QRXWUgg4YNg==
X-Google-Smtp-Source: AGHT+IFJnj4JrFaJ0n6g2olmkEu0zL16Y/UlajtFV/oAdIf8O4OFDaSCIkhgfK7G37jKKk/id7KT8g==
X-Received: by 2002:a17:902:e888:b0:23d:d0e7:754b with SMTP id d9443c01a7336-2462ee0853dmr91593385ad.18.1755989129272;
        Sat, 23 Aug 2025 15:45:29 -0700 (PDT)
Received: from localhost ([2a09:bac1:3680:98::10c:23])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-770401afde8sm3334373b3a.61.2025.08.23.15.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 15:45:28 -0700 (PDT)
From: "Kavithesh A.S" <kavitheshnitt@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	"Kavithesh A.S" <kavitheshnitt@gmail.com>
Subject: [PATCH] selftests/exec: improve clarity of error messages
Date: Sun, 24 Aug 2025 04:16:11 +0530
Message-ID: <20250823224611.549648-1-kavitheshnitt@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed minor grammar/wording in check-exec-tests.sh messages for clarity.

Signed-off-by: Kavithesh A.S <kavitheshnitt@gmail.com>
---
 .../testing/selftests/exec/check-exec-tests.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/exec/check-exec-tests.sh b/tools/testing/selftests/exec/ch
index 87102906a..21908f107 100755
--- a/tools/testing/selftests/exec/check-exec-tests.sh
+++ b/tools/testing/selftests/exec/check-exec-tests.sh
@@ -27,11 +27,11 @@ exec_direct() {
 	out="$(PATH="." "$@" "${script}")" || ret=$?
 
 	if [[ ${ret} -ne ${expect} ]]; then
-		echo "ERROR: Wrong expectation for direct file execution: ${ret}"
+		echo "ERROR: Incorrect expectation for direct file execution: ${ret}"
 		return 1
 	fi
 	if [[ ${ret} -eq 0 && "${out}" != "${EXPECTED_OUTPUT}" ]]; then
-		echo "ERROR: Wrong output for direct file execution: ${out}"
+		echo "ERROR: Incorrect output for direct file execution: ${out}"
 		return 1
 	fi
 }
@@ -47,11 +47,11 @@ exec_indirect() {
 	out="$("$@" ./inc "${script}")" || ret=$?
 
 	if [[ ${ret} -ne ${expect} ]]; then
-		echo "ERROR: Wrong expectation for indirect file execution: ${ret}"
+		echo "ERROR: Incorrect expectation for indirect file execution: ${ret}"
 		return 1
 	fi
 	if [[ ${ret} -eq 0 && "${out}" != "${EXPECTED_OUTPUT}" ]]; then
-		echo "ERROR: Wrong output for indirect file execution: ${out}"
+		echo "ERROR: Incorrect output for indirect file execution: ${out}"
 		return 1
 	fi
 }
@@ -67,11 +67,11 @@ exec_stdin_reg() {
 	out="$("$@" ./inc -i < "${script}")" || ret=$?
 
 	if [[ ${ret} -ne ${expect} ]]; then
-		echo "ERROR: Wrong expectation for stdin regular file execution: ${ret}"
+		echo "ERROR: Incorrect expectation for stdin regular file execution: ${ret}"
 		return 1
 	fi
 	if [[ ${ret} -eq 0 && "${out}" != "${EXPECTED_OUTPUT}" ]]; then
-		echo "ERROR: Wrong output for stdin regular file execution: ${out}"
+		echo "ERROR: Incorrect output for stdin regular file execution: ${out}"
 		return 1
 	fi
 }
@@ -86,7 +86,7 @@ exec_stdin_pipe() {
 	out="$(cat script-exec.inc | "$@" ./inc -i)" || ret=$?
 
 	if [[ ${ret} -ne ${expect} ]]; then
-		echo "ERROR: Wrong expectation for stdin pipe execution: ${ret}"
+		echo "ERROR: Incorrect expectation for stdin pipe execution: ${ret}"
 		return 1
 	fi
 }
@@ -101,11 +101,11 @@ exec_argument() {
 	out="$("$@" ./inc -c "$(< script-exec.inc)")" || ret=$?
 
 	if [[ ${ret} -ne ${expect} ]]; then
-		echo "ERROR: Wrong expectation for arbitrary argument execution: ${ret}"
+		echo "ERROR: Incorrect expectation for arbitrary argument execution: ${ret}"
 		return 1
 	fi
 	if [[ ${ret} -eq 0 && "${out}" != "${EXPECTED_OUTPUT}" ]]; then
-		echo "ERROR: Wrong output for arbitrary argument execution: ${out}"
+		echo "ERROR: Incorrect output for arbitrary argument execution: ${out}"
 		return 1
 	fi
 }
-- 
2.43.0

