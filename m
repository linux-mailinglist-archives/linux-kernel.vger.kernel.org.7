Return-Path: <linux-kernel+bounces-863872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA22BF964F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DDB3B0CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394D31A072;
	Tue, 21 Oct 2025 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acBU5El1"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613502E7637
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090445; cv=none; b=tNj2Tksl827Bxyinh/N4xT/noLex7Qt97JwmUXHXbPk6FhvO7x4MaoalHUhmFEktP0oPGr0HUXMAZ6jAgzPBP71m62Y4fkhjYVbJSWg0pCO4lvNzcncW75m7oxgTuWe4IthADZdmZ61ND/KcppirzFX2HiDDAFKd5gGomOXgo80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090445; c=relaxed/simple;
	bh=Vq3JxLDexMAZpBZBOMz7RcnedkE0owAELSAnlUsmBpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jdfm/UmHN5pMRb6bLQPpiF61AUYi95rpHA6KP3g+d0SNzeAraD0YWjrUB9TbOtzNS4N12qqB9YPU/37yc7L6DWkvSb1CMPrqIgyOTluhuTaOxvk54utoTzxVN8v38DOxGeTFSa4dnRjdInlIJKq1EX9ayRGdp8XADaPdd59RTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acBU5El1; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso5146182a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090437; x=1761695237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ziglltQonD40PF3NaoQP9RaIb5nYxZqEFCDNXD/J6U=;
        b=acBU5El1XUnF5ahrQ6RY667sgPxLgA4ZdJwjIRnfSKapdKibrM29eTmpmAJGeNqGam
         Vcpo5EVSM/PpE88hHnTPEhkCDnqRwI4cGqC5L+itv6PdAMBrIWmxYm6c3+oEBeygAmy6
         fu5bI3vqAMWu3xJuEIO0Rhb3GHPzv9pf+BzPM1LR40a9FHLJsf75hxbid5OouU2WBszC
         1uLIzC2hXnfIslq5jjHwcFSVb2CGnHOC6lJ6DmmhpmukPvJhLqyOQ/Ki5YffYmkwXBwl
         IVfJNKxJtnLyzFbeScTbyoOKiaWotKOmkrnlWFw7QJU8JyZV0addM1hna8phjUUpizMN
         04Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090437; x=1761695237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ziglltQonD40PF3NaoQP9RaIb5nYxZqEFCDNXD/J6U=;
        b=GNFWfbn7fTGkkdxlgJsRFVVG+q5r9tRbIfG4rJ5j5i2mj1KrPgQ1fg00t5OcrIgTEg
         70H3BrUy3ge0nk0WYD2GvupGyT7xIMDe2VGL0Mz20kqtDs95oy2TnczNG7JIut652OXq
         Wt1Ko8NFOFL3u3AKFvWCaeaMLTgL3CK1Vs7kCb7j2843La6bePQtY1hveJx6MqrC6eaw
         Pe9dXj6ykncH4RHfoHqVmL5H2Jqs4rHyg05Qsn9QMoVXd9pM2KDzGcJt88pkQxtoOvHW
         4mT64LhRcIgiTwIUM+NjIM1OJ3YcYraLBS/ka5gR3QncFUs01htVY/sSUb7y4LTAfIA4
         1jkA==
X-Forwarded-Encrypted: i=1; AJvYcCUgY7mjLNLhJaZ5oN2HTzmWO5nW/QL5y3sHXjS00mcp2Eufg/syE+kGWuJyo5lLABSVZuNFyPrOzb8iWlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+1ZcUD0puf8wam3b/VJdFLSLgvFjkqamQqJyiRpQUT3gI3Ss
	lcnKp+aAZipo5mJSoOL3HO35xiKqkvv9hpLOt0OQpYR+hq/cs0u4mESx
X-Gm-Gg: ASbGncvjLs4WWmPENU92qtaz8U2k7Rl66UfeD3hB7c1DSgB5TjgH/u5YmL/+7iX4GmH
	y5Fbqrohx6BU7jHS7ZviMAYDN3zeC4HD7YAvbKivSV4aTaMdI5xUBF7SQNOLAV2W6VWzG6FxNpI
	Wdu5aoVDJ9gBxTyEV5OhPNxk/jPzE5geehe1/EZpqOVJ/0566l6Lq8ZuM+9N4oIJ8L3ynU70tnp
	zvPcqyWM/UaULQBs5IarEiBdXsNjeDY12TCYlIa1FWT8AEhOb6ItI7Wp6fv657vcbZB02eol7KP
	HAqdD3wcBfps3D3oZtuFxDspA+M5ipxMIAq94I0TdkZTEfsOhUciD+J7DwQO4jYgn+q9joVqCjh
	9e6KvuNybLG0eIPDTCdbLbU7UByu8nZWIgdmX8SZN1SqxOAzf6fyXFcNLcKz3SJygETDPg3Vjnb
	IwS1aXSzdv
X-Google-Smtp-Source: AGHT+IG5dGgoFfjLOrDybopHtR5kmquL2RmRYL/ZwgLqL0f5q8OPShyxosfyQ4g18ky0R7BE1MkTfw==
X-Received: by 2002:a17:902:e84b:b0:290:c0ed:de42 with SMTP id d9443c01a7336-290caf8582emr300060005ad.36.1761090436967;
        Tue, 21 Oct 2025 16:47:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdd10sm120304085ad.83.2025.10.21.16.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:16 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:02 -0700
Subject: [PATCH net-next v7 19/26] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-19-0661b7b6f081@meta.com>
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

Add the definition for BUILD and initialize it to zero. This avoids
'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
set to 1 and is later checked for its value.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index e8f938419e8e..9afe8177167e 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -626,6 +626,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3


