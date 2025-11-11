Return-Path: <linux-kernel+bounces-895967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B92C4F61A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 320D7344A73
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1693A1CFB;
	Tue, 11 Nov 2025 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/Urs8JW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D5272801
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884777; cv=none; b=CiL5oLAF+wSmPt4i77CgvgrIa+295YXR4b+GuIQ6+jMa5MhTjzOKpAEQYC9bFZP7wWnGdO40JvYqUIZ7Hkrc+vgWQNMf/GuuqEhk6sopRbAP3eKmd/ESxIoy0mDqXXhrRbUVeejqmCAUCEfmfDXGoYSUS03Mj7dQPtJNkAzkr2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884777; c=relaxed/simple;
	bh=Wkh0MXpt0jkH3qMK7memVYmYm/3Zw3vmTkjgkL9MuJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QxBbOjMrS1A/7wZHrCZHkJb/5G5rcEzXZh1YGq3ip1NX8snQmOCcIAiNrZ0f0+5M21WA+AIXrydhkyPoLJw3PKrT+P5U8WCKBa0XgfcPBBvibcF2E33HQXhlW2GDne8pXnypIkXcYUgmjeRTx0KNI06SNquUH4nQ9yIQm88ctHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/Urs8JW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762884775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kbBT0LpREuk2X1cRxrYwVwo+ggq8/d3myNs3fV/FRtA=;
	b=M/Urs8JWatEmbnUnpZmmAATMRRHsLru/ZK3wC5b+p4U6OFAyJj5fb4xWq+nRUhOdZYnMvG
	yYZVW3naK3RrHtcjtsVtuGYyvrzRH96KmSV8n5UqIfJsl4psngLhkHQsaRBtG5+bXXhQXR
	1PRGiH5UeUS8/BndZVegQ5kgrhHs2e0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-NPOeYaAjOu-TTXVDs8HqEA-1; Tue,
 11 Nov 2025 13:12:52 -0500
X-MC-Unique: NPOeYaAjOu-TTXVDs8HqEA-1
X-Mimecast-MFC-AGG-ID: NPOeYaAjOu-TTXVDs8HqEA_1762884770
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F06F18002C2;
	Tue, 11 Nov 2025 18:12:50 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE31E1800451;
	Tue, 11 Nov 2025 18:12:45 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/6] dpll: zl3073x: Refactor state management
Date: Tue, 11 Nov 2025 19:12:37 +0100
Message-ID: <20251111181243.4570-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This patch set is a refactoring of the zl3073x driver to clean up
state management, improve modularity, and significantly reduce
on-demand I/O.

The driver's dpll.c implementation previously performed on-demand
register reads and writes (wrapped in mailbox operations) to get
or set properties like frequency, phase, and embedded-sync settings.
This cluttered the DPLL logic with low-level I/O, duplicated locking,
and led to inefficient bus traffic.

This series addresses this by:
1. Splitting the monolithic 'core.c' into logical units ('ref.c',
   'out.c', 'synth.c').
2. Implementing a full read/write-back cache for 'zl3073x_ref' and
   'zl3073x_out' structures.

All state is now read once during '_state_fetch()' (and status updated
periodically). DPLL get callbacks read from this cache. Set callbacks
modify a copy of the state, which is then committed via a new
'..._state_set()' function. These '_state_set' functions compare
the new state to the cached state and write *only* the modified
register values back to the hardware, all within a single mailbox
sequence.

The result is a much cleaner 'dpll.c' that is almost entirely
free of direct register I/O, and all state logic is properly
encapsulated in its respective file.

The series is broken down as follows:

* Patch 1: Changes the state structs to store raw register values
  (e.g., 'config', 'ctrl') instead of parsed booleans, centralizing
  parsing logic into the helpers.
* Patch 2: Splits the logic from 'core.c' into new 'ref.c', 'out.c'
  and 'synth.c' files, creating a 'zl3073x_dev_...' abstraction layer.
* Patch 3: Introduces the caching concept by reading and caching
  the reference monitor status periodically, removing scattered
  reads from 'dpll.c'.
* Patch 4: Expands the 'zl3073x_ref' struct to cache *all* reference
  properties and adds 'zl3073x_ref_state_set()' to write back changes.
* Patch 5: Does the same for the 'zl3073x_out' struct, caching all
  output properties and adding 'zl3073x_out_state_set()'.
* Patch 6: A final cleanup that removes the 'zl3073x_dev_...' wrapper
  functions that became redundant after the refactoring.

Changes:
v2:
- addressed issues found by patchwork bot (details in each patch)

Ivan Vecera (6):
  dpll: zl3073x: Store raw register values instead of parsed state
  dpll: zl3073x: Split ref, out, and synth logic from core
  dpll: zl3073x: Cache reference monitor status
  dpll: zl3073x: Cache all reference properties in zl3073x_ref
  dpll: zl3073x: Cache all output properties in zl3073x_out
  dpll: zl3073x: Remove unused dev wrappers

 drivers/dpll/zl3073x/Makefile |   3 +-
 drivers/dpll/zl3073x/core.c   | 243 +----------
 drivers/dpll/zl3073x/core.h   | 184 +++-----
 drivers/dpll/zl3073x/dpll.c   | 776 ++++++++--------------------------
 drivers/dpll/zl3073x/out.c    | 157 +++++++
 drivers/dpll/zl3073x/out.h    |  93 ++++
 drivers/dpll/zl3073x/prop.c   |  12 +-
 drivers/dpll/zl3073x/ref.c    | 194 +++++++++
 drivers/dpll/zl3073x/ref.h    | 134 ++++++
 drivers/dpll/zl3073x/synth.c  |  87 ++++
 drivers/dpll/zl3073x/synth.h  |  72 ++++
 11 files changed, 1009 insertions(+), 946 deletions(-)
 create mode 100644 drivers/dpll/zl3073x/out.c
 create mode 100644 drivers/dpll/zl3073x/out.h
 create mode 100644 drivers/dpll/zl3073x/ref.c
 create mode 100644 drivers/dpll/zl3073x/ref.h
 create mode 100644 drivers/dpll/zl3073x/synth.c
 create mode 100644 drivers/dpll/zl3073x/synth.h

-- 
2.51.0


