Return-Path: <linux-kernel+bounces-864485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2F3BFAE2F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3833BD990
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23012309F06;
	Wed, 22 Oct 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkMde9Re"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB2D309DDC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121646; cv=none; b=Kn7FZjjngXpaRmHq8sIQ465R1wcuOBo+dkgeoD03i47/V97DAv4na/bH1vHwBlmIajgrQqGXeZ+QvN9C41C07v7ZwNwir502gsXoEK+LXl1JVUGpkGPrX//1vSJn9ST7DX/6+ih+3YCgcndRQ9M32RYZ4Zsy8lZeLlYl1THnrPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121646; c=relaxed/simple;
	bh=tdMCrTS11/V/RG3ZXCpH2xncw9MorPLnFVlPKePhQcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XX+k/Kuf79MNKFpgtu3yrR0j4SzZ1KhwJyIZat1TmPHHfwew+W20n4Z8AMclDBNDFfBLDAvnhkZGBezRIpofA/hZb1jQRm1VwSRxvk06HEeSjKNgE/ku+jE4/o4eB7nlQGUojWpkekkXdkQg5EQJs4jFX7AMk/lMrYTL5V2dBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hkMde9Re; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-471005f28d2so24954225e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761121643; x=1761726443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EEzCC+9AOK4yZHpfROCb40dtqhboh5xWZdG1MYZMg9M=;
        b=hkMde9ReTpa9FN58YfFSicanoYc6L5pUWnRZeg1vXxQxKh8wKSGbnWIJE5w2TFm6ya
         JeJ5iWXFmUMyxVGLmqa/gFqqVS5qllbLnaSV4tJ3ODBoOtb6wj4YYXGONfkJJL7DlZYJ
         7ZeKUx1+SI03kEoxXwJuPo/6aoYF90icKw+SogR0wB2Vfif3/qPHz3vvGacNgpsEXoGK
         nkm1lcGlquRP1lxTm/4kSQb9rfxT37QmIQ4La5pOIq+OkO8nYpL+/LrkTIBiTOYt1hL5
         YDIOTUurf+/996f2r+rYDGusan6Ue966wUKnvOL43bH/4MllRaojKQSOhgyT9jrGoOxK
         EvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761121643; x=1761726443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEzCC+9AOK4yZHpfROCb40dtqhboh5xWZdG1MYZMg9M=;
        b=YaCTizSBcIUw86lc+2WgdU7KxLdpPYHO/Et5H3GHq8/2j/aBGKJDfsUipy3JdK26BJ
         hdF9aqCN8ZPiBEeokT+9gKsdNvigcfqj31EcCLG02qPYT2TNc6zV7kQaj5w6T0T6Fkl1
         AxljXORdaCSTpwZXJ/Rs3u6s4af2/Eo5iqaHX0rWTY/w+KcYRZ/vhrdHQzpmtlfj3tPL
         EfsfY1XNlNnn7dsLlu+J5QUUManHiT1wfFx2466rcFudYUkGTbbBp86c/YlM+a3rp0GW
         tpcMUDxUmGp+8pFpq+3dfz5Tc0+iYpZm0sSarXtvmQYKyr+k+YQUST0qJztpUA5C0Hp+
         5KmA==
X-Forwarded-Encrypted: i=1; AJvYcCXc2KUhg1t9b7/KFVJTkiM/D67wZWT0ul/OsA7/ed8ZPEpSMvyshVVc+FhBtO+G2yBgDVlkzQKwg/qHUtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwS92XRP74l4rbknqO9XKECsHiD4mIReP1HYKoio19/17lT186
	aYD1O8atxgMtTeShKqJgsse1hKaYUSDtxTfHeAv5YNpWRxOGvdx6Hl+0+ZkSlr4THgwxSZHGyMX
	zydK2w2r8hHpdKJtApA==
X-Google-Smtp-Source: AGHT+IEWMusiGxmG8q/baznsT+BCENOjAatF/36w38yfM62+imMcUpM6TlM1aCKBP8oAPtZRLy3N/J4JPzr+R+U=
X-Received: from wmwr16.prod.google.com ([2002:a05:600d:8390:b0:45c:d828:e351])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:548a:b0:46f:b42e:edce with SMTP id 5b1f17b1804b1-47117925db7mr133274735e9.39.1761121643176;
 Wed, 22 Oct 2025 01:27:23 -0700 (PDT)
Date: Wed, 22 Oct 2025 08:27:22 +0000
In-Reply-To: <20251022080717.GI4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022035324.70785-1-boqun.feng@gmail.com> <20251022080717.GI4067720@noisy.programming.kicks-ass.net>
Message-ID: <aPiVajDTiPsxZweo@google.com>
Subject: Re: [PATCH 0/3] Remove the usage of Rust native atomics in debugfs
From: Alice Ryhl <aliceryhl@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 22, 2025 at 10:07:17AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 21, 2025 at 11:53:21PM -0400, Boqun Feng wrote:
> > Rust native atomics are not supposed to be used in kernel due to the
> > mismatch of memory model, since we now have the LKMM atomics in Rust,
> > remove the usage of Rust native atomics in debugfs.
> 
> Doesn't rust have a language feature that allows you to blacklist them;
> ensuring they are not used?

I believe clippy lets you do that.

Alice

