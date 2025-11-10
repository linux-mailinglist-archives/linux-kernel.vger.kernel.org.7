Return-Path: <linux-kernel+bounces-892731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B723C45B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF4D3B71A9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA48301460;
	Mon, 10 Nov 2025 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EN5+Dk6s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201A25784E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767911; cv=none; b=FDuTdYvRm2MkfH/T0vH3VNi3Ih1qIUdklUgpoZdiUxLG+/NlyFIf8mz7r+6Dw3O60Msm9a6B63082c7CKlng3ltP4sA7J4zd8vbiO0eWd5etoAGoW5Far29xdTrBcnVHBshTGtNY39J91SPAWrZ4zjF5uV/6KKxszb8O4h+Bsg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767911; c=relaxed/simple;
	bh=goBB6a9ijYsjH1ApwGICOTD9RRiuY+gQpLOMLI1pKjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dKyEjtmKsVLx/Th+wjxe/SwL0O3qqyHHWJ0uVx3Hcc52cJyU6FambAxjZBeeZLa276cOUChwnoCdiI+rs4E9qoddLVg/aQE/Y0R/f1/x978+vOH7qcNVpU/cqrKOENCOp6r70zKtH3ug1KFUGFhQvsmjzRMcO0xHTvKLDO+1TL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EN5+Dk6s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762767908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UVXpka/wfvK1NTQpXcElrqr+Eu4p1Ghvs93NaoRYmkY=;
	b=EN5+Dk6s6JdV9do6X8Q8A6/KeSwTvyOotNrVahm1Wednj5/1byPwJ1PPic8kS1E5AjnpD8
	u2BApCKj6/4uMffAixsx+/yxxyIQFcFoorQlcYQOx6IrB5RdSjEt8U6IzP2kLlw5l3Xcn/
	EImDe38Q30M5oYdYvO0xMmhGFsp+abA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-tAv0p3UENYmR87MU9ynLsg-1; Mon,
 10 Nov 2025 04:45:06 -0500
X-MC-Unique: tAv0p3UENYmR87MU9ynLsg-1
X-Mimecast-MFC-AGG-ID: tAv0p3UENYmR87MU9ynLsg_1762767905
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12E97195606D;
	Mon, 10 Nov 2025 09:45:05 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.47])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25B581800576;
	Mon, 10 Nov 2025 09:45:00 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>,  Matthew Wilcox
 <willy@infradead.org>,  Hans Holmberg <hans.holmberg@wdc.com>,
  linux-xfs@vger.kernel.org,  Carlos Maiolino <cem@kernel.org>,  "Darrick J
 . Wong" <djwong@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
In-Reply-To: <20251110093701.GB22674@lst.de> (Christoph Hellwig's message of
	"Mon, 10 Nov 2025 10:37:01 +0100")
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
	<lhuikfngtlv.fsf@oldenburg.str.redhat.com>
	<20251106135212.GA10477@lst.de>
	<aQyz1j7nqXPKTYPT@casper.infradead.org>
	<lhu4ir7gm1r.fsf@oldenburg.str.redhat.com>
	<20251106170501.GA25601@lst.de> <878qgg4sh1.fsf@mid.deneb.enyo.de>
	<aRESlvWf9VquNzx3@dread.disaster.area> <20251110093701.GB22674@lst.de>
Date: Mon, 10 Nov 2025 10:44:58 +0100
Message-ID: <lhuframz0f9.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

* Christoph Hellwig:

> I think what Florian wants (although I might be misunderstanding him)
> is an interface that will increase the file size up to the passed in
> size, but never reduce it and lose data.

Exaclty.  Thank you for the succinct summary.

Florian


