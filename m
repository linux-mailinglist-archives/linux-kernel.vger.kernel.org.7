Return-Path: <linux-kernel+bounces-845735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D926BBC6007
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBEBE427CA1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9078E2EC571;
	Wed,  8 Oct 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWBMIDax"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2AE2BE048
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939734; cv=none; b=GqRMx7JDxO2pMqszHGgGWjDbN5lGIPiowma0IyB3L55fZ/OPEaBBs4ZbiwVh3nP+i+6/30Q2AG35LiERAH2DwGEZrtTfyyOp9sZd8ukt7kAOlsNKmRw52kWua+/ztxO0Cp7PZ+tmfLu3956qeH/KJRpTN/C7EuaJTX3aaxBe7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939734; c=relaxed/simple;
	bh=vk3AuPzABSqiYhDKyK5DZW5TBoEaJm0wm/y7QixLxVw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=O8f0RFBEpqlndFT5P8vejKS8e/qAMYlCUZEVg/NB3mVeSy8aVoHEw4jUSf8zNY7qYwlNZSmMEsSEfvo+sMM7Hs/VkMngyHxzR/TX+KQPGYtPEfnk/9256KlRNnNkq7biUWV4GDTRMXwPh+OP+xDIwCOtcBA5PKCdaG07TqNg3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWBMIDax; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759939732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d83HNR6tAkbhcYaA0tnAzOhkHW7QfhiumWGCMyzcg9A=;
	b=hWBMIDaxhaAtdEdpLAnIC7J6jcIMfnYJivMpbZyKWk9TfL3TVWLKwWLwEEwUzYeUQCsq+F
	SH5J/9/C5D/S+agmv7HQmfzadJewLG2hg6DcFPkFxRk51c0VWUEB1jPX2qVqsUSU37zNLt
	FWYWYbLqmltpkqZJE1VX1oZqI3wnKOE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-SvaXtyJoMEWkkgFdwVbGKw-1; Wed, 08 Oct 2025 12:08:51 -0400
X-MC-Unique: SvaXtyJoMEWkkgFdwVbGKw-1
X-Mimecast-MFC-AGG-ID: SvaXtyJoMEWkkgFdwVbGKw_1759939730
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88432e707b0so61170839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759939730; x=1760544530;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d83HNR6tAkbhcYaA0tnAzOhkHW7QfhiumWGCMyzcg9A=;
        b=gIXkWfjebSQfBbE5YaIX1y0tAR1ZwkrBXIDmM2B+IzCIBIIReVNhphNfaEkQc0H6Kf
         h9G7VDGP9hSmk4TBLI3Hu4f+oAKibXsDYYacaVvx3XdeYYg+aB1l0SHVgmKhJv9ps10a
         5dWg3BEXdVh1Se5AInBOlLvHsBtInyv+FeH4uB9B/nNv8H/gGGWfoXW1X532v13hsVNK
         cyK3k6X6iUofFAx1glLpBlnTt9Lc1bSFEUfhxMoxuzosHiqTT1p1cyogK3XDDzLaJONu
         lm9ITid3DXQnodqHy1aweM1cqcQGSsJ5LLvghRzUGbQEyr0Jupj7/lYye1rtugCtbgyN
         Katg==
X-Gm-Message-State: AOJu0YzaPaLKTmdj2iXa6dcF461Aq2eyAyMYtrUKU/7MczCpnAYpyCdX
	CNvRgsZbjLsNeS7CMYdqDdgtaJ7/jDzakte7mTOg1D7JWuvW/Xjb8qZDVR2xmCSkxVl0vxXcmBU
	L0+9cWyXCDU34uCaiL45L/P1eQoEd/PkM3WK59ixiSDjcdUuvenJZXSUT9wEzULN7aA==
X-Gm-Gg: ASbGnct1cM5kwBpVkJ6DC5tuaKieGbu76yofzpbYB1qc44j2SLQx7UEVqIRqG82Pjrp
	/Ox/8mUg8k+ZW9hmJmhfLZcRhAv+jvrpMGSrcCnZ90WeIbJMUycj8IiObif84Ge3qE3KOcBrku0
	JjZ4ECBQfKMhG6bz+815uzS375hoRAXfsNYhRo2kYOV0Q/mYjyOdKQpz1LDFQWbaQlkk5ejnvcQ
	TkOUsAFPX14IyxrJPOx6So29IVERmQqvPhCeJW7zx380WtYcyS25ppCEvSIZyfPonrAkgtwN8sC
	CKDYfmMtRL+dBNRrgoKYm5C3b5Dbj5l9IJwZT8qK+y4uVxMY
X-Received: by 2002:a05:6602:4016:b0:921:5e64:677 with SMTP id ca18e2360f4ac-93bd197e8cfmr161409739f.4.1759939730075;
        Wed, 08 Oct 2025 09:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg4nuM2w2if09kF/9hjDJAQxyAe4TBWUu9omT72OFBq2W4qsR27e2Ru0/zlWuNm4KiUOruMg==
X-Received: by 2002:a05:6602:4016:b0:921:5e64:677 with SMTP id ca18e2360f4ac-93bd197e8cfmr161408239f.4.1759939729565;
        Wed, 08 Oct 2025 09:08:49 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5e9ec393sm7191810173.14.2025.10.08.09.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:08:48 -0700 (PDT)
Date: Wed, 8 Oct 2025 10:08:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, David
 Hildenbrand <david@redhat.com>, lizhe.67@bytedance.com, =?UTF-8?B?Q8Op?=
 =?UTF-8?B?ZHJpYw==?= Le Goater <clg@redhat.com>
Subject: [GIT PULL] VFIO updates for v6.18-rc1 part 2
Message-ID: <20251008100846.47bcedd1.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Sorry for the two part pull request, this is mostly the DMA map/unmap
optimization series that we tried to get into v6.17, but made use of
the nth_page API that generated some objections.  That has since been
removed, but was stalled again by the page_to_section() to
memdesc_section() change, where I opt'd for this two part approach
rather than resolution buried in a merge commit since we saw it coming.
Thanks,

Alex

The following changes since commit fd94619c43360eb44d28bd3ef326a4f85c600a07:

  Merge tag 'zonefs-6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/=
git/dlemoal/zonefs (2025-10-05 20:45:49 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v6.18-rc1-pt2

for you to fetch changes up to 451bb96328981808463405d436bd58de16dd967d:

  vfio: Dump migration features under debugfs (2025-10-06 11:22:48 -0600)

----------------------------------------------------------------
VFIO updates for v6.18-rc1 part 2

 - Optimizations for DMA map and unmap opertions through the type1
   vfio IOMMU backend.  This uses various means of batching and hints
   from the mm structures to improve efficiency and therefore
   performance, resulting in a significant speedup for huge page
   use cases. (Li Zhe)

 - Expose supported device migration features through debugfs.
   (C=C3=A9dric Le Goater)

----------------------------------------------------------------
C=C3=A9dric Le Goater (1):
      vfio: Dump migration features under debugfs

Li Zhe (5):
      mm: introduce num_pages_contiguous()
      vfio/type1: optimize vfio_pin_pages_remote()
      vfio/type1: batch vfio_find_vpfn() in function vfio_unpin_pages_remot=
e()
      vfio/type1: introduce a new member has_rsvd for struct vfio_dma
      vfio/type1: optimize vfio_unpin_pages_remote()

 Documentation/ABI/testing/debugfs-vfio |   6 ++
 drivers/vfio/debugfs.c                 |  19 ++++++
 drivers/vfio/vfio_iommu_type1.c        | 112 ++++++++++++++++++++++++++---=
----
 include/linux/mm.h                     |   7 ++-
 include/linux/mm_inline.h              |  36 +++++++++++
 5 files changed, 158 insertions(+), 22 deletions(-)


