Return-Path: <linux-kernel+bounces-809233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA41B50A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE8B1BC1B40
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889AA1E47A3;
	Wed, 10 Sep 2025 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4lZrRA+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6F21E5213;
	Wed, 10 Sep 2025 01:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468152; cv=none; b=NtW7c2hnkC3QA0LQAl5FcmIu/HSb2kddTX/ZKmfbpwFKu6kOmFsIBiFxLYtR7NFN6LxMQdyw1XXcgRHfYbznGl+c463ji1UDXMTG3exgquTLOzvMkDSFo4A64VdPWVdvLq0aNBiHUmeNTIogaT/6zD39wiqVcafJLbDNFcw+Blo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468152; c=relaxed/simple;
	bh=Fec8sfobQBSww+UvyZTnZcpEuUkC3pn3M7kf7LSU+vU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgT+U8XEXrTkNMxRpOz8+sJDJGsXyjgLjhSLsmJldwYX9+M/PX/rQifmNhAPDT9DexwBPHAwReVNx2qF6N35OL+SinOcc5PgM98cK7AXW74w0lIiwgdN71wPbtCn63LH8N4ekB2Wxf/9JEiYQ775PvxlNRkrEXqOF3qqZAHAc2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4lZrRA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E605BC4CEF7;
	Wed, 10 Sep 2025 01:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757468151;
	bh=Fec8sfobQBSww+UvyZTnZcpEuUkC3pn3M7kf7LSU+vU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L4lZrRA+W9zQOVMghSDh9lXqH8CpXeAkxjP6jDZBMbhQxvMBvBnk+O+v+WazzXeYb
	 pYYpQn6P87RPke+Ckpa4SzsspFwiI/QtHL3xwgqiBYr0gTR6XQcsMjyn14uZETrfFA
	 Kn/9x0ZaTtZibsDM9s9RN83XTNqbTN1v8kYRT6KwzgTYVPKALVHYw+XMIJHShj2KjB
	 kxLUP32bcMA4jQxW2hYSt6INH/HF9Oc31lvRxikrw1a6QsRPkMBlliiu8N3Jk7n5rb
	 NtXXMf7nGBRW8ZIMZ1lquk3jzzc/XQAy0F9U1R0Ys+RKiaFYKogmPnXN8F1a2UZY4e
	 uO1EZ836XgsNQ==
Date: Tue, 9 Sep 2025 18:35:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ncardwell@google.com, kuniyu@google.com,
 dsahern@kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org, Mina
 Almasry <almasrymina@google.com>
Subject: Re: [PATCH net-next] net: devmem: expose tcp_recvmsg_locked errors
Message-ID: <20250909183550.5bcc71d2@kernel.org>
In-Reply-To: <20250908175045.3422388-1-sdf@fomichev.me>
References: <20250908175045.3422388-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Sep 2025 10:50:45 -0700 Stanislav Fomichev wrote:
>  				if (err <= 0) {

Should we change this condition to be err < 0, then?
I don't see a path that'd return 0 but it's a bit odd to explicitly
handle 0 here and then let it override copied.

>  					if (!copied)
> -						copied = -EFAULT;
> +						copied = err;

