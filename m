Return-Path: <linux-kernel+bounces-866051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0E8BFEC84
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD5319C5454
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BE424339D;
	Thu, 23 Oct 2025 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWanEwaX"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C984221D3E4
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181232; cv=none; b=UZVTIMq61Boxqxw16tmhthqLhDiptLp3jcTwU2bBruddyzzDANFyjGPVb5QeLuHX5Abdf8pHmtPjmw+3N+Dh/PEiKgLxA28Joo6voeiQuGsANpkZuGzfC2moY8W8Q9DSXkrBR7y7DGr54Iw8HXv1mu8hZbaJ3M1sWrCo+HctNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181232; c=relaxed/simple;
	bh=4pbEdZWO3naganJPGX2hHH04O1jq6bd0JAXIDNigrjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XP9JWNI6+vM22rMLy2z6/q0GwcRvq4sSEn8QVJvHu6tn5n66QAkbjSIy3zzxIy1Y7Hs70CIGqkxkZGaUAY9Zt1gU59hAyRp5ydkza9GGHCXBE7GTJU32KyeiO0G2ufE1iUsVjjmCU5hdf0+YkHtCtkcIRktT2+L8GLJk8/Maxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWanEwaX; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33ba37b3ff7so238833a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181230; x=1761786030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXOvnbfPKIC6rRblSxQAXqJxbJ18ywkGP6EdCLVk0Qg=;
        b=dWanEwaX4qyY4otH9BIzAq4fA1PfDUzVMnAhcpgGxSQyKL+3vz8DfW0CJNO3jDzZHW
         6AznwGs1VHGdF9gJcRWkbMC4eGVyGrf8raqGZNC7HiarvVLWYIeMo3/Dr+0nRUcH+++u
         wOLkjgy+6PMi8T0Q4WpXsNpW/QTkOW+PS4X9ziI+/tvkvpKMwrHFMV2N699B1th2lLD7
         ENwQOy763hnuGy+8o1Hgrgz7zC9GPWJpBFTHdBe7Xku7NcgBfyXHhBZv6jFJ/f7YLIVX
         MxpAsD8tPLnPust3OQtJKjMn1Wc5bdkahzrF2Ez6Ivq7XW1YzCeoXMD5Ok5QEQVxkv6a
         EPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181230; x=1761786030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXOvnbfPKIC6rRblSxQAXqJxbJ18ywkGP6EdCLVk0Qg=;
        b=R4u9qGXRN92hFwK+lZpF4smycezNqcUjCdWQEh6WgzSSWwUkGFztNHX0K7QCVQZYWz
         lNt5HRwf5lLnNqqsEU5cIMhKNppEBp9ND5NVq0pecr81BJwe9Xi0wUGGh+mpKR+t3sGO
         iI54kiMy7Djo2D9zlf9i7qbsaBhGzHKh3L6ozAt5If5tmhhitmOLH34HAyPALcdwfmCf
         LAP36XXfWNt6ujZqscX+vdSD20YaX8gwjDTiwoP5CX2Yj2tWQj1H6WspzraoIVRb4zu0
         sgbX0Hg7rAoELsKuqcxyWkOVcZiEMOP4nNkiD2l/WMtdGnQZ1Sn4MDf5mkfdkhrifqiD
         6VwA==
X-Forwarded-Encrypted: i=1; AJvYcCUf0TWR+l0z6I6pJJak4w4WTzfwJWNh7+6hPRbi2+dbI9TCWNBEfiCqviYId08EPWuR+RV8Lu1mTb8oss4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7VBU0aVf5XC8QSah8z+cwrU/+u2gB1u/d8dd/ZNMZoHEhpYv
	TnOO0L86FaAjdSIz6D6iE1DDofFUsR5Q7CJzgkmQTS8hKRUXHdqmbPmY
X-Gm-Gg: ASbGncs9Eg0++s68fqJDTCID54NV4EKOgIt8wQgb6B6BYJAUVfntgDo6gxRWdOlmp7M
	l63iGsOc2NmmiYBznu5Ith7RYtlzvNfZ7qeISDZyhU/oSsNqLklf5F8PQSG55raiNvWo6xhkHUo
	uhjfTJ7/HR3OTNpvBodHMWnZhSq67385vg5JrlYZ3EziT+fIsYWZOoUJagsyfT9SZwzvD/11HEK
	/H+9KcYkeefpm7iSxyPUtDTvCdY2hlBIBxui6TmBiuwbVrLJKbU28xzWxCPXS2iwWDkpAy+9gO2
	oTbD5X+TyVssbIzLqBYoSh/eaaLGphggWjrg44pUM4eODI+wMqhv1iH46ljTy9uAJsZY0y3h1El
	PBqgs44WvK29XTuJl4uggwJuzlfyH2S0YcnxgkOfJM+lidREgNNSJDOsFGOAQDGrXAW9ShOT9Bm
	RzfdHwZoc=
X-Google-Smtp-Source: AGHT+IGDhjee3qb0RmCmk094kyxxRhSnp6cpHy/pZvteX5hCRnyEn25K/Mo2iLuTUZkw6wAqEltkkw==
X-Received: by 2002:a17:90b:4a03:b0:32e:7277:9a81 with SMTP id 98e67ed59e1d1-33e21ec3286mr7594732a91.4.1761181229218;
        Wed, 22 Oct 2025 18:00:29 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb016f865sm491272a91.11.2025.10.22.18.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:28 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:09 -0700
Subject: [PATCH net-next 05/12] selftests/vsock: do not unconditionally die
 if qemu fails
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-5-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
index 9c72559aa894..6c8f199b771b 100755
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


