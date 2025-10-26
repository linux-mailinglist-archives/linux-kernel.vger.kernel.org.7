Return-Path: <linux-kernel+bounces-870198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE845C0A297
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 05:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EE03B2A16
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 04:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA752566D9;
	Sun, 26 Oct 2025 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+GChMDq"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E67229B1F
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761453839; cv=none; b=qEOyMq7PlWcrcsuOqJjfvqKDn05CwvON8a11dKgGQTvPL6+gXV7I5GyC2ZY4GyFEWVBBr4TspfbI2gPhGTv6aJ3U6WtmhmFRdNDQ8lyb7hkcV/CM7JtMiktVnHOEJ7lvF0G67ITfh6PjK3yGSiX87zX6Y6oUrqq+EY/gxruosxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761453839; c=relaxed/simple;
	bh=Aq74QMuE52R7WYicPBIBj8uAOiBzvycV/ZXDy6HTnQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fe6MCFfgFgXvGMdmbMO9M/JjtJm4McEjmpIs3K4JzF/lE+V5zh0hQuD90FXLLn9Qt7qWiBmQqCAeMoRmhTFAxGGf0ZOeMcI1eojEe2om8gqaa/vNRVtGkLIYfSBillazgEcz4kFI23rnfFfoCFrGp9Io47GwB1V2iU8OefGSNKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+GChMDq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27c369f898fso56886465ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761453838; x=1762058638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3QG/GQcuHlnsVtxELaSyj+sqLVJE39GY4SNmTDM2G0=;
        b=g+GChMDqMHoHGXrhpy/zqFMfrzgizfu8qAUXveFc202Grj+t8c0aI/eSy2b07bvgRj
         AmnrIoW6gOWbvdiTc2ddjQ4mN6q0b+UhN2OvzYbSf9G8HVwokZsfrb+ZNhUkqcSXjql4
         aOC/gsIxHHjco8hsFHDZXUJQ2uDtnZBQnXVJXOJVYr4p6/QiZqIIkpQnzYvkYYZre0LV
         Pc8a2PG+c1SEZV5g2Ffu5s9w0/IHAOUs6+5nEmpUPrDYdtyF8pXJ+RFOyLOb0o9yhrUZ
         hegVbffghgGMIRQAGzH9aC+Z8Xn0pw7K4CsKi+BlUyeZeRCeYHQgpl0D2cP4moxFoDhh
         gK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761453838; x=1762058638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3QG/GQcuHlnsVtxELaSyj+sqLVJE39GY4SNmTDM2G0=;
        b=JQyM+Rn3SJc7T9lCYHOZ3L3AYH8VxDvRY+t274HYtsLkCP3swUHO/1Nnk/6pUyIlnq
         qX2Hir540QcWx0kLOK707W+xQv4lKGJKx6Fs44sxFONE5EFu7uLOddomA7HzTrkum3+g
         gS7Uj0HEoWypJKs4msCBRDg60lV5h6+22RvsqVikinrjoG9hs7b8an4pZB8C9i3KKnCN
         gMdzgYr7HBpcuPlidUxz/IQzfYAsIZ225gF5Y7ODGFDbXvHeNmdax1MmLjb6qlV7+IkU
         QGH/YSdMQ1c+x3BNlMtl3ZjajoPKxIe4rJ4D1fXp5hL7ACE4Dn+1MtDXAAv2NeYrV5Xz
         ssZg==
X-Forwarded-Encrypted: i=1; AJvYcCX8J+l/+mEtVIi5Z+5NtZ/iibsjiCwYpl1DuX1/79w1+Xrk/7J2AnTKuaKYrJKAn+yu0bT2pFPWdRAxNh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznvY4GXeRtod627Mw7nQQe9fWDRdHTfUEt5U8dqP7LHZpiLtz1
	oJ3bX+aMFFJ01aW3a3ijr2+1LJKpu/FwZN6+T4v8StHihnhXH+JoY2fe
X-Gm-Gg: ASbGncvBRfqiMPCeYFTGIkFtomZL57c80Z4kh7pHJrMkuUNLOqlOhr4b72V7cr5hIpD
	tkzOR5Fp6kDql0xiPujAe3YtAeNGzB20ZdgFE8XveNWsd2aFpF9xc2FHuDX6i4C6k27D3VZqWS6
	iVX/vNkRzjb/EaKdYjXhwJKV+vEBhJOlJEs2UFW50aqsLUoCJHXYVbOBuJCba9PtO9YNTjlEql3
	qum54bvJbP2Aia5Lno+guhe3nRVGzCiNF3lvCr345HeRvq4VhJrKyu8e+S6RaqrTCimFLPpjZBl
	jlauxvrSNmLJcYXS1iEUSmTFcq0kPLLmxPrZHc0y6Lc4PGgxM9RG1ui1Ab5eNO0iaJEj+6xXUAx
	0EZOKyVKOTTtK8zgbYJcNFWnaWDyjTAaiA3/vpQUaHqTs+CrQD0p/j71HaeshN8g2JiXtwO6bgu
	rOf5Ln0gd8sg+93HS/5u9jYumRg5rmUTv0e9F3p4X81XMjUbq0LA==
X-Google-Smtp-Source: AGHT+IFB/FjN2j0+IOAja2+xRrNG+5H+gTFghf6JJ7KBtwsp4jcAYxVgOF8JlaL+XVkBPHYqSsE4lg==
X-Received: by 2002:a17:903:8c8:b0:269:87a3:43b8 with SMTP id d9443c01a7336-290c9c93aa1mr330667075ad.4.1761453837832;
        Sat, 25 Oct 2025 21:43:57 -0700 (PDT)
Received: from localhost.localdomain ([119.127.199.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2317csm39315755ad.48.2025.10.25.21.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 21:43:57 -0700 (PDT)
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Waiman Long <longman@redhat.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [PATCH v3 0/2] PCI/aer_inject: Adjust locking for PREEMPT_RT
Date: Sun, 26 Oct 2025 04:43:33 +0000
Message-ID: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series addresses locking issues in the AER injection
path under PREEMPT_RT.

Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
Changes in v3:
- Remove unnecessary lock in aer_inject_exit.
- Link to v2: https://lore.kernel.org/all/20251009150651.93618-1-jckeep.cuiguangbo@gmail.com/

---
Guangbo Cui (2):
  PCI/aer_inject: Convert inject_lock to raw_spinlock_t
  PCI/aer_inject: Remove unnecessary lock in aer_inject_exit

 drivers/pci/pcie/aer_inject.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

-- 
2.43.0


