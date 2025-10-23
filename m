Return-Path: <linux-kernel+bounces-866048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C83ABFEC78
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4973A90EB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420A02153D2;
	Thu, 23 Oct 2025 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7Zg7hB5"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8991D63C2
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181229; cv=none; b=VtdhL3KmvqwRlcfY2OtfH3BX4UEGeDh8jMrteLiH4Q6KBejAVh/+zZQK61DUlVzrluRhuPY65kirqAKvmIQJ866yuTToiKqBVbOAsIqATEA2A4baec3XS6B5q1/MDfK4mQutBOWPCIi2S/70/Q60BuBWiOQubvOew7tTRTSemno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181229; c=relaxed/simple;
	bh=WLRIEtshDzL84rzcliCGLW0ha/QAvCdjX7baGObipwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A26rMo+Hj5ScJUTNr6pujEnQzrCnUI+x9PW/6L1qULPP7i4Y1cSu5NNzFaxSXbu5P6O8mx6ZsSYbJpnAxh9vKHI4SWsKBsYi0cRQrYa7oUQ26bZKxBGjCG18fs6AEPHPosYkALMF/4vhdE5/UraIi//LX1miudeJc1GOV3yp2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7Zg7hB5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781206cce18so221188b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181226; x=1761786026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRr57c0ypvpAqUCBQClyFAT6EHQRTScPRNGmNmK0UxI=;
        b=G7Zg7hB5B5G45aKO6sGu+HGKhvFnVHLdPiId/ttbkZ6v+Zll3y72h8s8Wr665LO85B
         I3iw4/PfcphvrSF8G7cnjKKMP9RXmlgEDHF9uALyCBg+OdVX/SOpEap6o0Ui4SMkc19U
         obrFFAm876jJwFx1VLZUOrAEfoHIxP+mlxgukO45L+pqlvsU5uM+tui/zOeB02cd+0Kd
         nkNBUH/W5ocT+Zn0Vw5ZPmz1uwVKxq19dVrS8Qr99BhNtE/01ftfMkOvOVukgWeg01oE
         TyTzaIOgfN96ex5WoTh6SZ2UW2A5Yeb6mM6gI10AyKAsz1Acx555DTNINgeT3vFn0KMD
         V7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181226; x=1761786026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRr57c0ypvpAqUCBQClyFAT6EHQRTScPRNGmNmK0UxI=;
        b=WEk8EUebX3dMzSmxa4X3+j/Qh/5REH5rl2qcZog0D26nsZHt2kmH2LrZZl6rRef2mz
         AwM4glcYCNhu2A29bXOdfsSDYVk3TmEtksJjGmNPlP5YQkULRPAyngx3M/41Nx59Zn0l
         HdA+oXadLfl0pdXQXrbi5EmjpG40/ykYcrkCUsVGVguU6v3/iwHBoXRvOxZkxZJwoPrq
         pEAghBmbYRirICZdWkmnSTWLp5Og1BXOuGm+G6ua+zc24xL92jkFtFS/qZMhS5Od/Avw
         pPJGtdADAYmSaqDUr2ZapTVznwQElBjojp95aKnYChGC9F2HrUEvdyk9+AQEcx0PeDjO
         6NMA==
X-Forwarded-Encrypted: i=1; AJvYcCWfiMNqMh7ahcGGRSphTIvKe/ePlSJ4yDdo+CI0eDE/u9NHCoDr5uRfKQDw8ewTeO9o4iObHkZVM/2PpTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx18Vd8jJvXUG13cnjIaQJhT2yKTdWtuHKDyG1yUbbin4J0c45q
	SXmzEGifH60OY103zp7rr3vFh2UdE5Jk4Wb0g1oFDTccQCOhpDv19otf
X-Gm-Gg: ASbGncvFy7ULCKaww2GhEb0erXJ57GodkPHlahjOQZ9YnM3G7lDKXbnZGw6o3oyhO2e
	4t4RoTc4i1+7iGg7ylTu3D4dv3X1XlJ2IVUdTuh8oLYym9J7fSApcq54e4BTCd2nOjcc0Fb9oER
	1JPH33jHKMSpzOSfO95L1hFmQsOWU56Cbhz74PaQ9RGtdNibrgvN3sGtsBMl7ChNEagrpNoxHbp
	clcZ3ewBEwHzAjcCA+J7qF+0xkdKa9zZbWM8nZ/YM0PQHVl+lbxSc9sNiePQdh6xoqTjO/id9pk
	YyGULQ5vre6A1XZ9K9sBxlP578WtvpAV6ttk5FCSuCXT8IqGqGjDY6aNlLY6vGpGgvgtQ6Z/1U4
	hrjt98H3qT7y2oGkY8NniB3krjqRFZDkz5VijT+gLZIJ2p6LJLWUrKLamOnw8HIYETnnZYxi5
X-Google-Smtp-Source: AGHT+IHg3+CWJSd/e6BOgzi+f6DN5y9Cs7OSFyBJFrkPqO6Uo3OZWXDmlV8rzUOGTzBmE/tvar48Sw==
X-Received: by 2002:a05:6a00:859d:b0:77d:c625:f5d3 with SMTP id d2e1a72fcca58-7a26b3137a2mr3513332b3a.1.1761181226239;
        Wed, 22 Oct 2025 18:00:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9ce15sm576231b3a.23.2025.10.22.18.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:25 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:06 -0700
Subject: [PATCH net-next 02/12] selftests/vsock: make wait_for_listener()
 work even if pipefail is on
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-2-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
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


