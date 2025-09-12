Return-Path: <linux-kernel+bounces-813245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9440DB5428E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A02567B7DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4130327F749;
	Fri, 12 Sep 2025 06:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGQBHN8f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102B52AD20
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757657479; cv=none; b=bSgvMKzvoAz2h65Lv/GA2eu6cb1yQvfMbweIG82BbgPKEP9BfOBLhaaJPyzZEjHZgHaGvkhShFXh+BPAeIsrwWnPCHOwXPVne8vwnUjMMc2SPpW3R7xkqM81BVg/l6JcLrhlcmIYDCRSQiuGaMPfLDVa7Q+OHeXYz46oe9fRYt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757657479; c=relaxed/simple;
	bh=ZTegVEYrdvvc90RIKJbiisV+vAC21Quxs2vQKOq7M2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7d4W1Lu153lOXrl1LMXyVDcKX0VetM27pUKS9oqjqM74upKSFDPmk4pcuMhdvhAZoq8+RqrclM96Y309tbKgaXNlnyel+lCMPLxtafRBqbFvZ9+HvN5nnkWLReMNOsWB3WfGO0JVVQUjiWXGDLK/JkXkF9tZbI/go/Qj1bJfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SGQBHN8f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757657476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HNBcD/8+n0Gc4r0tfbcJk3JbRg5+y0i3aIdBUAR5FgQ=;
	b=SGQBHN8foq9i71fCkwdHY6fK787Su7Z7QfKHYflHoVp4zF/y/glV7p0I6dG5Fira1YSqiZ
	j/hkFqylxAQwSWeoBXIjb2+1ozcrvMLA5rrb3+tIG9kmPHk4qEaYuUNbSuRwtMweRNMtzH
	cZnnVt5XwisHB27yYlZANSJula5whWk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-YeS2e8aMMqykZRPRk9ZpeQ-1; Fri,
 12 Sep 2025 02:11:13 -0400
X-MC-Unique: YeS2e8aMMqykZRPRk9ZpeQ-1
X-Mimecast-MFC-AGG-ID: YeS2e8aMMqykZRPRk9ZpeQ_1757657471
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71AC61955EA8;
	Fri, 12 Sep 2025 06:11:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.224])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D27B319560B1;
	Fri, 12 Sep 2025 06:11:08 +0000 (UTC)
Date: Fri, 12 Sep 2025 14:11:04 +0800
From: Baoquan He <bhe@redhat.com>
To: "Bouron, Justinien" <jbouron@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Petr Mladek <pmladek@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Kudrjavets, Gunnar" <gunnarku@amazon.com>
Subject: Re: [PATCH] kexec_core: Remove superfluous page offset handling in
 segment loading
Message-ID: <aMO5eKSpvwYAtDtX@MiWiFi-R3L-srv>
References: <20250910163116.49148-1-jbouron@amazon.com>
 <aMKZUY/zg31qN+68@MiWiFi-R3L-srv>
 <1659446A-F17C-4FF2-BE1B-3EC37520DDCB@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659446A-F17C-4FF2-BE1B-3EC37520DDCB@amazon.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/11/25 at 03:30pm, Bouron, Justinien wrote:
> On 9/11/25, 02:42, "Baoquan He" <bhe@redhat.com <mailto:bhe@redhat.com>> wrote:
> > Do you mean we will adjust the memsz and buf_align to PAGE_SIZE aligned
> > in kexec_add_buffer()?
> That and mostly the fact that `sanity_check_segment_list()` explicitely rejects
> any segment that either does not start or end on a page boundary:

Ah, yes. I missed this one.

> 
> int sanity_check_segment_list(struct kimage *image)
> {
>     // ...
>     for (i = 0; i < nr_segments; i++) {
>         unsigned long mstart, mend;
> 
>         mstart = image->segment[i].mem;
>         mend   = mstart + image->segment[i].memsz;
>         if (mstart > mend)
>             return -EADDRNOTAVAIL;
>         if ((mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK))
>             return -EADDRNOTAVAIL;
>         if (mend >= KEXEC_DESTINATION_MEMORY_LIMIT)
>             return -EADDRNOTAVAIL;
>     }
>     // ...
> }
> 
> > That better be explained in log.
> Does it warrant a second revision to change the log?

I would appreciate it if we can tell the reason a little bit in patch
log. Because we have codes as below where people assign a non PAGE_SIZE
to kbuf.buf_align. With a general conclusion, people need explore code
to find out. At least that's what I do when I check this patch.

arch/x86/kernel/kexec-bzimage64.c:
static void *bzImage64_load(struct kimage *image, char *kernel,
                            unsigned long kernel_len, char *initrd,
                            unsigned long initrd_len, char *cmdline,
                            unsigned long cmdline_len)
{

	......
	        kbuf.buffer = params;
        kbuf.memsz = kbuf.bufsz;
        kbuf.buf_align = 16;
        kbuf.buf_min = MIN_BOOTPARAM_ADDR;
        ret = kexec_add_buffer(&kbuf);
        if (ret)
                goto out_free_params;
	......
}

Thanks
Baoquan


