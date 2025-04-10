Return-Path: <linux-kernel+bounces-597101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD622A83521
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 02:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F121B612C4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 00:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA20B70830;
	Thu, 10 Apr 2025 00:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stqSRG9b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325571BF37;
	Thu, 10 Apr 2025 00:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744245875; cv=none; b=bdzDv0ZrUKi/e31gL4vkcAoqXk/ar/jN6ZPPSyEjNeusrgiiL8ToiLf8NGizkZomn8lpcjrmNd66uEu43EYKWyFyOBGbsgqCCeYPaX2XhL8IHkgP6oXTO7RVZSfZePWdz3ORb1+avqe123+7zcNmzS3SYUdt0kOhLjNs4hqNvEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744245875; c=relaxed/simple;
	bh=s6Mi5a6ne5nmm3KPRugEAD13xldMWCgW6hxneh5DGWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8IzSkoTwaAQBp+szhq/6GNouDzLIJMkY76hHZq+KPZTjG8tpB0vzmCfC0t/5v192TuOt128zYUM3w+ekeOTobl2/PDZMH50N2l+aWn6+egOuztgfAW8RKqFgtjSMqqVBEzShgioAGRMSS8BYqXz36MbI2gPuqVdy2WKTt3FJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stqSRG9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE10C4CEE2;
	Thu, 10 Apr 2025 00:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744245874;
	bh=s6Mi5a6ne5nmm3KPRugEAD13xldMWCgW6hxneh5DGWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=stqSRG9bbHbGLkIr8TTf238dd/RyIegcJpxxrT9g3fDv5Zm0DIJ34/Y/p6gtgLDHb
	 XylnpzltA00csOsjHmd1JJr3NUHA12ucNvHwwQ1BQEhEScFqx8sNVA0zRP8UNFIU03
	 rCi3jQO58AHhNKmKkNgIQTIw/FHe0GbcCae2Ekvb4ODBLQBQCZn8UWn6+vzkk+z4qe
	 fl5YzDeQMS6gDq83uJR7XjZ47dCc9L7saI3K4VvuW52w4e9hP6dtNgTm5UCWXK59ow
	 FgoLRVKIQTgicuXkTUxxvWHaxMoYzdkx0inKyocPhKLBaJwq350VZvmfZfG/TOApTq
	 Ux+pPMXMhht9Q==
Date: Wed, 9 Apr 2025 17:44:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 linux-kernel@vger.kernel.org,
 syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
Subject: Re: [PATCH net] bonding: hold ops lock around get_link
Message-ID: <20250409174433.7b3d0f29@kernel.org>
In-Reply-To: <20250408171451.2278366-1-sdf@fomichev.me>
References: <20250408171451.2278366-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Apr 2025 10:14:51 -0700 Stanislav Fomichev wrote:
> +		netdev_lock_ops(slave_dev);
> +		ret = slave_dev->ethtool_ops->get_link(slave_dev) ?
>  			BMSR_LSTATUS : 0;
> +		netdev_unlock_ops(slave_dev);
> +
> +		return ret;

Is it okay to nit pick? Since you have a temp now it's cleaner to move
the ternary operator later, avoid the line break:

		netdev_lock_ops(slave_dev);
		ret = slave_dev->ethtool_ops->get_link(slave_dev);
		netdev_unlock_ops(slave_dev);

		return ret ? BMSR_LSTATUS : 0;

