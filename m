Return-Path: <linux-kernel+bounces-864714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4C2BFB65B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AAC1502DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47B03126BA;
	Wed, 22 Oct 2025 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mtBlkSzT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C812367B8;
	Wed, 22 Oct 2025 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128750; cv=none; b=gncM3EFMjsBPeRkz4q2OMkz8lJz0Ee+tXuurgS7kCcnRmPupOi8bipd+Vhri5S5tqkNzwhVaG5Pc0LZBFHdNyq/4WwVv6/1pcoTphPI6SfK2/fkCujh9qwMcg26qeL+iH11Mzi9rLjLTeGoLGCUq5UUj5RicyCvS+8TgoFCidhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128750; c=relaxed/simple;
	bh=44eFxxcmgKe1yf49EaRVPV9A6CQBOHNBDElPqiOFLNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqTbjxATQIH2ZWmLKgXaIzFG3N+sLcpenSLWiZCdt6dl0XVzoSce+dykqES1x6hdZp5gm+tpiOCjTxJbZ1pAb31GuHAqATzvf3gA2ik+fWeyyjD4t85KzUWtxEmvrnvyLeVjCM98Kq+qEwmyxokcjLtnOrSlhVt/1vU2F7uI7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mtBlkSzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A56C4CEE7;
	Wed, 22 Oct 2025 10:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761128746;
	bh=44eFxxcmgKe1yf49EaRVPV9A6CQBOHNBDElPqiOFLNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mtBlkSzT0V0ulPZKh1wW1HOxjrvK1o7kHX0znckSKde0VclaGTlsAYKcI0C1yvVIt
	 Y789MBSCJSvb0AuOZhCdQZM6gIyCC2O5yogbaGmzhGDOvUmbwdzDN8osaG/f2iZXjh
	 0hDuW7bUoXR3rnIiDNbrIKisUvIZUhDSRkm9w0E0=
Date: Wed, 22 Oct 2025 12:25:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fokaz Chakma <fokazmchakma4427@gmail.com>
Cc: dpenkler@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib/pc2: convert explanatory comments to /*
 ... */ style
Message-ID: <2025102227-resisting-sudden-7f3d@gregkh>
References: <20251014200727.206103-1-fokazmchakma4427@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014200727.206103-1-fokazmchakma4427@gmail.com>

On Wed, Oct 15, 2025 at 01:37:27AM +0530, Fokaz Chakma wrote:
> Converted single-line // comments that explain data or logic
> to kernel-style /* ... */ comments, per
> Documentation/process/coding-style.rst.

It's ok now to use // in .c files, so why is this required?

thanks,

greg k-h

