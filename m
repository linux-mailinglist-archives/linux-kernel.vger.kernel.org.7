Return-Path: <linux-kernel+bounces-781315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02C2B310F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B947BD2CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1232EA72C;
	Fri, 22 Aug 2025 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePcWKAly"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2481B2E8E17
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849543; cv=none; b=lu5jS/P1MiDnL7T+RcjDiBOIJXr0eHC4arJ47Npz6guMFReHRqPZqmuaonr2+r1XGlF7EkUPt6OojCaGExUJy3NLutYdxgC4nYXm/4RbgBa7vxrlDOzsHxEkd9PY0I0fPCXnuZ1wz4XtVSz7mfTnlMKbh77t1Fx4Rn4gChOkuDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849543; c=relaxed/simple;
	bh=ZSQnUiBY+QjVWejECl7qq5B/ncsHvvBk+pJI9WWhJ14=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CivolxuE8i13T4lqxB9uFfWZTgINMCnEJTirnUjFZ3lhxtq44dlbdnqZPmUryBUtar1muHhqerfUSckFFptayYe8NGC1wdlZNRzK43qP/7EtriuVxhCI6AmDRM6NUE57c8iophK3nZEzRGnUIiPHw2tSs/WtO94BDU92betR2gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ePcWKAly; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9e743736dso1034079f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755849539; x=1756454339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OcR2vTnWvdHWsTxe8C4S1nf6KTHkxOneetmft7WPD4M=;
        b=ePcWKAlyd6NH3t/t6bnD3PFKLfRGfImvC3RUidWoW9fND1QrccadYRUIFhBvLuUrPi
         1z0Ue9GfuDy/KNWa8BEoiGFtvFqNmhEUTY9y+D3PzJ74RWauKyeLYfeewp5qzsNRZUqS
         bIdUQ0XcJoKixgiwfNliuylJPblnZOj3Dy/V7TKxxV+DwnPDjZiB5faMhOALFsCcJHV6
         4C5ffRZULjmQoWVOnbYds4qrLrkNJD/ifxpbbDbUDF5Rprija7rTnCwHUjJbYV0eI7Sm
         IJYiApmAZveZKooYwPjEpg1f3A2poSM8EDp8a6T3nmpL5tNLqJpnPe3IhNtbDYhcO6aq
         v2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755849539; x=1756454339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcR2vTnWvdHWsTxe8C4S1nf6KTHkxOneetmft7WPD4M=;
        b=DEwBup/9M8TLGict5sbrATN66fIwfTT+Z1yA0BkMUzzEJj7fbVe/MerNRtFe3r3iFK
         4RmO6qXSLcJWRvmuGkovzwwqjhSVr+fQQ8hF8zdg5pXzGId7gdSQeHyCNqm4+FU7OU1p
         MtxbuFZLlsqfogDmj+szHJATV+PB+XDyBPRJEzMIPeAQKbhrjExisLDkbF7pJGt4sMRi
         ZLnNU1Yo3OpXctakAyEixD0LpmWAnz5cLm5GmFmg+4hbbzL9+hCNUOxf4TaJ+K7V7dp0
         v87aguQJg0MgnGdSPyXDkxeU93Kts6ykdl9T2Q7xI4QDQ5pYXj4V0WPl5TmJ8XY7rhFI
         vnzg==
X-Forwarded-Encrypted: i=1; AJvYcCX/lgqUT28iNkZZ5U5oGNOxHbIM42Zk6TBUe5WURL6ivhW3bFTLEQJBdDq0lGuIM2DC/ffAdBfCZQW8jfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEnxC7pLGg0NHVmeHFr/vjaVmyxUQ5JYRx5n/bH65tCUmpDj8T
	SOXgaasEZWxT7seMx1K+08rF3dv+hJON+j+N4BdvepxtWcQ5uOT0DHCRitq2UOwOizd6V2o0yJu
	Np///Et4PzTidatVmgg==
X-Google-Smtp-Source: AGHT+IHHa6Gwb6EMwcReUb8w20SMBOY8HUqXKfoIIJGVFOjuon7/sYmIEhsZh0RUa04bS92rGVC4oCZ2kKrrErU=
X-Received: from wmbdv11.prod.google.com ([2002:a05:600c:620b:b0:459:dac7:4ea6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2583:b0:3b8:d893:524c with SMTP id ffacd0b85a97d-3c5dcdfb74cmr1360982f8f.53.1755849539448;
 Fri, 22 Aug 2025 00:58:59 -0700 (PDT)
Date: Fri, 22 Aug 2025 07:58:58 +0000
In-Reply-To: <20250821-num-v4-1-1f3a425d7244@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821-num-v4-0-1f3a425d7244@nvidia.com> <20250821-num-v4-1-1f3a425d7244@nvidia.com>
Message-ID: <aKgjQq9tfRuCq-cr@google.com>
Subject: Re: [PATCH v4 1/2] rust: add `Alignment` type
From: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"

On Thu, Aug 21, 2025 at 09:42:17PM +0900, Alexandre Courbot wrote:
> Alignment operations are very common in the kernel. Since they are
> always performed using a power-of-two value, enforcing this invariant
> through a dedicated type leads to fewer bugs and can improve the
> generated code.
> 
> Introduce the `Alignment` type, inspired by the nightly Rust type of the
> same name and providing the same interface, and a new `Alignable` trait
> allowing unsigned integers to be aligned up or down.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

