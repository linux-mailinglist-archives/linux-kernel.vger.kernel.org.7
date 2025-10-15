Return-Path: <linux-kernel+bounces-855167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E25BE070E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A09A585117
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E581230E84B;
	Wed, 15 Oct 2025 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qyiqbtYa"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1230F53C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556672; cv=none; b=n0dIWu0ECaikhv2Yift3DrVcFy945u+/HDWmzuXPLosAAqPIAzr2N/C9SUnf78qlaze4PbMpMFtppmsePnZ+PQiOCezRpPOhx6LsZ8zfPlL17l2e5N2BYkzEvFybKZR/NzmEq+jn33zdXM98WLeM9LZKiddT2wlYsu0x8LicryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556672; c=relaxed/simple;
	bh=M3OmafxYrytddi2fWGeQJQ8nIAlismXr2eiCuylqQ9s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qp/hE50xhKoOdftiARDBNPNsUy7567sZicZk16MuVo0szU/9hN88WxSU+fakfRg8Rs6+f6ECUBCAXHfQ6XXuyVfuhL71c47WmDe3hUI+e0x7eLTzjSNDCw6jVr4uthJAYGRXy3tDQk0Rqe3zo5GTwWTLxsT1CGWk7IuUlggwdqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qyiqbtYa; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e3d9bf9e1so48070395e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760556669; x=1761161469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n9rhvc+XdtkSeql1ngz80HmWK4mJ3tw4/Kibofy2HKs=;
        b=qyiqbtYaPU4E7r/EgAYjBbvh06YOElGo1y6q0VE/i7jMRyDy7vi9059RVcaeQDnhoV
         +6pvGO2MxkFk0jpQmEPVTd76fo6CpN1bf48hk4yh/UTA2ob8k0h0eK52+KV6MhC9/ete
         2uN9QHdzuHgvGDXtocDQogXKHmCR1d2iIMInhi1xk4GTVd+tdp3iKA7ytgcuw1lNO8DR
         B0V/FNLRq3Tq4XOfzPbQVpNMP3/u1OUFzDPC4GRgTiaMca8ActyiC0X8IVOvBBG2AlTU
         1q4pwNAvXy9vdCPxbt0BnmnAyJWuI2lx5JoAq1tolBTO6pLkZHOlK02iam/4ErajhcG+
         91BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556669; x=1761161469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9rhvc+XdtkSeql1ngz80HmWK4mJ3tw4/Kibofy2HKs=;
        b=MsUOH5MGZ97/CSjiP88tC6FcyG+nTMM/rCSG/4TklZx98i4a6QG/8gCIPXWvsmLpM0
         dBRsBL8DcZBJU4t2LQMsMCit41iXDKF23CMxj9Qc963KI5RuPbNItCO8cJKSR7f0CN7r
         QuLPQ5ZaNtUkk8bXFRO3xCHHuJ2CxjK4/OzLE0u3NhePEOCRP6bAHsh9MvbkCVZCrvaw
         bVvY1ZkUAiNlw3KEyojw19hCXUoLnxxvXCODO9iV5HHUiSuLNnLHYjvjvxmR+gMNrmxt
         5dP2udfC7OSVhjvTBaBl917Zc7iTnZr4m+vigW8QfsUzqUlQ/uCeGQTUlNBaGuZrGoCK
         PqCw==
X-Forwarded-Encrypted: i=1; AJvYcCVWACXEkDkS6jsnhgTcddVoonZvXwQzUbbXpcMJDJ6yBvDYBTZ3iKGwbs8n11RqeEb5pcrx4JSSdQSbUX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7msBQ0QNpuMRI8sK6/4D28CMX2BAz8giPgWblR/WFfmyX1jr
	jBRf0+pPj5vCKQQ69v1tlgWLb9ADr3ws7YJbe37hzR15SROuW1rn4eG/MNxhc/YqboS+/boNP/B
	i9+fanvOsCpSpHy9C/g==
X-Google-Smtp-Source: AGHT+IFUuQlqtHR44WvPHRF9KPjT92Y5yOj1YhvXBQy9Crnrgo5UDneJSF9KPTAa9EHr6BuFGJGsfuKxG3RvfpA=
X-Received: from wmfq20.prod.google.com ([2002:a05:600c:2e54:b0:46f:c6cb:516f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:529a:b0:46e:3802:741a with SMTP id 5b1f17b1804b1-46fa9af2d67mr202606365e9.22.1760556668803;
 Wed, 15 Oct 2025 12:31:08 -0700 (PDT)
Date: Wed, 15 Oct 2025 19:31:08 +0000
In-Reply-To: <20251015-cstr-core-v17-3-dc5e7aec870d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <20251015-cstr-core-v17-3-dc5e7aec870d@gmail.com>
Message-ID: <aO_2fAYlMxOHBt7Q@google.com>
Subject: Re: [PATCH v17 03/11] rust_binder: use `kernel::fmt`
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

On Wed, Oct 15, 2025 at 03:24:33PM -0400, Tamir Duberstein wrote:
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
> 
> This backslid in commit eafedbc7c050 ("rust_binder: add Rust Binder
> driver").
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


