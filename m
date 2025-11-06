Return-Path: <linux-kernel+bounces-888362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B13C3A96D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6BB6340281
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120352F5319;
	Thu,  6 Nov 2025 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tadpRn1X"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6182F1FDF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428813; cv=none; b=CVthf5m3kjhS8/leZHUA+z89n5vJQ8n5aiZSObgHhCvHUg+HItYd+5aSn+jJt9GmV61Zf2P6Ss3/7t4EASGIsZkW2McwEfA2dSj12Mjj3btu2PFTiWkd8bknGHjtTfPhTFy4Ov10mY0HeliaF5NX/mEuBgSgGrqfUAjc5Ztl4wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428813; c=relaxed/simple;
	bh=kskZfrnUVk0ZLO8Nc1tGxz/XbFYwKP6SavvJ3620Jng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bsova0z2K28woJ4At3LeIvYT7AKJr8qBKdV7JTI8iBeClMiPUHcXxdoNxXawQ1+ChjjGi+poEHPmFf2crVLbaJ1qjRQlg0tCEQL4BceIa0cdpyTXKi+dnKbteLeV6Fx+YPvJv+nJf3RI4JFlUd2JsZI33bv+1WQegJXQFPktEyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tadpRn1X; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477632ce314so4111775e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762428810; x=1763033610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3LzpMnnz4ipgzn0EHBlLJPC1ABo5o2dTp81SvHFFqg=;
        b=tadpRn1XWHoPMOqYMF3sUTrI4iaQvp0g4JtdUKnUw31NP4ubyIBnsa00OoFjUMG/ei
         kPYgj1wWgiRuwG8J3tWGeWQXk6Lp94Gm0Lb3TOIOa7N72m88uvdGRAdW9y5kVtKCBxSf
         ZkMTBqlRtJ0SC61eBk5cPBxlVtoJVcloC2ZmZIcGVOjRe0ANR5odzXSUAcW/X0s4L1Gb
         UyH712PULN3R3iNw50LKw8JMUvEFdTtV2sjRT1txPvSUp3bJFfHXdFXa648pyMRm4t6g
         bB/JPmw18STGo2jaWY9xyy/MCd70RIccm2WcPkuAwAlV1HnoAzVj1I0kj+V6towenFVO
         VIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428810; x=1763033610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3LzpMnnz4ipgzn0EHBlLJPC1ABo5o2dTp81SvHFFqg=;
        b=VfWKl5FRnttKFUGqdGwylAuoUiBdDZIdNqrEqOh7BcwnVAMZ/mmCbRK4QA7ybYH9nC
         of0Q/J85nOGwxsLgw0mSSTrhTYylzgZqd071DDCsspkLiqbqgVuqjhc2SJrrGq69eYEk
         GNQO6bf12hMlSx06vSq69Q7nV5KTrTPTYDIShssWY14vzjYpty4k4aCcWupz2qNkFOEt
         NMFYWBYX3dWnBmhF6tCjhVocHN5WDp37J4tWOpTFiJ87j7xJmFGakiwpkqNlMPygIKz2
         kheCLJ4nZDF+uW0o2xLbGAqn0Hvmo4CbUtJxzn05f7U1RR3HxHYauL8mu0n0bibZjJn6
         Bfdw==
X-Forwarded-Encrypted: i=1; AJvYcCVl6M7f/qDJPo1m9tAp4BCkP3IrhfC/rpmqDIofnfIADOBZgN9Qig/kijpNRzZAhl8ZD2cfAl9Ewh5JFbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsx0W2Dsj6MWlxDslo2bDR1Cmvd5nhmn+wiZ+zgVdK2h5+6cQQ
	1APJ15EFCWaxrf2DuQsDemtS6p8jvNu1YAITEO5ALZMwcTp3N9iv4YxifrFFgKlLj2QnVKwnTEo
	XlNWw+Uj9ebHODb9KWQ==
X-Google-Smtp-Source: AGHT+IHssTkDeOS2zrZoGKuLejZwLW0/HkLFxDa/KU2PrRZn+M5vKIDi/+Iwwc4V/ot2KZc7tJmUxQLHbnhZN1E=
X-Received: from wrbl18.prod.google.com ([2002:adf:a392:0:b0:429:c7d9:2f9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c07:b0:429:66bf:1475 with SMTP id ffacd0b85a97d-429e32c6cb6mr5721285f8f.3.1762428810181;
 Thu, 06 Nov 2025 03:33:30 -0800 (PST)
Date: Thu, 6 Nov 2025 11:33:29 +0000
In-Reply-To: <DE1IJMY33LSW.2X8N4PYXFITVB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103190655.2326191-1-dakr@kernel.org> <DE1IJMY33LSW.2X8N4PYXFITVB@kernel.org>
Message-ID: <aQyHiezb9Dqsyx1G@google.com>
Subject: Re: [PATCH 1/2] rust: dma: make use of start_ptr() and start_ptr_mut()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: abdiel.janulgue@gmail.com, daniel.almeida@collabora.com, 
	robin.murphy@arm.com, a.hindborg@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Nov 06, 2025 at 10:44:06AM +0100, Danilo Krummrich wrote:
> On Mon Nov 3, 2025 at 8:06 PM CET, Danilo Krummrich wrote:
> > @@ -576,7 +580,7 @@ pub fn item_from_index(&self, offset: usize) -> Result<*mut T> {
> >          // and we've just checked that the range and index is within bounds.
> >          // - `offset` can't overflow since it is smaller than `self.count` and we've checked
> >          // that `self.count` won't overflow early in the constructor.
> > -        Ok(unsafe { self.cpu_addr.add(offset) })
> > +        Ok(unsafe { self.start_ptr().cast_mut().add(offset) })
> 
> In this specific case start_ptr().cast_mut() is indeed a bit odd, I will use the
> following hunk instead and keep the raw access.
> 
> @@ -576,7 +580,7 @@ pub fn item_from_index(&self, offset: usize) -> Result<*mut T> {
>          // and we've just checked that the range and index is within bounds.
>          // - `offset` can't overflow since it is smaller than `self.count` and we've checked
>          // that `self.count` won't overflow early in the constructor.
> -        Ok(unsafe { self.cpu_addr.add(offset) })
> +        Ok(unsafe { self.cpu_addr.get().add(offset) })

Assuming you got rid of all cast_mut() instances:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

