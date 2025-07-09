Return-Path: <linux-kernel+bounces-724466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4738AFF343
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5DE91C46F4E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2872376F2;
	Wed,  9 Jul 2025 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="el53lsXC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C5233152
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094533; cv=none; b=JNWS8u19DKMqZmcSprlQ+QFTrOvpeGkrs36rgrzVKvOFuXo+1M67I8q7PMae+L1fH5vwMj45ukLuvKNejpNFv4wWMiq+E+t0egVR6s+/y+RkRJJkiyKlfCdSrUNxal0UDxt93tkKE0r3Xr0vhMLwAL/EPCQyYqsKbHo9HZs48Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094533; c=relaxed/simple;
	bh=JTJVkmOLnRfILK5ufjbxQjP514STuLltf2LGrFdAEPA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IBkcRxABt2RN3n49DVz0oIAluQ6h/cUwyDaVC10Ep7HorCzIr+e30iYQqKB6RFKYZGUnO49sBhQzE4y682So/3HRgTLOeFT8T/qvqmff2DJJV/MpTdsMQgZsJxsP9Cfp56RGbyURHx08Sq73IhNin8bHangXKG2kuqDfalkU9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=el53lsXC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752094529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=1eeG0+aNHKSbFK7ky8dnoR90LoNUZNKrOGjsnQWQ9MY=;
	b=el53lsXCiHq/Fp6+66xdDJWwmexqekfw9UKaflj581MhE+eEWKlMNFfoh1B/pMLM/E7j2G
	UfFHwJ1erjaWMgNHeJvz4MBmaBU1cEp8gd1n0VHqlqDeCNhFQ7X1hoeeDxsiuC9JrulQLN
	bSq9z1aluh8nfwrwNNNGHD6i9E1SxG8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-fucQP8hIO8Wy7lvlOdU6uA-1; Wed, 09 Jul 2025 16:55:28 -0400
X-MC-Unique: fucQP8hIO8Wy7lvlOdU6uA-1
X-Mimecast-MFC-AGG-ID: fucQP8hIO8Wy7lvlOdU6uA_1752094527
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4e9252ba0so208137f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 13:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752094527; x=1752699327;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eeG0+aNHKSbFK7ky8dnoR90LoNUZNKrOGjsnQWQ9MY=;
        b=OHL7nY+rF7a849HqapcslQ7LGqH+fZrSmye3yAOtRKd6RqQ/kue1jMzZ8ZhAXp0daK
         w85pT3Ux5FXtJ/mSJ2F+/FkiYqscqr4rRRIQ9tjXHg5qM1E+U/yA6BhYTbPhlNCZpw6y
         stI6aCRiIn/mVQEVzEvSwZ0aifnEmo2HzGw2nTwP8Qbau6jLDz+4Dg9jJRp1LNnKtJty
         S1U2ntNGPyHMmrtmT+pOQrjkVGzSwFytcLp4MfDo71pg8LwjHyYzyj2hl5S7JWJvxvr9
         Z296YGySFU59+08yIM25Fsucyxx0/7PX59NzlyWXRaM8afOHeRMwuQhPl7H7GxLDV92l
         347A==
X-Gm-Message-State: AOJu0YwhhwAXmD8jZbSFl1XoE41oQCPfTA8j1LUCi2OTHKmHLuzcCcMR
	J6g0CpgkHRCPJaHVXDMuv8UZ4NyAEuoq90+fzQL+F31xOGZp7mgSbSFCfnWxH2Ymm9RdOo0+7Qo
	MbPYHHs2ysEAhjMz91ZVL4hDX+UzW55bd5DM4y6Mz0s5egvYh5Ujh2pU6qesy8PNgXfzLkEDOEB
	QCErdA0zbwP/6bsa8m3rV55l68npAXEaEXsYmafIcnf0Y=
X-Gm-Gg: ASbGncs3t2WifjNJAZ0a+I2/Kj4mGeKO1eSfdrJ0yhqKBOREz8T1SgOiltAjBnRMLuW
	LvXA3/CXqR1HVH8MKnN1mR/JmZGu3OcPAL28fDJ92NUoGiIxVXxOHtp8tYVoIG08jOY2B9AZZ25
	41bwu6TlgGwjQRNaTIsJb9bPGqEtMblqPYcZgVfc4HnErC8b8WdXWbli3EnXSquUdL8u/h7yrG8
	xKFO8IXtgMXKAdaqVB0Qfuz+oLFswZ2px5KyGq1ILaplCEkRWFBxD75hQsGvAjcWU/hcOwW0f1l
	G6nagOxEv917Wsw=
X-Received: by 2002:a05:6000:2913:b0:3a4:efbb:6df3 with SMTP id ffacd0b85a97d-3b5e788d2c4mr1319071f8f.10.1752094526842;
        Wed, 09 Jul 2025 13:55:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENLpfIvJB+dmyEoPgLHpsVWD6fbGIZAwezKmU2P9msQM/dbc5vXYMGNyI9NmDpA09Z2FQx2w==
X-Received: by 2002:a05:6000:2913:b0:3a4:efbb:6df3 with SMTP id ffacd0b85a97d-3b5e788d2c4mr1319054f8f.10.1752094526364;
        Wed, 09 Jul 2025 13:55:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50516f1sm35729015e9.16.2025.07.09.13.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:55:25 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:55:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com
Subject: [PATCH RFC v5 0/5] pci,virtio: report surprise removal event
Message-ID: <cover.1752094439.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent


Lukas, Keith, Bjorn, others, would very much appreciate your comments
on whether the pci core changes are acceptable.


Parav, I expect this to be integrated into your work on fixing surprise
removal. As such, I am not queueing these patches yet - please include with your
other patches fixing these issues.

==========

This is an attempt to fix the following race in virtio:

when device removal is initiated by a user
action, such as driver unbind, it in turn initiates driver cleanup and
is then waiting for an interrupt from the device. If the device is now
surprise-removed, that interrupt never arrives and the remove callback hangs
forever.

For example, this was reported for virtio-blk:

        1. the graceful removal is ongoing in the remove() callback, where disk
           deletion del_gendisk() is ongoing, which waits for the requests +to
           complete,

        2. Now few requests are yet to complete, and surprise removal started.

        At this point, virtio block driver will not get notified by the driver
        core layer, because it is likely serializing remove() happening by
        +user/driver unload and PCI hotplug driver-initiated device removal.  So
        vblk driver doesn't know that device is removed, block layer is waiting
        for requests completions to arrive which it never gets.  So
        del_gendisk() gets stuck.

We could add timeouts to handle that, but given virtio blk devices are
implemented in userspace, this makes the device flaky.

Instead, this adds pci core infrastructure, and virtio core
infrastructure, for drivers to be notified of device disconnect.

Actual cleanup in virtio-blk is still TBD.
Compile-tested only.

==========

Notes on the design:

Care was taken to avoid re-introducing the bug fixed by

commit 74ff8864cc84 ("PCI: hotplug: Allow marking devices as disconnected during bind/unbind")

To avoid taking locks on removal path, and to avoid invoking callback
with unpredictable latency, the event is reported through a WQ.

Adding APIs to enable/disable the reporting on probe/remove, helps make
sure the driver won't go away in the middle of the handling, all
without taking any locks.

The benefit is that the resulting API is harder than a callback to
misuse, adding unpredictable latencies to unplug. The WQ can simply do
the cleanup directly, taking any locks it needs for that.  The cost is
several extra bytes per device, which seems modest.


Previous discussion:
https://lore.kernel.org/all/11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com

Changes from v4:
	fix !CONFIG_PCI, reported by Stephen
Changes from v3:
	added documentation to address comments by Parav
	support in virtio core
Changes from v2:
        v2 was corrupted, fat fingers :(
Changes from v1:
         switched to a WQ, with APIs to enable/disable
         added motivation

==========


Michael S. Tsirkin (5):
  pci: report surprise removal event
  virtio: fix comments, readability
  virtio: pack config changed flags
  virtio: allow transports to suppress config change
  virtio: support device disconnect

 drivers/pci/pci.h                  |  6 ++++
 drivers/virtio/virtio.c            | 23 +++++++++++++--
 drivers/virtio/virtio_pci_common.c | 45 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.h |  3 ++
 drivers/virtio/virtio_pci_legacy.c |  2 ++
 drivers/virtio/virtio_pci_modern.c |  2 ++
 include/linux/pci.h                | 45 ++++++++++++++++++++++++++++++
 include/linux/virtio.h             | 11 ++++++--
 include/linux/virtio_config.h      | 32 +++++++++++++++++++++
 9 files changed, 163 insertions(+), 6 deletions(-)

-- 
MST


