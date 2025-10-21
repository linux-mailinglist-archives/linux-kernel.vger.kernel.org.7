Return-Path: <linux-kernel+bounces-863871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1386DBF9655
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33F7D5076FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E2831A071;
	Tue, 21 Oct 2025 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvLpxZ/o"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F732F1FDE
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090444; cv=none; b=Y+hmFSI9/TEI1GIHOmZIhIdSNhH0Q2GASJn23s/QevyVVn4mYlea7oiPee3HfX1JqRL+R1x9DrhN1Dd6RjD+EREWLlPojG046y/fR7ghR9Nyw0iUaqrbqeXbdzgvP4EPUiYgvhN/HWDXVVW1JWLuk90cY6W1GJ/K4UTItIROr3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090444; c=relaxed/simple;
	bh=8bOFcVzDZsUwxKg5ikgK5NJUIukOBjSEIefCk8ZnB5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jA6wWW61QpfAhFVPC4mOen+9h3mhgyEt0m9i5F9Q+ngKqTtAQJ0x8FECgeF1wwX/Cp1PshQi22XUdia6iucfGWtq331lq123dr6n5KGSr7K7SqjSw11Pl0XSQkuVXoVOtMk5+KmdETI1xL+WnT4vq+eUIc6oHdGf3wvuEkJRdT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvLpxZ/o; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781db5068b8so4764445b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090438; x=1761695238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4OFfgfpg2zuYVB97qQ4nYxxE2fA0slLU1vqJ2CVR4E=;
        b=HvLpxZ/oyS6/bJuVCK52e2NPKHQGvQmmYqh8/9b4AxDZ2YYK7TrE1CWlHE2reLMhun
         cX/LAKQcBHti7pwdZlU2FD0gdKfHtaXB2/dH+bWAJ4MFzeB102phEzkQ6vFJs+IXukjt
         uMwjUwdEzoFySh0OWznGnIfPjO/pqtP9StiZeoeJ0Uf0iCnRhDj9DqPV1+T/UUvvEuyO
         Pmr8qsSx87aT0QJixLbYmLlOxCMOosVPRb/C1R4u2p9wuqb0VgI9GgAsvUgodrgqHhvu
         MXACr2Hzlwox7//EKMFlLTUtAca7vOtHRPKdiKoG7me4IQnv5UN75f0ErpeJLP7Xzfkq
         jXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090438; x=1761695238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4OFfgfpg2zuYVB97qQ4nYxxE2fA0slLU1vqJ2CVR4E=;
        b=t2DSdXAHpIt2G8mA5HPRBnU2bMr0N9fbuYEPd05Yly/uHIJ71UlGHSXloJ+Pc28NJw
         o+qnXu83RkgJT52P6XX3ZohCdrE9jxhnJOdUWJ7nOIEhcF9nHeQbKLepFMXW0CO1rp0g
         WpuGe3CB1BPH9A6yIoY5BHdkdoUVNWZDzjFfi4NtwqqxMAnpcnjSLNxwYOOu8y6CcChY
         1aOhkHqc++Lh3MU6K54bkIVuH7YeSQlLlQ7sm1eIyTWluL7Sv2EA92ADOkpvG3N8PNu+
         E5t+IrwHf7Kb3sGs7/PtN7ru9j0ySGYvtUzqsZjUVz+JRTHgtrcNbbmV/iyLr+FEJFlM
         swiw==
X-Forwarded-Encrypted: i=1; AJvYcCUBsPXY2+EDR19W2ziNOvjdugvAEXkZsbgpWBQa3p2xZpNBskWQM8H0OnDDjOfbj7IuZhAOHFsuY3qsOn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkujDbPPWh0Sg7ZoKfPGL1tFeau50ib+OAO0MbMucaH2IPg8M5
	Ej03iVIAksOsgrxLVhtRMT2bPW5JkQHyjaNdwg0PLh138kqXMBTZ0Qmv
X-Gm-Gg: ASbGnctNsoHaPRPYjnu3JPaGhO7tPGyBX3AGXQXSRpbV7aPJsyKjRorMQDhonYk/4ax
	cltqDc8x3/evDh1OuHsVWHiKDHV9VSTVtJIOT1bNm8dRQmaP43wL8cdgHlZ6JlPovvF+epHv/4k
	TSvTDIDk6BE/aJ0Un0Bu6mGXA7TGV0bbbco2qgkgucqddG5xsn5xJzT9q01UxJ8p4zz4Rzb1ajD
	d/h1wUKT8s1GjKmIjlQuKRtF/5W4+E/jb4RbzuOILYkNYJoWzKKLF/3OHF5bM+oVYQMxKw0Huh0
	7jSa4qERpI5/dEv1ei41Gmi7qsKqgfYkVRG3ofevagDT4l0tr5W302VA6xUxFxvWj+xR4ZBEWiD
	WUQtex5gsqsBnKokTNfZrqxrZVOR5miFp+MW7WMEZXHwGcQFfwVqPfRadWztrKZuYZW+Qdpdz0L
	PaVji/fPuI
X-Google-Smtp-Source: AGHT+IFkhGJRP2dLAASLtzToAAHgpD36H89TPJABTWvg0NGgrSHeo1CXKroyw7GJKTzS0N8BFk4Bbg==
X-Received: by 2002:a05:6a20:42a3:b0:334:a832:91a5 with SMTP id adf61e73a8af0-334a862939dmr20305416637.44.1761090437936;
        Tue, 21 Oct 2025 16:47:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b33bf3sm11369376a12.19.2025.10.21.16.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:17 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:03 -0700
Subject: [PATCH net-next v7 20/26] selftests/vsock: avoid false-positives
 when checking dmesg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-20-0661b7b6f081@meta.com>
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

Sometimes VMs will have some intermittent dmesg warnings that are
unrelated to vsock. Change the dmesg parsing to filter on strings
containing 'vsock' to avoid false positive failures that are unrelated
to vsock. The downside is that it is possible for some vsock related
warnings to not contain the substring 'vsock', so those will be missed.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 9afe8177167e..b129976e27fc 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -591,9 +591,9 @@ run_shared_vm_test() {
 	local rc
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
-	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
 	vm_oops_cnt_before=$(vm_ssh "init_ns" -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh "init_ns" -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_before=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i 'vsock')
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -605,7 +605,7 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i vsock)
 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on host" | log_host
 		rc=$KSFT_FAIL
@@ -617,7 +617,7 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh "init_ns" -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_after=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i vsock)
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3


