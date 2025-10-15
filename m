Return-Path: <linux-kernel+bounces-853993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAB3BDD45B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03E68502246
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF78C31619F;
	Wed, 15 Oct 2025 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LygcJQma"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806AD315D39
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515195; cv=none; b=XsOjv1Lu/RMSofOI9ShEm5uSEdfztuLZRO5HEHlzBh4l+C2lBceB3OdiZSPnfxHd7AJytjZvKLkCYV5eT0Wz+cH283Q2F0HihdZhG8GAb9/9a59vHmPKXSdStkKlLcaT32zIRdqGx4/KbVMTckHiwdLQN+c5mT8WN4kc4sLeebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515195; c=relaxed/simple;
	bh=g0w1/EWgq4Mr9YLQy8DLKhipoh2gip+oFE1Oo3UKjkw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dqQ/bCYE1Luu0DqTcGDC4u3v1H6LpENeixQYue6SeOALUxYMQ8Pqiq7wofopz1FfMKrkQWVDyJq2mUY9AH3baeMaZeLq5ETEOzL1W1Z/c0E6au/xoADl2eHo3J0ok8WYE/FnZKtfQx9QVMaZnDVrBNN7xCqNMIxQmI9z9qm0g5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LygcJQma; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e502a37cdso39333365e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760515192; x=1761119992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8/8tGFS8qttNTKEkAB29MIJVNr9Gnd5ccqpP5VlItWA=;
        b=LygcJQmaOBoWiIWYI0CGmrerFj4KLLm7SC/AusEYbInOfm7WKwRfLKZxoVVkMMMjWO
         0nwz62Fn2moMw6LoeiiRVsCzLbyWHxcVrTQuWVOH8bBMlAwH2RtFjtYlsWVWDrDdsWgb
         KrSAH/CKQ+SiN3I3wzZobLcDFlyban5OMOnzFvSDQXEL5InXVOaxku3ZnJSbwzkh2J7f
         MTwEEqjcmnBE6XEfhZAC5dILhCJk79oykJ5iRupJjuvfxz2dp4NYRwQVnxARf9LKoUb9
         Aq1ybpYN68HhynTAISxuYUatUAoRbOJxA5X5OfpnnaYtmQl9hnMMhN2bzeVHEPKmHJzd
         rPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760515192; x=1761119992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/8tGFS8qttNTKEkAB29MIJVNr9Gnd5ccqpP5VlItWA=;
        b=s9rL8NoIGmjH2w/0sCZ4fD6PQ9nFqU14h/so2Gv8X4waUq3KEI1iQcs3vbegPz/1rw
         6WodkrJPYx0n3kr01EDDyFPeHcHor/76YO5G4TliZ+CjMdMSBA/BqWewIISGZNkzkzTR
         Qajntw2mvg21ANBG6Z4H8aSIX6OqKUMd4m9OAKVyGrySMw1cN2Y0BsKOVHQexoWo5SLp
         nybWFyavQ+RlowNG093p35Kmaixm88AEURzL6Dr5PHf7hYYG/CKXeb38wFLoA4SmrN+Q
         HFeu9CuDFgdOQOJU5hrPdftO/UEMUac9c4ciMHu2oXZ1Jck9RdNd9vVkQ5lZDnQpGMm8
         j6pg==
X-Forwarded-Encrypted: i=1; AJvYcCVGkoYnUQk9epH5p9ou8ww4PtzAgbugHIJODPqZrD/V2s1H5kVfNGjiXYZXrQZmcgZuzsV0+Ee4WRY3k8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHNUFJkbjmsDp3AoWT4E4AlWayil7gCh7K5ZuHlTXbvPajJODl
	IaJv/84rmycYAL46al4dRUX3l2Wa3NWym0hQx3coZn3SFvt43tDV4IyoHF34TdSMhYEYdAJD4+f
	K+dNNgCjpxle6mmUwtA==
X-Google-Smtp-Source: AGHT+IHfqCzES/l8fuWHkUtpM/E7ZJGIYru/M5wSo4fJgT2WUS0ZQPDZuI0v6yzjLDhYFsqu2byJ8UaG8cfcIWw=
X-Received: from wmcq7.prod.google.com ([2002:a05:600c:c107:b0:46f:aa50:d6fc])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:198f:b0:46e:3b1a:20d7 with SMTP id 5b1f17b1804b1-46fa9af8595mr225722805e9.19.1760515191749;
 Wed, 15 Oct 2025 00:59:51 -0700 (PDT)
Date: Wed, 15 Oct 2025 07:59:50 +0000
In-Reply-To: <20251014123339.2492210-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014123339.2492210-1-vitaly.wool@konsulko.se>
Message-ID: <aO9Uds521WM1n8_X@google.com>
Subject: Re: [PATCH v5] rust: rbtree: add immutable cursor
From: Alice Ryhl <aliceryhl@google.com>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	"Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Tue, Oct 14, 2025 at 02:33:39PM +0200, Vitaly Wool wrote:
> Sometimes we may need to iterate over, or find an element in a read
> only (or read mostly) red-black tree, and in that case we don't need a
> mutable reference to the tree, which we'll however have to take to be
> able to use the current (mutable) cursor implementation.
> 
> This patch adds a simple immutable cursor implementation to RBTree,
> which enables us to use an immutable tree reference. The existing
> (fully featured) cursor implementation is renamed to CursorMut,
> while retaining its functionality.
> 
> The only existing user of the [mutable] cursor for RBTrees (binder) is
> updated to match the changes.
> 
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

