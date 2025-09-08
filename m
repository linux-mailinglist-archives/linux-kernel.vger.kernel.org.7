Return-Path: <linux-kernel+bounces-806740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A15B49B2C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79A41BC2991
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35242DC331;
	Mon,  8 Sep 2025 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in1N8aSd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E7F1C863B;
	Mon,  8 Sep 2025 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757364280; cv=none; b=QWZhIAk4HGoi0hmLEtk7OsEWx8Q768qVnf+aMEEGND1wPz5VyPfeZMGXfQOyXZEaP+Vcpwk4YDflFbH/kChSbpS2cxcvxJ+lB5NVnFJoHigEYAKvQ/zVYgWuOw/XyqVor/XfXAHWBDp9ZteKPkzbmIc7UcMeDjgs1KlooEdgL0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757364280; c=relaxed/simple;
	bh=+UaQJJ9kveq5w+zMdLW3l1Tdxyl5Xf3XW3yKboz8Rwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tA0k5IksIWQr4zgEBPyV/ZsiucUuSS4lSCdm1xAzW+OsLJdrpcrqB2a7uMhRReq8jxY57KhdMb2+Y2SJpdqjpup/IrtTZMRakegdI8fvyE01C0diDhQRtHDl8d7r105EQFHFgyqx0krdB+zAkJKsoglSULG43ovHOg9XKrUb2e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in1N8aSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C765C4CEF1;
	Mon,  8 Sep 2025 20:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757364279;
	bh=+UaQJJ9kveq5w+zMdLW3l1Tdxyl5Xf3XW3yKboz8Rwc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=in1N8aSdMwY7UqLQ5gJ3Rv/Jg5RlH4YP0yewS6QkRacRakFWcP3v68iwP0wkZDj/E
	 bBx0QxQZjXy6iH4XdawKN/Z66ZsfkC4eKMD+K6zh/VnZbGjXRI76HxRwAqhIyass3x
	 BjEJb3nY17IUYXpXvmx8H3M1FGHzdoHgLXPgaZMA3MBuISEVW0vV/D3F4aZSJYQWuq
	 b3j/70Pu6Fs+WAKd3K9NcyoYI7QGblUK14EtZMEdUESfo+j+lkRKDb2oFIs/MjYzA2
	 tEwlHhm/w1rF7Q+hAorK7xCpef7fwI1xvaLk55WeAISxb74gESxdSeNmuJcU6F01oT
	 1NV+euPt/NQqg==
Message-ID: <7726e657-585c-42d3-aff2-c991eed42361@kernel.org>
Date: Mon, 8 Sep 2025 14:44:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: devmem: expose tcp_recvmsg_locked errors
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ncardwell@google.com, kuniyu@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org,
 Mina Almasry <almasrymina@google.com>
References: <20250908175045.3422388-1-sdf@fomichev.me>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250908175045.3422388-1-sdf@fomichev.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/25 11:50 AM, Stanislav Fomichev wrote:
> tcp_recvmsg_dmabuf can export the following errors:
> - EFAULT when linear copy fails
> - ETOOSMALL when cmsg put fails
> - ENODEV if one of the frags is readable
> - ENOMEM on xarray failures
> 
> But they are all ignored and replaced by EFAULT in the caller
> (tcp_recvmsg_locked). Expose real error to the userspace to
> add more transparency on what specifically fails.
> 
> In non-devmem case (skb_copy_datagram_msg) doing `if (!copied)
> copied=-EFAULT` is ok because skb_copy_datagram_msg can return only EFAULT.
> 
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  net/ipv4/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


