Return-Path: <linux-kernel+bounces-725488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E665AFFFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A58B7B334A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89A82E0939;
	Thu, 10 Jul 2025 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="Y2amTz0t"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8624501E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145087; cv=pass; b=jONXU0F0agq34/Zca6/9NW0KFxup6gpzv7TN/oz8qCGDe6BhDWZXNpGZhcm0Co35PiK5i1BhElXXrFJNOsSluh+kyyyyaUwItG5O4Mw2bdIOF1oG5TkTG3uEmzjzjyxoDTnIs7/ui5DLxGS1ZLhK7qSC0wfT+cndZ30Sl6CtRow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145087; c=relaxed/simple;
	bh=JzOEzQ4u4rtw2NIBLOcRDtDefM3sgL3nRVZ/m4mk2yc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ulyX8Kje7imuyQ3tgCEFg4kPScU6pg2Q5NmzpXW1GJtcDo63rdOyMjplQGy5hQoK2f03vZRn1yQHPDnvLUxJVz7l/Vxh+VHXDQ4k/DTCxZFRjREGtzYOO+R2Y55ModKzyigYABHW9AKQZrXVgSXjHBRu26IaTsaZ6xo79LBPMdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=Y2amTz0t; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1752145042; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C7R/uEgzS8DBaItptc8pmQ/N4XdTC9BtVmSrxUSFnurBo3Sx8VY9jI3eQstJ4XxE4V63oX6AzD1BnsnQCZItvMBIICSVHmEbj3iyX3uxsGQvs4mDQKegxr+qND0yKObhqQXpSBgUtR89uhUsVK9hhd5HkTKVHVWe7LZAfMMHBrM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752145042; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=yiEYKiYWi9lfEelzgS689BygDZKCSEUDoT6dG+OBGmU=; 
	b=U/bnAvbtIfwE1blvERtTfUL+ZMXe36eRgIzSyTGqCbcT8R1lbhqZtIWFQ7uXDXvAa4x3/l+VWGt/aHal7XlneKHg7d1LityuLX3oFGdg7aXAzT4JcEaNbL0hZunTkmJSOoBwzA5P3lYM/VpnO0FrZ8QS5HQtQTPpn/DfxBUiwH4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752145042;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=yiEYKiYWi9lfEelzgS689BygDZKCSEUDoT6dG+OBGmU=;
	b=Y2amTz0tziV140SrHvT24YTRFZsci/hGRpokwl7qkJ3dGbwNKqkEmjfgKaoiQ9mG
	nt1IOua+FpOfW0XDBNB3cbXLCJPjjIye8RgZ+VfIxK6HaPDrSPRoRRQdVXVtEHXOoMM
	Phxf8//u3GA64BoPaBrnyaCr2P5e1oNUhuP6Kxy0=
Received: by mx.zohomail.com with SMTPS id 1752145040240481.87790057866744;
	Thu, 10 Jul 2025 03:57:20 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "Thomas Gleixner" <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Dave Hansen" <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Sohil Mehta" <sohil.mehta@intel.com>,
	"Brian Gerst" <brgerst@gmail.com>,
	"Patryk Wlazlyn" <patryk.wlazlyn@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] x86/smpboot: tidy sched-topology and drop useless SMT level
Date: Thu, 10 Jul 2025 18:57:06 +0800
Message-ID: <20250710105715.66594-1-me@linux.beauty>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

This series cleans up sched-domain topology handling and
eliminates hundreds of pointless attach/destroy cycles for large
machines when SMT is not available.

Patch 1, 2, and 3 do some cleanup and refactor.

Patch 4 is a follow-up that simply skip SMT domain when
cpu_smt_num_threads <= 1, so the SMT level never gets created.

Tested on Qemu.

changelog:
v2: fix wording issue as suggested by Thomas [1]
v3: remove pointless memset and adjust PKG index accordingly, as
    suggested by Thomas [2], and refine some other wording issues.
v4: v4: Split refactor patche into three parts (as suggested by Peter [3])
    and refined patch 4 logic (as done by K. [4]).
v5: fix some style issues and do some improvements as pointed out by K. [5][6]

[1]: https://lore.kernel.org/all/87msa2r018.ffs@tglx/
[2]: https://lore.kernel.org/all/875xglntx1.ffs@tglx/
[3]: https://lkml.org/lkml/2025/6/25/584
[4]: https://lore.kernel.org/lkml/1b706790-2fec-4582-a425-55eeff36c32e@amd.com/
[5]: https://lore.kernel.org/all/f391491d-f886-4579-9b40-78a57f2ed1b5@amd.com/
[6]: https://lore.kernel.org/all/7e7f686b-1f5a-46dc-8b16-c6d491160d1c@amd.com/

Li Chen (4):
  smpboot: introduce SDTL() helper to tidy sched topology setup
  x86/smpboot: remove redundant CONFIG_SCHED_SMT
  x86/smpboot: moves x86_topology to static initialize and truncate
  x86/smpboot: avoid SMT domain attach/destroy if SMT is not enabled

 arch/powerpc/kernel/smp.c      | 34 +++++++++--------------
 arch/s390/kernel/topology.c    | 10 +++----
 arch/x86/kernel/smpboot.c      | 51 ++++++++++++++++------------------
 include/linux/sched/topology.h |  4 +--
 kernel/sched/topology.c        | 24 ++++++----------
 5 files changed, 52 insertions(+), 71 deletions(-)

-- 
2.50.0


