Return-Path: <linux-kernel+bounces-860541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E80CABF05C3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9352934B070
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D402E8B62;
	Mon, 20 Oct 2025 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DI7m1xyh"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9270823E35B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954488; cv=none; b=Vota2hNJqcuZSt9zgDD+snmXyiaL+Tm2mF94xleXT0oIetFdxGfmubOciLSQxlD/0Y5z/9FKAPzJrDQaIM+k4xiRAnB/Thk8JwdkgQ2U8ff1amgGnArp5rICIZpf7oKnBMbfwuHOQeWHgFgEzRtmL8cQxe2byJ2DP3HDM8WzKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954488; c=relaxed/simple;
	bh=mhITn3HDo0uQ823iD054gcNgABztLTs2sqLqGtvUuxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qK9MsYXfqs4+vVeJQQJyjfpYqTK4oBvozsz97s05+i49vfnGKqTVJEhpMaxNSlQujhj+BzMmGjYkVtUM2AYC92eRf116p8Ye8BS1p9ZRVmpX2MtXh+w3mbcT6jxYEHxysx447MO13R+jtNPVSTyvEFy6Rt2YWE0bwA7+c8/GQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DI7m1xyh; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47106720618so24366845e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760954485; x=1761559285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0l1K7JIIcbBvkAiIx/D88CHUVKA5vo6fkTzO0AUaHY=;
        b=DI7m1xyhb1cJqgJQYHoz4KCfk9x21tB/H9AjSRDJWLldf/LEiZ6EJcCS9Fr/YqKchS
         tXy3Cv8KinM/Echpsq4GlvupQ1sf7jvkG4evdZVYs84SMy4QeKnm6ZhM5ncJeTiO/Vmj
         Usm2Y2UeQn8F0p0JdSJ2YoxR2BWUEmlvIb8yA0CaZOt59e9Vpj22rtqfsb0ZYyyY9HOd
         uGZ5W5e9cD4suAcGvAACa9Bp2I/KIrx2MPfKUSpVuVhVQ2pz2waC7sHXtNnfrMb3ivw6
         LS4z0tmmNC0tyk3KpUj0D0XeJCdquRTyQd9jBIGGwkageH9uOTFvQy03XGy5SnmzHELI
         F9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954485; x=1761559285;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0l1K7JIIcbBvkAiIx/D88CHUVKA5vo6fkTzO0AUaHY=;
        b=TRmlD9WwRylQSX8CqCB9XitzuYL4Y1RVVVpYBMLU8AFDWmZib8LcmqEY1qWQF4rddZ
         vh/ryXBzs+z5Clu8pQ1p3sKuLBHFXHSe5NEU7CTLZ+5EKWyf44jPFJVRL57zJ4Z8evNB
         HMOmxP1uVFp3Ywm8JBupnDbzbGoIqXXgpecJRJFl8BLdleV8yakx1kUCk6iwj2bv+DFL
         SngUz0Km6s6C5Bxy/CIh61Bb8+frbomU0aBTky3Iq8L73Pn5/Ovh9M5ejSw4q+fxh8Yl
         FGm5vcuhgbbtjNiH0jZo8YdNmXznXbppCzuZzbTu5kxuQY9BW3TgrhZjFb+pCe9eNsvW
         FSVA==
X-Forwarded-Encrypted: i=1; AJvYcCVO68joYYqusdx228ZvPynq8qSjRwOOuH2VjpgdlbCh2NxEscxKNCT5qSUfjWWLkWo6Y7vJHphHF0gHs20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD55HLv/V4ORDTGPRSwW0UsH46FMcqUkGXl20r0+8QEtqyLGJ7
	0QVQZPTWHGufrCTN2x+f889pw93kXzIkPDwr4M2VflS2uTDUx7OxY4qc5iXHvaAoyHmA+XAi6J8
	fIFAODML83HJ7nSADQA==
X-Google-Smtp-Source: AGHT+IFATPYHlVFBmlLsBVvlR3qG2Rbu19LkskrwZ1g9wMvquqf+maELC/ipWw6CiyqUDRaelkkGsv2zR0WAluY=
X-Received: from wmbd1.prod.google.com ([2002:a05:600c:58c1:b0:45d:eb3b:5482])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:548c:b0:46d:5189:3583 with SMTP id 5b1f17b1804b1-471177bad0dmr87865495e9.0.1760954485032;
 Mon, 20 Oct 2025 03:01:25 -0700 (PDT)
Date: Mon, 20 Oct 2025 10:01:24 +0000
In-Reply-To: <20251003222729.322059-6-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003222729.322059-1-dakr@kernel.org> <20251003222729.322059-6-dakr@kernel.org>
Message-ID: <aPYIdIk7jXruPeV0@google.com>
Subject: Re: [PATCH 5/7] samples: rust: debugfs: add example for blobs
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, Oct 04, 2025 at 12:26:42AM +0200, Danilo Krummrich wrote:
> Extend the Rust debugfs sample to demonstrate usage of binary file
> support. The example now shows how to expose both fixed-size arrays
> and dynamically sized vectors as binary blobs in debugfs.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

