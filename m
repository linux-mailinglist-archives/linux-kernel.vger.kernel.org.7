Return-Path: <linux-kernel+bounces-760278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FE2B1E8D9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6773A2C30
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BD2279DA0;
	Fri,  8 Aug 2025 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZCy6M+e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398D2517AF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658116; cv=none; b=S+hDeXGnweKndqGu/Llx22FjVmjNIsCLFWlpkiK3C85nQnQNc7nWshXebTTjEibD6W7aY8ydz7d49tJig7JfNPOvpYvz8UhdXeI5R5QIydZQxTlvThz1lBEEzEn9g8gnFZMpfo6V/10+rFrH8lKy/kiAJ17Wyj3OEVsPUVOgfLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658116; c=relaxed/simple;
	bh=hU7x9Sfv/LiI5+bY5V2azxZU0hrkczjIwxcWwT9y3o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElglaZ90yc8ZrTN3xHdUp1D0HdBwiTDdzEzvDNzx+/OPyoF+/FH8R4UCLB3X8MZHVMgIITXgjq3tPnVZONvNhpDjlE+HWFs+mINgVimhaoI+XwlUlbAa7C6+HYKLB54ZCTIva0fNSqOJ9ByudlkBgslHrG0bl9fFnvhLtjKM/Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZCy6M+e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754658114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GIqJ6f/aDwqAFbRn5MC1kbdMPJMwUfUOc/srLwo7ZjI=;
	b=HZCy6M+eW005LYLh1iGglHm3qbThc3O4BFtdNnX8Conu4cSfRtjhdnx96yAVL5/87cH3d+
	ZjcRqRcrAj9/Hty3Yz6EcAgm5KgK4lq2S7s++laAnhOimaPB19HEksZHURWVoabE65Dr+l
	ymA7pP8Z4aX0ix9Pzn6VTTbuQDzYMzo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-CU-roWnKMwqBdKpO_Vmcog-1; Fri,
 08 Aug 2025 09:01:49 -0400
X-MC-Unique: CU-roWnKMwqBdKpO_Vmcog-1
X-Mimecast-MFC-AGG-ID: CU-roWnKMwqBdKpO_Vmcog_1754658103
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1812F180034D;
	Fri,  8 Aug 2025 13:01:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.126])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BBB61800297;
	Fri,  8 Aug 2025 13:01:41 +0000 (UTC)
Date: Fri, 8 Aug 2025 21:01:37 +0800
From: Baoquan He <bhe@redhat.com>
To: Marco Elver <elver@google.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com,
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 2/4] mm/kasan: move kasan= code to common place
Message-ID: <aJX1Mcc1QrkUgi89@MiWiFi-R3L-srv>
References: <20250805062333.121553-1-bhe@redhat.com>
 <20250805062333.121553-3-bhe@redhat.com>
 <CANpmjNNr7e6DXQrZva8k46jELr1JSkjExWvQOyrkY5VD8mOadw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNr7e6DXQrZva8k46jELr1JSkjExWvQOyrkY5VD8mOadw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/06/25 at 09:11am, Marco Elver wrote:
> On Tue, 5 Aug 2025 at 08:24, 'Baoquan He' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > This allows generic and sw_tags to be set in kernel cmdline too.
> >
> > When at it, rename 'kasan_arg' to 'kasan_arg_disabled' as a bool
> > variable. And expose 'kasan_flag_enabled' to kasan common place
> > too.
> >
> > This is prepared for later adding kernel parameter kasan=on|off for
> > all kasan modes.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/linux/kasan-enabled.h |  4 +++-
> >  mm/kasan/common.c             | 27 +++++++++++++++++++++++++++
> >  mm/kasan/hw_tags.c            | 35 ++---------------------------------
> >  3 files changed, 32 insertions(+), 34 deletions(-)
> >
> > diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> > index 6f612d69ea0c..32f2d19f599f 100644
> > --- a/include/linux/kasan-enabled.h
> > +++ b/include/linux/kasan-enabled.h
> > @@ -4,10 +4,12 @@
> >
> >  #include <linux/static_key.h>
> >
> > -#ifdef CONFIG_KASAN_HW_TAGS
> > +extern bool kasan_arg_disabled;
> >
> >  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> >
> > +#ifdef CONFIG_KASAN_HW_TAGS
> > +
> >  static __always_inline bool kasan_enabled(void)
> >  {
> >         return static_branch_likely(&kasan_flag_enabled);
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index ed4873e18c75..fe6937654203 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -32,6 +32,33 @@
> >  #include "kasan.h"
> >  #include "../slab.h"
> >
> > +/*
> > + * Whether KASAN is enabled at all.
> > + * The value remains false until KASAN is initialized.
> > + */
> > +DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> > +EXPORT_SYMBOL(kasan_flag_enabled);
> > +
> > +bool kasan_arg_disabled;
> 
> You lost __ro_after_init

Right, thanks for careful reviewing.

> 
> > +/* kasan=off/on */
> > +static int __init early_kasan_flag(char *arg)
> > +{
> > +       if (!arg)
> > +               return -EINVAL;
> > +
> > +       if (!strcmp(arg, "off"))
> > +               kasan_arg_disabled = true;
> > +       else if (!strcmp(arg, "on"))
> > +               kasan_arg_disabled = false;
> > +       else
> > +               return -EINVAL;
> > +
> > +       return 0;
> > +}
> > +early_param("kasan", early_kasan_flag);
> > +
> > +
> > +
> 
> Why extra blank lines?

Good catch, will remove it in v2. Thanks.


