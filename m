Return-Path: <linux-kernel+bounces-824874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96660B8A59C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB88E5A4D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A09431A819;
	Fri, 19 Sep 2025 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iXXKEkQb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97793176E5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296344; cv=none; b=Z+zrm9EOFGwkxgp3cGcfW45em3MevpPCkgKc7Hlsg9lPZY3PN/+Zoyf5XDsjU97McRKTCUNSKWT7Hq9nYS7bnggU7ZDuUkJNdaLq7vWEPoY5qzZFx5zHPp7RE/Y+folsQKLG7G3B1vW0FGaQ6SDUN8twRvjZZPj28AsroqFi65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296344; c=relaxed/simple;
	bh=iDqNQZwVv3ryjZ6gpsiIIyUzJdKF9s7SjoRbRdPkI18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqmcLapXObES6pFOMQY4hSAjJhhe1EpGeQyu+ZhhNi4jZgfEq9uhcu3penzmUSuxrm+piG9aIrnnW2tk1Z5cgoivg5vj0DuNbnwpIRaC+qy8ls03+bHLFkZJYQ+U+uYJRC1uQgxT7t8rytdKkUaUDawcYIUKu3DVhb86RsyDD3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iXXKEkQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C70C4CEF0;
	Fri, 19 Sep 2025 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758296344;
	bh=iDqNQZwVv3ryjZ6gpsiIIyUzJdKF9s7SjoRbRdPkI18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXXKEkQb1rZmT2b/ac+gYSO9PpUGXAt0GSnnTENET+TUmAroCMBtvoTLXyw5z+EFd
	 enH7xUHTtL6DPnIjWOGv+GFqUcJ/1pjwrnwekWcjsN9n8Y90cCdLPm/16nz25Pr+1e
	 jv8C7+QCEaeucqfr4e48qdYhRzd5ZhJyReavYqbM=
Date: Fri, 19 Sep 2025 17:39:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
Cc: Kees Cook <kees@kernel.org>, Alejandro Colomar <alx@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: eisa: make eisa_bus_type const
Message-ID: <2025091949-finer-velvet-334c@gregkh>
References: <20250919065327.672924-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919065327.672924-1-abarnas@google.com>

On Fri, Sep 19, 2025 at 06:53:27AM +0000, Adrian Barnaś wrote:
> Because driver core can properly handle constant struct bus_type,
> move the eisa_bus_type to be a constant structure as well, placing it into
> read-only memory which can not be modified at runtime.
> 
> Signed-off-by: Adrian Barnaś <abarnas@google.com>
> ---
>  drivers/eisa/eisa-bus.c | 2 +-
>  include/linux/eisa.h    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

