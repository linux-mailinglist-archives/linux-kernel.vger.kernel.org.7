Return-Path: <linux-kernel+bounces-819754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842EAB7E3BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2871C04194
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBBB2F744D;
	Tue, 16 Sep 2025 23:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUUdTCKi"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7EA2F5493
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066247; cv=none; b=nmI9OB3eiSaNviS7sk9CBn0T5OX+JkTYU9s8kgb/B4MkR1mZAslHyc4rjIRZb373OnVz/yZdltuZ/JYYk8UPERPBJpwzxSZS3Y9vYS4qaSglNjJUOOKFe42pQc97ZHmHoZQobCmD11XPOdNIZfKhgz0JixOFjO2yw/o4xRtK0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066247; c=relaxed/simple;
	bh=BquwX6HjvEBxZ0NOdjFPMl3JAQrw/BuuZkbNRV5kNDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kVP6KIxghHx5faePxAHbkRtjMLFZkYmIf7yB+Ret8wQzCJ2Pkkj/y4abzEpDW8+n81uP1t7quK10Wsjps7z5NSL8PrATPT4VEH6cSIHPn4klTeVjzYZLusMJx0IxiMy1j5ji6+qBOtVsiQUqGsZGNJLbo/kQKBH7wHpcuY6hJeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUUdTCKi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-267fac63459so5080435ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066244; x=1758671044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YyzkIGkPcN4s/5n8XbmWu5wXR7Mhh7fBZ/cTvP3v7E=;
        b=LUUdTCKiJEesPFtxzdNKrPM08t1j59Bcax7x4SDqh4xmTZmyGrfbEk1qUoqBRQEJ/1
         7/gDLyv9CMlZm2vtGAwphO758G/U8jiFfcBwqCNn31ovEDG9dcbqFO0LOWppOXyZxPcF
         gJFNaJOJxb9k6gN+pGsZQ49eHDCgQLwDSAHZspxGIxba9iNI67O/gYL0QMeeRu2zPtpu
         1lWKBbzhN04XsC3z/KcMCPTUjy38A2MvV/2UEujcZ3zVhaNtoeDB5GS9ahxmI+gpjjRa
         loGMFHCj/HBz5p1NA60rUdPixe3ujO3iicy3P6nNS3XJ45X3+0dNyacUiSjfCJMurvYR
         RlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066244; x=1758671044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YyzkIGkPcN4s/5n8XbmWu5wXR7Mhh7fBZ/cTvP3v7E=;
        b=emMUT7GbFd6VZ2734xo2aWvBfNjxFERblE0ARnuXQngfeQ9GESw3ZYLfUbFsna7/nI
         1AqqUfP2uNRuIGUyj61L97Q+h64ShOXTrnUyHfPnAlWlO0AunuZnbIeG4asz0tdpcgW9
         xQnnIwTF6T032ev0ykCIdUOxJD0STVHJWnhnceslXFGQCJ3J6ilEQQYAQku/yNE7unhS
         Pjh+PONwYdGi1inIdGJ5OEC2bXlHwSKQaqLI46K05+Vr8opw1LYUotisyW7wNvkoOH7d
         SK5l7cx3GT6drW+bIMZjduKKbrorwsCJbQIVwAFxN9MLlWTtQWnr4p8Z6AUQpgYnyt1P
         OrfA==
X-Forwarded-Encrypted: i=1; AJvYcCXHmhyyH7+nec2xI+pdLwYmZMqH/bgPfhd5y5Xpbq7V5AT2QoBR+lU1IHxHpgthBrPDMxmvkIDDqS5Cuvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoeApkxVIubhL3rOMNmwyOlqv/y52oxK6xgtLaPKKfXQ0TZ6fx
	w+q+8oFyPVEzeN4EXzqy8SaqpA3pcbZGmjw3K86d5zJh1Bn+4WnQg/if
X-Gm-Gg: ASbGncswadiSKQNfZE5hD451RzXGzSoAeL/aVf30W+09WaziQwZ/tmG5sZ8fG1XaVcV
	yCPbLtvA0d3BsMptsMS8K8ubd2/hQR4GKo3VcMq6VEWxJOAPjXu868ak9+NSC79MGySBCfMtS3m
	8zqfnPBK72QScL/fzwhICGEzFfummBk9WR6QhvPRFDu+wXroo3V0iA+u0H7S4++yJrKLGU8EAKY
	rcsf4af/qBNjS91eKiKpk8yLcMqu2osmafxcDH70nEvLrdcrYFKWWRcZgkAZ3NNu4naCemT1BpX
	KW7hgHtGYfUA4nHpduUNDnP1cVohU+rIuFT3B6F7OrNPbxyKN1vaw0LNunkP/yx02s+nbECDeBh
	wSf/3qjP76xu+iSpaLmBm1PdibyeSEQ==
X-Google-Smtp-Source: AGHT+IGM0BGroUFsWn2Kv6PouQHNw7n3uA2Of13nBuo0577q7Fe2ucFSI7S3Oym5/xCIQAf+ZDsd3g==
X-Received: by 2002:a17:902:ec88:b0:268:10a6:6d72 with SMTP id d9443c01a7336-26812586017mr965905ad.27.1758066243929;
        Tue, 16 Sep 2025 16:44:03 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267e9372e86sm19646765ad.136.2025.09.16.16.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:44:03 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 16 Sep 2025 16:43:52 -0700
Subject: [PATCH net-next v6 8/9] selftests/vsock: invoke vsock_test through
 helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-vsock-vmtest-v6-8-064d2eb0c89d@meta.com>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
In-Reply-To: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
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
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add helper calls vm_vsock_test() and host_vsock_test() to invoke the
vsock_test binary. This encapsulates several items of repeat logic, such
as waiting for the server to reach listening state and
enabling/disabling the bash option pipefail to avoid pipe-style logging
from hiding failures.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 120 ++++++++++++++++++++++++++++----
 1 file changed, 108 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 183647a86c8a..5e36d1068f6f 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -248,6 +248,7 @@ wait_for_listener()
 	local port=$1
 	local interval=$2
 	local max_intervals=$3
+	local old_pipefail
 	local protocol=tcp
 	local pattern
 	local i
@@ -256,6 +257,13 @@ wait_for_listener()
 
 	# for tcp protocol additionally check the socket state
 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+
+	# 'grep -q' exits on match, sending SIGPIPE to 'awk', which exits with
+	# an error, causing the if-condition to fail when pipefail is set.
+	# Instead, temporarily disable pipefail and restore it later.
+	old_pipefail=$(set -o | awk '/^pipefail[[:space:]]+(on|off)$/{print $2}')
+	set +o pipefail
+
 	for i in $(seq "${max_intervals}"); do
 		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
 		   grep -q "${pattern}"; then
@@ -263,6 +271,10 @@ wait_for_listener()
 		fi
 		sleep "${interval}"
 	done
+
+	if [[ "${old_pipefail}" == on ]]; then
+		set -o pipefail
+	fi
 }
 
 vm_wait_for_listener() {
@@ -314,28 +326,112 @@ log_guest() {
 	LOG_PREFIX=guest log $@
 }
 
+vm_vsock_test() {
+	local ns=$1
+	local mode=$2
+	local rc
+
+	set -o pipefail
+	if [[ "${mode}" == client ]]; then
+		local host=$3
+		local cid=$4
+		local port=$5
+
+		# log output and use pipefail to respect vsock_test errors
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
+			--mode=client \
+			--control-host="${host}" \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest
+		rc=$?
+	else
+		local cid=$3
+		local port=$4
+
+		# log output and use pipefail to respect vsock_test errors
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
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
+		vm_wait_for_listener "${ns}" "${port}"
+		rc=$?
+	fi
+	set +o pipefail
+
+	return $rc
 }
 
+host_vsock_test() {
+	local ns=$1
+	local mode=$2
+	local cmd
+
+	if [[ "${ns}" == none ]]; then
+		cmd="${VSOCK_TEST}"
+	else
+		cmd="ip netns exec ${ns} ${VSOCK_TEST}"
+	fi
+
+	# log output and use pipefail to respect vsock_test errors
+	set -o pipefail
+	if [[ "${mode}" == client ]]; then
+		local host=$3
+		local cid=$4
+		local port=$5
+
+		${cmd} \
+			--mode="${mode}" \
+			--peer-cid="${cid}" \
+			--control-host="${host}" \
+			--control-port="${port}" 2>&1 | log_host
+		rc=$?
+	else
+		local cid=$3
+		local port=$4
+
+		${cmd} \
+			--mode="${mode}" \
+			--peer-cid="${cid}" \
+			--control-port="${port}" 2>&1 | log_host &
+		rc=$?
+
+		if [[ $rc -ne 0 ]]; then
+			return $rc
+		fi
+
+		host_wait_for_listener "${ns}" "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+		rc=$?
+	fi
+	set +o pipefail
 
+	return $rc
 }
 
 test_vm_server_host_client() {
+	vm_vsock_test "none" "server" 2 "${TEST_GUEST_PORT}"
+	host_vsock_test "none" "client" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+}
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=server \
-		--control-port="${TEST_GUEST_PORT}" \
-		--peer-cid=2 \
-		2>&1 | log_guest &
+test_vm_client_host_server() {
+	host_vsock_test "none" "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"
+	vm_vsock_test "none" "client" "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"
+}
 
-	vm_wait_for_listener "${TEST_GUEST_PORT}"
+test_vm_loopback() {
+	vm_vsock_test "none" "server" 1 "${TEST_HOST_PORT_LISTENER}"
+	vm_vsock_test "none" "client" "127.0.0.1" 1 "${TEST_HOST_PORT_LISTENER}"
+}
 
-	${VSOCK_TEST} \
-		--mode=client \
-		--control-host=127.0.0.1 \
-		--peer-cid="${VSOCK_CID}" \
-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
 
-	return $?
 }
 
 test_vm_client_host_server() {

-- 
2.47.3


