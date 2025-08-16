Return-Path: <linux-kernel+bounces-771968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E8BB28D50
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78D817E82F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D452857C2;
	Sat, 16 Aug 2025 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUaz2dG+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8A9460
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755342992; cv=none; b=Evw58b48KmU0yrlvBkRrz9J/9NQuhbTAMS2pwgwHwoHr27S5iNvuAC7pNUAoYo04UYqY7WmirSJTBhSFMCXV2K4fVQMMOnrOqITqsYXa9L3adSwIipWTA5lKyBd6MlEblU9g6bq9XRvix0j3RuWRQ7RDQ60HHGovWKw26hS4nns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755342992; c=relaxed/simple;
	bh=p+OQJdHRBzlxDexxQc8bsWt3RekR3nxtrLX9rgGs9d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQWEGy0o6/VWoIF3ZMS/biSaTMZ8b5VEdvP8xBn+cnr4n1XjRnI1JNvLCFV1NCN0eCUqKGo3pck492BsQdxYBDJJ7WLL7lOLYv8og3LuQ5DSbJUFJmqenBN6pC5KOB0efTUr5dicodI80z+4/ra6ZqRl+Qn0gslmLExhl4nuDFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUaz2dG+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755342989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9+qL3UxaFfrtgWhKmgO7weS5eswTNMs7xBKwQ0a2qNg=;
	b=OUaz2dG+XSA5d7cK0FQOEu+npO6Dumt3MUUBALBCt/w532VBXZILpsh1B6KnvdbChR9rwj
	cYalAvOuN+BvYBR1lSMLi5jL1nXPgy7wzXTuh4WA34+gU+vuf7EsBCPA3O2s5vOFrIVpmM
	ck6MKFt1hq75tw30fSl12wGcv4gPl7A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-kp76sKSIN2ek_Kr6D2swgA-1; Sat, 16 Aug 2025 07:16:27 -0400
X-MC-Unique: kp76sKSIN2ek_Kr6D2swgA-1
X-Mimecast-MFC-AGG-ID: kp76sKSIN2ek_Kr6D2swgA_1755342986
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9170d540cso1355927f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 04:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755342986; x=1755947786;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+qL3UxaFfrtgWhKmgO7weS5eswTNMs7xBKwQ0a2qNg=;
        b=sRT6PLuVuyTpGo3e/Np2wNbSDFAfzSRP9aDjr4+Dlj622kIYgm0g+tMFwbKDLnR8pj
         whA1K8i26v6sqgkzCV18lVfrnEPJ3CRqNcVFkQVUw+PZ2xCl9TzhqwoL25vCvzvqSgm/
         bZxzT1PkVpC6ratGyFfFpMXCGHn+dZOXZnzfWZiWW0YpKcVF9eOuLbpxMhXuaYSxGuTN
         mIPnUsusdOXMZhtcVldKm1c5aom1PGKEZKWQ91ymcnUuyYxKhzCeMFsBT+Lpm9mUEWIj
         pT3hBMvO1WqZJF2mIUH3OT8BiBrjp5Vo52vCs4KLQkEJzvaDr7wrMx3aP4rfLNRajBph
         ZCQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyWcJmd7aQvNi3/sbrAW6UmDcOvE1EyUkbsf7CT3/vFrkANV9/JMT/1P300gL+93Z8jdzOhybXkQQD8tE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4d7CcPOGFspzwoljJC83vC9397WatWqkkqS6FnJbukRMQKiLH
	qSs4YBXONUN+LN3piDoDa06bzlnjJqR48U30srBZL8XEKKNILdeM3PQQLBCgYxyJdzlKlviQmxW
	P9GnQv0hVM7MscZzT8+GSj3FYCjGzULwoWS2ZeGYVMKaxIIyp4E9n1rp6uaFEbDpqwQ==
X-Gm-Gg: ASbGncvYlSyaI+IqJSBW+BRTRwRTyxnzy96wwPGT0u7HzjCZ5OjEQY5sR/AqJrp3rS9
	CNjttsZqZRfl8MOP4BxrNtQcHmBzaEdHU/4VrgySs932NPwrEFJcF9iRo79m4TJlPn+o4CkEXj9
	Ce+RIo9HsLXZQ4Zt0XCbosonlZ3FOej26J+P0Lr38x/P+25KGJVMaF93E/w0VT9CQSW/3/jiwxK
	A99S4+MqHRIIhlqID+oifEXBFl4rhTOaSb6noZN+vHwtR0ADtI7K/ZOUCvuTnGFqjOyd+I9sdti
	qzgcE8gWOEghR0aUjZQV/1epKWEG6bc4a/0=
X-Received: by 2002:a05:6000:22c6:b0:3b8:d740:a16a with SMTP id ffacd0b85a97d-3ba508ec53emr8158706f8f.16.1755342986426;
        Sat, 16 Aug 2025 04:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCB/tq6+rH1afwsy5HF5LOvKBlZteXTvS85IvwsaJcRQSuivds13I3biPvIiVcaxEDU6JMqQ==
X-Received: by 2002:a05:6000:22c6:b0:3b8:d740:a16a with SMTP id ffacd0b85a97d-3ba508ec53emr8158691f8f.16.1755342986010;
        Sat, 16 Aug 2025 04:16:26 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73cf:b700:6c5c:d9e7:553f:9f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64e27843sm5427333f8f.19.2025.08.16.04.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 04:16:25 -0700 (PDT)
Date: Sat, 16 Aug 2025 07:16:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: SamiUddinsami.md.ko@gmail.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Sami Uddin <sami.md.ko@gmail.com>, regressions@lists.linux.dev
Subject: Re: [REGRESSION] virtio: reject shm region if length is zero
Message-ID: <20250816071600-mutt-send-email-mst@kernel.org>
References: <20250511222153.2332-1-sami.md.ko@gmail.com>
 <kgasjsq2s4pshravsinycfihdfjhdts5iz2fox42aejs4xqhce@frurksambnk3>
 <87y0rkie9l.fsf@alyssa.is>
 <20250816063522-mutt-send-email-mst@kernel.org>
 <878qjj8r2m.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qjj8r2m.fsf@alyssa.is>

On Sat, Aug 16, 2025 at 01:05:21PM +0200, Alyssa Ross wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Fri, Aug 15, 2025 at 09:19:34PM +0200, Alyssa Ross wrote:
> >> Alyssa Ross <hi@alyssa.is> writes:
> >> 
> >> > On Mon, May 12, 2025 at 07:51:53AM +0930, SamiUddinsami.md.ko@gmail.com wrote:
> >> >> From: Sami Uddin <sami.md.ko@gmail.com>
> >> >>
> >> >> Prevent usage of shared memory regions where the length is zero,
> >> >> as such configurations are not valid and may lead to unexpected behavior.
> >> >>
> >> >> Signed-off-by: Sami Uddin <sami.md.ko@gmail.com>
> >> >> ---
> >> >> v3:
> >> >> - Use idiomatic 'if (!region->len)' as suggested by reviewer
> >> >> v2:
> >> >> - Fixed coding style issue: added space after 'if' statement
> >> >>
> >> >>  include/linux/virtio_config.h | 2 ++
> >> >>  1 file changed, 2 insertions(+)
> >> >
> >> > Hi, I'm sorry to be the bearer of bad news, but since this patch my VM
> >> > no longer works.  The system is running wayland-proxy-virtwl[1] inside
> >> > a crosvm[2] VM, using crosvm's virtio-gpu device to do cross-domain
> >> > Wayland forwarding.
> >> >
> >> > Since this change, wayland-proxy-virtwl crashes with the following log
> >> > message:
> >> >
> >> > 	wl-proxy [WARNING]: Error handling client: Unix.Unix_error(Unix.EINVAL, "DRM_IOCTL_VIRTGPU_RESOURCE_CREATE_BLOB", "")
> >> >
> >> > I'm pretty confused by what this change was supposed to do in the first
> >> > place…  Looking at how virtio_get_shm_region() is used in
> >> > virtio_gpu_init(), it's called with a pointer to zeroed memory, and then
> >> > the get_shm_region() implementation is supposed to write to the region,
> >> > without ever reading from it as far as I can tell.  Why is the initial
> >> > value of an out parameter being checked at all?  How does this prevent
> >> > using zero-length shared memory regions?
> >> >
> >> > [1]: https://crosvm.dev/
> >> > [2]: https://github.com/talex5/wayland-proxy-virtwl
> >> >
> >> > #regzbot introduced: 206cc44588f72b49ad4d7e21a7472ab2a72a83df
> >> 
> >> Okay, just found that it's already been reverted:
> >> https://lore.kernel.org/all/20250808072533-mutt-send-email-mst@kernel.org/
> >> 
> >> Still, I'm confused how this was supposed to fix anything…
> >> 
> >> #regzbot fix: Revert "virtio: reject shm region if length is zero"
> >
> >
> >
> > Are you asking why was the patch applied in the 1st place?
> > It seemed like an invalid behaviour to me, and I thought it's
> > not too late to block it so we don't need to support it
> > down the road.
> 
> So you just weren't aware during the review that it's an output
> parameter rather than an input?  Should the parameter maybe be renamed
> or something to make that more obvious?

Sounds like a good idea.

-- 
MST


