Return-Path: <linux-kernel+bounces-735570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E7B09117
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD735A0D96
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5EF2FA64A;
	Thu, 17 Jul 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="b/YitFHn"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B62FA625;
	Thu, 17 Jul 2025 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767752; cv=none; b=iSiuI4yNIaElIjLnvNaz7a+kJ4Aw4WTHf4jP0Qv3L79H1JPLqfXMYBInH5Sx6nhrSdNtQp2l2HYmD1enZMoPAFQqjIAn8Kdu0NowMUebxiAWUibZi77EfWvVC1ZSzAfpriDD8ntHgmCqztyB3W10KOhhn+2AEOfuuvTqRVyfNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767752; c=relaxed/simple;
	bh=uhGrghdG8minX6bUvQj7vq3dG2H6jbu2H+Z33Az9x80=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LHlewfiVlSviWgSUVsqRLIZNVgdF/uaX8S9n+IoUrGlbuei75E+mdnStUfuvY4lUM/FhVIPvcxDYX6i3rUB3jI8tBRIkfkyBTqC4vDphBV5lnwbzqhxc0bBTI4LkyxQF+0Q7IAQ+H0b8Spmrd2Jh0BD40G29KYsFjalI6zY+HVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=b/YitFHn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752767749;
	bh=uhGrghdG8minX6bUvQj7vq3dG2H6jbu2H+Z33Az9x80=;
	h=From:Subject:Date:To:Cc:From;
	b=b/YitFHngT9jes2PlapGwIKXpHGo3zUA6I5+e6iAOzJtrxyral7S+IQAXE22zytO2
	 AMGEQ1ofOTrlSaobFGRX6hDq+7r7STmvyfyqISOYNU6zi0NHAKvNlgJt5/z7CaJLuT
	 lbCUT8pulHY6uL8qmYLBGWlilY802X7t43wKrPrMha8ADK91dMAA4CalKCIV2FbSFK
	 3YLDkcTEupWtocZEL7cap3nfnoBBr8UkEVm0tLeUHsBJtH/MvzbOqJe+n3ukTuzNKT
	 Pe9vRsnuPe8Pymai0o118TbyTJ4q3OMe6vL+LRAt1BiWvn+DXVIQFk/2ryX4z9/HLA
	 a9MowrnMfqORw==
Received: from [192.168.0.2] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D1EC717E1298;
	Thu, 17 Jul 2025 17:55:46 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v15 0/3] rust: platform: add Io support
Date: Thu, 17 Jul 2025 12:55:21 -0300
Message-Id: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOkceWgC/43OzWrDMAzA8VcZOc9F8rd32nuMMRxbWQ1JXZwQV
 krffU4vKV0IO0qgn/7XZqSSaGzeXq5NoTmNKZ/qgOr1pQlHf/omlmJdNBy4AoGWTfmcwsimS2H
 n3k9dLsNXygMNDA2CR2MIY9fU+3OhLv3c8Y/POnclD2w6FvKriAI4B8XdQWtlnWbIoj8l6g++H
 yhF/x5y3/s2F38IeVjYYxqnXC735Nks+H/iZsOAGSmsdhgddeYJXgJnu2oK3J5mq0auQ8OVl/A
 n8665VdMg9jRXNc8NgURlSNCWhvDA8V0OYamLVoNXmjsJmx6ungHc9bB6OkQV62tEhZueePBw3
 xPVAy24bRXK2IpNTz56eteT1eOBG3AoVGj5s3e73X4BWnViBeoCAAA=
X-Change-ID: 20250318-topics-tyr-platform_iomem-1710a177e1df
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Fiona Behrens <me@kloenk.dev>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

Changes in v15:
- Use a default string in ioremap() if the resource doesn't have a name
- Fix the doctests in mem.rs to use the new name for io_request_by_*
- Link to v14: https://lore.kernel.org/r/20250716-topics-tyr-platform_iomem-v14-0-2c2709135cb2@collabora.com

Changes in v14:
- Changed Resource::size() to return ResourceSize instead of u64 (Alice)
- Changed Resource::name() to return a non-static lifetime (i.e.: the
  lifetime of &self). It turns out that although this value tends to often
  point to string literals, this value is not necessarily static  in C.
  (Thanks for bringing this up, Alice)
- "name" is now owned by the Region. We were storing Resource::name()
  previously as that was 'static, but that is not the case anymore. The
  string is now copied from Resource::name() instead. If there is no name,
  we fail.
- Changed Resource::name() to return an Option, as the name may be NULL in
  C (see the DEFINE_RES_* family of macros in C)
- Added a TODO to the "size" cast in IoMem::ioremap(), noting that we
  should fix this in C in the future (Thanks, Alice)
- Casting "size" in IoMem::ioremap() only once now (thanks, Alice)
- Introduced Flags::new(), which derives from a comment in the request_irq
  series. This introduces a build_assert to reduce the number of casts.
- Added Alice's r-b to patches 1-2
- Added Miguel's a-b to patches 1-3 (Given in v11 and forgotten)
- Link to v13: https://lore.kernel.org/r/20250711-topics-tyr-platform_iomem-v13-0-06328b514db3@collabora.com

Changes in v13:
- Change ResourceSize to just be bindings::phys_addr_t (Danilo)
- Mention that ResourceSize can be 32bits even on 64bit architectures (Alice)
- Use the deref impl for Resource to avoid unsafe (Alice)
- Change Resource::as_ref() to Resource::from_raw() (Alice)
- Mention that it's ok for __request_region to store the name as we require
  it to be 'static
- Remove all instances of core::ffi::* as these are in the prelude already
  (Alice)
- Resource::start() and Resoruce::flags() do not copy &self anymore (Alice)
- Define the resource::Flags constants within impl Flags itself (Alice)
- Apply the diff from Danilo to return impl PinInit<...> instead of
  Result<impl PinInin<...>> from the iomap() functions.
- Fix the docs in patch 2 (Alice)
- Use try_into() instead of blindly casting ResourceSize to usize (Alice)
- Rename request_io_by{index,name} to io_request_by{index,name} (Danilo)
- Link to v12: https://lore.kernel.org/rust-for-linux/20250704-topics-tyr-platform_iomem-v12-0-1d3d4bd8207d@collabora.com/

Changes in v12:
- Fixed the typos that Miguel pointed out in resource.rs
- Fixed a typo where thread was written as thead
- Removed ioport_resource() and iomem_resource() (Danilo)
- Created IoRequest<'a> and gave it an unsafe constructor (Danilo)
- Moved all the logic to map resources from platform.rs to IoRequest.
- Dropped the last patch as a result of the above.
- Link to v11: https://lore.kernel.org/r/20250701-topics-tyr-platform_iomem-v11-0-6cd5d5061151@collabora.com

Changes in v11:
- Rebased on top of driver-core-next (to get the latest Devres changes)
- Changed the order between requesting the resource and mapping it
  (Danilo)
- Link to v10: https://lore.kernel.org/r/20250623-topics-tyr-platform_iomem-v10-0-ed860a562940@collabora.com

Changes in v10:
- Rebased on driver-core-next
- Fixed examples (they were still using try_access())
- Removed map_err() from the examples, as it was not needed.
- Added a pub use for Resource in io.rs
- Reworked the platform code to make use of the pub use above
- Link to v9: https://lore.kernel.org/r/20250603-topics-tyr-platform_iomem-v9-0-a27e04157e3e@collabora.com

Changes in v9:
- Rebased on top of nova-next (for Devres::access())
- Reworked the documentation to add more markdown.
- Converted to &raw mut instead of addr_of_mut!()
- Renamed 'from_ptr' to 'as_ref' for consistency
- Changed the IoMem examples to use the signature for probe()
- Changed resource() to resource_by_index(). It's a better fit given
  the existance of resource_by_name().
- Created a separate patch for the resource accessors above.
- Moved the accessors into the generic impl block, so they work with all
  Device contexts.
- Take Device<Bound> where applicable
- Renamed "ioremap_*" to "iomap_*", in order to be consistent with the code
  in pci.rs
- Switched to Devres::access()
- Link to v8: https://lore.kernel.org/r/20250509-topics-tyr-platform_iomem-v8-0-e9f1725a40da@collabora.com

rust: platform: add Io support

Changes in v8:
- Rebased on driver-core-next
- Opted to wait for 'rust/revocable: add try_with() convenience method' to
  land instead of using the suggested closure (let me know if we should
  just switch to the closure anyways)
- Cc'd more people
- Link to v7: https://lore.kernel.org/r/20250318-topics-tyr-platform_iomem-v7-0-7438691d9ef7@collabora.com

Changes in v7:

- Rebased on top of rust-next
- Fixed a few Clippy lints
- Fixed typos (Thanks Daniel!)
- "struct Flags" now contains a usize (thanks Daniel)
- Fixed "Doc list without indentation" warning (thanks, Guangbo)

Thanks, Fiona {
- Removed RequestFn, as all functions simply used request_region and RequestFn
  had issues. Only request_region() is exposed now.
- Gated iomem_resource on CONFIG_HAS_IOMEM
- Require that the name argument be 'static
}

- Correctly check for IORESOURCE_MEM_NONPOSTED. We now call ioremap_np if that
  is set (thanks, Lina!)
- Remove #[dead_code] attribute from ExclusiveIoMem::region.

Changes in v6:

- Added Fiona as co-developer in the first patch, as I merged part of her code
from the LED driver series (thanks, Fiona)

- (Fiona) added the ResourceSize type, thereby fixing the u32 vs u64 issues
  pointed out by Christian

- Moved the request_region, release_region and friends to resource.rs

- Added the Region type. This type represents a resource returned by
  `request_region` and friends. It is also owned, representing the fact
  that the region remains marked as busy until release_region is called on
  drop. (Thanks Alice, for pointing out this pattern)

- Rewrote the IoMem abstraction to implement a separate type for exclusive
  access to an underlying region. I really disliked the `EXCLUSIVE` const
  generic, as it was definitely not ergonomic, i.e.:

  `IoMem<0, false>`

  ...doesn't really say much. In fact, I believe that boolean parameters
  hurt readability in general.

  This new approach lets users build either regular IoMem's, which basically
  call ioremap under the covers, and ExclusiveIoMem's , which also call request_region
  via the Region type.

- Added access to the ioresource_port and ioresource_mem globals.

Link to v5: https://lore.kernel.org/rust-for-linux/20250116125632.65017-1-daniel.almeida@collabora.com/

Changes in v5:

- resend v5, as the r4l list was not cc'd
- use srctree where applicable in the docs (Alice)
- Remove 'mut' in Resource::from_ptr() (Alice)
- Add 'invariants' section for Resource (Alice)
- Fix typos in mem.rs (Alice)
- Turn 'exclusive' into a const generic (Alice)
- Fix example in platform.rs (Alice)
- Rework the resource.is_null() check (Alice)
- Refactor IoMem::new() to return DevRes<IoMem> directly (Danilo)

link to v4: https://lore.kernel.org/rust-for-linux/20250109133057.243751-1-daniel.almeida@collabora.com/

Changes in v4:

- Rebased on top of driver-core-next
- Split series in multiple patches (Danilo)
- Move IoMem and Resource into its own files (Danilo)
- Fix a missing "if exclusive {...}" check (Danilo)
- Fixed the example, since it was using the old API (Danilo)
- Use Opaque in `Resource`, instead of NonNull and PhantomData (Boqun)
- Highlight that non-exclusive access to the iomem might be required in some cases
- Fixed the safety comment in IoMem::deref()

Link to v3: https://lore.kernel.org/rust-for-linux/20241211-topic-panthor-rs-platform_io_support-v3-1-08ba707e5e3b@collabora.com/

Changes in v3:
- Rebased on top of v5 for the PCI/Platform abstractions
- platform_get_resource is now called only once when calling ioremap
- Introduced a platform::Resource type, which is bound to the lifetime of the
 platform Device
- Allow retrieving resources from the platform device either by index or
 name
- Make request_mem_region() optional
- Use resource.name() in request_mem_region
- Reword the example to remove an unaligned, out-of-bounds offset
- Update the safety requirements of platform::IoMem

Changes in v2:
- reworked the commit message
- added missing request_mem_region call (Thanks Alice, Danilo)
- IoMem::new() now takes the platform::Device, the resource number and
 the name, instead of an address and a size (thanks, Danilo)
- Added a new example for both sized and unsized versions of IoMem.
- Compiled the examples using kunit.py (thanks for the tip, Alice!)
- Removed instances of `foo as _`. All `as` casts now spell out the actual
 type.
- Now compiling with CLIPPY=1 (I realized I had forgotten, sorry)
- Rebased on top of rust-next to check for any warnings given the new
 unsafe lints.

---
Daniel Almeida (3):
      rust: io: add resource abstraction
      rust: io: mem: add a generic iomem abstraction
      rust: platform: add resource accessors

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/io.c               |  41 ++++++
 rust/kernel/io.rs               |   5 +
 rust/kernel/io/mem.rs           | 283 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/io/resource.rs      | 229 ++++++++++++++++++++++++++++++++
 rust/kernel/platform.rs         |  60 ++++++++-
 6 files changed, 618 insertions(+), 1 deletion(-)
---
base-commit: f5d3ef25d238901a76fe0277787afa44f7714739
change-id: 20250318-topics-tyr-platform_iomem-1710a177e1df

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


