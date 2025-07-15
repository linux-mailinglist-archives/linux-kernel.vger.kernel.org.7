Return-Path: <linux-kernel+bounces-731615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C199B05732
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02BF3AF1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC69C2D63ED;
	Tue, 15 Jul 2025 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYIDa0s9"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08E2D542A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573252; cv=none; b=PbImaCdcCm7+XigAX5Vejy+sVxQ/6Ihq7crBb8KKI8oIzxLbVjd+JPPBc5grjtKBQhoCKeuhwKzA3Jjt4868sJUZkDMqmh7gO4pzq5hGa5WaoaqzBdU9UqFn7RTI04NGiZFPdn4PuctR6iOdY1b5/KczIpJgPbsC/819jy4LnNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573252; c=relaxed/simple;
	bh=FItGyW8nimCshTyrVdStcZ8wr8/YBuniLgbjSo3h7WQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uIEGwWj4LCZLTCqCWrGgoo5ttg/rbjvHhrEHQ7is1abOSi2Ri7fKDAog9Wmb+m0IMLjtMfFPGAoRQkpVlxY0h2IXxAejMk5R/yxtKvgDEfxB5p5sO9YIGK7AJsSHJFyMqWOC1NBvtarn8+mp49mF8K9/sExhsuE2GyW20aiW5ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYIDa0s9; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45624f0be48so4947715e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752573248; x=1753178048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp5GBgsM/GT6S6VKbK948jD04WLTfcMDMRyGqwJi5HU=;
        b=nYIDa0s9EPbv0SG1k5u2P0TbXAv6RPl0uXt9Fdwu9THSi8axcq5BwtzzjO502tmBQG
         94ZrOHG+fmKr96JMF2DMrZqjhSaw6Kbg4Kbui/ZVE2WXAy+OhEMT1dG5I8/K406T9Rwa
         qqE37onECrJ3xuZ3qFkw6cwTcAczRJ+Jvb3kU09kZ0jF+6h8F3XSxNxEXE5gX1gAs06Q
         MrOFiv3H6cyGHXNKkiBnd04SC0jfUkbPu02mgfFSf/ueGlSU+oR1ZsJp+azlk6pulHMc
         j1rxdnbEPPn5zR9y85F5R86kYxtS+ba1rhTxLdJd/8bMMJig5iLgF1Xs4/wLAXyeRO4B
         BlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573248; x=1753178048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp5GBgsM/GT6S6VKbK948jD04WLTfcMDMRyGqwJi5HU=;
        b=Lr6TCpMpthM/PbZaWXlAmbnSVuY/x9CZQwVG+/pgRlPFp7LWSFPISfib1Aat4C+lwM
         1Z9xbERIkPOK821e7PqgbHxXzQ7KdnTVC41k/aHgJ4Ndl18Z/bSjAdafdFNg7QTfEiDT
         Vv3KtKKha4ZOO7tMQolUS5njGVR9Jqvfq/Bu8IZnfafolEuVy8ZWYoT2xuVBh8PJHNmS
         6cgbt+mrQgeqitm7M+VhHN9YgFiPOTcvk4QS5tBxAofY04qALQ3Ezd/RxGpk2oYNpDTV
         PAgLsuxcypOkV9L/9oDQXKX2Zn0HV/JmfB5xdLLKEo9jY43Jb8B2Kve7pLMefX/6qMac
         sSbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9qHgYWmLyKjKS8HuqFYuZofNFegIwG6ka2SPVngrx1aG9fh96wyRS0YZDGQUeqQxUj6glEQUOA8sKWx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCaLNPi3Hjs3DuUu+p2nsVQy09idSHoK3iF7zBq5eSF5IY5sCD
	D9/ETxdi0xQGEBjIf0PEJUs+RqEwN/9vZbmHFdjJdBskTcC4kDaYeROOUbrkO0CZXJSuZNYINeH
	nOd75WUFBK45osVIwSg==
X-Google-Smtp-Source: AGHT+IGGxjE3JPjoWX6iYc3kdOka7g4M+LKkBFbtVuyY2sgGCBGSXjsN0V1abh1tiQmQYxqqwxXDiLdFIZRicAk=
X-Received: from wmqb20.prod.google.com ([2002:a05:600c:4e14:b0:456:25e7:be1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:34c5:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-45565edc8f4mr130514075e9.23.1752573247648;
 Tue, 15 Jul 2025 02:54:07 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:54:06 +0000
In-Reply-To: <20250711-rnull-up-v6-16-v3-16-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org> <20250711-rnull-up-v6-16-v3-16-3a262b4e2921@kernel.org>
Message-ID: <aHYlPkFKTafRypNu@google.com>
Subject: Re: [PATCH v3 16/16] rnull: add soft-irq completion support
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 01:43:17PM +0200, Andreas Hindborg wrote:
> rnull currently only supports direct completion. Add option for completing
> requests across CPU nodes via soft IRQ or IPI.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  drivers/block/rnull/configfs.rs | 61 +++++++++++++++++++++++++++++++++++++++--
>  drivers/block/rnull/rnull.rs    | 32 +++++++++++++--------
>  2 files changed, 80 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
> index 6c0e3bbb36ec..3ae84dfc8d62 100644
> --- a/drivers/block/rnull/configfs.rs
> +++ b/drivers/block/rnull/configfs.rs
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  use super::{NullBlkDevice, THIS_MODULE};
> -use core::fmt::Write;
> +use core::fmt::{Display, Write};
>  use kernel::{
>      block::mq::gen_disk::{GenDisk, GenDiskBuilder},
>      c_str,
> @@ -36,7 +36,7 @@ impl AttributeOperations<0> for Config {
>  
>      fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
>          let mut writer = kernel::str::Formatter::new(page);
> -        writer.write_str("blocksize,size,rotational\n")?;
> +        writer.write_str("blocksize,size,rotational,irqmode\n")?;
>          Ok(writer.bytes_written())
>      }
>  }
> @@ -58,6 +58,7 @@ fn make_group(
>                  blocksize: 1,
>                  rotational: 2,
>                  size: 3,
> +                irqmode: 4,
>              ],
>          };
>  
> @@ -72,6 +73,7 @@ fn make_group(
>                      rotational: false,
>                      disk: None,
>                      capacity_mib: 4096,
> +                    irq_mode: IRQMode::None,
>                      name: name.try_into()?,
>                  }),
>              }),
> @@ -79,6 +81,34 @@ fn make_group(
>      }
>  }
>  
> +#[derive(Debug, Clone, Copy)]
> +pub(crate) enum IRQMode {
> +    None,
> +    Soft,
> +}
> +
> +impl TryFrom<u8> for IRQMode {
> +    type Error = kernel::error::Error;
> +
> +    fn try_from(value: u8) -> Result<Self> {
> +        match value {
> +            0 => Ok(Self::None),
> +            1 => Ok(Self::Soft),
> +            _ => Err(kernel::error::code::EINVAL),
> +        }
> +    }
> +}
> +
> +impl Display for IRQMode {
> +    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
> +        match self {
> +            Self::None => f.write_str("0")?,
> +            Self::Soft => f.write_str("1")?,
> +        }
> +        Ok(())
> +    }
> +}
> +
>  #[pin_data]
>  pub(crate) struct DeviceConfig {
>      #[pin]
> @@ -92,6 +122,7 @@ struct DeviceConfigInner {
>      block_size: u32,
>      rotational: bool,
>      capacity_mib: u64,
> +    irq_mode: IRQMode,
>      disk: Option<GenDisk<NullBlkDevice>>,
>  }
>  
> @@ -126,6 +157,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
>                  guard.block_size,
>                  guard.rotational,
>                  guard.capacity_mib,
> +                guard.irq_mode,
>              )?);
>              guard.powered = true;
>          } else if guard.powered && !power_op {
> @@ -218,3 +250,28 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
>          Ok(())
>      }
>  }
> +
> +#[vtable]
> +impl configfs::AttributeOperations<4> for DeviceConfig {
> +    type Data = DeviceConfig;
> +
> +    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
> +        let mut writer = kernel::str::Formatter::new(page);
> +        writer.write_fmt(fmt!("{}\n", this.data.lock().irq_mode))?;
> +        Ok(writer.bytes_written())
> +    }
> +
> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
> +        if this.data.lock().powered {
> +            return Err(EBUSY);
> +        }
> +
> +        let text = core::str::from_utf8(page)?.trim();
> +        let value = text
> +            .parse::<u8>()
> +            .map_err(|_| kernel::error::code::EINVAL)?;

EINVAL is in the prelude.

> +
> +        this.data.lock().irq_mode = IRQMode::try_from(value)?;
> +        Ok(())
> +    }
> +}
> diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
> index 371786be7f47..85b1509a3106 100644
> --- a/drivers/block/rnull/rnull.rs
> +++ b/drivers/block/rnull/rnull.rs
> @@ -4,6 +4,7 @@
>  
>  mod configfs;
>  
> +use configfs::IRQMode;
>  use kernel::{
>      alloc::flags,
>      block::{
> @@ -54,35 +55,44 @@ fn new(
>          block_size: u32,
>          rotational: bool,
>          capacity_mib: u64,
> +        irq_mode: IRQMode,
>      ) -> Result<GenDisk<Self>> {
>          let tagset = Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
>  
> +        let queue_data = Box::new(QueueData { irq_mode }, flags::GFP_KERNEL)?;
> +
>          gen_disk::GenDiskBuilder::new()
>              .capacity_sectors(capacity_mib << (20 - block::SECTOR_SHIFT))
>              .logical_block_size(block_size)?
>              .physical_block_size(block_size)?
>              .rotational(rotational)
> -            .build(fmt!("{}", name.to_str()?), tagset, ())
> +            .build(fmt!("{}", name.to_str()?), tagset, queue_data)
>      }
>  }
>  
> +struct QueueData {
> +    irq_mode: IRQMode,
> +}
> +
>  #[vtable]
>  impl Operations for NullBlkDevice {
> -    type QueueData = ();
> +    type QueueData = KBox<QueueData>;
>  
>      #[inline(always)]
> -    fn queue_rq(_queue_data: (), rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
> -        mq::Request::end_ok(rq)
> -            .map_err(|_e| kernel::error::code::EIO)
> -            // We take no refcounts on the request, so we expect to be able to
> -            // end the request. The request reference must be unique at this
> -            // point, and so `end_ok` cannot fail.
> -            .expect("Fatal error - expected to be able to end request");
> -
> +    fn queue_rq(queue_data: &QueueData, rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
> +        match queue_data.irq_mode {
> +            IRQMode::None => mq::Request::end_ok(rq)
> +                .map_err(|_e| kernel::error::code::EIO)
> +                // We take no refcounts on the request, so we expect to be able to
> +                // end the request. The request reference must be unique at this
> +                // point, and so `end_ok` cannot fail.
> +                .expect("Fatal error - expected to be able to end request"),
> +            IRQMode::Soft => mq::Request::complete(rq),
> +        }
>          Ok(())
>      }
>  
> -    fn commit_rqs(_queue_data: ()) {}
> +    fn commit_rqs(_queue_data: &QueueData) {}
>  
>      fn complete(rq: ARef<mq::Request<Self>>) {
>          mq::Request::end_ok(rq)
> 
> -- 
> 2.47.2
> 
> 

