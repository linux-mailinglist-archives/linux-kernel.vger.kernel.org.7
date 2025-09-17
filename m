Return-Path: <linux-kernel+bounces-820924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FCCB7FD67
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BD77B832B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FE522ACEF;
	Wed, 17 Sep 2025 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="TTkoncLH"
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E8221554
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117686; cv=none; b=rk2nz2wz+/x/RUrxZytxuwhq2vnCGRTJjawWYOWw8+ie47Ct+5fC1Je9wXfZHPkQDaQiWtLBo7yU93tgT+nH+vEBUQg/MtWdDCyFBVDBoah73HpcNZrs9F/h2hC+JMKUkMH5YNxZbj/XgHfhJKqb9ma8J2edCkmRg92Bmy5GzHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117686; c=relaxed/simple;
	bh=/AfbjX/jYllr4V3pASSWaipU1gYxGpN3Yoy6RG6sVE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVOLDrsEDzfia5Xl8qExXC3gd6p20AoNaCDA/g92lxA/QvwOmp6NTCOaSkETYp39GEem8wrgnnzdu1ZwEx8Yu5jtLXDEAPixbJunyCGAi/UYaiDve7MvFNSIPXwHqCMpb/x2HyY7cCKt7ou2aTb5LUtMaOegUdfuzK9BTlJiaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=TTkoncLH; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2908:0:640:b877:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id E563A8206B;
	Wed, 17 Sep 2025 17:01:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id A1STVW8MxuQ0-3c6VqYoj;
	Wed, 17 Sep 2025 17:01:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1758117673;
	bh=6zZlQz/YD/jhK0omFxxGjG7VhM9sjBQmzPRMKo/erpY=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=TTkoncLHRx7HbC6QgmVUo+mdDPNMbA2Q2OX34klikNzYwH6NMfaRcwEFTETE23fCD
	 rmO/BsKZHG507y6rZYkKZ/s3I/akWZX2YT9RIm14RP1e0bE54Ca98ssm512a/WfX3G
	 t372wZaA0v+FuTUeDTRhNxrMux1AOVuXpqeV2JDA=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Wed, 17 Sep 2025 17:01:10 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org
Cc: apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
 lukas.bulwahn@gmail.com
Subject: Re: [PATCH] checkpatch: warn on unhandled placeholders in cover
 letters
Message-ID: <20250917170110.4e6d4831@nimda.home>
In-Reply-To: <20250917114909.7678-1-work@onurozkan.dev>
References: <20250917114909.7678-1-work@onurozkan.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Sep 2025 14:49:09 +0300
Onur =C3=96zkan <work@onurozkan.dev> wrote:

> Adds a new check to detect unhandled placeholders in cover letters.
> This prevents sending patch series with incomplete cover letters
> containing auto generated subject or blurb lines such as:
>=20
>     *** SUBJECT HERE ***
>     *** BLURB HERE ***
>=20
> These placeholders can be seen on mailing lists (e.g., searching
> for "BLURB HERE" on lore.kernel.org). With this patch, checkpatch
> will emit a warning when such text is found.
>=20
> Example output on an invalid cover letter:
>=20
>     WARNING: Incomplete cover letter: placeholder text detected
>     #4: FILE: ./0000-cover-letter.patch:4:
>     +Subject: [PATCH 0/4] *** SUBJECT HERE ***
>=20
>     WARNING: Incomplete cover letter: placeholder text detected
>     #9: FILE: ./0000-cover-letter.patch:9:
>     +*** BLURB HERE ***
>=20
>     total: 0 errors, 2 warnings, 24 lines checked
>=20
>     NOTE: For some of the reported defects, checkpatch may be able to
> 	  mechanically convert to the typical style using --fix or
> --fix-inplace.
>=20
>     ./0000-cover-letter.patch has style problems, please review.
>=20
>     NOTE: If any of the errors are false positives, please report
> 	  them to the maintainer, see CHECKPATCH in MAINTAINERS.
>=20
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
>  scripts/checkpatch.pl | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index e722dd6fa8ef..9d5ded376112 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3339,6 +3339,15 @@ sub process {
>  				$fixed[$fixlinenr] =3D~ s/^/ /;
>  			}
>  		}
> +# Check for unhandled placeholder text in cover letters
> +		if ($filename =3D~ /cover-letter\.patch$/) {
> +			if ($rawline =3D~ /^\+Subject:.*\*\*\* SUBJECT
> HERE \*\*\*/ ||
> +				$rawline =3D~ /^\+\*\*\* BLURB HERE
> \*\*\*/) {
> +				my $placeholder =3D $1 || $2;
> +				WARN("COVER_LETTER_PLACEHOLDER",
> +					 "Incomplete cover letter:
> placeholder text detected\n" . $herecurr);
> +			}
> +		}
> =20
>  # Check for git id commit length and improperly formed commit
> descriptions # A correctly formed commit description is:

I wasn't aware of the checkpatch documentation in
"Documentation/dev-tools/checkpatch.rst" file. I guess
COVER_LETTER_PLACEHOLDER needs to be documented there?

Regards,
Onur

