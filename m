Return-Path: <linux-kernel+bounces-771926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D301B28CF4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E201B64C13
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA4C293B5C;
	Sat, 16 Aug 2025 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bddQ7JUF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17D28C852
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755340587; cv=none; b=s7knJtAKsE3zPg8qeIMrOKLPgGGPzO1ICAf3anUYGqBP84KjPQ1TAAHjq9UHtdDRz8VWGrmNDcyeKNCZF/FsvZaOc2xuiLrBfHANSNnbyfm/BxnS4+NQCvxCn4lVmY+/cto5+rxahv9u0y8799pW3usIsfcCyX+Yr6anI7U683k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755340587; c=relaxed/simple;
	bh=EYfRYy1z92ajS4ke1U1qfeBzLYzlyxCzubIJ3/OY6bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OS/kXNoTrz4oLCPasc24dkRXl9OplqTBkqtwd0RXvUS2jCySwXE7VIqWZgw6EXktMvZmgLrnMwtSEP9i4bwrCgIW7/LCr1wK+aXxEEnem/JEt6LeI7pF19N5knnGSIeGkuo3ukF3Yy07HY7bzUGtyF/aas3fV0LgTSpltf3i+Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bddQ7JUF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755340584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8kpb4zYqo4EMmVx2Xny+4AO4zuhFI4D+a2JoLHbhIs=;
	b=bddQ7JUFQ5QD85Kt9P2FeWLty2Uck6PEqmOpr0fEgFoO+a26T4pqgDwdfjeibAcpj3RCG6
	vEgD80IG0Xv/bNdMAnaeAfhYZATaV7MyotMnnKMmviXrUHKqgW0UUOz08Qrg7VoYpzcAx/
	950FWT6RgcZQTNWdwIM5rU454OaZrVM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-e4vK5wJEPSKmDw9oeqGfqA-1; Sat, 16 Aug 2025 06:36:22 -0400
X-MC-Unique: e4vK5wJEPSKmDw9oeqGfqA-1
X-Mimecast-MFC-AGG-ID: e4vK5wJEPSKmDw9oeqGfqA_1755340582
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9bfe2c601so1529823f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 03:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755340581; x=1755945381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8kpb4zYqo4EMmVx2Xny+4AO4zuhFI4D+a2JoLHbhIs=;
        b=WxkA3zO1hI73aziMWXpnwtqQD4eITPGO11Zy25NHA9sd2jqvR0mD8CXbukVPmwvbdT
         1++myfesU5vjRt3xztH9Y4E+skkkXzQx8HZvLKaYSGQlXgTnGjm813A6QMs5aLrhFWLC
         uZ8CdrQsuMQ8+MfdWLVFgTMfNMx8aXc8CngHAJBd8vUnc5WkAH/ItGe+8zwY79lv1mUd
         5hT52uRR+r39VlkSF6T7q8yBwjrTTy0ohtADUBo2z5FwYMwmdjj8ip0xWnL6mN+A2CuR
         fojx9N0wgtKsbzB7R1LBLPwfT+XeGcbxKNfl8X18uj0A/RG+fFmqeZvN0c+rSxZ1l493
         HvvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9ov30vbekKwoQS2k2s+bFmeX0fkkT0o2T+U2ShMqkBy8pJ1LMdc7V73A9SL24wHfiGM5wgsTDmSNwm78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNWMCiJ8uuxiS2497823R6XEUqslEyxrxmtdiX/Qq5qQ43/6d
	oxzrPE8sK9J+hOhsq8azFt4oaqJRa4p6jfCy044L0DRZFoQOKOLyUNXyZ/wjYhbhcoM5OokdmCQ
	NRzfg9JKdXxFgTOfZ3blH/OgP3SlBLT1tjY0Bx7n/jpm6VuVtvvxpgbaTRo97/eBL0g==
X-Gm-Gg: ASbGncvKXyDsZgFu15JEIPPnN6Ls2UaNYRPG6f1ENq6yYth3xMALNkQA31QxA8nXHEs
	Sglv3vNmQ23aCU9vktMS47ecGprQJaUElmBseX1pgqnTFOhfovXkI0/z37zMkV+yf0Z6GLzG7iu
	o6lYRiDQKy+Md1PxcUqyOC+IOAgK6upJKYA7Qx3NOP2ygUMRp7N2MK9YWXjUB/msy95IbikBNSr
	9btTRm8J9rpFlWEEtSTm+fMVijQuWncxYfExvjBvzKI69k9D+M6YjkBdbxGpciWRW4Y/o0vEwzB
	GnMQQP64/4yrGVLZOtftlS1OC+NPcKKv/0A=
X-Received: by 2002:a05:6000:4310:b0:3a5:8991:64b7 with SMTP id ffacd0b85a97d-3ba5093b77dmr7934607f8f.26.1755340581479;
        Sat, 16 Aug 2025 03:36:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhOaIvnCh51kO1M3yudZ1Zco2KV8bF2xaTDUF4+BRWU8NLMhH+ezyI4LNzBjTWj+A0q+/Xgw==
X-Received: by 2002:a05:6000:4310:b0:3a5:8991:64b7 with SMTP id ffacd0b85a97d-3ba5093b77dmr7934596f8f.26.1755340581068;
        Sat, 16 Aug 2025 03:36:21 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73cf:b700:6c5c:d9e7:553f:9f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64d307cfsm5181464f8f.18.2025.08.16.03.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 03:36:20 -0700 (PDT)
Date: Sat, 16 Aug 2025 06:36:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: SamiUddinsami.md.ko@gmail.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Sami Uddin <sami.md.ko@gmail.com>, regressions@lists.linux.dev
Subject: Re: [REGRESSION] virtio: reject shm region if length is zero
Message-ID: <20250816063522-mutt-send-email-mst@kernel.org>
References: <20250511222153.2332-1-sami.md.ko@gmail.com>
 <kgasjsq2s4pshravsinycfihdfjhdts5iz2fox42aejs4xqhce@frurksambnk3>
 <87y0rkie9l.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0rkie9l.fsf@alyssa.is>

On Fri, Aug 15, 2025 at 09:19:34PM +0200, Alyssa Ross wrote:
> Alyssa Ross <hi@alyssa.is> writes:
> 
> > On Mon, May 12, 2025 at 07:51:53AM +0930, SamiUddinsami.md.ko@gmail.com wrote:
> >> From: Sami Uddin <sami.md.ko@gmail.com>
> >>
> >> Prevent usage of shared memory regions where the length is zero,
> >> as such configurations are not valid and may lead to unexpected behavior.
> >>
> >> Signed-off-by: Sami Uddin <sami.md.ko@gmail.com>
> >> ---
> >> v3:
> >> - Use idiomatic 'if (!region->len)' as suggested by reviewer
> >> v2:
> >> - Fixed coding style issue: added space after 'if' statement
> >>
> >>  include/linux/virtio_config.h | 2 ++
> >>  1 file changed, 2 insertions(+)
> >
> > Hi, I'm sorry to be the bearer of bad news, but since this patch my VM
> > no longer works.  The system is running wayland-proxy-virtwl[1] inside
> > a crosvm[2] VM, using crosvm's virtio-gpu device to do cross-domain
> > Wayland forwarding.
> >
> > Since this change, wayland-proxy-virtwl crashes with the following log
> > message:
> >
> > 	wl-proxy [WARNING]: Error handling client: Unix.Unix_error(Unix.EINVAL, "DRM_IOCTL_VIRTGPU_RESOURCE_CREATE_BLOB", "")
> >
> > I'm pretty confused by what this change was supposed to do in the first
> > place…  Looking at how virtio_get_shm_region() is used in
> > virtio_gpu_init(), it's called with a pointer to zeroed memory, and then
> > the get_shm_region() implementation is supposed to write to the region,
> > without ever reading from it as far as I can tell.  Why is the initial
> > value of an out parameter being checked at all?  How does this prevent
> > using zero-length shared memory regions?
> >
> > [1]: https://crosvm.dev/
> > [2]: https://github.com/talex5/wayland-proxy-virtwl
> >
> > #regzbot introduced: 206cc44588f72b49ad4d7e21a7472ab2a72a83df
> 
> Okay, just found that it's already been reverted:
> https://lore.kernel.org/all/20250808072533-mutt-send-email-mst@kernel.org/
> 
> Still, I'm confused how this was supposed to fix anything…
> 
> #regzbot fix: Revert "virtio: reject shm region if length is zero"



Are you asking why was the patch applied in the 1st place?
It seemed like an invalid behaviour to me, and I thought it's
not too late to block it so we don't need to support it
down the road.

-- 
MST


