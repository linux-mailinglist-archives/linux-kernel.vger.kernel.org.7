Return-Path: <linux-kernel+bounces-824616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0C5B89AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33D97E72D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6C22264B2;
	Fri, 19 Sep 2025 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudbear.ru header.i=@cloudbear.ru header.b="TAjFB0lh"
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4DB2701D8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288572; cv=none; b=DUwqOoTcu2zl3eKba8VTn/QOSFb9KPQjtZ9UeEkVnrnOakGj1fmu5F0rNbsbwM/KKl6sXxMfFq3oXxem+LL71t8eDYrLGQix5VdarODFgEyyh5QyRpUJQsYkuWDkMaGzwLFyLm2JaivJaoJe5WnBGIMKxvkR0xNebwWYOlVMpjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288572; c=relaxed/simple;
	bh=5GKwVU8hH362rEZTY7jUkYc/oYVzpgwPEn9qR6hEv2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y63lq+UUjTSyqYwqgpsNs0Tsxg8svUNXTxME0CjGy5ohlcieeswwfQN5QMj0fjwNx/M3t602i73uC8ZDAHtkpQ8yGBXdFPjK4+4alGAGN7jK0SpXtpKG6+YP79Ip56387pqootcitYZm55SmhmxBuM73bgNxx/og0L1TkptU2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbear.ru; spf=pass smtp.mailfrom=cloudbear.ru; dkim=pass (1024-bit key) header.d=cloudbear.ru header.i=@cloudbear.ru header.b=TAjFB0lh; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbear.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudbear.ru
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:582e:0:640:200:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 8DEC8C007F;
	Fri, 19 Sep 2025 16:29:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id CTT506cM0Gk0-s8TLlgil;
	Fri, 19 Sep 2025 16:29:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cloudbear.ru;
	s=mail; t=1758288559;
	bh=EFeeSu4GhJq3UlGQ+sl0zXkSLxrNHkuxsapv8WRHun0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=TAjFB0lhwSVxAj0O+dePRDq+r6l/8hnOOv7Wt3WPW8G7R+6y3lFzG9kIbpglnWdoq
	 jhO7041CyANsjPXg/p2YlBBtwAJF664zYfflN8u0bVd+8u28weu+1a+7M8t2sV4Fy1
	 sa/6/Zg8WUmFF3RMYJbUsfM+A7OUcYI1T7iuBPTM=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@cloudbear.ru
From: Danil Skrebenkov <danil.skrebenkov@cloudbear.ru>
To: 
Cc: pjw@kernel.org,
	Danil Skrebenkov <danil.skrebenkov@cloudbear.ru>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Charlie Jenkins <charlie@rivosinc.com>,
	WangYuli <wangyuli@uniontech.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: cpu-hotplug fix
Date: Fri, 19 Sep 2025 16:28:46 +0300
Message-ID: <20250919132849.31676-1-danil.skrebenkov@cloudbear.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

openSBI v1.7 adds harts checks for ipi operations. Especially it
adds comparison between hmask passed as an argument from linux
and mask of online harts (from openSBI side). If they don't
fit each other the error occurs.

When cpu is offline, cpu_online_mask is explicitly cleared in
__cpu_disable. However, there is no explicit clearing of
mm_cpumask. mm_cpumask is used for rfence operations that
call openSBI RFENCE extension which uses ipi to remote harts.
If hart is offline there may be error if mask of linux is not
as mask of online harts in openSBI.

this patch adds explicit clearing of mm_cpumask for offline hart.

Signed-off-by: Danil Skrebenkov <danil.skrebenkov@cloudbear.ru>
---
 arch/riscv/kernel/cpu-hotplug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index a1e38ecfc8be..3f50d3dd76c6 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -54,6 +54,7 @@ void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 
 	pr_notice("CPU%u: off\n", cpu);
 
+	clear_tasks_mm_cpumask(cpu);
 	/* Verify from the firmware if the cpu is really stopped*/
 	if (cpu_ops->cpu_is_stopped)
 		ret = cpu_ops->cpu_is_stopped(cpu);
-- 
2.43.0


