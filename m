Return-Path: <linux-kernel+bounces-766133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29606B242BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4B7165F50
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759A02D781B;
	Wed, 13 Aug 2025 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZyHJlpG"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D322D3236
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070050; cv=none; b=CboTkP8GofRSMw5bqo5zYLEipvlilmox6bEpL+VV7Br0cnni1Oq1muQG+vgczDGnOETCGRaP1/rWIWfEPwnW0X5K91V1rmOYuOJ8BwRfaOEE+8JshJSBsJ8lmPnBkpW/JdTzaSMFPGrKHfZxZyLkO3F653ADybcpaV9mP2Zp36k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070050; c=relaxed/simple;
	bh=YHoUjA/8KX/MmU2Uv6aAwYiYpEqz2AMzsIp8MSWSjbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UA70+QRMvW8a+9VZdB+NmlYEBby+ofWbz9YtjL5bIPI011D6kcpnyaElfU1higRJAkAuCjV6fz53oEKZl08xS9Xil1VEWx8UiXcznZ8uAkgeHjeASslQD896LFtVIe8HviuielrHluM5yxzY2HiPt5HrTUZ9lQJ+fsJap3FqMd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZyHJlpG; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b783265641so1135561f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755070048; x=1755674848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=17SD2UwpWysDD6vNNdHlWpNPy0OKiiXdv4ame2mkJNQ=;
        b=MZyHJlpGz9zMGijGFCBzEXHlCgGtWADe8YC3voZe7lM2yuhL6lDpgB2qzTBDxnXSNy
         xIgFsy1yopvy+OWjyWEG1krSQQvThUDHz1hmCHipVzDENcS/4k7/Ix6cgW7oMECmlxK+
         jlrJL6is7lJk1NvHMPKYwWeJ7o9l4OPvJR+9J9dkuCkpntKHxpJ9Hlca14CqmB1jXp1X
         L0qKsyi3/qfBEDDDxpSPm4pB5ccoLvBkn4LS03kS7krhcwKZAvFH6eItTnBFQ0plD/XY
         zqkIklJJi2kCLyzj+RWwzTq4s1K9kJWyHs7CzrCSVgq5RSETK1QGFW64eLWXj0a0tNjS
         u+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755070048; x=1755674848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17SD2UwpWysDD6vNNdHlWpNPy0OKiiXdv4ame2mkJNQ=;
        b=r5ALzl8DzgIxAp/iIZWxnoigUD5DupiHUhC0y0ySm3nyPLgl4TQk4I/nUTA1KVCe+Q
         V8+JmYTsGVoGp4L0zh6cYi+yASw4YXYqPYeoUIKeeZvJ5lNc3LJLMyYPpQ0qyhrHT4iq
         HZ5C+nOELoRHR7AjWiPhZUfvQlYiMToFb6IQSN5eglL3voatCOnFb5LxLOOnXc8DDIt4
         +oMKhiLMDixmxxNSVw0NwmOy2QB6/fiQ3Sst6MKC5D92/EITu5f2jDJU6GklAQF7wMC4
         3dS+NOyY7/jr5wldgpaS0mOo1YGqsvuH1cdb5saOnD8abFgrig62i19s9ASrhWfs9+6l
         6TLg==
X-Forwarded-Encrypted: i=1; AJvYcCWOWMpdFYtzQJgRxiO5Uh1v8lH4aZmt19DeIXIfxirwd4H3XxC7EClSidIdjstlo2Ns6RoR71N6Ow6/yD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0qlktWW+CR7sAIjVZzGRuawF4xvqpRnpJHWOPEYrDMHfoe9nI
	PARKspV4M4wt470Fim1tSCVfEB14chl0cbWqUfZKSCXEwaitS5zSKieIY5QWXzeJAah2eu/r9T+
	fSTyzhYe5L6x7TI8pKg==
X-Google-Smtp-Source: AGHT+IGwdUHoW8Y7DCJnE3LmPWgw+RTDGRfKlKIp2l/UIObWW7mCAH6YZMY5QXAF8IY4M8lipLx+ulfYnIu9PdU=
X-Received: from wrxp12.prod.google.com ([2002:a05:6000:18c:b0:3b8:dd81:b66])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:250f:b0:3b8:dabe:bd78 with SMTP id ffacd0b85a97d-3b917ecf44amr1294514f8f.54.1755070047818;
 Wed, 13 Aug 2025 00:27:27 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:27:25 +0000
In-Reply-To: <20250812-rnull-up-v6-16-v4-11-ed801dd3ba5c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org> <20250812-rnull-up-v6-16-v4-11-ed801dd3ba5c@kernel.org>
Message-ID: <aJw-XWhDahVeejl3@google.com>
Subject: Re: [PATCH v4 11/15] rnull: enable configuration via `configfs`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Aug 12, 2025 at 10:44:29AM +0200, Andreas Hindborg wrote:
> Allow rust null block devices to be configured and instantiated via
> `configfs`.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Overall LGTM, but a few comments below:

> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
> new file mode 100644
> index 000000000000..8d469c046a39
> --- /dev/null
> +++ b/drivers/block/rnull/configfs.rs
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::{NullBlkDevice, THIS_MODULE};
> +use core::fmt::Write;
> +use kernel::{
> +    block::mq::gen_disk::{GenDisk, GenDiskBuilder},
> +    c_str,
> +    configfs::{self, AttributeOperations},
> +    configfs_attrs, new_mutex,

It would be nice to add

	pub use configfs_attrs;

to the configfs module so that you can import the macro from the
configfs module instead of the root.

> +            try_pin_init!( DeviceConfig {
> +                data <- new_mutex!( DeviceConfigInner {

Extra spaces in these macros.

> +        let power_op_str = core::str::from_utf8(page)?.trim();
> +
> +        let power_op = match power_op_str {
> +            "0" => Ok(false),
> +            "1" => Ok(true),
> +            _ => Err(EINVAL),
> +        }?;

We probably want kstrtobool here instead of manually parsing the
boolean.

Alice

