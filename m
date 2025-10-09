Return-Path: <linux-kernel+bounces-847067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDC4BC9CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7845E188458D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A579E1E7C23;
	Thu,  9 Oct 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mZ8KF4Hq"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4341F1932
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023595; cv=none; b=gNKTJzKIX8hBlQtDlcUqwjt9icB40qLO4JcYo26Iw0cR7pm2vQwQFEBJpXdijxZft1jitUl3m8mepsG2jIYYFI/rHUYZpRSP76LTP12mWEDu5larEY1CqzsRP6WJuOF2iTvhywz0cU7OAMhitlJhczdMm/TMxHhai1bQJNZPt5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023595; c=relaxed/simple;
	bh=vHT4mml/Nfbml0xk4/KK+lrmsPkXCmCZsxGJY9nykX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8Ui7kQMgQDGgRmK0YV17qyeg6UM66KURFaRSUBjtfVYYjIDSxg9qChkNRnzlyUDBWlCjN4U1pF5j1UKPB+p35duZj8A89qInZI0C3W9j5p831hKtKTnsfAxGNd2/ohcys1OViyUVWtA3g2wrIMWqNHJPtYN3h9bWs2oMjsaiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mZ8KF4Hq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760023591;
	bh=vHT4mml/Nfbml0xk4/KK+lrmsPkXCmCZsxGJY9nykX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mZ8KF4HqcHQ8cBZqIGrG9elLhSvonQ6hYdSdQkE44ec1oKFk4C0qfrf8ZuV2NIdh/
	 802liWwnc59w0kL0NCGk/PsC7is5byP+r4T4XH6XWkDTtQTDpSEytTCu8VfChdJiU/
	 odPNnzq1v/48tat5P1cp7o9DYUeAZ3KXDf8UQfhJdFGaLvnhSBs7iDi3SH/ZZ7B4Aa
	 2uyTgTipJJbAygcLr1Rl/Z6nO8yMGbFtwY6D1PrV4VPbT9G0chN9fiz5kStI8NgzIn
	 j+JRcx93ogCJ7b7M/TFxYEqxeM0iIGOdQxkOE+29PfaP2+hl2ZPCuajsmiU/D9ps21
	 slWT607oUHxQg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 14A0017E108C;
	Thu,  9 Oct 2025 17:26:31 +0200 (CEST)
Date: Thu, 9 Oct 2025 17:26:26 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com
Subject: Re: [PATCH v5 12/12] MAINTAINERS: Add Adrian Larumbe as Panfrost
 driver maintainer
Message-ID: <20251009172626.45feb3ea@fedora>
In-Reply-To: <20251007150216.254250-13-adrian.larumbe@collabora.com>
References: <20251007150216.254250-1-adrian.larumbe@collabora.com>
	<20251007150216.254250-13-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue,  7 Oct 2025 16:01:54 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Add Adrian Larumbe as Panfrost driver maintainer.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Acked-by: Boris Brezillon <boris.brezillon@collabora.com>

Welcome to the team!

Once this is merged, you probably want to ask for drm-misc access so
you can start merging panfrost patches yourself.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5257d52679d6..cb68fdec3da4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2066,6 +2066,7 @@ F:	drivers/gpu/drm/arm/display/komeda/
>  ARM MALI PANFROST DRM DRIVER
>  M:	Boris Brezillon <boris.brezillon@collabora.com>
>  M:	Rob Herring <robh@kernel.org>
> +M:      Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
>  R:	Steven Price <steven.price@arm.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Supported


