Return-Path: <linux-kernel+bounces-747075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F035B12F67
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 13:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941593BBC6E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 11:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811DE1E2602;
	Sun, 27 Jul 2025 11:55:57 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC97C7DA9C
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753617357; cv=none; b=LqDxIcdRcfsGGqD9dTxhxZFNvGJRh/U3N9Ll2ytwXNOBp30kgKfhJ0XwnT2QGumVeBpOkrvlBGrei7C06jHM+4kosMgfUcJviuZkb3xJATiFPrzZGiTuHcMT8wUhz2nXNu8S6u812iwPqSP9uzp7dODQTnpwK4ZP0nd31Bd3Mxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753617357; c=relaxed/simple;
	bh=LtomfhiWAB6xUadkgFUuxkUjUXise5GTj6Gp1iOvrKs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LL4eDLI2P3MtDXQP1SdeCWDoix9bNc5gs6mJAw3KD0lSnWTk2i+BjmTasZhKXvgWi1AYheF/52ENFA+xZZdv3MPf6Hu5ZTtL2eGjg/d+xV60yQcTpXkevqUS7+nYTKsayahqyt3RNblsW4LUTMpa1FNZk7fTGaZt6E/ZqNLX77g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id C1B3B10D07C;
	Sun, 27 Jul 2025 11:55:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 81ACD20025;
	Sun, 27 Jul 2025 11:55:46 +0000 (UTC)
Message-ID: <acacadd2c1112e31cccbe8db504ce30bd8587852.camel@perches.com>
Subject: Re: [PATCH] checkpatch: suppress strscpy warnings for userspace
 tools
From: Joe Perches <joe@perches.com>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, apw@canonical.com, 
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Sun, 27 Jul 2025 04:55:44 -0700
In-Reply-To: <20250726185432.162632-1-suchitkarunakaran@gmail.com>
References: <20250726185432.162632-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: o7zufsf7ufptwzuyrrzd3w1jn8az9xq8
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 81ACD20025
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19dhVxEe1pYQ7C7rf6nIC/OwhobK5M3rFY=
X-HE-Tag: 1753617346-20858
X-HE-Meta: U2FsdGVkX1/R4cwxqgw1AfKXVvKU687clxSYbzQhxRzi0ykNdNGHYS1WVd3v3bxlfyomElTyoUW31xS96pXT2KeOlKLSiVaA/2yS/T6Kc5VJVTFkcfBSLYMLgNG+2/OnetJHbvVTLJt3IRKP1jnyxYu4L9DZNAs3Ol4ZH6Zu4NTuYGpRK53gZkxkixJ4BNLRdEc4knYV7IoOgkO65nMCUzUD/pyYOdcqYD5k1YXGx9fiBFGdSGSpIbI5EpTjTeS5xmdZ9yJbZ3TJkOs1XuAEyWRpO9pJWWkezqVoOogGzg5eyMrE6/pcOoknFHRYFY6J

On Sun, 2025-07-27 at 00:24 +0530, Suchit Karunakaran wrote:
> The checkpatch.pl script currently warns against the use of strcpy,=20
> strlcpy, and strncpy, recommending strscpy as a safer alternative.=20
> However, these warnings are also triggered for code under tools/ and=20
> scripts/, which are userspace code where strscpy is not available.=20
> This patch suppresses these warnings for files in tools/ and scripts/.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7020,19 +7020,19 @@ sub process {
>  #		}
> =20
>  # strcpy uses that should likely be strscpy
> -		if ($line =3D~ /\bstrcpy\s*\(/) {
> +		if ($line =3D~ /\bstrcpy\s*\(/ && $realfile !~ m@\btools/@ && $realfil=
e !~ m@\bscripts/@) {

Maybe instead create a is_kernel or is_userspace function
and use that instead of the test

	if (!is_userspace($realfile) &&
	    $line =3D~ etc...

and=20

are all <any_subdirectory>tools/ always userspace ?


