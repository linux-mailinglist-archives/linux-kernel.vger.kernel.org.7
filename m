Return-Path: <linux-kernel+bounces-731599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DADBB05704
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9CCB7B797E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9FA2D63EF;
	Tue, 15 Jul 2025 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ntztDOFF"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E99274658
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572850; cv=none; b=UVF8RtNiahqXqNfqW87ZioM3VY5MCj1A50uQjxBGsBnoSI3wQkxTpO1OAhYeNGkoHWHlBniLh6pgOEAREPyMpVK6hOsH38wTm7OMV9qWzCMwY8UC4H1XHgmFw7YGX8JjXJ/wcRv/yvXt9x1akOqs2dNZKGyYb1Jpndw/c4mrmEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572850; c=relaxed/simple;
	bh=MD/cHEVWUxyRKx8Xe3LNcxQnVbBuJ7DgMqEABC9Ja+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PYmiZqGqRkDW+klpcWtW4OHsH+lLfq0l4qVkAPhb6nY+Ygf/Y/gsdsMv4R5HvfrktiRdM7rPISZRzxu5+YF+FsVdl/fcrtfU1eV728KEItU6J3Is5iI7WPrrnqcGjfvn6AfpU9JDVMlXdWrPc/GYQ+ZoUdoUdgi2rSoXAzpkxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ntztDOFF; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso2787713f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752572847; x=1753177647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAt7mLchhRq2293rBJVYgzc28F96UltwoSZXB0nj2GA=;
        b=ntztDOFFITL7lc1+RsHkeA2xgXDDnjb9xZwQt/Y0kAffh+n5pGigkgM7yOPZaeFx+6
         1eTWmvqjM2h9wiL/V14sctnzb9pGoT2BUo841ZJXRLnfHXHu4rnwcl6DDGi7neppql/Y
         C4W9fVoOKzs/IfNzYtx1urlZZsC20ZxalSE+y+/Thsb9xKsMvaS0SPs2nq/or2breBdO
         leYAiynjQ0PJnDYEv79kWPrSH9Cb/aPA9zYIUCq+fzchbRQgqOI0Q9YDAV93nfGs2fxF
         3cc6oH9bF2JkSTpxpzIFsSSbxCIW5DWDkwpI8ZM7RNq4G+YNPR7KekFNqjnoPLM2onA2
         /TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572847; x=1753177647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAt7mLchhRq2293rBJVYgzc28F96UltwoSZXB0nj2GA=;
        b=MeBFiQ4cMADZiPud/KKQZzGnM18RsLpLsniC5W4pdjGpCsnF0nZGo+1lcN+roHQgCV
         XWDAU6t5RxAiPBUTr3rOcSuFqsAf4jbzIhqxG8ZkBGXhumZ9xzAt5bk85pZPtbOn022J
         75toMFMX9/rbhDUwaepmbOyBXvAmZzvqWeW7eZBha8JcuUdnRv5pIg8NMgDvIAfItl+f
         L1fgu9EFTiNI8gpI1NPYDwAuKTqY8EZINcSvWQyhhrKrejaBaJKHQ2VG++AIC/q6PkPc
         PBvTkY5mreuBiqHSIEhkYZA/3pHjjQXBdXxR4WwFmYrNHaXMWiSeqrNQsVt2eGQyuzpV
         HH6A==
X-Forwarded-Encrypted: i=1; AJvYcCVeDJj4MuDI/l1xGPYgYV3ji8zUgWPZn71u53ZnglvP9B0ypgWao7BZYRCOzS9FQJ58zmWGacgyKEp72zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvTOtSUfpoRKuPvaPNGoxoA6UdFRie3AajFuWfk4GGXNbMkbXY
	G4DPKztkgUV93kzo2utRdISk+urF5h4iHhnMAFTyW3V2h6Z9NPonuJspw+HqkLl3JtHPPX5DMxx
	WWf3R4Xe7QX8eK8KP/g==
X-Google-Smtp-Source: AGHT+IGgPN0GJqHxDbm1p54u6euZwVkU3BCJ69/D4ACXUE/vZAeMbVRrrACOkOXbJH1DZAvPkrpcNuKLUWJaL7Y=
X-Received: from wrqd4.prod.google.com ([2002:adf:f844:0:b0:3a8:2eca:bbd4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4915:b0:3a5:39a8:199c with SMTP id ffacd0b85a97d-3b60a1bad29mr1698888f8f.53.1752572846733;
 Tue, 15 Jul 2025 02:47:26 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:47:25 +0000
In-Reply-To: <20250711-rnull-up-v6-16-v3-12-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org> <20250711-rnull-up-v6-16-v3-12-3a262b4e2921@kernel.org>
Message-ID: <aHYjrSPttj0VQ7sg@google.com>
Subject: Re: [PATCH v3 12/16] rnull: enable configuration via `configfs`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 01:43:13PM +0200, Andreas Hindborg wrote:
> Allow rust null block devices to be configured and instantiated via
> `configfs`.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  drivers/block/rnull/Kconfig      |   2 +-
>  drivers/block/rnull/configfs.rs  | 220 +++++++++++++++++++++++++++++++++++++++
>  drivers/block/rnull/rnull.rs     |  58 ++++++-----
>  rust/kernel/block/mq/gen_disk.rs |   2 +-
>  4 files changed, 253 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/block/rnull/Kconfig b/drivers/block/rnull/Kconfig
> index 6dc5aff96bf4..7bc5b376c128 100644
> --- a/drivers/block/rnull/Kconfig
> +++ b/drivers/block/rnull/Kconfig
> @@ -4,7 +4,7 @@
>  
>  config BLK_DEV_RUST_NULL
>  	tristate "Rust null block driver (Experimental)"
> -	depends on RUST
> +	depends on RUST && CONFIGFS_FS
>  	help
>  	  This is the Rust implementation of the null block driver. Like
>  	  the C version, the driver allows the user to create virutal block
> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
> new file mode 100644
> index 000000000000..6c0e3bbb36ec
> --- /dev/null
> +++ b/drivers/block/rnull/configfs.rs
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::{NullBlkDevice, THIS_MODULE};
> +use core::fmt::Write;
> +use kernel::{
> +    block::mq::gen_disk::{GenDisk, GenDiskBuilder},
> +    c_str,
> +    configfs::{self, AttributeOperations},
> +    configfs_attrs, new_mutex,
> +    page::PAGE_SIZE,
> +    prelude::*,
> +    str::CString,
> +    sync::Mutex,
> +};
> +use pin_init::PinInit;
> +
> +pub(crate) fn subsystem() -> impl PinInit<kernel::configfs::Subsystem<Config>, Error> {
> +    let item_type = configfs_attrs! {
> +        container: configfs::Subsystem<Config>,
> +        data: Config,
> +        child: DeviceConfig,
> +        attributes: [
> +            features: 0,
> +        ],
> +    };
> +
> +    kernel::configfs::Subsystem::new(c_str!("rnull"), item_type, try_pin_init!(Config {}))
> +}
> +
> +#[pin_data]
> +pub(crate) struct Config {}
> +
> +#[vtable]
> +impl AttributeOperations<0> for Config {
> +    type Data = Config;
> +
> +    fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
> +        let mut writer = kernel::str::Formatter::new(page);
> +        writer.write_str("blocksize,size,rotational\n")?;
> +        Ok(writer.bytes_written())
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::GroupOperations for Config {
> +    type Child = DeviceConfig;
> +
> +    fn make_group(
> +        &self,
> +        name: &CStr,
> +    ) -> Result<impl PinInit<configfs::Group<DeviceConfig>, Error>> {
> +        let item_type = configfs_attrs! {
> +            container: configfs::Group<DeviceConfig>,
> +            data: DeviceConfig,
> +            attributes: [
> +                // Named for compatibility with C null_blk
> +                power: 0,
> +                blocksize: 1,
> +                rotational: 2,
> +                size: 3,
> +            ],
> +        };
> +
> +        Ok(configfs::Group::new(
> +            name.try_into()?,
> +            item_type,
> +            // TODO: cannot coerce new_mutex!() to impl PinInit<_, Error>, so put mutex inside
> +            try_pin_init!( DeviceConfig {
> +                data <- new_mutex!( DeviceConfigInner {
> +                    powered: false,
> +                    block_size: 4096,
> +                    rotational: false,
> +                    disk: None,
> +                    capacity_mib: 4096,
> +                    name: name.try_into()?,
> +                }),
> +            }),
> +        ))
> +    }
> +}
> +
> +#[pin_data]
> +pub(crate) struct DeviceConfig {
> +    #[pin]
> +    data: Mutex<DeviceConfigInner>,
> +}
> +
> +#[pin_data]
> +struct DeviceConfigInner {
> +    powered: bool,
> +    name: CString,
> +    block_size: u32,
> +    rotational: bool,
> +    capacity_mib: u64,
> +    disk: Option<GenDisk<NullBlkDevice>>,
> +}
> +
> +#[vtable]
> +impl configfs::AttributeOperations<0> for DeviceConfig {
> +    type Data = DeviceConfig;
> +
> +    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
> +        let mut writer = kernel::str::Formatter::new(page);
> +
> +        if this.data.lock().powered {
> +            writer.write_fmt(fmt!("1\n"))?;
> +        } else {
> +            writer.write_fmt(fmt!("0\n"))?;

I think these can just be
writer.write_str("1\n")?;

> +        }
> +
> +        Ok(writer.bytes_written())
> +    }
> +
> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
> +        let power_op: bool = core::str::from_utf8(page)?
> +            .trim()
> +            .parse::<u8>()
> +            .map_err(|_| kernel::error::code::EINVAL)?
> +            != 0;

So if I write 27, that's treated as true, but if I write 300, that's an
EINVAL?

> +        let mut guard = this.data.lock();
> +
> +        if !guard.powered && power_op {
> +            guard.disk = Some(NullBlkDevice::new(
> +                &guard.name,
> +                guard.block_size,
> +                guard.rotational,
> +                guard.capacity_mib,
> +            )?);
> +            guard.powered = true;
> +        } else if guard.powered && !power_op {
> +            drop(guard.disk.take());
> +            guard.powered = false;
> +        }
> +
> +        Ok(())
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::AttributeOperations<1> for DeviceConfig {
> +    type Data = DeviceConfig;
> +
> +    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
> +        let mut writer = kernel::str::Formatter::new(page);
> +        writer.write_fmt(fmt!("{}\n", this.data.lock().block_size))?;
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
> +            .parse::<u32>()
> +            .map_err(|_| kernel::error::code::EINVAL)?;
> +
> +        GenDiskBuilder::validate_block_size(value)?;
> +        this.data.lock().block_size = value;
> +        Ok(())
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::AttributeOperations<2> for DeviceConfig {
> +    type Data = DeviceConfig;
> +
> +    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
> +        let mut writer = kernel::str::Formatter::new(page);
> +
> +        if this.data.lock().rotational {
> +            writer.write_fmt(fmt!("1\n"))?;
> +        } else {
> +            writer.write_fmt(fmt!("0\n"))?;
> +        }
> +
> +        Ok(writer.bytes_written())
> +    }
> +
> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
> +        if this.data.lock().powered {
> +            return Err(EBUSY);
> +        }
> +
> +        this.data.lock().rotational = core::str::from_utf8(page)?
> +            .trim()
> +            .parse::<u8>()
> +            .map_err(|_| kernel::error::code::EINVAL)?
> +            != 0;
> +
> +        Ok(())
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::AttributeOperations<3> for DeviceConfig {
> +    type Data = DeviceConfig;
> +
> +    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
> +        let mut writer = kernel::str::Formatter::new(page);
> +        writer.write_fmt(fmt!("{}\n", this.data.lock().capacity_mib))?;
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
> +            .parse::<u64>()
> +            .map_err(|_| kernel::error::code::EINVAL)?;
> +
> +        this.data.lock().capacity_mib = value;
> +        Ok(())
> +    }
> +}
> diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
> index d07e76ae2c13..d09bc77861e4 100644
> --- a/drivers/block/rnull/rnull.rs
> +++ b/drivers/block/rnull/rnull.rs
> @@ -1,28 +1,26 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  //! This is a Rust implementation of the C null block driver.
> -//!
> -//! Supported features:
> -//!
> -//! - blk-mq interface
> -//! - direct completion
> -//! - block size 4k
> -//!
> -//! The driver is not configurable.
> +
> +mod configfs;
>  
>  use kernel::{
>      alloc::flags,
> -    block::mq::{
> +    block::{
>          self,
> -        gen_disk::{self, GenDisk},
> -        Operations, TagSet,
> +        mq::{
> +            self,
> +            gen_disk::{self, GenDisk},
> +            Operations, TagSet,
> +        },
>      },
>      error::Result,
> -    new_mutex, pr_info,
> +    pr_info,
>      prelude::*,
> -    sync::{Arc, Mutex},
> +    sync::Arc,
>      types::ARef,
>  };
> +use pin_init::PinInit;
>  
>  module! {
>      type: NullBlkModule,
> @@ -35,33 +33,39 @@
>  #[pin_data]
>  struct NullBlkModule {
>      #[pin]
> -    _disk: Mutex<GenDisk<NullBlkDevice>>,
> +    configfs_subsystem: kernel::configfs::Subsystem<configfs::Config>,
>  }
>  
>  impl kernel::InPlaceModule for NullBlkModule {
>      fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
>          pr_info!("Rust null_blk loaded\n");
>  
> -        // Use a immediately-called closure as a stable `try` block
> -        let disk = /* try */ (|| {
> -            let tagset = Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
> -
> -            gen_disk::GenDiskBuilder::new()
> -                .capacity_sectors(4096 << 11)
> -                .logical_block_size(4096)?
> -                .physical_block_size(4096)?
> -                .rotational(false)
> -                .build(format_args!("rnullb{}", 0), tagset)
> -        })();
> -
>          try_pin_init!(Self {
> -            _disk <- new_mutex!(disk?, "nullb:disk"),
> +            configfs_subsystem <- configfs::subsystem(),
>          })
>      }
>  }
>  
>  struct NullBlkDevice;
>  
> +impl NullBlkDevice {
> +    fn new(
> +        name: &CStr,
> +        block_size: u32,
> +        rotational: bool,
> +        capacity_mib: u64,
> +    ) -> Result<GenDisk<Self>> {
> +        let tagset = Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
> +
> +        gen_disk::GenDiskBuilder::new()
> +            .capacity_sectors(capacity_mib << (20 - block::SECTOR_SHIFT))
> +            .logical_block_size(block_size)?
> +            .physical_block_size(block_size)?
> +            .rotational(rotational)
> +            .build(fmt!("{}", name.to_str()?), tagset)
> +    }
> +}
> +
>  #[vtable]
>  impl Operations for NullBlkDevice {
>      #[inline(always)]
> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
> index 39be2a31337f..7ab049ec591b 100644
> --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -50,7 +50,7 @@ pub fn rotational(mut self, rotational: bool) -> Self {
>  
>      /// Validate block size by verifying that it is between 512 and `PAGE_SIZE`,
>      /// and that it is a power of two.
> -    fn validate_block_size(size: u32) -> Result {
> +    pub fn validate_block_size(size: u32) -> Result {
>          if !(512..=bindings::PAGE_SIZE as u32).contains(&size) || !size.is_power_of_two() {
>              Err(error::code::EINVAL)
>          } else {
> 
> -- 
> 2.47.2
> 
> 

