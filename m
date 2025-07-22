Return-Path: <linux-kernel+bounces-740398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14873B0D3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939A8189E170
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A722E2D97A2;
	Tue, 22 Jul 2025 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zL4imzYN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B10F2D94A4;
	Tue, 22 Jul 2025 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169896; cv=none; b=tZLbS2MjcYSwbweivaN9vgqxCoKyyLwG61/5t0U8+taFSpKQ8EHRlFQF/X0O2QVmbmNgwb1UkgOb/LLYOQ43pEx6GMLjnaeBJYGd770lqixSsrkLfntqQSEvtZrHYewhSbXsocnFzNxZugCrkVWF7KqhrY1TRMRaI/Ug4Dyxjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169896; c=relaxed/simple;
	bh=+8GB4p5kenoyxeeFKg1NGt6cpXw/JWSiJv1t8bHCLaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8FP0qCWmoTT5NEtVw8sDA2kmCw9WIkkBXLVH5a/uC4AW0Dk7A0vWrapocii8iT28A3HwWnTy9UbgiRn4tczubQrxuC4/i0br0G6iPTagu75Un1I03fK4SXLI5aNbEjzyLUdd+AcfXgjFLdaiMngFMTEaAcnKin5zyy5z16h+hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zL4imzYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EA1C4CEF4;
	Tue, 22 Jul 2025 07:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753169895;
	bh=+8GB4p5kenoyxeeFKg1NGt6cpXw/JWSiJv1t8bHCLaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zL4imzYNjVx9BDuGZzNIIKSl5H0gyDtSkUWE7/LBR8kLzpNbnWUFVHJQ7gPw5PSnx
	 s16PJlRuc44jiHWOS2P1j1bNpDUpBB97X23V/YBZ18yBKXAhEEexblvHFqdTACThrc
	 GxKSKJrf5ircySp2v8pFjbcNJ4yqX5uxTaSt9VPE=
Date: Tue, 22 Jul 2025 09:38:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ali Nasrolahi <a.nasrolahi01@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: remove redundant semicolon in
 basic_types.h
Message-ID: <2025072250-plaster-helper-aa7f@gregkh>
References: <20250721165639.10078-1-A.Nasrolahi01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721165639.10078-1-A.Nasrolahi01@gmail.com>

On Mon, Jul 21, 2025 at 08:26:39PM +0330, Ali Nasrolahi wrote:
> This patch removes a redundant semicolon for
> the macro SET_BITS_TO_LE_2BYTE from basic_types.h

Please use the full 72 columns for your changelog text.

And this says what you did, but not why you did it.

thanks,

greg k-h

