Return-Path: <linux-kernel+bounces-798734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9526BB4223A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D63F16C06A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EFF30BF71;
	Wed,  3 Sep 2025 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C196qyKE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6F23090D5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906992; cv=none; b=UDUuu2vsNBwOCacXNBlZZgwvFm0kAcOrUKVUd0d5AqLpAcQQsfoBKNkuwZww8MtxAPXxJ+vsztgp73EvG804fmSv/Q7m2yIMOooVw3W+89S3xLT5q6gjXyLLpjr1tX3qBn8855DuwPxlWcTjbQo7xEHe2fz0h4TMqbyzrZaBcO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906992; c=relaxed/simple;
	bh=rCcHklNzMjT3ObYYoA1HYxHvZ22SuN2f4sFmHo2Q/g8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bq4Da/xGir10Ly+giIP2jVBnXbRkH8a79+eKw9uVy5MwyzqXTmGZxajFbkYO8GK6i91BZiAxuoApydcPAoFyITN73QuYElyK9fDXwebzEoRPjlSYgDFVbUGCqKem8YhIpHoJ915ryeyLTIs8AaG+qr+G2YsA3uk45NW+LkZ+Wt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C196qyKE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756906989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=lZow2sr3qeI2s2aQP3f5xOQJySmyimDKdnIivHlqvAo=;
	b=C196qyKEMO3mnbB9hux8sXNbfXqZRy7mifHzk3X7vB5vufUDBOSV5rw2PXBNSCiA/ENpxV
	HAqqEvXo2xZHwxyC79jPR81dUrbbGYtf5WhrVJbgg8phoKTxkTWopAuDPS0Pgb2PV8jq0K
	EZ6x+dSeUqM1seqSHJz7ydEZR1IKt2E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-Ylu3DidlNkCBGBDWjTD_NQ-1; Wed,
 03 Sep 2025 09:43:00 -0400
X-MC-Unique: Ylu3DidlNkCBGBDWjTD_NQ-1
X-Mimecast-MFC-AGG-ID: Ylu3DidlNkCBGBDWjTD_NQ_1756906977
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64EB719560A1;
	Wed,  3 Sep 2025 13:42:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2D53E180044F;
	Wed,  3 Sep 2025 13:42:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Sep 2025 15:41:34 +0200 (CEST)
Date: Wed, 3 Sep 2025 15:41:26 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Deepak Gupta <debug@rivosinc.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 0/1] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Message-ID: <20250903134126.GA27641@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Dave, et al, please review.

Our discussion with Rick was confusing and we can't convince each other.
Perhaps this is my fault. So let me resend 4/5 from this series

	[PATCH v2 0/5] x86/fpu: don't abuse x86_task_fpu(PF_USER_WORKER) in .regset_get() paths
	https://lore.kernel.org/all/20250822153603.GA27103@redhat.com/

as a separate patch. I tried to update the changelog.

Again, to me it looks like a simple cleanup which makes sense regardless,
but please correct me if I am wrong.

Oleg.


