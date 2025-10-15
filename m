Return-Path: <linux-kernel+bounces-854486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC26FBDE7FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50CF11890ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16BA1A9F92;
	Wed, 15 Oct 2025 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hj7d16m5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916CF17C220
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531848; cv=none; b=h8J85n8fqZOGimRFst+QIh2/YEQW/LzdkrVLpMqbWY9kTB/o+0gCt1C1psgjzDWjqluG8Mz8+11KIuolKNbP64IEyf9ap3T3ZH/s8dP0BVW8yVzjlPvQ88/thr7qbud6ED17ZSjgIglh1fVolijSeet3KPr5gDs1AnBA0BoVp5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531848; c=relaxed/simple;
	bh=sKZOdoTjbsq6Mx+qTxWPLv6s4dPTLcEPG4wK69KUEp0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K/4hxxce0XfFwHk+1Bp3feDoYv4sCVTBmPE9eSmW+Dt0a7oQX7RTCaS7y2BGhHY7pGBbOG70aqT9yDduvVNCylcvxHR82yWWq9CqHoBIF655R4jhs5t0jI1XlKfrFTHTmxutdyGIXFeJYq8ZpTxm1y2GHxmMHgCkknJT4CP6vuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hj7d16m5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760531845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=AtZ093B0rnrZE2zbJt7fGZcLL+Rx4cRxgrPEuazmma4=;
	b=hj7d16m5eLSy/0VjF2UpNW/zN5WPdqyXQwlTyT8n7kLbsba7O+Bc164SWoRo4o9j48hy5O
	4EIqoOKuK1CnkRUKc40141Y2KUXr1gZgZ1spET361EZj+ozw/qI3p/RXmEPwBCASXn+ldq
	KI66P98yA3PTa2WlRH6WvpJW6iHxHso=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-Cxi3NOLoObmLpC7emA-L0g-1; Wed,
 15 Oct 2025 08:37:24 -0400
X-MC-Unique: Cxi3NOLoObmLpC7emA-L0g-1
X-Mimecast-MFC-AGG-ID: Cxi3NOLoObmLpC7emA-L0g_1760531842
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A54C18345B2;
	Wed, 15 Oct 2025 12:37:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.241])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5436C180057C;
	Wed, 15 Oct 2025 12:37:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 Oct 2025 14:35:53 +0200 (CEST)
Date: Wed, 15 Oct 2025 14:35:50 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: gaoxiang17 <gaoxiang17@xiaomi.com>, Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Revert "pid: make __task_pid_nr_ns(ns => NULL) safe for
 zombie callers"
Message-ID: <20251015123550.GA9447@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Christian,

I was going to revert 006568ab4c5c ("pid: Add a judgment for ns null in pid_nr_ns")
but then I changed my mind and decided to revert my commit abdfd4948e45 (""pid: make
__task_pid_nr_ns(ns => NULL) safe for zombie callers"). See the changelog.

2/2 is offtopic and purely cosmetic.

Oleg.

 fs/pidfs.c          | 2 +-
 include/linux/pid.h | 5 +++++
 kernel/pid.c        | 3 +--
 3 files changed, 7 insertions(+), 3 deletions(-)


