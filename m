Return-Path: <linux-kernel+bounces-885536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCACC333FE
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CABE4E5AA6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD235314B9A;
	Tue,  4 Nov 2025 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYS5PxKW"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8DF309F0E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295952; cv=none; b=pgKKI8Q1UaBa/cABN8YboRDrKSVh5RvkRztd0aKS9RZc5tldYiEfXbfAnVCUFZSIXKlxvhRZMUS1FkMvQ2RLsYXGz2srDl3mIGVlAb+p+HiNcpUfs0VtAPwpPZK41z6LPaDXD/OvgtSSC4vm1wVE+r5LO+CNRnyVLOpK/vhCW2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295952; c=relaxed/simple;
	bh=ZR9/j052YDNAkFJ3hHReoZQ9gREe6fypHqzQIW+W8y4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F/kxt3VS2IxOeEZu1oo8okwZ8tLpC3vIahBXOv90pD0IDIbvi9cC1yGU7vtCdMvLuqgys4ZMgjycTRzl6PsivvMRl2HZ0KFrNuTPXJrt/fF/EQuc+FRKXbvgRedqS2S5WaD006PMa2mb3zSWM/UBtZY/gu0nWZK0MphRhS9YT9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYS5PxKW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29570bcf220so42377065ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295949; x=1762900749; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k7OH/VaXbxgdDQ3VEdnOK5yc54+Zfxu1IfTiRbOYzNo=;
        b=jYS5PxKWCGC96YVaoEPvU/GV3r+WFCWDCkjEsppc2/g9tcCb8RJKJUO/Ol7iCNIiNU
         AS0W/WifMk0vbSaXxR2AhrAyf6G1X355l+R/mRId9n5ZviHQlhji6s8BQtC7TYC36hOh
         SDi7f2iwH1uFJzhC+Cj1QVs8d5AFlbxF41RUqTw+4SQyOW+ll76vVxGVuU7lkztr8l2v
         GpgQRZoxWFtDRlg/nAHdLt1ydlkIO3aDAnFRHemGQnMD0YFkAxGodWtRUQdtzwZ3hmMv
         hUERZ2/yXIgRMmlfaXAB9kkz/9amrb8cC4OO55rrn0g1uyy0HKC11wyVKfxIeqpYh7Dd
         CJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295949; x=1762900749;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7OH/VaXbxgdDQ3VEdnOK5yc54+Zfxu1IfTiRbOYzNo=;
        b=aMV/87RTs2cfteKl72a1zxJFALhIHn2VG2dD7tlcBP8M7RFqFoR/94tU4aRrH0F2ER
         vJweVSJywsmxwx58rYYveMXEr5ErQ7n+i2EvDNfFJ5iS0J+HxJlEUBoIvO+xOQYMz/Dy
         N68bUf0Qa4Zb73mKbeh1aN2Ldo89JtoD+9OFna0U/kP6FxsKuxTnOqY9+R+CTCj/Zg+F
         nypcN3Xsd3dpMDca2K/rKBeibEhrDw9PrU8Mz1L/vREMxvn3pcKFxqQvgqiMYVnHub5a
         MEfRqLbgNOYt8EtMcavRoF3Qhpr9HrjRb5dpFWyGNgi6sRZHYT33TzJ6jqV0olM8Lh8e
         xG8A==
X-Forwarded-Encrypted: i=1; AJvYcCXOqeuwCCPJixE2IAFjs1MvvEHBmM1CY6F8E3wJ74gH4WbjD3aFK5Eh86CyirbSkDtdW6IlNj420XDycEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7w2Kxgkm9NfLa62NAEkYJJeU1nbKbB+n8qMRbJjr3XJ5veQOa
	orYYQPogO3X+w9ANcGpZcwVCdgI+qHA0H8YAv63G9uKqdmsa0Rax2fi/
X-Gm-Gg: ASbGnctH/l7TxfMOMA+cMskP9TH/dNK6MnzmpkFV1nDGjVBlRaII6D0jHu0qImdPQZd
	i++JOa6IL83it8bN+4CPFj6zXEyZSPWyRBacc7BC24NeZtnRWr/OlXU+SZkD6hoby6tQEwJtujr
	LHDvZXIMqp1gHECoy8YBGTfYSabqUArqqVlYSRja69Qns6h8yimvsPRv5RSCxX/Gg7DVrtdFeAU
	0z0swxwrVyycXI56HaULBnVRMUlIZsYQb8zgtYKzSisfjwPD0e4fy8U1iZ6c7EAXbUDoIsGXN50
	67tjGEn+VwCOnNqkSuBkQmW/YOymI3IBq5YaZ+LkqC9OKp+LCypSHpl+hPihWtZJq/F0GgY3bX+
	jZarq7ZzaMZxxqYD6up4aFkGk8X31D1s43KB5penBKnGbS9S4WfR2KzARDkJscbPDb334s9wcLQ
	==
X-Google-Smtp-Source: AGHT+IEf8Nrub88wm5PzVqxHEp7+fQp/JKH+iJ9scU23Jg6FQodVkNNRoH/TfsmpGm25Zf50pWGuAA==
X-Received: by 2002:a17:902:dac2:b0:272:dee1:c133 with SMTP id d9443c01a7336-2962adb20f8mr14797755ad.22.1762295949382;
        Tue, 04 Nov 2025 14:39:09 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5d174sm39069295ad.77.2025.11.04.14.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:09 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v2 00/12] selftests/vsock: refactor and improve
 vmtest infrastructure
Date: Tue, 04 Nov 2025 14:38:50 -0800
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHqACmkC/52OywrCMBBFf6Vk7UiSvtCV/yFdpM3EBm1SMiFUS
 v/dWAS34vLOvZwzKyMMFomdi5UFTJasdznIQ8GGUbkbgtU5M8llLbgUkMgPdyB8mIgUCYxdkEA
 5DXaag084octnXrdVxY3ppVEsw+aA+zKzrsxhBIdLZF1uRkvRh+f+QRJ7/5HJX2VJAIcKT21pt
 BywF5cJozoOfnqr/6Khzpj2pJuqKb+0btu2F09HTHczAQAA
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

Hey all,

This patch series refactors the vsock selftest VM infrastructure to
improve test run times, improve logging, and prepare for future tests
which make heavy usage of these refactored functions and have new
requirements such as simultaneous QEMU processes.

These patches were broken off from this prior series:
https://lore.kernel.org/all/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com/

---
Changes in v2:
- remove "Fixes" for some patches because they do not fix bugs in
  kselftest runs (some fix bugs only when using bash args that kselftest
  does not use or otherwise prepare functions for new usage)
- broke out one fixes patch for "net"
- per-patch changes
- add patch for shellcheck declaration to disable false positives
- Link to v1: https://lore.kernel.org/r/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com

---
Bobby Eshleman (12):
      selftests/vsock: improve logging in vmtest.sh
      selftests/vsock: make wait_for_listener() work even if pipefail is on
      selftests/vsock: reuse logic for vsock_test through wrapper functions
      selftests/vsock: avoid multi-VM pidfile collisions with QEMU
      selftests/vsock: do not unconditionally die if qemu fails
      selftests/vsock: speed up tests by reducing the QEMU pidfile timeout
      selftests/vsock: add check_result() for pass/fail counting
      selftests/vsock: identify and execute tests that can re-use VM
      selftests/vsock: add BUILD=0 definition
      selftests/vsock: add 1.37 to tested virtme-ng versions
      selftests/vsock: add vsock_loopback module loading
      selftests/vsock: disable shellcheck SC2317 and SC2119

 tools/testing/selftests/vsock/vmtest.sh | 332 +++++++++++++++++++++-----------
 1 file changed, 216 insertions(+), 116 deletions(-)
---
base-commit: 255d75ef029f33f75fcf5015052b7302486f7ad2
change-id: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


