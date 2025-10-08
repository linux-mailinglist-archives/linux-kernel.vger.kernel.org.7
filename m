Return-Path: <linux-kernel+bounces-845210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D359FBC3E64
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95A419E2B6F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918802F39B5;
	Wed,  8 Oct 2025 08:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ktdaglsx"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFFF2EC09A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913071; cv=none; b=WaDFHsSgfzhbM9nc20wmhs2yxmQudkE15MVP3BK3zEu6ubIhnFjCmzn0BtJFum5gZA2x2WWHDeYL4dIHWwA5uPKhAlF3sWdV8VudRjbv+DHx8hNQoXLS+TA0aHZE51lkDuFqon8vBFsHIc5aXnnBmPQIrAirYYJUT3q5z4N5ioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913071; c=relaxed/simple;
	bh=jQ2r/rcCQFyp8n0GePqoko8xfZQFPXQULeRJ6UtUvkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGuQldesBZE/7oBNqNLIUWrVbuqf2O25r+QVs2THk3ThQFe2vuPylBhDVdiOrr/3B800viqdl7Dj+66XibEd3JDZzzCf2LbnA3lEWe2r8GP74B6Nd8eQBZSNrDHavYUDASzL50V6Twkimj2pvwnr11oreRCNUKi6a/AqbdUAoVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ktdaglsx; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4db385e046dso72547901cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759913069; x=1760517869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlSjJCs7A1ERmjbEvfSkW/CmM7q/PE2PcmG+9t+wYEo=;
        b=ktdaglsxeMCjhkJ9+ONSTubAFmm8u9Di0puasIn/s17303NJ3557Pedm2p5Q8pNsZf
         4iMw1gVGnTnvipne6Ij4jJBdaT1b936xRAi1aZ249OJS69uH6oX6zt23fjllNTgU+Dvs
         2Fx/sx1XLwnBZ+dGOjtIOVPhcxyTSesq4QPFKA3ls9Vs1EePYDfp2oOaXyF3HhREw6J2
         i/9iJnSKMJhvkqrH2eOdFinyM44fFRKsNANv34YHdLpFnuGMggZUzTzkaPxMrREmCntd
         I/SmgPOG2PLAnsJmHhGw/YUe8E+Jn8vOO/K1bEokHw4ARrdMuDqoEisDVZ6ooufHQWFs
         /gWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759913069; x=1760517869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlSjJCs7A1ERmjbEvfSkW/CmM7q/PE2PcmG+9t+wYEo=;
        b=LN31O0VkgSr2AlrP511+XY+kzc1vP0vEZqpkX3GH1Jip1ZPMeAqB+OeHYfajdZjZzU
         lTE77Mim3QdJL5FOVreSMGf37B9oM9hXCT9CI5fKO4CgGHxmUx2tasyGr1j0Gaib2zNv
         jcgfhwRNgLAn3uClyY+6rvKVoopLb6lexmL57TIdU9Vs5Y38XDdj/pudL6PJL+3GWCx7
         bvb5rwCbzRSXUQdQP7AEQiq4SQgWHTeT60lYSvj7nwOb4Gcr5bzMfCcZhkFDuB9P9g0E
         fg7BmanAtHjwOu3FpjYp9TKWW5/5QKUw+bEadOjZCgE9BD2AEJEd/xlEVKBUslZZptrS
         LdiA==
X-Forwarded-Encrypted: i=1; AJvYcCU7dn/M+qbA+mJZBkZXX/7gbe843g8+DHSstSE22CmGZgy19Rb2fIWSI9a9kguVW9qYJfyirzr1DjWXSc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/jwCffgk9nQ3OWCQ5No2cUQmFP/G+kjpgL+QGGIbjssefoDEv
	ou4Cdgm7g6Lob1yAu+tjbAg6r70rkG4/GX8S/8jdEJAMyVhkH1VJlwh0kGQeUHA0vj8Qu1Xty7B
	deEl8nk5EAjYL64R512UCCKb2BugGz9sP2hjOf8yv
X-Gm-Gg: ASbGncvR34nyYVrgFIj+PenjSQlYtsnFOrMNBecljbrmunn3/96ZdXH6bM9tI90rnWI
	z8YnzmD3tI2bTEHN8n88WdMdBrWGlIL4vrWBihXhjmIA+gsj569J4LtSyz8MZkI9VHhmpnyrkyy
	sqnv4RFMNG1tH9cWA6vu0eK9mSkO3RdzZoyVt42ZVX1vty9QOYAvB6DKrV2sH4u6zRyU4vUT/re
	if/GCEMwk/vWYpPWsoGjZk1R8H7XFZXkRCSUNmHypJ81RYCUEpUCo3EAYalkU5CuDkXPN6QUVvT
	FEU=
X-Google-Smtp-Source: AGHT+IH6T8Z0phHUrkW2LYomzcuIMTigkC4dYVy2h9gd9Ou0VM87Kj2q+2642RYcQOs3k9cE8zHQiNe+PBbwdD28j0U=
X-Received: by 2002:ac8:5914:0:b0:4e2:cb29:22c6 with SMTP id
 d75a77b69052e-4e6ead46a0bmr35675251cf.53.1759913068856; Wed, 08 Oct 2025
 01:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925223656.1894710-1-nogikh@google.com> <CAG_fn=U3Rjd_0zfCJE-vuU3Htbf2fRP_GYczdYjJJ1W5o30+UQ@mail.gmail.com>
In-Reply-To: <CAG_fn=U3Rjd_0zfCJE-vuU3Htbf2fRP_GYczdYjJJ1W5o30+UQ@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 8 Oct 2025 10:43:51 +0200
X-Gm-Features: AS18NWD2m7wRQRTYoE5oa91q74s9ueKa5gBPaHOd5rYELKrxuXExAl7EfwP9pSs
Message-ID: <CAG_fn=WUGta-paG1BgsGRoAR+fmuCgh3xo=R3XdzOt_-DqSdHw@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in eth_type_trans
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Leon Romanovsky <leonro@nvidia.com>, mhklinux@outlook.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 8:51=E2=80=AFAM Alexander Potapenko <glider@google.c=
om> wrote:
> Folks, as far as I understand, dma_direct_sync_single_for_cpu() and
> dma_direct_sync_single_for_device() are the places where we send data
> to or from the device.
> Should we add KMSAN annotations to those functions to catch infoleaks
> and mark data from devices as initialized?

Something along the lines of:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0d37da3d95b65..7f59de19c1c87 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -42,6 +42,7 @@
 #include <linux/string.h>
 #include <linux/swiotlb.h>
 #include <linux/types.h>
+#include <linux/kmsan-checks.h>
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 #include <linux/of.h>
 #include <linux/of_fdt.h>
@@ -903,10 +904,13 @@ static void swiotlb_bounce(struct device *dev,
phys_addr_t tlb_addr, size_t size

                        local_irq_save(flags);
                        page =3D pfn_to_page(pfn);
-                       if (dir =3D=3D DMA_TO_DEVICE)
+                       if (dir =3D=3D DMA_TO_DEVICE) {
+                               kmsan_check_highmem_page(page, offset, sz);
                                memcpy_from_page(vaddr, page, offset, sz);
-                       else
+                       } else {
+                               kmsan_unpoison_memory(vaddr, sz);
                                memcpy_to_page(page, offset, vaddr, sz);
+                       }
                        local_irq_restore(flags);

                        size -=3D sz;
@@ -915,8 +919,10 @@ static void swiotlb_bounce(struct device *dev,
phys_addr_t tlb_addr, size_t size
                        offset =3D 0;
                }
        } else if (dir =3D=3D DMA_TO_DEVICE) {
+               kmsan_check_memory(phys_to_virt(orig_addr), size);
                memcpy(vaddr, phys_to_virt(orig_addr), size);
        } else {
+               kmsan_unpoison_memory(vaddr, size);
                memcpy(phys_to_virt(orig_addr), vaddr, size);
        }
 }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

should be conceptually right, but according to the comment in
swiotlb_tbl_map_single()
(https://elixir.bootlin.com/linux/v6.17.1/source/kernel/dma/swiotlb.c#L1431=
),
that function is deliberately copying the buffer to the device, even
when it is uninitialized - and KMSAN actually started reporting that
when I applied the above patch.

How should we handle this case?
Not adding the kmsan_check_memory() calls will solve the problem, but
there might be real infoleaks that we won't detect.
We could unpoison the buffer before passing it to
swiotlb_tbl_map_single() to ignore just the first infoleak on the
buffer.
Alternatively, we could require callers to always initialize the
buffer passed to swiotlb_tbl_map_single().

