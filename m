Return-Path: <linux-kernel+bounces-863865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE23BF9640
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDDD460500
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F8F305E15;
	Tue, 21 Oct 2025 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HszNB7Zm"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39A82E2EEF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090438; cv=none; b=JEEL25COS/m5VeXN9odL2lskVCH8fNPlgQ8dl1t+oL2sqeDeygP4tgTQkz3qPo2/MxNjhkPir3ITNCD4oOafPxozRCxidRLep1AUhXUD7VR4VOwQBz1756gWzLdOKaZhJOCRQZljIoTivwC3thMrhGMt3Rkcki9ZwMu73s0YoVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090438; c=relaxed/simple;
	bh=Ah75iXsh0T8yhCIpU6zRS0eJQetFgIMRMgUlS91SRJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bezkgZX7qzLx2mRO3LlqE6+u72/UyysubBQYxNKaGiKOnbS0uTPVUxxZiEV+wmNdNEDnihh8+QctepFFJqsSRR1CWtAf0QkBbp/QyBRLtnhiMsZCeuy5SbyYZ8l1WpP9SMb5tj6lS+hqxjBTDGtzHU8SdNVwuJsfjGgd3xAmXW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HszNB7Zm; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781206cce18so511076b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090431; x=1761695231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnzs2zs6t5aqxB+IKVfd3RCQCLiGKiLLTWmUAKIpb/I=;
        b=HszNB7ZmWL1j0OpgxNRQ8G5r/LEmWqQPTqK/vSouCT3KFep+YG5xltDqXPiMH/E8xQ
         Wivc7hlRjGXZwwWu0MPONn0MTOV7qtYbeTaK5JyETTZULIPJUIDLwLaI/PUsUH3zlRqQ
         v5yN2FH5/bN/XN7IMV2mNwIvFmZNKFYAHPXGFEBQFUtb4LOKNZ0VS590DPlmSXtjszy0
         hSQWxOvH6di4vL2oWH8m/T5v04ylrdNiGHexQNgWEcjNgn81rH/kemiXZd5G2WSyLXdC
         Xt4aEmQ5EVEKJnOHcXbUASObth3aqKhmxlfCudv+D4jOhZDRGJZ5Il5G5RIevnAir6qf
         KDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090431; x=1761695231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnzs2zs6t5aqxB+IKVfd3RCQCLiGKiLLTWmUAKIpb/I=;
        b=uK3iUncobbY2nwcw5HJj7f+TLuKF6LO8eqIKvoFpgKdKPvjXxbSb554g8oTM9czQZQ
         rajrT0o9fUa8dbnTetUu/yo4oJhb1zNG3PazFRufyjkVaUAcQrf21eY59kLruJhj2V9u
         bkbUV8BGS6HcILsoqR2QXjz+Yjs+LMPyQ0Za6rTzw4jy4351dD6YUkr1cxu33WXhjwvP
         7UGJ2vv8kujw7xPGIvxLXEV2O7cdmdCqBA1J+XRjZ29HLIrO62tQPeLCRv3bFkemW1SC
         mDI19hkfQ/N2IKoD3o858QmO9YdbuaVhKsXvpNqPq9qOweYXzigdsDHDTukXtwhR3aGa
         Q0GQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9tfbPDPwjgVSzFv1s/8sfT1/3gIHrXu4VJJJwcxXTaF2c2giFG9wqFMnyWDzbEcZmdPjhV0gXteSJaT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvcT1tbCV9O73Z+YbaWg7a4Hmbo1vJP30CZmJXlyiFJ8atAOFp
	w9su9mKjTBz843CJMI8hrMhKDf2SCrwZxDeXZ+KAzFl8BGKqniE5nu2r
X-Gm-Gg: ASbGnctscZxvBq+mIrZWDGyR4x3juacgHCwxw7t/upiJVw+/4g16VOPHrkhedOTxHwD
	V4OpvghN2k7NSIxTtalqgHoGbC64tYKmPyJkvj50imOOcKZ3CyYSxBNhal55vMz/ZmY/ck2p+UN
	FjbGe2plp/JFdMPnDckmVA+LNLNS6fN87XnTf9C+9dUvK8x/pU/s/gG03TWHvTC20Jsi6fGDz6F
	rOZkbSxXm7SsvnxNCfTBJ/6Q0zoJYcD+2P4EP4nYH1BQyh7UCiPH4D57KjNi8bDx/8xXTqqpvHp
	SvM2kAwU2qSxheFRcsoXSPvB8mkaunQgHNQ2J3J39C/UBJnRSUn+V7rL6suN47a/FJAJEWOsAMz
	1qBBYHl6vJcQScW16o62HPGNAbo3J0ub9QFwjdMMvmmo/v6il1TuSqmNtFqHT67/U0JCS1flwkg
	RNM1yLFo38
X-Google-Smtp-Source: AGHT+IFbTUe9F4h1LyVbUwgCQ1C/DV9vJaiYH1suq6bPPsdLXWTdUfcRVma8kaGj52ddQduYiLM0Cg==
X-Received: by 2002:a05:6a20:6a1e:b0:339:7f7c:bce5 with SMTP id adf61e73a8af0-33a9fb9f872mr2206937637.9.1761090431314;
        Tue, 21 Oct 2025 16:47:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7664b30dsm11118178a12.7.2025.10.21.16.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:11 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:56 -0700
Subject: [PATCH net-next v7 13/26] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-13-0661b7b6f081@meta.com>
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

Reduce the time waiting for the QEMU pidfile from three minutes to five
seconds. The three minute time window was chosen to make sure QEMU had
enough time to fully boot up. This, however, is an unreasonably long
delay for QEMU to write the pidfile, which happens earlier when the QEMU
process starts (not after VM boot). The three minute delay becomes
noticeably wasteful in future tests that expect QEMU to fail and wait a
full three minutes for a pidfile that will never exist.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index d53dd25f5b48..020796e1c31a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
 readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
@@ -221,7 +221,7 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	timeout "${WAIT_TOTAL}" \
+	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 

-- 
2.47.3


