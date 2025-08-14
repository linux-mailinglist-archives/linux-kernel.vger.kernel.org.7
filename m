Return-Path: <linux-kernel+bounces-768592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7617CB262EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0F91C86A82
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D5628C009;
	Thu, 14 Aug 2025 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="O/GOHdyW"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5487C2E7BC8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167842; cv=none; b=FL9j/HLKPbb3/Kd6cNcXeLLzN3MB1GrYj9ocL6fqgb5jFyJHLdeSCpNemQAqIOxGrTcccvVTNdWuMKy4DVmtxRmFzw4DACn3u/9wfaobxlkJfJMWjjMM+6C4GVF2gn5zyiQ12UNeydksLv9AE3jqokS0t9rCj6+3AoklqEpZT4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167842; c=relaxed/simple;
	bh=2z4KHp3G9a5b9AfVC4TLzGl8oU7ja1D8uVs4f94B57E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjgRpUh6b2L1+LqQx3/xHtcBZ4oDomp71bPSjNhrCv8oLiwRw6ScCaK1vmKRycMTkZ/rr30FvL5RFMRrei5gD8Y/2IWQqi3/6Lp87xE+ITdLRIODp00RCbz2bZO7CGKhCdUB+s+IUJv03oZpuciXTzl0PP5wCWZTVd75UUxItQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=O/GOHdyW; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e8706a9839so86116385a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755167839; x=1755772639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kfg1xdeLOfyreKnr328hQaYYjz2z+mng0dgiwOWK8Ho=;
        b=O/GOHdyWZapd+Nae4I8AkqAIRlDiXTWapC6/jH6o4x70+cSV5xWtCGGTblvSY3gApB
         QHc/mOyfbM+ZTYQ8ptVLzn1NDc4xewRyPkMC87FPDYgcd9c6qEFXD6RSyGE8+s0oo4AX
         rhkrWHIK/1AfLWZXh1yFCv3TFLmRVPrORiMp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755167839; x=1755772639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfg1xdeLOfyreKnr328hQaYYjz2z+mng0dgiwOWK8Ho=;
        b=ZoR9RcTTpEqDFuor6UF5yEURME84ZUp5K/5eYmZ1/G92SrgCiqIMBX09w/QTUN2RUt
         JtXzy3sbsO2dM1YikZrcKrUDe6GUuD41/5Yx4aHD9wH9qF7gofXig6kDQRE9JmJ2wzMr
         v7JPbvF+yU1OxlGNA0T8TQGw73FJ+nbnfYdAurOwNL4xMo+rHfaOAF5iVJjGnbLUZyU0
         qnGj0JJQpgeyHl1bip9Xo5LQN2rTDWNpvJkCLCJh+JnadAd59csfotDNpa/3q+nind3X
         KlN/gV2bx6CW0xVSxUO1zmQPSUQvBO4L0+CLgqUrT854d7rQ30ARrJrvADNGqIM1Vt5F
         iOUA==
X-Forwarded-Encrypted: i=1; AJvYcCX47gdmJ9b7QSu+ZX7oHk3qntBYf8O5XjGBEuSG3cv+3slIVV2tCZfelKYbdLGJqi+hR7DChYXU48ivLMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYdCWq/jZeWyhWm40P1z0aC2DkJJSuMfsdTzS5Il/asSgxGShb
	xgtpS5oB3/mHA9fQ/K/SjeC2QLwh/lF6kcU+wXq6wD2HNX1U3z84gow6/TfMT8LuWopQCGH+unr
	pVnMpSRCJHxQHFdYmuPcMbCJhag1jE3A1egUbPa1KqQ==
X-Gm-Gg: ASbGnctiQvZzS997W1MUQEuPWDHkJHYYl9RfWolwm0ktNoQP4JKdcYZEBngI1MwDWYw
	FOR2rUn6NmI3PquhWsA/YJRX156CXtynK5Jfp1ezrPJIqqWp1GNLSYrT32LojkMeTQ2P8Pd3nb9
	UGtHF1uRehqKcDK+4DdVYHdsnbZeZjk2YndnD/JjKUdFSz9kAwbAaePTlYEoeeeZiF5yt+jvAux
	0BB
X-Google-Smtp-Source: AGHT+IGCyQ+LrtnuvvD4cnfS9KWxmodF+LtsJHdOQQ03BWq4ghzPdSAt/rs4hdQANvXyGJmp0NayklHjGgL6sn9UaHM=
X-Received: by 2002:a05:620a:17a8:b0:7e7:f84c:9d65 with SMTP id
 af79cd13be357-7e87066e73cmr321505585a.38.1755167839208; Thu, 14 Aug 2025
 03:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-12-john@groves.net>
 <20250709035911.GE2672029@frogsfrogsfrogs> <ttjh3gqk3fmykwrb7dg6xaqhkpxk7g773fkvuzvbdlefimpseg@l5ermgxixeen>
 <20250712055405.GK2672029@frogsfrogsfrogs>
In-Reply-To: <20250712055405.GK2672029@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 12:37:08 +0200
X-Gm-Features: Ac12FXw_tUJvAdswzhdrUe0cP4gCxZqTC0WTTpEt7BoMabiUDl0tjdFveoca6_Y
Message-ID: <CAJfpegspQYVbWVztU5_XFwbGaTQKe2NCm2mcui6J3qv1VDxdSQ@mail.gmail.com>
Subject: Re: [RFC V2 11/18] famfs_fuse: Basic famfs mount opts
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>, 
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

On Sat, 12 Jul 2025 at 07:54, Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Fri, Jul 11, 2025 at 10:28:20AM -0500, John Groves wrote:

> >     famfs_fuse: Basic famfs mount opt: -o shadow=<shadowpath>
> >
> >     The shadow path is a (usually tmpfs) file system area used by the famfs
> >     user space to commuicate with the famfs fuse server. There is a minor
> >     dilemma that the user space tools must be able to resolve from a mount
> >     point path to a shadow path. The shadow path is exposed via /proc/mounts,
> >     but otherwise not used by the kernel. User space gets the shadow path
> >     from /proc/mounts...

Don't know if we want to go that way.  Is there no other way?

But if we do, at least do it in a generic way.  I.e. fuse server can
tell the kernel to display options A, B and C in /proc/mounts.

Thanks,
Miklos

