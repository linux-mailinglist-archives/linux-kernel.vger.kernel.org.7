Return-Path: <linux-kernel+bounces-798397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 021C7B41D48
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69DA1B21572
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33EF279DAD;
	Wed,  3 Sep 2025 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP2vsuiH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB640855
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900022; cv=none; b=jUQf2TsPfAdFA0Oc9h+qkKq/yF97q3GovfdCq4i3PZJ7w0xD2n6IWmC6VIGav6+PIsgsEuRjTWPW82iYvqFJtbActOqiWASbNwHqvHW6xb2Itl9F0S7yQwxRqn3aXisXMBSBOprX5o25+nL0a76EJiTWRd9fc7ejG1nj/0fYsMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900022; c=relaxed/simple;
	bh=E+tm49iLapdp8c9m9L5vyjEMtzVvJkZDok4ll4GVeBs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=NhPGZN7jDXkeKlkh32Unpcl5Z0RfdbgAqxzqXKuDI9pzXecbnux5brvK6EQ73QfRO4t6gZU5FJAR9AVJl3Io5wevv+lODdIdFQviykfQnY+NfehK2L9+Otly51VOWrcGlLBkGznR0Rlw0tiP9P8x3IGWqaLlZ6+fIdy1if/rW2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP2vsuiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCEBC4CEF0;
	Wed,  3 Sep 2025 11:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756900021;
	bh=E+tm49iLapdp8c9m9L5vyjEMtzVvJkZDok4ll4GVeBs=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=UP2vsuiHApTQz0Qe0Zyb9utghA42nO4pKTxwgYJBiJHzd4sRKGBlmwD2aB9R2M9J1
	 tAaH+HgID+5xqDciprlqzI+5xl4/zzaPhSu/hpfUnSCa8/+VYMIIBOIuiLE/EkbN+K
	 Ag0r7CtaF+m0lx+/p6EBs/pJDKfgOawAhZTagFV3fiqcjfWZqWiaQQiztI6MI8F2iL
	 PwtgWfxbZYQ9aIA2DKK0AUe8L96bWiYCBoxVLJqMMmJssSHbwii9LhnBufVyMYnVI1
	 bW1sKRHzUjk429zkQk9e7zVrKjIhJ8wiAm36dz+Hz7TVVwcDS524PzVNzw0yAwX2Hy
	 D6reClid+shgw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Sep 2025 13:46:58 +0200
Message-Id: <DCJ52UB7OIXR.3MS54RJKMI4OK@kernel.org>
To: "Zijun Hu" <zijun_hu@icloud.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2] driver core: auxiliary bus: Optimize logic of
 auxiliary_match_id()
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <linux-kernel@vger.kernel.org>, "Zijun Hu" <zijun.hu@oss.qualcomm.com>
References: <20250903-fix_auxbus-v2-1-3eae8374fd65@oss.qualcomm.com>
In-Reply-To: <20250903-fix_auxbus-v2-1-3eae8374fd65@oss.qualcomm.com>

On Wed Sep 3, 2025 at 1:37 PM CEST, Zijun Hu wrote:
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index 12ffdd8437567f282374bbf3775d9de7ca0dc4c7..ed2537cf3b048149e784e5a58=
2631db549050734 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -171,17 +171,18 @@
>  static const struct auxiliary_device_id *auxiliary_match_id(const struct=
 auxiliary_device_id *id,
>  							    const struct auxiliary_device *auxdev)
>  {
> -	for (; id->name[0]; id++) {
> -		const char *p =3D strrchr(dev_name(&auxdev->dev), '.');
> -		int match_size;
> +	const char *auxdev_name =3D dev_name(&auxdev->dev);

I feel like this is a bit too ambitious. Using dev_name() directly for the =
calls
below seems more obvious to me.

Yes, dev_name() contains a branch, but I'm pretty sure the compiler optimiz=
es
them away for subsequent calls anyways.

> +	const char *p =3D strrchr(auxdev_name, '.');
> +	int match_size;
> =20
> -		if (!p)
> -			continue;
> -		match_size =3D p - dev_name(&auxdev->dev);
> +	if (!p)
> +		return NULL;
> +	match_size =3D p - auxdev_name;
> =20
> +	for (; id->name[0]; id++) {
>  		/* use dev_name(&auxdev->dev) prefix before last '.' char to match to =
*/
>  		if (strlen(id->name) =3D=3D match_size &&
> -		    !strncmp(dev_name(&auxdev->dev), id->name, match_size))
> +		    !strncmp(auxdev_name, id->name, match_size))
>  			return id;
>  	}
>  	return NULL;
>
> ---
> base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
> change-id: 20250902-fix_auxbus-76bec91376db
>
> Best regards,
> --=20
> Zijun Hu <zijun.hu@oss.qualcomm.com>


