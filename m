Return-Path: <linux-kernel+bounces-776634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F302B2CFBD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFBF1C44F57
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DF825C818;
	Tue, 19 Aug 2025 23:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KwB21sgr"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5905F254864
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645296; cv=none; b=SpHDwojiHTmolTElOekoZ4Ce+tURkYTgapl0vtYf+hnTx9b2GKoE2jG8lyjHQ39/HAtTJVdYIxSPFZ0wCkdsS9jiPxMQD8uNgp9kip7minbQSRUVXDBcuDaRFVxFyAnp0/NYSmEBb8haLdKK9vMEScftL55iy3A8p2eWcgFIzQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645296; c=relaxed/simple;
	bh=JtcDbRrByYBzzFUFrg65H4Zj55y3Ey33CzZgyUfMhhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOOjIxx+BGf+clO5k+mlTKqhXeq+3tdPXhfORjjY3WSnS8mk1XThzaflCQyXEyQb/dCkbohvxvR+/H2DSJ4vTOTnuk9RRpIsZisP3LxJusYHd5zyFgyq/GoKRJzvtctP3pcGUBAUHde+vWjNrREedCgf9OOwgyB+Af5dQzRIGUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KwB21sgr; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61a207a248cso6771a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645293; x=1756250093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1KzXEFU36I9rZwWKO00Kwp1smdA7LETmuPE20PF8Lo=;
        b=KwB21sgr/t96MmFe+AsYpaS8q4EqvJTe1DGFAjHSrhOuPQNXeK4dnuQcob55aVNREq
         Nl8JEEKc+ha4qW5NQm4y2OfWIoEQaVC4aQ4CkGUh5dYKhkiDptEDgSqqafMoTvzOvbkP
         Ne0nCIeQzXKprZSB2nvu7d9Un5OFtWsbEbJ07nAos5DabWkxmcdUI1t8+5RZCRnMpQX3
         eRMRnYLv/VBUhUzPzxG2UX4tWR/hdayCChK9FK48bOxl+WodK4C/BCBzmSuP/XCngg0s
         d0rcAuyiEMSEuTr9NzFUKQ4ED6PF/u8Wn7f8w15guQR1y0Q21RlJ+WUCfJQk+diVdzqU
         NbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645293; x=1756250093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1KzXEFU36I9rZwWKO00Kwp1smdA7LETmuPE20PF8Lo=;
        b=vXBcAhluXuMzHkf/ztnVqmiStA6jJJjYt3oowxfO6Y9UPagdOdAL+5n3wJNoMvsEdh
         uzK+74j465Lv1QYPdIISaDo0IUh0k8gNEmLNwbFAmC+fn/o//Lx7nXpCngbUZof1Ox/x
         7z8Nj0keiN13kC9VEnABPO6q6gD3e2O8MjQr3qVhClf16FDFiluEeEjcgUbcc0rhUnuL
         7hv8RUyo7jKGI0SLiZXFQXFQ4/ya5xzWrz7/BFfVGMLju4NC0IS/OP4bhmh+PC7lKZ5C
         NMermtDDVxOhWxAvAcl32jRFssOSlDMwqXeEOhth7Dxv0UABCJBbGtRhCJVtCD4bCBS9
         2nyg==
X-Gm-Message-State: AOJu0YzAteH+KQb6AHOAhr7iKJ0SrtLUYJxC1tVXWb1tmrJXcTqctFJo
	nd5bwtiL4HQEFeA3/03RBPRKxvckVY6xJbemBs2OatdZvcSikWjdYTd0D+zi6588+8Q4SPzrJmQ
	zM4YPe7MiPLe0yMRhnI5pQd5vIL25q5XwJtjm+R0q
X-Gm-Gg: ASbGncuRqfTiVH6gyiv3Ij880JBTn1H6KzaR8UjLUObY8v5TZS3kMJs1pzlU2UEz17h
	R3kJmpvvFPs3THJmpgmkstCIzNSHSWe7HJhPPC+DMWGvmU4olD2wwR0dCK29dlxJd3LjRAKFm5k
	c2EZBxCXasDuyM6Lwq8BGCDMPjeWMDNamjpIcO+xLex9vbIZEffmKtPJydGMzGlBLxJoeyjXLNx
	B7xL3zuTaHEaKSfAxU5Zn8/746c+O3VmuBo3wk8CP33jYlaB/UE+3E=
X-Google-Smtp-Source: AGHT+IE9+sILVkUZSvOYtaQzfkl/5qf3a+gVtvWGoaWDpub9OOBogM4coMZW3hcKQwCZPhnV66ZcDGaVLU8L+UcyDrA=
X-Received: by 2002:a50:d5cb:0:b0:61a:1922:32ac with SMTP id
 4fb4d7f45d1cf-61a98064733mr29569a12.0.1755645292365; Tue, 19 Aug 2025
 16:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
In-Reply-To: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Tue, 19 Aug 2025 16:14:40 -0700
X-Gm-Features: Ac12FXwVWMdTN3oKDSjvFJoOvP3iXIsVXz9GbuFWc5q48MsfxuOMWB0kWK8AyIo
Message-ID: <CAGSQo03RGzmP2diL-vvLDZHduu=d4oFy8X46Fc8vg0SzE-XfDw@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] rust: DebugFS Bindings
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Timur Tabi <ttabi@nvidia.com>, 
	Benno Lossin <lossin@kernel.org>, Dirk Beheme <dirk.behme@de.bosch.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 3:53=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> This series provides safe DebugFS bindings for Rust, with sample
> modules using them.
>
> Shortly after this is sent, you will see a real driver WIP using this
> implenting the qcom socinfo driver.

Now mailed. [1]

[1] https://lore.kernel.org/all/20250819-qcom-socinfo-v1-0-e8d32cc81270@goo=
gle.com/

>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
> Changes in v10:
> - Introduced Scoped to show how either a File or Dir can be bound to
>   data
> - Remove use of `use<>` for MSRV compatibility
> - Added Write support
> - Added more complex sample driver using scoped interface
> - Updated original sample driver to use writes to drive mutation
> - Added `FileOps<T>` (only for DebugFS, not a kernel-wide abstraction)
>   to decrease needed `unsafe` for keeping vtables paired to types.
> - Centralized `dentry` lifecycle management to `entry.rs`.
> - Link to v9: https://lore.kernel.org/r/20250709-debugfs-rust-v9-0-92b9ea=
b5a951@google.com
>
> Changes in v9:
> - Switched to `PinInit` backing instead of `ForeignOwnable`
> - Changed sample to be a platform driver
> - Exported a static property
> - Demonstrated runtime mutation in platform driver (`inc_counter`)
> - Demonstrated how driver code would interact with data structures
>   exported through DebugFS (`Wrapper`)
> - Link to v8: https://lore.kernel.org/r/20250627-debugfs-rust-v8-0-c6526e=
413d40@google.com
>
> Changes in v8:
> - Switched from casts to `core::from_{ref, mut}` in type change
> - Link to v7: https://lore.kernel.org/r/20250624-debugfs-rust-v7-0-9c8835=
a7a20f@google.com
>
> Changes in v7:
> - Rewrote `entry::Entry` -> `Entry`
> - Use `c_int` and `c_void` from kernel prelude rather than core
> - Removed unnecessary `display_open` cast
> - Switched from `Deref` + an explicit box to `ForeignOwnable` for
>   attaching owned data.
> - Made `&'static` and `&'static mut` implement `ForeignOwnable`
> - Swapped "driver" to "module" in sample code
> - Link to v6: https://lore.kernel.org/r/20250618-debugfs-rust-v6-0-72cae2=
11b133@google.com
>
> Changes in v6:
> - Replaced explicit lifetimes with children keeping their parents alive.
> - Added support for attaching owned data.
> - Removed recomendation to only keep root handles and handles you want
>   to delete around.
> - Refactored some code into separate files to improve clarity.
> - Link to v5: https://lore.kernel.org/r/20250505-debugfs-rust-v5-0-3e93ce=
7bb76e@google.com
>
> Changes in v5:
> - Made Dir + File wrappers around Entry
> - All functions return owning handles. To discard without drop, use
>   `forget`. To keep a handle without drop, use `ManuallyDrop`.
> - Fixed bugs around `not(CONFIG_DEBUG_FS)`
> - Removed unnecessary `addr_of!`
> - Link to v4: https://lore.kernel.org/r/20250502-debugfs-rust-v4-0-788a9c=
6c2e77@google.com
>
> Changes in v4:
> - Remove SubDir, replace with type-level constant.
> - Add lifetime to Dir to prevent subdirectories and files from outliving
>   their parents and triggering an Oops when accessed.
> - Split unsafe blocks with two calls into two blocks
> - Access `private` field through direct pointer dereference, avoiding
>   creation of a reference to it.
> - Notably not changed - owning/non-owning handle defaults. The best read
>   I had from the thread was to continue with this mode, but I'm willing
>   to change if need be.
> - Comment changes
>   - More comment markdown
>   - Remove scopes from examples
>   - Put `as_ptr` properties into a `# Guarantees` section.
> - Link to v3: https://lore.kernel.org/r/20250501-debugfs-rust-v3-0-850869=
fab672@google.com
>
> Changes in v3:
> - Split `Dir` into `Dir`/`SubDir`/`File` to improve API.
> - Add "." to end of all comments.
> - Convert INVARIANT to # Invariants on types.
> - Add backticks everywhere I found variables/types in my comments.
> - Promoted invariant comment to doc comment.
> - Extended sample commenting to make it clearer what is happening.
> - Link to v2: https://lore.kernel.org/r/20250430-debugfs-rust-v2-0-2e8d39=
85812b@google.com
>
> Changes in v2:
> - Drop support for builder / pinned bindings in initial series
> - Remove `ARef` usage to abstract the dentry nature of handles
> - Remove error handling to discourage users from caring whether DebugFS
>   is enabled.
> - Support CONFIG_DEBUG_FS=3Dn while leaving the API available
> - Fixed mistaken decimal/octal mixup
> - Doc/comment cleanup
> - Link to v1: https://lore.kernel.org/r/20250429-debugfs-rust-v1-0-6b6e7c=
b7929f@google.com
>
> ---
> Matthew Maurer (7):
>       rust: debugfs: Add initial support for directories
>       rust: debugfs: Add support for read-only files
>       rust: debugfs: Add support for writable files
>       rust: debugfs: Add support for callback-based files
>       samples: rust: Add debugfs sample driver
>       rust: debugfs: Add support for scoped directories
>       samples: rust: Add scoped debugfs sample driver
>
>  MAINTAINERS                              |   4 +
>  rust/bindings/bindings_helper.h          |   1 +
>  rust/kernel/debugfs.rs                   | 613 +++++++++++++++++++++++++=
++++++
>  rust/kernel/debugfs/callback_adapters.rs | 122 ++++++
>  rust/kernel/debugfs/entry.rs             | 164 +++++++++
>  rust/kernel/debugfs/file_ops.rs          | 246 +++++++++++++
>  rust/kernel/debugfs/traits.rs            |  97 +++++
>  rust/kernel/lib.rs                       |   1 +
>  samples/rust/Kconfig                     |  22 ++
>  samples/rust/Makefile                    |   2 +
>  samples/rust/rust_debugfs.rs             | 151 ++++++++
>  samples/rust/rust_scoped_debugfs.rs      | 134 +++++++
>  12 files changed, 1557 insertions(+)
> ---
> base-commit: f3c5631f70e434e318c44001e2417d4770f06cd0
> change-id: 20250428-debugfs-rust-3cd5c97eb7d1
>
> Best regards,
> --
> Matthew Maurer <mmaurer@google.com>
>

