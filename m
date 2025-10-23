Return-Path: <linux-kernel+bounces-866656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAF3C005CE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C5319C7804
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01C230ACFA;
	Thu, 23 Oct 2025 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MxclM3C+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82CD30ACF3;
	Thu, 23 Oct 2025 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761213520; cv=none; b=OeirTVlOiJ1uKbjLJ8i3UtBI2sf5DrXIy4O5w002WpaaKLr47Hk+dvO6PZSYSsjEuZP+ZgIdRe//Xn5yk3TVdpO3YRvh0nSmzyR7ucNGMsaAFrVN5/GwPTSH/GtEk68YBqGCkkFeSWN54WQOiQRfszpqfaJZw9GNLYb4BpfQtrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761213520; c=relaxed/simple;
	bh=C1e5zMU2FxmuvcmBblTzBCIpoY3f39ZeA/FwDmoe7+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXmu7Ri7X8U8rsZH9Idx+5sxpJ1ADRqEJq9GNban5b6Ek1nHq11pAFVa8KUECMN78fXu5NoL+oGvKCR4imKFbQFosu5d+i2p5pFlUeiTm/6DFrIlRLDsEJJzz5mA1BbohkLp9AlLZvkrlwr8VmMDk9c79p9b8uMQR3O866WLC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MxclM3C+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D377DC4CEE7;
	Thu, 23 Oct 2025 09:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761213517;
	bh=C1e5zMU2FxmuvcmBblTzBCIpoY3f39ZeA/FwDmoe7+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MxclM3C+eb976gcoy28ohvAY9D6iqxv37gFlY9HgupWQEDwbsodVm3N+Bxu1CS6bD
	 T79v1OGju+bWuqy9ws8w++a/xYUcB8poHaCVmzQvoestMBM+XnDLdhZhWcs0v9zOyM
	 a3qSkvPvued4lg1YyAPKJ6LakUTZMGDNswpCpni8=
Date: Thu, 23 Oct 2025 11:58:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fokaz Chakma <fokazmchakma4427@gmail.com>
Cc: dpenkler@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib/pc2: convert explanatory comments to /*
 ... */ style
Message-ID: <2025102341-playmate-angling-bdb5@gregkh>
References: <20251014200727.206103-1-fokazmchakma4427@gmail.com>
 <2025102227-resisting-sudden-7f3d@gregkh>
 <CAMa_khZMv-8jmUf1wqhund_rWQ5Nkoox1mqUsHaHmVvS6PJwCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMa_khZMv-8jmUf1wqhund_rWQ5Nkoox1mqUsHaHmVvS6PJwCQ@mail.gmail.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

Also, HTML email caused this to be rejected by the server :(

On Wed, Oct 22, 2025 at 06:48:21PM +0530, Fokaz Chakma wrote:
> The coding style guide in Documentation/process/coding-style.rst indicated
> that single-line // comments should be converted to /* ... */ style when
> describing  code or data.

Yes, that's good, but we have learned to live with // comments for
simple one line comments now, so there's no real need to change this
driver for just that.

thanks,

greg k-h

