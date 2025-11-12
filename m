Return-Path: <linux-kernel+bounces-897991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2CBC5416D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7F53B846D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6940E34F46A;
	Wed, 12 Nov 2025 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN3uq/uD"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126734DCDE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974565; cv=none; b=PK0IzZomqojJ+a8VCY+0MRLz16hAtR69sUECu+fxNpsu3uqbX3oX1Q6lKzIbUhpL27vHzSiMp90Di94UBSAZK/Fn5eBStfea6UJ38XgZ28dJ1CWrup0SFxc/eiOcNKiYqGQ5fOxwVUi4KDEOnZxrjsHlUvXm4YFpmtDz7kawldk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974565; c=relaxed/simple;
	bh=doOipufOprAR6hfC2H6pC4ypIpujTWR+dx7K6fca1wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Irmk29AjML8mjKW2p7WUIyin76VV0Oj7KZXXmJ/e9FV+r+1pQAQP/1eQypZEo24gRzshowphbcPOJwpay1xYgWPbXs8Ne8LrmQ2ADNN+ST7O8+p4p+zr3ZX9qa+JWMg0eZ3OlVJowDMZ8l0/TFzQGJyVQBNUUkMjwibdtfSfHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lN3uq/uD; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b26be00d93so3733285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762974562; x=1763579362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejeIvsq+a1dgP5WXvm2OFT/yoRAahndq1U3uROJjEIs=;
        b=lN3uq/uDMBnzeuhID5J61n6Dlz7Azsco/+gFNFg5+hRTKSXT0RBDCBkYgafWjNFspg
         EbiwiqHhbMgzuZOA7mxHiFRUcW75neQuPZjsOepx/LQVwhzLLcuC5OQYprlDIArpzOSU
         EPvuXssyXdf+jR7DAz3DUnKtiVKrSY2i6+4E4h1hOtwiYHHnkm254Zu9QwKhlhPqeXnP
         oVP5roe2OVS3iregLevG6GJG6y+fH6NknE0UIGdxyj9thPOPZSC4x9/zbU73ODu5EzCf
         4DYEcQML3sYUYG4nionYqEDBUAHHsXo+qJgABRQMofz9uGREv2x+llEORb65YJTaxaBb
         KMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762974562; x=1763579362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejeIvsq+a1dgP5WXvm2OFT/yoRAahndq1U3uROJjEIs=;
        b=FlciGWspVwcJUbJiMGEq9mx9zPHSDakQrbq62upAM4jeJN+XlKSrHPuxLq5HdnBFIX
         0A23bgN12t5pVFL84++CG/04lYNSQDgQVWElWPyuo5Vrnsssdam+PYHte7n2t0WM8gpt
         rcRuvZp/zEeT3jWk/f2NCaGdX6uk68s5dLNmef0rvQ5M/6+NmI/0DWAsI+HCnIjP4Yms
         zezOv0F4cFnNO2mASmUaTSaHrsHvkoPfJybGF3Ze6ow6lPm4VbeetWvIdqLpCqq4cabE
         2c8GAuzcx4wB/S6NKC9qA2Hp8Y0cDIoUhu8MIConhk4ntHlQxWc4XDAdhwNtQ/5MwGCy
         NYnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2FfMJbx664e9g4bbZmv7kTEiErrq/ivOb+zsoVvGq7kVw0SDxrqQuJnqvOnjJ6/0mcF8b3cnmUksoIc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVz3/VMwVTvRKUEZNUN0qWkot4tsHhpoi4669IdRKKa4WgKXMT
	yADDJOZ3BwoOKas5/tWa+pdPTsAcbC3+jpkCpw6m3O6ajZWFXoaaJthE
X-Gm-Gg: ASbGnctxEpE16tlCS3xPOt5c12MF9elA58oV3fs1UlGpT/uVJQ77s1lV6qp0wxrf1lx
	giP9Fr+NaO0HaDCMmmJoNF/L4a4BLXYlHIS7e5iSOp6geGYEz+ukpkt1ugwdFq0DchrMv0UMd1M
	jHvv+XmW9i4E/2TNEseEgMRRVNPGZ7rUUqgKN4Xx5Vt02K4NkKxc7INbEK3Wf3u6j9mhPOPNk/a
	FiLc9Dc1dhaWJk7ni/yDpo2cyNA/z7K4EU6tb4sLMPezmaLB3+YXjkVeYtteHx4cPDWROiHAJ5s
	Uu1qgUNNhlZdC9zsoxrVAd8UrY6++K4Ru1NkbguwvcHG0jndIYjmE6Kr0zoUp7NH6NIv1Z6jZ4N
	H3L0sfuLZWX66HJoiDrmnDjiA4EAkrDgNIVXbiiAaEKAXUQPKendYm+C5Ta3UBpHcj0vhCZ8HDo
	rATwT7y3I=
X-Google-Smtp-Source: AGHT+IFji5HChSuITTHB/W3zt81uIP7P13gd6m+S7E7+q0MZ2t/n0gk0zKUOEb2Xa/7fXIriCLWw2g==
X-Received: by 2002:a05:6214:da7:b0:70f:a4b0:1eb8 with SMTP id 6a1803df08f44-8827192b87amr67690046d6.13.1762974561529;
        Wed, 12 Nov 2025 11:09:21 -0800 (PST)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238929ae1sm96477006d6.3.2025.11.12.11.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:09:20 -0800 (PST)
Date: Wed, 12 Nov 2025 14:09:19 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/6] rust_binder: use bitmap for allocation of handles
Message-ID: <aRTbX6RPsFf0NW48@yury>
References: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
 <20251112-binder-bitmap-v5-6-8b9d7c7eca82@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112-binder-bitmap-v5-6-8b9d7c7eca82@google.com>

On Wed, Nov 12, 2025 at 12:47:24PM +0000, Alice Ryhl wrote:
> To find an unused Binder handle, Rust Binder currently iterates the
> red/black tree from the beginning until it finds a gap in the keys. This
> is extremely slow.

Can you share performance numbers? 
 
> To improve the performance, add a bitmap that keeps track of which
> indices are actually in use. This allows us to quickly find an unused
> key in the red/black tree.
> 
> This logic matches the approach used by C Binder. It was chosen
> partially because it's the most memory efficient solution.

That inaccurate. You are adding a new data structure (bitmap), advocating
it with an improvement on search side, and that makes sense.

But now you're saying it's also a more memory efficient approach, which
doesn't sound trivial because the most memory efficient solution is to
bring no new data structures at all.

I guess you meant that bitmap is the most efficient data structure to
index used/unused nodes. If so, can you please rephrase the sentence?

> Reviewed-by: Burak Emir <bqe@google.com>
> Acked-by: Carlos Llamas <cmllamas@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  drivers/android/binder/process.rs | 63 ++++++++++++++++++++++++++++-----------
>  1 file changed, 46 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
> index f13a747e784c84a0fb09cbf47442712106eba07c..933b0f737b38ffac536b19c9330dfc63ffc72f2b 100644
> --- a/drivers/android/binder/process.rs
> +++ b/drivers/android/binder/process.rs
> @@ -19,6 +19,7 @@
>      cred::Credential,
>      error::Error,
>      fs::file::{self, File},
> +    id_pool::IdPool,
>      list::{List, ListArc, ListArcField, ListLinks},
>      mm,
>      prelude::*,
> @@ -367,6 +368,8 @@ impl ListItem<{Self::LIST_NODE}> for NodeRefInfo {
>  struct ProcessNodeRefs {
>      /// Used to look up nodes using the 32-bit id that this process knows it by.
>      by_handle: RBTree<u32, ListArc<NodeRefInfo, { NodeRefInfo::LIST_PROC }>>,
> +    /// Used to quickly find unused ids in `by_handle`.
> +    handle_is_present: IdPool,
>      /// Used to look up nodes without knowing their local 32-bit id. The usize is the address of
>      /// the underlying `Node` struct as returned by `Node::global_id`.
>      by_node: RBTree<usize, u32>,
> @@ -381,6 +384,7 @@ impl ProcessNodeRefs {
>      fn new() -> Self {
>          Self {
>              by_handle: RBTree::new(),
> +            handle_is_present: IdPool::new(),
>              by_node: RBTree::new(),
>              freeze_listeners: RBTree::new(),
>          }
> @@ -775,7 +779,7 @@ pub(crate) fn get_node(
>      pub(crate) fn insert_or_update_handle(
>          self: ArcBorrow<'_, Process>,
>          node_ref: NodeRef,
> -        is_mananger: bool,
> +        is_manager: bool,
>      ) -> Result<u32> {
>          {
>              let mut refs = self.node_refs.lock();
> @@ -794,7 +798,32 @@ pub(crate) fn insert_or_update_handle(
>          let reserve2 = RBTreeNodeReservation::new(GFP_KERNEL)?;
>          let info = UniqueArc::new_uninit(GFP_KERNEL)?;
>  
> -        let mut refs = self.node_refs.lock();
> +        let mut refs_lock = self.node_refs.lock();
> +        let mut refs = &mut *refs_lock;
> +
> +        let (unused_id, by_handle_slot) = loop {
> +            // ID 0 may only be used by the manager.
> +            let start = if is_manager { 0 } else { 1 };
> +
> +            if let Some(res) = refs.handle_is_present.find_unused_id(start) {
> +                match refs.by_handle.entry(res.as_u32()) {
> +                    rbtree::Entry::Vacant(entry) => break (res, entry),
> +                    rbtree::Entry::Occupied(_) => {
> +                        pr_err!("Detected mismatch between handle_is_present and by_handle");
> +                        res.acquire();
> +                        continue;

At this point you've detected mismatch between two linked data
structures. It means that one of them or both are corrupted. To
me it looks fatal, and your pr_err() confirms it. How could you
continue then?

> +                    }
> +                }
> +            }
> +
> +            let grow_request = refs.handle_is_present.grow_request().ok_or(ENOMEM)?;
> +            drop(refs_lock);
> +            let resizer = grow_request.realloc(GFP_KERNEL)?;
> +            refs_lock = self.node_refs.lock();
> +            refs = &mut *refs_lock;
> +            refs.handle_is_present.grow(resizer);

Is it possible to turn this block into a less wordy statement? Maybe a
wrapper function for it? Ideally, the grow request should be handled
transparently in .find_unused_id().

> +        };
> +        let handle = unused_id.as_u32();
>  
>          // Do a lookup again as node may have been inserted before the lock was reacquired.
>          if let Some(handle_ref) = refs.by_node.get(&node_ref.node.global_id()) {
> @@ -804,20 +833,9 @@ pub(crate) fn insert_or_update_handle(
>              return Ok(handle);
>          }
>  
> -        // Find id.
> -        let mut target: u32 = if is_mananger { 0 } else { 1 };
> -        for handle in refs.by_handle.keys() {
> -            if *handle > target {
> -                break;
> -            }
> -            if *handle == target {
> -                target = target.checked_add(1).ok_or(ENOMEM)?;
> -            }
> -        }
> -
>          let gid = node_ref.node.global_id();
>          let (info_proc, info_node) = {
> -            let info_init = NodeRefInfo::new(node_ref, target, self.into());
> +            let info_init = NodeRefInfo::new(node_ref, handle, self.into());
>              match info.pin_init_with(info_init) {
>                  Ok(info) => ListArc::pair_from_pin_unique(info),
>                  // error is infallible
> @@ -838,9 +856,10 @@ pub(crate) fn insert_or_update_handle(
>          // `info_node` into the right node's `refs` list.
>          unsafe { info_proc.node_ref2().node.insert_node_info(info_node) };
>  
> -        refs.by_node.insert(reserve1.into_node(gid, target));
> -        refs.by_handle.insert(reserve2.into_node(target, info_proc));
> -        Ok(target)
> +        refs.by_node.insert(reserve1.into_node(gid, handle));
> +        by_handle_slot.insert(info_proc, reserve2);
> +        unused_id.acquire();
> +        Ok(handle)
>      }
>  
>      pub(crate) fn get_transaction_node(&self, handle: u32) -> BinderResult<NodeRef> {
> @@ -905,6 +924,16 @@ pub(crate) fn update_ref(
>                  let id = info.node_ref().node.global_id();
>                  refs.by_handle.remove(&handle);
>                  refs.by_node.remove(&id);
> +                refs.handle_is_present.release_id(handle as usize);
> +
> +                if let Some(shrink) = refs.handle_is_present.shrink_request() {

This is questionable. Shrinking is usually the very slow path, and we
don't shrink unless we're really close or even inside the OOM condition.

In this case, shrink_request() on average returns false, but it's
O(N), which makes _every_ release_id() O(N), while it should be O(1).

Consider a very realistic case: you're destroying every object, and thus
removing every ID in the associate ID pool, doing it in LIFO order. That
way you will need to call shrink_request() about O(log(N)) times, making
the whole complexity ~O(N*log(N)); and you'll have to make log(N)
realloc()s for nothing. If you release IDs in FIFO order, you don't
call realloc(), but your shrink_request() total complexity will be O(N^2). 

Can you compare performance numbers with and without shrinking under a
typical payload? Is there any mechanism to inspect the ID pools at runtime,
like expose via procfs?

Can you make your shrinking logic conditional on some reasonable OOM
heuristics, maybe OOM event driven?

And even without OOM, you can safely skip shrinking if the number of IDs in
use is greater than 1/4 of the capacity, or there's any used ID with
the index greater than the 1/2 capacity.

> +                    drop(refs);
> +                    // This intentionally ignores allocation failures.
> +                    if let Ok(new_bitmap) = shrink.realloc(GFP_KERNEL) {
> +                        refs = self.node_refs.lock();
> +                        refs.handle_is_present.shrink(new_bitmap);
> +                    }
> +                }
>              }
>          } else {
>              // All refs are cleared in process exit, so this warning is expected in that case.
> 
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog

