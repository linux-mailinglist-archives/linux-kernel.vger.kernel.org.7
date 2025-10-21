Return-Path: <linux-kernel+bounces-863862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6829ABF95C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6566585BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C972ED161;
	Tue, 21 Oct 2025 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isRGfygX"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D042DCC05
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090433; cv=none; b=FJhfRRa0nvKtNQAGt7Jxi+t/cF4R2v8oapDeMY8ZM4McM3Wm2e06QRErR+ZeGnt4QjKeesh99jCA0HAm1jXK+y/VlIfxzFcEQChpelmM+vGinJxR9jch2FAu7x7xfI8aH/xCvv+rNRtsP2LO9NDkkhz1BI0YSmd8ctiLBhBmTak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090433; c=relaxed/simple;
	bh=WLRIEtshDzL84rzcliCGLW0ha/QAvCdjX7baGObipwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gbsF0+5dLaWbfBg8PlFcuBgtBZwPePpiEO2HpwCBmdYSDpGNXD+p8H0wUQCzYojKwA/HtGC66fMVC1+54Qy+NIhJ14KVCFBkcDRvW1+2T9VzWOOfjt0S+N/PkwLnkYMuzNEJ62D1knSFivY3+Fry8o0rc0B7J2hhbwR5YRu3HIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isRGfygX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-78af743c232so4888149b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090428; x=1761695228; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRr57c0ypvpAqUCBQClyFAT6EHQRTScPRNGmNmK0UxI=;
        b=isRGfygX3j3kiY9X/b4OtfvTwWRvJM/VJ6cfmc/v7sH/L+5YBWxqGOIarwcO8xCJyk
         QXIiM/pCYVIbiAujF9qK//A3Sj006l9IYbDfDgPXINjzmRdchl5LCHumRxFKPLbkiGG3
         OGYMruJUyIqmbFHhlMtARC0wST+P1gYQCcIC/KCU9iOxMiLpPr7+I5dUd0aawRVWFqNL
         nM43YRXl/+Rv9Jf3iChLrMf91XTatMhHShIJOHp/Outx5iIbPeS1EGt1O0RRKYHZH5kI
         IGSs2qXy0N3M2sd1aOEaWzv9bLkQcUwy3Ksu/VePPRkbhDJrncH1Cx9rk899OC9MP+Hr
         431g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090428; x=1761695228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRr57c0ypvpAqUCBQClyFAT6EHQRTScPRNGmNmK0UxI=;
        b=d36Q3Gb7atzkswyaubJ1ajd1++xV/5KCfzXMvsZK3FSy+szhQDfVhyo34bC3QpB6/I
         9IiuM4Fdm4ot+mxQEWm4As5eS5kCqsCrjlnrzYVwmNp5JM2FJAcylXBxD2N45DRghKdR
         zsw6GKXzjVb8Q7P0U8HapbD6HK9ggebC+0N99eAAgOI8fY3e8h+1YdLg7TOgIfR4BZUY
         qA9nwYvJjfDw1OoT7JRNYgrOu5VbVbolCTTftb8+YNgeLBgmUTZR98tsbZTDo+XOkvGh
         yD9VNaIn/18XKvhb9knKkLlA3SfNv8YwoBrcUnGQJQf0jY/NFKqZnkmFDKkEWgwP6LQg
         9AYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWVKq7O3r8/V70bzt9vbPqzruW4RpU1TQT/VxsPj76W/43FOJLcSooEHb81SzAmnPf8AEOa3su6TwyKaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUL4twiWinWEf5KkH14QPu6AvPMY3czreriT9cx01f02pmj/zh
	PcXS5NrzP6V5ihO2nBao7G4YLHbMgtDaDEg7QYRJ+drrI8s0NmllwvP9
X-Gm-Gg: ASbGnct/X6tu/EXn+Fe2IaQcNmx3i4WMIsbkG7Kj6+zqI/v3PoEo2XDwKUYMWkKyxCk
	bDb83Jzlt/aTCDG2fTQgafJifjzefupxxFq0eDCoZgi7WMQGyvLUrPsDxjlK038kULSeBzi89nn
	Z+WhIn7Y+DnZCGYJTO0u7Dlc5K42EC6Nqh3r6fVseoFaetLED8cwGM/pRbRg+A64RPmECTZSHkN
	eEhwA3w2kB2zpOSBx7zmRRWsqaiv9LNzr3tuD229bKARTz3Xw3LCBzPuJCg82yRlMYRF8SN4b05
	VzNsRuA3jSqhhsAX7Dh8VJb4fNXchwIlfGtCQqV1fcgDrHAPt+6QN3aVAdOPHmqD09RGvqMwkJv
	xIz+8SywNWkX1UybW5cgLEBISzMFJwziPqLLFXYSKpMsYEwIe5xgy5A24y8oZyPZZSiq2k0PjpQ
	==
X-Google-Smtp-Source: AGHT+IGw80QlQNTM0vsCWt4Xrwj7+OMB8f2A+GUNehs8ToYoF6rhSNtapD7Jyv42u/TS1+BhlWruNw==
X-Received: by 2002:a17:902:ea03:b0:28e:7567:3c45 with SMTP id d9443c01a7336-290c9c897damr245660295ad.9.1761090427698;
        Tue, 21 Oct 2025 16:47:07 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472197desm120683495ad.115.2025.10.21.16.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:07 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:52 -0700
Subject: [PATCH net-next v7 09/26] selftests/vsock: make
 wait_for_listener() work even if pipefail is on
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-9-0661b7b6f081@meta.com>
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

Save/restore pipefail to not mistakenly trip the if-condition
in wait_for_listener().

awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
exiting upon finding a match causes false-positives when the pipefail
option is used. This will enable pipefail usage, so that we can losing
failures when piping test output into log() functions.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 561600814bef..ec3ff443f49a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -243,6 +243,7 @@ wait_for_listener()
 	local port=$1
 	local interval=$2
 	local max_intervals=$3
+	local old_pipefail
 	local protocol=tcp
 	local pattern
 	local i
@@ -251,6 +252,13 @@ wait_for_listener()
 
 	# for tcp protocol additionally check the socket state
 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+
+	# 'grep -q' exits on match, sending SIGPIPE to 'awk', which exits with
+	# an error, causing the if-condition to fail when pipefail is set.
+	# Instead, temporarily disable pipefail and restore it later.
+	old_pipefail=$(set -o | awk '/^pipefail[[:space:]]+(on|off)$/{print $2}')
+	set +o pipefail
+
 	for i in $(seq "${max_intervals}"); do
 		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
 		   grep -q "${pattern}"; then
@@ -258,6 +266,10 @@ wait_for_listener()
 		fi
 		sleep "${interval}"
 	done
+
+	if [[ "${old_pipefail}" == on ]]; then
+		set -o pipefail
+	fi
 }
 
 vm_wait_for_listener() {

-- 
2.47.3


