Return-Path: <linux-kernel+bounces-658493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BF2AC0323
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 05:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38321B66DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 03:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF27139CF2;
	Thu, 22 May 2025 03:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHeNByC1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02F383
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 03:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747885786; cv=none; b=CYUE2dTuJxNfwACzDv28zFcgwxknIkeKvfJ7fFd4EXTLQ6QQDRDPt7v7p1k5CWQ/C1flfpkfgQ6O1yXqrYQAn5xIA2an0J6FdTgm79ZF6AYUGEpoG3seYKw/cG9VO4eEjN2v9w4+gUreiBaIL4YFO+iYVNUT5FQaa5WnnLE1TyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747885786; c=relaxed/simple;
	bh=pP0gCOXOC50Z/0xxYAr7ydbCoPDt1OcdK6DtbcZyLKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuakrhxv5xae3QPfMU3otkL5LORDbw9vzH3XRZus+dyq1kaYeSDdp+y9nve3xoXAa1eXToJDO1qPqrCdADrwMnKkyVuHrC0dJt4B4B9JKapM5XpPgrVPL3R7xIrru2PuK1I6izgPQnEfm+qyzhlFENuqUqoQvnDPhdJMHDvdCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHeNByC1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747885783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pP0gCOXOC50Z/0xxYAr7ydbCoPDt1OcdK6DtbcZyLKM=;
	b=DHeNByC1wOsPJXox/AJ3h//Efx6gLszfj62/lUk6fTy1+q9YFgOkZDkg1M9hhyO19Xxquk
	vEApigB48Cqt5Swkrfuds0ICA69EKoOTKrq5zI7YTa/toxEkXf5mJpyU0peg2OeavY7qP3
	aLt3RxL6L3Cvsc9ncf6Zcnx5SllgruA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-5Ihd1d0fOMS9kWgG_6x3aQ-1; Wed,
 21 May 2025 23:49:40 -0400
X-MC-Unique: 5Ihd1d0fOMS9kWgG_6x3aQ-1
X-Mimecast-MFC-AGG-ID: 5Ihd1d0fOMS9kWgG_6x3aQ_1747885779
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24CCB195608D;
	Thu, 22 May 2025 03:49:39 +0000 (UTC)
Received: from localhost (unknown [10.72.112.172])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C317A19560AE;
	Thu, 22 May 2025 03:49:37 +0000 (UTC)
Date: Thu, 22 May 2025 11:49:32 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de,
	coxu@redhat.com, ruyang@redhat.com, chenste@linux.microsoft.com
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
Message-ID: <aC6ezNcUZ/ulKgpv@MiWiFi-R3L-srv>
References: <20250515233953.14685-1-bhe@redhat.com>
 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
 <02e5091f96404a86073abacb2861a07cf1deb439.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e5091f96404a86073abacb2861a07cf1deb439.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 05/21/25 at 08:58am, Mimi Zohar wrote:
> In addition, please update the Subject line to be less generic.

Sure, will change subject as below:

ima: add a knob ima= to allow disabling IMA in kdump kernel


