Return-Path: <linux-kernel+bounces-778095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DD5B2E148
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8E7188BA36
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA17126E70D;
	Wed, 20 Aug 2025 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9S/Gp4+"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88DB224AEF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703893; cv=none; b=QUWZ+BDaAbnGjyctmP5RxKFtH/GNEVo+gc5+0mjBFGV1U3SKcML2MhwN5o4MTVk2whoT59vWFPwEBwhOVArRHaE0GyImT/dKkDZXY/VRpU2DG1AW5pYh3ywY6sFDnZteUCW/MLmj7t1Zn6hdckcnGM/FUwrabDR2bYa9k7ogy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703893; c=relaxed/simple;
	bh=s+R8aVv1kQPKJL48rz1eQ6eILA63+WLcaOOcmA0QxjM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U2E+RSwbajdv1jbqNZdDizunmaC+NSy/wlj80dPKveI5tS0mzy8HXAWOViRP5JlidRA6vpAazOaunSKJ01aUQMqpw3W9xSJPltFu4B/BweGen7LumCq+NhskLkqEOG7HkDvK7ykauQZioCNzo+n+iSszn+1UQfj0PROrKR7KmIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9S/Gp4+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326e46a20so71064a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755703891; x=1756308691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o9QzEQYSWbERMpwFDE3tIp6dRHsbQYsz0nj171HoUNo=;
        b=v9S/Gp4+jy8zr9N1Jbet5dXmud8y/zebX5xGzUoeaJs3sMSpTHrSa/OtPPee2+EeYS
         e9Iz8Nzz9kduFck4W6jYt5NBJnuYHjhNpAXD57827Vcmuj+86g9tPc+lfcaLIcQs5z+1
         O1CG7WHC+ofI8BR92Tin9NZ/EdGJw2HOnix58ifHR1dtHJM4rsFV6CMIaRoKOWCEdAAH
         DJ8551IoPhu0GzO/ZQ+vzGze42Xni084aB6+LDVJ+1YkHGZ1Em0rEGNs4StkOhSCCFPm
         OAxybSExIAOMdsWjCDatYmQwuisoQ1SIzdOas9XdcNQsz2iBqBKPVbfnTsRGBYp0R7+D
         cIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703891; x=1756308691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9QzEQYSWbERMpwFDE3tIp6dRHsbQYsz0nj171HoUNo=;
        b=Z7OOXk8aAXmAEkAmUktQGbg72YTEtDCKcV13g3CAk6h+CQuvf5D6FfaFqUVKCx/snZ
         g5ZY3oQxQrD3EIosk+fUpMYxO3TuFjDfRF7xOu3tXoBi6KbUQ+FdbObQAaEt5+0SWZX3
         ZHTIKH8xi4OgZwaDgwgoc5PISzW03gXqpw5WLwl84BWAm1GnaLf1/IggWZgOXGOz7RXp
         KQ4oC4LQVzli5ozesB7Xc7BpbnHYuh7fKD1BXxTupBPClPqo8Pfubx4GYPqIESAs2HYE
         5pblva34jAZw9/QFF5gTVaufhhdCUVnJObrv1+Nf5fAH2zt3Tcd/WpxqrNcoKVKQVOMs
         oY3A==
X-Forwarded-Encrypted: i=1; AJvYcCXS3baczf32MmCDSJWInlVIhVSRWtTD5W7tfXKQpgRa4DQSCsGM3tWHsb446s80NXJgvch/XO2GWe9vw3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGXMSH5WlGlWDQYG45auwWEuCXLcOPBoSu1ytQpCzFaeqlu2u
	cItsT+WccgqAgQrR6Ic3kYIqJ4dhQLjVxqr7KZneWAtRjUufU7zDtULyL7YbIL/0pPrxJ+PIm6e
	0fDE5Bg==
X-Google-Smtp-Source: AGHT+IGnry6UQD9dbJDbiib0HiTkV2PQuZkHfqGug22iyfAeQKMVe3qfW45SYnYvoCN5T+mHnTS+yLo7nLU=
X-Received: from pjbqn7.prod.google.com ([2002:a17:90b:3d47:b0:31f:d6:9cf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec88:b0:312:1d2d:18df
 with SMTP id 98e67ed59e1d1-324e143bff2mr4826196a91.23.1755703891209; Wed, 20
 Aug 2025 08:31:31 -0700 (PDT)
Date: Wed, 20 Aug 2025 08:31:29 -0700
In-Reply-To: <dd58cf15476bac97b28997526faf9ff078d08b21.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250609191340.2051741-1-kirill.shutemov@linux.intel.com>
 <d432b8b7cfc413001c743805787990fe0860e780.camel@intel.com>
 <sjhioktjzegjmyuaisde7ui7lsrhnolx6yjmikhhwlxxfba5bh@ss6igliiimas>
 <c2a62badf190717a251d269a6905872b01e8e340.camel@intel.com>
 <aJqgosNUjrCfH_WN@google.com> <f38f55de6f4d454d0288eb7f04c8c621fb7b9508.camel@intel.com>
 <d21a66fe-d2ce-46cc-b89e-b60b03eae3da@intel.com> <6bd46f35c7e9c027c8a4c713df7dc73e1d923f5b.camel@intel.com>
 <rxtpzxy2junchgekpjxirkiuu7h4x4xwwrblzn4u5atf6yits3@artdh2hzqa34> <dd58cf15476bac97b28997526faf9ff078d08b21.camel@intel.com>
Message-ID: <aKXqUf9QBpLOeB3Q@google.com>
Subject: Re: [PATCHv2 00/12] TDX: Enable Dynamic PAMT
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "kas@kernel.org" <kas@kernel.org>, Chao Gao <chao.gao@intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	Kai Huang <kai.huang@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	Yan Y Zhao <yan.y.zhao@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 15, 2025, Rick P Edgecombe wrote:
> On Thu, 2025-08-14 at 11:55 +0100, Kiryl Shutsemau wrote:
> > > > > (similar pattern on the unmapping)
> > > > > 
> > > > > So it will only be valid contention if two threads try to fault in the >
> > > > > > *same* 2MB
> > > > > DPAMT region *and* lose that race around 1-3, but invalid contention if
> > > > > > > threads try
> > > > > to execute 2-4 at the same time for any different 2MB regions.
> > > > > 
> > > > > Let me go verify.
> 
> It lost the race only once over a couple runs. So it seems mostly invalid
> contention.
> 
> > > 
> > > Note that in absence of the global lock here, concurrent PAMT.ADD would
> > > also trigger some cache bouncing during pamt_walk() on taking shared
> > > lock on 1G PAMT entry and exclusive lock on 2M entries in the same
> > > cache (4 PAMT_2M entries per cache line). This is hidden by the global
> > > lock.
> > > 
> > > You would not recover full contention time by removing the global lock.
> 
> Hmm, yea. Another consideration is that performance sensitive users will
> probably be using huge pages, in which case 4k PAMT will be mostly skipped.
> 
> But man, the number and complexity of the locks is getting a bit high across the
> whole stack. I don't have any easy ideas.

FWIW, I'm not concerned about bouncing cachelines, I'm concerned about the cost
of the SEAMCALLs.  The latency due to bouncing a cache line due to "false"
contention is probably in the noise compared to waiting thousands of cycles for
other SEAMCALLs to complete.

That's also my concern with tying PAMT management to S-EPT population.  E.g. if
a use case triggers a decent amount S-EPT churn, then dynamic PAMT support will
exacerbate the S-EPT overhead.

But IIUC, that's a limitation of the TDX-Module design, i.e. there's no way to
hand it a pool of PAMT pages to manage.  And I suppose if a use case is churning
S-EPT, then it's probably going to be sad no matter what.  So, as long as the KVM
side of things isn't completely awful, I can live with on-demand PAMT management.

As for the global lock, I don't really care what we go with for initial support,
just so long as there's clear line of sight to an elegant solution _if_ we need
shard the lock.

