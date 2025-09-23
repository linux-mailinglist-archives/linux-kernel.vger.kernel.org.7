Return-Path: <linux-kernel+bounces-829469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C29EB97241
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB572A2868
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDDB2D59F7;
	Tue, 23 Sep 2025 17:58:12 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A562C026F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650292; cv=none; b=TlCL4kO4blqNomAGsLQviahMzBkTTU9LM/kKRdt1vzyiQsOG154xQFWBHUKMY6+si+lyNNfolXEcsfrQAjx+x/UDbE5/0DUw3l8Z/709JVvqEDlBne9nhVgR22P4MyUsf6VOCu5N/KU3TVwYDOz25mjJrM84CKLR+DHTsloU/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650292; c=relaxed/simple;
	bh=wqdHXYHD2mDbQ7QYKXLFy2xzEMRIBoD8MFVRb7pXMAA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hGKZePXvHp45kFN4YG0v9QKYfE2e+XulSqLBarhCHLrORnxsf67DnIzImDpEuini3Boa6jxJmWKwCUEdhFtwAQHtqXPiEjVHRcwehx1PPKZouV3SS7OG5efchqXIuorLAwu3rOiTrf0ubNIfZsyZOAdm8dpEb5Fz+Rwa0TacLdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id EACAF13B303;
	Tue, 23 Sep 2025 17:58:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 7C73C20026;
	Tue, 23 Sep 2025 17:58:00 +0000 (UTC)
Message-ID: <e4b30be3891cf6e615c5079e7330c10f433520f9.camel@perches.com>
Subject: Re: [PATCH v3 RESEND] checkpatch: suppress strscpy warnings for
 userspace tools
From: Joe Perches <joe@perches.com>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, apw@canonical.com, 
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: skhan@linuxfoundation.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Sep 2025 10:57:59 -0700
In-Reply-To: <20250923171722.7798-1-suchitkarunakaran@gmail.com>
References: <20250923171722.7798-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: ao8a7a5y9bbsbr4dhoe5cs66o8sio5zu
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7C73C20026
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19+5JqIvS9md6f99LCPycD60LxX/ihyzuo=
X-HE-Tag: 1758650280-101948
X-HE-Meta: U2FsdGVkX18Vy9F5n1pDUPPpBRLknbyFoMBQtXLLEgEI5h+u8lk94VuDow/v0NPUyeclHAgyzhZqGZ/qwtb29ovMpvoA0WR9IB7gYB8xcN7+nWZY4IQWIg2nM/0d1SiF3b4VBpq0yOZhbNFlUQAPPaBuOcOM48E7X6B1Lnt22kdAbAOTd+6aVwg+isjTUQSlJh+uks78U3eK57cHmIDpPVhbFBTBWPwHqwnaEs8He8WCEzClKF3VoCagMbHzj+vzAsSRCLas5uY8vvAcMGafjKeCL2ZKHLJl8X+vsRaG6+ZacvZLX3bnnWXxaQehtBO+w4DqJdzza3y7WeunihY5ryTcEaDx8RRutW+EWZNNsn55vlDiQkvL9deg9XjzZdShKx+0Xqe2TznyENJqualbO01oHEeR3/gC2CfO/B0wJ6Q=

On Tue, 2025-09-23 at 22:47 +0530, Suchit Karunakaran wrote:
> The checkpatch.pl script currently warns against the use of strcpy,
> strlcpy, and strncpy, recommending strscpy as a safer alternative.
> However, these warnings are also triggered for code under tools/ and
> scripts/, which are userspace utilities where strscpy is not available.
> This patch suppresses these warnings for files in tools/ and scripts/.
>=20
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

Acked-by: Joe Perches <joe@perches.com>

> ---
>=20
> Changes since v1:
> - Create is_userspace function to check if the file is in userspace
>   directories
>=20
> Changes since v2:
> - Change regex pattern to match top level directories only
>=20
>  scripts/checkpatch.pl | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index e722dd6fa8ef..fe580b0810f9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2636,6 +2636,11 @@ sub exclude_global_initialisers {
>  		$realfile =3D~ m@/bpf/.*\.bpf\.c$@;
>  }
> =20
> +sub is_userspace {
> +    my ($realfile) =3D @_;
> +    return ($realfile =3D~ m@^tools/@ || $realfile =3D~ m@^scripts/@);
> +}
> +
>  sub process {
>  	my $filename =3D shift;
> =20
> @@ -7018,21 +7023,20 @@ sub process {
>  #				}
>  #			}
>  #		}
> -
>  # strcpy uses that should likely be strscpy
> -		if ($line =3D~ /\bstrcpy\s*\(/) {
> +		if ($line =3D~ /\bstrcpy\s*\(/ && !is_userspace($realfile)) {
>  			WARN("STRCPY",
>  			     "Prefer strscpy over strcpy - see: https://github.com/KSPP/linux=
/issues/88\n" . $herecurr);
>  		}
> =20
>  # strlcpy uses that should likely be strscpy
> -		if ($line =3D~ /\bstrlcpy\s*\(/) {
> +		if ($line =3D~ /\bstrlcpy\s*\(/ && !is_userspace($realfile)) {
>  			WARN("STRLCPY",
>  			     "Prefer strscpy over strlcpy - see: https://github.com/KSPP/linu=
x/issues/89\n" . $herecurr);
>  		}
> =20
>  # strncpy uses that should likely be strscpy or strscpy_pad
> -		if ($line =3D~ /\bstrncpy\s*\(/) {
> +		if ($line =3D~ /\bstrncpy\s*\(/ && !is_userspace($realfile)) {
>  			WARN("STRNCPY",
>  			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see:=
 https://github.com/KSPP/linux/issues/90\n" . $herecurr);
>  		}

