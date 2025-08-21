Return-Path: <linux-kernel+bounces-780354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 867ADB300CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8551882E74
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBBC2FB63C;
	Thu, 21 Aug 2025 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HUQ9vodE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783032FB633
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796480; cv=none; b=BepoVsfB0t3FjNc8LmEE+c50gI5cXetxtM4tSSWcVt1v5LByJnRvUUqHyCzyEZtgshWC9PZsxZz+LBSxdi+bpJpVPJSSyBr/nx/6iOJvjaNDjU9+Os4TglyfOywR2tlO8MSLDEckMj2aazB/IwWYjoZfwWjfFtSnsAPAjhfCKKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796480; c=relaxed/simple;
	bh=HvO73xghbnjLzeJQc4Ld6soKlGU8P0XEpJRkCn4ZrNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYyBtgGymo28zQNyyYiXByLnZoJYIRPj96PObND3sCAQPZz+Qrwz2dfcDSrBajgB4bE0r6wzJ8h/9blaN4+6IPu/5lzqwq6+16evvT/c7/pv0R9SsRqoJQIXaLEpzPVg7VGabnT9+VUGKj/n0TZpaycuvO5BhuD8zY5qY84wEKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HUQ9vodE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A02C4CEEB;
	Thu, 21 Aug 2025 17:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755796480;
	bh=HvO73xghbnjLzeJQc4Ld6soKlGU8P0XEpJRkCn4ZrNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUQ9vodEOmrxTeBzvSDhn5f9QlL7AsaYk/ow707hwThTJKYQpPoQBuA+DfcFXQBi3
	 moijcC0vB8QsehPr+RkI5lqMOI0NUdb+HKBT2cQNQItzCj8AWhl+l4eo4i4uj32hjj
	 MBi0S4BfUDb6HaOlwK3YCe5Q9ICcecWmXjT2BaOo=
Date: Thu, 21 Aug 2025 19:14:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
	safety-architecture@lists.elisa.tech
Subject: Re: [RFC PATCH] /dev/mem: Add initial documentation of memory_open()
 and mem_fops
Message-ID: <2025082120-emptiness-pencil-6d28@gregkh>
References: <20250821170419.70668-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821170419.70668-1-gpaoloni@redhat.com>

On Thu, Aug 21, 2025 at 07:04:19PM +0200, Gabriele Paoloni wrote:
> This patch proposes initial kernel-doc documentation for memory_open()
> and most of the functions in the mem_fops structure.

You are adding kerneldoc documentation for static functions, are you
sure the tools will work with that?

> The format used for the **Description** intends to define testable
> function's expectations and Assumptions of Use to be met by the
> user of the function.

Where is this "format" documented?  Who will be parsing it?

> Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> ---
> I have a couple of comments from this documentation activity:
> 1) Shouldn't the check in read_mem() <<if (p != *ppos)>> return
>    -EFBIG (as done in write_mem())?
> 2) There is a note in memory_lseek() that states the return value
>    to be (0) for negative addresses, however I cannot see how that
>    would happen in the current implementation...
> ---
> 
>  drivers/char/mem.c | 209 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 203 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 48839958b0b1..96d59066e8dc 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -75,9 +75,49 @@ static inline bool should_stop_iteration(void)
>  	return signal_pending(current);
>  }
>  
> -/*
> - * This funcion reads the *physical* memory. The f_pos points directly to the
> - * memory location.
> +/**
> + * read_mem - read from physical memory (/dev/mem).
> + * @file: file structure for the device.

What do you mean by "device"?  It's a file pointer, no devices here.

> + * @buf: user-space buffer to copy data to.
> + * @count: number of bytes to read.
> + * @ppos: pointer to the current file position, representing the physical
> + *        address to read from.
> + *
> + * Function's expectations:
> + *
> + * - This function shall check if the value pointed by ppos exceeds the
> + *   maximum addressable physical address;
> + *
> + * - This function shall check if the physical address range to be read
> + *   is valid (i.e. it falls within a memory block and if it can be mapped
> + *   to the kernel address space);
> + *
> + * - For each memory page falling in the requested physical range
> + *   [ppos, ppos + count - 1]:
> + *   - this function shall check if user space access is allowed;

What does "shall check" mean?  That it does do this, or that you are
asserting that it MUST do it?  Again, documentation for how you are
wording all of this and most importantly, WHY you are wording it this
way is key.

Actually, why is any of this needed at all?  What is this for?  Is this
going to be some requirement of all new functions in the kernel?

I think I know the context here, but I bet no one else does, please fix
that.

> + *
> + *   - if access is allowed, the memory content from the page range falling
> + *     within the requested physical range shall be copied to the user space
> + *     buffer;
> + *
> + *   - zeros shall be copied to the user space buffer (for the page range
> + *     falling within the requested physical range):
> + *     - if access to the memory page is restricted or,
> + *     - if the current page is page 0 on HW architectures where page 0 is not
> + *       mapped.
> + *
> + * - The file position '*ppos' shall be advanced by the number of bytes
> + *   successfully copied to user space (including zeros).

Why is 0 special?

> + *
> + * Context: process context.
> + *
> + * Return:
> + * * the number of bytes copied to user on success
> + * * %-EFAULT - the requested address range is not valid or a fault happened
> + *   when copying to user

"userspace"?

> + * * %-EPERM - access to any of the required pages is not allowed

Which pages?  userspace or kernel?

> + * * %-ENOMEM - out of memory error for auxiliary kernel buffers supporting
> + *   the operation of copying content from the physical pages
>   */
>  static ssize_t read_mem(struct file *file, char __user *buf,
>  			size_t count, loff_t *ppos)
> @@ -166,6 +206,48 @@ static ssize_t read_mem(struct file *file, char __user *buf,
>  	return err;
>  }
>  
> +/**
> + * write_mem - write to physical memory (/dev/mem).
> + * @file: file structure for the device.
> + * @buf: user-space buffer containing the data to write.
> + * @count: number of bytes to write.
> + * @ppos: pointer to the current file position, representing the physical
> + *        address to write to.
> + *
> + * Function's expectations:

Expectation normally means "stuff that should be done before this is
called", not "what this function is going to do" which is what you have
documented here.

> + * - This function shall check if the value pointed by ppos exceeds the
> + *   maximum addressable physical address;
> + *
> + * - This function shall check if the physical address range to be written
> + *   is valid (i.e. it falls within a memory block and if it can be mapped
> + *   to the kernel address space);
> + *
> + * - For each memory page falling in the physical range to be written
> + *   [ppos, ppos + count - 1]:
> + *   - this function shall check if user space access is allowed;
> + *
> + *   - the content from the user space buffer shall be copied to the page range
> + *     falling within the physical range to be written if access is allowed;
> + *
> + *   - the data to be copied from the user space buffer (for the page range
> + *     falling within the range to be written) shall be skipped:
> + *     - if access to the memory page is restricted or,
> + *     - if the current page is page 0 on HW architectures where page 0 is not
> + *       mapped.
> + *
> + * - The file position '*ppos' shall be advanced by the number of bytes
> + *   successfully copied from user space (including skipped bytes).

No short summary first of what the function is supposed to do normally?
Or are you relying on the few words at the top to summarize that?

thanks,

gre gk-h

