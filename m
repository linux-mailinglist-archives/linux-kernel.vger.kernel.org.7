Return-Path: <linux-kernel+bounces-852867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E644BDA22B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5643B9798
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A482F99A6;
	Tue, 14 Oct 2025 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xErK7qIV"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5662882CF
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453134; cv=none; b=fjRvuYgEcqvqT7Bd2WTYYOtQm4rPAcx+4goL6Fv6vG/GOnwBdk9NrTI3JC3/pmvOm7PXIk6IbLjU0omMBnH6as39bJQStPljePuewnYlDjaFnT8M22O8gdYnH02NpKcYYOUJTQcyjgMQZMIvRj7VSR6PN5P6NWJpS7zy8/+ifkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453134; c=relaxed/simple;
	bh=8YGDWKZMZ4rg6g9jadHfjYJ49DLGb0GNWnRjrg7bjP8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oWdm6QZIoxh5Ihule1ixNJhvAVC+jwYys8W0FHbftjUsRizMnRolN9XdBais9NMV/hJHJx0a7ToCzC8yYIBugMie+573jd1UclW5loSOSEZm6rNTvZ/cHBH/JzDjCcJIbcA0JyNd+IZg8qK/IvAZoilZ/mi3r8ovv/CfgZ6CsRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xErK7qIV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e473e577eso39579455e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760453131; x=1761057931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gHk+n1DTS8EFhi+cKHdXuVXK4mRrNAjTvT92loE1bGw=;
        b=xErK7qIVKa04S4WyxU1S+qrTZg8tdGI24sFvrcml3cQcLMsrOlmwOAKwr/f7UsqxKT
         vH/I7h2Yy1NHfvg1qUN0+2BKAnrh9RHVPT/5kDuCwrgRkSb1973CmnZ+fZQKjM+Uhqc+
         f3CKbAmvQk0UqEC3B95Bfv8Ykl2mK6DiTwHq11eypJxUfjyXLZkv8X2Ehd8iXHEfAalL
         yXeU20/kklIbGHSXrna8/yJlXuP8JSdgQ0qnHTzEV8sDddfZGR6pflCnpbLazzuxK5AR
         qjCKSVmIxcbezMbms6coq8Fkgp+23O3L4cDOHbHxfZeuYplkVlapu9VfOwVtmmrveqEU
         wE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453131; x=1761057931;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHk+n1DTS8EFhi+cKHdXuVXK4mRrNAjTvT92loE1bGw=;
        b=TfmlsqOPEzVHqq55ztHqxy95/unY2hifmkkE+jruCy4K/vhlirXE+Q+Jc4jsINkCM7
         xJF3WIBXBfPXPb+N3jOOmTOxOrJWtQaUBRGeXfc5uIq7Y4QNu5WqN5uuwY4dQ0ow3pk2
         TbjXls6Dpiu7/2cwdEIFfe9S9aVLKrC2umCeOjvWLmgLaoI1NBAE00NYQHFjfmeMhzRj
         y6ErMbR2Tuo73+EnFHjRBvNLs1BNVTyZhfLia7yATMgZ9zP/lYEhQ5ttss9VjVgWyaeS
         TLxN78xCvCqZPLpNOtlLrCoxsliLVEfzsMJ7CxnP29llYc5YDHygJi6gS0SZ3YPw3lA/
         PD4g==
X-Forwarded-Encrypted: i=1; AJvYcCXpfggbmBfGcl7bW2JIvI0dKrh9vZDPY3kyePE48ydFuVd1YNkzbrA1Nd/cxUDMMqQqVKN/77Gy1l4WNd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySxd8WrEKtDbV+uato+/RceKKlPbjMrv7cvrY5aU5BTXMBVbcY
	52soAdGKvOETwDfeho38vAHFwEPCanBDLrMO95S3qq/HEmeOyObQjmDvcbSszbz2EHGUiJGeZpN
	Lf6+4dYM6VOtB9Q==
X-Google-Smtp-Source: AGHT+IGStL63V0FhO1l0cVvqKc9OTBHXvyFk5MbM/ZPcJ10xamJ8DJso5DtxHGWCKT7x5jpmn9mFsq4KkGOAmg==
X-Received: from wmvw16.prod.google.com ([2002:a05:600d:42d0:b0:46f:aa50:d714])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c23:b0:46e:32a5:bd8d with SMTP id 5b1f17b1804b1-46fa9a892d7mr183885885e9.3.1760453131207;
 Tue, 14 Oct 2025 07:45:31 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:45:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAP9h7mgC/4XNTQ7CIBCG4asY1o6B4a9x5T2Mi4LQEmsx0BBN0
 7tLu9KFcfl+yTwzk+xScJkcdzNJroQc4liD73fE9u3YOQjX2gQpSkapBiPglv0ELqWYII7g2zA
 AtWgNR6GoYKTePpLz4bm550vtPuQpptf2prB1/ScWBgw0M57Kxkul8NTF2A3uYOOdrGTBD4aJX wxWxnCHSmrk2jRfzLIsbycYHKUCAQAA
X-Change-Id: 20251007-b4-ksft-error-on-fail-0c2cb3246041
X-Mailer: b4 0.14.2
Message-ID: <20251014-b4-ksft-error-on-fail-v3-1-31e96fdf9bd7@google.com>
Subject: [PATCH v3] selftests/run_kselftest.sh: exit with error if tests fail
From: Brendan Jackman <jackmanb@google.com>
To: Shuah Khan <shuah@kernel.org>
Cc: "=?utf-8?q?Thomas_Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Parsing KTAP is quite an inconvenience, but most of the time the thing
you really want to know is "did anything fail"?

Let's give the user the his information without them needing
to parse anything.

Because of the use of subshells and namespaces, this needs to be
communicated via a file. Just write arbitrary data into the file and
treat non-empty content as a signal that something failed.

In case any user depends on the current behaviour, such as running this
from a script with `set -e` and parsing the result for failures
afterwards, add a flag they can set to get the old behaviour, namely
--no-error-on-fail.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Changes in v3:
- Fixed quoting
- Link to v2: https://lore.kernel.org/r/20251014-b4-ksft-error-on-fail-v2-1-b3e2657237b8@google.com

Changes in v2:
- Fixed bug in report_failure()
- Made error-on-fail the default
- Link to v1: https://lore.kernel.org/r/20251007-b4-ksft-error-on-fail-v1-1-71bf058f5662@google.com
---
 tools/testing/selftests/kselftest/runner.sh | 14 ++++++++++----
 tools/testing/selftests/run_kselftest.sh    | 14 ++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 2c3c58e65a419f5ee8d7dc51a37671237a07fa0b..3a62039fa6217f3453423ff011575d0a1eb8c275 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -44,6 +44,12 @@ tap_timeout()
 	fi
 }
 
+report_failure()
+{
+	echo "not ok $*"
+	echo "$*" >> "$kselftest_failures_file"
+}
+
 run_one()
 {
 	DIR="$1"
@@ -105,7 +111,7 @@ run_one()
 	echo "# $TEST_HDR_MSG"
 	if [ ! -e "$TEST" ]; then
 		echo "# Warning: file $TEST is missing!"
-		echo "not ok $test_num $TEST_HDR_MSG"
+		report_failure "$test_num $TEST_HDR_MSG"
 	else
 		if [ -x /usr/bin/stdbuf ]; then
 			stdbuf="/usr/bin/stdbuf --output=L "
@@ -123,7 +129,7 @@ run_one()
 				interpreter=$(head -n 1 "$TEST" | cut -c 3-)
 				cmd="$stdbuf $interpreter ./$BASENAME_TEST"
 			else
-				echo "not ok $test_num $TEST_HDR_MSG"
+				report_failure "$test_num $TEST_HDR_MSG"
 				return
 			fi
 		fi
@@ -137,9 +143,9 @@ run_one()
 			echo "ok $test_num $TEST_HDR_MSG # SKIP"
 		elif [ $rc -eq $timeout_rc ]; then \
 			echo "#"
-			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout seconds"
+			report_failure "$test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout seconds"
 		else
-			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
+			report_failure "$test_num $TEST_HDR_MSG # exit=$rc"
 		fi)
 		cd - >/dev/null
 	fi
diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
index 0443beacf3621ae36cb12ffd57f696ddef3526b5..d4be97498b32e975c63a1167d3060bdeba674c8c 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -33,6 +33,7 @@ Usage: $0 [OPTIONS]
   -c | --collection COLLECTION	Run all tests from COLLECTION
   -l | --list			List the available collection:test entries
   -d | --dry-run		Don't actually run any tests
+  -f | --no-error-on-fail	Don't exit with an error just because tests failed
   -n | --netns			Run each test in namespace
   -h | --help			Show this usage info
   -o | --override-timeout	Number of seconds after which we timeout
@@ -44,6 +45,7 @@ COLLECTIONS=""
 TESTS=""
 dryrun=""
 kselftest_override_timeout=""
+ERROR_ON_FAIL=true
 while true; do
 	case "$1" in
 		-s | --summary)
@@ -65,6 +67,9 @@ while true; do
 		-d | --dry-run)
 			dryrun="echo"
 			shift ;;
+		-f | --no-error-on-fail)
+			ERROR_ON_FAIL=false
+			shift ;;
 		-n | --netns)
 			RUN_IN_NETNS=1
 			shift ;;
@@ -105,9 +110,18 @@ if [ -n "$TESTS" ]; then
 	available="$(echo "$valid" | sed -e 's/ /\n/g')"
 fi
 
+kselftest_failures_file="$(mktemp --tmpdir kselftest-failures-XXXXXX)"
+export kselftest_failures_file
+
 collections=$(echo "$available" | cut -d: -f1 | sort | uniq)
 for collection in $collections ; do
 	[ -w /dev/kmsg ] && echo "kselftest: Running tests in $collection" >> /dev/kmsg
 	tests=$(echo "$available" | grep "^$collection:" | cut -d: -f2)
 	($dryrun cd "$collection" && $dryrun run_many $tests)
 done
+
+failures="$(cat "$kselftest_failures_file")"
+rm "$kselftest_failures_file"
+if "$ERROR_ON_FAIL" && [ "$failures" ]; then
+	exit 1
+fi

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20251007-b4-ksft-error-on-fail-0c2cb3246041

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


