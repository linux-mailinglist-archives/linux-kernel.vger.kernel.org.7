Return-Path: <linux-kernel+bounces-736620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC35CB09F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2C51C23BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF42298CDC;
	Fri, 18 Jul 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dowzipka"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478B0298990
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830952; cv=none; b=cncZpwN0PzFJ+qPQW4NqD6PQ6OEAbxt+nKuiacQcIa8D5b2eb0CK5sCeeFIo07R/q9fYknSqUMc3gXX18uHujJt0rp6kBH4YWnHTzMQ9c3q2n37UhCgnxrbT/vcxH+dBzv1a+IHJazv6/e3S8fBc7Dyl/jDfs6qDUTGWxiG9yHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830952; c=relaxed/simple;
	bh=SSEapJw9gIpQvMe/GSbXsIpSF0SV6GSNbc3rYxWdvew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WS2BVBi1supwV3F69zsb/tqWj7fGkJ2w1g6hfFIzfQxtahh/Ri0Yt6thvh/aNv0XmFpVvlkseAhnLQ78yJn4fAKkfTTsUhKphedZX9QKkVmXEy/RNyPVW7J6zC6cI/0ci8uD78/wruQfh8doPIiE8HmgCA4SB2bgNin4oaY4L0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dowzipka; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752830950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05GlAbbQ3xY778mOKhz9KvpGxfjV14skZVzYZoy7Tmg=;
	b=DowzipkadO9oc1mRBb+BPOnGWunFiaFTga6X+WO0jwAeT7Vjnzld5cIb9ml/OJ9+UChYiK
	H1uH1kCzppnG1+qvq8+KVrZLCMCTMxwBVHfziuvbdIHvFitX/KOTIwTVMq1oDvEKitNAoa
	pL69hVNgmMYoKkK6zMIkU+EDZFEuGCg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-iISU7yhtORK1jytn_9TJGw-1; Fri, 18 Jul 2025 05:29:08 -0400
X-MC-Unique: iISU7yhtORK1jytn_9TJGw-1
X-Mimecast-MFC-AGG-ID: iISU7yhtORK1jytn_9TJGw_1752830947
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f85f31d9so947679f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752830947; x=1753435747;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05GlAbbQ3xY778mOKhz9KvpGxfjV14skZVzYZoy7Tmg=;
        b=AulKMKbw62qDJy4HyGkuiznAxrFudRpvkKmCVRfKHxj09v4PIqkFq8XVhPMPqq99DC
         Aki+Axrubq980duAi5RWG6+zEIWzLwQRw2KfY0brCnJPkPYHS3FroblfN26kV7LZ4aSk
         FxdINaGpqn+ADROGE4jpRv0BooV+PzGr8Lo4oEp3QnG8E7Q19uDCYo7YkyfTdRLrga1U
         BNO2vUJdyYWvjGdXEGaDnT3brETzhPhLFINCffuQofHq32G6TUODstCq2koibNRvzv3f
         GN4qYxeic00oc1gR1q2CDEagMIhYooEZsbef95gYZHZoNY3W+KTmUZ3G+SyXltGtXaVF
         +OGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgiTj4tGfPg5eGKkXBvLRL02kN/T9o1/e0qCsfIs96BXyXXkvgDnZNJrHLRRBMGB/6QjVA+4B0e6oCPMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyMfgPniqa1ujQlXiG5STE7KqU1Mkd+IZy4h5n5che6IjsjESf
	tlaI4lPRRS2oWnTrJzShdAU8XAF7ISjcxPWdRURBPw0iuz+H+rxvC6s7kwGNlnhs8DZzHWqcGg+
	qv94RqJza06xBGtdOb9gt7icnQdOw7wQshUTCu4Bv/+d+f2Etm6GJCO1g0TEDti/Z4A==
X-Gm-Gg: ASbGncvTBLdK2EVWzXHI/1xB7HqxjVUY7/sSdN1Z4T31z9Zbd+HYu+9si/Vfq3W9scy
	p/5rUaKkNclnNj43Z98KyEsuDAHDin6iBTg9uoks57n6hPQDJzLPGYpDeQipXM99L9EJYcVjVlw
	aIgBpdXg1qIPxLQHmOTDeetp8Kmveaqpa/gm58RpFf5yT6Y0nmVg3LtLhG25HrsPQJWAvqhVflt
	Ow5e3rJiH64tbEgazB1XBiHmmj1VBhvs/MUqYUli8hQLZeMLfOTPFGJxE1F9ywlEA5MQFPqyKTE
	wd92NN60Rq0ek7G+9Rzv4A0Q2gILaAa9
X-Received: by 2002:a05:6000:430a:b0:3a5:8cc2:a4a1 with SMTP id ffacd0b85a97d-3b61b220fd5mr1590617f8f.39.1752830947091;
        Fri, 18 Jul 2025 02:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF99Q3CYpAdCQEYHNdwI4F7VEKY9nBiW7NBhJbkG8u6wZyeCRLsebXdo2QPbFIqLY0Zj9jJVw==
X-Received: by 2002:a05:6000:430a:b0:3a5:8cc2:a4a1 with SMTP id ffacd0b85a97d-3b61b220fd5mr1590597f8f.39.1752830946555;
        Fri, 18 Jul 2025 02:29:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d581sm1290245f8f.64.2025.07.18.02.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 02:29:06 -0700 (PDT)
Date: Fri, 18 Jul 2025 05:29:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jonah.palmer@oracle.com
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
Message-ID: <20250718052747-mutt-send-email-mst@kernel.org>
References: <20250714084755.11921-1-jasowang@redhat.com>
 <20250716170406.637e01f5@kernel.org>
 <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
 <20250717015341-mutt-send-email-mst@kernel.org>
 <CACGkMEvX==TSK=0gH5WaFecMY1E+o7mbQ6EqJF+iaBx6DyMiJg@mail.gmail.com>
 <bea4ea64-f7ec-4508-a75f-7b69d04f743a@redhat.com>
 <CACGkMEv3gZLPgimK6=f0Zrt_SSux8ssA5-UeEv+DHPoeSrNBQQ@mail.gmail.com>
 <7aeff791-f26c-4ae3-adaa-c25f3b98ba56@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7aeff791-f26c-4ae3-adaa-c25f3b98ba56@redhat.com>

On Fri, Jul 18, 2025 at 11:19:26AM +0200, Paolo Abeni wrote:
> On 7/18/25 4:04 AM, Jason Wang wrote:
> > On Thu, Jul 17, 2025 at 9:52 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >> On 7/17/25 8:01 AM, Jason Wang wrote:
> >>> On Thu, Jul 17, 2025 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>>> On Thu, Jul 17, 2025 at 10:03:00AM +0800, Jason Wang wrote:
> >>>>> On Thu, Jul 17, 2025 at 8:04 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >>>>>>
> >>>>>> On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
> >>>>>>> This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
> >>>>>>> feature is designed to improve the performance of the virtio ring by
> >>>>>>> optimizing descriptor processing.
> >>>>>>>
> >>>>>>> Benchmarks show a notable improvement. Please see patch 3 for details.
> >>>>>>
> >>>>>> You tagged these as net-next but just to be clear -- these don't apply
> >>>>>> for us in the current form.
> >>>>>>
> >>>>>
> >>>>> Will rebase and send a new version.
> >>>>>
> >>>>> Thanks
> >>>>
> >>>> Indeed these look as if they are for my tree (so I put them in
> >>>> linux-next, without noticing the tag).
> >>>
> >>> I think that's also fine.
> >>>
> >>> Do you prefer all vhost/vhost-net patches to go via your tree in the future?
> >>>
> >>> (Note that the reason for the conflict is because net-next gets UDP
> >>> GSO feature merged).
> >>
> >> FTR, I thought that such patches should have been pulled into the vhost
> >> tree, too. Did I miss something?
> > 
> > See: https://www.spinics.net/lists/netdev/msg1108896.html
> 
> I'm sorry I likely was not clear in my previous message. My question is:
> any special reason to not pull the UDP tunnel GSO series into the vhost
> tree, too?
> 
> Thanks,
> 
> Paolo

Paolo I'm likely confused. That series is in net-next, right?
So now it would be work to drop it from there, and invalidate
all the testing it got there, for little benefit -
the merge conflict is easy to resolve.

-- 
MST


