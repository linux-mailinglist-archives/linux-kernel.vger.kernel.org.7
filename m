Return-Path: <linux-kernel+bounces-803498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E70B4609E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B17583606
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B792FB08E;
	Fri,  5 Sep 2025 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViVBARX0"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3333191DB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094463; cv=none; b=Z1opTmr5Q8SWoTct5RF7fFjPmtnvkqjuANlMSO7j2vyVduPD8RzrAk7PkOM2fGHb5ejssjQwp46j0Sbecjy6CY9MXo63pwS3fVUzYvuFOWPpB5XuqHBYI+p/BdbS+OSbSKbQkdlzccQBYaDj5GwkcasMyBqX1defR2dcPPpxIHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094463; c=relaxed/simple;
	bh=o34BmzkJCbWQe0X0lBP2XX3M2HpMngbM/yfmsu8decs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isegzeueQzgHeF+lxk08tUt0QOgvqCcZVN/WT3yln9gBbTkVSerkbXtNDxukVn8zqgFG52UBZIm630Oc7XLk9Gq4zyzLy6ymPOcS3+uqBZ6d4809YPG/FvK6ZpgNEhOZ+cccUCkfPowYi/S1DscyadfDXhhbhjGUPCVN2annGDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViVBARX0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7722f2f2aa4so3159573b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757094461; x=1757699261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iGdmOjhJX6hBoAVuN78EeIW768m+7wCUaHh9ZJvY08E=;
        b=ViVBARX0MYMdE5Zot3Zu6sAaLrHqUM1feMGkszDC3xUoHtlGPiKciiT2C/wi7XsZrs
         IZ1DIFTpJlI/qfy6g3zvfmg9U3G3FkYCg2JN76LIVVhrmt3ee1lTwUlM7AHCBmoYoW0l
         a3A19XC3fzEgeCYBaclxk77/kJUp16PatMlBvgYwuOBFkAFRjhhNOvQcafC1881nBq2G
         /cbIutfhn+RZyQ6m0OL+8jGREI9v8Jpqm6EK46LU9RoltPckFoRtNEyzXA1en6SH2lYO
         swRVOwnQmnflisEx+LZOphH7oojYQtghf94SwGcZQtJkv23iDWCdHTC7GnCYXKSnEiMU
         Butg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757094461; x=1757699261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGdmOjhJX6hBoAVuN78EeIW768m+7wCUaHh9ZJvY08E=;
        b=f6RFc+PH0se+HTqrUqu81eY79sl7bAaiW7a72n7tP3rUK4UEOmGTuCn6mMet1J3g00
         aH/VlOIxiwbiJwZRsi/InSyOwgbVviW9/G6YASKIx/1salge/S4uR9ptFY/n32mlspAK
         tvO9MPT0ykKmRoDKNZmD92cwYuGfTvUnbzP/6SBrOyt5SrsDlWkoYKk+Xtwqb2iFt1EE
         fum8lwN79enT4vlsEP0mQcAHPMK99D+urmN/huVuBrxe2dmGihghTkRWT4D39Jgf7nSN
         qK2q37kwTNnFUqFnwug5CjMmV1Ws5hoHp+qKhuFQda/wPgvrMIArL3ugrekpj4Y5AhLh
         /Biw==
X-Forwarded-Encrypted: i=1; AJvYcCWkvn7dJI3xIF0JG1xVrYE0Dyy3yK9Gt7roybdyUObEfDukRX/tfYMHpp9Ln37qd29AZWAku5UgzcVYWtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH6/VJTDYU7F35JhX8a5wfBAoCg/ceWoCHZsVA51GN/klEBk9J
	IMkQ9P/o1+4HRmU/Rq2jblrVts60dKYx1EnJVfy6nOcqpuSOAzzDyL40Ec4QkQ==
X-Gm-Gg: ASbGncsNKH6Zzmwfr3/VZAPMYoJ/u6HfIznYBOzZ70oQxfoD5vrwFWegqVkrrbKEEI8
	CiAEbmLQTZKxBVvvr2l5h+JYG0uJ6ppOaFq8CXsR0HZyX9Tnaco6JDmQpZM75tS/sYAg6624xz2
	W/asg3Agp4rPHUrjkb7EChydqagtil6QUUsZLNMU6xQNtkIOeYKHpp/jqCcXBp23vM6hv5y7IVx
	quI0BnT7qnEFqITW1UvRNirZDxtj17sq1kMZhKz+aUGb69/m2sX1Jow+kl4BgJ2IEnFGP6jJtE1
	QZHlSdWzv8mbkJ0XiulXsBKeAvZse5VcPCMF3znZddERQRFa9X9T89vVphi4mkeq/2TC8PWzO7v
	zu+55KHR3G1Ero+18GOjmhi11Ynl35wS+GpyfgU71r0tIgs3UIEROXvSFuy2wR08H
X-Google-Smtp-Source: AGHT+IHE2lRExnIyHB3Qcc28VDoQK8iZdwHIwmBowH0wlHh4c9ugPDIVctlxj9Nc+It2M+MIg5ro8g==
X-Received: by 2002:a05:6a21:999f:b0:24c:48f3:3fd2 with SMTP id adf61e73a8af0-24c48f34120mr9732610637.24.1757094461464;
        Fri, 05 Sep 2025 10:47:41 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm12010238a12.37.2025.09.05.10.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:47:40 -0700 (PDT)
Date: Fri, 5 Sep 2025 10:47:38 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: tag kernel stack pages
Message-ID: <aLsiOvvxhJnTzKO6@fedora>
References: <20250820202029.1909925-1-vishal.moola@gmail.com>
 <ea48bc1f-7ee7-48b4-b389-c3622fc4d3d1@redhat.com>
 <aLiGnSHFJdaTpMc-@fedora>
 <84297d37-b766-4cfe-9c3f-bff1cb3cb4a4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84297d37-b766-4cfe-9c3f-bff1cb3cb4a4@redhat.com>

On Thu, Sep 04, 2025 at 12:23:31PM +0200, David Hildenbrand wrote:
> On 03.09.25 20:19, Vishal Moola (Oracle) wrote:
> > On Wed, Sep 03, 2025 at 09:49:06AM +0200, David Hildenbrand wrote:
> > > [resending my original mail because it might have landed in the spam folder]
> > 
> > Ah, indeed the original mail was found in my spam folder. Thanks for
> > resending.
> > 
> > > On 20.08.25 22:20, Vishal Moola (Oracle) wrote:
> > > > Currently, we have no way to distinguish a kernel stack page from an
> > > > unidentified page. Being able to track this information can be
> > > > beneficial for optimizing kernel memory usage (i.e. analyzing
> > > > fragmentation, location etc.). Knowing a page is being used for a kernel
> > > > stack gives us more insight about pages that are certainly immovable and
> > > > important to kernel functionality.
> > > 
> > > It's a very niche use case. Anything that's not clearly a folio or a
> > > special movable_ops page is certainly immovable. So we can identify
> > > pretty reliable what's movable and what's not.
> > > 
> > > Happy to learn how you would want to use that knowledge to reduce
> > > fragmentation. 🙂
> > > 
> > > So this reads a bit hand-wavy.
> > 
> > My thoughts align with Matthew's response. If we decide "This doesn't add
> > enough value to merge it upstream" thats fine by me.
> > 
> > Otherwise if we think this is useful, I can respin this with your
> > suggestion below.
> 
> As raised in my other mail, I assume there is no way to just have any stack
> pages in any kernel config marked appropriately (slab allocation
> discussion)?
> 
> If so, I prefer to not add it.

I agree, this shouldn't be tied to specific kernel configs. We can leave this
out of tree.

I didn't know a page could only have one type, and trying to handle that
doesn't help explore what we're interested in right now anyway.

> If there is a way to just make it consistent, then no strong opinion from my
> side. Willy is the page-type guard :)
> 
> BTW, I was wondering if page-owner could be useful instead.

Thanks for the suggestion, page-owner looks useful for playing around with
different kernel stack allocation methods :)

> -- 
> Cheers
> 
> David / dhildenb
> 

