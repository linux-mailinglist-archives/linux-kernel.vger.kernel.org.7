Return-Path: <linux-kernel+bounces-761047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4B7B1F3B7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB2E722149
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDA427FB18;
	Sat,  9 Aug 2025 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jq6ctYQu"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6526CE02
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754731576; cv=none; b=HXuBfZ2f7XBny55cq9SUbmfcPiT2ciGyhGtvmQnBTauDlQfZT8FmGxkjSO7N9sh0lMGDlUNdg6umzhBKaw8hT2N8pV3ljtM9O8CL/BQmYIxsooDHnaMsKVysMviR/2sAm0hHBDUtOTipZjojM56KbQmwebA4uVFh/Qy5e5SmA3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754731576; c=relaxed/simple;
	bh=JI7UxsnlFe4V69bsEG+B+RaGNll1vaMtUV/O2Isv0WU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RCD2ARISWjby1175t9H/zF53h2s6xxX/87NldEHH4COeumt5lWpVyq5+1qwiNBoyxoHty8qBq1s4UUQIux7yjt4a6/B2uhNf09rYI6sNHNBwFVLr+vSoY1WfLjJ6MTovDF3CbW9xy45jDHrBnJSlBEmVls0zPw5/oaIpRTZu5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jq6ctYQu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2400499ab2fso24581235ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 02:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754731574; x=1755336374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=taB2S1kc21QQVal7yCU/KFHfBisPj+YfeRw4O/7Vlq8=;
        b=Jq6ctYQunWcwzpcMvgVe9Zu8eioRElJneCISA1k/RHM2nff+UBINat7scoqCtLsvFN
         vOxr10+VtGQN7rmL1NoFwUcf9R2oOgNFt/mqm+ABcDrfggJvIQUmIcCE7vVkP8jUx8ZE
         C8DTpAxLNI2fHuXm7i/n4trXjO90rTgxZ7xAUrUE1m01Bf/eA9fUzt2HjzxVkXCabv+S
         JF9AupFxWLUGiKfcZuI0u6kLHjwrsSJzLsqLs85D1Qm/iSYARQFJMNZNBOxvZYRZ3mTW
         304E9udBeZPyugX8f00PY5aPO7/+opLPrQbpbZsaDceWiOPwwcWPPIWvm5eXP/MuR2cp
         JmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754731574; x=1755336374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=taB2S1kc21QQVal7yCU/KFHfBisPj+YfeRw4O/7Vlq8=;
        b=ox3MSkvdEM/mqbF2XbtTzEBdzZzEgaANtJxUxUqGaSq6HkYcStYiUoQr/whkMBtmvu
         BXonRK0tKSYT3p0aRQKMQBUXeO9eYbDMH/3HdbSu4nySmx9CrZjLV7S8bIWuHD9dGsGi
         fXVN9azL5vN9cASiksIw+SLFcathuCLpqzMucJ/vlnxDPPPloXt0dzCRNEkBa9CVYZ0L
         ReOayU9cf7w/mRVlYN16Ax8eJcOANPePtACxy4ZVv+q4oLltZtNihpT0rNSDkpcmCG1f
         6bPIFQgO3CugsG9YZAFzYu3H+8iz1KsMwjlPyNMRNFMyBopGK8c0TCYX7JANEPeMPwAS
         VvAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUQjZ5UKkR7OkcbTvrZkPk+Qpp79qwctrQfX0etYJngwCDx0C74RCBmbU0trhlQpKMczX2g/sbxFoNBNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzARkTcGQhGWgVJ+g2rCERwe95y53e2uZ8RDI/wmr2tnFdU194c
	eRFV8+U7+Z1z1VplJZoD+tvK7UAJ52m8j6fe6zTKajkn5baADWnx738D+sGh7khapc4ZTJGyW5o
	uGw==
X-Google-Smtp-Source: AGHT+IF67/5BRworf1OUrxxyHh4xaXb8ltchvm4vHnd/z6Gz/vfYWC6tHpkj9DFfS+wBIWceaYaK1BsjKg==
X-Received: from ploq6.prod.google.com ([2002:a17:903:1aa6:b0:23e:3914:f342])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d07:b0:23f:f065:f2be
 with SMTP id d9443c01a7336-242c2217718mr92708095ad.26.1754731573971; Sat, 09
 Aug 2025 02:26:13 -0700 (PDT)
Date: Sat,  9 Aug 2025 17:26:08 +0800
In-Reply-To: <38bbacc3-625d-4071-889c-a5b4d59ec456@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <38bbacc3-625d-4071-889c-a5b4d59ec456@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250809092608.2457522-1-wakel@google.com>
Subject: [PATCH v2] selftests/binderfs: Add CONFIG_USER_NS dependency
From: Wake Liu <wakel@google.com>
To: shuah@kernel.org
Cc: Wake Liu <wakel@google.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

The binderfs selftests, specifically binderfs_stress and
binderfs_test_unprivileged, depend on user namespaces to run.

On kernels built without user namespace support (CONFIG_USER_NS=n),
these tests will fail.

Instead of adding a runtime check, indicate the dependency on
CONFIG_USER_NS in the selftest config file. This allows the
test runner to skip the tests if the required config is not enabled.

Signed-off-by: Wake Liu <wakel@google.com>
---
V1 -> V2: Use selftest config to declare dependency instead of a runtime check.
---
 tools/testing/selftests/filesystems/binderfs/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/binderfs/config b/tools/testing/selftests/filesystems/binderfs/config
index 7b4fc6ee6205..7d5f941d03a8 100644
--- a/tools/testing/selftests/filesystems/binderfs/config
+++ b/tools/testing/selftests/filesystems/binderfs/config
@@ -1,2 +1,3 @@
 CONFIG_ANDROID_BINDERFS=y
 CONFIG_ANDROID_BINDER_IPC=y
+CONFIG_USER_NS=y
\ No newline at end of file
-- 
2.50.1.703.g449372360f-goog


