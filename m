Return-Path: <linux-kernel+bounces-723711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97221AFEA34
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5434A6411BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A3A2E1C6F;
	Wed,  9 Jul 2025 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdfwN97u"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A8F2DFA21
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067583; cv=none; b=jEC6ypnoXSE/ODNVWtLCdNFfrlLVToNiTHGRJmEplekmhGdUE5x1Wt6IsVj4OCIiqHjesettH1WAXTHu7JlECgocyydu2vhnOUG49798krVsjQi+/phUgw/+kXyFoCpVa+7/b4iBbUcEP7lrrKh3yHE2u0sL4rfAHigCDZNNfpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067583; c=relaxed/simple;
	bh=EpIPSnFL3zxtw4E9KyJjVoSQ5FEr+FAlGgdFcHUVawA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bkLCfbMozkuGn1Ae8FXHcWgH8sSAhpLnCGiOcoeW4TIQpGZV7AWTz5+HNmMuY1D0sgwHxUoPmbCRAodstQJzmx3H0sRYM1nknGdDUbmSaYvLQ50tscfHcw5kind+37gSnWKnIDE5b/arxpvAAxTPYZeeEBn1pdnJCLyJgXMPgYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdfwN97u; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3af3c860ed7so2579060f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752067580; x=1752672380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/2XZ5Qh0Y8/xBI8hFk5wtj+oH/ehg5gQNl0hSLZ7V4U=;
        b=hdfwN97ueykNPqM9h7gIbIpwras/T9IxChYMMHvdZLmjnZU0Fj/Cz61jMSuuzwxPfU
         PhzeQpzO+B+jVYmC/l+KksYF0PEhbTVBK8S0gCoz7Mi6eT/njDRjYB2oiM5n+1+o4NQu
         QupOVJrgqdlm7k7RBxjh54/wzOcG6zpe+3VhH0c1iJxBCHzyZhWyROUPO7Cs/tAz15vO
         44LziQSzP+gVT+Gtm5GVKJcJ1aTaLieYAulRzg/LNGyQ6vFuPthUGdwqeULWDijSNmBf
         DW8UvLd0LBXD8znDbHnNDPZXkDYMjFDJRFq74FGCeFXDYMbi32CSTx5J1XFShtXkaU8G
         VA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752067580; x=1752672380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2XZ5Qh0Y8/xBI8hFk5wtj+oH/ehg5gQNl0hSLZ7V4U=;
        b=Q4+aTzo2DYtht6D4hpWpLs8PO8q1+nmjqePUVACNtI1XhhT/Zq3+Dvy0E6tddj2gLd
         SELi1h5B9m/GB4G66Gc4HZyFXDro+llg0DZtxuYuns/xkyF1BzQnP4UEa90LjA3xQkQu
         7A/PyKnkUfe/aZlYwxkAI+gnmpzq05DxFoRAy+iyakhYLoR7c37aBwEQhfsLZvjWRVN9
         Iw5fkN5dhLQ2qr0RoztsJwssAJOsNs3a3NDjZ76Ou5dmkUKBa3OrCyjvbzIXrIYilsD4
         5zi/hXbBGt2vrAwMB6zDHXdqhorsJpbfvjQtoMTyv9hAzsSJAFJxN024H1mS0y28c2OU
         ICkA==
X-Forwarded-Encrypted: i=1; AJvYcCUOpDTk1nnhMstzJO1RfHFYyjshTQJCkVh9iHzoGIRpfswpX1LP1tdbwH8ctv0/YbJBdv4+PD/mhf7kVL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoRhOsVpHUJlrcBgL9V75wB0DYeoU+a1ceM9fLlV8Msrgrb4lN
	MY4KaheW//4nIx6VJZz5NBN67JE2CLgO32Wa3QefElw6iESoEqXb7tVVeawEwbnL5f2u9b2DAQn
	hRrAPw+cBKBxvInDcTw==
X-Google-Smtp-Source: AGHT+IF+xK3vC0GxnM5YgdFqU78a1/83sM+KndWW9pR/GYUNx+a3eu0I/KM87az6bLdBJy/RPRIBoTlPLaO8DO4=
X-Received: from wmpz13.prod.google.com ([2002:a05:600c:a0d:b0:43c:f8ae:4d6c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4287:b0:3a4:f66a:9d31 with SMTP id ffacd0b85a97d-3b5e4514e3fmr2393240f8f.16.1752067580535;
 Wed, 09 Jul 2025 06:26:20 -0700 (PDT)
Date: Wed, 9 Jul 2025 13:26:19 +0000
In-Reply-To: <20250708-rnull-up-v6-16-v2-4-ab93c0ff429b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org> <20250708-rnull-up-v6-16-v2-4-ab93c0ff429b@kernel.org>
Message-ID: <aG5t-1nadCfvD9uF@google.com>
Subject: Re: [PATCH v2 04/14] rust: block: normalize imports for `gen_disk.rs`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 08, 2025 at 09:44:59PM +0200, Andreas Hindborg wrote:
> Clean up the import statements in `gen_disk.rs` to make the code easier to
> maintain.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

