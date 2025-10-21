Return-Path: <linux-kernel+bounces-862942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCA0BF695C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23FF423663
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8401333740;
	Tue, 21 Oct 2025 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aG9ukBQj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8B2749D6
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051579; cv=none; b=ARTd+eoxO1Wgg4tRBGfNKOD71EW7OApc7dk6FkokJDpuERP584Q8H5wUwUXbWPBCWcMtFoIMKG844TUC/Phi6Zuesl/Uf7oaXRTCR/5AwvYTCWh3D9DdpXHNC3m5CPg3Z643FUep22GwhQ05xni3Taj+UUomgkZvSMSHHgD+BN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051579; c=relaxed/simple;
	bh=F2i/t3Rr4/yrOauE4NxVRju8DiBbGS7hQ62g+htZfA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VNJ0ZGIX+fWF4Hv+ORXDhRsn1WRSu5emjUS71daIoE9GfrimamxmmWYFJjb63xDB4oI0pCw6BhZN0aoyrTekUO0SZCU8N8wW7IN7DAMHb+aFSDyS37FU2Fw0iFuLEr2mQJCn3ZlIEJx0nEsRUEk6vFcGqqqMj8VAO8AkFS2PhYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aG9ukBQj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=omAB84zm1ZJJGkhLo0LBcnP4dZPVDNNrUkrD6enlyeI=;
	b=aG9ukBQjBk5GKfZEJ5+4xJWqUb4xddeh+AAm/v8I1t3d+n3EzI7AuyDL3CCZkXxB5VpF67
	eyR/ZgKVxiUYe8h+bhmMCZENyhmJKoHxiikL08QUN2wCJLKYayYH1Xa0M4E6P77a80xhD2
	e6X3C/Wc2QUa1HKuVnHAqzTmIdQ6HCg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-hQ4FhZePM4yN4-nxGNxb6Q-1; Tue, 21 Oct 2025 08:59:34 -0400
X-MC-Unique: hQ4FhZePM4yN4-nxGNxb6Q-1
X-Mimecast-MFC-AGG-ID: hQ4FhZePM4yN4-nxGNxb6Q_1761051573
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46fa88b5760so19026375e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051573; x=1761656373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omAB84zm1ZJJGkhLo0LBcnP4dZPVDNNrUkrD6enlyeI=;
        b=jzkHhxa0lhf4z8QjWhvEvrSFtT8cPvADSose3w1yzFBcuBOcUrMJGxX6n1dOvmmss/
         5kwieX3svy2pIXG3RgDQV/M2q4ZR411sjR8akcLDbzvI0cNd69/bS2e9SdmDqFDHfUBG
         hHu6mB62igq2/cQ+LawthTQFxZWM5hJCJDGC2b0aSnC3ujQuSN5LMmyHLRzXyIR2QyLX
         RvlAZu/pp9THqWNQfxV99pDo8Y778S9O3iB0NGSUhH3GQQkpbYHCaBw2WklCfMWOIWv8
         hlYru6HYgWvuMOhaxZGXC4FYjJGu/PIC+aZEM2z1NqQDVqEwfJRt+iT/06I1DdMnb+Lp
         2tPg==
X-Gm-Message-State: AOJu0YwGh3EM1RLeH71pTLInyRfmGMpAzozurx+6m/aoDHyAHAlXLGuk
	u1PowzIU/LLMSlzxVIbm6IaxXD9iGwG2fz3HldozMQn/FNAjcNsd85w4J//FSgYOaJWEDKR7zyn
	WDoOZ3OQAJ3rcaLdn9GdOAlEcfURIxc7F9XLi7sRS0PBX9Y7gxQ2TydfLpkNJrCtQ/9sfXuHLiS
	lyXCLM/oumhKZD8JHsvo2S605ozFGdNozVIhh15n8OtmyUCA==
X-Gm-Gg: ASbGncvR0sZx2GK70cm/WdxUkcbjFH3xUWyl8dxzTeGunLH7VglgprYSTuQ/ESYsl3n
	/K4szdhhuwX5ZmhuRHkeUc1UWxwNnDYJDUumcgDlKfcOfRbDXCKGXfAujYIbZR49PwclVlZUU+J
	qXhaIG0Idzf8xf2Yn7UfYHM8KwCmu2IcC2bzLrXyq+wrjb6/y7U0v5S7giPWWrtf4ZE9UhguyxM
	dk3/KTGmtFy4odVgw25wY09C2ISUN7ReHFj7WM0Dk0Oo1AK6DXD5MK/8yFHSq9mYmVhz8SIigfi
	5F/2TKEHGoIpca3qx65syPlJvq6lFsWrjBLv9oenU6prlYAv7VvPJZyoyp4kuPCrGMOkp2FtgKc
	0Vd5E3APi4hbuonE5JqOkWoPMazaFv6Oa81snIgkv/EId5D5nqVo+3zaQNbXj
X-Received: by 2002:a05:600c:3b03:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-471178a3ff6mr120309705e9.18.1761051572748;
        Tue, 21 Oct 2025 05:59:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN1EuUZZ8R3FSSnr8qb9y2RESEr9jR6C/rPmGSz5JIIAcste2ucC0iMZFWCPlNIaKu6Wi9QA==
X-Received: by 2002:a05:600c:3b03:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-471178a3ff6mr120309195e9.18.1761051572222;
        Tue, 21 Oct 2025 05:59:32 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5b3dabsm21210821f8f.16.2025.10.21.05.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:31 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 00/23] mm: balloon infrastructure cleanups
Date: Tue, 21 Oct 2025 14:59:05 +0200
Message-ID: <20251021125929.377194-1-david@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is based on mm/mm-unstable with two PPC CMM fixes I sent out
separately earlier today [1] applied first.

[1] https://lkml.kernel.org/r/20251021100606.148294-1-david@redhat.com

---

I started with wanting to remove the dependency of the balloon
infrastructure on the page lock, but ended up performing various other
cleanups, some of which I had on my todo list for years.

This series heavily cleans up and simplifies our balloon infrastructure,
including our balloon page migration functionality.

With this series, we no longer make use of the page lock for PageOffline
pages as part of the balloon infrastructure (preparing for memdescs
where PageOffline pages won't have any such lock), and simplifies
migration handling such that refcounting can more easily be adjusted
later (long-term focus is for PageOffline pages to not have a refcount
either).

Plenty of related cleanups.

Heavily compile-tested and heavily runtime-tested with virtio-balloon.
PPC CMM and the VMware balloon are untested and I'd appreciate a helping
hand from people that have suitable environments.

Not CCing maintainers for the vmscan.c and migrate.c change as they
are rather trivial and I don't want to patchbomb them.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>

David Hildenbrand (23):
  vmw_balloon: adjust BALLOON_DEFLATE when deflating while migrating
  vmw_balloon: remove vmballoon_compaction_init()
  powerpc/pseries/cmm: remove cmm_balloon_compaction_init()
  mm/balloon_compaction: centralize basic page migration handling
  mm/balloon_compaction: centralize adjust_managed_page_count() handling
  vmw_balloon: stop using the balloon_dev_info lock
  mm/balloon_compaction: use a device-independent balloon (list) lock
  mm/balloon_compaction: remove dependency on page lock
  mm/balloon_compaction: make balloon_mops static
  mm/balloon_compaction: drop fs.h include from balloon_compaction.h
  drivers/virtio/virtio_balloon: stop using balloon_page_push/pop()
  mm/balloon_compaction: remove balloon_page_push/pop()
  mm/balloon_compaction: fold balloon_mapping_gfp_mask() into
    balloon_page_alloc()
  mm/balloon_compaction: move internal helpers to memory_compaction.c
  mm/balloon_compaction: assert that the balloon_pages_lock is held
  mm/balloon_compaction: mark remaining functions for having proper
    kerneldoc
  mm/balloon_compaction: remove "extern" from functions
  mm/vmscan: drop inclusion of balloon_compaction.h
  mm: rename balloon_compaction.(c|h) to balloon.(c|h)
  mm/kconfig: make BALLOON_COMPACTION depend on MIGRATION
  mm: rename CONFIG_BALLOON_COMPACTION to CONFIG_BALLOON_MIGRATION
  mm: rename CONFIG_MEMORY_BALLOON -> CONFIG_BALLOON
  MAINTAINERS: move memory balloon infrastructure to "MEMORY MANAGEMENT
    - BALLOON"

 .../admin-guide/mm/memory-hotplug.rst         |   8 +-
 Documentation/core-api/mm-api.rst             |   2 +-
 MAINTAINERS                                   |  12 +-
 arch/powerpc/platforms/pseries/Kconfig        |   2 +-
 arch/powerpc/platforms/pseries/cmm.c          |  53 +----
 drivers/misc/Kconfig                          |   2 +-
 drivers/misc/vmw_balloon.c                    | 105 +++-------
 drivers/virtio/Kconfig                        |   2 +-
 drivers/virtio/virtio_balloon.c               |  64 ++----
 include/linux/balloon.h                       |  77 +++++++
 include/linux/balloon_compaction.h            | 160 ---------------
 include/linux/vm_event_item.h                 |   8 +-
 mm/Kconfig                                    |  23 +--
 mm/Makefile                                   |   2 +-
 mm/{balloon_compaction.c => balloon.c}        | 194 +++++++++++++-----
 mm/memory_hotplug.c                           |   4 +-
 mm/migrate.c                                  |   2 +-
 mm/vmscan.c                                   |   1 -
 mm/vmstat.c                                   |   8 +-
 19 files changed, 314 insertions(+), 415 deletions(-)
 create mode 100644 include/linux/balloon.h
 delete mode 100644 include/linux/balloon_compaction.h
 rename mm/{balloon_compaction.c => balloon.c} (59%)

-- 
2.51.0


