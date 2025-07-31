Return-Path: <linux-kernel+bounces-752389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F03B174FC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D346625F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772E0222587;
	Thu, 31 Jul 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKcMByMn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BF1BA33
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753979550; cv=none; b=nNsL/0VaESNZWe63UVDL/EG55N8LAzwXZHuuy1MaomrUPEajfCoBhYKjvS0wUla36C+pNtiYbyUH9OMQ1kNowENmRbJepg6mWnPTxQ6a9zMkCyCT7esdrQhhPDoxZwd5+leJHiBZHPhzoqA1nZO56Nkicsc4LV+9/UMVnoxP3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753979550; c=relaxed/simple;
	bh=QxmW59MYclt+PJHRDq75K8so3xIhhYBKiVpMFYXkyWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aht/x3fuLbRclwaBLr9ip8hoS3yG/J7cerLDMjlrJZnpVAxEAV27F0DztNMEOV358pygkLXrxayb491jMpISB71Jt/E0DrHtPu54Cny62TZ8o86z/7A5HuIk1JdhF8s1EHevReet6KFIH2fi7AXy5QO2KQ5F4hWywc4WCZUvkvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKcMByMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46345C4CEF6;
	Thu, 31 Jul 2025 16:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753979550;
	bh=QxmW59MYclt+PJHRDq75K8so3xIhhYBKiVpMFYXkyWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKcMByMnyptsDdhNBTi+FQ168SG3Lp0BzgL9LeKMqjPqX6e5oSm5aK1yp7gnSwIDY
	 te5lAcQvZaAKkFZHPFS4sE52+MkTvyDe/Jyc4GjVv3mqQFtDsWX7RKL6edru1tUE8d
	 28bXN6lBVxd2a23VO/jLgHrKOfcYmmdYerP4EM8IiQ4pIxT0oH6PNWXs5DBz0aiPz+
	 zU077G0H1o+TgR6liMWrV56TtKO8bZzUaVd/ZDB07ABwzH1KyIeOz+guRpU8ssr+iO
	 /2ggdatzVYGj1p2Hfjr0NW2eC3EjZ6BvINih7fANZCViHNMe7/MIckQR8PYHtA6Rdf
	 /2VM/vV5S7Yfg==
Date: Thu, 31 Jul 2025 09:32:29 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ref_tracker: use %p instead of %px in debugfs dentry name
Message-ID: <202507310931.1EE1716CD@keescook>
References: <20250731-reftrack-dbgfs-v1-1-143ee1cfda44@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-reftrack-dbgfs-v1-1-143ee1cfda44@kernel.org>

On Thu, Jul 31, 2025 at 07:57:05AM -0400, Jeff Layton wrote:
> As Kees points out, this is a kernel address leak, and debugging is
> not a sufficiently good reason to expose the real kernel address.
> 
> Fixes: 65b584f53611 ("ref_tracker: automatically register a file in debugfs for a ref_tracker_dir")
> Reported-by: Kees Cook <kees@kernel.org>
> Closes: https://lore.kernel.org/netdev/202507301603.62E553F93@keescook/
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Probably better to use a global u64 counter, but %p can work.

Thanks for removing %px!

-- 
Kees Cook

