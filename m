Return-Path: <linux-kernel+bounces-895725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16772C4EC58
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDD118889FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15695364E98;
	Tue, 11 Nov 2025 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="q0vYo4qq"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F450313537
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874498; cv=none; b=Fipaf1YZzcAKmf6Cl3G3dGwQ2yC9pLqwLkrVs/aqKMhHRTo2ZRudCjU8iK0+vLGzknSTRCxzVscxJTSfUZj7YtFhFe4Y3japao4hP8L6VQwfSSDMG9j3+5aYis0RHWMmcx7iMPDf2u1xlfIqLD/B0aC5QgL5xPlpndQAN4TSRhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874498; c=relaxed/simple;
	bh=nMj54SUz8pdQghuB45xHQESh/8ZSXLgHcoaDbE31i1s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nLS0Qz41DllvoJWShJk3fcmUvQ81GbywVC47w/cvthmzddCkWggzscK1Uk+0sM82DOpPPU80CBtEvBjMQzP4vEfnAxCnGalwCMSsBZgHnmvaFBba+hKbUuWftuxOgH+MAYq9UDI9WbHXccEj+7fjRkee/xgyLhYmRFIeZrjWroA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=q0vYo4qq; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d5VcX5n2wz9tWl;
	Tue, 11 Nov 2025 16:21:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762874492; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9AOIQTAr+rJ6aj3EobQIaLVDl4XDG7YKi47rzRBvHE=;
	b=q0vYo4qq2X6h3pmSr9Y9Vb3NpLWnTKttNwZCFPEztb4QX8c67VVEmmI9X9O4HGMQGGy5Pb
	ZKDiIzxIi/i3VoJe3mDZIiCWPDkF3nri3jsfsP5bdY5q1mNQ8BuUfC/H9RzinuYIYgkB4r
	hGtdRx+EfyySp0PDlnS9rJjzfW9xhqOb7HIcvzkj6QCbibCVSUw2DHfJ6VR4Z+D3bAiFtN
	DIdZtL2hcjIYqVmq0rxT18CJkHGTGnHUXYFIKs0/6zXs88OKxZ4Km4qMVJR50U0YB2LVks
	xOMlmrlsJKXrIZtkJZ2FBVWNdlTWp3FqvICJWqGWb+KdNrVMZzRCMz6+5lSIXQ==
Message-ID: <629a4be58b02dac86d267fb00b8e44d7aa01877d.camel@mailbox.org>
Subject: Re: [PATCH v2] misc: cb710: Replace deprecated PCI functions
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Madhur Kumar <madhurkumar004@gmail.com>, arnd@arndb.de, 
	gregkh@linuxfoundation.org, mirq-linux@rere.qmqm.pl
Cc: linux-kernel@vger.kernel.org
Date: Tue, 11 Nov 2025 16:21:30 +0100
In-Reply-To: <20251013132833.1783880-1-madhurkumar004@gmail.com>
References: <20250919083214.1052842-1-madhurkumar004@gmail.com>
	 <20251013132833.1783880-1-madhurkumar004@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 9kcupromsr8b1wiudg5h6pshiwoesi6w
X-MBO-RS-ID: bf773dea8db5c65684d

On Mon, 2025-10-13 at 18:58 +0530, Madhur Kumar wrote:
> pcim_iomap_table() and pcim_iomap_regions() have been deprecated.
> Replace them with pcim_iomap_region().
>=20
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---
> v2: fix checkpatch warning for missing space after 'if' in core.c
>=20
> =C2=A0drivers/misc/cb710/core.c | 8 +++-----
> =C2=A01 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/misc/cb710/core.c b/drivers/misc/cb710/core.c
> index 55b7ee0e8f93..a1e6ba62c298 100644
> --- a/drivers/misc/cb710/core.c
> +++ b/drivers/misc/cb710/core.c
> @@ -223,13 +223,11 @@ static int cb710_probe(struct pci_dev *pdev,
> =C2=A0	if (err)
> =C2=A0		return err;
> =C2=A0
> -	err =3D pcim_iomap_regions(pdev, 0x0001, KBUILD_MODNAME);
> -	if (err)
> -		return err;
> -
> =C2=A0	spin_lock_init(&chip->irq_lock);
> =C2=A0	chip->pdev =3D pdev;
> -	chip->iobase =3D pcim_iomap_table(pdev)[0];
> +	chip->iobase =3D pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
> +	if (!chip->iobase)

Nope, this is wrong. pcim_iomap_region() returns an ERR_PTR on error,
not NULL. You need to check it with IS_ERR or similar.

Sry, late to the party, but just saw this. It was applied already, so
someone should send a fix. I could, but maybe Madhur can do it faster
since he's got the branch etc already.

Thx,
P.

> +		return -ENOMEM;
> =C2=A0
> =C2=A0	pci_set_drvdata(pdev, chip);
> =C2=A0


