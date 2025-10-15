Return-Path: <linux-kernel+bounces-854625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB21BDEE26
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 093B44EDF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D75A21CC6A;
	Wed, 15 Oct 2025 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GMeONgcy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5432D7263B;
	Wed, 15 Oct 2025 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536846; cv=none; b=PnbZjGwETmXE7fbqsndaPqvyUdhPA2C4cIJl30LBmyoz1CUr/eAwuJdOhPjHyYfvKD09dwV0g1pZeDwBiVmQo0NRdNnKlS3uMiruguwoigk40yPrz4igaShuTE7l0T3PugDGmK4r8Uafnvh/QPqtXIDqKysD/0osoQXXoYx56Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536846; c=relaxed/simple;
	bh=MDRP8V1iEZmLz15Z2XSYpGm1FBRVJoPP1hu8VeNx7ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lkj0ar/VITxfaIsXNe8K3sx61YPmTc8Lmcan30SFqKwydGrRA8Sc/FDaF8vYQ401bcI/SyET1GpStRqqGDD78IjnKqJ9INFe+qqHQO49bet6SDTVZKqszg0ZqW6lACBvJawP19VZiGP/J3B3Kz8LnkVJenMA4fiflOy6D9BaC0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GMeONgcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73649C4CEF8;
	Wed, 15 Oct 2025 14:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760536845;
	bh=MDRP8V1iEZmLz15Z2XSYpGm1FBRVJoPP1hu8VeNx7ZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMeONgcyepwm0q8G6yDqZzSVPHJGauZD93Jk2kOU4+j+n7BsdNxgCF796c/70PXeU
	 sVffMT5gm16KO/lGzAayC4D4WrZHBUrG+uyz9lOqSGt2YD0EcU/AqyY7bWgQAioVj1
	 cFIk0Ho2pRYO60HO+f+4yQ1XLGbLKztgpf1iFQYQ=
Date: Wed, 15 Oct 2025 16:00:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] usb: typec: ucsi: Add support for orientation
Message-ID: <2025101530-skeleton-able-6523@gregkh>
References: <20251015-usb-typec-ucsi-orientation-v1-1-18cd109fb0b7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-usb-typec-ucsi-orientation-v1-1-18cd109fb0b7@linaro.org>

On Wed, Oct 15, 2025 at 04:50:36PM +0300, Abel Vesa wrote:
> According to UCSI 2.0 specification, the orientation is
> part of the connector status payload. So tie up the port
> orientation.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 24 ++++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h |  3 +++
>  2 files changed, 27 insertions(+)

Why is this a "RFC"?  What is the request?

thanks,

greg k-h

