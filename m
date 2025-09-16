Return-Path: <linux-kernel+bounces-819310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6836CB59E79
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294383B0CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E543831E8BB;
	Tue, 16 Sep 2025 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudbear.ru header.i=@cloudbear.ru header.b="XTn1cBFm"
Received: from forward204d.mail.yandex.net (forward204d.mail.yandex.net [178.154.239.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B628D8D0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041855; cv=none; b=i6zp85gaCmvaIRNb7qAfsplnmHrzVfCILPrGgOk6DaOZIf/L/c0JvGhmz/6Ar5YV5aa65k6mZuHxoHI8c6MOtsNpQOlGF42xAAUmCmU8jJa1tUwsDdBi2q07K/ie8ZANao78ZzQUzwIinAJW26kYbJItrLrVcl5iDzTpUUIROcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041855; c=relaxed/simple;
	bh=5GKwVU8hH362rEZTY7jUkYc/oYVzpgwPEn9qR6hEv2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKmS9m97aTNGB7HyI8JCrJHZYIg8+geE2bHGk4z/R2IFMacpfyD80k9ixgcjLdzt6Wqef8QWI5c6rpxO0jtbNyTIgGLWchYLQlLjoc10NMUWWgU9X9yu8vVcm+AtYoyBfcT3yqqxmnQ7e4SMPD4h/yOHTZjYoQ4/L2Q2U02sWbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbear.ru; spf=pass smtp.mailfrom=cloudbear.ru; dkim=pass (1024-bit key) header.d=cloudbear.ru header.i=@cloudbear.ru header.b=XTn1cBFm; arc=none smtp.client-ip=178.154.239.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbear.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudbear.ru
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward204d.mail.yandex.net (Yandex) with ESMTPS id 74CA68774B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:57:20 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:4985:0:640:840f:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 5103DC01B1;
	Tue, 16 Sep 2025 19:57:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 5vT9EV0LxSw0-ZMk2EQOV;
	Tue, 16 Sep 2025 19:57:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cloudbear.ru;
	s=mail; t=1758041831;
	bh=EFeeSu4GhJq3UlGQ+sl0zXkSLxrNHkuxsapv8WRHun0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=XTn1cBFmjca+xPXjNY4+Rx2VypbzztYTtctl355nJfBgfm1BisE9x+m1j52mw1CS2
	 aO5anuOTR0ouu7EPzZoc7mh7uew5LHD7AxOu6XkBCNAcrOYbPzaKwmtIP+5fA4llAr
	 Il56zm3yqYbHFrETMt84zEhsqPQHAfvy75l0Vrhw=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net; dkim=pass header.i=@cloudbear.ru
From: Danil Skrebenkov <danil.skrebenkov@cloudbear.ru>
To: 
Cc: Danil Skrebenkov <danil.skrebenkov@cloudbear.ru>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Charlie Jenkins <charlie@rivosinc.com>,
	WangYuli <wangyuli@uniontech.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clear_tasks_mm_cpumask(cpu) is added to arch_cpuhp_cleanup_dead_cpu
Date: Tue, 16 Sep 2025 19:56:54 +0300
Message-ID: <20250916165658.19052-1-danil.skrebenkov@cloudbear.ru>
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


