Return-Path: <linux-kernel+bounces-860492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACA6BF040F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3BB188A471
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BCB2F692B;
	Mon, 20 Oct 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4jtNaxJ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDD32F5306
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953191; cv=none; b=X9uAxg1j4h/PysIOCkfkVqLNR8RKYKUx7uGTy/lXh9EYb8bGFyuVx+jhVhBDdduew4Sk/Rx9EbMzpgEAGX1v7ERYeCdzID4xRYbKCiWkNCXnX+pSJL1o5FQ3EeWD1uAb4HXmQVaHgXxneO3gATK4tr1FB7CVNBhZ0/LmAFZpkWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953191; c=relaxed/simple;
	bh=rlReUiN8izqYmd/SmC7+ZVqul99jLDzgi/035/wGtbo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ttboxL7CKyv/ep3YXKfkV7ORkLPfzzOVFUX18nYQudCiSRe7c+Zy8ycEOXS67kUVjGlh17/AisRK/LKM916/kGRPyTrfbea5iwrgjIk9cC9U6WNz7O5deZvHk3GKkqpWdjSCAqZIVra10xa43RKNBBQEBiJ640nvfEq99SSMEM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4jtNaxJ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-471144baa7eso15047165e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760953188; x=1761557988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4W5fx1xJzyywPWz2TPx9643bFzzuinQiyCivwzQn5o=;
        b=Y4jtNaxJVPZWk8SH4JKF3xFR/zX7krmxiIAyt0dQRz7V5QjadhvCcB6sXEewKVHT16
         fZWTkLA0s/7l1+sFOksomXThh37CuZqwJQj6MQhtZWaQ8dND9IemAEBVe9aSoqUWlmDk
         bR2pyaDTgJIV2eLGIJ5B7cCD4U+9DhdpzHW/6uTkFUuUuscGF4p1SfCo4F9g5sazA9+B
         CTuHK+6HcJ/9hBY/7U7Ohex36JM12B9DRQulEPpIXdLd140QzZsVfK0zWYqkK4kmA/Hz
         +nG31MusMEVBsW0fY6fludhkW7+nxyJjy4vaoey5/Ga2znsjfQK/hwHnu0B5+Ot0ekvi
         fLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953188; x=1761557988;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4W5fx1xJzyywPWz2TPx9643bFzzuinQiyCivwzQn5o=;
        b=Xvci/X/5e3g0AJMyCCtjY4BpI+Fj+KLVbi3C23N/XuwkkDkVO2sAWe9W5mhBdwZSn+
         vY/CGRzBw8YttrxdbFxXF73nyVs6jM5nsB7dpms4RBABjNZYbX+iLNL74gTqF7+FcFXU
         G1zzLVvOd9LdIZaCvSHiSwa0qygowa3lgZ77jEZ1RWh1a9Oixc6Isj9GGSTrRo3Nc1nj
         IXqc6hSORP2edBhOcCzWBffgIp7GH1tw+Yi8Sc3NBjZ3QixWrBXqNMowQUBbLA8q588B
         db5niDn/EMXLpc+eZfB15bCN1z5RYaYKUcAg/XuO7Xmev2VHZi5Jbv2Ba2k86p6P/Dky
         3plg==
X-Forwarded-Encrypted: i=1; AJvYcCWyW9bsRxkbkzTyWgR+b4lD+Yz8JoLAJps3qpeFezwbnpRCEoTqIcoG5JdERsBhtRm/A/ExzEtg0oRxf/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbAeSnAZ9/aQD6qUfUINx+K8cVYNMU9WO8ZTshgqw9Oy0lrDda
	+iD5PIzLZkUgAay1mB3rSdUY6HJSswV8UNmrqe+JnkZvzXCShiD/H8BrvBxbb6Oi0AmjFOzlazH
	4RUfCE/Bfk/WNAHiWzA==
X-Google-Smtp-Source: AGHT+IGDfA53NxhNSHfMk6oo7zPt81rPlpVd0hfiY49P2Ld6yI2Vye275tLp0hNs/aO1TCjCrUYUSSRhhc2pYnY=
X-Received: from wmwm9.prod.google.com ([2002:a05:600d:6349:b0:46f:aa50:d70b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1914:b0:471:c72:c7f8 with SMTP id 5b1f17b1804b1-47117907a52mr85563345e9.21.1760953188498;
 Mon, 20 Oct 2025 02:39:48 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:39:47 +0000
In-Reply-To: <DDN1PLK58C34.2XF7BCBQNAW5X@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003222729.322059-1-dakr@kernel.org> <20251003222729.322059-4-dakr@kernel.org>
 <aPI9tNoh0I3KGDjl@google.com> <DDKO9M4P06HS.3UMGG3QR7BX67@kernel.org>
 <aPS0aTUUwDsXmHFN@google.com> <DDM9EDPP7XQN.2SW537AZ7DAZ9@kernel.org>
 <aPXvJPcSgZdNlGtB@google.com> <DDN1PLK58C34.2XF7BCBQNAW5X@kernel.org>
Message-ID: <aPYDY8mdHWjyOU3l@google.com>
Subject: Re: [PATCH 3/7] rust: debugfs: support for binary large objects
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Oct 20, 2025 at 11:35:15AM +0200, Danilo Krummrich wrote:
> On Mon Oct 20, 2025 at 10:13 AM CEST, Alice Ryhl wrote:
> > I ended up using i64 for simple_read_from_buffer in iov.rs instead of
> > loff_t. But if they can differ, then yeah let's introduce a loff_t type
> > alias.
> 
> No, I don't think they can differ (I used i64 in earlier version that didn't
> make it to the list as well), but I think it could still make sense to indicate
> the relationship with loff_t. When I see an i64, an offset into a buffer is not
> the first thing that comes to my mind.
> 
> What about uaccess::Offset?

Hmm. That seems wrong. loff_t is a *file position*, so it should go in
kernel::fs, right? We're only using it in uaccess/iov because they
happen to have utility methods to help with implementing fops entries.
None of the "base" uaccess/iov functions use loff_t for anything since
they deal with sizes in the address space, for which usize is the
correct type.

Alice

