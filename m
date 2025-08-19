Return-Path: <linux-kernel+bounces-774864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AF1B2B884
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92946562013
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D9630F54E;
	Tue, 19 Aug 2025 05:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5RjcTl7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDADB261B75
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755580238; cv=none; b=roXl+b/8lsbKEP+jKwnnJTviX3Z5NRa64dh3dBGjiH9zTuG72D7ULPva8CO1zCgVzMBR+p0PriwBV13icNU/uT8de8n86b8uQNkl3IKjGasOkjUtibGRUFlUaitJbUJU9VZDUHhRERQiwgKUK7UvAiWrKJSXr+cYa3ogpeA/3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755580238; c=relaxed/simple;
	bh=URETRUUnf5Nf4QLwoBwTW7sh1xhwroIB5KhjlsfYNrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUFV4UCtud53DtIbuNXELVzwg2sUaHmvMhSrRwcMr3aGu/e0PKCaf3tVN5VKKPuGVi8bG0aAOfgUC5eJVBYMIOFUMfw/EUx+d1lXpSCDSyRsF4NLiXaNUddhmlxOUKGMD2z2P2kUtVHFRgpb1XA4LHpnd/cNNDM2S3Htf3tM+bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5RjcTl7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755580235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcMWmSwQxQAwGftbQEwa8JZHokvZ0U7fwYMtmA0OKvY=;
	b=F5RjcTl7DVqUkdQMS1EZax58CPpwr/+iY+O5GstmVIZWBH+Q6cML/laQl1R+zQTPoI3Mii
	DdwDgem/Wd9oS+aEnOx/ZqW6iAU7seDpw4xJdb0P8P03I8eJwjDksItdQqvq7G9sCjvQVm
	sT3LuAtYW+/wtk9Dtk6fXK76LAp4HpI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-hTHDKehWMFu5b-kdlOiSzQ-1; Tue, 19 Aug 2025 01:10:34 -0400
X-MC-Unique: hTHDKehWMFu5b-kdlOiSzQ-1
X-Mimecast-MFC-AGG-ID: hTHDKehWMFu5b-kdlOiSzQ_1755580233
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32326e2506aso4598930a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755580233; x=1756185033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcMWmSwQxQAwGftbQEwa8JZHokvZ0U7fwYMtmA0OKvY=;
        b=F4O85qIMvxA5YJrT2RCY/TTzPjLhMjvmH6xMDSOBDcjxlih1DT9SPrsqtNl2Q0RnDH
         qTmkT5h6q9cDqCXujACahg5ZxiRKbFguOLc7oa3PC+AKaE2tebwukbYowlS7G9HOhlVA
         GWMRtb0zsCz+2H7zVXCg7Zyho18r/r/n1LzE/owyZp5CAeCGF/Hl3Gi4O8JCKBgZxsGH
         nqpYebu6SRZ1QzDWeIyjyoueZLzZ3wZ+ReiX69BndqWS9FwTk2G0nAzNqmy35Gsy67Tt
         rV9n3zDotHnlDprPkcEwnwfpjYDjw/MrS3wGdQrl6cQkcqlFn9GlB9M+GaBkOiSXVsEE
         bfBA==
X-Forwarded-Encrypted: i=1; AJvYcCXqo+BzYvThFLQDY4WY1VZT7PGeU+JJ2YnwaPX6BRh7D+5ml8m66+5ci6wn6AuIC1CsLvNMtDWnbFr4yBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcjz9tPLvibMkU2I+USgrXlx85X46kRXuLvWqHRFsn58Lt1TjZ
	HxbpNjlleHg2S/m7O/5t3yFOhBi445YGihV97mroWcivUbYxavpGaGXN/OdeuCzYo4hssc6QwMT
	+NzkmO2QazhZd7sD8UpzbyB9DC+lAsEbh1LXCM5ysbna7OUaccmw1vcfK4UJYKmbt5g==
X-Gm-Gg: ASbGncvv94sgfz3UEovrpyoXZyUnCeoSxD54zNvI8QQYczx/H27tAn5WENtU6Yb7Vfg
	lXMUz8+i7g0aLlPLGVZx4rULR/rLlkYsAetnInRG+yQukKc6VvF9CPflctKj0E/2Tq518qz1xZi
	sll8/u5/R2ZEJndalrhPfsjll/0WlLLVlv99LAKphD1nz9dktyc+xvArQxLLEhfjEOL5kbghPTd
	aYj0/6rjuLLSaFbMZjOH0Y8luOtA8aYWwR/BUhXmVgDlkANzhfptyS+vNT+j2PAajdw9HmJYcUh
	MjieFFcO+t4gYRUZ8UNBEn2ulEYqBdTHkw==
X-Received: by 2002:a17:90b:3851:b0:321:c53c:4e50 with SMTP id 98e67ed59e1d1-32476a6cfeamr1808243a91.18.1755580233035;
        Mon, 18 Aug 2025 22:10:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY9DXiOXbeVkCNAdAOHO3J5NlS0U+d+VNCaQG7DmDml3jFwO/JkAy0MSW2lJdU5b7sc6c5ug==
X-Received: by 2002:a17:90b:3851:b0:321:c53c:4e50 with SMTP id 98e67ed59e1d1-32476a6cfeamr1808217a91.18.1755580232515;
        Mon, 18 Aug 2025 22:10:32 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330fc3684sm12883856a91.11.2025.08.18.22.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:10:31 -0700 (PDT)
Date: Tue, 19 Aug 2025 14:10:27 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, lee@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rust-next 1/2] rust: miscdevice: add llseek support
Message-ID: <aKQHQ4av5ZqfQ8Q1@zeus>
References: <20250818135846.133722-1-ryasuoka@redhat.com>
 <20250818135846.133722-2-ryasuoka@redhat.com>
 <2025081836-unbraided-justness-4b43@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025081836-unbraided-justness-4b43@gregkh>

On Mon, Aug 18, 2025 at 04:17:40PM +0200, Greg KH wrote:
> On Mon, Aug 18, 2025 at 10:58:38PM +0900, Ryosuke Yasuoka wrote:
> > Add the ability to write a file_operations->llseek hook in Rust when
> > using the miscdevice abstraction.
> > 
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > ---
> >  rust/kernel/miscdevice.rs | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> 
> What misc device driver needs any real llseek function?  The ones I see
> in the tree are only using generic_llseek or noop_llseek.
> 
> Do you have a specific misc driver that you want to write in rust that
> needs this call?

No, I'm not actually writing a practical misc driver. I'm just creating
a toy misc driver to use for testing.

In my toy driver, I need read, write, lseek, and ioctl to verify the
basic functionality of the device driver. I saw the Jones and Alice were
already working on read/write functions [1] and I believe they will
propose their patch soon. So I propose implementing lseek which
anyone does not work on currently. This is the background of my patch.

As you mentioned, lseek by itself probably doesn't have much meaning.
Should I wait for their read/write implementation to be finalized before
proceeding this?

[1] https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/.E2.9C.94.20Miscdevice.20read.2Fwrite.20abstraction.3F/with/497953296

Thank you very much for your comment.
Ryosuke

> 
> thanks,
> 
> greg k-h
> 


