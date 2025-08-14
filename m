Return-Path: <linux-kernel+bounces-768585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B65B262E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6A3CB66E52
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF0B23A9AD;
	Thu, 14 Aug 2025 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZ7sH8Mx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BBA31813A;
	Thu, 14 Aug 2025 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167259; cv=none; b=ctzgNYACCXDnM4LfM3gtyrA8k9pXKXYBxZtz8Rv9y7vOYk1PN97n0qm6R78+0qgMn3+OnAcqjy4wzPI8MZf3MuuJlTYE12tVPwd6imiKAmshZi280ACTA6uEKOlTVpP9C745zUg3L7F7fzgtxFoSr0iQa/x88s9UpyffabnZGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167259; c=relaxed/simple;
	bh=hsBkwJF3St3qBKx1WqP2VR8h+hSlYAmg1c+OKwcJqBU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=o14SOkLQ/OmLqnuzzGHmGg6xasDbjA6ahDlH1LdcL8k0UC9fjWasbJvXvonNYBO7SJdztBI9Lx2xjQEM9aVNErXpdfQ8oHzcXI3Rab0WQ0gOYm7RAS4rwgpvBuKT9pGlgGlMZF/QLgD8EqeLGfDvtdossZqJNIuFMYfVq35fQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZ7sH8Mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53153C4CEED;
	Thu, 14 Aug 2025 10:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755167255;
	bh=hsBkwJF3St3qBKx1WqP2VR8h+hSlYAmg1c+OKwcJqBU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=jZ7sH8MxJex8dTNCa14QLQdrdmH0DiyLkQtMHrFseRrzd6UCT3Y05K2oe+JM+zSDI
	 LmEsMvglXXg8sweg/i/lYtucYenE/p2p3Yv4e1nKnxtnjvFBffz44LUVhfm9z395hh
	 rv47Bd9zfrwxp5isB/5Xs2/I0Ff1ThTiSAXWsaJ/OLBblQ5a5KVOAshmeveOxFUg6D
	 GoNCb6kNZoZheiLWGWSQaRO0VUppUTJqpvjisd2UGr3PgIIJBGI7mBlAV2u2c54qzi
	 64qJJNROmBuB7dRenpQ/MJBDkvoEkusNE36z8a8j/ZhetIqaCz9nMH8ej15NcC5zR4
	 BL5xnHQIuvpSg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Aug 2025 12:27:32 +0200
Message-Id: <DC22V4IMAJ1Q.3HJUK21LRN5D5@kernel.org>
Subject: Re: [PATCH 1/3] lib: Add ref_proxy module
Cc: "Tzung-Bi Shih" <tzungbi@kernel.org>, <bleung@chromium.org>,
 <dawidn@google.com>, <chrome-platform@lists.linux.dev>,
 <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
To: "Greg KH" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250814091020.1302888-1-tzungbi@kernel.org>
 <20250814091020.1302888-2-tzungbi@kernel.org>
 <2025081410-salsa-alabaster-9294@gregkh>
In-Reply-To: <2025081410-salsa-alabaster-9294@gregkh>

On Thu Aug 14, 2025 at 12:05 PM CEST, Greg KH wrote:
> I've added Danilo here, as hopefully this is doing much the same thing
> that his rust code does, but I think it's using different names?

It does exactly the same thing as we do in Rust with Devres [1] and
Revocable [2].

The only difference is that this uses SRCU whereas the Rust stuff uses RCU.

One reason Rust is using RCU rather than SRCU is that in almost all cases
we can avoid the need for synchronization at all, by having a proof through=
 the
type system that we're accessing the resource from a context where we can
guarantee that the device is bound, i.e. we have the guarantee that it can'=
t be
unbound concurrently.

While for the few cases we hit where we can't proove that the device is bou=
nd
anyways, we don't need a sleepable context and rather keep the critical sec=
tion
short in order to not delay device unbind too much.

> Danilo, any ideas if this matches up with what we have in the driver
> core rust code now, and would it help out with the drm drivers as well?

As mentioned it matches almost exactly. However, I don't think it'd be wort=
h
building abstractions for it in Rust and use those instead, we can do it wi=
th
less code and in a more ideomatic way in Rust right away.

However, *both* this and the Rust Revocable suffer from the same problem, w=
hich
I have on my list to solve. That is, we have a synchronize_{srcu,rcu}() cal=
l for
every devres node being dropped on driver unbind. Where, instead, we want d=
evres
to provide two callbacks; the first one where we revoke the resource (in C =
this
would be the call to rcu_assign_pointer(rpp->ref, NULL)), subsequently call
synchronize_{srcu,rcu}() exactly *once* and then have the second callback t=
o
free / drop all the resources.

I'll also reply to the patch itself.

[1] https://rust.docs.kernel.org/kernel/devres/struct.Devres.html
[2] https://rust.docs.kernel.org/kernel/revocable/struct.Revocable.html

