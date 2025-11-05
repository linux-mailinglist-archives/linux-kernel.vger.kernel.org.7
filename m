Return-Path: <linux-kernel+bounces-886834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E305FC36ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4D466286F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262F532E732;
	Wed,  5 Nov 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQKTB0pC"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7A32936D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358368; cv=none; b=Xs4KW6b4oPaDCFxZjYcfmpfazzlj5I9WYPg1SN0IQZle2m+t5tmOiprtrMm9tQIQU0yIWGqQ0J4cffzgW4EkI1/h2pex30G9dBzgHuiOBX9oTYxlckTyLFhWXEini8kqlb3UUbLYEq6onk6emlsA2nPXcmAv8G7lcb66CZmlptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358368; c=relaxed/simple;
	bh=pVSfoO/0UIFMSnMLr516HI0z/z9lVuUNXwJAeljB520=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YAbVR43xBTHaNARAAswypdqxyjgkz0YhrX0ogx9bhAYkwMgpA9R1nhAsMjcP2pI3LLPv6uO8I4F+topKXVParDRJL00824ETieFEQgYidr06PtkZduTtnIJIYdnRaakgG0oGNZg3Ka/0Y3+VN26ZQF6pzGcEXwHJLlqIxEVL69M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQKTB0pC; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b996c8db896so3987389a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762358365; x=1762963165; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcWLW8qdCBVn4955Lh+XqTuvqquYHifTQdNcqINjy8Y=;
        b=JQKTB0pC7LcRg+weqNHESVw7FKSbK+2Wwr9uKEZ7mcOBbceGl4i8i3W9LhA3RW7rZ1
         ybebzcAlmQJ+u8YiWK/xizL9PUg42vcN5BNX6oYEA1fpK2SYm3SkdF9QGBP7teuHuuaU
         X/F9HT8iq9fw0pQb2fdIUAqiJU6Tf5sFxXX9SLz4XZ0KUTcSIuzAISgR0JolF3zH9oFC
         7hTnSoBM7Cw7E5vm+NjQW8itTFz1HLpmK+zmTnHXRe+KGWhbG9ZPA+OUgScTeTdkj6Ne
         xEnNsd3GN+iJBrPV0XBTRXvCNby3wpeQNlf3WlyGGPq20Mw9cLn4MEbabymca1AwNhxM
         0nzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358365; x=1762963165;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcWLW8qdCBVn4955Lh+XqTuvqquYHifTQdNcqINjy8Y=;
        b=AJvptBDOjUQEdamo1J60GC6fWyaJ4Znu3urK4V5Z0D30x3tEr6axeLvlCO1fx4GEY2
         bBffBxfPy2GuhdLAgsswJ6wbBdreLnweghkYpi43KfrLHley3uDEG61Dbs7XBpTCetTS
         bljRi2uCQl9eRA9Cr07jh4vt2kGj+UqoiPzCz4AmnV8ke1+W1hhM0h/yPNiSpSjqGoYp
         NPC0oJFMG/UXoNEpHnZjg5QT7WmfnETGiSvZF9xLk25Kcl5v6AWG1ggUft1OoD0aXtC9
         3PfV8mxTJ+Bolu77pVdk+HRcfZ+lOZWEREx4dsOEhCgpNtye8I4KPc5deLCOiSxQswzE
         BUig==
X-Forwarded-Encrypted: i=1; AJvYcCVMDNIANEmVWh3fSYu5FgyRcuBmTCWjOsCjGl9vIC/xOnKUWUjEVuB1Sc60v4/6gEcj9WC0pDXYX3BOE6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYdar+KCXFkGy3t/HOedI7EgT8+XaYZXK8Jn+UlA8T0hugD+5s
	MlNOf9iYDQRT2Ipw5g41C6pvKtiMyUd+cAh608f5tj1WsPF2yV7YS22u5R8ZQ+TN
X-Gm-Gg: ASbGncvQIxSQEKa6BC4T+mveDnk1JF1OpnKdgwMG0onc4JqV5cXY8/bfVJuAghR5u+r
	XeGQtaE5IRLtjzLtW/ZigGPQWSG1yLFBgAHHSsde/6x4XlV1m0JYMwXUK8cL9V2C/0W4HHuu4or
	HVHzNtgOzS09cI8yoqnPQJ0vJi1KDidONF8mD9bTzHbzqpys4/kDwNq9kdMsZOd1dPia3Etowva
	TDRp0ZkU6ONOS5b0Jy1Icl0R3A8ynaxz+STfoFdrBIbIvhYqgIEYpdC/RVqxx2oacnUxeHX2BPL
	nrln0mJI7/IPz1Dl/0vFeABLh3uBmGX9dRO5iurkZ3hcswZGno1r+fAqNH1GmizVrepKCuN4s3t
	JT6thTmMC9oTH0qwcf7HCoxTsJM5C9r7tTYQeY6ffWRySQm5fXHcsRaHEP0sBpr9uJXbvJOsD7w
	==
X-Google-Smtp-Source: AGHT+IEe5YQ6JeJmA49ewbcYItDVFikNimAbp/SS4l9S+v7yYwjF6WuYS8I7WYaQuTYcUp7f9KrD4A==
X-Received: by 2002:a05:6a20:958f:b0:347:5ce0:6dda with SMTP id adf61e73a8af0-34f83d106fdmr5164430637.14.1762358365064;
        Wed, 05 Nov 2025 07:59:25 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2893bc6sm5859917a12.10.2025.11.05.07.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:59:24 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 05 Nov 2025 07:59:19 -0800
Subject: [PATCH net v2] selftests/vsock: avoid false-positives when
 checking dmesg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-vsock-vmtest-dmesg-fix-v2-1-1a042a14892c@meta.com>
X-B4-Tracking: v=1; b=H4sIAFZ0C2kC/4WNQQrDIBBFrxJm3SlqKpiueo+SRaJjIsVYHJGWk
 LtXcoEu//v893dgyoEY7t0OmWrgkLYW1KUDu07bQhhcy6CE0lKKG1ZO9oU1FuKCLhIv6MMHZ2X
 1QNINtjfQxu9MDZ/iJ2xUYGxwDVxS/p5nVZ7VP2+VKNEIa9zce+08PSKV6WpThPE4jh995KsJw
 AAAAA==
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Sometimes VMs will have some intermittent dmesg warnings that are
unrelated to vsock. Change the dmesg parsing to filter on strings
containing 'vsock' to avoid false positive failures that are unrelated
to vsock. The downside is that it is possible for some vsock related
warnings to not contain the substring 'vsock', so those will be missed.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Previously was part of the series:
https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/
---
Changes in v2:
- use consistent quoting for vsock string
- Link to v1: https://lore.kernel.org/r/20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com
---
 tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index edacebfc1632..8ceeb8a7894f 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -389,9 +389,9 @@ run_test() {
 	local rc
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
-	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
 	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -403,7 +403,7 @@ run_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i 'vsock')
 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on host" | log_host "${name}"
 		rc=$KSFT_FAIL
@@ -415,7 +415,7 @@ run_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
 		rc=$KSFT_FAIL

---
base-commit: 89aec171d9d1ab168e43fcf9754b82e4c0aef9b9
change-id: 20251104-vsock-vmtest-dmesg-fix-b2c59e1d9c38

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


