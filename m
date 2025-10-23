Return-Path: <linux-kernel+bounces-866486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B291BFFE59
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AD454FA3AB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C2E3002C3;
	Thu, 23 Oct 2025 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GhpUltlx"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721B92F5A3B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207805; cv=none; b=S0aianosWOoxhfjAp7pE0cZokZtItLfonwvFwgUJZAV59CGQdpi19qknoyYvJxC/PAOQicgJtnwKrZhcD6WKVorP1w9j9W7luKUQ8Gn5AllfbiP3rehH1m+kRgeTEkhtNmU8vkWaNbjioXeAPzQlBqfKEViR13fjiTXuabbzqYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207805; c=relaxed/simple;
	bh=GZ2o/nJlsEOzs00Oa82WFjuaDZobMx/ouP1Wbql+PLo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MO2XJAkbSLh6cFvJQaIFVfoM6hO7lADv5dFqU7DTW5ExF1sqqKcaTbpNnw/plfWXpSTidwWRIJMECGzwROgda/urxCusYrsGpI7hRstM078+/ZNlX/U6CrPyf6AEdSOH6UszoTI2QuXooMosMXbI1jeGOkVatEqBSO066QIcSGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GhpUltlx; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-475c422fd70so2930085e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761207801; x=1761812601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QpqWsbe7X8TE4MbamMdrMlILOwJyeV2HZGxH0RxJ4HU=;
        b=GhpUltlxb7pXO7xYnzD2qz1vBVpmNmwv/qPEqqVA5snlYpxMksSkOIwpsEwUiWxLiW
         Y6ryfxWnV7R9h/x2jXwpTkHzeimlb6pztsOLm61EhOhbFI81pNmmRfBzrYcV+UZyeGoR
         Xkcsxa97YzGiykhiDUk4iMzSaFv8sayVUBB48pE7DJs1g8J77oPv6z+LtVCWMj7tTC0A
         HI/4u7TGKCfEb8EY5x4RJfsU6eHGH8KrdEfIQ685Ap4au4wkg6rNt/enGnYhuA/OYmES
         gXxalzKaOcqQJAVIbVFB37ONZk3xFfi3qEwf24vsV1y/8y74Y6Wyp6fAGa97plN6VaJc
         WOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761207801; x=1761812601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpqWsbe7X8TE4MbamMdrMlILOwJyeV2HZGxH0RxJ4HU=;
        b=MXdeiq2oSRl1MPEvlH2zm2iA6Vf6/J9B4xNNaZewGYipXQywEbWQqbUtgyGtUVxZtI
         xRAe5MgG4qCj8Fsj5hgKvWJ5GfvP7LdzBombYzLkQqkFcP0VCmTsFoa3ZOJ1VTqrQeq0
         cZh5Oy0y2mkp8D+oJsazqlbbVbQPTeOcKQ2heKrW1vlFMMQptXt76BaIOuDGoxYGNUUp
         sSeA8z38294xm8b9PqEz4Zz0y1P/7bGykhWEAMo2pkh6GpOnLNrrWCcB3+5vGRT8iFYK
         7kWh+gWLpbCESUX/PKEIVEkBR5d2QctW6H2Ur7nMWLFEahOsZXWYCpqdcK2mz9mThQfh
         BdaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMa0zDZXTRjEw3h3AkjJiKDAlobbgzcNyvS26M2XTuADQJasMFuwjq1dbj0WlJ8wo+q5cgyv4RPUc1uDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNmYIrh+faVOnHdoLsX/8aTrMLr6uJLOO0pKJVedBFfyDXIeXU
	bIgyH7kAGaU1+B+dl/9sM6KxnDsLVMll88qcum1YRACR+YsvNedB0h1hoyYR0UEUk3RMpOcnoa9
	D0Fmjg38gDwMfzCdZ8w==
X-Google-Smtp-Source: AGHT+IHRFzs92gG+pJqT1st2Vl1lkPZd3yrofQcAqIqA/U/9o7yE75rCP4nX2IU1q+y5Llnr+jhwkJEc7xi+Eoo=
X-Received: from wmin5.prod.google.com ([2002:a7b:cbc5:0:b0:46e:67c8:72a6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a214:b0:471:ff3:a7fe with SMTP id 5b1f17b1804b1-471179123b8mr119070815e9.19.1761207800744;
 Thu, 23 Oct 2025 01:23:20 -0700 (PDT)
Date: Thu, 23 Oct 2025 08:23:19 +0000
In-Reply-To: <20251022143158.64475-10-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-10-dakr@kernel.org>
Message-ID: <aPnl92lLX9sCWrT6@google.com>
Subject: Re: [PATCH v3 09/10] rust: debugfs: support binary large objects for ScopedDir
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 22, 2025 at 04:30:43PM +0200, Danilo Krummrich wrote:
> Add support for creating binary debugfs files via ScopedDir. This
> mirrors the existing functionality for Dir, but without producing an
> owning handle -- files are automatically removed when the associated
> Scope is dropped.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Matthew Maurer <mmaurer@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

