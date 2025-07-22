Return-Path: <linux-kernel+bounces-740218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04887B0D17E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CAC1C22BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09231CF7AF;
	Tue, 22 Jul 2025 05:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fbnzA/9n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF835A79B;
	Tue, 22 Jul 2025 05:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163623; cv=none; b=DxjhaVyqROCe1cxDzdDzNh7zSNkDh3N196ybu7/P1Q1b8XbTL7t2JaibeFLFptHFDWgW2ltD4wgUKvKNzC9YHmaspmNVUCc56bMKjeKy+bvtKlQtOndQtJpW0hjuuNqU9jAPaHuZ9JB+n9ayEMi4kMXnhXwpgg6ZCtUJEeUKa7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163623; c=relaxed/simple;
	bh=upVSnkCMm3I3aGmUUs+P8F1vsjB3glfV4yq4Rv56GNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pS0JR0b2+0vPMIhdrnE7qHdfO71B5s0dWNxEyJnHrge2LUx4TlKgXc7NEH7JgzVrm4XAulp2rGBPwY8QRX4khb5QfgSeKiSivN5/SHoN9LG4L2Ew5ntjn/6ZkeyTq+bzWgDgNp86Ha8jCACkwBzU844dB82D1NwwRiB2dfItpaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fbnzA/9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38735C4CEEB;
	Tue, 22 Jul 2025 05:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753163622;
	bh=upVSnkCMm3I3aGmUUs+P8F1vsjB3glfV4yq4Rv56GNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbnzA/9nZYoLNwYogjvQ6VQVnt+3fsJreW1OUBq1lwHSXruWvbEL22FEg+P1gIcJA
	 q9NwilKlSi9s4I9P6WYpdEye8oKBgcMAGwcGWoaQ+zKuk6tzDORozDKkIHrZRJDJ4Z
	 u6GrYJVr5NOClkvEsjAQu6a4TORLBYAwNbvhm4wQ=
Date: Tue, 22 Jul 2025 07:53:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rujra Bhatt <braker.noob.kernel@gmail.com>
Cc: geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] drivers:zorro:zorro-sysfs.c Replace sprintf() with
 sysfs_emit()
Message-ID: <2025072228-comfy-germproof-578d@gregkh>
References: <aH8H3D0WRrqqZYc4@brak3rDesk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH8H3D0WRrqqZYc4@brak3rDesk>

On Tue, Jul 22, 2025 at 09:09:08AM +0530, Rujra Bhatt wrote:
> Reply-To: 

Why is this here?

> 
> replace sprintf() with sysfs_emit() in sysfs
> *_show() functions in zorro-sysfs.c to follow the kernel's guidelines
> from Documentation/filesystems/sysfs.rst.
> 
> This improves consistency, safety, and makes the code easier to
> maintain and update in the future.

No, not really.  For new code, always use sysfs_emit().  For existing
code, that you can not even test, just leave it alone unless you can
prove it is wrong.

This code looks fine as-is.  No need to change it unless you really want
to, but there is no requriement.

thanks,

greg k-h

