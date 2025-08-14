Return-Path: <linux-kernel+bounces-769159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384E4B26AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8F13B3E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E661022425B;
	Thu, 14 Aug 2025 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nLbSPa6w"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD2A22331C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184775; cv=none; b=ZnoEMboUIyHzM+gJaPUTI+7XewDZSbwVyhgrh0KSp0D6hR7Y9L3VfqDqTFIxa9FcDHesKfOkZzBxXDxlygTVvCKm2xb2C/tyh8AYjrhSwYm8i4wAQSFUsppUhN9inM6I7zDhvuYhEngxDVft7AZ0uRinq1oATHkhlcEvKCeUeMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184775; c=relaxed/simple;
	bh=w0w0dvsu6k/K6PwFlV7vPpkTwV9o99ZgnYkwYYG/8s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlAfRquq0DlAYkhM23GJ2j4BGpdbVLG+VeuxoDU0rs74xW5VQuhFpIA5KRwFQm+Jd8qmv691OzQHPlvZxjVqYBSMAq8ffhAb5ZG8Z3FDWwtXcd6w5LSUAYS0qcm7LTLfO/M9Oy4ugqZ7S923Ajjxeo8Lw4PQ5CUO4WEfD2yXJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nLbSPa6w; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b109c6532fso9579681cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755184772; x=1755789572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EA1ZvFf+qWrndIFVkpDd7IpLWJx6+2D8DPmrDSfzpF0=;
        b=nLbSPa6wSfW6iCCBQoxh4+p9jCDfOizqypU73rXtCjn1BgXV957iRTFTtfAR3X1aK2
         ojqSsWGo4QLxAJmi5KwRfXOo3wvWLyp6gyMHoktgawOgtvte0P8E5OPp68kiup5CY1uV
         ENnEaxbmpkhRj84GdnITQXTFiwiooHB35Gat0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755184772; x=1755789572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EA1ZvFf+qWrndIFVkpDd7IpLWJx6+2D8DPmrDSfzpF0=;
        b=c7W8DsVp8jXi+zJ5ehtmKBJBWo+tGatc3nMGp5SoI5KNeVMUAh2q8pFmgHT/wPeMjU
         XmaMt9xdTmELZ/tKa46JIv+hJDWqNpwrwB2XY4mcuqn48gDqqfUizspJOUl+6U5y7Zms
         YojMOnTZaShrcR+uyd3s3Ys+VRAdU8ADp8N0vvhO3bJomxP42n9U/HC40dWUWtWwWo+5
         TAACpf0O5TdaeQikwdDT/9G+gRuv88ApKNCUCf7SxbDlgSykd6hw5n7KTx4q7lr/fi5E
         PrdIHNAwrkudTl4hkHsLj2VUbFgYzneSgSSjdQ4sJj7BM1/bcTwetfXkLMWCoHhiOlU7
         huIw==
X-Forwarded-Encrypted: i=1; AJvYcCXqcoRPM/XQMVxI3FDvXgiOvPbONE8DMl3dDnsXeBZMRMxd2h/EKZEBBZW6gITZnqJ1Xk6IRUm1gUmQs24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKRuuoR7xEscCZ4gRulNGsIpaASFafxKGpxvMjPhIrP5T3VRo/
	Xrdp4fX5JJoZQJCN5zk4p/jNu/+ILSe92tZ2w9OrdbGqWMwzNG+NusKOSapKlWCTxTEjjynF08J
	xyf1s9GEFkjRsNEI6M0o7g/Nr5zSs0H29LzaaaNpDWw==
X-Gm-Gg: ASbGncsf78sZd2jcBuCIz41bHWXDdT2f5jqu4O4mzXVdgXJcHwdbYmEAuBYT/1IVt/D
	19e0MVyKv+AYbw04671CFxMHuHS23kZWOISnDtvkcsLvrjPoG5cBHye0kyThzPw8KhgGixyNATr
	/pQ/zN9nCBY3LIS878INKixyMNNbA5jOVVq74tDHgnsBJbJNrz7Jac5DfmbJeDfvWOSTy5872Jz
	Q5+p9EV
X-Google-Smtp-Source: AGHT+IG2qa/e3q/lS7fdE17E/mieIqz9XZskfeQdm0xkHvlzBuR85dHk6whip69ESAWWHza3LlnZuCoCgfbTex8i3Ho=
X-Received: by 2002:a05:622a:5c9a:b0:4b0:7327:1bf5 with SMTP id
 d75a77b69052e-4b10a958412mr55498911cf.6.1755184772275; Thu, 14 Aug 2025
 08:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-12-john@groves.net>
 <20250709035911.GE2672029@frogsfrogsfrogs> <ttjh3gqk3fmykwrb7dg6xaqhkpxk7g773fkvuzvbdlefimpseg@l5ermgxixeen>
 <20250712055405.GK2672029@frogsfrogsfrogs> <CAJfpegspQYVbWVztU5_XFwbGaTQKe2NCm2mcui6J3qv1VDxdSQ@mail.gmail.com>
 <z56yzi6y4hbbvcwpqzysbmztdhgsuqavjbnhsjxp3iumzvvywv@ymudodg3mb5x>
In-Reply-To: <z56yzi6y4hbbvcwpqzysbmztdhgsuqavjbnhsjxp3iumzvvywv@ymudodg3mb5x>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 17:19:20 +0200
X-Gm-Features: Ac12FXw8eO26MUJ86ncWZmuTB9wijlUFGNEwkcMvFc2CD_KfkHGAKLg17yDdXIs
Message-ID: <CAJfpegsQxSv+x5=u1-ikR_Pk7L+h_AqNBW1XxM-b1G2TLPP4LA@mail.gmail.com>
Subject: Re: [RFC V2 11/18] famfs_fuse: Basic famfs mount opts
To: John Groves <John@groves.net>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025 at 16:39, John Groves <John@groves.net> wrote:

> Having a generic approach rather than a '-o' option would be fine with me.
> Also happy to entertain other ideas...

We could just allow arbitrary options to be set by the server.  It
might break cases where the server just passes unknown options down
into the kernel, which currently are rejected.  I don't think this is
common practice, but still it sounds a bit risky.

Alternatively allow INIT_REPLY to set up misc options, which can only
be done explicitly, so no risk there.

Thanks,
Miklos

