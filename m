Return-Path: <linux-kernel+bounces-866057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0DABFECDB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8F83A9396
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BA41DF248;
	Thu, 23 Oct 2025 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTarZ7Ql"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40471DE4CA
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181239; cv=none; b=MOrerG9sTOr+h74bPWK9S6DidBGPanSRME6y02GlOmBmqQ1hpVVU4TFhO5uFQcVLW8VKEUS9v+dXEdiJWRfcpLxdFnPY5pTYwzN7L1Y7UwZSn8G0CIU6SGNbdPPRUOvy+DXexE6nGfU0I9zI4bRfc/wIt7v5IX3DZJ+I79Ygzwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181239; c=relaxed/simple;
	bh=0gdl78nLUN6qDU9c49g00gHfPsOWu9yWlnAwLxCpxsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KvgroV0+s2/3a/MZyqritd08yxXmhM3V6ZZaa9Df/vTB00laKxophWSMlrMy0xy3Rgxd3t6b7UmDvOGaivZvGHW4Zo8xykosmkfNPeEGU443fAWxkjtK1N2adBMi71+Tq/9lM8lm7prHJWsXI+kHzGCLlxmXEuN/25sSJsYSIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTarZ7Ql; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33e0008d3b3so291973a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181237; x=1761786037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cswws6nw1UcLqOlSgHDjsHbmmRPUE9+8RNFOhZ/bbU=;
        b=LTarZ7QlXgJC0csl3gaT7S9YAatvTMy6Jsm4TgDLsRlWUiJPTcDr4DvaDkSM550oME
         J7LATX+3xtjdP5zJuwb3pr68XHLTbrq/KQ61fdkuVWXVAepqtVo3hpnfehikItxBBnBM
         1wtMthWMtZz5im8pGYOq6u/cgwJPZ23n2K49dwPkrHpxoHXWhaXX1X8zEmNCyeHtflrY
         +US+59b7b+bhkUCBqZ/xnwX1tZ2P2KWpR7+V3oBoOEoyhyjKiqZnQGci5i7geYb+GpIs
         EQWtydSCH51kqpojWNoComjEiA0LdDFqON0LXytY3dBURMJpn+/1ZGPaU0Xq338zq6pD
         DI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181237; x=1761786037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cswws6nw1UcLqOlSgHDjsHbmmRPUE9+8RNFOhZ/bbU=;
        b=U7Bk6gJLBbdaZDPltZNor8wwDGpbKx/nXmvWoCfq28AdXdq6Xe3dqJl9QOE2D0OQju
         nXKdQNJqAFXLjqvE5pjahYNVVuy7NR1jCDFn0Ra9olpC1PHMw9CyiwAbo9LaIYNSg5M4
         hHI+UIqTkGy5N2G2Zg3HPffZuh8rtG9IE9J7hOwHNKD6P0T/427LCJqzhPUBIF6coq37
         tZ/TP5yg7xfy7NSihsPLlWzbHAUUQiBsOo1hA/kQ6wZ8HiUgN9Ve8i6z0480VdRMUlc7
         ZV5MU2f5rEPE9Ds2wrAjvQOreyDymgxLY23L+Gxp8JoWx4F8mGt83FosoFP0D+Xf70Wk
         ndgw==
X-Forwarded-Encrypted: i=1; AJvYcCU3l0c+2pZGsI7ewYRmVS69+RGT7mgtlmv+yEqz7XVnr2ScKMVqBLdrCrNmK3UFuPRNC/fce+UUOugzFZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKCGfsQetIjHuQvEvzkKiC+NoNJrPppAzN3BfgdomNtBHt8sES
	WfZU+LIe2y86k96bKMlLIP8aX14rV1a8NKXTjOAm1hD3hhYOPFPTM2Xk
X-Gm-Gg: ASbGnctUWO5GIdN9AfqnExB4ZizhDtM2DoT4XLANLPbd/p/NJ2apXCwG40XGTxsomHK
	ASCbua9+ThZs/XAa6qxv8zfzZx0WvnGUpsa3sIhute6zzMOMWq1qPxsg/reKZ66j+bVLzeu/gnt
	4KlKNYwTHGIF81OLQYACuJp3yG/im3eKCDx8NtGNIKBPKsMgdUOfbjvKrqUEwn6tekrZVKueH/f
	kSfYYQ6ayrQrS4eH2AkcCBLUqJsrv0VOgL7slyBJn/FlOfTX8A7244yXJfx4mQN5E3x58ZEAScU
	P0xmbqh8XmIsaO5gYTZhbTk1AZc8PXV6Ycu6y9iOXZcqkLt0O9vqRyK+gi1VxWF7XHj7AGceYzd
	EFRQZIcmxXeCVt25U+uG919k+mXQJqRA9GRWnieEjtRGVBki5rLS3bgdDib+h6gmQi1NWA0zujv
	uSVes/IUU=
X-Google-Smtp-Source: AGHT+IHFMWz/k3rf0exIhdMWgyBNfPBQLd//9lK2ixQKJ308LaXrH8yGDSVFtVxEd+3WBYMDTmigrg==
X-Received: by 2002:a17:90b:5105:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-33bcf87a85amr32540449a91.13.1761181236821;
        Wed, 22 Oct 2025 18:00:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dfb67f151sm3310254a91.2.2025.10.22.18.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:36 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:16 -0700
Subject: [PATCH net-next 12/12] selftests/vsock: add vsock_loopback module
 loading
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-12-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add vsock_loopback module loading to the loopback test.

When testing vsock_loopback as a module, it must be loaded before the
test executes or else the test will fail with errno 110.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 038bb5e2b5e2..62b4f5ede9f6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -445,6 +445,8 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+
 	if ! vm_vsock_test "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi

-- 
2.47.3


