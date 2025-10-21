Return-Path: <linux-kernel+bounces-863864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1A3BF9601
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CDCD5035EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB3E2F9C37;
	Tue, 21 Oct 2025 23:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5w6B0ZJ"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33732E5B0D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090434; cv=none; b=FeXhryXzBRSxlDntqYcaC1ywtyeYYoojZneRufD8qoqCeQPpVzTEuqSbZxuvMcQbMkG3IbB9xyvni5kBGA7h/ARQnsQUn0T+DPmDFIhktJn4OtsCwDbYBnT2v7g+EJdvc4CHVEhRKzhP2H9taqwZzNWtk2rgtIyHWfPKBNGNsZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090434; c=relaxed/simple;
	bh=sFmiWiqcfg8xXVngUspNtrgGk8pAsdPv+UUIRplZPLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uEnGo64+Rqp73x3Fnjdtcn03sHU4kOZy8IeK9dMgA9fINN45ehGBQhGPkmcx3NmMDOYsLwga4G+tsu9Apo5N6u0cdtdhpBu7tzwAguslpDjZc110VE15zznL428j2RoQjOTqPNk6UVSnFvfPzLYBH/g8fS57KqiyAZuWW0Ye62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5w6B0ZJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-793021f348fso5548291b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090430; x=1761695230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Lx0Vsy3+YgWmRX9GABJkmBtAr8R5JRasWccNZRzMeM=;
        b=V5w6B0ZJQCwTfCtO7I91J2tvyL/SZY+dKcKM/ZSTCGmXFn+uZS3Zgy9/vw/BmVhkJw
         Fo7qWb/fhwFDmXhHgWiEH6lTicnillbZmtMOG24ahvMSpaaZ+V0FMB2ob3F9X3W5MXvg
         eU6SdHEC32W7j0DyAIPbXGZ2gdnKRn4EonlVaavHMJ0a7rx30dEPOaeKw1wXVmx6unVW
         kyApOWzSE4uEG4ObG6H0kk5ooKvjCeo0o5fvKb+KxPSCkNFoKrjYLJwiVfDBA6QqaZ3A
         kts6xEGkq1UHN0AL7BQEw7x6L7ZKkpPnsQz0KIQaee9Rf1Oi3lyUg5c+I4mwnnR+Xn6R
         CDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090430; x=1761695230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Lx0Vsy3+YgWmRX9GABJkmBtAr8R5JRasWccNZRzMeM=;
        b=SoyMWDUiod2yy4KX7I4WjRgiA0XDSTebyEAd+9hIOV3VhjnAd1EmVhLulIICbW4mpr
         Ehc9PD7aNzhjfavG4raupcIHZup9r4onVS9sdiJcqonTlt3mGOIOvLP7OUaO4LPwVQW1
         He0VaRn5LK95fvShTz2yoRkko6/g8z6mtUYn8ANrdb/W8EkdK1ml9lFO6HO+krSTWyjQ
         CbShTM+5VOfWdEQct7IOKledtgx2zzdoFtYGgYXW440WRIwfOZamfm/My3PTxhf+bHHd
         Wjn77amFSndaufbPQlI63gk5r5ByalOr1jHnSVsG18+ZyicPSzMRbq/4909aQ6nwzq0d
         nI0A==
X-Forwarded-Encrypted: i=1; AJvYcCU2Dk8uD3YP134iUAwa2epqHwnsPqmlNc+womX7Dg9ELjhCO/Kz2iW2lHtuN6S8j1jmYx7e5xb3AJBMmac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxKjPQYnDbGHschNfRZkofN3XcY7dtqVq4POEwzZQzCwZvzQMM
	GT9CRtLG2UpcHqjezHpAgmJcOK5kag3R+9BLhEzHd744nK+mXZzqgzF7
X-Gm-Gg: ASbGnctUt80il/MQDdZOHQvavY6i/vJB/jqL+MkWF7HlcMq+IiWJ9yoVmLDUudZYhw8
	vaXJSZ8GvSr++Mqa8Zwdq7m+JmBaCVL1Zi1h8+e4DIUMza4GcUCfcjBP1ItXs0z6I1wTsw/QiCF
	OVoqz3XE1LaBNSGpZDL/86xqzNPybG7W/sYttny6Tsb5Ku6sRd/eLi3cLIVWnjkuzBpv1Evx/ZK
	fXSekYkJv/dbxKpKz7nENx2q/sFUy6zpj1j4r+TfI89mfgdlvRHIkSuE5z9p2ptR/bgWx4+RH+o
	ZrRzL2OX4UL5dkik9wPw5Su8yNShxBKdvXu2l2MComgJ8QQtJADwjpGQhyaxwyrf5lkrzzM1m5J
	tK2o3DTzOaqXwal2YAOeN0R5375XSXYaIoJLXVRKT/oTV1FDlr4QzTSr1ocMgh3d94ejt1qaBau
	nbnpX520bBbUpk8uyRyAg=
X-Google-Smtp-Source: AGHT+IHBIC1WFg0H2qiLSSMrqYIuCevWaKcWLpJLUcG8eiGjix0DgQfBr2qDeIJoI8W1LO6p9Cikzw==
X-Received: by 2002:a05:6a00:130e:b0:77e:8130:fda with SMTP id d2e1a72fcca58-7a220aa090dmr21331246b3a.13.1761090430385;
        Tue, 21 Oct 2025 16:47:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff1599dsm12619953b3a.4.2025.10.21.16.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:10 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:55 -0700
Subject: [PATCH net-next v7 12/26] selftests/vsock: do not unconditionally
 die if qemu fails
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-12-0661b7b6f081@meta.com>
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

If QEMU fails to boot, then set the returncode (via timeout) instead of
unconditionally dying. This is in preparation for tests that expect QEMU
to fail to boot. In that case, we just want to know if the boot failed
or not so we can test the pass/fail criteria, and continue executing the
next test.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 9958b3250520..d53dd25f5b48 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -221,10 +221,8 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	if ! timeout ${WAIT_TOTAL} \
-		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
-		die "failed to boot VM"
-	fi
+	timeout "${WAIT_TOTAL}" \
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 
 vm_wait_for_ssh() {

-- 
2.47.3


