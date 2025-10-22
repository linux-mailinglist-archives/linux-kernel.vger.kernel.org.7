Return-Path: <linux-kernel+bounces-864713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5858ABFB658
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A50D8506B10
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E4A322745;
	Wed, 22 Oct 2025 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JWAnUtiD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A28280318;
	Wed, 22 Oct 2025 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128717; cv=none; b=S/SAo19Jp6sK2y3iSPILRBkLiwPjhoB8MvYDC3AD/jXhHkCu/RK4Ys1tPyvH0c+XTvcX9znYZfWQiVjx1/Gpd6qBJvU0k6jDCg9dpB0kL0G4fTs1ti/tjeHFRYFXNwjR5T/Pe72TSCGnmO2Jm3/+mHsJLLemGNEzXvo0p0aJHEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128717; c=relaxed/simple;
	bh=T2xSsqijF0LklJ89gp/Yz9fOPOiOgCsbt2SswEo5JB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMHRMlel2LlnAZww/CihEV4EJbuNxESuK6a0xGMvHslqlW7j+2HdoZ/oslE9+2FOE98NRgqOJ7VEAL8riFHdgRhxCeX1eGLQdZ2qghqIylrMPHrMydNgCuDjTYBa2M0lPSpwTzxxDXjnWMm61vLPNGWQH6gqeMoM7410budpqnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JWAnUtiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53DBC4CEF5;
	Wed, 22 Oct 2025 10:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761128717;
	bh=T2xSsqijF0LklJ89gp/Yz9fOPOiOgCsbt2SswEo5JB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JWAnUtiDLFhGJ+CbNU7QIX8cLmW6raAmB/00Bm7txQMMA7wbt+sLzYeOThffPuzqp
	 pgrksOHWYbSiv7Ufc1WNMOe9K3g7MruEjxoGHdo16ScQ6udkYwDK9ZFrHLIvD1z51H
	 WpRUzQAstQzuOuMopMRdSonxrpxA+xSK2Vae5wLs=
Date: Wed, 22 Oct 2025 12:25:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michail Tatas <michail.tatas@gmail.com>
Cc: dpenkler@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: staging: gpib: convert comments from // to /* */
Message-ID: <2025102230-unshipped-comply-9957@gregkh>
References: <aO2BHZzs3EsMTo3n@michalis-linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO2BHZzs3EsMTo3n@michalis-linux>

On Tue, Oct 14, 2025 at 01:45:49AM +0300, Michail Tatas wrote:
> This patch converts some comments from // -> /* */ to make everything consistent as suggested
> in the TODO file in drivers/staging/gpib/TODO

Please wrap your changelog at 72 columns.

> This patch only updates part of the driver to keep a reasonable patch size. Further conversions
> will be submitted in follow-up patches if this is accepted.

Please take a look at the kernel documentation that describes how to
write a good changelog text.  Neither of these sentences fit that guide.

thanks,

greg k-h

