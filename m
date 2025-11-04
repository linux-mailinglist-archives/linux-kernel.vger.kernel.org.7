Return-Path: <linux-kernel+bounces-885538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A024EC33425
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172744280F7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6A2346FA8;
	Tue,  4 Nov 2025 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpGdT9ZZ"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58C131D741
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295955; cv=none; b=YYold1Uznapvlgp8ukrrJpdKSnIvZ0v1X8NbgCro9akyM1qCkNiMFrtxqExPp3Hj2GJkJtdVPo9+QZ7uWsuxZ8UT9BQz7A/zivHPK7kEezIiAgCAUnK7gAlB2KBSPsoSLMckjU0GWU8Me5yX8CkS+upgvT0mYbmAYMg+/rP5FrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295955; c=relaxed/simple;
	bh=/8284WgqZBkmvYo7p6HbzA4BQ9SwpvVlj048Ne45Jpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K9kd3QQ1FeGvRcuU5+l0BIXvLHFJFBavyqLjmzw+MoaXPa6Kzv3x+jEzB7tZvuLnM9Zjgq6O9j42Dk5Id0UknOeHn8rLdGy5IkMJwWEzO/hdmGdksnEdfxL4EtODqt61/S4YfluvrciWAlujN/et+QuM3wBrSaPu/+4t/m/ovlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpGdT9ZZ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33067909400so4336918a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295952; x=1762900752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZp+C4CcVFJXBROG1xENTNsT1iMwKGcBzeNVL/tTmVw=;
        b=HpGdT9ZZSUGCLKyD1inkdmnlnbkltkD0Q4GGENk3x2FP/lJKQ3wUVv1HHiLHHKJOs6
         R68ku1OWN2PdHS/5S7qX+Cmpbt+MSaGjNm7qmkeL2wxKxELCH6lCubqQ5f3u0hFDePLy
         lr8VvhQiZdupBi5wZYTeLrUGrmEp5sb/cQSOdFKlkjVRasYgET2h4Q5uY2uxQrpyp+Rx
         fxL6tcDMCdULiTtFCTU2kLsL8KI7nfiPBavXk5eallKdpJKqI2yIw7naRvkOoRyqn1+M
         pwiAwsPKkzZPUX7mA82sV2S6D/HvkQufp9p3caNcTeg1nEa20xS1XWLOV6HxYLMsxBDB
         Ox3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295952; x=1762900752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZp+C4CcVFJXBROG1xENTNsT1iMwKGcBzeNVL/tTmVw=;
        b=vUXkoB7JuJFiCMRwtFxthkftyC9EBtOfY9/WIlw8X3kbKzez1T75ndKVUlz1+1YtVQ
         W1XAo15ELPMAzINj0PXwEhXmzsI2DQpWG0zA9zoyuCY3m+oE9g++BCH0GhuUkQHTeDQo
         /mj00aX4W3rb8U8T49ZLb84+fYWFM2hV0p49mROYuZjdcg44KyuhHYbwfZUTLI5ZDEeD
         0eviLDLz+jFFT2DIHq9p7Vf3fHulydZ2iwe2k1I9xWwvNt74ovfcsDEDiA4GZsBqOQ3F
         57aM1CojpIHJKmeL9ECozK6u+P81hwE0pV8viUhb6lBAabqLnLppe//wXkElmBXecxav
         bvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbgE9BR2QnVry8It8Jz24flRNjbI8m2BnKaSXwEY4L5kQwNp0QZKRYMKQJwz1kkWpztLXb/d1Z0TIKybY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCR+7mjN2QaJ0UPpcFIPgmdwI6uo6XhQrC1AwkuK0MvW1Ynivv
	dk0K0mSdokcDE3YY+v1r3xYBeW+APNt9wyFAS0NJMjmZNMFYzoLyQJHz
X-Gm-Gg: ASbGncuXK5+MNGiyTNjvqhqRN3BODQon2JmIs1LRgBxAyT44B4kHdXvyj/9WGHOX97J
	vyw8AXQ60RY/qATckp15Qywpz6MF7ickGWsP7dV5uSiArDcAKf6tugWqS+hBL48qYB+iD4bOWtR
	mVdukdoLOOd00ZmJpcWzGXMFcRktnmSutN0wjQTFBstjGENmXPlncgtgCJxUaZRqE5eKM3t9jpT
	qi92IWaNlp7/1+AjS4/sY6Ipv4BGnZOrXBFgNtvfa5K3Nt3GIlXn0qjMKSSmr/YbjbMOhvtI3oq
	JDLZ6mCZvIjk9MsUSFlNKbyOv721+V0op1gZq18hJU0XiHawIWcbNDvlsBq1bngYEqR6yL3fwsg
	7llribKw7lY8PCD56e+EqUCyIUjQVbx42kOwTNkv3F9ZjFlWW96WwnFKiq8w+i0NdO6nz33LLQw
	==
X-Google-Smtp-Source: AGHT+IHtBPG9OeMS+uLaPZ7VQjgXPmnJkhyPQNwSqGa6hD901ItTF9A+GhcbDo+Uvew9U846BuIvcg==
X-Received: by 2002:a17:90b:3751:b0:341:194:5e7c with SMTP id 98e67ed59e1d1-341a6dd6953mr825767a91.24.1762295952118;
        Tue, 04 Nov 2025 14:39:12 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f18315bfsm3432766a12.5.2025.11.04.14.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:11 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:53 -0800
Subject: [PATCH net-next v2 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-3-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
the vsock_test binary. This encapsulates several items of repeat logic,
such as waiting for the server to reach listening state and
enabling/disabling the bash option pipefail to avoid pipe-style logging
from hiding failures.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 130 ++++++++++++++++++++++----------
 1 file changed, 91 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index da0408ca6895..03dc4717ac3b 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -273,7 +273,77 @@ EOF
 
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
+	# log output and use pipefail to respect vsock_test errors
+	set -o pipefail
+	if [[ "${host}" != server ]]; then
+		vm_ssh -- "${VSOCK_TEST}" \
+			--mode=client \
+			--control-host="${host}" \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest
+		rc=$?
+	else
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
@@ -312,59 +382,41 @@ log_guest() {
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


