Return-Path: <linux-kernel+bounces-855232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76254BE0909
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BE8C508CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D371C2561B9;
	Wed, 15 Oct 2025 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="tAGM6dwm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cpohXbMM"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528FC3090C1
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558254; cv=none; b=jLYSChTnub1OlCqYpxYanZZjo/PARoZs/yFI6KaHLACmgM9v9OGZLLSlIs5IgsYCfFa8fiH0GgJOeR7Zlb2ayjmxDTB0CKp0un6VRwB9nMOqwbRK0WUYUgWgkfvRDI4pUQcSrAaVMK3jEfgWwJWOyXwuzavHH+Hep3BAqgNmBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558254; c=relaxed/simple;
	bh=zGDVio5zMnn87R7RCV6lhgWkKhFzWjFcPX/we3VYs08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XsU8odmn9/2BMhbkC2LlHwaKAV9wCZFkjrVGuXvE5g9IuPyaQ1cWqNI2yEsdrOB3ddviAu8a24A7SmGIdd7rMgbfIf0zFvvfEwvIHlLxuup15jLVR7wYsZ7n9XvYEUO5keVp/NXxIDG4zaRvNLmZAlGeZpfNrfTWIZRtGWRXC4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=tAGM6dwm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cpohXbMM; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 42F8B7A0165;
	Wed, 15 Oct 2025 15:57:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 15 Oct 2025 15:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm2; t=
	1760558251; x=1760644651; bh=hai+s8KEB1nxGZr2wQLvsaSxQBC7QUNm2B7
	G6anXMaQ=; b=tAGM6dwmauRnHvQ6OHLVT7Vc6d2ayLZLLBTzF3lCgP4FKKuiIIY
	dPhTi8C+BYfWWUQUwEOsdPRbcGteHDErbJNKq8rE2G5dO1db8wRyoez6ecRONesX
	UCWaK4/axM5QT12tnwFA4I42tAajUAOLp5bPV9dMl35HqVKoxXywSzKWkL0ITe52
	ruvd73o24c4Kl6dKnl2UwMDz8Y+G12mtU8MrmceZcSn4h0e/B745+MmeGWOwkTaZ
	1wZlFljZj5HsI5AeXlLGHXkmLro+8M6lhHwP2mEUcAp+h0Ec8F0yVO/+Z7Eil40r
	CWQqIWWYdAPkB6+8Q9jYf77atyKpBAKqu6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760558251; x=1760644651; bh=hai+s8KEB1nxGZr2wQLvsaSxQBC7QUNm2B7
	G6anXMaQ=; b=cpohXbMM5DOBS8fEPI7e++tOAQwD2o02M0D99VbRKAeuHCxw45N
	1vJOUjTIavZtWqQ5/r4EoOA/L70oiFpe/Tg4cq1OUbrsro2d7RPzg6+CxURs5Ur7
	EKA4UxeVYi0nZqq+YerTch/D+P1VI2ISIOcFO7CpculXLHXuTj/6B8I4ABDT6D+O
	oFbJJeCttb1byYooHpsAuvCqjuHwLOX0zxYRm9mDlukMQdv0/a7FCML2/2ccCPE+
	t6wttAxsp7rF2DgyyP0yyW85weZSIg7l71mc+Qt9fqGkuk3Q1lytEpmGu4MHeDKw
	+8C+lMySKu3bwb6Ogf3tlwIgSfqrKoEVTFA==
X-ME-Sender: <xms:qvzvaMkv8gP61Jh9Xtavx7kE36SgGA_IYmE0dbYVl82FHkwAlVS-mw>
    <xme:qvzvaFJeRoSBgKh5zo8NFFkW2y5w6gsHXD7Ku4RVKC611-gpY1Et5vJgsuKtxXcEJ
    K60vMVIOk8nWHlh3WBd4YDH-D1882EhbI0ILYjUoCybgld1aok>
X-ME-Received: <xmr:qvzvaB6kwQAaJLYW59si6tij-dWK4ihyfH--80Id6oRurChKyJy0f3BoNTBLtJCexX0o3ID5f7ip2-4JVta-wvaRoM8KYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepgggrlhcurfgrtghk
    vghtthcuoehvrghlsehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecugg
    ftrfgrthhtvghrnhepgfeigfeihfevhefggeeuvefftdelveeufeejkeeltdehveelveeh
    tdejheetuedunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehvrghlsehinhhvihhsihgslhgv
    thhhihhnghhslhgrsgdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhgrhhoshhssehsuhhsvgdrtghomhdprhgtphhtthhopehs
    shhtrggsvghllhhinhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopeholhgvkhhsrg
    hnughrpghthihshhgthhgvnhhkohesvghprghmrdgtohhmpdhrtghpthhtohepvhgrlhes
    ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhrtghpthhtohepgigvnhdqug
    gvvhgvlheslhhishhtshdrgigvnhhprhhojhgvtghtrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qvzvaJ3zvSrAUHTIZOcMe669P-CUiuXF3H0NNQCanfrYh-8qVLvP5g>
    <xmx:qvzvaHc-hKQgKbFGi8ezCXE2T9DqEC6R1d_ri3hlVjWzcZdglEaoCQ>
    <xmx:qvzvaPeG76LH_ewfN1rFGagWAPLkIDhIgG5At-1JYgtrSJaVp0ICDg>
    <xmx:qvzvaCw9NhweJANBxV9eXHEazSAbveEYc1Qayr6EiYmpSL6bq1RHqw>
    <xmx:q_zvaBJsejqp6C9NROTgWvbOEeYxneVcQ7EntZDOJizlm4H2y5zKAVQL>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 15:57:28 -0400 (EDT)
From: Val Packett <val@invisiblethingslab.com>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Val Packett <val@invisiblethingslab.com>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] xen: privcmd: fix ioeventfd/ioreq crashing PV domain
Date: Wed, 15 Oct 2025 16:57:03 -0300
Message-ID: <20251015195713.6500-1-val@invisiblethingslab.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting a virtio backend in a PV domain would panic the kernel in
alloc_ioreq, trying to dereference vma->vm_private_data as a pages
pointer when in reality it stayed as PRIV_VMA_LOCKED.

Fix by allocating a pages array in mmap_resource in the PV case,
filling it with page info converted from the pfn array. This allows
ioreq to function successfully with a backend provided by a PV dom0.

Signed-off-by: Val Packett <val@invisiblethingslab.com>
---
I've been porting the xen-vhost-frontend[1] to Qubes, which runs on amd64
and we (still) use PV for dom0. The x86 part didn't give me much trouble,
but the first thing I found was this crash due to using a PV domain to host
the backend. alloc_ioreq was dereferencing the '1' constant and panicking
the dom0 kernel.

I figured out that I can make a pages array in the expected format from the
pfn array where the actual memory mapping happens for the PV case, and with
the fix, the ioreq part works: the vhost frontend replies to the probing
sequence and the guest recognizes which virtio device is being provided.

I still have another thing to debug: the MMIO accesses from the inner driver
(e.g. virtio_rng) don't get through to the vhost provider (ioeventfd does
not get notified), and manually kicking the eventfd from the frontend
seems to crash... Xen itself?? (no Linux panic on console, just a freeze and
quick reboot - will try to set up a serial console now)

But I figured I'd post this as an RFC already, since the other bug may be
unrelated and the ioreq area itself does work now. I'd like to hear some
feedback on this from people who actually know Xen :)

[1]: https://github.com/vireshk/xen-vhost-frontend

Thanks,
~val
---
 drivers/xen/privcmd.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index f52a457b302d..c9b4dae7e520 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -834,8 +834,23 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
 				if (rc < 0)
 					break;
 			}
-		} else
+		} else {
+			unsigned int i;
+			unsigned int numpgs = kdata.num / XEN_PFN_PER_PAGE;
+			struct page **pages;
 			rc = 0;
+
+			pages = kvcalloc(numpgs, sizeof(pages[0]), GFP_KERNEL);
+			if (pages == NULL) {
+				rc = -ENOMEM;
+				goto out;
+			}
+
+			for (i = 0; i < numpgs; i++) {
+				pages[i] = xen_pfn_to_page(pfns[i * XEN_PFN_PER_PAGE]);
+			}
+			vma->vm_private_data = pages;
+		}
 	}
 
 out:
@@ -1589,15 +1604,18 @@ static void privcmd_close(struct vm_area_struct *vma)
 	int numgfns = (vma->vm_end - vma->vm_start) >> XEN_PAGE_SHIFT;
 	int rc;
 
-	if (xen_pv_domain() || !numpgs || !pages)
+	if (!numpgs || !pages)
 		return;
 
-	rc = xen_unmap_domain_gfn_range(vma, numgfns, pages);
-	if (rc == 0)
-		xen_free_unpopulated_pages(numpgs, pages);
-	else
-		pr_crit("unable to unmap MFN range: leaking %d pages. rc=%d\n",
-			numpgs, rc);
+	if (!xen_pv_domain()) {
+		rc = xen_unmap_domain_gfn_range(vma, numgfns, pages);
+		if (rc == 0)
+			xen_free_unpopulated_pages(numpgs, pages);
+		else
+			pr_crit("unable to unmap MFN range: leaking %d pages. rc=%d\n",
+				numpgs, rc);
+	}
+
 	kvfree(pages);
 }
 
-- 
2.51.0


