Return-Path: <linux-kernel+bounces-836731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A60BAA6FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946371C652C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CCA244669;
	Mon, 29 Sep 2025 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieOPG71m"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E46217736
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759173210; cv=none; b=WxVaBNM11NlNBd8DSNwrBecSGUsI16iQeWIB6LxfLEsmpxIg0oheBUlZ9EoFHRDgigwJ2IwsIJpDk7To82q8JSUAo1VkbhrEYvaDqmu8X1rbXoSTQTerNQS7COByKvW5nnJQDIGFG5apBZwH2mprWY+Ns8FQGUMtRbUuHSUmbkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759173210; c=relaxed/simple;
	bh=P9Y1j6zDFm6VNI5Ni4uPj/s+D1Z6aovIAiLNcjmEWq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8Qrhz+u7hbwHYt/NO9EZ5/I+moJgYGQ8gN9W5cKuVkhW5mwczdkSy6caofc9PU7tvf0tv4OsBVrJNU4CLtargY9QQmYtMiefO24rjuJjMz+s0TSaOU4784T+RicOSzBsmowMkOMWH9/8RKWWVlk2/EcuaHsS4qaYXmn6bh6psc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieOPG71m; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57a59124323so5201622e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759173207; x=1759778007; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhqVWTFayCZqdCtpHugU4/RlDPGuDMr9RSGzGhiO5nM=;
        b=ieOPG71mbFeI+xG4E2vS2frHAA4tOjc1rJc3uMqGWVUhjDtpz+mq3P45S4dmq6Qe/w
         8j3w7v9z336ktyQf1PV+2nTrazFd8/DvCcUPnNtikkL6eQAESQQDrO1nHREdjKWjny5g
         6OGi6ZgZK8tKE20Fy3+VAqVAUK4OVElrqlbI8U33/IzC9VDb9Jvp4EzHde11QdvBB3As
         8Dhn9LELFc4S0aT2s/CHZRoh++QXJ9vGmo5xgoRTR92d+nB6VXc+Dk1UvRfTDDdlXQeu
         s45zrnQxC7mpSR61gXpeFxjnj2590qZMY057JOc7gsSro92FPo8DbrCCbWMqRyfTzc1f
         4WvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759173207; x=1759778007;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhqVWTFayCZqdCtpHugU4/RlDPGuDMr9RSGzGhiO5nM=;
        b=ZVkunDgYjHmUtn3//GpU/tLGkhFHOk1MA/W7WNypWzmiIDi7q5Vvpx64gx8bO1NeHM
         eVjZQe8rq5r72tYPBRzgccaYxmokXVFcE0wF+PWT6SAHRh+lMJJM1dYvBJPkTUgwyFc4
         ScVZ+JshjZqY02+Izhc6B+6Lk77h10THzuIMROh7WFKNCxQHPsqRNiwwZjVuVlp1AmFy
         W7loaNYqGYkunmPA4ETdpuobZZua5eIH2YDy1H6u01edgyOxeQzPUNxy/jOvfPeT3Ppd
         cIZo36ldNX/mowb3e3Il5a2depm+iG2BNQZswZ+Tl515lppw0wRAxH3y3bHek+lzU3+O
         87DA==
X-Forwarded-Encrypted: i=1; AJvYcCWT/1974KNlS1T8Liuluak9ZgtvtljU5q91ukwIC6SH+um0bgCujpsbh6rLKGNfed864Y41/Qm47kBHv2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVsmYgzgC+qk6/jW8oaS4Rr93/ncZfe9dA7Bo4kvqooE+Nu3Rc
	lHPFF+pKXVAPkKjRzIYktoHwY3GGYTDD8diJLBiccF6s14jp8k43Va0D
X-Gm-Gg: ASbGncs521ua1ew7Ga23Vv5hvRlA0jr1yKSGAr/zgrwFvkfdq4ZOC5AgzGFZnFsGKGG
	03qkIzMKnanVJJnozNcPrX2uT1Z4Jfk3GoFlLtz+VxYcp3X/6gWpI35HAM3sA7qnjPzk9lut0L/
	zIOVAI3kg5xxT8cNgNl6bL9+gDNKrgHRsp4GrRtePTLoq6LH+3Qp9T+fftxvAcOhA263LQGAIu/
	7RLsrVIJQANLDNHJ7+fAHwkewZqf05YyDCVt9zBp20pQqsEU5GerpS68LiWzhdr8rLmm7p7uqTZ
	TmbN/D1S7PxlaOPdLlmxYeqcsHq6BI9TRjF9fGPpa4QJVpwD9I9akmMoUOjo47gLJ3/4DkHedFk
	lmawYO6hKmFx8XmkduZ+lxqnqfFpqBrZ7NxagL3ro/fw1LM36cw==
X-Google-Smtp-Source: AGHT+IEL0DvGvJFTjcXFtSLUYDkcvWLmwEDINloNMRh76KrCro7nYZP3SSYe4SN1qOLDLjMmnPhzfw==
X-Received: by 2002:a05:6512:681:b0:579:8bbb:d61b with SMTP id 2adb3069b0e04-582d3ba1b83mr5213106e87.46.1759173206578;
        Mon, 29 Sep 2025 12:13:26 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.147.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58567242ef3sm2473234e87.19.2025.09.29.12.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 12:13:26 -0700 (PDT)
Date: Mon, 29 Sep 2025 22:13:24 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, 
	Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFSD: Impl multiple extents in block/scsi layoutget
Message-ID: <qddd2ydxgzhx72ybsxt2o3o2x73wkntqsfpg57fsbw5qlfgm4l@yzan3q4ybywx>
References: <20250911160208.69086-1-sergeybashirov@gmail.com>
 <aNo0BCzVQxR60qeT@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNo0BCzVQxR60qeT@infradead.org>
User-Agent: NeoMutt/20231103

On Mon, Sep 29, 2025 at 12:23:48AM -0700, Christoph Hellwig wrote:
> The subject line is odd.  What is impl supposed to mean?
> 
> I'd say something like:
> 
> nfsd/blocklayout: support multiple extent per LAYOUTGET

Impl is short for implement. But let's rephrase that if it looks odd.

> On Thu, Sep 11, 2025 at 07:02:03PM +0300, Sergey Bashirov wrote:
> > Checked with smatch, tested on pNFS block volume setup.
> 
> Any chance we could get testing for this added to pynfs?

Thanks for pointing out pynfs! I'm not familiar with it yet, but adding
tests is a good idea. Will take a look on it.

> Also what is this patch against?  If fails to apply to linux-next for
> me.

At the time of submission, the patch was made on top of nfsd-testing.

> There is a lot of code movement here mixed with functional changes,
> which makes it very hard to follow.  Any chance you could first
> split the functions, then introduce the new pnfs_block_layout structure
> and only then actually add multiple extents per layoutget?  That'll
> make it a lot easier there are no unintended changes.

Agree. I will try to refactor or split the patch to reduce unnecessary
code movement produced by diff tool.

> I struggle to see what the point of the nfsd4_block_map_segment helpers
> is, as it seems to add no real value while making the code harder to
> follow

The main idea of nfsd4_block_map_segment is to logically separate work with
XFS, handling single extent, from the loop through the pnfs_block_layout
structure across all extents. If we combine nfsd4_block_map_segment and
nfsd4_block_map_extent, the switch statement will end up inside the for
loop, which will result in a large code movement in diff due to the right
shifts and line breaks.

> The subextent handling confuses me a bit - there is no such thing
> as a subsegment in NFS.  I'd pass a never changing end of layout,
> a moving offset, and a constant iomode directly, which should simply
> the code quite a bit, i.e. something like:

You are right, subsegment here simply means a smaller portion of the
original requested segment and is not related to NFS structures or
specification. Actually, I first made a version with three separate
arguments. But then reworked it to reduce the number of arguments in the
nfsd4_block_map_extent function. I am ok with any option, let's pass
three variables without using structure.

> > +nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
> > +		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
> > +{
> > +	struct nfsd4_layout_seg *seg = &args->lg_seg;
> > +	u64 seg_length;
> > +	struct pnfs_block_extent *first_bex, *last_bex;
> > +	struct pnfs_block_layout *bl;
> > +	u32 nr_extents_max = PAGE_SIZE / sizeof(bl->extents[0]) - 1;
> 
> Where is that -1 coming from?  Or the magic PAGE_SIZE?

PAGE_SIZE is the maximum possible size of the pnfs_block_layout
structure in the server's memory that we would like to have. And -1
ensures that the nr_extents field will also fit in it
if PAGE_SIZE % sizeof(struct pnfs_block_extent) == 0.

Yes, it would be nice to add a comment in the code, or even better,
an inline function that calculates the number of extents in a given
memory limit for the pnfs_block_layout structure.


I will prepare new patch(es).

--
Sergey Bashirov

