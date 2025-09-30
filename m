Return-Path: <linux-kernel+bounces-838147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE26DBAE8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EAB01940961
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4B9267F58;
	Tue, 30 Sep 2025 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1W2Us7S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1122E004
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759264545; cv=none; b=IlWjsz6KTSgyK8BHE2qIq6GIoqVq+UXnySRAaIEZA8ZnD4ivEGL3UaMSX47bJeznOrTmPeRhexEmwRm9iUiB+EgDJ5Py9FU6p1wge16mY0diRyOxiTxRi9AY3l1UJbIF13svE8UK1YcQFTwGtjofT8ZZNcOM1ey85KZclaaN1F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759264545; c=relaxed/simple;
	bh=Mqe3iTmmi+nKlY1Eto3G7wjsYgkPXFi6g4uA6mdEhYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5wW/L5QtJngWDbsDXJbXiJebVHGIHA8BILciH8sCZrodYuOPubFYjcCRjWFBnSSgmq/DPWmbNdq0bBkTUMF6Dm9vxPaYYot/k2B8jwX2ziv/k4fkW9JOZXApELmNbLj71MfC4rx5Be5k9n/KtoaqF5DcxF/0+CR8bC5hUAyoM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1W2Us7S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759264542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tcdjHj3hrCi2n9CnZqBqMGWq7DhDnkuit40Rw1hplXg=;
	b=C1W2Us7Sl+/zGVZiX3qGywjWZovX0S1SFtGYd0q/l7QBL4ZysYoGMih/2M3Ntm+LO1qdYf
	cuzaWSvhQ9ZZJzBvGwJuRLGnSfHvap1mQQVvDPDwUsmdp++j6X8ngCh5rwVxztJVbEGUNW
	iwVQJSfvvq+ZAWOLfEfRe08lKNv1i0M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-t530qXcAMDOBwOZu9vyNDQ-1; Tue, 30 Sep 2025 16:35:41 -0400
X-MC-Unique: t530qXcAMDOBwOZu9vyNDQ-1
X-Mimecast-MFC-AGG-ID: t530qXcAMDOBwOZu9vyNDQ_1759264540
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d91b91b6f8so100561931cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759264540; x=1759869340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcdjHj3hrCi2n9CnZqBqMGWq7DhDnkuit40Rw1hplXg=;
        b=U1DH8hoIFC+f+KbcqlUnfzw4QRQcevA5aztQOR56VeNG+Qgw3g/EL8+V41DturEKzj
         blhDpPc/J9/tgK19I3wX+md7tyJ394vsefNq1aHjR1j4pj+cQl0L7oJrzTo/TzP2NAT3
         SOmQ0LBlBIIYk036yZIGapmquHC6AfXhwYYFNjeti4nNBs5QJwEi9RDR4+ZDOOzIJ5Gw
         u0kBW5oSjsnduC+EhuAu4EHLAA67+cztaaQMlC+GXjhJU1EDuzf3+rU1kV1unVz5Ww2M
         ZZNL26Qgdop8mvCDf30wFQjqGXonQVY9gHqFW6uxldRY5QTpRP9pwCyJvEk9qqSy/dt7
         bOqg==
X-Forwarded-Encrypted: i=1; AJvYcCXTHnET979+QchtKOhC6JCntp87iyOqTRI8+6WZHXIHo3+nJKa3KlzXlB7n1Wo5bp1easFSWRYfHPYNu2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2earWtDxKBLGCD/dx6zSI2t4GhlbOIDiWe/FvcGdROeoZ0LcA
	RO2eegPwWkE2sYpvjVDLKTe+MQSwypI97GheEOc8DlqDs8hSK6LKgo8B3kP+f8oXnRETm8goKfQ
	+rC1b0GFhzD5qo7366QrN+mhcp1/ZLAfNecHPitHeqOyEv8ggEWoVsCHyvCS/t1xPdw==
X-Gm-Gg: ASbGncvhsI7UHzKhTsGXy3uRlrVMZmAhO2iZqwZa9et7j4oP5UURZdGXKuoxS47gLqA
	LJ9AeRPBfPp/O5Gwu7MNRPRSZjryc2YY4PkJPDsOBAjhOvZgexyQgjhGGskKXd7uzNDuWI0xEo3
	USDtEtcqDDklr/8QyqubsdJUaOLVwCruqFWiJNc3xdvcOBCyQrcdyw8q0P9w5AjmGEsWQzGZWNv
	IxZecaZOHcXtxPSv9n8j9a1g53jJ5W1tPSZGgTZ9dbkp+rwOisJs/wgiRl59vQxYpiWyDzoPmij
	xOU+DtMrIh2gwi5GgZMR1QN3qIAMovL1jmuZ7Q==
X-Received: by 2002:ac8:525a:0:b0:4cf:c058:96f8 with SMTP id d75a77b69052e-4e41ea16a4dmr9675191cf.75.1759264540405;
        Tue, 30 Sep 2025 13:35:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRFvQ7iweHJJXKuRSbPcafJqC24Mx1TFX1nNEJ4hnhKFuws1x28jLXszl2ahz6F4cqkhz+GQ==
X-Received: by 2002:ac8:525a:0:b0:4cf:c058:96f8 with SMTP id d75a77b69052e-4e41ea16a4dmr9674851cf.75.1759264539936;
        Tue, 30 Sep 2025 13:35:39 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80cd172fd3esm95716896d6.27.2025.09.30.13.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 13:35:39 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:35:38 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Axel Rasmussen <axelrasmussen@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aNw_GrZsql_M04T0@x1.local>
References: <20250926211650.525109-1-peterx@redhat.com>
 <20250926211650.525109-2-peterx@redhat.com>
 <f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com>
 <aNwmE11LirPtEuGW@x1.local>
 <f409cbe7-7865-45ab-af9a-6d5108bc5ad4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f409cbe7-7865-45ab-af9a-6d5108bc5ad4@redhat.com>

On Tue, Sep 30, 2025 at 09:19:05PM +0200, David Hildenbrand wrote:
> On 30.09.25 20:48, Peter Xu wrote:
> > On Tue, Sep 30, 2025 at 11:36:53AM +0200, David Hildenbrand wrote:
> > > > +/* VMA userfaultfd operations */
> > > > +struct vm_uffd_ops {
> > > > +	/**
> > > > +	 * @uffd_features: features supported in bitmask.
> > > > +	 *
> > > > +	 * When the ops is defined, the driver must set non-zero features
> > > > +	 * to be a subset (or all) of: VM_UFFD_MISSING|WP|MINOR.
> > > > +	 *
> > > > +	 * NOTE: VM_UFFD_MISSING is still only supported under mm/ so far.
> > > > +	 */
> > > > +	unsigned long uffd_features;
> > > 
> > > This variable name is a bit confusing , because it's all about vma flags,
> > > not uffd features. Just reading the variable, I would rather connect it to
> > > things like UFFD_FEATURE_WP_UNPOPULATED.
> > > 
> > > As currently used for VM flags, maybe you should call this
> > > 
> > > 	unsigned long uffd_vm_flags;
> > > 
> > > or sth like that.
> > 
> > Indeed it's slightly confusing.  However uffd_vm_flags is confusing in
> > another way, where it seems to imply some flags similar to vm_flags that is
> > prone to change.
> > 
> > How about uffd_vm_flags_supported / uffd_modes_supported?
> 
> The former would make things clearer when we are at least not talking about
> uffd features.

I'll go with it.

> 
> > 
> > > 
> > > I briefly wondered whether we could use actual UFFD_FEATURE_* here, but they
> > > are rather unsuited for this case here (e.g., different feature flags for
> > > hugetlb support/shmem support etc).
> > > 
> > > But reading "uffd_ioctls" below, can't we derive the suitable vma flags from
> > > the supported ioctls?
> > > 
> > > _UFFDIO_COPY | _UFDIO_ZEROPAGE -> VM_UFFD_MISSING
> > > _UFFDIO_WRITEPROTECT -> VM_UFFD_WP
> > > _UFFDIO_CONTINUE -> VM_UFFD_MINOR
> > 
> > Yes we can deduce that, but it'll be unclear then when one stares at a
> > bunch of ioctls and cannot easily digest the modes the memory type
> > supports.  Here, the modes should be the most straightforward way to
> > describe the capability of a memory type.
> 
> I rather dislike the current split approach between vm-flags and ioctls.
> 
> I briefly thought about abstracting it for internal purposes further and
> just have some internal backend ("memory type") flags.
> 
> UFFD_BACKEND_FEAT_MISSING -> _UFFDIO_COPY and VM_UFFD_MISSING
> UFFD_BACKEND_FEAT_ZEROPAGE -> _UFDIO_ZEROPAGE
> UFFD_BACKEND_FEAT_WP -> _UFFDIO_WRITEPROTECT and VM_UFFD_WP
> UFFD_BACKEND_FEAT_MINOR -> _UFFDIO_CONTINUE and VM_UFFD_MINOR
> UFFD_BACKEND_FEAT_POISON -> _UFFDIO_POISON

This layer of mapping can be helpful to some, but maybe confusing to
others.. who is familiar with existing userfaultfd definitions.

> > 
> > If hugetlbfs supported ZEROPAGE, then we can deduce the ioctls the other
> > way round, and we can drop the uffd_ioctls.  However we need the ioctls now
> > for hugetlbfs to make everything generic.
> 
> POISON is not a VM_ flag, so that wouldn't work completely, right?

Logically speaking, POISON should be meaningful if MISSING|MINOR is
supported.  However, in reality, POISON should always be supported across
all types..

> 
> As a side note, hugetlbfs support for ZEROPAGE should be fairly easy:
> similar to shmem support, simply allocate a zeroed hugetlb folio.

IMHO it'll be good if we do not introduce ZEROPAGE only because we want to
remove some flags.. We could be introducing dead codes that nobody uses.

I think it'll be good if we put that as a separate discussion, and define
the vm_uffd_ops based on the current situation.

> 
> > 
> > Do you mind I still keep it as-is?
> 
> I would prefer if we find a way to not have this dependency between both
> feature/ioctl thingies. It just looks rather odd.
> 
> But let's hear if there are other opinions.

Sure.

-- 
Peter Xu


