Return-Path: <linux-kernel+bounces-816718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0346B57796
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5439E445C10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0361C2FE59A;
	Mon, 15 Sep 2025 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axVjefPK"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BECB27817F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934146; cv=none; b=hSqHfvZaQvO+tI0XKgFfOKzuvmIJCyULpF6/Ccv1ZMxdLX8qd3rZTgLkvziUdBnBhlAT9wlewWUAstqG+eRpTnLTofDGuSu6sUeC3ptIY54p0lZEJuG1PxTM/E78S3mO5Si+kXmhcVhnSvbg84odKhEvv1i7zF5SyANGbOI1/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934146; c=relaxed/simple;
	bh=XIqiNT2sHtXXqO7bDWtyq5tUgQTZFwmYR1nBxZAfn54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHnrljKxWp2m9FF/lzfgDhCOdtMuV4e85sB476MFVTb/geYXgtF/IVJ185Sq8Gj+7q+K2HsvC1sUnuF9R5HHDcVwOlPvocl71xAHP4yAApFhPYGwBTfSOWEn8CpuOJYiIJ2B3GXuf5x7Ap4egT9u6sqo3CWiViWTC80xYDv2DIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axVjefPK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso24587305e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757934143; x=1758538943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09G9j06MNZe+y/tjN1dT5p6DESHL0gAogtQXwPWBuqc=;
        b=axVjefPKj4tOvhT91CKOdRdPZW2l3KdbAH3/3MuTH1f8FXID9F7K48o6IC/cIEGaK+
         8IlfUidH2+Qj52+VhNAGVwMu58/9Ac8vknxKa9MknwYbZRXd0z7aSz5u6+J5ReeHCJ1L
         eaydxAnPSmTwlQfIySkWd8HVIrBrvqr6WITvYgbyAST0FRTfIIbZgt4EKvgm8r9Yo3Gd
         cf1pPbOtTQ3uxWaqCm79mVa4Zh0E+ocORL8wmynX1R0cDDWMv1ImXghE/Nbm67cs6LRC
         qtM51wwyGCpFvKKk4iQuhlMmhWXM7K0ea3YW5M3Y9HQT55g6CKqMyq9KbKa9K9h199Qr
         o7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934143; x=1758538943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09G9j06MNZe+y/tjN1dT5p6DESHL0gAogtQXwPWBuqc=;
        b=FI8+Akh8zsSg/EPaJR8SBqK4cog9bzGPHdYp9nLaUL4T37g7wXxeMKnDeopLAwYFl6
         YqNcKrAvY5tngGpWkUH+4fi2sZUhA3bl34nm5hIBLkZzls9RLzHaizWlDb/iMs06QsGJ
         eVltDGRPuufwHpmvkR8CdcJleUt17C6R9LjOafobb8/iZA71MPVTBqAa/F96w7/+ZxZM
         sdW+UxUxkuIK5cSE5Kp5NT6maSBag954UgTsPDG6SuoMHUhrkds5LK0cm9tZWJZSuAKk
         BWD+JGCCFdK7hGF5kzbTubWnqkqQTYdJ0sU7PP/DgzhmmtL7kxk9sAcfmS4S7Oqe5Jij
         s1sA==
X-Forwarded-Encrypted: i=1; AJvYcCWbX3/ly58DXRCujDroUzdLhYk37uIqNkp/pg3qBvBP9ybI/5cfZNwzOadsJS1ZX3kLS0gJymH5/tOipek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8A6OEmLJnzriI1b3VjWE5oySfHni3HRtgJXIL1puQdEBU7q95
	RerUUxGujlMK8xOroFW7SqYCE6R9HLgIWpFY7T4+B6b92BjgbarEnsdt
X-Gm-Gg: ASbGnctULHeNbW0+52wxLgqumrcasWXnkIA34fIf5c2OyUL00PSpkSixtaqoEbpGgKZ
	JIolX+2nc7eGaMMa8h978pM/WMuk8YXclM5idv2fuYh6FKK4SgsMIQaG2/A1vNlmJakvHGtZMOS
	I52/jR6CNX3nv7p4QuVjfXZbkXN9mh605frH/vaIQ5xqcUZvHFYPIx5zr9CXdRoOXe2+QR1CxHl
	0ap5XXs70z1Tlj9qb7VUz6Dy2pRGtder2V3ldX4POAwmJyj94EKnCxXdT0tOoO/cepv9hAQfCww
	DdszAqMBd8sBzmoxeH68UFVYumDg0133AABOD96bnuA7LkwpC8632cUtePxx3An28TOcECPcSp1
	EXOUvVTq3/aLbFoZ//JYNSxgUjBqfBwCvxmtI9DY7CSxWlzDn9W1bv8j6zIdA
X-Google-Smtp-Source: AGHT+IEGWi7WSzkVoFDGqX2MXPtsSn7cc9zia88pj05NLpV/q+zlVJHp4+lOIa9wC9pExz4PmhCy3A==
X-Received: by 2002:a05:600c:58c1:b0:45d:e0d8:a0bb with SMTP id 5b1f17b1804b1-45f21214d99mr76359545e9.23.1757934142746;
        Mon, 15 Sep 2025 04:02:22 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e900d8f0e9sm8457904f8f.35.2025.09.15.04.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:02:22 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:02:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Guan-Chun Wu
 <409411716@gms.tku.edu.tw>, akpm@linux-foundation.org, axboe@kernel.dk,
 ceph-devel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
 home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
 kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, tytso@mit.edu, xiubli@redhat.com
Subject: Re: [PATCH v2 1/5] lib/base64: Replace strchr() for better
 performance
Message-ID: <20250915120220.6bab7941@pumpkin>
In-Reply-To: <aMfFOoQIIdMkVdYl@visitorckw-System-Product-Name>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
	<20250911073204.574742-1-409411716@gms.tku.edu.tw>
	<CADUfDZqe2x+xaqs6M_BZm3nR=Ahu-quKbFNmKCv2QFb39qAYXg@mail.gmail.com>
	<aML4FLHPvjELZR4W@visitorckw-System-Product-Name>
	<aML6/BuXLf4s/XYX@visitorckw-System-Product-Name>
	<20250914211243.74bdee2a@pumpkin>
	<aMfFOoQIIdMkVdYl@visitorckw-System-Product-Name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 15:50:18 +0800
Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> On Sun, Sep 14, 2025 at 09:12:43PM +0100, David Laight wrote:
> > On Fri, 12 Sep 2025 00:38:20 +0800
> > Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > 
> > ...   
> > > Or I just realized that since different base64 tables only differ in the
> > > last two characters, we could allocate a 256 entry reverse table inside
> > > the base64 function and set the mapping for those two characters. That
> > > way, users wouldn't need to pass in a reverse table. The downside is that
> > > this would significantly increase the function's stack size.  
> > 
> > How many different variants are there?  
> 
> Currently there are 3 variants:
> RFC 4648 (standard), RFC 4648 (base64url), and RFC 3501.
> They use "+/", "-_", and "+," respectively for the last two characters.

So always decoding "+-" to 62 and "/_," to 63 would just miss a few error
cases - which may not matter.

> 
> > IIRC there are only are two common ones.
> > (and it might not matter is the decoder accepted both sets since I'm
> > pretty sure the issue is that '/' can't be used because it has already
> > been treated as a separator.)
> > 
> > Since the code only has to handle in-kernel users - which presumably
> > use a fixed table for each call site, they only need to pass in
> > an identifier for the table.
> > That would mean they can use the same identifier for encode and decode,
> > and the tables themselves wouldn't be replicated and would be part of
> > the implementation.
> >   
> So maybe we can define an enum in the header like this:
> 
> enum base64_variant {
>     BASE64_STD,       /* RFC 4648 (standard) */ 
>     BASE64_URLSAFE,   /* RFC 4648 (base64url) */ 
>     BASE64_IMAP,      /* RFC 3501 */ 
> };
> 
> Then the enum value can be passed as a parameter to base64_encode/decode,
> and in base64.c we can define the tables and reverse tables like this:
> 
> static const char base64_tables[][64] = {
>     [BASE64_STD] = "ABC...+/",
>     [BASE64_URLSAFE] = "ABC...-_",
>     [BASE64_IMAP] = "ABC...+,",
> };
> 
> What do you think about this approach?

That is the sort of thing I was thinking about.

It even lets you change the implementation without changing the callers.
For instance BASE64_STD could actually be a pointer to an incomplete
struct that contains the lookup tables.

Initialising the decode table is going to be a PITA.
You probably want 'signed char' with -1 for the invalid characters.
Then if any of the four characters for a 24bit output are invalid
the 24bit value will be negative.

	David

> 
> Regards,
> Kuan-Wei
> 


