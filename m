Return-Path: <linux-kernel+bounces-891772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AF2C436F2
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 01:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1167C3B0398
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 00:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284BF190685;
	Sun,  9 Nov 2025 00:52:42 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB4615B971
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 00:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762649561; cv=none; b=HG3ULeqBBPSJfqoMwzdW6Ku3oQidmGddmrB9BnFQQiVOuxPO7GgIGlsuRHRkoAMg0+yyQaLI5VPou/oapV5wvAaCIJCkc1fB9qtX6EYHLNCiUxsopRATcqpPKqleHwbKDisxq5ZXQQ79gKE6nQi3waK5Oty+W6Fq4kJ0UGsd+rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762649561; c=relaxed/simple;
	bh=9X8ZIls7ZXc+lK1POlli2gos/qev30fz/7qAGoTPOyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+0mG7edIkI7KoLQXABu/4Xxid+sPLC2hPJn4C4ttaykm9eJnVhx5aBvZToZ/9zaekk/aWGS82fcexM2d283yGA7faFgCdwS6szYzWqOpro5Do6lBOoaRJC8vAVlm+rliQPoB2bRXp136WX76Xp7VqQXvb6U/qyOL88BIOdrXmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 9F64112CF39;
	Sun,  9 Nov 2025 00:52:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 679052F;
	Sun,  9 Nov 2025 00:52:30 +0000 (UTC)
Message-ID: <cc0edf9cf2ee40bc13eec609eec5686de4f9f77f.camel@perches.com>
Subject: Re: [PATCH 1/1] checkpatch: add MA_STATE to declaration_macros
From: Joe Perches <joe@perches.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org, kernel test robot <lkp@intel.com>, Andy
 Whitcroft	 <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn	 <lukas.bulwahn@gmail.com>
Date: Sat, 08 Nov 2025 16:52:27 -0800
In-Reply-To: <20251108234725.1650246-1-jim.cromie@gmail.com>
References: <20251108234725.1650246-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 679052F
X-Stat-Signature: yx6w6mncc67qgxm8563i1tgetdnd5ibd
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+MblxEu1TEAoos0pUOn/yHmB9CpoLWbxw=
X-HE-Tag: 1762649550-13431
X-HE-Meta: U2FsdGVkX187WeBzzri5uOGxbbleEc9noZQFw7wKe9YbXMVssLNnlaBVD90QJlMZwdXGCYBfpvJH8mWjsTycFBq6KJZJLxipYw24MGN74xLeAXXvk+TG4vSAkOo53Q6VShj/tzXHPr4oCbe/StUGgHAChI8rS8SnNuiPbDtYpIxDTzMiFbIAZhET/D4Hv3icc0Mmo+6+ZyurpNYHgfsqTepg5iIQoGclsyFI22MAvfhfpk59l2hLqUC6L5sQ1NNS8bpQwT79mDvkNtC+x+lo3XQUwww7jOqAOm41Q6Z6/F70AjaXrMn+Uh+VAdCcC/U2nCzOVajqmAxnflJ0ahmEkxieAxOjzg2Uo5f34WXCnZkcSius1Y09rtjhxkgUuLF9tyucq9YoTDo=

On Sat, 2025-11-08 at 16:47 -0700, Jim Cromie wrote:
> MA_STATE is used repeatedly as a declaration, add it to the list.

OK but

> I left out the $Storage regex component, since I saw no cases wanting
> it, via: $> grep -r -B1 '\bMA_STATE' .
>=20
> This change fixes the following, reproduced locally.

No following ?

And I looked at the MA_STATE macro definition that has
several NULL or zero unnecessary member initializations
but doesn't initialize the entire structure as all
non-named members are NULL or zero by default.

I wonder if the unnecessary NULL/0 initializations there
could actually increase the object size.

With gcc 15.2.1 allyesconfig & defconfig do not change
either way but I don't know if all supported versions
minimize the initialization properly.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202511071306.OJpTf7fK-lkp@i=
ntel.com/

This Closes: url is not found on lore

>=20
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index e722dd6fa8ef..4b5e2e64dece 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1096,7 +1096,8 @@ our $declaration_macros =3D qr{(?x:
>  	(?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]=
+){1,6}\s*\(|
>  	(?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
>  	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(|
> -	(?:$Storage\s+)?(?:XA_STATE|XA_STATE_ORDER)\s*\(
> +	(?:$Storage\s+)?(?:XA_STATE|XA_STATE_ORDER)\s*\(|
> +	(?:MA_STATE)\s*\(
>  )};
> =20
>  our %allow_repeated_words =3D (

