Return-Path: <linux-kernel+bounces-856725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A8CBE4EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797523AD03D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E561F217648;
	Thu, 16 Oct 2025 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlkuRKMr"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826543346B6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636931; cv=none; b=XRQKiIx8Z48KBDMqGQD4wlMtTNaDbuVqRK3dzWaB35lfZ4sOPgZwaQ+4Sfw/eGV/PmmB2awSCon3043Hgnlo8BrmYCi9L3ZvL4HY8DjHJ+e16z7HK6kGlntgeSeCXSttCakFdTeo2LriHcfzrE+NAQ82O/1kTc6ZaQQayVy+9gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636931; c=relaxed/simple;
	bh=BVGyvUQiZTxyD1hJbxw1DvOoISAi98yFgXmltP+nnLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lytcmCFPiPyv11uqf4iDMV2TXrVU0DxdgA0cYKc+N78+oLP0hbv1kyoBwHiXa/htxbt2uh7NTN9xjIZe0FyJz/RzVS+x7eRxWe1tow/PQqklAPUlHddYSEacuQ/ydUQFbeX5HrpnNceLqJ6ou4jU6KikOr/LCKgGDBOeUpwaLQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlkuRKMr; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-88fa5974432so129938085a.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760636928; x=1761241728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fbAxek/XudSJdm/bilTDa/VZekS8oo3F9bSouHLDLDo=;
        b=GlkuRKMrJkyHEam/SoTfhtpxaR3sOO5H+08ZdWSymizxYSwCHjjt0MZ7mFWlZbxCkG
         AzquChvPj3T30Hwm89/VWFun2IbpueadgD6cldl61TTISZ0hlwWBjaea25Lp8JeVk7rV
         pu0qgLKoic90731/EyJ6JxGWC7Dh6F1k1lezBRXZutCVi4g/i1hBCqy3fveQOkZujm50
         7i9XSGyP1DGqqN5tSRIj6N8ZEKrfxiHP6Dp6HkqywAbQ31DqSGOTn9uhI3Qj+D6mTNaZ
         HW6ZVoEthZT2JY8aJJLoc9FIo3NWSu1ChWy0Bb1Na7BhI3Vyz2g66ny1SkehfVq5pPZU
         Appw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760636928; x=1761241728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbAxek/XudSJdm/bilTDa/VZekS8oo3F9bSouHLDLDo=;
        b=aGUljXlWE8TTm/2DDT4y0aayhKa2CkShZcXhDHdfKruJKKGZ0hWh8VBEhPnzrCsoQ8
         QNOPN9Fi1nMIV1oGWstE2DQXwPFbd1R8P6506A4x1AwPtxZVQ70uDsR7So1Y5P+rjw+8
         ArTn9iY8cqlhMN8JbYWIFfG7zMhnVi0+TR1HK2qCASrqNZ8LdRtotYLdUwXOWC/koZ+C
         xjmq8WXRa9Q5r7bR7BfhYejiF1Xcpi4/2Zlud0qbjcWpt02XGgQ877QD8NAZVoRcEapp
         XKEfrIlE1/X0y4OwPUxTZDP6lX63c2bN3S0WcSaIyTGoC7ZkCT9QSxXGMWxQBx7liQEj
         AGPw==
X-Gm-Message-State: AOJu0Yw9yrW9F8yzTIqFMTJWqqmtRgxu+cxs2NJQmuR5Jp9XSrQbImoF
	qEX5Izx/NFH5PABf3Dy/lIpTgYpSNjmVOqtEc5FeAoUcz3ivwiSStjsc
X-Gm-Gg: ASbGncuhNlTZVW5HRPTMwCUdqkf/5zGPUKfYxaXd02TY+UH8fYP7QPhB0bIMsjLITLD
	Rzbw38MnP+Gt2SHS01ZWC6iJOOx/i1fIjEL0A4tPZCea4jcescdigiSkgKOTjhQiqcd1qISGF8P
	7cMvVDQtUPC4GVD9eebqXz5wwXPYVmois4e6ZE1bIeGWGez4tqX/+WWWp3TCHAzO9C4ZXDUlSvJ
	Ir1+cj4FQDaSX3WA33r1z00BcPMElZaaEnmPvtI326BKbTZKhWZ0HT2L6SJnWVHtULFrGYaiL3u
	RWqDzMkLHFvoKGS3rCwf8Tnhqp83GBHe9/gPY3mdx5zS019qYgT0OJaDz2R3q+Ch5PlrSvnjCA+
	LcK0DITmI5DNGWYjpFK9KEizZmB81fwp3Row44hYYOimgHdiYkcXsnbeSx7qfu9S6hX/E6G1N
X-Google-Smtp-Source: AGHT+IH3+Fae4k22gY3NVjEqt4enc7pxuqkgdu3bjhkqSWDqAE7JM060ERq759Poo6uBtl8GK/pyKA==
X-Received: by 2002:a05:620a:25cf:b0:883:9b33:f6b6 with SMTP id af79cd13be357-890709ee994mr113167585a.84.1760636928217;
        Thu, 16 Oct 2025 10:48:48 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f38bf32cdsm239783585a.57.2025.10.16.10.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:48:47 -0700 (PDT)
Date: Thu, 16 Oct 2025 13:48:45 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org, dakr@kernel.org,
	acourbot@nvidia.com, Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	nouveau@lists.freedesktop.org, Edwin Peer <epeer@nvidia.com>
Subject: Re: [PATCH v7.1 2/4] gpu: nova-core: bitfield: Move
 bitfield-specific code from register! into new macro
Message-ID: <aPEv_UO4vViOcOvN@yury>
References: <20251016151323.1201196-1-joelagnelf@nvidia.com>
 <20251016151323.1201196-3-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016151323.1201196-3-joelagnelf@nvidia.com>

On Thu, Oct 16, 2025 at 11:13:21AM -0400, Joel Fernandes wrote:
> Move the bitfield-specific code from the register macro into a new macro
> called bitfield. This will be used to define structs with bitfields,
> similar to C language.

Can you please fix line length issues before v8?

$ awk '{print length}' drivers/gpu/nova-core/bitfield.rs | sort -rn | uniq -c
      1 118
      1 116
      1 113
      1 109
      1 105
      1 103
      ...
 
> Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Edwin Peer <epeer@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  drivers/gpu/nova-core/bitfield.rs    | 319 +++++++++++++++++++++++++++
>  drivers/gpu/nova-core/nova_core.rs   |   3 +
>  drivers/gpu/nova-core/regs/macros.rs | 259 +---------------------
>  3 files changed, 332 insertions(+), 249 deletions(-)
>  create mode 100644 drivers/gpu/nova-core/bitfield.rs
 
...

> +///
> +/// bitfield! {
> +///     struct ControlReg {
> +///         3:0 mode as u8 ?=> Mode;
> +///         7:7 state as bool => State;
> +///     }
> +/// }

This notation is really unwelcome this days. It may be OK for a random
macro in some local driver, but doesn't really work for a global basic
data type:

https://lore.kernel.org/all/CAHk-=whoOUsqPKb7OQwhQf9H_3=5sXGPJrDbfQfwLB3Bi13tcQ@mail.gmail.com/

I've already shared this link with you, and shared my concern.

I realize that rust/bitfield derives the GENMASK(hi, lo) notation here,
and GENMASK() derives verilog or hardware specs popular notations. But
software people prefer lo:hi. I'm probably OK if you choose C-style
start:nbits, if you prefer. But let's stop this hi:lo early, please.

Let me quote Linus from the link above:

  It does "high, low", which is often very unintuitive, and in fact the
  very commit that introduced this thing from hell had to convert the
  sane "low,high" cases to the other way around.
  
  See commit 10ef6b0dffe4 ("bitops: Introduce a more generic BITMASK
  macro"), and notice how ALMOST ALL use cases were switched around to
  the illogical "high,low" format by that introductory phase.
  
  And yes, I understand why that person did it: many datasheets show
  bits in a register graphically, and then you see that "high .. low"
  thing in a rectangle that describes the register, and that ordering
  them makes 100% sense IN THAT CONTEXT.
  
  But it damn well does not make sense in most other contexts.

  In fact, even in the context of generating mask #defines, it actually
  reads oddly, because you end up having things like

    /* Status register (SR) */
    #define I2C_SR_OP               GENMASK(1, 0)   /* Operation */
    #define I2C_SR_STATUS           GENMASK(3, 2)   /* controller status */
    #define I2C_SR_CAUSE            GENMASK(6, 4)   /* Abort cause */
    #define I2C_SR_TYPE             GENMASK(8, 7)   /* Receive type */
    #define I2C_SR_LENGTH           GENMASK(19, 9)  /* Transfer length */

  ...

Now compare it to what we've got in nova right now:

  register!(NV_PMC_BOOT_0 @ 0x00000000, "Basic revision information about the GPU" {
      3:0     minor_revision as u8, "Minor revision of the chip";
      7:4     major_revision as u8, "Major revision of the chip";
      8:8     architecture_1 as u8, "MSB of the architecture";
      23:20   implementation as u8, "Implementation version of the architecture";
      28:24   architecture_0 as u8, "Lower bits of the architecture";
  });

There's so far 36 thousands of GENMASK()s in the kernel, and only 67
register!()s. It's a separate topic what to do with the GENMASK()
codebase. But now that you do this massive refactoring for the
register!() macro, let's convert those 67 users to the lo:hi notation.

As a side note, for GENMASKs, I tried this trick:

        #define GENMASK(a, b) UNSAFE_GENMASK(MIN(a, b), MAX(a, b))

It works, but bloats defconfig kernel for another 1K. I don't think it
would add to readability on both C and rust sides.

Thanks,
Yury

