Return-Path: <linux-kernel+bounces-717344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D71AF9319
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 14:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470B91C25E7B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 12:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161C02D948A;
	Fri,  4 Jul 2025 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="UtYtt2DH";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=teddy.astie@vates.tech header.b="VBcFSLCE"
Received: from mail124.us4.mandrillapp.com (mail124.us4.mandrillapp.com [205.201.136.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541238FA3
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.201.136.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633363; cv=none; b=qGoHHybs2ifZsNWK3oa2UDSp9VeMQy2vaWJNZShuHsvjuleGwO3oi2AuOSZtTeUm6Arbzc3OGzdQE7FTsWwGRghKbM17StuXVKitig9aBslXAfUEt5aF2XXCNicowbInVZWLpNwwv1yHEsmZVg13ym9HZOkUOGOM3qTgZD4g38k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633363; c=relaxed/simple;
	bh=+Ya70OlSJjMKluBLRmgXd00vMiKqrWVBE+J7svp14ss=;
	h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type; b=GJuSirPv8ITbkLnZurqoR1xK935U8Wj8BJq/RAPI+hJVqM0XxdCb7mUJW6Gh3Uwa6XSk40eyX0P2REnr8P6rg0Ij0NNM9SyyQB1BcCfvnFnvydLjiL4oNJgsgIsYrJ+2nyVdx3DiWTKoV/HDqkeqnFjjCpMSnmmUbyRbCIkv9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=UtYtt2DH; dkim=pass (2048-bit key) header.d=vates.tech header.i=teddy.astie@vates.tech header.b=VBcFSLCE; arc=none smtp.client-ip=205.201.136.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1751633359; x=1751903359;
	bh=tt0oM0tqOxl3axHhNxXYGkg2bRs4dsH6dn0uDyBVvW8=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=UtYtt2DHL8jHnIaR4MLf5CQeeheH0VTv4YttLG5A5LGCPGWJ6/OS1/rrCVNQKKTVm
	 fPEVC2xB1iuUsl0Tz5IN8if1Mg0OxR4CWcShaESQ4rzBZte5b0Lxvi1zaHOyL057vl
	 wwq3lMtCMwuWZC2EJpJQkKE+fqEZWt9Y4+P9bqjcLCCQyxHNRjQouCAMNCb9+8T7L0
	 qF4HFTl+y5KCLZUpDtl6B6g/GGhouu9VNak8u9/BqB08Z3l9ZLVIVLQyUOodBrG7om
	 uIbMPeyt4Dwaeen/Rs8JjKerF2cV745+EE6qOqGZf/HRZBg0+cwfrye+NXNLkq3EuU
	 YMDS+Ud6JRcSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1751633359; x=1751893859; i=teddy.astie@vates.tech;
	bh=tt0oM0tqOxl3axHhNxXYGkg2bRs4dsH6dn0uDyBVvW8=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=VBcFSLCEE/g/EjBMS1yoTvh5L5CyKxv+cR0sOgaG/o3ku91fMj+n4944ODX5p9/w7
	 jQPEpzxB2Q8nnfI8vgHjp+sHhu/GSR0azPEaVRiFHMMwfSshqwg8NFUyL3zdy+qkp4
	 dPbRCNbDjVmSQ2Tptaqh7WSWgKN79IWGgCuZkmywFNsrOLKkmOBxPYXB3S60lfGql4
	 hGEzlk8ArSupxnyoXeroTXRhdSMNcwBK0lH6dk0PRs9GLPLxw+oovM8mSidfriShPX
	 ZvfqiLt4P3nnJxjqKM2OE8FMC1Rbpa27jS+D6azdwYAzjyVBP3VdQKq6Q7gWhE703f
	 ECtcVvOhsMOPw==
Received: from pmta15.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail124.us4.mandrillapp.com (Mailchimp) with ESMTP id 4bYYNv5sL4zKsc2y7
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 12:49:19 +0000 (GMT)
From: "Teddy Astie" <teddy.astie@vates.tech>
Subject: =?utf-8?Q?[PATCH=205.15.y=20v3]=20xen:=20replace=20xen=5Fremap()=20with=20memremap()?=
Received: from [37.26.189.201] by mandrillapp.com id d1c46b1eb49c4a048b18bdedffd0d099; Fri, 04 Jul 2025 12:49:19 +0000
X-Mailer: git-send-email 2.50.0
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1751633357597
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: "Teddy Astie" <teddy.astie@vates.tech>, "Boris Ostrovsky" <boris.ostrovsky@oracle.com>, "Juergen Gross" <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Sasha Levin" <sashal@kernel.org>, "Jason Andryuk" <jason.andryuk@amd.com>, stable@vger.kernel.org, "kernel test robot" <lkp@intel.com>
Message-Id: <ea4945df138527ed63e711cb77e3b333f7b3a4c9.1751633056.git.teddy.astie@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.d1c46b1eb49c4a048b18bdedffd0d099?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250704:md
Date: Fri, 04 Jul 2025 12:49:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

From: Juergen Gross <jgross@suse.com>

[ upstream commit 41925b105e345ebc84cedb64f59d20cb14a62613 ]

xen_remap() is used to establish mappings for frames not under direct
control of the kernel: for Xenstore and console ring pages, and for
grant pages of non-PV guests.

Today xen_remap() is defined to use ioremap() on x86 (doing uncached
mappings), and ioremap_cache() on Arm (doing cached mappings).

Uncached mappings for those use cases are bad for performance, so they
should be avoided if possible. As all use cases of xen_remap() don't
require uncached mappings (the mapped area is always physical RAM),
a mapping using the standard WB cache mode is fine.

As sparse is flagging some of the xen_remap() use cases to be not
appropriate for iomem(), as the result is not annotated with the
__iomem modifier, eliminate xen_remap() completely and replace all
use cases with memremap() specifying the MEMREMAP_WB caching mode.

xen_unmap() can be replaced with memunmap().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/r/20220530082634.6339-1-jgross@suse.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Teddy Astie <teddy.astie@vates.tech> [backport to 5.15.y]
---
v3:
- add missing hvc_xen.c change
v2:
- also remove xen_remap/xen_unmap on ARM
---
 arch/x86/include/asm/xen/page.h   | 3 ---
 drivers/tty/hvc/hvc_xen.c         | 2 +-
 drivers/xen/grant-table.c         | 6 +++---
 drivers/xen/xenbus/xenbus_probe.c | 3 +--
 include/xen/arm/page.h            | 3 ---
 5 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/xen/page.h b/arch/x86/include/asm/xen/page.h
index 1a162e559753..c183b7f9efef 100644
--- a/arch/x86/include/asm/xen/page.h
+++ b/arch/x86/include/asm/xen/page.h
@@ -355,9 +355,6 @@ unsigned long arbitrary_virt_to_mfn(void *vaddr);
 void make_lowmem_page_readonly(void *vaddr);
 void make_lowmem_page_readwrite(void *vaddr);
 
-#define xen_remap(cookie, size) ioremap((cookie), (size))
-#define xen_unmap(cookie) iounmap((cookie))
-
 static inline bool xen_arch_need_swiotlb(struct device *dev,
 					 phys_addr_t phys,
 					 dma_addr_t dev_addr)
diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 141acc662eba..6a11a4177a16 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -270,7 +270,7 @@ static int xen_hvm_console_init(void)
 	if (r < 0 || v == 0)
 		goto err;
 	gfn = v;
-	info->intf = xen_remap(gfn << XEN_PAGE_SHIFT, XEN_PAGE_SIZE);
+	info->intf = memremap(gfn << XEN_PAGE_SHIFT, XEN_PAGE_SIZE, MEMREMAP_WB);
 	if (info->intf == NULL)
 		goto err;
 	info->vtermno = HVC_COOKIE;
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 0a2d24d6ac6f..a10e0741bec5 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -743,7 +743,7 @@ int gnttab_setup_auto_xlat_frames(phys_addr_t addr)
 	if (xen_auto_xlat_grant_frames.count)
 		return -EINVAL;
 
-	vaddr = xen_remap(addr, XEN_PAGE_SIZE * max_nr_gframes);
+	vaddr = memremap(addr, XEN_PAGE_SIZE * max_nr_gframes, MEMREMAP_WB);
 	if (vaddr == NULL) {
 		pr_warn("Failed to ioremap gnttab share frames (addr=%pa)!\n",
 			&addr);
@@ -751,7 +751,7 @@ int gnttab_setup_auto_xlat_frames(phys_addr_t addr)
 	}
 	pfn = kcalloc(max_nr_gframes, sizeof(pfn[0]), GFP_KERNEL);
 	if (!pfn) {
-		xen_unmap(vaddr);
+		memunmap(vaddr);
 		return -ENOMEM;
 	}
 	for (i = 0; i < max_nr_gframes; i++)
@@ -770,7 +770,7 @@ void gnttab_free_auto_xlat_frames(void)
 	if (!xen_auto_xlat_grant_frames.count)
 		return;
 	kfree(xen_auto_xlat_grant_frames.pfn);
-	xen_unmap(xen_auto_xlat_grant_frames.vaddr);
+	memunmap(xen_auto_xlat_grant_frames.vaddr);
 
 	xen_auto_xlat_grant_frames.pfn = NULL;
 	xen_auto_xlat_grant_frames.count = 0;
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 2068f83556b7..77ca24611293 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -982,8 +982,7 @@ static int __init xenbus_init(void)
 #endif
 		xen_store_gfn = (unsigned long)v;
 		xen_store_interface =
-			xen_remap(xen_store_gfn << XEN_PAGE_SHIFT,
-				  XEN_PAGE_SIZE);
+			memremap(xen_store_gfn << XEN_PAGE_SHIFT, XEN_PAGE_SIZE, MEMREMAP_WB);
 		break;
 	default:
 		pr_warn("Xenstore state unknown\n");
diff --git a/include/xen/arm/page.h b/include/xen/arm/page.h
index ac1b65470563..f831cfeca000 100644
--- a/include/xen/arm/page.h
+++ b/include/xen/arm/page.h
@@ -109,9 +109,6 @@ static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
 	return __set_phys_to_machine(pfn, mfn);
 }
 
-#define xen_remap(cookie, size) ioremap_cache((cookie), (size))
-#define xen_unmap(cookie) iounmap((cookie))
-
 bool xen_arch_need_swiotlb(struct device *dev,
 			   phys_addr_t phys,
 			   dma_addr_t dev_addr);
-- 
2.50.0



Teddy Astie | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


