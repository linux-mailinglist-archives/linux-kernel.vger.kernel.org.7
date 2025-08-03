Return-Path: <linux-kernel+bounces-754401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEACAB193DD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 13:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB193B60AA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 11:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0820253F20;
	Sun,  3 Aug 2025 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mfLsUteU"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971AB156C79
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754220819; cv=none; b=lcZ0eLFA3WpOr1QuX42lVIzg/qogFlci4HAbVKvyurVwYn1Fk1AaWdkXPxx3uoOjaKI4g/IspG1FnruZJtMj4Snxw62/rJFfhmOBbPAP1qAjMGeC8PWmXcfBjSsK4tBLVHzf62aeyoX3eSkOA4DlMdv+Chg+Wrlc/09YNYvs/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754220819; c=relaxed/simple;
	bh=R69ike7n/7/MxJzmcgaY3ANSVRrE0YadM7PHSwlocZI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=owOdTF6Bp5uCc+VhLdqb5nQKNzp/UqCTI3qMP8BWnc1MHKD+QsXVlYJ3ZN5YgMugEUX1efcoMgXBRPPvMYHPIMj+PcLNO++83QDKopzw025YTQGrU6mehtQzzNoo8tAmANKowlUS5HgV5y6BNAoKgS5CjwEH+hoEnSFPXmV+z1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mfLsUteU; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754220800; x=1754825600; i=markus.elfring@web.de;
	bh=Gh7UCBKW2ZKQxPll5m7Nb+1o4NiEmFKs7C57wXfPSRU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mfLsUteU3aJJzlkdPiG8xyUUyghYZEB5NEzoIroR6s6OjCa43rHuvkRPMf/lYnvb
	 66PJsEyr+hh8MbWdKyn8prwGWO8PhYoS3lD9xTG/8J4SAmEbm/dC50dn0c8ZK9UMO
	 lVrSoKkmqsJEI1ZZB1njjTkqXMheESIUIDqHgMDgg1CbX7bCq2DCKJB+GLqvwS+a3
	 k5kE4dp1qjTOlh520rG5DdwOLxWaBpVhehyisChXYYeiNGde9Sf+yZOY4i6uFtJ9Q
	 yXh4sO0iG5vO/jzWBXk+ysJIdWoqljLJfyT5xwl0eYkl6ka5ICYrXt8jFML4epx7P
	 hgozFkXg7hCk0jfI1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuVKI-1uQSBO1Hpi-014Tvv; Sun, 03
 Aug 2025 13:33:20 +0200
Message-ID: <4688e9e4-fc41-4d0d-9948-e729c812c346@web.de>
Date: Sun, 3 Aug 2025 13:33:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Qi Han <hanqi@vivo.com>
References: <20250802023733.1890349-1-chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix to return -EOPNOTSUPP for uncached write
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250802023733.1890349-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7VD/TlZYC1Ka7SadUjhBeJ2MVGkbzvfIbkpUsQ4rzyumGV6vS3l
 6x2QSTEmBmsf4utM+W9WPQul/e5uT26EegoHtGGxXlWWOHrCJRY5WZVH1VRPAqm8rLpJ774
 xW3HcDuiD8ysS84TwRMkFwgWQWe/OjFBNKaNV8efxQlIFJAa5wKm6xNw1LfPK4lVypl/PGf
 GGQVu0MdnEzPdbPVWca/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wrGSbDtvmtM=;KMGN6RZyBSE/W5y9lzBzNUqKqjb
 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
 x2DVzdOEkz/XR03MES+v4j0=

=E2=80=A6
> +++ b/fs/f2fs/file.c
> @@ -5185,6 +5185,11 @@ static ssize_t f2fs_file_write_iter(struct kiocb =
*iocb, struct iov_iter *from)
>  		goto out;
>  	}
> =20
> +	if (iocb->ki_flags & IOCB_DONTCACHE) {
> +		ret =3D -EOPNOTSUPP;
> +		goto out;
> +	}
> +
>  	if (!f2fs_is_compress_backend_ready(inode)) {
>  		ret =3D -EOPNOTSUPP;
>  		goto out;

Can it be avoided to specify duplicate exception handling?
May the condition checks be merged for these if statements?

Regards,
Markus

