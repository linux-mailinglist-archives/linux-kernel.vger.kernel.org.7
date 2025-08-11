Return-Path: <linux-kernel+bounces-762920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A835B20C47
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CEAB188A402
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99D62D3ECA;
	Mon, 11 Aug 2025 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCFqCiSZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61446253B64
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923148; cv=none; b=IZQJ5OmWGWVaYlX4lAegdcNwgciUUEdDc7CSIe8U/sXSmMblEIoyP4MstcXcgV5wfaq9NPH7x3K9h/bAMFFupNv29RdPpJn2pE1dHReMNhjVs/EA/0/uIo7rDZ5fytPt1Y6ehXeTpSKkqa3N1TD3hG92jjtzaX3HLB6b/schJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923148; c=relaxed/simple;
	bh=G2uVQpOf7PqwQRVRsPvTZPrzWtNui0toN/ABy8YeG4k=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=euGIbUU8hqd0Aq0P7CsdiTy/Vny7FcxGmX6iXJNUF3wXtcsyDvdkJjHUj7vTOdPegZ5zo/11g0NA9pmJ7kHTJEfrg/esPyOjydqcwpx/AFV5e95B2rZBL3X5bDehDxb0LUbWzdBsPoiOXLUfKhHzbhlki/vruorjp3qTMXqMd24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bCFqCiSZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754923145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3LVZ5P/C39XA0ox+6E/6LTbIRgWArxstBCbjGuW0XMo=;
	b=bCFqCiSZyJopBCMtwHcOO9c7DVvKpBr1Iqmniq/ezgwmgW81zIjBrGUZNL4A/BKw/mgXXB
	hp6eZqq2rxLAQkUXw6DRm3UAF5RPiXa5BbtBcUj36X9rsQRGgFTlCMJQQMgJqI4v5bjCn3
	UdmFs8OveH2UEkXawBKNk8c1ovJ6xsg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-a3dCoIfjMky3DxWnzypurA-1; Mon,
 11 Aug 2025 10:39:01 -0400
X-MC-Unique: a3dCoIfjMky3DxWnzypurA-1
X-Mimecast-MFC-AGG-ID: a3dCoIfjMky3DxWnzypurA_1754923140
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 968E5180035F;
	Mon, 11 Aug 2025 14:38:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B98B319560AB;
	Mon, 11 Aug 2025 14:38:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250811-iot_iter_folio-v1-2-d9c223adf93c@codewreck.org>
References: <20250811-iot_iter_folio-v1-2-d9c223adf93c@codewreck.org> <20250811-iot_iter_folio-v1-0-d9c223adf93c@codewreck.org>
To: asmadeus@codewreck.org
Cc: dhowells@redhat.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
    Christian Brauner <brauner@kernel.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Andrew Morton <akpm@linux-foundation.org>,
    Maximilian Bosch <maximilian@mbosch.me>, Ryan Lahfa <ryan@lahfa.xyz>,
    Christian Theune <ct@flyingcircus.io>,
    Arnout Engelen <arnout@bzzt.net>, linux-kernel@vger.kernel.org,
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] iov_iter: iov_folioq_get_pages: don't leave empty slot behind
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <385704.1754923134.1@warthog.procyon.org.uk>
Date: Mon, 11 Aug 2025 15:38:54 +0100
Message-ID: <385705.1754923134@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Dominique Martinet via B4 Relay wrote:

> From: Dominique Martinet <asmadeus@codewreck.org>
> 
> After advancing into a folioq it makes more sense to point to the next
> slot than at the end of the current slot.
> This should not be needed for correctness, but this also happens to
> "fix" the 9p bug with iterate_folioq() not copying properly.
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

Acked-by: David Howells <dhowells@redhat.com>


