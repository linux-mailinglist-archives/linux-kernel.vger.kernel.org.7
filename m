Return-Path: <linux-kernel+bounces-855168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E396BE0723
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB6058516F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6C931065D;
	Wed, 15 Oct 2025 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XmI27w5x"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1B430F815
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556691; cv=none; b=GOMV+8BolN/kzIc8YOJg+C7Z++bQdtjOLvNuY8KXo67qFwxC2AH0CsF92AiKcsYhCCaepgsyO9YEC59q/HgQOOHAowbPNOH6ohTHQumDZo09vbxNYMgmGPHM1/VEpgG/OJjLJV29BlZYqB6/FITilix5EUOcD1nSIFK0A7ghrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556691; c=relaxed/simple;
	bh=kNflbdkxnSak8W84DQ9chfjwf1iwPVGgDeWnudi49IY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GvxxliKb3U3Zw3dXaUuVrKk0obYsX+98i7EnRll6fqL2rKU99PGyN+V5FDsnV+Fv6Ko9j9ryp7mGwzwTOaCDG6czmhndCDXFfjDCB+J2huh9xbe1zPdCbKSO2Lz+7eDMSZIwJqZPAYu+wZUjwmuxi6BzlSD17mSCtbexVF06lms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XmI27w5x; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-471005f28d2so4231895e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760556688; x=1761161488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2YYTBGsDd4ZJL1eAQVxl6XdilN8lmC3un8gI57oa+wc=;
        b=XmI27w5xlSKnfxgSInyYaWeOIFLoYxyVbK1nfeR85kygPzMmThaIuBowCqgYOJ0Rad
         g5HBqy+tccEtFAfG+OoopcoNG0RvjCJUreF9jam6sNl2+gp3dpMdZZCMtfw9PEG9u+Tu
         PDO9errvqX4ws2qc1YlT2rPDVFYmevwWeN3JyMa5DL0GQhXFGay1cpppj5E+gOUUFFl4
         E8RhiEnCcRduX9qlUPvrWGVpUQUCyNeBRaUp62YcKnlZWWh4t2Wgp8npYisR3YkBue6r
         jGDZdhm7qb/SSPRac/oZrEsHqyr8TuwY5FDUPWPBprUXJWYowMCU4cY+8HepX5th914A
         YA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556688; x=1761161488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YYTBGsDd4ZJL1eAQVxl6XdilN8lmC3un8gI57oa+wc=;
        b=KMTqHdH0gzP5K4CGDVoxLCdSHV2nfzD45i6pr+KcSXWhqS8uYrLZ8KAUbcIqWOFVok
         yEyUKG9lM+tGma2YFmT/9ONF2ZSSxKoti+6a626+cLbYaM2Vt4YpzxIJP9ELdomBR7tH
         +kqVq/Ec9UZiOwDdMfJ/FqhotF9fdzZXmlNHFkg87efHkCoiDk9p7tV3qN/bGN/QOHaf
         ncXeKsd7O+I3ZWcsO/xI95WkYqyTnhRucD3f1AtaaVafM3zL+XQhwry76OtjVd8wVUCj
         UTIWJmdKIxACoKq7/+5C/JfuZv6kXdTlKM56Kqz958CrcUCiRfhA+uIRV3s/NEYgFcte
         UfJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjf7ZPXVKlL6RK3YIGUrVDhtU8YXlxEu1Mn8xZlQUc7wnXokkzBfCmgp3pHnYs+6molXKwmQcE2acVXlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOWyqQ7+yPUkjAnOv0FuTxkVLmGPRbv1oM3xesineslIh1bnca
	rQWLt6v8SLTaoxMV4ajBaEgy7MIfoLOaQuWCoyWU1yrNA4VpM2WwQXNHIW8m6KbU2VuEuQjivyi
	WVFjRxXKWM5ed9kKOCg==
X-Google-Smtp-Source: AGHT+IHkXgCUD/Xg8mwfvq5rsw1NsD7V33g7iy9bartydYztNdh4V9vcMXz0z1HOSr9X/M95RapHcDYXFrnCOyo=
X-Received: from wmoo1.prod.google.com ([2002:a05:600d:101:b0:45d:e2f3:c626])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:529a:b0:46e:59bb:63cf with SMTP id 5b1f17b1804b1-46fa9af31d9mr184569055e9.24.1760556688057;
 Wed, 15 Oct 2025 12:31:28 -0700 (PDT)
Date: Wed, 15 Oct 2025 19:31:27 +0000
In-Reply-To: <20251015-cstr-core-v17-4-dc5e7aec870d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <20251015-cstr-core-v17-4-dc5e7aec870d@gmail.com>
Message-ID: <aO_2j7uQGLbXmZVS@google.com>
Subject: Re: [PATCH v17 04/11] rust_binder: use `core::ffi::CStr` method names
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 15, 2025 at 03:24:34PM -0400, Tamir Duberstein wrote:
> Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
> avoiding methods that only exist on the latter.
> 
> This backslid in commit eafedbc7c050 ("rust_binder: add Rust Binder
> driver").
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

