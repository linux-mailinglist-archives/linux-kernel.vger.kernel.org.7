Return-Path: <linux-kernel+bounces-844522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F319BC21FB
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3F834F3842
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE7D21A420;
	Tue,  7 Oct 2025 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fr1Ipfib"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71611D5CFE
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854966; cv=none; b=d1QrfAJM+4b0ufzZIIHj5/RdUf+b2UOldu2kdYtMWWOmd8tdgZ6Bi3hjZ8vFP4a4JENxjIH6b/azrkAU0W8kwVMIcQzpiNOMa7CHeovqxoUj/ewwPNIs9KFa8yl3TiMTxaiqdTUHnLdwdvPSotb5jNLyrMgChmwHZVdk22EEq3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854966; c=relaxed/simple;
	bh=smWtRVorPTEIpGrK1dPatitUtj9KnqiKfgNT9C7C+dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyQ5H6jotfue7gRVkVIxJMQDNotsDQpUlF4hXjuYD2RYez9fp81RiKKRPoVJr6F44Snh2B7EYTLCIa9L4jEOnsztTOc+FvOZu/LH2k9i0C2Hgtgq4yQfBIOEUPoi0AOJY/Nog30Gv5VTS3+aoABLL5GV5gTwu4IxwAC4RZLBMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fr1Ipfib; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759854960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=smWtRVorPTEIpGrK1dPatitUtj9KnqiKfgNT9C7C+dU=;
	b=Fr1IpfibmQNMImf39HL8uGVPQCQgnaeb48hCYRXKCuRbaC5A47g04rCOtH52Bc3EO+R0pY
	qG/HqbgMw09xPPJ+TCqmhd7nrex7coOP/ryaanL7b2iC6IBKqL+scYwJyWIHFcj/D8xzlb
	J7+IR4JqP3yC7vdveyVaOdlD/iT3LDM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-7CldBmlUP-egjZD8TChb5w-1; Tue,
 07 Oct 2025 12:35:57 -0400
X-MC-Unique: 7CldBmlUP-egjZD8TChb5w-1
X-Mimecast-MFC-AGG-ID: 7CldBmlUP-egjZD8TChb5w_1759854955
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C782918004D8;
	Tue,  7 Oct 2025 16:35:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.227.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6EB3319560B8;
	Tue,  7 Oct 2025 16:35:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  7 Oct 2025 18:34:33 +0200 (CEST)
Date: Tue, 7 Oct 2025 18:34:28 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251007163427.GB12329@redhat.com>
References: <20250928161953.GA3112@redhat.com>
 <20251007142043.GA17089@redhat.com>
 <CAHk-=wgSSr=Ljm0rJ_zV8v__uuQOHs2Z0bwQ5HRQN3H63MLQbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgSSr=Ljm0rJ_zV8v__uuQOHs2Z0bwQ5HRQN3H63MLQbg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/07, Linus Torvalds wrote:
>
> On Tue, 7 Oct 2025 at 07:22, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > I can change scoped_seqlock_read() to do the same, to make
> > it symmetric with _irqsave() if you think it makes sense.
>
> I don't think it's visible to users, but maybe it would make the
> macros look slightly cleaner.

OK, agreed, will do tomorrow,

> And it would allow making 'lockless' an actual 'bool'

Yeees... This will slightly increase the "size" of defines, but I
guess this doesn't really matter in this case.

Thanks,

Oleg.


