Return-Path: <linux-kernel+bounces-889607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1BAC3E089
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 652794EADC9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04452F60DD;
	Fri,  7 Nov 2025 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqJyFPpc"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36FC2F1FE4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476599; cv=none; b=GPtqP/YEsIgP5GWWVtzFs3OnPiVOOLp4HJdpktx+YpuAb/Vb6RUtSsTxhhJHYa8pgGWwRmqQNMt9lkPZ7p5UCUgOQXmWcLr1YV+Bk/x2vR0ahxdORjodZDtnu1viwzmAZT4tJgQaOGs53IF9T/B2V8rPoWvFoq45uFR+0o2/sds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476599; c=relaxed/simple;
	bh=NjhEgtu5medwkPvG2Enm9tK5HgLlZ3KE8dn38aGAOtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UUQOhCxRcI5rVQqLwTI7zKk6ExJm7f8d8DjnYbFJJ9Q3aJx9Agz7qduG8t5HvpjWJeSTgU8iGms5ZPCF/MLQT+qIWMzJQqHW7ws466rNtr/gIS+jVb5YaufR++MzZb38tvvfsyjzeYfndVz54b/CEKNyHBdbFBAivEejKBwJtns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqJyFPpc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso197277b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476597; x=1763081397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cB0jrnxyKvtVXOL0SkOCiQy/hsJ1kDvUYjzNG1+oTMw=;
        b=AqJyFPpciT/XLz8cnmY9iVvQF+xWs1lXU4cw5fA26gNRVpFdfzYOC2wmBDX3ja6Lj0
         HUhHkZ9Tnn9R4kFrARXJGdqLMM3jC9a6iKvub0+vejhA7e0nd93dAqXjvY292BF/DGhb
         U+jNYQ7tS/wN6ZTcw/ELQLJVZV8b169Juifisa/jflY88RFwY4R48FBFd1UcGC4f30wk
         k9XszumA63tne7hLyrImUp8p5g/Jy+xi+P2j9/OYS/b8LMBrFz6G3Y90pDDrRbHIXYKx
         esIbELi671CdkhCbkNg8YNc7ipg4Q1tLW0jFKbTpJHW2RFVe0ZCvMfxpJAjcIq2yM6r2
         x6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476597; x=1763081397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cB0jrnxyKvtVXOL0SkOCiQy/hsJ1kDvUYjzNG1+oTMw=;
        b=vilrcL1XV1du/M6IN5m3HJRKBFxHII71NjOwvhNtxO1mTHf63l0s57XJdf+7iS/kRG
         nkNDTXehlS9a4Wt4LZwXkcscw9XH6R5pWp7jfAfa0VASZWtnZLgpTQaK0EBolyPRslI7
         4bNg6HWMQXgbrjFAsAqUnoaYTggwRMU9fdrezONxDgSJawzeO4YL1HbA+SBVE9RwTPcW
         FTbFP5XHpWxKzVoVnAPHQfbuxAJpjiP988Som5JbVMNxR4eZdano57pD+kQ9xuKjR0dI
         bCdFkNlOJamKbgSlsm9VaFk2RkcyAmiqPWyQJr8kJYb2NwWXkKv68efLnJmApd6WIucQ
         ftFw==
X-Forwarded-Encrypted: i=1; AJvYcCXKIUxNXhv0L7MuAvmysnXFncyx6GEkFieM2vhcm+c4rT8t2WmT0yjHI/2ZgVyF1rZfrpyxGl/4DeYIr38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBK2PkKmwBBz8wn9za6+QHrEWWj7KwxOmNyatDIT1LKJEQGSxP
	NfKzGzMR7N+/AKpFyPabn0SgrNa3B0+ju0xFFwDOc6peSwUtvK0IbtNl
X-Gm-Gg: ASbGncu/O57kQfQzer4l1+l/4JPrJc+f3NxkyR3+B7goAxFZ5GXXk5hDG6lfmMpoYm+
	dP8fG7ekA2ap88fKNtvUetBS4HbiFfvdTKKwqPHbh2rgadGECCNqN2p5/fAPF/nDNLQnv6+44EY
	MmQ+P7ssDLAIQnXTaPZfk7cKcgC56fqMNwRMNlLETuobR7NAs7nIV1e94ie4BZnPiZ2ljIEwVDL
	MgYbE0hnYlcdt4Wk88X5/uvM66+TBjsbyj2yrhxBlGxNhd925zHdhnc45+DpxF6x5o+721XPVXT
	xirmktm579DWHRm4r6PC6eEg/5tw196aXgMtb9JtWyMn0+jf14IlzvaFt7EimnKmgKwR44Pus9v
	uWI9TNKt8dyWXKpLdq/jaZSc9NyMMLbDuAmK5Yb34G1JNsqsim5Vl6nEwkuQxl4dRJNXRCc1b
X-Google-Smtp-Source: AGHT+IHEjR+tD3f5onmBvKNAdZ43ttTdSjninDQiFysSI8E3D14rKPjUX1v0eti1pW9Okz7YIsxP6w==
X-Received: by 2002:a05:6a20:e291:b0:33e:6d4b:609a with SMTP id adf61e73a8af0-3522806bf44mr1924302637.6.1762476597267;
        Thu, 06 Nov 2025 16:49:57 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9635007sm875993b3a.2.2025.11.06.16.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:56 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:50 -0800
Subject: [PATCH net-next v3 06/11] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-6-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce the time waiting for the QEMU pidfile from three minutes to five
seconds. The three minute time window was chosen to make sure QEMU had
enough time to fully boot up. This, however, is an unreasonably long
delay for QEMU to write the pidfile, which happens earlier when the QEMU
process starts (not after VM boot). The three minute delay becomes
noticeably wasteful in future tests that expect QEMU to fail and wait a
full three minutes for a pidfile that will never exist.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index ede74add070a..557f9a99a306 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
 readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 declare -a PIDFILES
 
@@ -246,7 +246,7 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	timeout "${WAIT_TOTAL}" \
+	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 

-- 
2.47.3


