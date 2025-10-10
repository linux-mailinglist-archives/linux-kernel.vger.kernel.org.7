Return-Path: <linux-kernel+bounces-848494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9E4BCDDE8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DBCA50021F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BCF2FB991;
	Fri, 10 Oct 2025 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bibn0VuR"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7D2FB98B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111282; cv=none; b=L3hKzJHllW7M/ib7VIuUSpUEsDCK/q93hNWlJnaMG2mKOuhrBjEEITcKOc9qHs2kpFuuQdSZKTnEAXitXf8AGIjUVK2IlRP1O3MItT1X+WY6xKLKOAoC6SNB6QCl1OXv3ktPONS6aS/ql1UPW189zUSU6I4+/MXYDjoZQkVDcqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111282; c=relaxed/simple;
	bh=NdsUvpJDpi+f0utptiH48+P8qxTjCKD1BXdBqHb5OLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NrA2IZHg6GKu2aAAALtiX1aS7ydu2XnqlDl8Wz147yP17xXSBCPWB6B4jeDmA+uGcPtcQ0baq+xRSDraymLeO7X33dhPJ0eWndK5sABfEKJ0gwt7O3ZxeahaEKmGIzMvbEVkI5hrlQPG8Wn+GjxPK9l5BjP550VskqNqRftwrOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bibn0VuR; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b593def09e3so1506736a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760111280; x=1760716080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVrsyEiFlMWkB/upPN4SEiDIc8/lApQ9S0UUM9Wa5uQ=;
        b=Bibn0VuRo1gZ1Ith6+kwbMQxRF6QJO82MZ61cWDTgQ0zR5kc82761192OgOYQVDdf5
         FSjvU8NTpGPcguygjMc8zxB32iZFmGePFDCc6rfhTuQ2nkDI/0ehO+M9GalPGJZB/nde
         zauySeYNGccs8gPBMzVnvYXdfuN2+98Aqx2sT7LXKfD7ZPQfqzmlwfBYeWLFnBUgFm8p
         29VRElBHTnqn8xnsuYJPi6A8xnIup6C/2pF0NImKCx2TFlGdsAYrwUKEHCZ9RRhk546U
         Q+5G1e9A4WCIewy5KW04z2U4+/QdHYlDtH3+uT1rsdu0sAyVxe4rIfnnql+NNPKaOLLj
         fHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760111280; x=1760716080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVrsyEiFlMWkB/upPN4SEiDIc8/lApQ9S0UUM9Wa5uQ=;
        b=drtXUTx3n8a/ycVSsqBrlXAaMJybxxNDPUEXFSCWyvrKagr9WccYAeeCIiZdK6L8PR
         2jByip8NPR5jQs8/8YnkDjpqASQ4FFoH0AXyOldOSY1Rhizyi8HHqjQEdyiJ3JNgwc7C
         VjptTmTFw09DRrvjZIpgX1jYP+kvxPuxFralrZjzWufOOndBCyOtau2G0Nuc8r/Rkdyg
         dewjZNyunAptF5KUazgP25KkQQ+yRiedUARDLU/ElCgq2dEchqE0HPk2PV6KYbPA8Tv7
         ksu43DoNCj/1wEDE+mcX5jnCAAN05S2ic5qbFTTaw0Oym1Bgce9rWvsyVrmjhBH5Fgd2
         9lug==
X-Forwarded-Encrypted: i=1; AJvYcCUJfGSgT1t57wjOvaU2cpj11OdWidbAqu3ecX4gqlhJng/kQORYw1PRHapz+OqW45A1Mkvs5JO4x5Dx+w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrHfFhBq/eEqLStlevkInZ2mt6DeQYxtmdbsRM8zsF63qQM00o
	n6/c+hTmVW7uBwS/yM1rmBO+oaBl8njhLroRq30V0yQXs5DZTOgFXDr0Tg1QP9mFfMA=
X-Gm-Gg: ASbGncsNt9ao69X2nrnuxZqEnUqky2YmXAgIk6yyeEoCjRIa4y2NmqMqSuNvCnmjudN
	aY9RzBihiKTsGTMbq44cgjojZAoptJqYjfJgSi8Q4KuBFBvYU6GZjvAAMY9OnUVh9+3wfO3+ecb
	WbT8W132myXz6PkDwO6s/JG/nArJpS91IHg781G7r/rfjw0hu5rzsIE4i90lOvJxmziXdqFYE6M
	tD+zdSOKquG9nGYrceHGBVZ8AlcLKZjU4CRcv5tqkLGm+KbNnpFggQitdReNbJ/mVBH/TMI+Zi1
	Z09HlgkfA3u3htQ/hBey3K1hgCjhD2G4U8zFryFvgcYuq9q9UPWP8nCbPuQzlLQShhjJrqoFf6p
	hZxRinlZfMbefNRzyBpPkJbl4+qwyZKdoHSWn
X-Google-Smtp-Source: AGHT+IECq+NaLToeqvLCJlAHobRhWtoU2tfGHlHLrRwiIikFaVG8MgZK2PzLWaGJXCNyUhyUAiHnRg==
X-Received: by 2002:a17:902:f608:b0:278:9051:8ea5 with SMTP id d9443c01a7336-290272b340fmr165277955ad.21.1760111280220;
        Fri, 10 Oct 2025 08:48:00 -0700 (PDT)
Received: from localhost ([122.171.19.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f06c82sm60691875ad.81.2025.10.10.08.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:47:59 -0700 (PDT)
From: Divya Bharathi <divya27392@gmail.com>
To: linux-fscrypt@vger.kernel.org
Cc: ebiggers@kernel.org,
	tytso@mit.edu,
	aegeuk@kernel.org,
	orbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Divya Bharathi <divya27392@gmail.com>
Subject: [PATCH] docs: fscrypt: document EFAULT return for FS_IOC_SET_ENCRYPTION_POLICY
Date: Fri, 10 Oct 2025 21:17:53 +0530
Message-ID: <20251010154753.19216-1-divya27392@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Divya Bharathi <divya27392@gmail.com>
---
 Documentation/filesystems/fscrypt.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 4a3e844b7..26cb409e3 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -729,6 +729,8 @@ FS_IOC_SET_ENCRYPTION_POLICY can fail with the following errors:
   version, mode(s), or flags; or reserved bits were set); or a v1
   encryption policy was specified but the directory has the casefold
   flag enabled (casefolding is incompatible with v1 policies).
+- ``EFAULT``: an invalid pointer was passed for the encryption policy
+  structure
 - ``ENOKEY``: a v2 encryption policy was specified, but the key with
   the specified ``master_key_identifier`` has not been added, nor does
   the process have the CAP_FOWNER capability in the initial user
-- 
2.51.0


