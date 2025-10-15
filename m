Return-Path: <linux-kernel+bounces-854679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9542ABDF18B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26DB0357DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52C627FD44;
	Wed, 15 Oct 2025 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CX9WGeVe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E3E14BFA2
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538942; cv=none; b=ZTm7rccxGrntN5B2z7UiaaQd0CntErw5XNwF7P87cAgRNHwjwhlRr5kLs3F+X3JxfdnccKsbUOJPK78vnrDyyd5ZXOASi+opjDKCRjTe6fMZltS1cwuE9Mun91R/4K5oLPlJUa/BcJZi0Oem+NvBz5Wc3r1BpQh2nhkCdCpYo0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538942; c=relaxed/simple;
	bh=JUIWJxe+SHZiKJXBnWbbxSub3DnIM9+58bzZdb7Um3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDgcfOC/RZPYyFx5YpVkJYkitC945NRYivwhZJnXZCL0Fwi23+elH2EckcsiWcsRnhQzktvhMgxe10iJtcp8h/HDawzt91qOqevvAardM1CH9RwwDeYHVO2BOwag0rn4Jc0fY2tmmuqqdi+6ghPhqOutuS4MHm5x1FyKOZe4+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CX9WGeVe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760538938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JUIWJxe+SHZiKJXBnWbbxSub3DnIM9+58bzZdb7Um3A=;
	b=CX9WGeVebkoWAfLAt62ZSXcFr9XfRlatE4pH3GkabXY8iIuKWCr6UPtHk3Ksotu/8sHnyz
	EAyEm3NCZaNMu+vf3hU0GcpmiNtDmbfdXhYIeJ9r5JvCeHWPSJHWMlGFLFzxNgJBg3LyJn
	Ct+9q2NuM3VTzsfzgHbNwInOOeHkurM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-ib9f8Em-O2ifUOZP7GlMCQ-1; Wed, 15 Oct 2025 10:35:37 -0400
X-MC-Unique: ib9f8Em-O2ifUOZP7GlMCQ-1
X-Mimecast-MFC-AGG-ID: ib9f8Em-O2ifUOZP7GlMCQ_1760538935
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso439712f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760538935; x=1761143735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUIWJxe+SHZiKJXBnWbbxSub3DnIM9+58bzZdb7Um3A=;
        b=SoJjDEpxr1cuc6wKX6tEYUMXSxMM0WTiIgzpRXfduGnaFC+GsuLps/eW3vwAJkKofu
         zVl+kNGg0QPap8RVYpxCAjItx5UvHzEu7gPQFvrEWrSuZte8qmBF8xl9kJ90zoSOthmw
         i65sRAdH+JNZDR7RrEPTMrVNqsO5W/Kq+eukpayP1e3kTTcvnTutHge7BfH5ipdBw2Or
         hwWRR9YSZ7y6ZcA99nDskwowuQn8xznSkrMDGJxreQ0w0lE+M1NBzBodyDuYoXqsbLAD
         cSroQSi6cIMtSh4bQAEjrVRt/12rnY+8Nr039qsIKiW0CuAFaktEnUxavaEupXKCGlT+
         CwBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+QPFz8FjJGAVUeUz0QxjCcMBF7oTHQXelWdNzXfw9bsWaJPG3SIoVCZ0oly9wF7R42Pj3mUlkyBSgUBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5aQ6rCLVcnNeiA5lt+Wp0JSgs4iz9ZkZhKvRt1dZqS7lCBIBY
	TvTaM4fFwwG15QxEM5q6yyONX3oe+XcmnLZ9xQcyFXGKSz7X3srOOffgYvL5yURJ4BV7jydnraQ
	TYUKZohgtfomppz0zAX4ZulB0itPu9NGFg3AxIBHSBHHAFIcD3KXST10voF/Y0IQitw==
X-Gm-Gg: ASbGnctP0bbahJu9rkwJV0jSAYb6vPIZ7y2dZfjKPaB/oB8G5OaaJXQ0y4V2bCXOhZw
	gIL4jEDrIV3I+mDqI5zcfs4osfJjrRtwOmlER+Hj+2yUvaC55/HOSej0VcGtGOIKaD996Scsuyc
	VtzvRoEOrRkPbPr01OtAp1LvwD/bvYrdAOCOahk+vfliaIawcSKo13n6bHI3fYW0uwkRo7mGWTb
	ynK9R1bNYGHm+thEismm09R5Rsh6NcCv3PIZlHOEwktClX7n92k2QDA8FaQOg7sLqdigWao+IXM
	QqrrlL37T7m7TMNDSefXtFlH6/VcBtUB0qi47EAC8gqSEviSrSa7w/L/3k7XoxH3itfWZadk
X-Received: by 2002:a05:6000:2406:b0:426:dbed:28c1 with SMTP id ffacd0b85a97d-426fb7a36a0mr256962f8f.14.1760538934906;
        Wed, 15 Oct 2025 07:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDQMg0/W/kg9r+5LRcz/Y++psBoi5B4hc6VRPhU+FAdOa/n9E0Ona5IAyk+byNBnkSpIsyfg==
X-Received: by 2002:a05:6000:2406:b0:426:dbed:28c1 with SMTP id ffacd0b85a97d-426fb7a36a0mr256945f8f.14.1760538934478;
        Wed, 15 Oct 2025 07:35:34 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57cc03sm30547115f8f.4.2025.10.15.07.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:35:33 -0700 (PDT)
Date: Wed, 15 Oct 2025 16:35:32 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v3 00/24] Hierarchical Constant Bandwidth Server
Message-ID: <aO-xNBHYIyu74aQF@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <aN4_KE-5kOCbpQux@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN4_KE-5kOCbpQux@jlelli-thinkpadt14gen4.remote.csb>

On 02/10/25 10:00, Juri Lelli wrote:

...

> I will be trying to find time to continue testing and reviewing this RFC
> of course.

I provided comments up to the last part of the series that implements
migration. I will now stop on purpose and wait for replies/new versions
of the patches I reviewed. I believe we could try to leave migration
"for later" while we solidify the basics. What do you think?

Thanks,
Juri


