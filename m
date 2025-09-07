Return-Path: <linux-kernel+bounces-804535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B47B4792D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 07:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79ADA16BE68
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 05:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C113018EAB;
	Sun,  7 Sep 2025 05:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/ZZL9dJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE2C1A01C6
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 05:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757222295; cv=none; b=FT07CfqbhvxmjBlJUAtlmGdCpnZ8uwyieNadgWDrdkB3kqGRWMXMG6gRbdhOZPfq03KLNXpVsjU4bKG88b39xdEaat6MndyIwevkoNDMyX+4cUgvgKJUlc9AhNjk8NdEESehlpx/3uoqSwf0q7seLxd8xouaKcbWvio36nrEc7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757222295; c=relaxed/simple;
	bh=qwccVuzbUesgD3QoZMWodzkcU8xN7J0ykW7Ze0ZXgK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWhtUMGHXZn7TfARG4g5TyTm29aL9Di8DJ76+VLxrfT0ZQPcVEqsRLLr6xT9EkPXOTVHvz33MEUnf5tWxev/8iPa061p96fOgonVKizFo3Ngp7ppkkyIl1xDF5B4lfCNr2+tPCYHaiXmK8DfO6sPNzQerbqgCgxWUU3EbEPAys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/ZZL9dJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757222292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OblASZcrr7kB2yJKEylAwifpAWWyy4KUP/8RCxYnVGo=;
	b=h/ZZL9dJAkhDgqZ3KgPkro/X0Kl69eMJRT1Qx+HCFHatpZzxYjlIH7fMa7zI8wg/mCa2ZN
	JpBK/nsO/fe6WLSKAXRd9ETScmx+fe8vHzjoUsqUMPoDScmC0lyMIJ5/CN00cty/tk3xfW
	8s5+jru1XBFDoPywvd/PLrefsb40Su4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-LZksDGojPuCc75JVzVPNqA-1; Sun, 07 Sep 2025 01:18:10 -0400
X-MC-Unique: LZksDGojPuCc75JVzVPNqA-1
X-Mimecast-MFC-AGG-ID: LZksDGojPuCc75JVzVPNqA_1757222289
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24b2336e513so52181205ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 22:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757222289; x=1757827089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OblASZcrr7kB2yJKEylAwifpAWWyy4KUP/8RCxYnVGo=;
        b=PHkoPkrUEpQ7kCeGpoAR90RaD6WC3PPqHLnb6AZ1UeRScMx+2EbHtgQ09afSIckLp3
         kCRYNAwh7h2lnIkgtPLt/xZbLMijYCjieK+hCA/PQIRorEQFDz78mfqyYbQapr+QvT23
         7j69ey8XvCdaRUCTpyHZj3aWtyPRTWn81j4TFIf9eYkUR1g8fBPsMVZn4QSjEniG9+iy
         QwNEjDJ/Z+URBuuOyBIqlI2TC+wv3iNlBE7BdoVqd+Eaa77sy5F+t4C5mSMKD6e9ZSJC
         VEEamTCu3VOJ/JBnQq8vApIHZGOV74Ms7E7y1ICp9QU1GbR9KuQOqH8vTX0OafWfWYHS
         jP0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/K4KpEtHCVcBm0cP+CBa0BkLR/r1q1HTmV8hqw46TcoOL+shsAo0d2ZQapRrjJEpxubc/2eiV87oR+w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRDasrsnRFSR/SxkCYCzjzyC3/OVE0rs1JCPq+29qfpdbnxL4V
	CqWgHNfFHfKO8ny/ym36yDswMTU7G0h6MxSfMs81t1OmMQ6bBADZpO3ndypuFQDaYLh9CoZXWoW
	06Dg6zhFiHDX1a2ta+cWa/e1uPUpLgROrXHBtt8bWQ3DEomCGziP0tWInrfShiBnpVw==
X-Gm-Gg: ASbGncvUT14FTVW8eD8V35d75ICbxBi0se4PsniXUuZLGIVvS5WprSUTWS3Tz4wOcck
	Fwfmd2ZqbVabscgjP6KVno6tOpkRrnLF/lWH0nOE/QvkXGmmqTQdAWMDgl8EmZHvTVJLIQchyPH
	T8Blt9uhfHcsv4ZfuLuS3XDpZVEJrjZG+DFNFkjMIN+cytMcxg1hNDawUn3ZIXXWuoLets13x8L
	L7dothq1RqAIOZHPOqVrD5m3CEoUAZpkEi5Gb72o5B+C6nXXFetphCNp2Qt2RWecyZ+rkaBMLQt
	zzlJD4JUrliZ5fvsGBuLqGXiAy4xXD8k+FjJ/9ol0JAl5x1GhHNNx5uoGusEqs0l9Y9NTP+G5x+
	ellkd
X-Received: by 2002:a17:902:7c98:b0:249:33db:34b with SMTP id d9443c01a7336-25174374976mr39073055ad.42.1757222288996;
        Sat, 06 Sep 2025 22:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErgKrN3nawKeRdKJYtoByqaDG+aENeILCXOZaM7UN1gFx5Yj70HtS39XlJA3mnEHXugO/6/A==
X-Received: by 2002:a17:902:7c98:b0:249:33db:34b with SMTP id d9443c01a7336-25174374976mr39072895ad.42.1757222288607;
        Sat, 06 Sep 2025 22:18:08 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b020a7cb5sm146860015ad.115.2025.09.06.22.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 22:18:08 -0700 (PDT)
Date: Sun, 7 Sep 2025 13:18:03 +0800
From: Zorro Lang <zlang@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <20250907051803.t4av26vmf7zodzjl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>

On Tue, Sep 02, 2025 at 03:50:10PM +0100, John Garry wrote:
> On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> > The main motivation of adding this function on top of _require_fio is
> > that there has been a case in fio where atomic= option was added but
> > later it was changed to noop since kernel didn't yet have support for
> > atomic writes. It was then again utilized to do atomic writes in a later
> > version, once kernel got the support. Due to this there is a point in
> > fio where _require_fio w/ atomic=1 will succeed even though it would
> > not be doing atomic writes.
> > 
> > Hence, add an explicit helper to ensure tests to require specific
> > versions of fio to work past such issues.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >   common/rc | 32 ++++++++++++++++++++++++++++++++
> >   1 file changed, 32 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 35a1c835..f45b9a38 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5997,6 +5997,38 @@ _max() {
> >   	echo $ret
> >   }
> > +# Check the required fio version. Examples:
> > +#   _require_fio_version 3.38 (matches 3.38 only)
> > +#   _require_fio_version 3.38+ (matches 3.38 and above)
> > +#   _require_fio_version 3.38- (matches 3.38 and below)
> 
> This requires the user to know the version which corresponds to the feature.
> Is that how things are done for other such utilities and their versions vs
> features?

I don't like to use "version" to be the _require_ condition either. fstests always
recommend "checking if the feature/behavior is really supported" at first, not a
hard version limitation. Some old downstream software might backport new upstream
commits, the version is useless for them.

Thanks,
Zorro

> 
> I was going to suggest exporting something like
> _require_fio_atomic_writes(), and _require_fio_atomic_writes() calls
> _require_fio_version() to check the version.
> 
> Thanks,
> John
> 
> 


