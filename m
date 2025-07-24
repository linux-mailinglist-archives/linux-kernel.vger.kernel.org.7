Return-Path: <linux-kernel+bounces-743799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C792B10374
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2026189137C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D9B2749FA;
	Thu, 24 Jul 2025 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTH1R4b0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE07A2749CE
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345414; cv=none; b=uUkn9bLZ3bwsI+op9DqRnM6jFuXOeWJynRs/ueIq/rLBJBiSSNnBjlS2phv7p/Bcnn/Rtk1E/QOxfaFn0eOZOOwT1lNZ5EqwUZZ8EfQ1Sh6tDLeBbXOttO5NcfNwbw6vunOekruO0miLN7PMIj87OxFszgNSX0vDeJs39SGe35c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345414; c=relaxed/simple;
	bh=kR35/Jv6iuJ8iS2M+TzhgCahUP4ydamz1XAkQX4VSqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlGUOwJloq8hLIe21iM2iQjfRaYRMs89S7MHZjUybqaW8dkRtMwClRGTTSDwmg0r+d1Vii5jYhrdOfL/DrNIHHQGG1ZUe+t1rcvEt5NNBpisj8KWRbMN8U4D8jbA9447MCMHwweDVyefHth3Z7/0KED52OLOQEgRghLKQ4KscQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTH1R4b0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753345411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inucMIKhxEvXP9jZT/ROlUmFAW5Fk+3g/o1C1Us0aGM=;
	b=UTH1R4b09vsfP4u8mbqnMomLmUe1KEz7kfETjzYM9vL0mAgcYucDhYomw1Wina5EG53mme
	xaK5l3asKlxC2ve86YVqonK22O7oA3pev/9Xe68+/IiN1bcU2h4VcC6EqSVPgjGSXq0606
	P6UE7mBaCDoKT2d/w4lHtoOiVga0T6U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-vgkFOhQzOq64B9DvmBPCwA-1; Thu, 24 Jul 2025 04:23:30 -0400
X-MC-Unique: vgkFOhQzOq64B9DvmBPCwA-1
X-Mimecast-MFC-AGG-ID: vgkFOhQzOq64B9DvmBPCwA_1753345409
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45867ac308dso3719385e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345409; x=1753950209;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inucMIKhxEvXP9jZT/ROlUmFAW5Fk+3g/o1C1Us0aGM=;
        b=rXU8RQFcZU52hgBToebtwQNnDEVpGIq2f4GsCfpwaamKDjyhwawjv9/WaVCMZEtOFO
         NeZJ+3WeOUb2qJ+OOlXZk9qpzUgVzHamPyWz5Qb2v+82SVSPTS0HF6SMf9U7DzobhGOe
         OZJGgJ8o3OdyTHMUd6LuRZvRyZ8H8mwN36YHW9LBnqGcp3bWNL3LVSyWzq17hvZ4b2a8
         fODgalHP4ZLXW/PeLPuhB5ZIdjSTtGz+0Wazu9ukx1+EDPZoPyYfPs9fFXn4buyb/Lfz
         d1duYKjFPrSWb7v6zXrlpkIpHjxGjKlqd7OCGNxoCtzftoc4a4Shvfkr/Ju70Ok+cAaj
         nd1g==
X-Forwarded-Encrypted: i=1; AJvYcCUDDnk4aJj9hySgCoQrX43MDLJSekYyF7vk4aCwDKtcg+avsQaGPBKdeG3nSgIWO8U1aRP6N2pGyhQuiVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94ggrpOEN7NOEWORfa5Bw4EB/HggnfkmtaPUVDKogaMRZPemZ
	MCZ94wrbO65fF0q5g2jbyfWzMRRiHFONtdwhS1jqGmnG+S5x7GcxLxMdwYo3P5YtrPMQ049zPxt
	z3RBf18ozcjbPbyJjoHYdXfvE+BloIh103iW21FT16jWOXj8mac2Tb0R0F24lR2+JDg==
X-Gm-Gg: ASbGncsEYUfpJTi70KQC6ZYpGz/bgIhlb7tHqDLInr6PJtKOXAsFUZrO4d7WygrgnlQ
	3hWk77ZEx5ad3PZ8tJXCwBfExgplSYQN2YkIlIQsxnSSWICUJbcavoj+RxIrCRQNN5W4k2wRnYC
	p84OS0HZlZRa7NkcKK/oDX0YF2zQ0maV/ruGQPk7j4D/eyGJlhLJlRJmMZJ5XmZ7vtczAiKshCD
	KpcnWkhxSyZb4iNIKaJzKh0uXWvL0JqycRhWST31G9fhr4thv4MBKLxjepWGbH/ARj4SBEEjFxQ
	a7LqisA+dgKmyXYMvE16Q38XiymP3Y71SB/ivpivgSfCRzpVBWTkH5cgj3NXD+w5dQlcOQ==
X-Received: by 2002:a05:600c:8b08:b0:456:1b93:76b with SMTP id 5b1f17b1804b1-45868c79052mr53695475e9.4.1753345408886;
        Thu, 24 Jul 2025 01:23:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdtLcyEdZUOsZv2sq0CbPs5hZqiaOagRDT3jXPlexGgIDzMlul8E40cqYAQwrjLryESM9Uzw==
X-Received: by 2002:a05:600c:8b08:b0:456:1b93:76b with SMTP id 5b1f17b1804b1-45868c79052mr53695235e9.4.1753345408515;
        Thu, 24 Jul 2025 01:23:28 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.46.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm10581635e9.14.2025.07.24.01.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:23:27 -0700 (PDT)
Date: Thu, 24 Jul 2025 10:23:25 +0200
From: "juri.lelli@redhat.com" <juri.lelli@redhat.com>
To: Pierce Wen =?utf-8?B?KOa6q+W9pee/lCk=?= <Pierce.Wen@mediatek.com>
Cc: Kuyo Chang =?utf-8?B?KOW8teW7uuaWhyk=?= <Kuyo.Chang@mediatek.com>,
	"bsegall@google.com" <bsegall@google.com>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"jstultz@google.com" <jstultz@google.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [RFC PATCH 1/1] sched/deadline: Fix RT task potential starvation
 when expiry time passed
Message-ID: <aIHtfRB6UuVVbp2z@jlelli-thinkpadt14gen4.remote.csb>
References: <20250615131129.954975-1-kuyo.chang@mediatek.com>
 <aFAyN4rfssKmbUE5@jlelli-thinkpadt14gen4.remote.csb>
 <089882f95b1b910f7feecddd0ad9b17f38394c64.camel@mediatek.com>
 <aFQM8TdZIIvvGv8T@jlelli-thinkpadt14gen4.remote.csb>
 <6ec534be0618de3e2b4d81555e5f24155326c0b9.camel@mediatek.com>
 <aFV8qeH__bw0chWM@jlelli-thinkpadt14gen4.remote.csb>
 <a1103727ffaaf5f4d1b077bc09a3cc5168c5708d.camel@mediatek.com>
 <cd10d32b514d2792659fe03ad1235771982a6e2f.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd10d32b514d2792659fe03ad1235771982a6e2f.camel@mediatek.com>

On 23/07/25 22:22, Pierce Wen (溫彥翔) wrote:

...

> Hi all,

Hello!

> I wanted to follow up on the discussion regarding the potential RT task
> starvation issue and check if there have been any further updates or
> feedback.
> 
> To recap and provide some additional context:
> 
> 1. As discussed in the thread (see
> https://lore.kernel.org/all/CANDhNCqYCpdhYS9afdKeY34Bmw8MXyqKWCSTxOZNLTjYrUaVXg@mail.gmail.com/
> ), it has been demonstrated that the use of a scaled timer can indeed
> induce RT starvation under certain conditions.

This first case has been handled by fc975cfb36393 ("sched/deadline: Fix
dl_server runtime calculation formula") on tip/master.

> 2. Furthermore, since the delta_exec time calculation relies on the
> clock_task member of struct rq, which is affected by IRQ time on the
> runqueue, there is a risk that if IRQ time becomes excessively long in
> some corner cases, it could also lead to RT starvation.
> 
> 3. Based on these observations, we strongly recommend adopting a
> recovery patch to address these critical scenarios and prevent RT task
> starvation, especially in cases where the current logic may not be
> sufficient.

As I was saying, I am not against the patch proposed to address the
starvation issue discussed in this thread. Maybe the patch can be
reposted with the addition of a comment on the code path related to
dl-server explaining why the special case is needed?

Thanks,
Juri


