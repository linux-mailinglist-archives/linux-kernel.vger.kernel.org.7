Return-Path: <linux-kernel+bounces-760546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11963B1ECB8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1F2AA2F60
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E8328540B;
	Fri,  8 Aug 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gD/3pnI8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC7B286416
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668804; cv=none; b=SD7KceFTnQWwG3tIPZoT5aCiqTFT9lESStL5gXBTVIH39rUyveQl23mIYLLP/91gtqlmgZ3yxBdG83uh/4NZpv56IH0ISTd6KdCPSGfbfV4qcdgf3rxRwEZ19ek9e7tBFUjoWMsVL5wf+Zvnl20nqw7aYN4u7Cwhkl3CbQNKNSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668804; c=relaxed/simple;
	bh=WKHcd03Cr9GxBWo6yqcOzEqx/3q8PlcHLVjcF+AwmDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoYVTG/qSCeEsMNjsqzp1eaccf1mM7B5zAeU3dc3fQ8IzOVcv9LXggMiN1bsrInN3CTdq/ktQwuHGiax7YFjy5j7ccM88+uEfFEysL0ksTbdxZ2eRTbaxkHQUgSwwL+VGpw7kqEb0kQtyNGWulHHAw0ZQYPbtXMwsjbcxHtFqUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gD/3pnI8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754668801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YGK9n6dq7VxCb/OM51wQ3RDMD15RnRtHlU5OclWuDJs=;
	b=gD/3pnI8BT2u2+ivalqIr7x9EkaWhr5nbGvNEV2mRgSgJqruhHAvFEvKtPApB8Q+wHN8WL
	fTScsNY3KLjiMLxzBF75JEdtw1b9lt1Qb9LAOFzHNslEalF2TzSKS3Wc6v/ROq4DZwtzJ4
	9PzkithKD/r1wEO0Hm3aJS1lNf8r8Rc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-wt4H8Zk0P262tjW9FjN_lw-1; Fri,
 08 Aug 2025 11:59:56 -0400
X-MC-Unique: wt4H8Zk0P262tjW9FjN_lw-1
X-Mimecast-MFC-AGG-ID: wt4H8Zk0P262tjW9FjN_lw_1754668794
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6256195608B;
	Fri,  8 Aug 2025 15:59:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.126])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54FE0300145A;
	Fri,  8 Aug 2025 15:59:51 +0000 (UTC)
Date: Fri, 8 Aug 2025 23:59:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com,
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 4/4] mm/kasan: make kasan=on|off take effect for all
 three modes
Message-ID: <aJYe8rAa3lIe4Nat@MiWiFi-R3L-srv>
References: <20250805062333.121553-1-bhe@redhat.com>
 <20250805062333.121553-5-bhe@redhat.com>
 <CACzwLxivXFYXuF1OkqcP9THar7UGQ3VVAQgQm=PU9Tohb8hnRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACzwLxivXFYXuF1OkqcP9THar7UGQ3VVAQgQm=PU9Tohb8hnRQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/06/25 at 11:24pm, Sabyrzhan Tasbolatov wrote:
> On Tue, Aug 5, 2025 at 11:34 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > Now everything is ready, set kasan=off can disable kasan for all
> > three modes.
> >
> 
> Hello,
> 
> I've been working on this already and a different approach
> with the Kconfig ARCH_DEFER_KASAN has been proposed.

Thanks for telling, I don't always watch MM mailing list, so missed your
earlier posting. 

I went through your v5 series, we are doing different work. I am adding
kasan=on|off to generic/sw_tags, and have added kasan_enabled() to needed
places. In fact, based on this patchset, we can remove
kasan_arch_is_ready() more easily since in all places kasan_enabled() has
been added there. Before seeing your patches, this is what I planned to
do to remove kasan_arch_is_ready(). I will see what can be done better.
Maybe I can carry your patch in v2. I will try tomorrow.

> 
> Please see v4 thread.
> https://lore.kernel.org/all/20250805142622.560992-1-snovitoll@gmail.com/
> 
> It also covers the printing in a single KASAN codebase, instead of
> printing "KASAN intiilaized" in arch/* code.
> Also covers the enabling KASAN via kasan_enable() for all 3 modes.
> 
> It's up to KASAN maintainers to choose either version.
> I just need the confirmation now if I should proceed with v5,
> or your version if it covers all arch and cases should be picked up.
> 
> Thanks
> 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/linux/kasan-enabled.h | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> >
> > diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> > index 32f2d19f599f..b5857e15ef14 100644
> > --- a/include/linux/kasan-enabled.h
> > +++ b/include/linux/kasan-enabled.h
> > @@ -8,30 +8,21 @@ extern bool kasan_arg_disabled;
> >
> >  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> >
> > -#ifdef CONFIG_KASAN_HW_TAGS
> > -
> >  static __always_inline bool kasan_enabled(void)
> >  {
> >         return static_branch_likely(&kasan_flag_enabled);
> >  }
> >
> > +#ifdef CONFIG_KASAN_HW_TAGS
> >  static inline bool kasan_hw_tags_enabled(void)
> >  {
> >         return kasan_enabled();
> >  }
> > -
> >  #else /* CONFIG_KASAN_HW_TAGS */
> > -
> > -static inline bool kasan_enabled(void)
> > -{
> > -       return IS_ENABLED(CONFIG_KASAN);
> > -}
> > -
> >  static inline bool kasan_hw_tags_enabled(void)
> >  {
> >         return false;
> >  }
> > -
> >  #endif /* CONFIG_KASAN_HW_TAGS */
> >
> >  #endif /* LINUX_KASAN_ENABLED_H */
> > --
> > 2.41.0
> >
> >
> 


