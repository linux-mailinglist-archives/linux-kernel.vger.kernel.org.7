Return-Path: <linux-kernel+bounces-763272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 164C7B21298
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307B41882EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB9029BDA9;
	Mon, 11 Aug 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOVntpeA"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9778A29BDA2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931095; cv=none; b=F30nTVO4na1x01bX7IRBtLkcyuBtXnrcVJXW3SecwnLgcp1LK00Yc0AmJJtHuppBRAcZbLUTRyfs41SQS72pgAyVZxAR8pGhtFUAHfACTU6Y7GYf5Wy22CrKk5P6ZKkMVAaNdQIPt0+V5HTh1o6pz5vmNZnOxZy6oCFdUMX1xMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931095; c=relaxed/simple;
	bh=lZWge6ssPDFkLFGqCmA9xsMj32gAja/aopa6X1cWoyc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZlSv4une4cJnn+s7KDxLgeafDB3tTLG6wDa6WNjKeTKj/qa6OuGDbc/FdL2B+g6DOm7dwpyDD6E5U2Wq9YBvbMjS/AqPfohlm1FXFko0hNU46KFPauL4iHEnAaHCIfEHC1qdYRs7ldRDUItHjrvVWyug/EU1n/MZJ3aBIwmjyIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOVntpeA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76be8e4b59aso3883574b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754931094; x=1755535894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LERbV0S38RbJIKVdlX/fCrWEtk21kg3d1o9P6dPP59Q=;
        b=nOVntpeAKX3BtO07nOoz3slXJ8sIUHH0/hRYK3kdIoX9oum9St+nPgoIE4UQgbU7e0
         12o7qWFPnLq4MKf03/IHwTH1gnQMbKxKYLpf4fhGqXpFEm8AdTO29qqAj/js7D+3Y1jm
         1JwWnLJFydBgs+9ZcDQ+PhZTAwaAPeHOo9J/GViUBY0MNs5JFY2gD06QL6F7cQqLvaPh
         f1t/mYeDwHga90fojV+Qm9Mj42zAs7AA7l4HjRZXWsvyVww6/Q4+e+kGRaZC+j3dFZDd
         qOYl2IHd5vAk2eLRDdF91IZ3QYATWYlWZ96DabZZxg8C1y3yXmCWcObRazk/HCTfgKjp
         AtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754931094; x=1755535894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LERbV0S38RbJIKVdlX/fCrWEtk21kg3d1o9P6dPP59Q=;
        b=jPWVooo+7qWRdHHu039lRXItQ0fYx3zGIrVeZFVsojmKlY5jfYell2UNPOv1j/TrJ2
         Q6g28hxIbAGa/GFgUZCHoRTLQSlm5ZmUSR7a6lmWTiQlAZHvSTA5RCuIeKDSHGNk9W+1
         KmO7vhRxkHmQYUOhj4v1T/TDsM9/QPbFWerSp4zhkENwEey+CJIP9JpwlAFchkzIV+WU
         LO/O8bEJCHF79VoDyOBVYuqfKvJAnZMkt0Qg+xdVCB1epQjIz/r/8FW96RjQYxxyPvXf
         P6ALgEA5KGiCYOAbH7EzmfuPNnOSTqmfoVUZdmGC6TCWz/2RZFwHRyp0ELEZ3wgCDZ4q
         rIOg==
X-Forwarded-Encrypted: i=1; AJvYcCUwPZWqcD/7vzgfH2yT+lyO9RxaFmfmD033MdUkz+twaxGkWQ68uHjFHDEXcsgNzLQhyIlxL/iZlJLeWKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcS7IOaMS8GDGqCi6ClXPTRB4iv91Yq+8chEZgtQDn/yb90O3Y
	Ez1H+wdw3L5OwklfqkIgfA2ogtHKeLzdVUpFQVFQzG8lH24RVkHIv7Nu
X-Gm-Gg: ASbGncuoGAV9Tke84AbN/5rJX2IYNye89XjgqEeW80fVc14Q59ECrHObTod7QnusjmD
	fZh7/QNSjKP7y7cLvlwW0L+wMj1D2iuKqOPYyPJyznEN/169XucTrD2zdUnocihbVa512VzgVmV
	hl8dJgIqMOB3vo4GCtxWl2KO7vNS8kTWKEZOrWr8HwF1Np7t25ThkyktkGjHP1aXs+/74t4f7dc
	qtH4SUPJZic5LWs7Cl7/e83SiN/fPuHBHlICn8XAJAaBfjPXcEii1yPCGcT9zKlCKVQUiCRN2rk
	BkFsWMmj+CU+QzFxdjXlobYsv2ixSMzWjNV6lcSaozZZzNiwJvtbN504HOpkxxPFHNVg1WTKKEL
	+50ToCQmQ4PHSY/29PYWuyQ==
X-Google-Smtp-Source: AGHT+IHdxDU1+GsAONPyuYx2xGLExrkYYSwAJYQG9U47O5KfVxLBq4NaK2X4lcJNVXSJvnN26C4h3g==
X-Received: by 2002:a05:6a00:3c86:b0:76c:503:180d with SMTP id d2e1a72fcca58-76c4606bd5dmr20521364b3a.8.1754931093831;
        Mon, 11 Aug 2025 09:51:33 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c46a05464sm8661470b3a.96.2025.08.11.09.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:51:33 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Barrat <fbarrat@linux.ibm.com>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Yury Norov <yury.norov@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] powerpc: pci-ioda: Rework pnv_ioda_pick_m64_pe()
Date: Mon, 11 Aug 2025 12:51:26 -0400
Message-ID: <20250811165130.37552-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use cleanup functionality and better bitmap API in the function

v1: https://lore.kernel.org/all/20250720010552.427903-1-yury.norov@gmail.com/
v2: 
 - add patch v2#1 that switches the function to bitmap_alloc() and
   clenup engine (Jiri);

Yury Norov (NVIDIA) (2):
  powerpc: pci-ioda: use bitmap_alloc() in pnv_ioda_pick_m64_pe()
  powerpc: pci-ioda: Optimize pnv_ioda_pick_m64_pe()

 arch/powerpc/platforms/powernv/pci-ioda.c | 27 +++++++----------------
 1 file changed, 8 insertions(+), 19 deletions(-)

-- 
2.43.0


