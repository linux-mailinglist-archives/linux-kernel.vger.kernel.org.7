Return-Path: <linux-kernel+bounces-863870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC6EBF9652
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E367B504434
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7242FE596;
	Tue, 21 Oct 2025 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+gt5wjc"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEFB2EFDA6
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090442; cv=none; b=aKdQ2e3Vn9dv2warWzADapOET6P9RiFcEGV1GaSedncg25+sfHABqCdDd6IFHuGnuE7DjvajTrk48xFxnz+/XLAhb7VCbHoPFhcocBXpT/WTARbHRPxvit224hL4eGO4xJtXHkzknqCQZabBcDyHE963A7b7G6vHr56BgNkIbHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090442; c=relaxed/simple;
	bh=MF/czfrq9R+gzUXq3nakRInrzOwnmvgXgQyREpFMOsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgrK+n3bKuc5NtMu7FPlBHZEEIw15zMr1UYLUyiTNoqqiYuf8OTZ8ITui4qPFD4Ugd4J4fH6YpBhpUes1D10RRbdwwiJNxJ144Sla8Hwvnf78SEgQpaHu33OU2aBfizt5msuy8FEmU9QBc9d6ttcEsVMTICHYfKdv5nFCZnXStQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+gt5wjc; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33bb1701ca5so5349994a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090435; x=1761695235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6mUZMq9SVTZCVxtIiXitg02c6DGfDqdmAO69aX2eA4=;
        b=Q+gt5wjcUAWtZ1+Pa+QKWygd7P0u+N4yhjAijbU6jC2CCxufGapnDsR1Ijcr3Oi3SD
         ojh9jDqGB0Xnt1ExxkM7bqyKm9mi+xF830Wz1EgVDCSL/rsy/RoTL0qnEis2Y8ls1rO/
         pmqxqOPscZTQEs7Z942VDGmhNBd7iw2TDBokfXWzl2kPtB1n9Es0dK2F/TxAZj72N2e+
         68M+2YfrBnwaKrYKxcwcrHHhkg9gnxyf+9GvkRuJRAoXYObbpqbFd44a3bGVhfVsfsTe
         AaOiI5dmeI2ucyLa0eKl9kyned47owzg3NkYy1ZHB+n3PvC0Jdy2kd/kuntVANcluzAy
         udrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090435; x=1761695235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6mUZMq9SVTZCVxtIiXitg02c6DGfDqdmAO69aX2eA4=;
        b=LljlHN67leenoaNK/JGDkVILzz4Y0SFXCBPOTL+3kEZmtnpTnzX5H/ZWaetseoXfhB
         3RGbtyUw+XZaUj0AaETvnikGpnSe50+aB3oDBJwIixCE5NYMq6AQYmcPNvVydFmyyB+q
         1MXJXkLMEvZ5GgRBbDU+YGb26QShdz5ApH8VCcUtyKlJCdz2df/BjDe/TufsFd7Hq+wu
         Pr7zcKRnVT1HOeMRgV5vjkGXyO7XMRvnEQxT5Z06l9N3QUY3YpHMBntn3aN4sMZ/rzjq
         eTfpK1ap0+abYwOGEa8QN5OqTU5Ku79TK/FV9R6xYJ7DzeLCHfcC6pS9Zbb3QXRKDsKg
         ngNA==
X-Forwarded-Encrypted: i=1; AJvYcCUZCRtOmJHMHbUOyrbfuo9qJtxBLj+IPRcaa1DlCgTfQuWX8oJn/15sV3vT+H1wEC3KyLunYvJ8Nep5MfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/3JZG4r1rdYY1BRPwBxf78AA8z6HVMSSLtaO2MTTyqKo+fT7s
	qUk78qSrJ9xf7rJ9yGcQIBDCCjvln+cbb5myP/np8zOT09kULKvE3mw9
X-Gm-Gg: ASbGnct/LF8f7RqFhB8CKy0Ap3+E9BvStSHvmKWJvvrcnZVLjqnhNCHKEsrRkopFOp0
	+uKkUB7qib/OFuPFOAwqqxIFc2GYRnqgyabuXdfSe0vnDe0ELW/ElMF9MWslYqKb4B2KYTPQdCk
	zdOoxnp/uZXyM46+1a+kZoKl9DcxUaaHdVBEHyA1CikLnFcMKOo6ZBo2tmm+nP2DuZ3bmp2w+99
	s53nVeeV3S/En/O7MIpUX1TS39BoIzjbyoCVxscr4DMw2fkqVtc6OZxYVLQkgkW+gskbA+001RH
	YGJRgicdMQoiSbLRleLlfEOAyzYJtyLHbViEw5rEV8WFfJbFs/nYdBTKqPOzXTb10Co3c+EovH4
	SReUqcZQBpEHepxzDrqQs2/vf1EVXYZWGmSEzBLaCxnHekynPwmLlvHmfExjndwR5x9FZY7Wd
X-Google-Smtp-Source: AGHT+IFVbMkOuOiBDnCJEvlMwLaZ7DlmhKs/V/NW1acHbQ/gNGtWZNBni32L0tz8fkkeIan2KaLV9w==
X-Received: by 2002:a17:90a:d60f:b0:32e:d600:4fdb with SMTP id 98e67ed59e1d1-33bcf8e61b8mr21858888a91.18.1761090435179;
        Tue, 21 Oct 2025 16:47:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223e223esm711430a91.7.2025.10.21.16.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:14 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:00 -0700
Subject: [PATCH net-next v7 17/26] selftests/vsock: remove namespaces in
 cleanup()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-17-0661b7b6f081@meta.com>
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

Remove the namespaces upon exiting the program in cleanup().  This is
unlikely to be needed for a healthy run, but it is useful for tests that
are manually killed mid-test. In that case, this patch prevents the
subsequent test run from finding stale namespaces with
already-write-once-locked vsock ns modes.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 914d7c873ad9..49b3dd78efad 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -145,6 +145,9 @@ vm_ssh() {
 	return $?
 }
 
+cleanup() {
+	del_namespaces
+}
 
 check_args() {
 	local found

-- 
2.47.3


