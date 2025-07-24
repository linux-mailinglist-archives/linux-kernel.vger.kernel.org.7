Return-Path: <linux-kernel+bounces-744207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6CDB10980
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B79562D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3594F1853;
	Thu, 24 Jul 2025 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bXHG3Ahe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D141E7C38;
	Thu, 24 Jul 2025 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357656; cv=none; b=cH0Z6ZAENAcvA/pQEbNMx9jVZnFraFxFU5nNMjLl8qFjt7RAMtuO76wJbJV9wQDlbYpRDGJsdbLvFMpx4cEDWINFvIaSVxFmir/N23c6aFYLI9WQvPOC7Ih1D+Bqz/DsCqvohCIvwZlTOA3ykmfLYS4/p/TgAcnqr/tO0ttb5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357656; c=relaxed/simple;
	bh=/6HaErehx7k1WhU8/s1erU3/KkyrpEUlVpdYu82fI6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVEfZCJDkkUxQhhzZg04hF3JH1z/i+j+jNDMGFfIAKA0lRNPQ5jxHmUEIvJJb+fKQpmmSGK8YVuV4G5DLCraRfGHeBgi0dQnChw6ud/hJSTNqMteO+7oxW2zKU6NfgEmFYF4gamfe8Na2iPtuB+xUNhqWaN8NohV26RSe7gXLVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bXHG3Ahe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970BDC4CEED;
	Thu, 24 Jul 2025 11:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753357655;
	bh=/6HaErehx7k1WhU8/s1erU3/KkyrpEUlVpdYu82fI6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bXHG3AhemQ2+IgI8Z5upFn4HNvw5Lm8PWOtg/OES8vdjSeRyTBF6lfkTAxrxMm04h
	 QP5lYmxem3jSbyeFjIU26jWFI6IO17DJ4UYIcxzXGeOVnvj73yPgBmDc/ZjfBXcxsp
	 YbhYCy9Jv+CO1Wi6+XzPhrkh7bINqgXSRynTxzXI=
Date: Thu, 24 Jul 2025 13:47:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: mention MIT license as a compatible license with
 GPLv2
Message-ID: <2025072411-provable-frying-9a53@gregkh>
References: <PN3PR01MB95977C87764A556FFD49FB72B85EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025072459-tweezers-dingbat-b748@gregkh>
 <PN3PR01MB95978770C2DC8D5CDB28426FB85EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN3PR01MB95978770C2DC8D5CDB28426FB85EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>

On Thu, Jul 24, 2025 at 04:11:57PM +0530, Aditya Garg wrote:
> >> +versions of the GPL), the three-clause BSD license or the MIT license.
> > 
> > You forgot a ',' anyway :(
> 
> While it is no longer relevant, I wonder where you wanted the comma. Maybe you meant "the three-clause BSD license, or the MIT license"?

Yup!

