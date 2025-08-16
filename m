Return-Path: <linux-kernel+bounces-772102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DD1B28EC2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0562C587840
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B3C2F60A9;
	Sat, 16 Aug 2025 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hyV+4bGb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD062ED17E;
	Sat, 16 Aug 2025 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755356836; cv=none; b=EcKOEK5rhMPHexuxCjF0cn5Po7SfvtaJdeU9+MvAZHqgVA2Ar/LPu9H4EmoYaXiuzXZ+qlt0+PQXgza+idZRVtoZ8P2bVB3lZ31qEyoaNDmS5UvjEAgXEz+0OEtO2XhBOHJHVWlDulK2fXHWGzYhdzxi2bDTrF343XOaTk0brm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755356836; c=relaxed/simple;
	bh=mHO6d3SPw4XkYGjvk5u4yBJn3I2kmY6FRR9ETJcNxGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOrNPa1w9QWJ5kMWYpcz1yM0Tgpnmoq7DP5tOMOxghUwqVMwoGS4vHmnK6Ya3MxSbCw+P+rPyG45u+McovN2DvGvA+KBTiQ7+PblfAKp0G9neEKePw4cQljc+d9CGhTstSei4+NZ39Gjt2lvj0okl2rNVvC+8IqqTum9+XI35k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hyV+4bGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A41C4CEEF;
	Sat, 16 Aug 2025 15:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755356835;
	bh=mHO6d3SPw4XkYGjvk5u4yBJn3I2kmY6FRR9ETJcNxGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyV+4bGb3B0i5Ac/70ARdEuTd4T5y/dSaMH0v5y3CaWaNQ8OC9+QmuTgaOkyTnpyG
	 LCaVJ8q4IwZxu/+19dYGVyatYkbA8ql56FK5aJnqJShd9RFDbOlKR82ZmZhcuIfnVO
	 DmHdbuxxMI7z1FR8muuazmI70R0cDRYws6Elv8SI=
Date: Sat, 16 Aug 2025 17:07:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Jonathan Corbet <corbet@lwn.net>, security@kernel.org,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: clarify the expected collaboration
 with security bugs reporters
Message-ID: <2025081655-proved-ladybug-4fa3@gregkh>
References: <20250814192730.19252-1-w@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814192730.19252-1-w@1wt.eu>

On Thu, Aug 14, 2025 at 09:27:29PM +0200, Willy Tarreau wrote:
> Some bug reports sent to the security team sometimes lack any explanation,
> are only AI-generated without verification, or sometimes it can simply be
> difficult to have a conversation with an invisible reporter belonging to
> an opaque team. This fortunately remains rare but the trend has been
> steadily increasing over the last years and it seems important to clarify
> what developers expect from reporters to avoid frustration on any side and
> keep the process efficient.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  Documentation/process/security-bugs.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Both of these look good to me, thanks!  I'll queue them up after the
next -rc is out.

greg k-h

