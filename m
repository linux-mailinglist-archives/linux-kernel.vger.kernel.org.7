Return-Path: <linux-kernel+bounces-731048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C6CB04DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44B11AA4448
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8A02D0C67;
	Tue, 15 Jul 2025 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKeIkq7w"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0492D0267;
	Tue, 15 Jul 2025 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547386; cv=none; b=NW87e5O42rQfehlAqsa4bm53MsXK3DQQJxHbi/mdxnxlKn397S84wvm3om9Es0c6wND0SEeglKVP2CGbVa9GqzVqTjUh3L7dV2XbNBSQB2aCACDuBx5qdoCCUgqRgHeuYVmf7CJxGTGU4klJVtDXxdUv0cE+Nlj0WVSqwkGHviM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547386; c=relaxed/simple;
	bh=HfggKZMScSG5PInVPAEiu9BcbAgSjeIm0cNHs/Mze+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cERf6LdzoT68cql15vxfr+bu0xQuOhgMOava9f8XCFqpMTYlZxfD4Y1AQuXAe9Uew28M8JLJ6L+eppk898CNUVHAPUscaQPqt35yC12+Pp2bR7HVfcO3gxdficLcZzZCfbHsu9zTgxzKgI60XDhVpDjIPPtxPzgvKU3SlLKVXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKeIkq7w; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234fcadde3eso61483475ad.0;
        Mon, 14 Jul 2025 19:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752547385; x=1753152185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+IhnlwVa/YxW1HoGKmOL2o9CXtCeczDjvZyWJT5FCo=;
        b=IKeIkq7wKtzP4/UpBYmlfxvV0Nm8x3napt4B/keCL0DcJUDbhnaPHzWKc9h7s13mAv
         5tSY2Z47Xmly3yBbCPcfBbMO0z3hRbdIRYq8fiMri9eOYkJtfJ6otwES+lbnFVBjbUYI
         XhtoeS9OsNSGbfS6rH1DnXsz6OOhaum5LWusLP3+CIbuUTLbJwD5S8EaEj7usRAouHUX
         ckoIpOw1yj47Dl5xzm9pUX1S4UvJIhtFOZMtY31sa57kJ5PwXP4xm5C/BH/sCX5goa2y
         JUU5VBjCueT3PDH/+F2l+rqCId6b3C8/O0OemHzXDDzmZ35ZvGE651OCmIdd812QCwiw
         20nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752547385; x=1753152185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+IhnlwVa/YxW1HoGKmOL2o9CXtCeczDjvZyWJT5FCo=;
        b=Z+Mqa9ux6gFL5vJceugdzNSA/oYSwtOheAKTpOCMK2Cwcx8sOedBemIZZ3M/GpS/XF
         1MPosb/MXiEmWLPe5/5PcAGJR0adlt1KdSUht0OwVNsXvvTLLPmKyUGaQAKg8bwF9AZv
         S9ja/r0xO18UQ78IqWtCoPL654JYTGD5el1hatKTiOtS6Dv7My//D/8Ji9QN8N5LIyzQ
         JNHsS+fFgKwl2j6KeEN8R3aUUcmeQ/oq1wTME0KFOtjE9Ph2piq9j/byvpe3vyHpYZOp
         gu36oX7OKOIXbedRS5pjOGECXfIDC8xsKwb6TayzFz9alRgQFd+metVWWBSke5+wq1R1
         HBeA==
X-Forwarded-Encrypted: i=1; AJvYcCVoPPIhFh3Hy9yiCvdLUQAXiJ4RPqitO7ltJoyLLtQEKW7vEcDP4w9wgpWNhaunNublZmwGFVLPwKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykeSyjWogPBkvfEt2elEpp9/586/j0i45tuhAzN8MuMQDrW26P
	aeGkxsRnZfyJNLhYutCZpmCTPdKMt4dLLD7MIMv7e61kuiLO8i7AwRIl
X-Gm-Gg: ASbGncsAsb10CLUl5dm4ykDxgaaklXXKpoVSYhiTiYkhtkEWWhuX2Wl6kPPjpUDtb0W
	+sdUbgpVULooVX2q9buOUToFZRDaxTwj8cLA6jCLtnaxVIp2RN+yUvEln6CBbSYOvA9RqWsCys4
	nZNGlVuF7S1ZdRwWLDRbrkunu7lTaUbxtq5W5EWDjJnTlizZVPFfCHU2Zw2aur4SWsE8huU5ZL1
	DTbNSXV0wei5nyUnPYhCKdXkxf4RpaKXaKM+ah1RcOx8ce+PZfIEWlnRLJMrCE9qc6tx1ZcCB7a
	hIcccnsx3guw3he47KRVJkjjHalZymrHDc9hKpZyjBVqoxzE1ycqkTlVsXwTf2bx/211vugS6TD
	Ad61ae7TkbvF486SKKqEM1g==
X-Google-Smtp-Source: AGHT+IFn6f9hk02G3w+WQYryJ3pEuTZw0/reY+/DvBUrZlUpuwSXVJmStqUWtvXbgtxUd5LpiselyA==
X-Received: by 2002:a17:902:8e83:b0:235:1706:1ff6 with SMTP id d9443c01a7336-23dee0e63eemr163941155ad.0.1752547384705;
        Mon, 14 Jul 2025 19:43:04 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42849absm106266675ad.18.2025.07.14.19.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 19:43:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7745F4206884; Tue, 15 Jul 2025 09:43:01 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 0/2] Documentation: ioctl-number: DRY cleanup
Date: Tue, 15 Jul 2025 09:42:56 +0700
Message-ID: <20250715024258.16882-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=487; i=bagasdotme@gmail.com; h=from:subject; bh=HfggKZMScSG5PInVPAEiu9BcbAgSjeIm0cNHs/Mze+E=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBml+8uCHwe+vH/oq/3x4w2cqhfzzbr/r3svx35/g772F +Ur53rNOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjARjSyG/+EJ56bEFvjoc8z0 mBJya0ltgHDQy+ORC6+xxNz7ccb+SQ/D/7CuU7YSt3m0GWp+Lhf5kf/3Dp/2389eOvmV1gJ1rjd OcQMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

As the subject suggests: don't repeat yourself (DRY) on table introduction
(ioctl macros-related).

Enjoy!

Bagas Sanjaya (2):
  Documentation: ioctl-number: Shorten macros table
  Documentation: ioctl-number: Don't repeat macro names

 .../userspace-api/ioctl/ioctl-number.rst      | 36 ++++++++++---------
 1 file changed, 20 insertions(+), 16 deletions(-)

base-commit: f55b3ca3cf1d1652c4b3481b671940461331d69f
-- 
An old man doll... just what I always wanted! - Clara


