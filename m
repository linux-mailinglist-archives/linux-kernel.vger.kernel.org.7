Return-Path: <linux-kernel+bounces-891574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A59FC42F8F
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137D6188D534
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABF62773F0;
	Sat,  8 Nov 2025 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZbUjJAS"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2235525A630
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617724; cv=none; b=JSRPC/IIwoAw+Ac5uh0QPtmLIfTPlDF6EosOOKnpaTS6ajg1y4z06KXSNkAvlFnUwfdMh/L6YU5x5BFOeFeka3Slv4pEM5p4WHFecwGPAVy38B/Mr6/Wo89Vs0HeYyeX6Q8cC3jsmUael/BHkrfdpU0uz7QQBvAqUXHLAly9nhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617724; c=relaxed/simple;
	bh=SP8z1T+qlVVpgOEY39bC1ez51Ud9AdASTxD/jvP34Z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUMRL5e6TLwqj6hmVB0ysw4LLbrEeaEhMuONRZx8EKhU6NLJSBtqsCythzat4P6Q6jf99d3ge7bXx9Or8QUSAT2n63RkhLUwQ3ieYLb8EgcGE4Mu/PvkJu2Djg4/e64XQd6WtPV+Lbby+10/sDoKWbauicWQLjW34PYpHlTi4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZbUjJAS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297e264528aso6556725ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617721; x=1763222521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYpbI2qDd2ToMrlc8dBEHmpGvANrMWIZX9h8c/Keihk=;
        b=MZbUjJASGHq9WCKo4LZ1khD6kB7doIIxixKz+6bZKWnzkA6k6hSFS0wDRqcNBtqFqQ
         9BxDXM7NARwLpEBlQq292/UWZEniqibqq14boMsKTkRyEwI+GcoXhFw9GCR4ZYbIQ+U5
         v9R7zD7iZ9kj8lYsAvLtcErJNy3Rljt6QyKIoD/VpTOGQDv812MVRRKbUqQWndDPZOeX
         Zw7w/5rEUndx9GtucHQCq/eS/l+ZCW2bbVvy5CrfkxxroauCMRXvKzzI2FU8MjmfC7md
         suaGoiVrzYgtZq0K+E4qNI/JAG06iMLj7GBl1xK0u4QVw/safJJS3meESN7B6J/tbEeY
         tAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617721; x=1763222521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FYpbI2qDd2ToMrlc8dBEHmpGvANrMWIZX9h8c/Keihk=;
        b=Gveplei8JSj/HhDakkE4FigLmn8Hnsmz5PGD8B1mIuV9QdHNREkbH86Q7YjI2C53pn
         jdPcNAio0havS8DaDkMASC/xmjmBkFJBiZcMxzg9exXIBG7AlffN7/rw5Tx+dWovMdLS
         cmkqFWvOtlrN7ZWXeAwXHhmRvsp9WGVvNj8RWaDNlR2guFFo6Ut7JrTxdirrTs/UWgcs
         0PJNxDwsgrpePNuskm/+afxEX4s+7ApVvOUNmBLyq4jtG9bu2hZLnxU34PrF9kL7+Exy
         Sj4tXzpNPFA0dyJSU+rLbRaGBjjGX9irQUTDZVEPCzKoSBqRIGj/BHNf6E/LJPzWjCGQ
         sXNg==
X-Forwarded-Encrypted: i=1; AJvYcCXTZZBN9UiSGt3yBwjCy+2/S3JURTIUCBMXBd7wt34V+4sdCbv0miLK1egYi60a0vN4/zwUDCaatARvnf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4L0NLdsVvmuN74p00U2mDjYYfMWr+8/2hLHWNt7CQgE4iRUvw
	/EAGab8KValx3kOT8SuRdAsJtGLXeBumNYY6gNG2lS4OxbXkFEOSWlll
X-Gm-Gg: ASbGncvNfZ3uc51ozZPEyUwXbS1RLaMoBnKCvcZEYqlfK0CvZ/5kqhtYu+RgqmSmAq6
	8Dxc2FHrH89e8VrK+05OmmdpT9Wt8iZMRYb44QJi4HYjyHciJeIezsLOUSww3huilJOWWZ7mtth
	1rNk8auN2EjgLdaTllr1nBrboLEdIkn4fmhaVAhFGq5m49BUBoAcFj2xNRLkAzJ2eHWj3jiWZjm
	xpplUWWWeJLALIdS72z+J0dPyuQo3zuJVkYas/bcNGxRQbRkX8G4TtKyLj1RR7najsFb1NeMtb3
	k0GdxrEsahVe9DO1ibS76YvE47UPihyMu8W2o3cDAc9kAOsPX5ETZ6+1F/D5CVOxW+yc7gTQ5vg
	+QWPXbgPHyucov7pr0/mi79KxADYCdLls7lwTq3Pt3bUstlQ8wUhccV4COYdwOD+m6yq6zmsFUW
	OMuye69JM=
X-Google-Smtp-Source: AGHT+IHCGCSZhbNlxrVbkMXRN4C1nK7xsiQfSpEwGwQVUYt3YG8Lt+frrWDbMAZVEikAd86U4GMidg==
X-Received: by 2002:a17:902:cf4c:b0:297:eca3:cee5 with SMTP id d9443c01a7336-297eca3d0f4mr25654655ad.39.1762617721363;
        Sat, 08 Nov 2025 08:02:01 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651042c24sm93003605ad.50.2025.11.08.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:02:01 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:01:02 -0800
Subject: [PATCH net-next v4 11/12] selftests/vsock: add vsock_loopback
 module loading
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-11-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add vsock_loopback module loading to the loopback test so that vmtest.sh
can be used for kernels built with loopback as a module.

This is not technically a fix as kselftest expects loopback to be
built-in already (defined in selftests/vsock/config). This is useful
only for using vmtest.sh outside of kselftest.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index b611172da09e..42e155b45602 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -452,6 +452,8 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+
 	if ! vm_vsock_test "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi

-- 
2.47.3


