Return-Path: <linux-kernel+bounces-891564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B4EC42F32
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E98D3ACEE3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC6233D85;
	Sat,  8 Nov 2025 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2nYmmAi"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB720E334
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617714; cv=none; b=B/g6q5xZuvEodo4XX50ZfgzK1mqhHZ7+j3+LayWcB4PsQd1Uuwv8pZnZ1g6QXIvjUBuwpgaoZpL9TgcDGFRUZLsO9tfAGS/wm3IlCI4bEaoN2lqLqNSJElGp6fto6pRBi4lPZ6bjYXFqUr4kXncVBmuf2o7IQ4IJ7BWN03o1N58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617714; c=relaxed/simple;
	bh=KaZPXYApVo3gzuCQZxOqqdj7Oefz16QZ4HcopRgoUyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SgMJqlulPgcRc47h8fjDZPSPWd2pFUHO0ZLcSg0HgTb+7zuQ8w0nECrQbVZ4vVoQ1OUMbQspJ837MOSXHhKl0MtiAW28dgo1BTI8h4wkIHKVnSkFdpuZZLrTAqvjJln1WfArlStDenoUKj0acHU6bhH643s2ZWJbv4P4tWtre8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2nYmmAi; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-340ba29d518so1088694a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 08:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617712; x=1763222512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuFcuN4dciZC8eK8448U1zaLcwyfmGMtaq+xAMSDgTg=;
        b=W2nYmmAiA/Ru3TG/OkEGb4o7wuwewiw8M/MCOegkyCdB7IoXzVcJqZiMi0W18+3REV
         Oic4WsypsL5oZmUtDYoZOBoEYkTNo38GCLY73dOmrtSK/DPyZayF56ZEkpEsVbv6eHfX
         +gnXjpJT3di0TZFNH42qb9UUUwgcUGgyw7q8WjEDr+hkDGm497YgNJhgGGDrzgNvyfQb
         JTnGMvFVf7bFjTGyQCImuABdUZ9TaQCXkVYXjVn/qbi7vPRgunSYFkTDznkGpjeKJjRu
         pP1pa4U+mkfRe/BQ9ugslOiWzEBU4XteDFCKHmkUjTu6O25eIOcFTXUyr6SCLVghz1rm
         h7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617712; x=1763222512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KuFcuN4dciZC8eK8448U1zaLcwyfmGMtaq+xAMSDgTg=;
        b=pvAWbL5G2xaiHxXMSy7LYJ4hqy5ICBSfE+0apgz3WX/iVNlE9UTmRFoMfoxSNr0h7+
         isqiVCWUWlAuFfIWDCZ+pWnRAUoFjkuCeMsHkk9+JznD6w2730F1NuRuoLpG/aY9TGWs
         ff8SlEye5l1ASm1nX0pXvXpuprsY9LqJY8ZBf5jhhJtOoL+jY+TFG/eKa+3Hh7q9CA5L
         v/oeUDthNgr/eD2Qr9EwmvgR7WBzR9ym6jTQt7MdnJnbsYZELCU2X2izJjHOIubyDjG/
         74Pkg9YvrxwURT9nNJ8Kydr4JnXZcKGqRRrzL9gH/fFQLYXKUClckoH+9aH1LD0nO0qF
         qqhw==
X-Forwarded-Encrypted: i=1; AJvYcCWXvA5GtLpZKmrLPIY+M+N8maskVBRCb3x3LvIUQmphFwmD57NzO6yIDn7Vul5iCQhwmoDpoFir/imioNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysTKEG9gWGkfJetLYt/Qe8kC9eI4nIu38ID3SHuqB6gaH80nim
	nZmfEvINwgz1LE0+oz2OgHtJLP63QaZltQI8xZche0oUBXXerCOBLo5F
X-Gm-Gg: ASbGncs78pbhNWu+orVZE0jbVaZ9yjJqqGtld2xRWLkcrqxGQxtytYOZXwI1Qq1mEM8
	TqIg0j8kaB28HP1U+tc6C9W0NEj6kBH6smvIlpBjOu/T/G0Wg96IwUT1xNjnIeWTqSM98EHXRU6
	MM5XcdEdte3wayAiHeLQVz/DfCYpJRmYa00Oa+l/LZsJp3sQaIeVvhW8z7iFx1c+1cvNXwG2dNE
	4308UDtkJ0EkhANzuBnSBwp8bYomciYDQsGiiKbpAZbgHmRuC7eY0T2eiF46ACHnT8bvw/01GzL
	hM3OCkyGD4CIePokBZliHewPnxtkXD2Kvd5TN04SJhAPin5tMZBCNDB/iqCaW4/Bgj4XYSc3GzR
	Y+RXAkcql354/Us1py0a1/NdUtMmcKao2YNTvBSK+Sg4zahS7V8qvny6EXbICi7FCWXdR2zXdgA
	==
X-Google-Smtp-Source: AGHT+IFfAGmgLKI4wsdRP449UjnWCEHQ8HjRd06GWOlMDD2Oh5K2oGmSXaRp75cZh2HiCmppgc3Cvw==
X-Received: by 2002:a17:90b:4a8d:b0:340:f05a:3ed1 with SMTP id 98e67ed59e1d1-3436cced91fmr3307290a91.21.1762617711672;
        Sat, 08 Nov 2025 08:01:51 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c30b96dsm5767493a91.5.2025.11.08.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:51 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:52 -0800
Subject: [PATCH net-next v4 01/12] selftests/vsock: improve logging in
 vmtest.sh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-1-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Improve usability of logging functions. Remove the test name prefix from
logging functions so that logging calls can be made deeper into the call
stack without passing down the test name or setting some global. Teach
log function to accept a LOG_PREFIX variable to avoid unnecessary
argument shifting.

Remove log_setup() and instead use log_host(). The host/guest prefixes
are useful to show whether a failure happened on the guest or host side,
but "setup" doesn't really give additional useful information. Since all
log_setup() calls happen on the host, lets just use log_host() instead.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- add quotes to "${redirect}" for consistency

Changes in v2:
- add quotes around $@ in log_{host,guest} (Simon)
- remove unnecessary cat for piping into awk (Simon)

Changes from previous series:
- do not use log levels, keep as on/off switch, after revising the other
  patch series the levels became unnecessary.
---
 tools/testing/selftests/vsock/vmtest.sh | 69 ++++++++++++++-------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 8ceeb8a7894f..bc16b13cdbe3 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -271,60 +271,51 @@ EOF
 
 host_wait_for_listener() {
 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
-}
-
-__log_stdin() {
-	cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
-}
 
-__log_args() {
-	echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
 }
 
 log() {
-	local prefix="$1"
+	local redirect
+	local prefix
 
-	shift
-	local redirect=
 	if [[ ${VERBOSE} -eq 0 ]]; then
 		redirect=/dev/null
 	else
 		redirect=/dev/stdout
 	fi
 
+	prefix="${LOG_PREFIX:-}"
+
 	if [[ "$#" -eq 0 ]]; then
-		__log_stdin | tee -a "${LOG}" > ${redirect}
+		if [[ -n "${prefix}" ]]; then
+			awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'
+		else
+			cat
+		fi
 	else
-		__log_args "$@" | tee -a "${LOG}" > ${redirect}
-	fi
-}
-
-log_setup() {
-	log "setup" "$@"
+		if [[ -n "${prefix}" ]]; then
+			echo "${prefix}: " "$@"
+		else
+			echo "$@"
+		fi
+	fi | tee -a "${LOG}" > "${redirect}"
 }
 
 log_host() {
-	local testname=$1
-
-	shift
-	log "test:${testname}:host" "$@"
+	LOG_PREFIX=host log "$@"
 }
 
 log_guest() {
-	local testname=$1
-
-	shift
-	log "test:${testname}:guest" "$@"
+	LOG_PREFIX=guest log "$@"
 }
 
 test_vm_server_host_client() {
-	local testname="${FUNCNAME[0]#test_}"
 
 	vm_ssh -- "${VSOCK_TEST}" \
 		--mode=server \
 		--control-port="${TEST_GUEST_PORT}" \
 		--peer-cid=2 \
-		2>&1 | log_guest "${testname}" &
+		2>&1 | log_guest &
 
 	vm_wait_for_listener "${TEST_GUEST_PORT}"
 
@@ -332,18 +323,17 @@ test_vm_server_host_client() {
 		--mode=client \
 		--control-host=127.0.0.1 \
 		--peer-cid="${VSOCK_CID}" \
-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
 
 	return $?
 }
 
 test_vm_client_host_server() {
-	local testname="${FUNCNAME[0]#test_}"
 
 	${VSOCK_TEST} \
 		--mode "server" \
 		--control-port "${TEST_HOST_PORT_LISTENER}" \
-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
+		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
 
 	host_wait_for_listener
 
@@ -351,19 +341,18 @@ test_vm_client_host_server() {
 		--mode=client \
 		--control-host=10.0.2.2 \
 		--peer-cid=2 \
-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
+		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
 
 	return $?
 }
 
 test_vm_loopback() {
-	local testname="${FUNCNAME[0]#test_}"
 	local port=60000 # non-forwarded local port
 
 	vm_ssh -- "${VSOCK_TEST}" \
 		--mode=server \
 		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest "${testname}" &
+		--peer-cid=1 2>&1 | log_guest &
 
 	vm_wait_for_listener "${port}"
 
@@ -371,7 +360,7 @@ test_vm_loopback() {
 		--mode=client \
 		--control-host="127.0.0.1" \
 		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest "${testname}"
+		--peer-cid=1 2>&1 | log_guest
 
 	return $?
 }
@@ -399,25 +388,25 @@ run_test() {
 
 	host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
 	if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
-		echo "FAIL: kernel oops detected on host" | log_host "${name}"
+		echo "FAIL: kernel oops detected on host" | log_host
 		rc=$KSFT_FAIL
 	fi
 
 	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i 'vsock')
 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
-		echo "FAIL: kernel warning detected on host" | log_host "${name}"
+		echo "FAIL: kernel warning detected on host" | log_host
 		rc=$KSFT_FAIL
 	fi
 
 	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
-		echo "FAIL: kernel oops detected on vm" | log_host "${name}"
+		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
 	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
-		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
+		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
@@ -452,10 +441,10 @@ handle_build
 
 echo "1..${#ARGS[@]}"
 
-log_setup "Booting up VM"
+log_host "Booting up VM"
 vm_start
 vm_wait_for_ssh
-log_setup "VM booted up"
+log_host "VM booted up"
 
 cnt_pass=0
 cnt_fail=0

-- 
2.47.3


