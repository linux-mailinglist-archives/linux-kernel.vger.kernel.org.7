Return-Path: <linux-kernel+bounces-886244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B17EC3512D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02CE54E569B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DC33002B7;
	Wed,  5 Nov 2025 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="keQWsQf6"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA22FC013
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337995; cv=none; b=CLpvZUC00Vj8YyN06q8fYwQW4XbqckREIPr3ze+mZWEjG4K/trr4yTaREa+6m2p0Omt0ibemfIZV9HrW+SgP1qB2G/e0vtSETm2DCWvqbgApX1wWmv0jOLBWYWx+pp51WSNStM3Rq9nzOGlibdFS5QQOjRFbfFpWVtUNG+Sfans=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337995; c=relaxed/simple;
	bh=zcwOyR3i+iQCu6dzVq9q4dOF16E9XrrQF46JdXsYiRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rfaSzByb0RUki6BEJ8Au4IYhJsqT57MVBIh5+9sDVboUUE+CphKTKbJLlH6BuEkSG2g9N/UYD0alKKbPIaxkv5pcgMxMDAtVCSc3Gi88Royf68Cs4C5mY/5ZuuTUOF2fW76fgrIg9pizO/meY0XXn0kbHsTxUVyjQTNHDaOMZl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=keQWsQf6; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so4555685e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762337992; x=1762942792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gSDrC2UXjvRn1x7EpScqa90OTfMWc8Syuy/AT16lrpE=;
        b=keQWsQf6ApTiOtYPl2nl2wskeXvnbbMnImbJLA/NAft85epBW6XA1mGcEDHbLnuvTi
         mnAIZymYM1MI2tYxTgvRU5zhNoE3PmbNIsuwx3wVa2VuDTkSmNn6oY9fxkW3culCDkzq
         sbMWof1tTKxqIvuv8KNnBd/Yne/37x0dkCEvGlK0o7M5DiNdvIISBatao5A+LfFtJBPs
         znq2XSR9m9bq3WPDhxtPjbYU/uMkrM6sSWQGC6Fl1zw/kt2QzcAUu17n1zdTddpS1n2R
         /L81M6rSK00nI4nWZlAsbPr6PHXcK/ZvUz8t6oHI0eInVi/jnHRgjClbh7R9BHeKM/p0
         eepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762337992; x=1762942792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gSDrC2UXjvRn1x7EpScqa90OTfMWc8Syuy/AT16lrpE=;
        b=QtJIf6vjw7tddyk1v7NhIGT80Vlj+exZn9JLkChH0HRzTjZ/Ys31Iwj/5s1LKONNWe
         1Gr/Diu72PYOHjJsR0UDDfz4SvLFTXwsOH6GyFGOkr7AjM2JfDXxVNvmSM2R89tIo6fC
         xiIBwarX6oelCClAAeh5lpL88IUTHQAF/rnORIvVn4e0PX98jA+kbCbXfvGpluDB4sLh
         UTbhI6CscPTk8QB02w4JMdk5obJDgJV+5To+/XgkPvYyWt7MixIfKWTW62QgGrf3HZsu
         2jkGSI3xOEVq79pqIgl5JPOEPpyBZlRb1CFmMY1pjCaIw25lWY+R3zaQnjuIMT2Jzv9G
         8dRA==
X-Forwarded-Encrypted: i=1; AJvYcCUASdD24h7t4L5x4K2foY1eNDm/XWGPMBWmKntj6lHT1YbFF1Mp8gM1K5pOQL6vVhJYJPjYhEsZRnUJCI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqGzvIZA/6KRdPATVHA79hWN+ul/epk3lVc96KIZ1XDP00Pi+
	iV0l8qaUrap1Mpoq52QLQh5CQCR323wEDNeA0kG8+647nkH+AGyfT5ZEu6KP3gXEOk8OqE7QJ/o
	9mswbbxW7VS5Fh5V5Aw==
X-Google-Smtp-Source: AGHT+IFy6HLdLExBzNA/9DKpfS4LGeWapRstwfkqLi6/dGNf+Wnlmn+SJmKmH4X1ieaDRU09v81ykT8v7CEixB0=
X-Received: from wmqe20.prod.google.com ([2002:a05:600c:4e54:b0:475:ddb0:71ba])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c8d:b0:46f:b327:ecfb with SMTP id 5b1f17b1804b1-4775cdc5348mr25817385e9.9.1762337992754;
 Wed, 05 Nov 2025 02:19:52 -0800 (PST)
Date: Wed, 5 Nov 2025 10:19:51 +0000
In-Reply-To: <20251105002346.53119-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251105002346.53119-1-dakr@kernel.org> <20251105002346.53119-2-dakr@kernel.org>
Message-ID: <aQskx-CkI1HNycQS@google.com>
Subject: Re: [PATCH 2/3] rust fs: kiocb: take advantage from file::Offset
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	arnd@arndb.de, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Nov 05, 2025 at 01:22:49AM +0100, Danilo Krummrich wrote:
> Make use of file::Offset, now that we have a dedicated type for it.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

