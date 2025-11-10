Return-Path: <linux-kernel+bounces-893129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 576F0C46982
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF82420AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C03830B52B;
	Mon, 10 Nov 2025 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c93jGTUQ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB2A18626
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777525; cv=none; b=dA5ZUa+RQMhPMQSz651H8w3ZMZOdPvbR4p/xdrbIp5qmjOB4jm9wgQIdq5ljDxyEhhtmoYa38AV1u8486gZCJQwqpet1LeFHqW5D5RkKqnWkfxQjRahKDH7z/Kg2190NoqJVLYbUU9WyS0bYNTBG/Q/GDudoNor78OHfIPLPhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777525; c=relaxed/simple;
	bh=yKWNhJc0NCCYA8zjMOH3QEEhuWZljyQXcQSfuMODHe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgCUcn7ke/Y4DxH1iW1f0WyfFukPj8Y550WmbSUtp1VaNNOcs/kBT8msYTTQcTiwZX/aVLviseoHU/5jNFhFqFFA9jxJ8qfLCIfE/ZBFPKlU9ki+2NuNH5nXsmEyM/aKs0vUdXcLiPlrQ+aKv8l8OCV/PlS7mxc985eOh5sfhXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c93jGTUQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso1134052a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762777521; x=1763382321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AdI7IxF7cmaOwwPz2uPN9pz51vkfzTah0Iexytj/exg=;
        b=c93jGTUQLNsvGt5jexqNPPi3uEH9qXGrOuUBu58yE+JTRqflbj53dmr9ifzHGsaOd8
         rN7t0rvLX+G4Kdb6S+7pxeXpeVNAdWCqhaoE0VXWkv3bk3JwZmcH5OqRl+JV7cuNycEm
         IagQDSjmfQ6gsZIwx02+xTnrFn3ghxrugM4SVAGZwdjacGjldRhriOkO0nKL18jmjy+r
         o/Q2k0/DZCWnNATcnzV8P9TijQLst11BKQfzWrSA2I59ewlZxnkZuzuOALhl/KBKvEDN
         3I7atanfWjz6hcnMq1/BmPFUPEQcTTNB594icUBPtwYf3IbKWdmVS5aTmE10apvNcN06
         ZlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777521; x=1763382321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdI7IxF7cmaOwwPz2uPN9pz51vkfzTah0Iexytj/exg=;
        b=cxeSKiVJnC7WOi0dTUO8sxYztQstpZhn8TkFBr0Qy+Iud/kNItiJo248i4SqFAmfo6
         1vFrMSUsTqnkVah9J+3Gzn+rTfmL6k5cdJgou7H0enqYm56ziFFCM9BGqMSGAeeU5nf0
         6UiiHNKCAs3Eckfj+7SHNOJvJRJRPUjSHF/YFqqz4aEGK9zb6BEfssxHEkzKmpRUVAkc
         5AnWqonq+JvAKCSPBQ2gCHLt7fhUjMNm2h5iTGVzzO64IQl7aszSFAY3B8mWc7ji8qvR
         5ylJwYa0WoHo2roIqe3bdtWwdqTs9563jrq3sQCBG4uOpFfmm7unS71STOJT5MfquGSr
         BoYw==
X-Forwarded-Encrypted: i=1; AJvYcCV/lI/Vb736sdSIaJm/WdD2G3QxcwjsQWPIz7sZCFHpvhSNqsS6TeF4lL6Dqm4KaHAm52llNF/WRRxH3GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeeRZGfZr41TWj9TK0qhDeof5uF3i0UGZrSSTwbE0LQ9QGFQRV
	M9fuC3H4uS+WxAx9hl6XtlGAaf60Qi5Gdmv/0MK3ik/LyUQFJ5THRWGMBN3aPblH9uk=
X-Gm-Gg: ASbGnctei2mWq6ZmFpit9I3jlgQ+A3+GSrb5i7ZIjo+x5gIm/VBqQy5DXEOoMFYKkHz
	iGHbdkBLo2YemeBfwmjFiqkInxK9lXh0Rghdl6Fvuoay4347ZYN1DcdKglaHFVCx4aO5r2F5OzW
	VNYUw+pdJQDMzN32fWwWlWDAUbhsprf2ZkPsAuoJCa4d3Z0u/qJiYzko0CU5tdDhB2M1UlhSRKk
	M07uvobqGJIOe7JFZIs3vTnOk5GKeXR3hNWo1ncFSWQq3M/gSnFRVXfzca3+S5AsQgcLn/omlex
	z7j6rTpV4l3Qgi5syctvkFBYtDwKI872gkg27LVW85Do5xwZB3JmmXPUhR5DNFmLCJXmOkcNubo
	sNhXQz3TgkUgragkOiZNjbY0z5fPyyR6ANdg7at1PqlE0JSL1mZLneBYiMfeiMfKdWOECs4xJ/y
	uBel4=
X-Google-Smtp-Source: AGHT+IH45M4martpu1ZV9EapqxF5z1Rmn3ab4L1EkLdaCAIViHu2tcBKPEF2r4oHemmDEAtCuQt94g==
X-Received: by 2002:a05:6402:27cf:b0:640:825e:ae82 with SMTP id 4fb4d7f45d1cf-6415e80a83bmr5792863a12.29.1762777520696;
        Mon, 10 Nov 2025 04:25:20 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813bedsm11054476a12.10.2025.11.10.04.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:25:20 -0800 (PST)
Date: Mon, 10 Nov 2025 13:25:18 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	"amurray @ thegoodpenguin . co . uk" <amurray@thegoodpenguin.co.uk>,
	brauner@kernel.org, chao@kernel.org, djwong@kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH 0/2] printk_ringbuffer: Fix regression in get_data() and
 clean up data size checks
Message-ID: <aRHZrgMXUeMMY_gf@pathway.suse.cz>
References: <20251107194720.1231457-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107194720.1231457-1-pmladek@suse.com>

On Fri 2025-11-07 20:47:18, Petr Mladek wrote:
> This is outcome of the long discussion about the regression caused
> by 67e1b0052f6bb82 ("printk_ringbuffer: don't needlessly wrap data blocks around"),
> see https://lore.kernel.org/all/69096836.a70a0220.88fb8.0006.GAE@google.com/
> 
> The 1st patch fixes the regression as agreed, see
> https://lore.kernel.org/all/87ecqb3qd0.fsf@jogness.linutronix.de/
> 
> The 2nd patch adds a helper function to unify the checks whether
> a more space is needed. I did my best to address all the concerns
> about various proposed variants.
> 
> Note that I called the new helper function "need_more_space()" in the end.
> It avoids all the problems with "before" vs. "lt" vs "le",
> and "_safe" vs. "_sane" vs. "_bounded".
> 
> IMHO, the name "need_more_space()" fits very well in all three
> locations, surprisingly even in data_realloc(). But it is possible
> that you disagree. Let me know if you hate it ;-)
> 
> 
> The patchset applies on top of printk/linux.git, branch for-6.19.
> It should apply on top of linux-next as well.
> 
> Petr Mladek (2):
>   printk_ringbuffer: Fix check of valid data size when blk_lpos
>     overflows
>   printk_ringbuffer: Create a helper function to decide whether a more
>     space is needed
> 
>  kernel/printk/printk_ringbuffer.c | 40 +++++++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 7 deletions(-)

JFYI, the patchset has been comitted into printk/linux.git,
branch for-6.19.

Note that I have updated the Subject and a comment in the 2nd patch
as suggested by John, see
https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=for-6.19&id=394aa576c0b783ae728d87ed98fe4f1831dfd720

Best Regards,
Petr

