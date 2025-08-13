Return-Path: <linux-kernel+bounces-766787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68F1B24B2A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2B2188B027
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8342EB5C6;
	Wed, 13 Aug 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERq1OAf1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439AF2EAB94
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092972; cv=none; b=BxGqEJJC9mBJS0PXED1ZSuqyg952JJo8ZTufY4m7nRP4Ir3SMSQnoDk8+KWjEgHaMdQF9ETysyDmeDVxc9dPKaOrk8yqhKMIj4CutkUFGzrHyNc4hPbLy0Vcr0YRlBPP90MmTxxJHdUkFhRgHfa7bOxJGyPuL86rBMLpCBnXW+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092972; c=relaxed/simple;
	bh=ngX7KqakvaHrr7jdbnboB1CiS7jx0blLv4FZ9WlGS6Y=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Aq5ngpZD2UjxQyMz5EJVBkSwZRA19+W8xw5sPC7NG9fj6IPE2lV3c7WsEiFwcqBMlgRWL9b/fQJRENQVhsc5eLM1KAHRkJgYJKH6HxECL5zQNDqZt1gc8mr7E0bhdAcBwdeXnaQoetouzrluv7dXsEwyGV8tENKZ2Y4IWhoqGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERq1OAf1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755092970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ngX7KqakvaHrr7jdbnboB1CiS7jx0blLv4FZ9WlGS6Y=;
	b=ERq1OAf1rViq86S5zRtC6CO6C/1eaBSL20TguW2dLR61JbykJ+joQtOtkrc7oWhIjeoPjX
	I1r8Kj5D9SFW03kz2Y57I+TnBUA4hCLRYvlYfBJ9h7Sj4dwPi5Fz+rVMBJoMEdO+z/Wzng
	V1PobpzE9ybTXlb0CEvPw4083+NLJD4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-7Vo1U-J3ONyy5NFUj1oonA-1; Wed,
 13 Aug 2025 09:49:25 -0400
X-MC-Unique: 7Vo1U-J3ONyy5NFUj1oonA-1
X-Mimecast-MFC-AGG-ID: 7Vo1U-J3ONyy5NFUj1oonA_1755092957
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2ACA2195609F;
	Wed, 13 Aug 2025 13:49:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AE64300145D;
	Wed, 13 Aug 2025 13:49:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aJwj4dQ3b599qKHn@codewreck.org>
References: <aJwj4dQ3b599qKHn@codewreck.org> <20250811-iot_iter_folio-v1-1-d9c223adf93c@codewreck.org> <202508120250.Eooq2ydr-lkp@intel.com> <20250813051633.GA3895812@ax162>
To: Dominique Martinet <asmadeus@codewreck.org>,
    Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Nathan Chancellor <nathan@kernel.org>,
    kernel test robot <lkp@intel.com>,
    Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>,
    "Matthew Wilcox (Oracle)" <willy@infradead.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
    oe-kbuild-all@lists.linux.dev,
    Linux Memory Management List <linux-mm@kvack.org>,
    Maximilian Bosch <maximilian@mbosch.me>, Ryan Lahfa <ryan@lahfa.xyz>,
    Christian Theune <ct@flyingcircus.io>,
    Arnout Engelen <arnout@bzzt.net>, linux-kernel@vger.kernel.org,
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iov_iter: iterate_folioq: fix handling of offset >= folio size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <758962.1755092947.1@warthog.procyon.org.uk>
Date: Wed, 13 Aug 2025 14:49:07 +0100
Message-ID: <758963.1755092947@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Dominique Martinet <asmadeus@codewreck.org> wrote:

> I assume Andrew will pick it up eventually?

These might be more a Christian/VFS thing.

David


