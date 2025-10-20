Return-Path: <linux-kernel+bounces-861816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD866BF3B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C083BBB75
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E60334376;
	Mon, 20 Oct 2025 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koB3siOx"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895993346BC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995426; cv=none; b=plx+hSRTIUbQEqXdIDDmYZaiIJA2R6BrYc8Dyfv0JJOe25kyAA4dnkxCwTcLv3ZkCQRdsiL6f94fRXz8H6HrfoMin+auJsC7275wEXu62K0qOd/DlOg91LA5m61bcAr+64pzK37F0kgHUuXpxlVjqM8DLQYuq/wOL6FJDKYiDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995426; c=relaxed/simple;
	bh=04076ZU4fDIpCe9Z9NA/L130XG3f40HHvGcZTgjGyZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUbvkS6H7qjQkqMpt/EHhcEHY2mRJQtP+SwPvXFaV4c9L5orIoRZCrXFAh/LU/S6W0rh5Jr2qLIiwpwo7Gn1kBIIRBdnlN5USQCf2ffI+OZLeZbrdmpSsMZyyC9SbcQWiNk6T70QCHdPaKSo9r1lmUguRKkqRfgtCli9sbe6ysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koB3siOx; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4270a072a0bso472125f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760995423; x=1761600223; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8d8EECRw+m7hbkQlqPrHgN7QsrNdYpfzvWQU4bXaCs=;
        b=koB3siOxzUUvwqpTuIQJTxStaqPagZGhQWhkKKCUSldmX+6VoGiZSZZ9lFtIn0sBZ4
         TiXH8SvBuGF0NmNfljbnXWwjnU1CDi6UqCse6tpZJex1QiyLYb7jmu2kjipUBUgDSmam
         DQaOCiJJ6MZi4qyrfqDQYFADsox5j/w0XEbJo2vDSd4tGkGi+JcFreTkNYl7e7QIsjeb
         LHSuDLIQimvXR7BYRaKNNoaeJdDYDd5oYmksvhmUEWQKm6qc1ZGRwAwzzLN3n6V3jdmJ
         RuCHrDELlRztbSB9h3vz9aUoopPiR0ilfsFHodPYyhQeHXd+S2D25KLPxN8LEkihTslJ
         0iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995423; x=1761600223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8d8EECRw+m7hbkQlqPrHgN7QsrNdYpfzvWQU4bXaCs=;
        b=CDCPt+KySwkSsPyNutHubbOyFra9W+4l2F4lJvMiQxhqHbBX8KDBm6QUMH5T+oCxIe
         zlt7LztX4TYqljgukZzepI+Gam6zviPxwtXtdFbkwOY48PWN/TFD71EDNLWnzK0bUdJL
         ADv7O42loCHnjA7GdIl7jt+Z3s5w677nYHZ/f7USa+6fLme576PLp8H4TIV5kKbcwsWR
         g3/5CKjHnOM8yqEnFJKYZnj3x1p1Ik5MFvJKhB8OJF6BPr+0vIzM+W7jMK4wmEBpZFCu
         1u/i6QJBPurI7/7Uv2d2he/3XM7by2YzDFAoTzm0wa1af9P4D1/QwRb4Hzqcogxwsx+T
         rKZA==
X-Gm-Message-State: AOJu0YwHitMMGBsdIQ1ilRzfQAVdqaCYCbHHNDKrRkT5fdWZpGoQ1A4a
	7136gv0cBm67nw7dWv+JR6HrE5+W6JvifiIJjS1AcpuICKkZ3HOnKEvR
X-Gm-Gg: ASbGncuONDgG+byT0StxRBmsHPBGWLeyWVqQP3+c6hLhGDs63BNJxNF/LmqLpVi6WBy
	sghA3UvQMjBON5PaMVsBAtAQ2SRv61X72h5gLm6luVJDMQDe5cG2Pp1JYTuSwswx/mZYas6oqer
	psJSHWhEUimh0yh/uV8fAgX3apdx8pmlz20WWTsOnjtd8lDaTsdDgMJ59vre+/+zukBbQzJ3hC4
	Lj+6QJfcRF3JLB/uccVmyKRbI8nQObNDr57Hix5ffey/ZX6r1SK8eqrF8/Je2NXtdFiRtbWDos3
	pvNY1vj6GVJFzYl2X3+9QiZIdB0LY3ImM6wTjPjLanWB6Aya79XEzhvRS7hT65FiKo7AXW7AHXK
	NmDjBpOUglqJllfjg/3CYeGsZ7NAEqgv/ZGe61O8jO95nmMIg1LD3FBfXhsiqL1U9bBUaf26O6E
	hEndEEw5UKzrAycKo=
X-Google-Smtp-Source: AGHT+IGPeTqQf1vlQsUiXqTSlLt915p9P93ZjBaP5WHDU0hfDPbSjD3/JewHJY3/mr8uMcN8iPANFw==
X-Received: by 2002:a05:600c:4ec6:b0:471:c72:c805 with SMTP id 5b1f17b1804b1-474942ee517mr4172895e9.4.1760995422711;
        Mon, 20 Oct 2025 14:23:42 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:51::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114423862sm250600925e9.1.2025.10.20.14.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 14:23:41 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 20 Oct 2025 14:22:34 -0700
Subject: [PATCH net 1/2] selftests: netconsole: Add race condition test for
 userdata corruption
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-netconsole-fix-race-v1-1-b775be30ee8a@gmail.com>
References: <20251020-netconsole-fix-race-v1-0-b775be30ee8a@gmail.com>
In-Reply-To: <20251020-netconsole-fix-race-v1-0-b775be30ee8a@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Matthew Wood <thepacketgeek@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Add a test to verify that netconsole userdata handling is properly
synchronized under concurrent read/write operations. The test creates
two competing loops: one continuously sending netconsole messages
(which read userdata), and another rapidly alternating userdata values
between two distinct 198-byte patterns filled with 'A' and 'B'
characters.

Without proper synchronization, concurrent reads and writes could result
in torn reads where a message contains mixed userdata (e.g., starting
with 'A' but containing 'B', or vice versa). The test monitors 10,000
messages and fails if it detects any such corruption, ensuring that the
netconsole implementation maintains data consistency through proper
locking mechanisms.

This test validates the fix for potential race conditions in the
netconsole userdata path and serves as a regression test to prevent
similar issues in the future.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 .../selftests/drivers/net/netcons_race_userdata.sh | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/netcons_race_userdata.sh b/tools/testing/selftests/drivers/net/netcons_race_userdata.sh
new file mode 100755
index 0000000000000..d6574f0364ead
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_race_userdata.sh
@@ -0,0 +1,87 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This test verifies that netconsole userdata remains consistent under concurrent
+# read/write operations. It creates two loops: one continuously writing netconsole
+# messages (which read userdata) and another rapidly alternating userdata values
+# between two distinct patterns. The test checks that no message contains corrupted
+# or mixed userdata, ensuring proper synchronization in the netconsole implementation.
+#
+# Author: Gustavo Luiz Duarte <gustavold@gmail.com>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+
+function loop_set_userdata() {
+	MSGA=$(printf 'A%.0s' {1..198})
+	MSGB=$(printf 'B%.0s' {1..198})
+
+	while true; do
+		echo "$MSGA" > "${NETCONS_PATH}/userdata/${USERDATA_KEY}/value"
+		echo "$MSGB" > "${NETCONS_PATH}/userdata/${USERDATA_KEY}/value"
+	done
+}
+
+function loop_print_msg() {
+	while true; do
+		echo "test msg" > /dev/kmsg
+	done
+}
+
+cleanup_children() {
+	pkill_socat
+	# Remove the namespace, interfaces and netconsole target
+	cleanup
+	kill $child1 $child2 2> /dev/null || true
+	wait $child1 $child2 2> /dev/null || true
+}
+
+modprobe netdevsim 2> /dev/null || true
+modprobe netconsole 2> /dev/null || true
+
+OUTPUT_FILE="stdout"
+# Check for basic system dependency and exit if not found
+check_for_dependencies
+# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+echo "6 5" > /proc/sys/kernel/printk
+# kill child processes and remove interfaces on exit
+trap cleanup_children EXIT
+
+# Create one namespace and two interfaces
+set_network
+# Create a dynamic target for netconsole
+create_dynamic_target
+# Set userdata "key" with the "value" value
+set_user_data
+
+# Start userdata read loop (printk)
+loop_print_msg &
+child1=$!
+
+# Start userdata write loop
+loop_set_userdata &
+child2=$!
+
+# Start socat to listen for netconsole messages and check for corrupted userdata.
+MAX_COUNT=10000
+i=0
+while read line; do
+	if [ $i -ge $MAX_COUNT ]; then
+		echo "Test passed."
+		exit ${ksft_pass}
+	fi
+
+	if [[ "$line" == "key=A"* && "$line" == *"B"* ||
+	      "$line" == "key=B"* && "$line" == *"A"* ]]; then
+		echo "Test failed. Found corrupted userdata: $line"
+		exit ${ksft_fail}
+	fi
+
+	i=$((i + 1))
+done < <(listen_port_and_save_to ${OUTPUT_FILE} 2> /dev/null)
+
+echo "socat died before we could check $MAX_COUNT messages. Skipping test. ${ksft_skip}"
+exit ${ksft_skip}

-- 
2.47.3


