Return-Path: <linux-kernel+bounces-808954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB6B506CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187D7189545E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB56B30103D;
	Tue,  9 Sep 2025 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b="tUHIM9Il"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930B020C023;
	Tue,  9 Sep 2025 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448939; cv=none; b=c+i/lIuLPoKtic/a8X4G+VOP5uB31YxEZdI58TnUY8NUbPvSGPk4HAWYgAraON4HGmcOL0p8qjzssuM236BmoZfIpZ6SlWIl4glx7MaS5HxV7Fi8YEc0wk3aXE0z0rtv3lDw/K9qsEEnio5ZxqZNYRrzORfFirLyW3zaMzf7T9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448939; c=relaxed/simple;
	bh=7XelOSuRtMumCFS1W544pv1aQaXtEUDaqg7xGeLRhEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJB32aWbNa2uoHbGrGnsH/j1teS90yjSxsVBPQZPZ64K8x7v686R17AXsTEdJnAtkuVY7SCFjyCHgK7oo9zGqzPxxoZuWJvfq+CJH+OPeoNHWodKdA/SthejXF+JHKc/kEYpWbHFgqRkLwXkz7w2St56ECakY+WDatFisRFgfbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com; spf=pass smtp.mailfrom=yandex-team.com; dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b=tUHIM9Il; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.com
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 93B5EC017C;
	Tue, 09 Sep 2025 23:15:32 +0300 (MSK)
Received: from localhost.localdomain (172.31.115.73-vpn.dhcp.yndx.net [172.31.115.73])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id IFQqlX5GteA0-lKmQ6Yfi;
	Tue, 09 Sep 2025 23:15:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1757448932;
	bh=v6j9zrtMltmIoN7tcvqfcj39ZzhThRROT8000Oa99k0=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=tUHIM9IlFhPrnvOXOM+8JQ/i0mj302skwkptt6zMP16DhVcdP4tW4deIOK4JJP3yD
	 mN3ebdg4uVK1ZkH0Io+gOBUGzVZlGDfE8Uh2rX0ZDfqoO6ePTTS6rxm/DASPVuY9h0
	 iwbPtIEVLaRWS89T8gLAY0+3oaK1BizzhT9GYSH4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	James Gowans <jgowans@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Chris Li <chrisl@kernel.org>,
	Ashish.Kalra@amd.com,
	William Tu <witu@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [PATCH v3 2/7] kho: move scratch memory in separate helper.
Date: Tue,  9 Sep 2025 22:14:37 +0200
Message-ID: <20250909201446.13138-3-arbn@yandex-team.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250909201446.13138-1-arbn@yandex-team.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move scratch memory initialization logic from kho_populate() into a new
helper function kho_scrath_init().

This prepares for using KSTATE in KHO instead of FDT.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 kernel/liveupdate/kexec_handover.c | 34 ++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index e5a436893f5b..a99425fdfce4 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1111,19 +1111,12 @@ static int __init kho_fdt_init(phys_addr_t fdt_phys, u64 fdt_len)
 	return err;
 }
 
-void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
-			 phys_addr_t scratch_phys, u64 scratch_len)
+static int __init kho_scratch_init(phys_addr_t scratch_phys, u64 scratch_len)
 {
-
-	struct kho_scratch *scratch = NULL;
 	int err = 0;
+	struct kho_scratch *scratch = NULL;
 	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
 
-
-	err = kho_fdt_init(fdt_phys, fdt_len);
-	if (err)
-		goto out;
-
 	scratch = early_memremap(scratch_phys, scratch_len);
 	if (!scratch) {
 		pr_warn("setup: failed to memremap scratch (phys=0x%llx, len=%lld)\n",
@@ -1161,6 +1154,27 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	 * memory reservations from the previous kernel.
 	 */
 	memblock_set_kho_scratch_only();
+out:
+	if (scratch)
+		early_memunmap(scratch, scratch_len);
+
+	return err;
+}
+
+void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
+			 phys_addr_t scratch_phys, u64 scratch_len)
+{
+
+	int err = 0;
+	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
+
+	err = kho_fdt_init(fdt_phys, fdt_len);
+	if (err)
+		goto out;
+
+	err = kho_scratch_init(scratch_phys, scratch_len);
+	if (err)
+		goto out;
 
 	kho_in.fdt_phys = fdt_phys;
 	kho_in.scratch_phys = scratch_phys;
@@ -1168,8 +1182,6 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	pr_info("found kexec handover data. Will skip init for some devices\n");
 
 out:
-	if (scratch)
-		early_memunmap(scratch, scratch_len);
 	if (err)
 		pr_warn("disabling KHO revival: %d\n", err);
 }
-- 
2.49.1


