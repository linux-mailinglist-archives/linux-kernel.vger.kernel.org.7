Return-Path: <linux-kernel+bounces-846828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A71ABC9254
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6553E5376
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1B32E62C0;
	Thu,  9 Oct 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="dOZx/Of/"
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D633D8;
	Thu,  9 Oct 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014612; cv=none; b=jyLdPln4meiMlZVE7qi3amlNzdShfpbQxu07uqZ5AokQXevO1flTlyr++ug+rBjomOTYHFSnapIS9rh/EL82gwGWRQK8dhwjTLy2unGGf3JF0iGLi2stfEGnqb2ai/t+1eHSi6BEmtdwrFe+oY8C4t0kFgCVKjMt+syJ0ZMWWR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014612; c=relaxed/simple;
	bh=YtPJriu86qx1eJ/nNs64Z9s6KR07EF+KlsNLOB7Bk90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZAChsjcqKZ3eGN+pSVFQacV/Ks9TjK9f8Dv5JucsM79CfVS9DpqWebcElGWJXVTn9sdEqi7beDFe7EFBojZjBYw0wx3rdZqenBn1+Y0ZZGEFK2MYVPispGaJtHcojC38rVyjR7rxbNK36lxJiF5Q4trTG37xbQQc4j9ksmRIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=dOZx/Of/; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:4880:0:640:22e4:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 1BC4880E95;
	Thu, 09 Oct 2025 15:56:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id auJ7sZaLNOs0-vkA9vxfY;
	Thu, 09 Oct 2025 15:56:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1760014599;
	bh=dT0nLTSbKuL+mNsLNXaUN4T3goDzZ2vrCJByRRjzh5o=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=dOZx/Of/O6qRK6OsJGW83eDxzB8diUHVIw/ygTLBmdyLOS1S/2iZPDBUSzwQz5JRv
	 YYLSdDDbWlhHWaUhcni4ZWCmojExWLpKkV23pxUGqtwCaN8F4jKWu7S4+jd9elXgMT
	 sDp5RTphBkN8xFJQc3Je4RORS2w7bGXpvxVKykw4=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Thu, 9 Oct 2025 15:56:35 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org
Cc: apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
 lukas.bulwahn@gmail.com, corbet@lwn.net, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/2] checkpatch: add new check PLACEHOLDER_USE
Message-ID: <20251009155635.7f1f2331@nimda.home>
In-Reply-To: <20250917173725.22547-1-work@onurozkan.dev>
References: <20250917173725.22547-1-work@onurozkan.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Sep 2025 20:37:23 +0300
Onur =C3=96zkan <work@onurozkan.dev> wrote:

> Changes in v2:
>   - The check is documented in Documentation/dev-tools/checkpatch.rst
> file.
>   - Used ERROR instead of WARN on detection.
>=20
> Onur =C3=96zkan (2):
>   checkpatch: detect unhandled placeholders in cover letters
>   checkpatch: document new check PLACEHOLDER_USE
>=20
>  Documentation/dev-tools/checkpatch.rst | 10 ++++++++++
>  scripts/checkpatch.pl                  |  7 +++++++
>  2 files changed, 17 insertions(+)
>=20

A friendly ping on this patch. It's been over two weeks with no
feedback, would appreciate any thoughts or suggestions.

Regards,
Onur

