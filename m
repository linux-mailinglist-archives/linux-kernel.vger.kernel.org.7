Return-Path: <linux-kernel+bounces-788899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F90B38C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B703BDD65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5949631077A;
	Wed, 27 Aug 2025 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3ar6SK6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1030F95C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332270; cv=none; b=rCa5QdEsUDCpyysrtfu/pLD28SfYRmSspm5P0WCTf65Ye1OsXG8qPz13M9mG3/SD8foJbQrRcJniZL6LCzt2M2lax/i65C5vfNdFkFpqDh76JFYaayAAaJvA07wH8B/hcyKNqK0aZBx3iPrWgQQ7oYhNkyHtCJuGJgz6aFjPguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332270; c=relaxed/simple;
	bh=QBThy5L9kt0vy3Em05+03Bcjn8m4khcRfvF3Hb3pPIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0dAek6sBapFBe92wvbEZiVSHc1MioNB61rjehd9Abnsufrp/sbf9Lvljh0gaNIWXvv/CzxZ50sGKN496DJVqGrseLQUmx9MjCEqZp/vl6b3q8eJ1m1fdCv+6QGjafClFlS0DfU08jYRFql9FZ5f4rrIb4VDrABxSNraXvEj6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3ar6SK6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756332267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OEFBgFIvCAQPYhXVvclPVAZs38YDchKEl12N56oJND4=;
	b=d3ar6SK6VoH5zdocbFvPByba7O1hwlVcHvmMKMP3phvoMcY4xsGlG3kI5rKJEAX00hoKap
	TY6WSFGXxqy37EdNBxkprFHyHL7ukZ4R//4/CyoGWlCRYDvBfdRS7PBwvM9uL6aXTAmIfy
	p/apR46Bq+5WwilYolUhjy85irQ5YJQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-6kUj63dyMWyAwHA6J_AWjQ-1; Wed, 27 Aug 2025 18:04:25 -0400
X-MC-Unique: 6kUj63dyMWyAwHA6J_AWjQ-1
X-Mimecast-MFC-AGG-ID: 6kUj63dyMWyAwHA6J_AWjQ_1756332264
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3c79f0a5bd5so239815f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756332263; x=1756937063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEFBgFIvCAQPYhXVvclPVAZs38YDchKEl12N56oJND4=;
        b=MDuZnaAm4kIkCxNLZXlkGbV1UECq6E+hfkaF3ayuJbO+7XqE5BbRF4nbARxrj5t6Em
         8LphWNQWsWSm1bh5d2wJRY/W1tC9JqpJanAWMIrIPAB9uucVfNTW3pW4M+T/l2LLO69g
         gE2dmTvZ3TxXfitQyfXJk0exfC+lB0xCh4KXWCcb5+T8KOiibC2RK6KhCXYQiFjFBykv
         twf+iaIEr2lbHHJK6uvtDhIWrsnxMJK4ZH1Tq1hQIhGQgUbMT0tLsTWG1f3Wq3XsWjE5
         pEiMiAsBO6vam94k8vwwsaMksvswhUTxo8RoXN378uxG7SIIpuFvVOPraAL2wq+xU+xu
         Z9vg==
X-Forwarded-Encrypted: i=1; AJvYcCVcHeluZkg+3hjfvYAAqmx0AzIPzw8kj0/Xg3j6OCof+jnAwbPpDoSAUUzBobW+krG7oHcMJUmfqKAGUUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+DcDSdSB2ZnauzYSHuCTr4rDInuycyMfY7mv5SRGwxmiIdlUA
	p6EKNi0/IyAWlp3viA8HHAMuk0rwnmQMq/rjveht2IQzahlMt05KWU7AEHbRIEPhrKUyty87XGN
	Mw8EQuz9TNIb6zN+Gls6motsaU0LSln/11qoUKIQYISgX6zdy2hSEaqWPfG/EYshyjIQoNMu5OZ
	k3
X-Gm-Gg: ASbGncvgYiDLjFpnzPdlq9UvY4zQry0ZlWe0jf5swm5A3OaAYSRa3ZBttCiQ8e3176N
	gjAAFOyafFCkLoT/I0yuX2XmuWgoY/pBLPJHSxJQFpdZfxHpWlKLQey0g6zvVhctxWasv6VdD3B
	9MDrVbFKrFX0aXaZZOZyBnW7U2RvhJVs/bSnJA0L9AOYRNBhJXaug2FtDsQ4PCom7L1w1u/7fE7
	cEFPKIxcwoerW/jk4p1Fa1qf7qh02VlsIoH8hqYNAgywS5OzKmW4re/QHJA17XTt5ssY9yrZEM7
	uYLpGHFefRIJAtgZy0OMcAoh2PPJuExc
X-Received: by 2002:a05:600c:4a22:b0:45b:7580:6f29 with SMTP id 5b1f17b1804b1-45b75807bd4mr10021045e9.4.1756332263554;
        Wed, 27 Aug 2025 15:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeFHIWe1QwfMq5KEErvPK+Alt0w4twa0nXLb2kOIp6Er1rEDYev8pXW2qpNWVXY0MPTcVG0g==
X-Received: by 2002:a05:600c:4a22:b0:45b:7580:6f29 with SMTP id 5b1f17b1804b1-45b75807bd4mr10020935e9.4.1756332263183;
        Wed, 27 Aug 2025 15:04:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211b19sm22668380f8f.39.2025.08.27.15.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 15:04:22 -0700 (PDT)
Date: Wed, 27 Aug 2025 18:04:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the vhost tree
Message-ID: <20250827152222-mutt-send-email-mst@kernel.org>
References: <20250827124654.78881028@canb.auug.org.au>
 <20250827062218-mutt-send-email-mst@kernel.org>
 <aK8_uOoLxLOniEbR@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK8_uOoLxLOniEbR@google.com>

On Wed, Aug 27, 2025 at 10:26:16AM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Aug 27, 2025 at 06:23:52AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Aug 27, 2025 at 12:46:54PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > The following commit is also in the perf-current tree as a different
> > > commit (but the same patch):
> > > 
> > >   c67e16d30dca ("tools headers: Sync uapi/linux/vhost.h with the kernel source"
> > > )
> > > 
> > > This is commit
> > > 
> > >   f79a62f4b3c7 ("tools headers: Sync uapi/linux/vhost.h with the kernel source")
> > > 
> > > in the perf-current tree.
> > 
> > 
> > Hmm.  I could drop mine I guess, but it only really makes sense after:
> > 
> >     vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER
> >     
> > 
> > which is not in the perf tree.
> 
> Yep, so I was waiting for you to send PR with the fix.
> It seems you already removed the commit in your tree.
> I'll send a PR for perf tools with this change.
> 
> Thanks,
> Namhyung

It's in my tree but I did not want to send it before we agreed what to
do. I can drop it, sure.

-- 
MST


