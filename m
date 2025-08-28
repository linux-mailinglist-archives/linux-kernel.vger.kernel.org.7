Return-Path: <linux-kernel+bounces-789231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9550B39281
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29101C2249C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446EA24BC07;
	Thu, 28 Aug 2025 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwfHaePf"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5101C5F23
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756354627; cv=none; b=TogdObhUHpBD+sJ2BlHEyVjnlvGV3btbleuJqWisPAnML5MXYu1ccmB+7WcDWnieKEC3HXeXProZNvRLDb1QzxTefeFqqBtW1+AO7wJK0C6ddeSYtZ3Y0tksnYx9cLiigPnFOsQvNa9sZSGJaGjTGBipBHJvIQRT2g/i8Wgv3DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756354627; c=relaxed/simple;
	bh=aiRplx1VFpUgZxqodOSdvKPvN4pjIopwIYvOiNZITQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQ/abt+IMT+X3U7yEOX99ReHbt8E8qPf0GJs8KY72tlNNbaKLUFGcxqUculDaLulGUSQqsSpil84TLa4V0Aev2ppp3e4DAw1yPHQ4Kp4dzl6gBgTdYmvQ+rzeHfZ4bqxt2JbAnWvArpp6ILjQ/FP2iJkqP4LLHUfrxG8R5WpIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwfHaePf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-248681b5892so105825ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756354625; x=1756959425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMQVn8CrO16DsNUEv8ZI780aElTyTlwevDHE/l6d5V8=;
        b=MwfHaePfiRPgogmV9Rg4y+1zqBlotE6Z2qunWFEWOVRBp8txiokxJXSMylhiVtjaXj
         ouC5p3uw+FEMEhbJ0pgLGBCVenOudeO1rk3GLnO/LH1wgMtP3xGgUZUVMuZmnMMINTKf
         lUGaobEI5WyM3TSDFszAPN4uVBoPyhPI/mBu1lwhaw1BMXqj+P+5zfOYN5Z/E6joWevb
         Ez4Q/KSzVenoTHYlN2SNJFRf14YeX+7jk45g6JojKav/G5/JQ5BGWMGaIn/5ZJRIKRE6
         +Uo3J42SiBazkR39X/o5kdLvN9NftuuJmkWB1eqyCeN7s1bBAzZj3MzISiNJ2SibZ0df
         LGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756354625; x=1756959425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMQVn8CrO16DsNUEv8ZI780aElTyTlwevDHE/l6d5V8=;
        b=OyaXtX3/MRXj59pEMknD/VWP1aiZwGadMZSXdCrDoO8ZjmkxCkY+wuj6axSq/g6KIf
         ZgB7ORHrDPleKiiQ4L9gvWfp96Vi5DbrYUnzO6icEZK3GMaSa+nJW/X3UqLpb1nIKRYi
         wHsZAKgXQR8g4ukPWHZwBq0ik6lLoMMqLCpNjxFnrJOlhK4qhVlnYTKS7WqGU7yANyG0
         T6ePn4amsSNoDy9vW5EMlLJUXRpICDnoP+6OL2IKxIbAVbn5OhLttt/ALcV7eQgoGhuY
         jWX/WK/2lYBRsI+x9zpUlcpA2qPLD+rFCYPcoRYHiolBoaOHBOTw07kexGp+ltVsfkkY
         QG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVot3VNFwAyB2yDMAGORc78VuotvUic1LXhSIEg1L7G+cb6CGgUlhdPAHt5IZGxLDRc+QKE9H5JC3J9ijY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+H3KXE0ZhMbUJi19UPOjBKmRVfqYWyLR5ofCVXrjQq2BN7Vx+
	I35eAMmXbibiRmgnUyOvwmPhDHRsUw6JlC3gmmcFFqztb8mffZmlAVpGV0c9NULkTA==
X-Gm-Gg: ASbGncvL1ogAIgl/OAzbyD13W+twpZ3pu5t3LpBVqGMlbmaA+HpTDrjlWIs95J49EJU
	vDtA+WjUZ2rcFoylTw5e2tWlyckI/35qsdQsD6GoPlBf5lW3xIUpWFIgngMI8LgmpOBFx5jYefz
	78WsCUUALi1aSv/yzGtE0QasYsVqbH9cYzmMXTH/nH43DbQxjwOvNnttjCoK/kiEeIbjUMhpYjb
	gLjdVM6Z5rTRofIZYz1l/B8b1mTRg34ZeWEpRMa6M6sixM2EBB8vVsOpHWVCZ86mmHQbSUnUBEB
	dGf795NeJgXPcZdQENz0KEz0eInnkzd07pglbO9s8By0EBzpJUnLLk+oChRlocqkSsaxkdhUU8P
	zzswj8vE9U7+8/W+Dj/K+6JbSE1tG56BJteifBNCLOHHf+p2lMvfU4LNKlCVXcw==
X-Google-Smtp-Source: AGHT+IEScvfgJtRVasw57V/0vxqTUB7x4SvVvb5MS9koK0iAGjVijb4Cn9+NhLOy8EhFZ2odTZwOvw==
X-Received: by 2002:a17:903:1ce:b0:248:84b0:3fa7 with SMTP id d9443c01a7336-24884b054ccmr9171285ad.3.1756354624980;
        Wed, 27 Aug 2025 21:17:04 -0700 (PDT)
Received: from google.com (3.32.125.34.bc.googleusercontent.com. [34.125.32.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668864426sm136937785ad.80.2025.08.27.21.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 21:17:04 -0700 (PDT)
Date: Thu, 28 Aug 2025 04:16:59 +0000
From: Carlos Llamas <cmllamas@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	"open list:MEMORY MAPPING" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/mremap: fix regression in vrm->new_addr check
Message-ID: <aK_YO90AEgow_iQt@google.com>
References: <20250828032653.521314-1-cmllamas@google.com>
 <xpxoxn25fzhahdyvjp2vgmcnek6oot2hhvb5niz3tw7au46eno@cixyid6ywf27>
 <aK_V4sOUOIpEhFC-@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK_V4sOUOIpEhFC-@google.com>

On Thu, Aug 28, 2025 at 04:06:58AM +0000, Carlos Llamas wrote:
> On Wed, Aug 27, 2025 at 11:43:39PM -0400, Liam R. Howlett wrote:
> > * Carlos Llamas <cmllamas@google.com> [250827 23:27]:
> > > Commit 3215eaceca87 ("mm/mremap: refactor initial parameter sanity
> > > checks") moved the sanity check for vrm->new_addr from mremap_to() to
> > > check_mremap_params().
> > > 
> > > However, this caused a regression as vrm->new_addr is now checked even
> > > when MREMAP_FIXED and MREMAP_DONTUNMAP flags are not specified. In this
> > > case, vrm->new_addr can be garbage and create unexpected failures.
> > > 
> > > Fix this by moving the new_addr check after the vrm_implies_new_addr()
> > > guard. This ensures that the new_addr is only checked when the user has
> > > specified one explicitly.
> > > 
> > > Fixes: 3215eaceca87 ("mm/mremap: refactor initial parameter sanity checks")
> > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > 
> > I assume this showed up with clang?
> 
> Right.
> 
> The specific test that broke on our end was this:
> https://android.googlesource.com/platform/bionic/+/HEAD/tests/__cxa_atexit_test.cpp
> Although I'm not exactly sure how __cxa_atexit() implementation uses
> mremap() underneath.

Ok, here is the specific call to mremap() in the test:
https://android.googlesource.com/platform/bionic/+/HEAD/libc/bionic/atexit.cpp#197

