Return-Path: <linux-kernel+bounces-768549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08EDB26284
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24053A2429F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BBE30E0DF;
	Thu, 14 Aug 2025 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rfzg3Oh3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EF02FB960
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166510; cv=none; b=MlyEg14H3HW7UggMuFa+i5G3WMy8NUrVC2hboOZ+sP337SCMeEWn2ea5bPQK0lpCvkNNCkBSSy8BnI6ht3oj0Lyh7+TnTOeyt+FSMqxls2YOrX6sVHohIHylzfRxbEmB4TXRJ3SqTWZScKgSL0v7Kpx8mkE+DMYkpOywSAUuZnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166510; c=relaxed/simple;
	bh=sj9dCvM+vz5lHW/usU3/K87b4NqgzHLCeOp/vQfBdrM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uurG3DVSuZF5dP1mRTizAzdnWB6WKMvPFp/6FBXICLQqEx3I3HnPOYSwhAL9fUnMk+Ck9/p4kwqsJLGpoHgmDpkTzeKPCX7TLNr8AYpiSrbPjbBQBe9lfQhH+YLpi+iVchcfaxmrIPT7c1Erbo2JmspoG4KXyOc2ZU6+pl60+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rfzg3Oh3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755166507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=yQbYWQJezXTBGRRkQFTfe4ECf5XM81W4OtacTbXcOTw=;
	b=Rfzg3Oh3VwYFwuXxWg1/WFpcutCfpKs+vpn56L7OzMmpPGEp+mJ1iY1MWgBuq+U83uw92r
	p9lf3hGcC9f9r9TSUzVItQKj582IOMKiJn0pFhLMAb1ZQBTwnpB0s17bDYFNZY8C8UCYZO
	zmdRlsYmgq9I4vvMCboU8eIjxMtYxOQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-IIAZLK2nOMeWn0xRd04HLQ-1; Thu,
 14 Aug 2025 06:15:05 -0400
X-MC-Unique: IIAZLK2nOMeWn0xRd04HLQ-1
X-Mimecast-MFC-AGG-ID: IIAZLK2nOMeWn0xRd04HLQ_1755166504
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5818A180029E;
	Thu, 14 Aug 2025 10:15:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.62])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C4F353000198;
	Thu, 14 Aug 2025 10:14:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 14 Aug 2025 12:13:47 +0200 (CEST)
Date: Thu, 14 Aug 2025 12:13:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 0/6] x86/fpu: don't abuse x86_task_fpu(PF_USER_WORKER) in
 .regset_get() paths
Message-ID: <20250814101340.GA17288@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Sorry, I have no idea how to test these changes, please review. Especially
4/6 and 5/6, I don't really understand shstk.c.

If you are fine with these changes, I'll try to update the fpregs_soft_get()
and user_regset.set() paths as well.

Oleg.
---

 arch/x86/include/asm/shstk.h |  8 ++++----
 arch/x86/kernel/fpu/regset.c | 46 ++++++++++++++++++++++++++------------------
 arch/x86/kernel/fpu/xstate.c | 12 ++++++------
 arch/x86/kernel/fpu/xstate.h |  4 ++--
 arch/x86/kernel/process.c    |  2 +-
 arch/x86/kernel/process_64.c |  2 +-
 arch/x86/kernel/shstk.c      | 19 +++++++++++++-----
 7 files changed, 55 insertions(+), 38 deletions(-)


