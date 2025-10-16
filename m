Return-Path: <linux-kernel+bounces-855986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1D9BE2BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9165D4F3BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B609328632;
	Thu, 16 Oct 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CM2gDSjS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4A0328604
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610002; cv=none; b=KoJZVZsk9LjDzgIK5IcMnwhUV0uS6G5Sqw/tYTbb+r4avF2/WLaD/789EBNJLMF/6tN0IiA2Bbz4uf/1Rrwq9+OuyQ9yQQXLlb01Uv0yDzIRNm6iffrRJQ44pfR50qYUf42KAjkySpFwvH3oABVt4X3xSC4U1b14JyEWQHnX1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610002; c=relaxed/simple;
	bh=Ja9OCsmngnUSE9D933GXE20U1SEDuEIJ/kJB/Ud5X8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1oLonqxJTJxLf6IPs4nc4BY7Jw32GX0AqX3egj8R4MVEi2wybIVEyeMBuhlYDXbH5XBb3PyhrvifkAuMWeS6smeoXNqMluLhcodi91qYIaeLQSMaX0e2F32oaH/YQCVtB4iKJ6We5hh+/bexo6RJ2BeJ8MzT+UF8mRkXrHFtx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CM2gDSjS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760609999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/lG9IkRu6rTULVmHXXnaYdq5MUjY3K7YFZ2k7C6bWjI=;
	b=CM2gDSjSnPKnViVoa82hUAb26nL9zp7ahFP49YY/5Mx6DiN3WzD849CaWWZESzTc34dKS7
	tsuRVuplFHPpMHxwU5BwDzorbWlb7BmMxcwdnMqQJov7bi7vY/U41XSuhII92W8T9ltQVO
	0aZa4bEwJ/baK4z+2SETmhKAKviR7k0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-Z9rn5rHUOOGfHELfNIKhoA-1; Thu, 16 Oct 2025 06:19:58 -0400
X-MC-Unique: Z9rn5rHUOOGfHELfNIKhoA-1
X-Mimecast-MFC-AGG-ID: Z9rn5rHUOOGfHELfNIKhoA_1760609998
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28e538b5f23so8471445ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760609998; x=1761214798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lG9IkRu6rTULVmHXXnaYdq5MUjY3K7YFZ2k7C6bWjI=;
        b=wOxgZZoTCCbOlSOC24u7Hzbp+93dPFKhoK+o76ISRjS+WoP/d/k+oiWzu9GZctHYN/
         aKXLsQ7iCpcgML/X/80nAOSq4hLZ7XYeisfT7ZlKoBA9D2QVbCGMPa0JYtSS5mfOORQZ
         fnHW0zFPwG49g7/3WSN5FXHBVAz3eIK5uMRcnvNpQkTkpQnWiDOi2zVTbe2b/SWdZYIv
         jxfWa6jz8Bof6Ia2IcjfyufzJ1qVYKigF17j9NHrYT/708EiglTcp7X3hY0Ip1pSEUpF
         G7S8SccyntuAkUXb2EMLHbhH+HSqzLhTAy2HpzQ2mCura0fMwUymke7a5G/rjgu4bWO/
         bsPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRK8esXQBK62P3B7xcYBKADlCzSRQytlWMJ0fiqufHn4YpyGr/5mEK+IyDY0ED7hWIRwoOBWOSjUjUegw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6FQ2GubZrefagG9OzeLLs048y0bD44AlOh5w69MiYHzqSLROR
	sMOLm9/KqsjLSeeCybzLmdi/+oOO5+yXD+YThzOnrXcIjuM6UHaZkD2QBPzsu3RaueK50JcpuFX
	BBoXwC3MhcPFdiK5t9FzSh8kJa//oGiwjQ/F3QG4A978Jf/052YCVVAqg1+xo6OeqaA==
X-Gm-Gg: ASbGncsUFE+BuKt0wIAlhu9OKBwvYspjIHHdPGqvIqDZHqdjXEz9bNVTMNAd4i29wXX
	GeNrWJnIE+sBbwzcc9Td2/1IJicmMSUah/4PcPXEvAyKh+mMLd8+VDZckkS8E8JJxut90WdKtIb
	xn0rQNNYA45qAsb54GiRErBJy87x5O/ekE2GsHMRxY7295d/i6nHKlDgqMJmmH8G4NVgUbesAXC
	PzYzPyWve1s05AsXxfpWkE22qicDQWB8pzLwgbW1A3iRSfEXVrLKKPfNKF2NEhWe5QRwDHoUZcq
	xvK9gykOlSFnZIHB6xILfMUGibdDF7QtRp8Wq26kk6T67Mxmvxfng8S4YlFtv5lB3+/OlA==
X-Received: by 2002:a17:903:f85:b0:264:befb:829c with SMTP id d9443c01a7336-2902721634bmr337193885ad.9.1760609997635;
        Thu, 16 Oct 2025 03:19:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTlevuCwFZug23HK7ieK2PBYjuqcD3nAVQRBsGzWAIrpjkSn/kauHrjBi4EzPYnipAaY0fKQ==
X-Received: by 2002:a17:903:f85:b0:264:befb:829c with SMTP id d9443c01a7336-2902721634bmr337193655ad.9.1760609997255;
        Thu, 16 Oct 2025 03:19:57 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-290ad977cacsm15444725ad.105.2025.10.16.03.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:19:56 -0700 (PDT)
Date: Thu, 16 Oct 2025 19:19:51 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH rust-next v2 0/3] rust: miscdevice: add llseek support
Message-ID: <aPDGxz04OQgzRQqL@zeus>
References: <20251015040246.151141-1-ryasuoka@redhat.com>
 <2025101544-stopper-rifling-00e0@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101544-stopper-rifling-00e0@gregkh>

On Wed, Oct 15, 2025 at 07:40:12AM +0200, Greg KH wrote:
> On Wed, Oct 15, 2025 at 01:02:40PM +0900, Ryosuke Yasuoka wrote:
> > Hi all,
> > 
> > This patch series add support for the llseek file operation to misc
> > devices written in Rust.
> 
> Cool, but what miscdevice driver needs llseek support?  Do you have a
> real user for this that we can see as well?

Currently no. Because lseek is one of fundamental functions for device
driver, I think it's valuable to add support. I believe we'll have real
users based on read, write, and this lseek support.

What do you think? Thank you for your comment.

Best regards,
Ryosuke

> thanks,
> 
> greg k-h
> 


