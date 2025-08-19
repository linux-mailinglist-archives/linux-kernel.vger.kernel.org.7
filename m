Return-Path: <linux-kernel+bounces-775951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B217B2C6A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C3D7A8CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCE622D7A5;
	Tue, 19 Aug 2025 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXEI0IL+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513841FBEA6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612779; cv=none; b=lZpMSdSciinfgub+f2LiLyKbx0QsDpuK/Yqc7pjKsSEdCsSRDjHKFyGHYJf8DmVkNjUu6Knw8rocW4ejUGGTHowBRQY0WFjzofItLGLnmQI6F2KhzzWq99eOfQygjWQXHRbUEXEtaG53InqB1c4lu2E/zMz1YWi/3CT/w3lbx1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612779; c=relaxed/simple;
	bh=3V0z30hzXwF9h8gKVpXsVSnFi0/6IwWc5rnalb0g0aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUBA2mylBWJcEhG+LcIDGPlwuwXYGTWR/loZnE79aDqouyWXHb8Ap+LoeYOQz0quxWkqYNq2vvzZiy6Lmji+i83QO8N71d5Ba/mOBTDPCFExR0o3QenIdfHArbpnwHFRlXJKhLSbz1h5Ig8d9I5iNqbWdwZPQnyK2A1mFhrhCKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXEI0IL+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755612777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Tz22iSKZ8PdzAiXkoimq0HOH4BrSK4mX11OZtBTSdo=;
	b=OXEI0IL+uJynGx3eTwF8mzUmNpOjRZlDpAv2+lIzdf3OQvXBUvpQYmY2owL7UZ6RhN8st+
	1LOvmM6tBUA5Y9WaKpt1peQmFOZRU36/Rewez4KC4oSruaJtKuVF9KJ+NW8l3kLcXTdok7
	Z8pnnGJdkXqFFibiOotIBKexQF3AS14=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-9rmAQKbQMzyuASZ11WIg-g-1; Tue, 19 Aug 2025 10:12:50 -0400
X-MC-Unique: 9rmAQKbQMzyuASZ11WIg-g-1
X-Mimecast-MFC-AGG-ID: 9rmAQKbQMzyuASZ11WIg-g_1755612770
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-323266b41f5so10792977a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612769; x=1756217569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Tz22iSKZ8PdzAiXkoimq0HOH4BrSK4mX11OZtBTSdo=;
        b=Lh5x8T49SqtOe4AFtq+Iws7G7keChOKJtIawdkcy57RyrRY/eHOwCwIIRfPQV6nBa0
         V47R42R69YkXL1i6B3tMUNJ+rBHzS9C6Z1gWYNGbzCtZXSypf0ioGorDhXMwP7+biiA3
         5BjEbe1myrTmKwuD2/mM7crW40fu3fzABMmmGhVrYQQI2UUtJZxs7OB/ALoTOpvDyJs2
         94yWdFRTCo8RgpNShS0ASiUcjQBEfny63Xqa6gJCAxV6TNqTSEdR5pTmSQS+BOoKH5JS
         SPWZXH3JsQFlq7cduax17zfNm+6cknKO7LEWEZa4+DCef90lutf1Lwxm+luNCoXf6cfO
         D5yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlpeV/ppL0W4MzFh2sKzZfL6AY4gtlhP8H4VebmDTl5fTmrBpyOJqltcwdV0IDuophx+43K0um78j8qAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5gWNZzVIFBENBPQmqX27kX/ELQQ4zfiJ6GxhtG87PRiQDxcO
	vsGSxUEd3KKJ3DJTlh8JKV3Tw/s5M7Hjypa15BhA15qUCP1dxWd4szWCrA5IGPePAlwhDtcQOWW
	d+tCRT/ufFoGNwjujhGJzLzySYacjejvUY/BXXDb3qJee4QrI4TKrKlfFbuEFdWR35Q==
X-Gm-Gg: ASbGncuXAsIvsfIE/DqEkiZO+U4Hyk2sSIkJxFusqh0auEnVqPeNcd852Mf5KXYarFV
	nE7R9FIrvXztc4lSyL19fvk8IP280eEZT5Ojqd2Lcxw5+vsqvCGnfzLh+jtAEmkJ7PMzHdIX85q
	58Q7ihUyjsElNsCRKSF1oip6SzFzhZrbmUIVpG5qDYuANtizOfwI+zOY1UVtBlbVqYKkpJqWCaZ
	D14pmjhlMWZBjX2Hwt80RRx4Eg9nhTqcm3+0bOLqddHL0lbr6uTVYFriRM9+eIZjr9HpXR7GLVu
	oxybQXhx/3FHW0s+zExFY8uBHxl/FK9bHA==
X-Received: by 2002:a17:90b:5584:b0:312:1d2d:18e2 with SMTP id 98e67ed59e1d1-32476a6ae7amr3859388a91.20.1755612769620;
        Tue, 19 Aug 2025 07:12:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPs2vzC4ASGHRd46PAct74FDOC62VGMtvuVe07NVQb4zpn+49Mi8TM8sz/fOnZED0AyqwrmA==
X-Received: by 2002:a17:90b:5584:b0:312:1d2d:18e2 with SMTP id 98e67ed59e1d1-32476a6ae7amr3859353a91.20.1755612769094;
        Tue, 19 Aug 2025 07:12:49 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d1714sm2699391b3a.15.2025.08.19.07.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:12:48 -0700 (PDT)
Date: Tue, 19 Aug 2025 23:12:43 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, lee@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rust-next 1/2] rust: miscdevice: add llseek support
Message-ID: <aKSGW1SXcYleSdph@zeus>
References: <20250818135846.133722-1-ryasuoka@redhat.com>
 <20250818135846.133722-2-ryasuoka@redhat.com>
 <2025081836-unbraided-justness-4b43@gregkh>
 <aKQHQ4av5ZqfQ8Q1@zeus>
 <2025081935-railcar-playing-eb9d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025081935-railcar-playing-eb9d@gregkh>

On Tue, Aug 19, 2025 at 08:04:32AM +0200, Greg KH wrote:
> On Tue, Aug 19, 2025 at 02:10:27PM +0900, Ryosuke Yasuoka wrote:
> > On Mon, Aug 18, 2025 at 04:17:40PM +0200, Greg KH wrote:
> > > On Mon, Aug 18, 2025 at 10:58:38PM +0900, Ryosuke Yasuoka wrote:
> > > > Add the ability to write a file_operations->llseek hook in Rust when
> > > > using the miscdevice abstraction.
> > > > 
> > > > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > > > ---
> > > >  rust/kernel/miscdevice.rs | 36 ++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 36 insertions(+)
> > > 
> > > What misc device driver needs any real llseek function?  The ones I see
> > > in the tree are only using generic_llseek or noop_llseek.
> > > 
> > > Do you have a specific misc driver that you want to write in rust that
> > > needs this call?
> > 
> > No, I'm not actually writing a practical misc driver. I'm just creating
> > a toy misc driver to use for testing.
> > 
> > In my toy driver, I need read, write, lseek, and ioctl to verify the
> > basic functionality of the device driver. I saw the Jones and Alice were
> > already working on read/write functions [1] and I believe they will
> > propose their patch soon. So I propose implementing lseek which
> > anyone does not work on currently. This is the background of my patch.
> > 
> > As you mentioned, lseek by itself probably doesn't have much meaning.
> > Should I wait for their read/write implementation to be finalized before
> > proceeding this?
> > 
> > [1] https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/.E2.9C.94.20Miscdevice.20read.2Fwrite.20abstraction.3F/with/497953296
> 
> Yes, that would probably be best, because as-is, this patch can not
> really do anything :(
> 
> Also, we really want an in-tree user for the new functionality (not just
> in the sample driver), if at all possible going forward.

Got it. I'll try to include an in-tree user for it next time.

Thank you.
Ryosuke

> thanks,
> 
> greg k-h
> 


