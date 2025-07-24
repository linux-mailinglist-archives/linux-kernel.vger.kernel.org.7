Return-Path: <linux-kernel+bounces-743646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D71B10146
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9313B86F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12978224AF3;
	Thu, 24 Jul 2025 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ucw3yVGA"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7971F2382
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340761; cv=none; b=C9KIkEM2TUaKhLd9XAKjJQoQ2Gl7ejJ/gMnatOb1PTDmQ7UbX8Z8mFmLphJNZ9zg1IpQ1fys0ro6SeBFjjRB+7sb/vwKVkIcDCRJx2GSY6p+OWlfYMWFZ9N6BQR37x7Nvvvamt0zKx9NFpi745MKYXhMYKK3ZgXkBbWSIxJoU5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340761; c=relaxed/simple;
	bh=aom4ik6NbQLJBpPAsZFZJSGuc3xewHhssefGt5HVSqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j2SkFNS6VsPkX8k1kVqW+iPKM3xgaZCYLELW99gZF6diVtnPZEcQ6CtKW7Mrgo+qRQqvW1ZlImMchzpsAEIDqV5Afbtg1NWXawXxCb2qYZxAYLpviHn5z/a1J2WE97hmGFKnAfVbBt6ZmtCqdf+TT9Y0vhz9S7DlX9sTo7t1nZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ucw3yVGA; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4561bc2f477so2896455e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753340758; x=1753945558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E9slyRDPcGtY3E1cTdlfeJMl5k9N8J/CpAiLJlmmRwU=;
        b=Ucw3yVGAA53OsNVEE4JJB4/70u6a8Sq0bVMPZRFECIRbkAi2yh1asRQhRhrQ/JRsfA
         PqgVyJ2L7RJpncfAOBsz72pONAwd1ys9JTYKN+cRx3cv97CSRODk0GqF4+9ykIc5Tonp
         W0J7RdXs/231uoT6wQKobTnmoJW3VKlRQQ+pFFNa3o550/R/zp+mS/R6UT18pTKu5q1B
         i7X5dmFVi+Xrr5/X9YQ2c/5WwUJVQ9FQYrJzrPdp9T6/jmw018X8FIuLpb9PQ5loHEdC
         kxh8bqelJRV+HNtqpqy2L6gml9KJvHSowuEP1vxuHsiBz189QtVqA7uDYSk+0GY+RaZ6
         MEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753340758; x=1753945558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9slyRDPcGtY3E1cTdlfeJMl5k9N8J/CpAiLJlmmRwU=;
        b=UEv2EzDp6bIUHfsjuUcjDBzUIUoT9w0dN0r/vwtNc4et1oNirkYlhhxHPSOcUepHhP
         rRcTsSN81R50QT9aMVes6IB3BPlZruOH89fjV4k8jYr109tYeHu7zUProCgmu3YX/QtT
         ng062uyeZq6WzDcmmFTa2KWVsVBDY5zPPrCRaEd+DFw4QKQyP3hJMWhVxEPKzDY+66cY
         PaeLaDIDTstHtweFd0p81pEM6Qf6acaO2vYiBDS9wTgJ2Oekv1y5RaVpkP9FZGHrxkBM
         xi16I+hjRACxfx3hIMuLWone0V7dyTBjhYxyv/nRgFEUw5ERLng5d7zfOlv1ciM5nE0a
         H7fA==
X-Forwarded-Encrypted: i=1; AJvYcCVOKH/QNzAdA6Ee7g8cK4EFX0pPtMmcx1UbbS4k32byfaxvTCu+Ck7PVOpcuruilpchfnm116QVhQc7mRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1+QdK57ZnH9G8M0y02oFgLlQmWEk2DqGzeWj1sJuuqsXUuOnY
	6+V5Hdrc1zkhJBS+5ePFb4oGmnDwFixSTMDCjmG07EUZgD3NTZhYNhOtnlZUdAFPoJP5JP6wopB
	Axz9DbiXffCsiNAzsBw==
X-Google-Smtp-Source: AGHT+IGyTjyBp4hfzmrFDQCSBkvhVeBIjabcRMfTMV10Ea44IJ7TP+ZbQw0R2vGl0rPk+/+EWHeAEtNqrbSrHOk=
X-Received: from wmpz20.prod.google.com ([2002:a05:600c:a14:b0:442:dc75:51ef])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:d:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-45869ea827amr41426465e9.4.1753340758482;
 Thu, 24 Jul 2025 00:05:58 -0700 (PDT)
Date: Thu, 24 Jul 2025 07:05:57 +0000
In-Reply-To: <20250722150110.23565-4-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722150110.23565-1-dakr@kernel.org> <20250722150110.23565-4-dakr@kernel.org>
Message-ID: <aIHbVWzX4NiZaQ7K@google.com>
Subject: Re: [PATCH v2 3/3] driver: rust: expand documentation for driver infrastructure
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 22, 2025 at 05:00:01PM +0200, Danilo Krummrich wrote:
> Add documentation about generic driver infrastructure, representing a
> guideline on how the generic driver infrastructure is intended to be
> used to implement bus specific driver APIs.
> 
> This covers aspects such as the bus specific driver trait, adapter
> implementation, driver registration and custom device ID types.
> 
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

