Return-Path: <linux-kernel+bounces-758674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F233FB1D274
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D18D3A843D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA9D21C9EA;
	Thu,  7 Aug 2025 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObgdbFZu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF8C1537A7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 06:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547863; cv=none; b=kNT6324I7E75k1vUPookvjb9x3F0r9JHFQCgSllHdEZT74NOKi7Mfwn9qkSObQKSAcAWQPbmczXBUnsTh3hd7QKowvDZCvdwV8/wITzFOSZ903ev/G+Rwo/2oSPSllYE/OoMXOBDKBUkMeNvejd6fOokkplHlwSUHM83YaCudBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547863; c=relaxed/simple;
	bh=3LQckM2EdoqnAXIB/DASixGzOmzCkzLo06SkipiWqLI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ENqGleTzE1i5r1qKUGrevfHnvd0nCQha8jqm6WOah+jhN90V6EJ+iXXBnENwPd4v8mMLAssnFnjaxjT3cxHHhtZBUPoiTugHljh3I3kQuBje2IXPr5WZv7wN9UEdhBM5h54LA4XoPRBl6Avtc67XZuqNVxkQmml1SpbKiwNQrNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObgdbFZu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754547857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k1WVOByHGPJSkXieU34Pjmu4LFu0grvMwhqpYIbMzb8=;
	b=ObgdbFZuKQSgOhYboT4yms39pXzpQmmCcJoaDMsJVuJdKETUL41/+9QPkeX9o4F+YQlNli
	EOKeSsTQQWhVL4Q1nKG435PpawqvwSuYPWRbdEp/cKsq0PknDmvS90bSNt5wUS9ExYQc8B
	C1oQnyhOEhBOQKnLYCMvbWp0xSjvvZ8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-sGGSZm2HNd6jGHFfZmszKg-1; Thu,
 07 Aug 2025 02:24:14 -0400
X-MC-Unique: sGGSZm2HNd6jGHFfZmszKg-1
X-Mimecast-MFC-AGG-ID: sGGSZm2HNd6jGHFfZmszKg_1754547853
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B05C1800366;
	Thu,  7 Aug 2025 06:24:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B00C19560AD;
	Thu,  7 Aug 2025 06:24:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <c213ace1-7845-4454-a746-8a5926ab41d0@samba.org>
References: <c213ace1-7845-4454-a746-8a5926ab41d0@samba.org> <20250806203705.2560493-1-dhowells@redhat.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.org>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Wang Zhaolong <wangzhaolong@huaweicloud.com>,
    Mina Almasry <almasrymina@google.com>, linux-cifs@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/31] netfs: [WIP] Allow the use of MSG_SPLICE_PAGES and use netmem allocator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2572843.1754547848.1@warthog.procyon.org.uk>
Date: Thu, 07 Aug 2025 07:24:08 +0100
Message-ID: <2572846.1754547848@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Stefan Metzmacher <metze@samba.org> wrote:

> So the current situation is that we memcpy (at least) in sendmsg()
> and with your patches we do a memcpy higher in the stack, but then
> use MSG_SPLICE_PAGES in order to do it twice. Is that correct?

Not twice, no.  MSG_SPLICE_PAGES allows sendmsg() to splice the supplied pages
into the sk_buffs directly, thereby avoiding a copy in the TCP layer and
cutting out the feeder loop in cifs.

However, this is meant to be an intermediate step.  I actually want to
assemble the fragment list in a bvecq in the smb_create_request() as called by
the PDU encoders, with everything aligned for crypto so that the crypto layer
doesn't copy it also.  But cleaning up the transport first should hopefully
reduce the size of the later patches.

David


