Return-Path: <linux-kernel+bounces-886247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB88DC35142
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE6D44F6CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBA03009FE;
	Wed,  5 Nov 2025 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="03bhVvY6"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7B83002CA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338110; cv=none; b=GlGPrGFgTNWYRWebhHumystA98k7DvAldhc2yWtGeyAmmy4tWsXOEZ3qVK62yE7+O7g+4H4ogRcWED9N5jNA77zRDIYoMbdYMZcQDFMXtyf7/rF9xsREfNzkBXsbOVyYCYglrHceBpzpZsv0KeDxc5OinAPS0cQY29h09T00SgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338110; c=relaxed/simple;
	bh=nOv5SbwEt/u7lrrZsNiTVArKA6WvbIJcj/VcuXvsciE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AG1V9mBNsXiUS8NvVY1VG6AyskqxZtk3Io6fbL2gEMWqIrnTbKcmW7mgjhOGYy7sjvgrJtZ0t9Cb7Gj/fzLLKc3iQxYnW4GrKXstRLzusZXYzR6i0GJysLVuBwVVaxFekW8hJH1/ClmqRQEp8MkOZQ1RdlJAhjLDVJDZmtLkZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=03bhVvY6; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4773e108333so25983145e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762338107; x=1762942907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QvaJZPWX/lBr0I8xsGU61fm8PKa7AAE0hAZtVjjW1rM=;
        b=03bhVvY6AbWk3zQldCqvY4TjKdIeyY0W8PTk5mTJPcZlMOTGlAoMKL44WS+t+hi045
         wW7QO73XSAkoKVSp4ttRHhRJUuaYBa/3iu/qJgxR3xaqZl9JwpNVSXSZH1u5aLd+L4E7
         46j3ELrUUfrCEsTn/B1JVsJA4601H+OUwtvxv5JKWxmIess1YDny6UTgNG9Ntp6fyDJA
         eBDBoSIacJ1h+xzIjmbrmp5ff3DQexeHypFwl/NRUuCgDSaa87P+DCeSYiTyZQLoZpRk
         I95ZmCt6aHYD/Im3YGZVu6Dxx4U1913/0GyA59kVXO5i3eKVqY8l1jhp1WQjfa2LpE3M
         xMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762338107; x=1762942907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvaJZPWX/lBr0I8xsGU61fm8PKa7AAE0hAZtVjjW1rM=;
        b=VfBz88jjKIEWgJ98xAJhAQ8vrPWYj20GFjY0b15MHJWLCj3LxPCBCWUZ5jpzAd8gvM
         a8sAF6vdUn4MUwrhYE14um5fa40fDPwFmLYXy9KK4Ewf2TyGgd6KkRQPfSSMpen9A+lS
         gJR62/htjur2DD8XtWV6p7laOjI1EZyl9gasyoBhDe48+boyJ3JLIUpIDizYfCp3TW4k
         cLzzPU1TD/ydt1OKMYN4vIQ0wagm4eXYD2/aytCh7JkLFTq3OpzkQ0C5lFsvncm6Pvq2
         PmjFy6FIke3cyTWjI5WZsZ9jh9n9US8CJIpX112FtZNJvBiFeE+wN0EMtomtWSTPFhHt
         j71g==
X-Forwarded-Encrypted: i=1; AJvYcCVosXjshAC69M5ujQy4RwN0dBaJVMOWuIAK27y5H+bpgBVMx5ETGQpMw6sbNnlDU7d8uumcmEGfVkkPVCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZydl9uTTH4fd8o9vwSJEsXJBCtyNCVuregV7ANUGuZ2CJMv33
	KYiiwLRIxzNQn90TDMQ5K1FsiVLQ2+2WsopDM5UeV1K6N/d5B9P+6peXBwZ5V7FTbb3slJoLmRO
	dIEqtQGgWfilm+QcoOQ==
X-Google-Smtp-Source: AGHT+IHdi59H0AvdEqXo2GpBK/HP8BVRFrNAgC6yALK1p5tu9Pd1lI5ZwDcYaG3owUMBQGLJqr+lB+V+J/vRa0I=
X-Received: from wmbb18.prod.google.com ([2002:a05:600c:5892:b0:477:5506:8a6d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:468d:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-4775ce15bbamr32064945e9.32.1762338107601;
 Wed, 05 Nov 2025 02:21:47 -0800 (PST)
Date: Wed, 5 Nov 2025 10:21:46 +0000
In-Reply-To: <20251105002346.53119-3-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251105002346.53119-1-dakr@kernel.org> <20251105002346.53119-3-dakr@kernel.org>
Message-ID: <aQslOtzy2PcJ4D9M@google.com>
Subject: Re: [PATCH 3/3] rust: iov: take advantage from file::Offset
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	arnd@arndb.de, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Nov 05, 2025 at 01:22:50AM +0100, Danilo Krummrich wrote:
> Make use of file::Offset, now that we have a dedicated type for it.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

