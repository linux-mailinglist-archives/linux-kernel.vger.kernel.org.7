Return-Path: <linux-kernel+bounces-885675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EEFC33ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A99189FCDB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3FE2BCF46;
	Wed,  5 Nov 2025 01:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4qTPyPy"
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC0B25783C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305814; cv=none; b=aS99PR7bRNnKqfB9upNI5rdFF5J1rO1q/QdPMaWLtnM04/5YpygyBBfbspvM+Pi8WMOJu6Mq3bOJO0s24d0VBQH3iUa9u3v6/Kvp99j01Hg4+ISg5RWylYXXhGLnqBcMiCX27oEwiNBLZBV9hRoIz+ElXQ76m8IKMpxjxREwKz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305814; c=relaxed/simple;
	bh=EUVr5JNK/GTAT1ttd11lgstVq87db7L7gS8Y83xgPYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nzi2j3aWgyoM9vB9sB7Drxz/Wk7TDQKPq7xR65yLPFFLqRBzwejcvmf2xuxidjSJzvzI7pAu+lO7EPKZNiedy2aNXqY5Y6wGnq6+IhVQIIC+c7xnDgMcIrTjzu09qGinGW7AmQR0h6xBBuOwthtWi3uLjb0oeAlk2g8cg44O4NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4qTPyPy; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63f945d2060so4469437d50.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 17:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762305808; x=1762910608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eVDPnkuv2SP94dsK2EFl5pOIR+N6oa4rL2rsMVs/R8=;
        b=S4qTPyPymyijDVhDyYOxTorfZgWjhzgv9UvEmkeogZrad0+Ni11qfJbH2VXOmsGQkT
         WSRN7s725oc7WScFEClLyvYtiHkMENn1NLLdRaZ0MlPXMKxMDTnnbI6dxo8PUonPPnVu
         Ia1cSW+GDU6XTsyY053c3jrI4HrViJipGWuQE92rDsVXIV9SC1MnG8Fsmnt3S5VDYCNj
         C1mrFIV8JWo0ScXI/uGmBiLLwcHcgEeW7l5Uh+zl6LOwSJo8A4usOKIiN7SE5hUbPBm9
         bPfFwN12J8klL5zDqH3t57kdeuhPmKjQERplVgBG0/dDL5py8YiVzmtrA5w+8o8GDzyc
         aUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305808; x=1762910608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eVDPnkuv2SP94dsK2EFl5pOIR+N6oa4rL2rsMVs/R8=;
        b=RfY4sjFPngIKfaA8shHnRHaPGPj5P4EVTMDzBEzloCQLJxT7wdFgAU+mbd1jfXLarO
         iJvoSpy7km3zobWb32JZTqd5muwed3afzchhfCkZlSvOzXguR77HWLimBoEaTvGFQp+C
         ZHPUZtvG2YrPXp0uGVsJhp3sXVyetxu7IrFA/k7KsBzYwW1p1igJi4r0PRBBf6SDHOhQ
         1/ixjazP8riV5S424DmwzDMOYDyiNzxN9E/Rka9PZ9gWxkBixEvei+8zWPu0nqRtNNeD
         aZhEFtZjFmPitUT28v2bmKh6QntYYbgXCZYKofvY2KhgKa9vcrQfPE/lD8BT/k86D7wk
         zwwA==
X-Forwarded-Encrypted: i=1; AJvYcCX8a0jaJgwk04bhZ4HVU8dzTgkHYLL08yzAHKT03rLf/owdyaLlsJ9sdICFtdXkJBYRpxUOUrPGjhBj0V8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznb1Iz6h75WLW2Xn9Cb05Yg925HUnu7oV+6RjLRFupteGhvmEu
	r6hPCDIuFimbH2I+w5Nr4C+MxOBvr9jwgO9zWSSJYpLk83bfuwqsr7CR
X-Gm-Gg: ASbGncsNFPcbiWmbatu/EDqPh0hNwOlk5Kkd+Dr6ig5wXEl5b9KNzhnFbU93+lajGBy
	wYMK9Bx8WhBlbTAdVyffdIS+wr78GV4yx7ZRIhZ4WnLwS3iKLAXH8XrGiWp73URuVjK5veT2758
	0/32qdS+0hMkBJLpGpLJsV1wVLsNp0BmBQS4LRVKN1apLP1eEAXiQV4Agu+uxkjpUsivYnhRFMB
	RP77GXWau7A42YeuXsIqPSjYqwMdMcLh91bI0WVqOfpFSgJ7pKW88ANsjfSCY3DsfRkpkp1fJD7
	wJ1+W5+aU05drYqmSBuUeVV+hvDNAAAcGGeFy4p+yfaay2U2Yrm/Viya8dC7NvglG8tyIwSMQfE
	po4OgrNjdl4+Yd82GeslfgcxkAtskyhCGRicAoR/oyVlrI/GwieElS4U4kbxsBGAJayZFY4D6ry
	sIagD9V76UsEo=
X-Google-Smtp-Source: AGHT+IEfDb+oJnGjarh+9F7GOHtv3gc1oPFaNFLIKdQInLnQKAgyBWcutw5Cbxj5+5Saxr4AJ66EZw==
X-Received: by 2002:a05:690e:241c:b0:63f:9f5a:a555 with SMTP id 956f58d0204a3-63fd35a47ddmr1049504d50.50.1762305808562;
        Tue, 04 Nov 2025 17:23:28 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7869a7b978fsm9216057b3.2.2025.11.04.17.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:23:28 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 17:23:25 -0800
Subject: [PATCH net-next v6 6/6] net: devmem: add tests for
 SO_DEVMEM_AUTORELEASE socket option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-6-ea98cf4d40b3@meta.com>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
In-Reply-To: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add -A flag to ncdevmem to set autorelease mode.

Add tests for the SO_DEVMEM_AUTORELEASE socket option:

New tests include:
   - check_sockopt_autorelease_default: Verifies default value is 0
   - check_sockopt_autorelease_set_0: Tests setting to 0 and reading
     back
   - check_sockopt_autorelease_set_1: Tests toggling from 0 to 1
   - check_sockopt_autorelease_invalid: Tests invalid value (2) returns
     EINVAL
   - check_autorelease_disabled: Tests ncdevmem in manual token release
     mode
   - check_autorelease_enabled: Tests ncdevmem in autorelease mode

All check_sockopt tests gracefully skip with KsftSkipEx if
SO_DEVMEM_AUTORELEASE is not supported by the kernel.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/devmem.py  | 115 +++++++++++++++++++++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c |  20 +++-
 2 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 45c2d49d55b6..29ec179d651f 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -1,6 +1,9 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+import socket
+import errno
+
 from os import path
 from lib.py import ksft_run, ksft_exit
 from lib.py import ksft_eq, KsftSkipEx
@@ -63,12 +66,122 @@ def check_tx_chunks(cfg) -> None:
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
 
+@ksft_disruptive
+def check_autorelease_disabled(cfg) -> None:
+    """Test RX with autorelease disabled (requires manual token release in ncdevmem)"""
+    require_devmem(cfg)
+
+    port = rand_port()
+    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} -c {cfg.remote_addr} -v 7 -A 0"
+
+    with bkg(listen_cmd, exit_wait=True) as ncdevmem:
+        wait_port_listen(port)
+        cmd(f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | \
+            head -c 1K | {socat}", host=cfg.remote, shell=True)
+
+    ksft_eq(ncdevmem.ret, 0)
+
+
+@ksft_disruptive
+def check_autorelease_enabled(cfg) -> None:
+    """Test RX with autorelease enabled (requires token autorelease in ncdevmem)"""
+    require_devmem(cfg)
+
+    port = rand_port()
+    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} -c {cfg.remote_addr} -v 7 -A 1"
+
+    with bkg(listen_cmd, exit_wait=True) as ncdevmem:
+        wait_port_listen(port)
+        cmd(f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | \
+            head -c 1K | {socat}", host=cfg.remote, shell=True)
+
+    ksft_eq(ncdevmem.ret, 0)
+
+
+def check_sockopt_autorelease_default(cfg) -> None:
+    """Test that SO_DEVMEM_AUTORELEASE default is 0"""
+    SO_DEVMEM_AUTORELEASE = 85
+
+    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+    try:
+        val = sock.getsockopt(socket.SOL_SOCKET, SO_DEVMEM_AUTORELEASE)
+        ksft_eq(val, 0, "Default autorelease should be 0")
+    except OSError as e:
+        if e.errno == errno.ENOPROTOOPT:
+            raise KsftSkipEx("SO_DEVMEM_AUTORELEASE not supported")
+        raise
+    finally:
+        sock.close()
+
+
+def check_sockopt_autorelease_set_0(cfg) -> None:
+    """Test setting SO_DEVMEM_AUTORELEASE to 0"""
+    SO_DEVMEM_AUTORELEASE = 85
+
+    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+    try:
+        sock.setsockopt(socket.SOL_SOCKET, SO_DEVMEM_AUTORELEASE, 0)
+        val = sock.getsockopt(socket.SOL_SOCKET, SO_DEVMEM_AUTORELEASE)
+        ksft_eq(val, 0, "Autorelease should be 0 after setting")
+    except OSError as e:
+        if e.errno == errno.ENOPROTOOPT:
+            raise KsftSkipEx("SO_DEVMEM_AUTORELEASE not supported")
+        raise
+    finally:
+        sock.close()
+
+
+def check_sockopt_autorelease_set_1(cfg) -> None:
+    """Test setting SO_DEVMEM_AUTORELEASE to 1"""
+    SO_DEVMEM_AUTORELEASE = 85
+
+    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+    try:
+        # First set to 0
+        sock.setsockopt(socket.SOL_SOCKET, SO_DEVMEM_AUTORELEASE, 0)
+        # Then set back to 1
+        sock.setsockopt(socket.SOL_SOCKET, SO_DEVMEM_AUTORELEASE, 1)
+        val = sock.getsockopt(socket.SOL_SOCKET, SO_DEVMEM_AUTORELEASE)
+        ksft_eq(val, 1, "Autorelease should be 1 after setting")
+    except OSError as e:
+        if e.errno == errno.ENOPROTOOPT:
+            raise KsftSkipEx("SO_DEVMEM_AUTORELEASE not supported")
+        raise
+    finally:
+        sock.close()
+
+
+def check_sockopt_autorelease_invalid(cfg) -> None:
+    """Test that SO_DEVMEM_AUTORELEASE rejects invalid values"""
+    SO_DEVMEM_AUTORELEASE = 85
+
+    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+    try:
+        try:
+            sock.setsockopt(socket.SOL_SOCKET, SO_DEVMEM_AUTORELEASE, 2)
+            raise Exception("setsockopt should have failed with EINVAL")
+        except OSError as e:
+            if e.errno == errno.ENOPROTOOPT:
+                raise KsftSkipEx("SO_DEVMEM_AUTORELEASE not supported")
+            ksft_eq(e.errno, errno.EINVAL, "Should fail with EINVAL for invalid value")
+    finally:
+        sock.close()
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         cfg.bin_local = path.abspath(path.dirname(__file__) + "/ncdevmem")
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
-        ksft_run([check_rx, check_tx, check_tx_chunks],
+        ksft_run([check_rx, check_tx, check_tx_chunks,
+                  check_autorelease_enabled,
+                  check_autorelease_disabled,
+                  check_sockopt_autorelease_default,
+                  check_sockopt_autorelease_set_0,
+                  check_sockopt_autorelease_set_1,
+                  check_sockopt_autorelease_invalid],
                  args=(cfg, ))
     ksft_exit()
 
diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 3288ed04ce08..34d608d07bec 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -83,6 +83,10 @@
 #define MSG_SOCK_DEVMEM 0x2000000
 #endif
 
+#ifndef SO_DEVMEM_AUTORELEASE
+#define SO_DEVMEM_AUTORELEASE 85
+#endif
+
 #define MAX_IOV 1024
 
 static size_t max_chunk;
@@ -97,6 +101,7 @@ static unsigned int ifindex;
 static unsigned int dmabuf_id;
 static uint32_t tx_dmabuf_id;
 static int waittime_ms = 500;
+static int autorelease = -1;
 
 /* System state loaded by current_config_load() */
 #define MAX_FLOWS	8
@@ -890,6 +895,16 @@ static int do_server(struct memory_buffer *mem)
 	if (enable_reuseaddr(socket_fd))
 		goto err_close_socket;
 
+	if (autorelease >= 0) {
+		ret = setsockopt(socket_fd, SOL_SOCKET, SO_DEVMEM_AUTORELEASE,
+				 &autorelease, sizeof(autorelease));
+		if (ret) {
+			pr_err("SO_DEVMEM_AUTORELEASE failed");
+			goto err_close_socket;
+		}
+		fprintf(stderr, "Set SO_DEVMEM_AUTORELEASE to %d\n", autorelease);
+	}
+
 	fprintf(stderr, "binding to address %s:%d\n", server_ip,
 		ntohs(server_sin.sin6_port));
 
@@ -1397,7 +1412,7 @@ int main(int argc, char *argv[])
 	int is_server = 0, opt;
 	int ret, err = 1;
 
-	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:z:")) != -1) {
+	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:z:A:")) != -1) {
 		switch (opt) {
 		case 'l':
 			is_server = 1;
@@ -1426,6 +1441,9 @@ int main(int argc, char *argv[])
 		case 'z':
 			max_chunk = atoi(optarg);
 			break;
+		case 'A':
+			autorelease = atoi(optarg);
+			break;
 		case '?':
 			fprintf(stderr, "unknown option: %c\n", optopt);
 			break;

-- 
2.47.3


