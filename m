Return-Path: <linux-kernel+bounces-863861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF42EBF95EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DF824F5E18
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E85C2F83A0;
	Tue, 21 Oct 2025 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWc1v91H"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B894E2DCF4C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090432; cv=none; b=PzlVLjh/Ry4LNeBT+zGr4/EMwkLaHdkTZkPKM0Tu3XAKYeZvoum0Q94UXs+vi0ukfoW3wAuouZT+nmojvDkK3Zd2iedDh4HaY32VfHTb04X/LaqK7/kRD1caOqYXkft0y/1ADDMVv8dBDprV1MaO6oEH/pcYeS2MeglC500k7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090432; c=relaxed/simple;
	bh=bLgJRj0B3l4I9LRxTwg4ipTz6i5xRpftUXJZZBIn7VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pyz7S3pRPRKeiKnJqvmsVPB/nuJhnBCNKkeE/R9tk4o0D+XSL9V0Pkh1L51z7vH94opVHkJezKebzMs/0Q1kcR89UpdR6YFFpqvCfJdMlMb6H5iZ8TTgYd2anVHgHlAT4PP/tSaJdyxKv9vaWF7eT40dBUJwOWF2OH+VqDuY2r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWc1v91H; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so8063044b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090429; x=1761695229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysnAf5Q6/F37oVxnktahtq8MWGwMsYn3elO8YpXbx58=;
        b=WWc1v91HrI0aX0IVlRuS9CMwS78uNFi5IhWxvqoBKtmul+3fGRFloPkHbfh/QwQnqE
         Q7JFpeMIHePBAcMlQMy0lN88yIXcm2r7p4J6Xtv8PVqfgsB7o5ZsgCxjU+HwiTYsAdry
         S/WT2cxKpMj57Ta/9D7Z5+jt/0Wa/3MbWkKDDFGoSy1z/rlcH0D3dTOgFeN8ER67qf2S
         Pb26dukHqsR/6lZ/tDbLmJ6f6TlbCA2vnRIGJa4Cvc4iuKZOnAOU3F2IyKxLy4rYaV/C
         JOv6BDAFJbZnyWoPrKoOzqkaAFluha74bd3zhwCTbcicdLM232cKgi3PjhORkIbIvn3J
         844g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090429; x=1761695229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysnAf5Q6/F37oVxnktahtq8MWGwMsYn3elO8YpXbx58=;
        b=vmK/vdNz9lPYV1E2L/JCDg/caDB4odNWnetVk+XQki148HzmzxMlh0a8xJV5bKkz2u
         iCWQ2w2giVU53OfVanAJhBHsQ2lEGJlApR8bNyI0a+TlwpWvMkHiVGi2Z5xQFPwI/Fey
         tVsJEQrigxS3VIiwFXibCKMA8A5473mcROFUjnNKZW/jqTTGVSSDFiT4Vouhqv+/GkEO
         D8RjJAWOnrXcK5P5/P6Cv/qAc8Io/ZjBkn8hw4/BeCVwMQq5erKEcRyaP2S+AhoIudeh
         1Hqj02pRxYhSVYRcLVZquwMgzl9Yx+xzUyV7fQsvhydvW9xoF0hNQ7mzGHBwAszNYR+7
         jRdw==
X-Forwarded-Encrypted: i=1; AJvYcCWTLKojRq6WtZw4lwvNFFCd0N8IXIT3dmYJ+PkRONntqv3eKiwIsyE1nOmlkavQJVS8EEVCnr0Rqutoz2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT0Q6TX8ds/D7UcpkJ85NKdiKRThs/oYghhgsIdYL1Fl882pAT
	XrgpjalIefHqn8K7H37TAqd0lOV287Ns05eJ0xCtaUyDWJo6Ls7rxDsJ
X-Gm-Gg: ASbGncus/764mrAAP4atXZpXzulmtr+R/zIWihmhzKwzAXex8Tvrygi7+ZgqWnjyq7n
	6RKB8xfcupDvwdDo8NbpSOFEzzLLT+kJeZ5rCRAqIVxupH0BP31UECPkKtkNL+ub0ehQup5gS27
	GVzln2XlUPOnI4cTipVLP5eKPumsHUe3RD5igZm9oPfu+vCTV2Hf8JQDG2AY71Q5kZNiE2OvL5u
	U51iJ68un621rXE0JKxis9gy8puuNbzr3ubxFTuFbp+pkNX0hdxLwz1ip7wZRawSeajJOzFLmqN
	WyVulhuG2DDoEsSnXUoPKLoZeaA+0qnM39+g1+i/sUGq8DHrgKoTG4ckXIX3z52q9zn3cIHNcsR
	HB3IZoHMgApfyMdCmVobIDLBGqsDqxJDF81K++EyR5umi4sWK5eEPAL3zcyOvcqaIYQP4MVoZ
X-Google-Smtp-Source: AGHT+IESeY2Sh9LyXvlNWSBcoIwZ1r/2aMHLIXNnNKYEULemMRlMzJHh0W4ok0D91ZgsuVhYMMaokA==
X-Received: by 2002:a05:6a20:1611:b0:2ae:dee:4ba with SMTP id adf61e73a8af0-334a85bb208mr23055148637.50.1761090428628;
        Tue, 21 Oct 2025 16:47:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff5d76bsm12490315b3a.33.2025.10.21.16.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:08 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:53 -0700
Subject: [PATCH net-next v7 10/26] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-10-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
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


