Return-Path: <linux-kernel+bounces-772765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D79B2973D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 05:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7924B1962853
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4782525D216;
	Mon, 18 Aug 2025 03:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPn2apqf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E604520322
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755486783; cv=none; b=jD7a9q9RFJ+9R6eQZP//9oa//1rYqiStB1obZ6BBDMyRt3Gx6qljs+9xHeqq78CmW+egEqkazLj3JJqTStETyngqR6uSiQ4IlRP7XPR7TRhfJ30W9JRXEQnQks0na+/wbCnnurlT29LXr0/yCFpZC8ebTmQJu9rrjCm9Bu8ZSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755486783; c=relaxed/simple;
	bh=fNTmw2fBuD548RFxUye8NfcsGZKy4gYCOaELXJHaOOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QL9DFLi9X+gm2jTrrzMObzioDslJGQr2ZB7PUilpccfYZ4yzl0cY+0slU0Efs4kVT4gWvFaitOb75VH1Cb30bdr/HO5RklXwN5wr46BWWNI+2CVTZKnuHVUrBfT+b02h2TjO62gHmkslJuENHF1IdL9j+D49MBjW2RuduoB7Zj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPn2apqf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755486780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxP4/8pUHKOzQChgnbfSSvo+Fj1kOBX1r6KKSDodaO8=;
	b=HPn2apqffdjVZ1myQC7lvcoVNoTlguqa/peSq+KxAZFZ1bMgrtlGDxc6VIRxnZkt2HkcUE
	uqnwx45s40FqrN2Azk/2RxYzRexGaPxPrMQsINtAeCZl1YSy4CBDP6DCvWrw8KGxSEWyvZ
	s4+CgOMwpCG38qhdQXfUHQp9sD7boRs=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-Hi4ewSrTOESSdZViTOhz9g-1; Sun, 17 Aug 2025 23:12:59 -0400
X-MC-Unique: Hi4ewSrTOESSdZViTOhz9g-1
X-Mimecast-MFC-AGG-ID: Hi4ewSrTOESSdZViTOhz9g_1755486779
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-53b1757cfcfso2000020e0c.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 20:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755486779; x=1756091579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxP4/8pUHKOzQChgnbfSSvo+Fj1kOBX1r6KKSDodaO8=;
        b=OygD7rJXHba5eHTGPcdT7AnuFFmcA92iu4knqYVZGYN4l8UPrvrR1aRnqEynYPTpNk
         qa7F7HevD5tfNoF9NwJLxLkuL6oHqSRRmEIW3aUQh+9v8nFMEQd5y0EV6KTEm0iaGAHm
         z1NSMbiXOp9p8YIynQs/nDT5ZyFFJgL9rl2AQ6qyaTyarZRd+mMIlUInq5rzGZFWHNd2
         9nw0NjH6fGRSgh/68zJn3+fLBkilmWYmwZ3KL0K+LTaYuiiEWLqPd449YOpa6jJCT1MR
         vj7zSyXKlSJ5Y+KHpZjD/hJh9BIpFlBNxCPweHyNLn6OVNlLM3smaGNkxmuag9SshSsm
         tHDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkmDpURdGyB0mE6gyZ4J61BimUSoPX5gr5J2buxZL0t1QPo8fpWo43G5KA1vCIN5TyduSxPyXW+8PX43g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt3N7STSTVMIXpnrNWNmNGv9fWPBb+UOwRCXEb36/aTU1GaV68
	ukcAKrrjD9fr/Ng1MsHiSxonxBisjXY5VCuXczapAEmaa+ak4McSmx28h9pDll86is1kCbK6U+P
	ajU3lEBTsSLjOjhTEZt8p4qiUbEAGn2d40E66FPrhxLecXXYemhcf2UcwkgmOmXmtZGk/fGmOm7
	L4SoqlNCTyIgCVXD19R6GomyZtahYuc4F5+RQha+qy
X-Gm-Gg: ASbGncvTC7YgBs72eTUJG5U5wO7OCOeZjy7bZb5lxucRrB+Xr9B7ViBbZFUv8fD+dUH
	79s+C/9Kp+imAg1WGOmv3P99PH337sl3XKSLgwwoMocdVv71c1JlSxzL6K2f6C9BHbejjnUouhf
	ZiPTXYaDzuRLzipkikTPUmEg==
X-Received: by 2002:a05:6102:2ac7:b0:4df:8259:eab with SMTP id ada2fe7eead31-5126d027f98mr3387480137.19.1755486778973;
        Sun, 17 Aug 2025 20:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWsK8UrKTDkdR4i2/n1OFDGnu1OhTpAxLc5OsSgAw6h8ie0dKEQqEUFX1dVqBXMdHohFVdBVowlCJLnw8kGQ0=
X-Received: by 2002:a05:6102:2ac7:b0:4df:8259:eab with SMTP id
 ada2fe7eead31-5126d027f98mr3387473137.19.1755486778504; Sun, 17 Aug 2025
 20:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
 <20250815080216.410665-9-yukuai1@huaweicloud.com> <c5e63966-e7f6-4d82-9d66-3a0abccc9d17@linux.ibm.com>
 <af40ef99-9b61-4725-ba77-c5d3741add99@kernel.org> <aKADe9hNz99dQTfy@fedora>
 <CAHW3DrjPEHX=XmPCQDBLJoXmnjz3GKsht33o-S6tH-tNb-_WQQ@mail.gmail.com> <aKKL5nL4gf2bnXUd@fedora>
In-Reply-To: <aKKL5nL4gf2bnXUd@fedora>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 18 Aug 2025 11:12:47 +0800
X-Gm-Features: Ac12FXwf8fc9hFman4MiOzTae05viaZPrSxfQiwQzelZ0-I9UaKM7qnzU6vE_P0
Message-ID: <CAFj5m9LOsj3dUYX5qHSGxekFMGTonsSxSoRczUO8jr4DW3wtew@mail.gmail.com>
Subject: Re: [PATCH 08/10] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
To: =?UTF-8?B?5L2Z5b+r?= <yukuai1994@gmail.com>
Cc: Yu Kuai <yukuai@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>, 
	Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hare@suse.de, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:12=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> On Sat, Aug 16, 2025 at 04:05:30PM +0800, =E4=BD=99=E5=BF=AB wrote:
...
> > one line patch for this merge window? just fix the first double free
> > issue for now.
> >
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index d880c50629d6..1e0ccf19295a 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -622,6 +622,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *h=
ctx,
> >                         return -ENOMEM;
> >
> >                 blk_mq_free_map_and_rqs(set, *tagsptr, hctx->queue_num)=
;
> > +               hctx->queue->elevator->et->tags[hctx->queue_num]=3D new=
;
> >                 *tagsptr =3D new;
>
> It is fine if this way can work, however old elevator->et may has lower
> depth, then:
>
> - the above change cause et->tags overflow
>
> - meantime memory leak is caused in blk_mq_free_sched_tags()

oops, looks I misunderstoodd nr_hw_queues as queue depth, so this single
line patch should fix the double free issue.

Thanks,
Ming


