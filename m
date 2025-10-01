Return-Path: <linux-kernel+bounces-838904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5166BB0656
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD624C0FC5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC592EC55D;
	Wed,  1 Oct 2025 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS42QBIZ"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10072D2381
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323377; cv=none; b=Ac1k3b91AXb8MU4B6l5Yx1dBc/JUkTR7tlLEyyRyY3JLvWp82tyF0S1Wf67wm18YC1YdNWR/V8gawlU2siziNp9utj137OoCA5r4LKZ+aYejru1D5S6rQtGTZcE+aQdPiXpu8IJE2Z7wqGax5hOvThvSQAJfasoP1SEO6B3FGUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323377; c=relaxed/simple;
	bh=e48hKC8RketRNvnBJqh9k7xnd0M5kkzlY/ow5Minm6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mF7HkJyGkp4Z2HI83a5nFitUurHJLpfMD6BJoEFIWVKNyP3697vnz4IouT0CTgo0D5ZxhMf6xkrEkLmKhoaDGU736vunqVE/Ha+6r9MKMFHSMKRjYTmK9sskAh85H8dIr+I3XIh3CpLYaIrQTjLJf/1nAwGTpuOOxGxR2lfQK1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS42QBIZ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b551350adfaso6765129a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 05:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759323375; x=1759928175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KuZd43UueqoDvh56cTTI9JpLcE20lmDhoJuxtDXLHxI=;
        b=QS42QBIZtDZ5eY8wzMDqsa3/7DsMSB2a6yFDbTqW5v86hTS9wixDTqEB621hYcgwbQ
         eOF5cRDLYbpKunDD+I9pFqS2eOO5q+jvSnrZ1mdYCb9mmTlJDFMufDD+wGv30amP3bMD
         K80ux+u13BqCcjZ3Rr6wi3A009UXtsaa5tJLgdXvrfwY/XDMox2Jnpyl4Q2AYgt5BSRI
         mP1rjGWDGMf6i7tcfO2um87ufp3Z1PrmiYfLLS8SbiIkTF4G0cyTIau2QJVC3msvuk9h
         +ZtLXtDMLN8i2ZxbY9qn18zXlKOAIa5ndnSAfdQKhkcMdJrEaaPFz4ItVQ0CXNPHzNqF
         2Yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759323375; x=1759928175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuZd43UueqoDvh56cTTI9JpLcE20lmDhoJuxtDXLHxI=;
        b=v4hIjoKvhgqsePYet+e7Bt3z8lOUOBATcKXvmXunzCXoT7/Sx0vzD+Ha3THqL66jde
         CUp2O5chWvy29EAaiPW5ZjK+moebZw83THdYXGpTdZA3mahMBgBlh9jfHXu/fmZbURtr
         XMh2ZHISi7Ittti6XcRoqdqU/odjLYuBUHIXPnuM6BNAZU4fWJ7KvtGPK/kThBYxGiiO
         g6T9SRA6O7je7iBgjSZyotQi4zjZlS6Bbv8kt5vxAAKr9JgbXJyDtzMQf5GI73i5/qty
         eVGqt4r69nHZOEVH+SRumWs3IKXQfRTfFleNNSYmsraDIYfTDE0C4YpAnh471MDozfpN
         Bkaw==
X-Forwarded-Encrypted: i=1; AJvYcCVToTQwbJhoU0r9fxhBeynk6WHLyZrctUByptTwtyIxfbz9qceh5SACICXEJcVZ1afxHp6oe4ZwY6wYGMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6eHIDabKMAkBu+FzwJu0po5r+EIvptJOoUGtc5A0ZF8FDYzbB
	wBmeWaeIXc/qi3oey4t+dj9BdyZvCpamm2L5pIcm78wK0MhpNEnzCeMp
X-Gm-Gg: ASbGnctq/U6BXqyC0aaPv8AgG1HLDOP0xVE51D7menNzGBxUpptVRx32hJpVrgmaM1l
	kmL2jHqgAbxD6OGj/iM+p7BNpiu7dWAzNeswPmSKqqYu2wwEy1cxzPl9vjtJUIZGbn+B2Ewz6km
	w/H/N6XJjPQSJGICDgzGNLAHtsAeT6474MbjAIYSL6msiJyqp5YWCh1qxoo78EKsOtlr5RNWSR4
	4U9iHciYoblw+QRy/V4Q0Dg6mXp1QaGKecRlc8M92TsFuxl9+71ydn6MXlUhgtQy3cR5Un5VUnf
	Le8WM5e1NvXpjWhGHdK0C3mpvvUVhLicQwYhhmQUEdkm5CYa50CPMzA5GusjnF1ensRnUGMQyYK
	2Lsklxo63OoXDUUsfolZr6zrkaOjrWk068hi2f1q/ZbwBthAf59nMSTF4QXFOI9HpqhRmn1hN3N
	UlgP039NHfR3y4HYsfch4WSdp/l6Y=
X-Google-Smtp-Source: AGHT+IGUyCWta2IvOu8FsxngQaZysc18Q7e04rBptGtsy21turuP3/XM/YDY7rPXcnNKuZ/akNFxRQ==
X-Received: by 2002:a17:903:380b:b0:271:49f:eaf5 with SMTP id d9443c01a7336-28e7f3117b9mr36640935ad.30.1759323375139;
        Wed, 01 Oct 2025 05:56:15 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:3656:da13:376d:baf4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882204sm182615715ad.72.2025.10.01.05.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 05:56:14 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: fix inode leak caused by disconnected dentries from exportfs
Date: Wed,  1 Oct 2025 18:26:09 +0530
Message-ID: <20251001125609.1792081-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jan,

Thank you for the review. 

You're right - I need to investigate further why these dentries survive until unmount if dput() should destroy DCACHE_DISCONNECTED dentries immediately. 
I'll add more detailed tracing to understand the actual reference counting and dentry state throughout the lifecycle. 
I may have misdiagnosed the root cause even though the fix addresses the symptom

Best Regards
Deepanshu kartikey

