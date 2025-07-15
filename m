Return-Path: <linux-kernel+bounces-732224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD81B063A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06D0580EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAA624BBEE;
	Tue, 15 Jul 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eyrex+6t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA02AD2D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595182; cv=none; b=V1EZBZ3Ho+Qs9CAFfNxpB7dDjwbxI6QJxXxyvBDSY+rNwbyXKVTzy+esljZbxxPF+ZdEH6d/sgLgUo4BBIFNu2yOcrFTgE4daI9C6yZO5y0DlgpNqr66L4KZg3RbVpPrdJ5CpRATQvYXIL8YL7mmftiL3Y+vwmVuRsSAGHIxs8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595182; c=relaxed/simple;
	bh=fdO5VfW6X60MkvIII8cRamu7Sgs5twFB5WytZ9oeUao=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=fpvJCdf+ZNbMer67I7mCcRe271crzpYfKSDmaLYgTrnwu8OoPdfLtr5mtmVAZTSxEX05x2mshb1Dd5UISt2oEVwWMp7j860VPXJQqyibZ7RXJ61Ay2NhBlsE/otiZ3p5SLluZYOLfVgZcTm7sIytRYv2kYggXuV4CpTX8YbyDPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eyrex+6t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752595180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VQ6VLvXQFvvpoa4OU5x7ISX5suRFkKwL8aobTGgqAAc=;
	b=Eyrex+6t4GBAKRQ0PnJCGO7eZBb1nb16FtBcnKc16JZbDu6WDU7ritebxIrcTUHBBGrGz0
	zXit3io2gK8IvMRcHzcx1z+GUBL84MGo/0yeSN56n8k0rYC1q2KIYodi3KHbkrJM7W8AbP
	iEvC8cB7t0+r4yhzCSXSVijT6VcJDAc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-5W-uSxY4OsSiYOOSwvsaUA-1; Tue,
 15 Jul 2025 11:59:37 -0400
X-MC-Unique: 5W-uSxY4OsSiYOOSwvsaUA-1
X-Mimecast-MFC-AGG-ID: 5W-uSxY4OsSiYOOSwvsaUA_1752595175
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 879581956096;
	Tue, 15 Jul 2025 15:59:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8576B30001A1;
	Tue, 15 Jul 2025 15:59:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3457636.1752593748@warthog.procyon.org.uk>
References: <3457636.1752593748@warthog.procyon.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Add support for RENAME_NOREPLACE and RENAME_EXCHANGE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3458631.1752595171.1@warthog.procyon.org.uk>
Date: Tue, 15 Jul 2025 16:59:31 +0100
Message-ID: <3458632.1752595171@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

David Howells <dhowells@redhat.com> wrote:

> +	kenter("%u", YFSRENAME_REPLACE);

Meh.  I forgot to remove a debugging line.

David


