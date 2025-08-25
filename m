Return-Path: <linux-kernel+bounces-784325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCD0B339F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20FA7B11CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33E82BDC0B;
	Mon, 25 Aug 2025 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Lxl/lSr2"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8C2BD5A8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111976; cv=none; b=HriWfG1myPrvA5ltpyzyrTsMXZglx5i6eEu+gTaBydOLr72cY9QVLu3QSig46sihe+9/KQrlOmYSb2wTKCRvY5MjGHiP99zWztvu3C2kbgroQdkqglqjDh/clxSSmqpsu7xolB1SPPKl0RtuLvDHnBFPaXOzzRIR2PdNKOipf4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111976; c=relaxed/simple;
	bh=8+PR+zrpFdf5yXPRxIaie2i1OqzKOsnI+Cg/NjRUK/Y=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M8KpDClRG0QZ9sA3bRrxwocPePv0or04t9V/DGnXnr+rzBE4ZcwzYmpAHx22xLjofrURXhls/SPuzqaq2E9YFb/CWiLaCGIpxrrgnWdOAkal52uo9IeGncqYu3ELUmx8BRN3GSIvAVaLFOOF1xtfXggCtn7afU+M/eUpn22YdWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Lxl/lSr2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1m6AUFG/wTkANLwgoSYJ+XLDqiRRBYABkW5BsmwGCXk=;
	t=1756111974; x=1757321574; b=Lxl/lSr2OALZGQLRTkPzg8dO20bJuk9R74MUvUV6aduf1Mx
	Lt3FaQwlCsK5vogZ9BOZr4edD0A/kwSnGRrQEnxiFtyKhTicGueD6EUhZYSDI9yV9fnrUcKiYu5C4
	b6X3S/JUWKYF5Gqe4/6ERFYgI7eXaOBgNLWacqStGMqSuCj5i5qrIfQwKjz/W6v3PWt99VlTmNvKz
	wBDU5Q9Rl27vxbXIpZQ/kwknJHZFKGmsrIDhHyCoWTXfevimDBqtz0MgBvp9tqM9yNJoTtDVO/zbe
	Dj/GOtDbGI9mqWwoWm9/bkPkmWZ3wH1GMrdTXjgoFkfXkSVwVnsY/UFm0cGnYSkg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uqSwa-00000001di6-25uf;
	Mon, 25 Aug 2025 10:52:48 +0200
Message-ID: <6f08683083e113ea31b331288a50f4f2ac5e26b9.camel@sipsolutions.net>
Subject: Re: [PATCH] um: virtio_uml: Fix use-after-free after put_device in
 probe
From: Johannes Berg <johannes@sipsolutions.net>
To: Miaoqian Lin <linmq006@gmail.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, Benjamin Berg
 <benjamin.berg@intel.com>, Tiwei Bie	 <tiwei.btw@antgroup.com>,
 linux-um@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Mon, 25 Aug 2025 10:52:47 +0200
In-Reply-To: <20250804075944.3612712-1-linmq006@gmail.com>
References: <20250804075944.3612712-1-linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-08-04 at 11:59 +0400, Miaoqian Lin wrote:
> When register_virtio_device() fails in virtio_uml_probe(),
> the code sets vu_dev->registered =3D 1 even though
> the device was not successfully registered.
> This can lead to use-after-free or other issues.
>=20
> Fixes: 04e5b1fb0183 ("um: virtio: Remove device on disconnect")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  arch/um/drivers/virtio_uml.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index ad8d78fb1d9a..c402c4cc908a 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -1250,8 +1250,10 @@ static int virtio_uml_probe(struct platform_device=
 *pdev)
>  	device_set_wakeup_capable(&vu_dev->vdev.dev, true);
> =20
>  	rc =3D register_virtio_device(&vu_dev->vdev);
> -	if (rc)
> +	if (rc) {
>  		put_device(&vu_dev->vdev.dev);
> +		return rc;
> +	}
>  	vu_dev->registered =3D 1;
>  	return rc;
>=20
This should now statically 'return 0' at the end.

johannes

