Return-Path: <linux-kernel+bounces-898241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FE3C54AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B9C3AFC1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491E02E762E;
	Wed, 12 Nov 2025 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YTZQqEPi"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B032E6CA0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984622; cv=none; b=s03O48WDrRWYRgYL+NWeUSkwlGrFGP6IndPcIWLz0lu7PRrkHzX4d/tDEc0KTL0VOJE24SSG2Rll3w2J8QFdY3RPLm1qV8woOS/QzCzIVo4pMeTknpTfZCHN0PnzxX2CK1LjNj+F0X/iu82KsrOOQOjW04OkXqDDFEPW5OzBDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984622; c=relaxed/simple;
	bh=0OTFUF8dKlxaDdn36rkr2KB5xF/wOSqhfWxtBGzWaxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7CTnlVcl6n19Dew4R8UD3ekBrikpldhUC7ii7QHfUWLLbLvSCScnKre8XbPuUg+Nr4RpJV4jeqJjdRRsRywT0VAlWkbzaYcY9sXmEijxxmfEtx3sgN0BH1JGUyF8Caw2Uf+kSBHSUcqx6yVCL3iO4eA/ga//6BIP85MV+IUOP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YTZQqEPi; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b99dc8f439cso68696a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1762984620; x=1763589420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UtzYm6CaQwwng4XDexAXOIVM2T8jYsSpOQI11uV7cIk=;
        b=YTZQqEPiaS/si8bOxnMCFdjnMaTXToGa+627P0ihXde9THCYTRabrnR046dIV/9vpK
         /xGW+/fpk3Ayxcxslmwu8IskYnDVZNHuoz9XgU1oKhwcgEecoUEg0CDvUWsiwQ9QhrD6
         qLzuJ3lhLMCeBg24li73qvZf9qJVTZEH6YQ5QfO7ag9GmeW0S553HICngVx2EtmTy1Zd
         W1TXGld4qghxcGaaLTfm/yqBFdwe9/CMI34rzzA0dL6ygouoq7/eAotojbh3vs493UHc
         P/Yptk1U+JYikQORa3NX0S9xOGe2j4bmELyr8Eqj4URJvRyHBtGASEtlIQxNcDPAl4zc
         Shgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762984620; x=1763589420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtzYm6CaQwwng4XDexAXOIVM2T8jYsSpOQI11uV7cIk=;
        b=dmbUhyw+xh9Zxk994S966oTIVNbG68hhYPUAuYXc5JizXf1yR5MzmLDMuXJAecfRWa
         cXCm52vGpj+ijHc4nwBa8BRwbpxzI5uUV9otDQXrVM8hbU8vlHUo4XeUhbny52y92lNM
         DRLirLaPo7AakJBtBSWwdc/BzEQP/60PYivYG7bB2+wyGrfIaRkSM4HIMQDL4bPIfv4Q
         POBS4Zb1JXX2IWELfvb0xCMHIwMykPVty3y0ygOWJ/TOkJr+PhqKqON0jpi/eOdzw/mu
         j7OahlWDFOWHnkQWxS4u1lH31UtekSHXmoa/K25EzKDn8Yyn7mo2szYDIuuczsX41k+d
         R+Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXsqFvVqd4hE51zl5OA5vM2UJYPqYbzOeCl6hFpdp/r1FCgelZtpVtXl339AzwvnI9bF4HGgUb+S9M8Qxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy23XzPozN6ekR3ikfx6Lhdz+9XTe9SShNrG1rBS5DSe4wLe6nJ
	20XKj96eViqvuOXyFsd8isbWEUZ4Mb25F1vS8AaB8mFTuThLWiPEyjjlyc3K3k8iGA4=
X-Gm-Gg: ASbGncs7zPNmFWyI8ePikHmeUG4+Eq9monRhPg2E9iW/eExHG+bdxaXxcU6DTXZ/Mh5
	y9wS005RgjWWddOxEJfOPi+VLmnOND5513cU9dn06mgd1L+V5XmP45BEgXVad4bmkjLJZlDz30M
	oeNHSzedB9xQKOt88H6f0qLsMtxNkcaW1XjHjGOq3F+reo0dtL7emTXF6IcojALNIkOQL3+sGL0
	mhQpUs+t6Zj67bviSjcDNBfB5+VpNtDtZiX7JQIMzGaUSWxOwsITY1OfKA4JxAbqqsHSg8/H2if
	CxFMxVZn+7if7vysTaeMHhb8C9PS39UQ88E7bwptvr/8a6yQJkCQ6jfunoO46J2Eb3zTc2CIdU+
	sfB+Eas8xDmTYmrK2AECKrtCBQDodTs3xPrXvFvYhS7a+dWheVfEV50vdBLlxGjKHtdZiRwTXVD
	ccRxONoiUlYQc+JkAKhPf2SUchXCgx+FK5y4rvjqEUMw6U91MgMM0=
X-Google-Smtp-Source: AGHT+IGGcSgtma54hv+7RKzmUmjycRVqw/LnJDNDCrdXo50noFmBCjb2IbQqtC0Ft6zra7BT9FpOHw==
X-Received: by 2002:a17:902:d4c3:b0:28e:756c:707e with SMTP id d9443c01a7336-2984eda94d4mr56523225ad.33.1762984620190;
        Wed, 12 Nov 2025 13:57:00 -0800 (PST)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccd1fsm1507945ad.110.2025.11.12.13.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:56:59 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vJIpk-00000009zCe-0KVQ;
	Thu, 13 Nov 2025 08:56:56 +1100
Date: Thu, 13 Nov 2025 08:56:56 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	ritesh.list@gmail.com, john.g.garry@oracle.com, tytso@mit.edu,
	willy@infradead.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
	martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
Message-ID: <aRUCqA_UpRftbgce@dread.disaster.area>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762945505.git.ojaswin@linux.ibm.com>

On Wed, Nov 12, 2025 at 04:36:03PM +0530, Ojaswin Mujoo wrote:
> This patch adds support to perform single block RWF_ATOMIC writes for
> iomap xfs buffered IO. This builds upon the inital RFC shared by John
> Garry last year [1]. Most of the details are present in the respective 
> commit messages but I'd mention some of the design points below:

What is the use case for this functionality? i.e. what is the
reason for adding all this complexity?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

