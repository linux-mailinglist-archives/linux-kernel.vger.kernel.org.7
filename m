Return-Path: <linux-kernel+bounces-739392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6081B0C5C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB91165644
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E2D2BE04A;
	Mon, 21 Jul 2025 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxrXF4fr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA65283FC3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106623; cv=none; b=let5sk0qVuIWtJYqolIDUldOYgbLVItJNCEzHwRcmxvc4Z16yAZ4U0/mS0KPiRMBHg5z1CB/dYDfHmZpfa/MZlyGEG6x0Q39h0Y9I5CxKVm248EAeAH/+z8MXUinyjGGJp2cEn6IY87keNEyY4qKV1r1HC59n2jvW8JXwtGg9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106623; c=relaxed/simple;
	bh=HBRK43gP2055T0s0GSexwoAa/3kH3YdJNWxa61o9aBs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Tn6iC5Uj0xJ1qntzfMnXtGOZT2J8dfanNVBxrFzEOi7HIeEU9JO2C+wujduNA6t0HFwzgImYXP8xaY7JJ9+e34o0H7huPgoIcF69mDBU/9DkJeJUia27+Kj/XJYWO/Caku1bcG2HUV52IYZY3Ps5lg7mmcimmeDymsWQx/p9kuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxrXF4fr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753106619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBRK43gP2055T0s0GSexwoAa/3kH3YdJNWxa61o9aBs=;
	b=NxrXF4fric6wIPXzVK5YeUbfM1LK69UFUecQu+8lW03iu44KKigmDtDs6YDZDNGtUpHCG0
	U5an7+ZrBmWM4cx+E6YweMx45LWV6uoi/h8s3YM3E3P88/HFfrHrTS2AbeZWYOee32occ4
	4116f2p3QQjA4dGgOlK9Cx2zNrL7Mr4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-xkl3hcltPtKIOZ1NxAP0Hg-1; Mon,
 21 Jul 2025 10:03:33 -0400
X-MC-Unique: xkl3hcltPtKIOZ1NxAP0Hg-1
X-Mimecast-MFC-AGG-ID: xkl3hcltPtKIOZ1NxAP0Hg_1753106612
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 763A61800C39;
	Mon, 21 Jul 2025 14:03:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD4921800D82;
	Mon, 21 Jul 2025 14:03:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <67e9006d.050a0220.1547ec.0097.GAE@google.com>
References: <67e9006d.050a0220.1547ec.0097.GAE@google.com>
To: syzbot <syzbot+ab13429207fe1c8c92e8@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
    marc.dionne@auristor.com, mathieu.desnoyers@efficios.com,
    mhiramat@kernel.org, rostedt@goodmis.org,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [afs?] WARNING: ODEBUG bug in delete_node (3)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4118022.1753106607.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Jul 2025 15:03:27 +0100
Message-ID: <4118023.1753106607@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master


