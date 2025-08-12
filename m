Return-Path: <linux-kernel+bounces-764070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4101B21DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451801AA2513
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045A62DECD2;
	Tue, 12 Aug 2025 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2igxDZe4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F069311C19;
	Tue, 12 Aug 2025 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977886; cv=none; b=TFU4HdvSUtbdBmA29npLAxBbL1phjcIk/dsbh8pkeV5VrY8nobh6E31g9VTIxydKHmLia6lI7yM/doIlVegKzjxg+Ki0NtFssDtWwv2umW8nGz/C/5Sl7En/luqheLIbaNoz1viGkb+WgYhgg3oImjLlYMtKgkqi9HBhVMoLgWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977886; c=relaxed/simple;
	bh=huS25wTfs3E0YIoS2KdJtmKuLnVKmVjENfSiujQkekc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFIer+tqGCGt058uWUmXS6r5CCDFxazkCgMMv1BV/5T9QCaSXZ775kOfnkU4Kn+CUsNWPcXlxNYNjOIGBM+09W7nGLEuqg8t1Msui3AOstsJIhUDRsdjsCAe+3LcjDXxXaNowbnUMGxQbwUUilZMsEo9YVLxonSHcLvUQSei9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2igxDZe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80888C4CEF0;
	Tue, 12 Aug 2025 05:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754977886;
	bh=huS25wTfs3E0YIoS2KdJtmKuLnVKmVjENfSiujQkekc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2igxDZe4pXC1GGEDEvVz8KfGal4n6Q9bbdmDVfarByji9KAMnByGCIqfOM8+YbBmv
	 DiHE9+C7v84zzICywdlAUotyHki3s5tkv1h9rDeaXjklxgw7fwr/9BK29aDNo+Uvrq
	 6Ogb68VQU3n3M9Y+zK/lUAvGICY1va81ywHVsD9s=
Date: Tue, 12 Aug 2025 07:51:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: AI Talking about AI <aitalkingai@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Rust: kernel patch series
Message-ID: <2025081215-backpedal-headstone-0750@gregkh>
References: <79821f85-9e95-4426-8b1f-8752f8683dc9@gmail.com>
 <42c3fc0c-46a8-4502-ad53-d3b886fad5e8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42c3fc0c-46a8-4502-ad53-d3b886fad5e8@gmail.com>

On Mon, Aug 11, 2025 at 03:22:18PM -0300, AI Talking about AI wrote:
> >From 21a3d2a2dcff13f445915602c06a17af07835ee7 Mon Sep 17 00:00:00 2001
> From: AI talking about AI <aitalkingai@gmail.com>
> Date: Thu, 7 Aug 2025 07:53:56 -0700
> Subject: [PATCH 1/2] rust: mark CStr::to_str #[must_use] and update docs
> 
> Add explanation about handling UTF-8 errors and mark CStr::to_str as #[must_use] to prevent silent error ignoring. Also document safety requirements of as_str_unchecked.
> 
> Signed-off-by: AI talking about AI <aitalkingai@gmail.com>

Again, please read the documentation about what "Signed-off-by:" means,
and why we obviously can not accept these patches like this.

Also, when submitting kernel patches, do not attach them like this, but
use a tool like git send-email to send them properly.

thanks,

greg k-h

