Return-Path: <linux-kernel+bounces-835492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A7EBA748D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 18:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9572174647
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9582356C6;
	Sun, 28 Sep 2025 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iL+ZZ3GP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E787F1FB3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759076490; cv=none; b=o5w0NFiu4DFWuJ3pphtg7DbT7OIVCeN0gn7VR5i2hD4xzU4VdoVeffXVIM0hHnXqXczuU5ASGRCQEc81vRsDFynSgKztzbUA1kiWqDcKxYewK2E2VhL9M7u6pybO95/o6bn3sHFvBWlOUcItzBz/ldkhb/5/Hon3cU9AI032dVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759076490; c=relaxed/simple;
	bh=uV5cw3K0ZRdmaa+mJJ0Pmd2STO2wkJsUygE5yZLnV6I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rRUa+8GXwESiPI3zo4hkO5HUNPXGNW3AvrnUnh4mvldKyGjtmOjsO6xI1jD1CRaN0w7f4tNK6pWwfuWOSOptGWYI1Pjs+9pnPnDV+oMiHLJk7AJqAADLrTe+sDMpCudEVxcPy/fAxIbJ99nZsO0wdoBSd6MHpeZf9uT0ZtAXjaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iL+ZZ3GP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759076487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=uV5cw3K0ZRdmaa+mJJ0Pmd2STO2wkJsUygE5yZLnV6I=;
	b=iL+ZZ3GPER9u7J2s0odb9w/k7lwd0SNOjmD2MBMnFLofjl2KMqHRWHrRNVdVYrz249jrOx
	Ymge/eiLTXhSrDoUiY7Hess6aJ6pMvpzTSY6AeobUUkhemGIF7laRnEQgqmrsD3W90gmIJ
	8MpTllhLhJHiwhyT9ev1fMrDeW4umhA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-4LyxC2CIMXWjZZJkRXRHNg-1; Sun,
 28 Sep 2025 12:21:24 -0400
X-MC-Unique: 4LyxC2CIMXWjZZJkRXRHNg-1
X-Mimecast-MFC-AGG-ID: 4LyxC2CIMXWjZZJkRXRHNg_1759076483
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 523C919560AD;
	Sun, 28 Sep 2025 16:21:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 33AF019560A2;
	Sun, 28 Sep 2025 16:21:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 28 Sep 2025 18:19:59 +0200 (CEST)
Date: Sun, 28 Sep 2025 18:19:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] documentation: seqlock: fix the wrong documentation of
 read_seqbegin_or_lock/need_seqretry
Message-ID: <20250928161953.GA3112@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello,

I already tried to discuss this about 2 years ago, but nobody replied.
Let me make another attempt.

1/1 is the trivial doc fix, but what do you think about "RFC 2/1" ?
Does it make any sense?

Oleg.


