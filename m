Return-Path: <linux-kernel+bounces-764464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E72B22353
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C3D3B11ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9152E92B8;
	Tue, 12 Aug 2025 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuiuK4aK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693CD1A9F84
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991276; cv=none; b=WgGm83zTDawyrZi3rJv+TRiTHchMnAOFovslczsty3p2On57pzP2/ugfioVkHxzVqWuBQwYNJqx7QygpnLh4bxmK0UY2u6XeSsvhSNxEnY1cOO22lsJD35qRK2dhoHaTQ1vePQjC/oJoMc1pH5ICSIPZuQKlvUo//FM9P3djJhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991276; c=relaxed/simple;
	bh=rNnsFwnGuu3gIqHdcbwoQsioWMOhv8l1bRy1GjfYvg0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=EGZZhQs8PDBPDkcfZ1f/C6AbyOVEBhyzy8+OjGbnct1IeQ6GUzpJrStYOjvrxkHn/8W6+BKFug2XCHrP34oZjjmPJOy2WjTJFmG84m84mIzolHdyNrLnuPTtAhTbMmM8Dg663fZi7Eya/Iwt4JPtGHqU9IXA7ZFIaF60tpUomuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuiuK4aK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754991273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kx0dhTCfyhMeyKByQPSUuP5rLf1cHUcwMzM5kaQhu9E=;
	b=OuiuK4aKCCrcv4OJA9CQNAb4QWzZIOkiEUxyEsaTuMfug1x9AcTxddM9mmM9Hj51EK2M5F
	rPoQRjrY582hiuF3aESSlipiIWYqSTQQr4jvDm+QfTygmN01fje+Ailig3VN9x+/Ae12nj
	VMLXg2dVpIn8F7lDmXRNTgGJLe9wpOc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-7TGlF5EEN_6FfCwsb3F6Bw-1; Tue,
 12 Aug 2025 05:34:32 -0400
X-MC-Unique: 7TGlF5EEN_6FfCwsb3F6Bw-1
X-Mimecast-MFC-AGG-ID: 7TGlF5EEN_6FfCwsb3F6Bw_1754991270
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6CAA19560AA;
	Tue, 12 Aug 2025 09:34:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 19283180028A;
	Tue, 12 Aug 2025 09:34:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aJpipiVk0zneTxXl@codewreck.org>
References: <aJpipiVk0zneTxXl@codewreck.org> <20250811-iot_iter_folio-v1-1-d9c223adf93c@codewreck.org> <20250811-iot_iter_folio-v1-0-d9c223adf93c@codewreck.org> <385673.1754923063@warthog.procyon.org.uk>
To: asmadeus@codewreck.org
Cc: dhowells@redhat.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
    Christian Brauner <brauner@kernel.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Andrew Morton <akpm@linux-foundation.org>,
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
Content-ID: <650268.1754991257.1@warthog.procyon.org.uk>
Date: Tue, 12 Aug 2025 10:34:17 +0100
Message-ID: <650269.1754991257@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

asmadeus@codewreck.org wrote:

> There should be a `if (slot == folioq_nr_slots(folioq)) break` check
> somewhere as well? Or is the iov_iter guaranteed to always 1/ have some
> data and 2/ either be big enough or have remaining data in a step?

We should handle both cases.  I think the other iteration functions
will. iov_iter_extractg_folioq_pages(), for example, wraps it in a
conditional:

		if (offset < fsize) {
			part = umin(part, umin(maxsize - extracted, fsize - offset));
			i->count -= part;
			i->iov_offset += part;
			extracted += part;

			p[nr++] = folio_page(folio, offset / PAGE_SIZE);
		}

David


