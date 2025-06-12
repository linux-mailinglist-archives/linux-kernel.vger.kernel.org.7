Return-Path: <linux-kernel+bounces-683944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2E6AD73D9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 16:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE823B21FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A9E248897;
	Thu, 12 Jun 2025 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sf++W1Qx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38AC239E9E;
	Thu, 12 Jun 2025 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738601; cv=none; b=YOdjIo3Y6bMBK+OoUrlQy2kCtiHU8KS8L4GY4ho72nT6o7W8dkdW5wmRRz5xy7j6ddh8LjU7Ppp0k11rXHB62k4Z0ZZphn+LNd0BBC0vG9Aw1Vrx9d+4v8W5h8Z1lzw9qtBE/txpJMJO+0JNmDV02QH3gNenrYibjblR5/d+JBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738601; c=relaxed/simple;
	bh=29yOxaK9p38k0aPrPa8VqKFwIrBVus6+IDqlxrTtKTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgBD6Ho+yKZAvMwHQeeBp4a1V+q9x3dtwuCTJnkggtsR9jFV6/irp3ADvsT296sHnSQB1hf1WDKpuohyIMNztmPx9vXxg5+xUBmFM8xi5qXXl6BFvIbjXGSVBBLo7JH55YtKiazZpOVY4KrMRwmTkk06dgZav45Qpx8VTpBvAX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sf++W1Qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C06C4CEEA;
	Thu, 12 Jun 2025 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749738601;
	bh=29yOxaK9p38k0aPrPa8VqKFwIrBVus6+IDqlxrTtKTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sf++W1Qx0TxhCH+KhNrnHX0hTBpX+/2RCoA6MvUUgbzyRD96alhenO9ZRM2efIZIY
	 zbq13ej8blySQdPH2vMRnZn+POBRUx33omcQBp6PzYDdOTRRXOvjhWeJ1HMBP933+0
	 Ow0A7oEsdzS/4aYuy3TlrZo2cv3Lxgiag/NrNI0VYrvlz+tLtVUCcpz5gYyCZAF58M
	 i6jf0LR25NpD3//GU8wBOKTexJD+jm/SWsi7NfUMRvt4nA+A0pXyOMxy0jzW01RsE8
	 lMAYhHf03TOZ3t0nq6AM2Xt32736kfsc6sKAJnAlscOsjLohCXovwsC+fTv6QqcY0V
	 zvoAbf6SCl7ow==
Date: Thu, 12 Jun 2025 07:29:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ruben Kelevra <rubenkelevra@gmail.com>
Cc: Charalampos Mitrodimas <charmitro@posteo.net>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: pfcp: fix typo in message_priority field name
Message-ID: <20250612072959.431b9385@kernel.org>
In-Reply-To: <CAGHX7-P5fgFCs3cJTYERu9dLne=UADPc-dHPZ6GYvkcdmTHXwA@mail.gmail.com>
References: <20250610160612.268612-1-rubenkelevra@gmail.com>
	<87cybbzbe3.fsf@posteo.net>
	<20250611145144.2bc0a7b7@kernel.org>
	<CAGHX7-P5fgFCs3cJTYERu9dLne=UADPc-dHPZ6GYvkcdmTHXwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Jun 2025 08:38:20 +0200 Ruben Kelevra wrote:
> I hit it while building an out-of-tree module that reads hdr->message_pri=
ority.
> Cross-compiling for a big-endian target failed for me, because of it.
>=20
> That=E2=80=99s the only reason for the patch; net-next is fine, no need f=
or stable.

I see, please go ahead and repost with [PATCH net-next], no stable cc
and no fixes tag. Would also be good to mention in the commit message
that it does not currently cause kernel build issues, but is clearly
incorrect.

