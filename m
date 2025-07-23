Return-Path: <linux-kernel+bounces-742020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92378B0EC01
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A5727B201B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2149276036;
	Wed, 23 Jul 2025 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHr+Q06z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5E778F51
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255974; cv=none; b=JEQSrfhzQnYJgh8S3qtj7f6b8fHlxym1nMUBAixYX9EMU41XZso9qOEiCSr/TeB/gf7DJAsKhqCvBxdtAuX4jPykwUTSsAKzuv9vczD2nGsNWOjnukPZ9EAwoI/P/2MVfitFa6lDkEMPU6W4ufWeWefijcAqiXfC7+xlIPtCtm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255974; c=relaxed/simple;
	bh=XH40oSbYkkReGCug2/mqfyFdqgA/8oCiKRTqfTtt9Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXsO/1QkEsXbazsA/0yzvkmDVzwC+Q2/KEsqfrLTjbi117BK5c+knaC9NuwdBZ/FRS7aeMfjYupVsJ10jem3SJxE0B5O5Clo/u0XR4wv/epbFfpg9p8jZIREO2GohliZhFCrxtIJPmkQscHHvF6YD1Umr0GI6bP27DQCrqlx4Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHr+Q06z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E06C4CEE7;
	Wed, 23 Jul 2025 07:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753255973;
	bh=XH40oSbYkkReGCug2/mqfyFdqgA/8oCiKRTqfTtt9Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mHr+Q06zIKtDmrsBcOrOxOPFkcgwX1H91VoN50GfOPy0998t+cGcvhZgCsE2WlMRD
	 LvD9wBsj+53+WKsEV4h6tK98DuUNl2oZIMQnpNDcanQbmXtRAiqnrVKkGpu07SdQEF
	 VpP5nlXoS81wlquH364ZPck9WVOZBiV2ZCHTOzs0ZfVYg5Y53jLQr3/33nUFFX0rc2
	 U8+EO37dk5d78ysrHYrl2h2YtzhcFl2DIYv5RoV509wghLixgs6kw5+C0LtiOchrTp
	 olSVHYBOF11vErbJJjOU4vI4P9a7OyhfsyMuQ2AH9BT6HyPqhoDTMiGzdK98+//0Da
	 5QcttX0sCfICg==
Date: Wed, 23 Jul 2025 00:32:53 -0700
From: Kees Cook <kees@kernel.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, Carlos Llamas <cmllamas@google.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 2/2] binder: Use seq_buf in binder_alloc kunit tests
Message-ID: <202507230032.742E5A52E6@keescook>
References: <20250722234508.232228-1-ynaffit@google.com>
 <20250722234508.232228-2-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722234508.232228-2-ynaffit@google.com>

On Tue, Jul 22, 2025 at 04:45:07PM -0700, Tiffany Yang wrote:
> Replace instances of snprintf with seq_buf functions, as suggested by
> Kees [1].
> 
> [1] https://lore.kernel.org/all/202507160743.15E8044@keescook/
> 
> Fixes: d1934ed9803c ("binder: encapsulate individual alloc test cases")
> Suggested-by: Kees Cook <kees@kernel.org>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> ---
> This patch is based on top of char-misc-next.
> ---
>  drivers/android/tests/binder_alloc_kunit.c | 46 ++++++++++------------
>  1 file changed, 21 insertions(+), 25 deletions(-)

Yay, always nice to see using an alternative API results in fewer lines! :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

