Return-Path: <linux-kernel+bounces-778904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E234B2EC91
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904EE7BF5DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCC1223322;
	Thu, 21 Aug 2025 04:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNIC38Aq"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C47213E6D;
	Thu, 21 Aug 2025 04:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755749049; cv=none; b=VPMKZumYq3Bngdx1/+/u3G5aEVziBeqU4rcmERjmGSXMNjQ7D+VIYOPQBU61O6D6R4elA42rPIMSl4fnvpJBM0qXyXKWZMKSxDCX6nV+4AqzocHPmUTElEl2BwV7dyAVXs5bRrHemv1LNu0UAaL/ExuBdbxiBCaz6t4fvhMF3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755749049; c=relaxed/simple;
	bh=8HhYAoV/BhODxYozpnKNsVVfBzqgzX9M8dABC6wrTbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VAONnPYO6Cef44VXRg/0nVElaqmnBsECP56pDDpfQhS6q8MXdsjsEpWE9ldnQVueSIxGrzcjq6Y6rK1CSCuVNnPA+Afhk8PSdWjNHdYrhFDWRt4SGM+TRArrg5GR2g+3bF/tfoDQOPkQieNyiO6pprCcB42xhPifESLUdUmgmvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNIC38Aq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e39ec6e05so509262b3a.2;
        Wed, 20 Aug 2025 21:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755749047; x=1756353847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkegwXPAPXDpCDg6K65jGaOrXzaCQE3Ssl56daG4mNQ=;
        b=ZNIC38Aq4i/N16zPV0mwt2VGwffFfMtfPQ6qYzVzpup62BAVQjP2/7ke8OdVv5BWdc
         nh6f0xsWoynT21YcEYiqG4l1ficmJvgJ4Q3Zb3esHkxynmXKv5b2bXmp9rysheafEgYH
         npQWpxiWYVB5ZiK7w8W8qlM97Wtki7oK/nYcbyBv/0rNuq7vISAY/Wf5zUMiQMVTMl2c
         o3lcYfVQ9DNb8dp8ldFA45k2/ITG7wKrn5zwVBuve/C3YndJLJ83PclgOKEyDq810nts
         VMvKjEIJ2f1twPTqmJzofwaQ6vlhX+UVt5stHR6YE8vu/LU2GbCyIayDIvKbbCu7XWSb
         TckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755749047; x=1756353847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkegwXPAPXDpCDg6K65jGaOrXzaCQE3Ssl56daG4mNQ=;
        b=ugUPYcsd1fk/JqUA1MYErkhAXPVVkNC15AFuYnXJnm4OsL8Cm5ryUxxxko0l6wt+Mh
         1KUwJhx4wPT9zPLrwvaLUrtQ/ndeLDNTVki1yPK0vffTLPcHtlOULClXh7FbAQ37lZaI
         2HjrfHJCTWTiBkAXPty6jE6N7YHQPqZaViViJWhBasjdzFe3Dm0XTHJxqgfcwidXg9qm
         4atqYiv7j7Ii+CfrJw8rPKFlgC2kvUjhC16jJW5+5k6oyu0Npor2Osi/Ad7JXtfnAOcH
         zrB3plbJWc7FEv5ZjZindqGZSNOvq2mxVczolDyxP60mTGsUORG18hcuDWsj/0/vsn5u
         u1Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVe+AlLilvcP/ulW61YVH3oSVe2FXPYcMfOQX233P5G6SYur+FEhBu+wDaXejeclqHv2uZgsZ9lTQcq+o0=@vger.kernel.org, AJvYcCXDTCaimeIIBVu9ymyUCraTpVoe/sOA8I1MXm8SYtEm119dj/fZFcmyfRt+gYL9T/6R1vv8nTnYNvZWzWguENc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbPK15wUFbvbE830yAFjfZlXZdMin8+szgxYLrc8gzwwyBzUhB
	yrsOLE0EPDCHseGA0ctB8MxKl4DK9h//YPKPxJY9CF5pcE4lKuVvpDka
X-Gm-Gg: ASbGncu4HlJn1LYmeireMHKvRFijWUDlWgjSPMet0No2yMYfuS93SXyw1uEV5RGMS1W
	cLSeYRlUfRscKB9jkZnmb+JPWv/Ur+9BnPPVyva5OAfOSQoDPMKICOmHFMz7LA/c4IjuOSxzSnW
	KeNljSSQmPXrpe7xfTyQWXFnyA8HnLWG1rjK3APDFqZzyP/g+HhZ4fVACaLdHQq+G+FhAMfeq63
	xtQRe2A1THToekaSJaqgL1gVEZxe9yE7zQ/TcDOmIGlBNp/wMM0p9ZCbRoUvPVZ+crvGmKsadE2
	RdHJIb4ahDqTxiIo6WrOeKR70Yxbbnh7/5hXhLH46mmoIoQUchbdZX7/VPj4Mypg5tzkXNPycSW
	FNRrUzbIK8Jj/cqmXxvl1DUqIPGG6lqPsI6EsyN88xBiW2bgVaOTvQE5Oy0KOBr0czCLzE34=
X-Google-Smtp-Source: AGHT+IHv+o5FKx7uEybGMQvX53ZFRsQjBWYD/TpwpLt/OVUcauEFvmymmfXmLmnMCOJzsA8Ju0zG+w==
X-Received: by 2002:a05:6a00:4613:b0:73d:fa54:afb9 with SMTP id d2e1a72fcca58-76ea3152024mr1379044b3a.7.1755749046896;
        Wed, 20 Aug 2025 21:04:06 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7f0b4f0esm6538714b3a.90.2025.08.20.21.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 21:04:06 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org
Cc: aliceryhl@google.com,
	anna-maria@linutronix.de,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	frederic@kernel.org,
	gary@garyguo.net,
	jstultz@google.com,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	lyude@redhat.com,
	rust-for-linux@vger.kernel.org,
	sboyd@kernel.org,
	tglx@linutronix.de,
	tmgross@umich.edu,
	acourbot@nvidia.com,
	daniel.almeida@collabora.com
Subject: [PATCH v1 0/2] Add read_poll_timeout_atomic support
Date: Thu, 21 Aug 2025 12:57:08 +0900
Message-ID: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper function, read_poll_timeout_atomic() to poll periodically
until a condition is met or a timeout is reached.

Unlike read_poll_timeout(), read_poll_timeout_atomic() performs
busy-wait so it can be used in an atomic context.

This patchset can be applied on top of the read_poll_timeout patchset (v3) [1].

[1] https://lore.kernel.org/lkml/20250821002055.3654160-1-fujita.tomonori@gmail.com/

FUJITA Tomonori (2):
  rust: add udelay() function
  rust: Add read_poll_timeout_atomic function

 rust/helpers/time.c       |  5 +++
 rust/kernel/io/poll.rs    | 90 ++++++++++++++++++++++++++++++++++++++-
 rust/kernel/time/delay.rs | 34 +++++++++++++++
 3 files changed, 128 insertions(+), 1 deletion(-)


base-commit: a3b971f57db41ef1c68f842cd3c2c00b3df54ce4
-- 
2.43.0


