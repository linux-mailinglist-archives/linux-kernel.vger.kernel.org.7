Return-Path: <linux-kernel+bounces-749260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 432C1B14C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B79545023
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADEA28981C;
	Tue, 29 Jul 2025 10:24:32 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1566289370
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784672; cv=none; b=rknNT9CpU1rMP2lLcXriqVDk15cGr8uzZvP06yxPNOnTzgftecd4VlC9nCKsZc94aLNPESt58fS8q1atfD4309ejdr9WdChAHmrwc7H159taRB8KJoL/tb4/VPW9YP2MaN+FM+VItPQ4FQB3Vgx+hMZrBOELoS2Ksl3IQSx9atM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784672; c=relaxed/simple;
	bh=C7XxuGD/2TO03hVl0sw8ExQFfS+rOKML9QM3NKpZEt4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M0JUGRfBex1gmXSdJZIaXl2CcIg/YSHTIGFa2xjwx0rLbz48bLRqpxsC7zgCWGl27XlMZthqXPBqjPyMGZP1FzEHG4l3GAhekELpkw3DKRdIy0oBEdMd5MEjuuGKA/d44dz//UaqQYX2EohlN6lkKedmkQWTWXy7xgHSY+x7llk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 6A2B31605A0;
	Tue, 29 Jul 2025 10:24:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 2554520010;
	Tue, 29 Jul 2025 10:24:21 +0000 (UTC)
Message-ID: <61958a3cca40fc9a42b951c68c75f138cab9212e.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: suppress strscpy warnings for userspace
 tools
From: Joe Perches <joe@perches.com>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, apw@canonical.com, 
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Tue, 29 Jul 2025 03:24:20 -0700
In-Reply-To: <20250727125044.101779-1-suchitkarunakaran@gmail.com>
References: <20250727125044.101779-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: sorxby9x4t56c5m4748g1regi689gm4b
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 2554520010
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/6rnYb1cQQjOtgR0ziqG7qZYAA1HQ3xP0=
X-HE-Tag: 1753784661-486860
X-HE-Meta: U2FsdGVkX19pdPjsKwsML4dm4K9Ax7S4ppTaGj0h0v7yDGIleSpxOZTvwpT2df9RMLAhiYAY0yyhytzVBTMNCnnznPLyV568Hy0wlsezH7manBnVFQKVrDC8TlIAykHDX3VehRMcccdQKmlSWM6TOvHm+c2uPMWJJva+hmm4jbb7bixQrsUD7pFYGRqD72ot6+dOmjIhPttPKw+q2ttS04yN0MYQnNtHUztAqyB7wANYftW6gXLa4qZRetn9eTvuZovdkmlFbvYRJGpwi2VAvG1f7CqcL4hAPFu9h/pazQZShtHkbTAw8Z1yc5Fluyb41WOccYJEU/riXIgHbgdEpwQgE/8OkOBKSXR57WVS+U6dpEIJsXsjKg==

On Sun, 2025-07-27 at 18:20 +0530, Suchit Karunakaran wrote:
> The checkpatch.pl script currently warns against the use of strcpy,=20
> strlcpy, and strncpy, recommending strscpy as a safer alternative.=20
> However, these warnings are also triggered for code under tools/ and=20
> scripts/, which are userspace utilities where strscpy is not available.
> This patch suppresses these warnings for files in tools/ and scripts/.
>=20
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
>=20
> Changes since v1:
> - Create is_userspace function to check if the file is in userspace
>   directories

the changelog bit should go below the --- line

> ---

This
>  scripts/checkpatch.pl | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7019,20 +7019,24 @@ sub process {
>  #			}
>  #		}
> =20
> +        sub is_userspace {
> +            my ($file) =3D @_;
> +            return ($file =3D~ m@\btools/@ || $file =3D~ m@\bscripts/@);

All other sub uses start in without indentation.
Please move this next to other sub blocks.

Please do a git ls-files -- '*tools/' and see if too many other
files are matched, especially the Documentation/ ones.

> +        }
>  # strcpy uses that should likely be strscpy
> -		if ($line =3D~ /\bstrcpy\s*\(/) {
> +		if ($line =3D~ /\bstrcpy\s*\(/ && !is_userspace($realfile)) {
>  			WARN("STRCPY",
>  			     "Prefer strscpy over strcpy - see: https://github.com/KSPP/linux=
/issues/88\n" . $herecurr);
>  		}


