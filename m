Return-Path: <linux-kernel+bounces-869699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34840C08878
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 04:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 296F14E518F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A73C237707;
	Sat, 25 Oct 2025 02:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XW21JhTb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C8222F75E
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761357805; cv=none; b=b5jJP2QbJzRoYKMKIIo9wZdMMrteSP+z9nAXv0t793X9khfrMXxU7B9xIoeC07MlWGRQTc1TQnO5xWQ3tEuwOc+78xeYlZ+dqHYhBrmrG+MFpERUrHzxMu9S3KIvhE9hk53XOVpj957tAvqE8ziMx8nh/4B4OFp4cpGebq5bmQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761357805; c=relaxed/simple;
	bh=34yPOx4euq0MixyxTf4qUPouAJpMt7Wf+ar6CUXmh7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAc/AKMz2OZIUkUNfyOu1Ra9Kh3nP8x2pc8XUqwd72n2f0raMDD7hs/tA7kvj/fLPjeb7SUNb0bwxPj2k6rHc4+IXsb34atihoxeOCn0LZ+SKSFIzSTi12WhRoP0i2/KorPnQvdlwYOMbHk30PfLvvVRQIzjuGDd3ihLoUgtGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XW21JhTb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761357802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8QVyFmHun0tiZe+mZoklBcouNkx/P49NYMHYlwZrNpo=;
	b=XW21JhTbmrX6D2kHQb0r4gmn5o4fbxG2/Wpg61X8/b1LtKWIkNs+LRPiPllZxfgQ6Ccmfk
	oJJUYTunGhFLpIaZU6+mu6coBtnmhzAomMFaAiFiSGOO5sjq6tXmH6XjVx/rOEL2fXQCBK
	1P21/4Jszm1ndecBgCVDaYZZJSaNwaA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-gL-LecEbN-yoll0AMy3tUw-1; Fri,
 24 Oct 2025 22:03:16 -0400
X-MC-Unique: gL-LecEbN-yoll0AMy3tUw-1
X-Mimecast-MFC-AGG-ID: gL-LecEbN-yoll0AMy3tUw_1761357794
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88EE6195608A;
	Sat, 25 Oct 2025 02:03:13 +0000 (UTC)
Received: from localhost (unknown [10.72.112.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDA7D180045B;
	Sat, 25 Oct 2025 02:03:10 +0000 (UTC)
Date: Sat, 25 Oct 2025 10:03:05 +0800
From: Baoquan He <bhe@redhat.com>
To: Justinien Bouron <jbouron@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Petr Mladek <pmladek@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, Alexander Graf <graf@amazon.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: Re: [PATCH v3] kexec_core: Remove superfluous page offset handling
 in segment loading
Message-ID: <aPwv2QVddRseX8iK@MiWiFi-R3L-srv>
References: <20251024155009.39502-1-jbouron@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024155009.39502-1-jbouron@amazon.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10/24/25 at 08:50am, Justinien Bouron wrote:
> During kexec_segment loading, when copying the content of the segment
> (i.e. kexec_segment::kbuf or kexec_segment::buf) to its associated
> pages, kimage_load_{cma,normal,crash}_segment handle the case where the
> physical address of the segment is not page aligned, e.g. in
> kimage_load_normal_segment:
> ```
> 	page = kimage_alloc_page(image, GFP_HIGHUSER, maddr);
> 	// ...
> 	ptr = kmap_local_page(page);
> 	// ...
> 	ptr += maddr & ~PAGE_MASK;
> 	mchunk = min_t(size_t, mbytes,
> 		PAGE_SIZE - (maddr & ~PAGE_MASK));
> 	// ^^^^ Non page-aligned segments handled here ^^^
> 	// ...
> 	if (image->file_mode)
> 		memcpy(ptr, kbuf, uchunk);
> 	else
> 		result = copy_from_user(ptr, buf, uchunk);
> ```
> (similar logic is present in kimage_load_{cma,crash}_segment).
> 
> This is actually not needed because, prior to their loading, all
> kexec_segments first go through a vetting step in
> `sanity_check_segment_list`, which rejects any segment that is not
> page-aligned:
> ```
> 	for (i = 0; i < nr_segments; i++) {
> 		unsigned long mstart, mend;
> 		mstart = image->segment[i].mem;
> 		mend   = mstart + image->segment[i].memsz;
> 		// ...
> 		if ((mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK))
> 			return -EADDRNOTAVAIL;
> 		// ...
> 	}
> ```
> In case `sanity_check_segment_list` finds a non-page aligned the whole
> kexec load is aborted and no segment is loaded.
> 
> This means that `kimage_load_{cma,normal,crash}_segment` never actually
> have to handle non page-aligned segments and `(maddr & ~PAGE_MASK) == 0`
> is always true no matter if the segment is coming from a file (i.e.
> `kexec_file_load` syscall), from a user-space buffer (i.e. `kexec_load`
> syscall) or created by the kernel through `kexec_add_buffer`. In the
> latter case, `kexec_add_buffer` actually enforces the page alignment:
> ```
> 	/* Ensure minimum alignment needed for segments. */
> 	kbuf->memsz = ALIGN(kbuf->memsz, PAGE_SIZE);
> 	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
> ```
> 
> Signed-off-by: Justinien Bouron <jbouron@amazon.com>
> Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> ---
> Changes since v1:
> 	- Reworked commit message as requested by Baoquan He
> 	  <bhe@redhat.com>
> 	- Removed accidental whitespace change
> 	- v1 Link: https://lore.kernel.org/lkml/20250910163116.49148-1-jbouron@amazon.com/
> 
> Changes since v2:
> 	- Removed unused variable in kimage_load_cma_segment() which was
> 	  causing a warning and failing build with `make W=1`. Thanks
> 	  Andy Shevchenko for finding this issue
> 	- v2 Link: https://lore.kernel.org/lkml/20250929160220.47616-1-jbouron@amazon.com/
> ---
>  kernel/kexec_core.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)

LGTM, thanks.

Acked-by: Baoquan He <bhe@redhat.com>


