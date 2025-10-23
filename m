Return-Path: <linux-kernel+bounces-866049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F93BFEC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A1C64E82B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C970917B418;
	Thu, 23 Oct 2025 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flCqHk1m"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1571DF256
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181229; cv=none; b=jHq2Q3l+0R21Fwc/HUN+sjSwtWBDgdMe/3eucYCyB/tqbifidHiVWvixvAdLp4huHAUMqIOhRWvlhjSm9hFhSpgGb1TdRkD9ogpNebF+96ykZbNwDiprWfDAuA0OA0sg3k0+Il8g9/AI4tZ7l6I8+6DSG8gWQgnS78qAK7R2rP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181229; c=relaxed/simple;
	bh=bLgJRj0B3l4I9LRxTwg4ipTz6i5xRpftUXJZZBIn7VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tjA04oEpATG8/B58fIVFT6MnvMcLRGeUGJ18/Usx6eg2fRuVPMZYwv0edre10vyKLoHzIDpXGw3pQ5JKE2bkX7K9cNNX1NLl4mYZ1Lunw7nenx+Ob1qHW2y7qaqV1KxpQQHYhspB4m3BjCmh0veUpRLmvOM51X+2Zpwr1RAjBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flCqHk1m; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7930132f59aso308345b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181227; x=1761786027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysnAf5Q6/F37oVxnktahtq8MWGwMsYn3elO8YpXbx58=;
        b=flCqHk1mDLdG9p/ErVgof8Zm1i7YjDT5YgjAFh3ysADTpr8bR5SXu4xYq1AHEBi3Vc
         3p/19KGyH1ABCaoQHxQMeZjEWLgylM5wNjVJv0/dJEyYQpayiz+fLd275/kq99Gan46n
         8KkQ41Ny9HrlivebrJuY5a0BARWuYbmm0MvoO7Hn529x8SCHYvmaK5RFV5qkOq/satQx
         OxdRSOduuVDIat+TDTJA1Ne0byneZCYPyGaGuOLpphlOoKu3152D/SJjDcPiQh5dC5Ap
         eDmx9Hz4Honp21eveZbxYi4XU0vuo7jRaJAVRYSpZ/BqlI/mHKFqwzs7XmQfs7qTB5/S
         bkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181227; x=1761786027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysnAf5Q6/F37oVxnktahtq8MWGwMsYn3elO8YpXbx58=;
        b=Ui8DswpK9tRwGKZxfLJcyxixJJ7pjmV7sNpGqCB6V/Is+yEsU7aulPpZZq/ZpVZ1a1
         e04Pmwm8y5tfHn2lkDAxkqhkCnI0U5fmxl9hLxX0JuojqxXvujDscS2aUN3HbM+XU8UI
         td4zk+XV+i2bzxe1fWaXmtLcAZJcO7oR/Lnmek5Wna7pOhUXKXazYlvjI0TxsgzMCStr
         1pjlmNha2vFmTVs4B/Fh525+EgCVmxJOxDLhq/AZ8zsUg95sNbovhFABgYxGl0wCom51
         3K7ZX6fcdZ2b2Q/I69ZH8CdFRlema3NyhOcaufORFINfqhcCNWRkPC4+pR+56dnWlU1q
         sC5g==
X-Forwarded-Encrypted: i=1; AJvYcCWj1IvOKwzmDwuAJJjU+jyb72tovFLydoofsLXn2BCDdNAEpVTt0U2H2NjOPIYNX3neEW6QNB6BNmbEUHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZUn6+VLZv2OWgQB2SDjERyOH2vtHUUIoZ7Pbor4UMcHjJr1bw
	XC1kgRzzUc9XaZuz+9tr9QI3HZ14gUwAOZ5C/7qIZ4K6MmJOgBm4LJKv
X-Gm-Gg: ASbGncs83lH0EV1UfRy/tYQ8pAQ5Z+HYeemqqN629RBkZwzJ8n7fs2a/TQXK726OOio
	yxpzEaJCdtm84ZqoZflE4Snmzple4jHBXqMgzqGwTTm4OlZrfshawfgGo8WJIaW89YcJbtQdZeF
	ZslBDi8XZWW5ecUOlS7LlQiZP8GUllTJarlCNfUNlWdg0nkDMZgzbt14nR1V3RtdTt1ezuVlygK
	RlssH3xFi75QLgwisRE4itNWML0nGPog2wxxJttA0r3p4lNU60ohVJxRAIC/Xh2GYDzRYR/VnKg
	VN7AmRGDRVB11UtJ1U66tbaFij8oZpv9pjOXi80Vmjn4WBE3/Ka3/YYTynolNrs2OEmkC/9eVk2
	McIzrvpDo8nQEzXEiOSkz+UfExwleUx5y344DyUt15YOefNmvNZDkInrcjMbTdUKZEbvOwOAqBz
	y1AlaXX5xr
X-Google-Smtp-Source: AGHT+IHOazPmZapnzVoec11my1SEQGOMvfwZs/K9HZJGzOPAxbA0ZzCZ6eN45sS9QYFtvW0q4Wovgw==
X-Received: by 2002:a05:6a00:4652:b0:77f:11bd:749a with SMTP id d2e1a72fcca58-7a220d2330amr21377015b3a.20.1761181227244;
        Wed, 22 Oct 2025 18:00:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274abf6d5sm563573b3a.33.2025.10.22.18.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:26 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:07 -0700
Subject: [PATCH net-next 03/12] selftests/vsock: reuse logic for vsock_test
 through wrapper functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
the vsock_test binary. This encapsulates several items of repeat logic,
such as waiting for the server to reach listening state and
enabling/disabling the bash option pipefail to avoid pipe-style logging
from hiding failures.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 131 ++++++++++++++++++++++----------
 1 file changed, 92 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index ec3ff443f49a..29b36b4d301d 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -283,7 +283,78 @@ EOF
 
 host_wait_for_listener() {
 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+}
+
+vm_vsock_test() {
+	local host=$1
+	local cid=$2
+	local port=$3
+	local rc
+
+	set -o pipefail
+	if [[ "${host}" != server ]]; then
+		# log output and use pipefail to respect vsock_test errors
+		vm_ssh -- "${VSOCK_TEST}" \
+			--mode=client \
+			--control-host="${host}" \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest
+		rc=$?
+	else
+		# log output and use pipefail to respect vsock_test errors
+		vm_ssh -- "${VSOCK_TEST}" \
+			--mode=server \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest &
+		rc=$?
+
+		if [[ $rc -ne 0 ]]; then
+			set +o pipefail
+			return $rc
+		fi
+
+		vm_wait_for_listener "${port}"
+		rc=$?
+	fi
+	set +o pipefail
 
+	return $rc
+}
+
+host_vsock_test() {
+	local host=$1
+	local cid=$2
+	local port=$3
+	local rc
+
+	# log output and use pipefail to respect vsock_test errors
+	set -o pipefail
+	if [[ "${host}" != server ]]; then
+		${VSOCK_TEST} \
+			--mode=client \
+			--peer-cid="${cid}" \
+			--control-host="${host}" \
+			--control-port="${port}" 2>&1 | log_host
+		rc=$?
+	else
+		${VSOCK_TEST} \
+			--mode=server \
+			--peer-cid="${cid}" \
+			--control-port="${port}" 2>&1 | log_host &
+		rc=$?
+
+		if [[ $rc -ne 0 ]]; then
+			return $rc
+		fi
+
+		host_wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+		rc=$?
+	fi
+	set +o pipefail
+
+	return $rc
 }
 
 log() {
@@ -322,59 +393,41 @@ log_guest() {
 }
 
 test_vm_server_host_client() {
+	if ! vm_vsock_test "server" 2 "${TEST_GUEST_PORT}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=server \
-		--control-port="${TEST_GUEST_PORT}" \
-		--peer-cid=2 \
-		2>&1 | log_guest &
-
-	vm_wait_for_listener "${TEST_GUEST_PORT}"
-
-	${VSOCK_TEST} \
-		--mode=client \
-		--control-host=127.0.0.1 \
-		--peer-cid="${VSOCK_CID}" \
-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
+	if ! host_vsock_test "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	return $?
+	return "${KSFT_PASS}"
 }
 
 test_vm_client_host_server() {
+	if ! host_vsock_test "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	${VSOCK_TEST} \
-		--mode "server" \
-		--control-port "${TEST_HOST_PORT_LISTENER}" \
-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
-
-	host_wait_for_listener
-
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=client \
-		--control-host=10.0.2.2 \
-		--peer-cid=2 \
-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
+	if ! vm_vsock_test "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	return $?
+	return "${KSFT_PASS}"
 }
 
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=server \
-		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest &
-
-	vm_wait_for_listener "${port}"
+	if ! vm_vsock_test "server" 1 "${port}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=client \
-		--control-host="127.0.0.1" \
-		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest
+	if ! vm_vsock_test "127.0.0.1" 1 "${port}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	return $?
+	return "${KSFT_PASS}"
 }
 
 run_test() {

-- 
2.47.3


