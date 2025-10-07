Return-Path: <linux-kernel+bounces-844366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CAEBC1B38
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB451891BB1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818321F4E34;
	Tue,  7 Oct 2025 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVMmaRCz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0865AC8E6
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846936; cv=none; b=POLawvFiNCIrD3hycRGMo8JSIkSuciN63qybqT5ckZ5Es5Hqj5bV90+M+Q65zN5OnYxad/wC15+CV+W5HctFcJtiYA2L8ikVV0aDh8MiAsthjY9tcoxBlhTkG31Kr7hz2gKbzxgl2QUcIZa5Tt2OnTgVjsNfsP7ZdUcHrxxmIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846936; c=relaxed/simple;
	bh=tDRx/i5f3frEzLsBUBctcO2Rl5xnDJm/sZ3jE18DvuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iA5HgOt7b1UjRiRY3oyeLiqJ91FazMX7znZmVvIjJ36FOZmeCpU79fhnZo5dDQpP9XYTAODSZjh+0qjMipHH+Ff36AgY46QbA6le8/e/S9NQGWfDJWnZPWPPkv7ssfFaXu9sRWDqSIUiAUKIgT0bPu9ftw2qqyf6NFw3wgfoNME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVMmaRCz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759846933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6/2zNLKlS35FPRtd7VkjfZlJg/226t9cgN3TgQqTJxQ=;
	b=eVMmaRCz60U7PJWtZply2lTSYlXgwPSqcMJfcdHmfS11xJgTykorJiK8bP+3qzmDcqCbbr
	kGqVVK6xA/HWWM8htUgEh4/+w9R6p6KYm0hvPzcPFi3AIVzxNXom3jo3/M3liiuV46LOmF
	SuwK0JuzAiXOsn+y91yoiHZ4jfohpEM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-StMUT7RbOFysCCzH6LLv3g-1; Tue,
 07 Oct 2025 10:22:12 -0400
X-MC-Unique: StMUT7RbOFysCCzH6LLv3g-1
X-Mimecast-MFC-AGG-ID: StMUT7RbOFysCCzH6LLv3g_1759846930
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C7041800343;
	Tue,  7 Oct 2025 14:22:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.227.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 633D5180047F;
	Tue,  7 Oct 2025 14:22:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  7 Oct 2025 16:20:49 +0200 (CEST)
Date: Tue, 7 Oct 2025 16:20:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251007142043.GA17089@redhat.com>
References: <20250928161953.GA3112@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928161953.GA3112@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

OK, please see V2. scoped_seqlock_read_irqsave() uses the
"for (struct {} s ..." hack to make "ulong flags" local.

I can change scoped_seqlock_read() to do the same, to make
it symmetric with _irqsave() if you think it makes sense.

I've dropped 5/5 which changed __dentry_path() for now.

Oleg.

 fs/proc/array.c         |  9 ++------
 fs/proc/base.c          | 10 ++------
 include/linux/seqlock.h | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/cputime.c  | 15 +++---------
 4 files changed, 68 insertions(+), 27 deletions(-)


