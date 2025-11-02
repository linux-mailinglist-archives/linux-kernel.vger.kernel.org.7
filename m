Return-Path: <linux-kernel+bounces-881752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B184FC28DC1
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 12:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F113A2EDC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 10:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6189B26CE37;
	Sun,  2 Nov 2025 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Shz5f0W2"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605C61F03D7
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762081073; cv=none; b=dpvO6PmcRPh/I5wE8h7tVWqg9V/QYem/oF6wDo8FPnXjbsK6jEpfZEZpxu3JreLgtFJeucjeFCIxVYUkOd9lpaFvfoiF3rReSLJ07NwJtyhXa/FaRztFLH8bZ0EIPrp8pzdnZ6w0Zj5c0HcTSQU78r2XbsWtpWWdzfggzKVd8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762081073; c=relaxed/simple;
	bh=SHEr//40zR6hLobNUNKlzHkrDggRl9UZzzbYH4lErwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hMBCNPfOUS2jup8iUkf9cLcr2LS4yt3y/woD9LDGkAVREnYqNh0hfdNTDcNAwvvxMbnfsh4/U7OuYpwhs5XQ8+JNRp+lIOOHnM/dEelozmfMZ/LnXwotgeHzVkbkmMytJgDPjl9Lys/Asgai2t1RmoS+Dq6VsMSFyBk4npdBfqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Shz5f0W2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so3362189b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 02:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762081071; x=1762685871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vMHdxPCuQYx37q4+PHeYjwUMtBpJVYVKStqHxBRsAFs=;
        b=Shz5f0W2eaQvA6yepaDocTLtgIomMWfKApVjy/e6LwXAlXHS9jLC9vqoHy0lDqCZ1Y
         WEzJMVxYnh/iSP9V4rZyhR/WrMymVbsnddwHCIUZddZxavq6MpvxQLJkQGmATJES9Ia1
         fI9oeAFritkilA2HaBATKa2zksKmLq9YpEFr2yzJkDPoGLuMtm8aVmHynZSZsK7GQQ5Z
         GQLw6kafUnB81TEbwZDmCl3Zx/G5A+MEybKOE4y4dtiCp4W5mrFuO3hy7wBKvSVR4B8z
         jQ1FdY6GY50dbWJh81Q69nzs0wirkidI5l3NBtWYztKRvo+3qOz4PEtLZd8gpJapYTRD
         SdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762081071; x=1762685871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMHdxPCuQYx37q4+PHeYjwUMtBpJVYVKStqHxBRsAFs=;
        b=dyG1jy4EuKoshMPd3Z0MUJAMZ7RqZVC+dIlV+dlA2kqdCfJmhuSRQTp3dH/+OEZa+A
         IRuFVsQ6+2c2ev/fiNkfJitGH691Jz5KlN5+9fmB6odspCeuadWQoWNGSFueglHak4XZ
         OhAcUBThIl8kgRHieljJXiZmUCvugoU3A3hB3taBWL2jqfcXeingmSg3JlpDrzLnpQc1
         HNV4cNblRrDq9OW/1ParkBOrv8CdsBgL28U4ASUtcIChyghfnQpbuiuPWEQoymfVhFW4
         OpOZKe651cNo/2j3WZy//AGqJtB9amSVuBipZ1ntjUGNkzmId7K3E0Qtg7CtmQtDtQZY
         DAJw==
X-Forwarded-Encrypted: i=1; AJvYcCXRKbn7rd55P9W431hcPTA9kiRXBBCH7SIDcjvPquo8Ibg7LdrJCd/AZKXEAcsXjLCsmpO6rUXhl2kUKVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi/YJhBc4TJR7YCpAHHH8up7OtKrjb9Q0a3Fx5on90R3Hud4zP
	atWSil6LFA0hK3fgqK8YsGQr30c3hAr0789uBsWZFWAspyA9R7C+1HDq
X-Gm-Gg: ASbGnct1834ODrUHm0j+kmfoRiSXHINdXy3P4z/LmeaQtQo51jGwdOSG5Yauo+KWaMJ
	vpm6zw/ZUj0OKrxwqiq7ndYQSlA0EUWfmBGX18evjcditbBNDmpJe8P69j5GktSOQZEH//s+Ipl
	zDZcNd9B9l+ykHbzA5Pil4YxW0tOfjtWCmlBZKeu8q86mMdwqcWJJ6mkfkydGZW4gYANRUdhMZi
	Ft/xL7qsk/fX7EKLK04Sc0hWXvdW5HteQtHQG19mMLopDu6J6Y4VjTG0j7PZIYd7IC4wd47QITZ
	UNQWN15x7acSxBJDCkQXQVSQ1RLeUZj+d/tlwoP+0AYkFQr2StFictj7v7vk7tT0EJQC5Utqlv7
	u9sAagmXeXJ4XzXDAYepAVSOsXNWBDz3BC4ecfY15bPhyJf+GsGp26f8T97XWwtLygTFjExosNX
	F2XKMJ3mqAguzBmbL37/0JZsPZXa5cmufNF9wyCik=
X-Google-Smtp-Source: AGHT+IEsI4Z/8PcAT7j2pialDGZiC/BBy4ILYzqkSINF9zrcfL6KP/AE2O0RDl67g6y34Zj7lSoeRQ==
X-Received: by 2002:a05:6a00:886:b0:792:574d:b2c with SMTP id d2e1a72fcca58-7a7794c4f13mr13897182b3a.15.1762081070616;
        Sun, 02 Nov 2025 02:57:50 -0800 (PST)
Received: from localhost.localdomain ([113.102.236.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67999bsm7488050b3a.56.2025.11.02.02.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:57:50 -0800 (PST)
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
Cc: Waiman Long <longman@redhat.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [PATCH v4 0/2] PCI/aer_inject: Adjust locking for PREEMPT_RT
Date: Sun,  2 Nov 2025 10:57:04 +0000
Message-ID: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
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
Changes in v4:
- Reverse the patch ordering.
- Link to v2: https://lore.kernel.org/all/20251026044335.19049-2-jckeep.cuiguangbo@gmail.com/

Changes in v3:
- Remove unnecessary lock in aer_inject_exit.
- Link to v2: https://lore.kernel.org/all/20251009150651.93618-1-jckeep.cuiguangbo@gmail.com/

---

Guangbo Cui (2):
  PCI/aer_inject: Remove unnecessary lock in aer_inject_exit
  PCI/aer_inject: Convert inject_lock to raw_spinlock_t

 drivers/pci/pcie/aer_inject.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

-- 
2.43.0


