Return-Path: <linux-kernel+bounces-889601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80189C3E05C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E893A87D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8432B2EBDD0;
	Fri,  7 Nov 2025 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYz1WX5I"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EE02E54A0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476594; cv=none; b=I4X+3TqnSjKW6RNuqpSyOMPo/0/5PXeiSzyy6XZQkYq7k0cSe8X/DgFN8tdVq+ZxJWPCb3VdYEhPw4Iuv08RumweQ/PlSNP7/YlzDXs7Lmbo6bVvehGKNtetxwjrasuIUN5fu4f0fM0tPsrR8cAmNJVYVT5m9EGpJ8A2KN32S5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476594; c=relaxed/simple;
	bh=Ys5kBUskDbPXQZnAqEoqIHnHJo/VOJneFvummyPz0NQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PRV4OOUd9FOnSAl6Ogu4mI00MHxVt0cdYZEqP37K8dnDDox+EGJqBwPH0EjnuOYwhfl8WkpC3tE/8vUBIFUtJkJcm1qfR8sMW+k5DUXb4x+hhGu+oCuQIe0peHEenwgvOExni7D5mH3UJ3qOlnmWj7F/2Q0wfYoWmNVoPFux2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYz1WX5I; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so306282b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476592; x=1763081392; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=St8d3RKISLkpZB5VPbgJXeIsZTPVvYqYQ1IGyhr4/ek=;
        b=GYz1WX5I1lKfO61vDYd5G1oNF35/yGUS5n24OQHoL/TEnz3df5v4/c6/tHDam45MbL
         oq/oIi/mF8tAdak/e24OganHwgmAwcMWMQxlKJrmfrxNa+VYyNPF7hJMIAOWFy/Ay7+p
         gbu00auWSFixBInWP/sxF3PwAQmfM8soHk8La2Px3GXHwRMFQdfeWaKed6zVbeyXOfdB
         ZkcYoBehN8diSfv/WvDtAlJ8gEXpNS6Pb/MTgYVapEMBieaFEeaKWs75pUpAVY9Q8Jd4
         mZEq8a4ifiqIUX7rnUynkDsgwgQkuAvvy8znvdrHReDQGs6aKKpY/k3osknrD09HJe5Z
         dsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476592; x=1763081392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=St8d3RKISLkpZB5VPbgJXeIsZTPVvYqYQ1IGyhr4/ek=;
        b=VNU/IJBai9ukvRVyfWzMTqGEllnEEatuaWnxW+/sbKzv55hMAUZbVbeOjR/SUOPa/6
         XxMw0wGfUQUyiZAWioDmgVXRmpHSjef5VvEXdnygMHZZzdOI1PNRWGqqgahQrTbvchyr
         zyMPedsRNpa0E4BKsTDNl7c1fYjalTKbbZmM9LtTWctTblmXIlSQWl9YA/xyHUtFb8sH
         7XIrgkglVbNUz0RSwXj4duUUj4d4g1V1dyDoBJK9Sxp2In+t25d5kALqokIVsqrjYTMp
         lWV3rYrYRU30c2l4a2Dx8XgIVtW0E0jkRTHeKWfKGlaUplwQ7woYx6dzL/LEMF8a9fUV
         Pw/A==
X-Forwarded-Encrypted: i=1; AJvYcCWexCWOcIGntxuy0RdXDoLsAfeSNRmWucRuaNMdh/FQvyrklOOnJTQGklcTHyeNev+mPz5jdUVCUbeV7dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6G5qGGZgE3z040rXgYbbOkbYimO/8jgzVLM3/8UZOCBxwJFco
	o0wdmFdxdloyM9cawmf4Qw5q0PRb7THAa0zo7mr/lPGUJFZ5sl7yywMm
X-Gm-Gg: ASbGncuFO5YGi5TYgYJp7NTrgRNSqKQW4ztzB03crKSkE4tG046TxniOhwTBSb4jn6Z
	KH0PwpqQGTmiCOcV8kuGOpZAJOuh+bipgdqna68u7TS+XdcsEpgHP9yDCH7zFoSrHwDIK37/SwH
	IQuD02Cl71RtD6+v+25hSSeSCT0+XIZR6GvPwuVAPP9Pcr2cxxpUcaqfz5GNaLjoYsNN/xFabI9
	3HBG61El80f3P+gndHiYFbYotYqVEIpqAq+XZyMjRhwhXw27BMei3XLx+cXtgXW/3W88gD6x7JJ
	Vx59XpqJLeEwHoW/ilJ08HvItKWuptSerVhv9LD46DnqP95r6fgddDci1Ce64tiVICti3SuDhzo
	bcKUjPmOVi+RmYgTB8vz0frloNHcqjbSgNoDeGkBIUD+Ry/KUs62xiX+vP4SfulixJzMNIFUxHS
	REv57YHOI2
X-Google-Smtp-Source: AGHT+IHCKDXAldqg2joCiE35wH1SeQuDpvf5hunDzrqzuBwb8N3icQ5Tp5Ef7NQZ3yBDhicNR2g6/g==
X-Received: by 2002:aa7:88d0:0:b0:7ab:5d1b:2d18 with SMTP id d2e1a72fcca58-7b0bd992dbbmr1615280b3a.26.1762476592224;
        Thu, 06 Nov 2025 16:49:52 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff8538sm848318b3a.28.2025.11.06.16.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:51 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:45 -0800
Subject: [PATCH net-next v3 01/11] selftests/vsock: improve logging in
 vmtest.sh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-1-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
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
index 8ceeb8a7894f..54bae61bf6d4 100755
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
+	fi | tee -a "${LOG}" > ${redirect}
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


