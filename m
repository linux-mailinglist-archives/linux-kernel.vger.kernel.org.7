Return-Path: <linux-kernel+bounces-756174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7B4B1B0D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6E416ECF5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5161E24677C;
	Tue,  5 Aug 2025 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eCXB5PyC"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAE62E3718
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385431; cv=none; b=daPviaVhKYc4rWGk1BcXQ9dWA9pmu8bH6z336J0s5yYLH0KlKO9KsqFcIgZc+pqLv5YHpgWqQ/v6OhosNFLTtM8TFZemn+8/XgdAWwHuF1wQNzgPEEVTaL/Tk6yT+Fxy+Sj3aKzRhO6OjSKvGW94/FrP+yQahxxL9bJCZCdC+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385431; c=relaxed/simple;
	bh=J8j8YhKnrnd3xDjVUlmRb5wEIFrdEM3rIny8bKxLcZw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Nt4PSGqEPS+FqoEqgTMzGOAksVxCC3K0RDWZ0EZ+bWI7cX41N4UdwKu2N5lYmfl+SHOH20xlo9f0CQLPBIiMOqb/7mx/qKBdCDiK5xcUvWS8FvwOOnGuztyKgDgdE0Nxpud5kgcq49JFzJgKB0ZwIyHm1Ve3zSMo+kaRZ2XQ8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eCXB5PyC; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754385399; x=1754990199; i=markus.elfring@web.de;
	bh=pmk+bK4uF0SSkoIBiFcKkqv8UXyIF1fM2mtrECC2uuY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eCXB5PyCuoJKB0X9nl3qo7jJPhKOQl3UOi5eEtN9Ne0tPDzkwdM4pz7XCRU7ksq3
	 kV5nE0l+PwDW2wPLKm8V+oeX17Lro5vpAcoOWvX6VwSwJnzpOO7MeoM0a/0jc1ZT2
	 8Wu8gT49NaQ9NzeIMOk1Fv/S3eE3zWnKBau6fZr+rphaykc81Wm9wZiwgKO46mzI2
	 czbiqIpf1tj192iDYi2mlv5dMqpQ1xzWiNC3qLmBXfTSfxhw6igH5vws1L+LnFSx7
	 TrogaWDGEORbPvbEpJ5VJtgcUHsYIU0of1T/UxrZmjuxPxIGtQNYbrSQKCN8AWf/3
	 tkacwdgFtCbmhqh36Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.245]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrLN-1uwdlM1qdP-00VxIU; Tue, 05
 Aug 2025 11:16:39 +0200
Message-ID: <d60910fc-a327-4ebc-ac24-42a668ac1402@web.de>
Date: Tue, 5 Aug 2025 11:16:38 +0200
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
References: <20250805061733.3067254-1-chao@kernel.org>
Subject: Re: [PATCH v?] f2fs: fix to return -EOPNOTSUPP for uncached write
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250805061733.3067254-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RtE7uzgtu+SdJzqnp9v738IXqW8VLSElJep+tlJJ/RTytXNyOZv
 6SGzMKRoaHShXWWucqIrAm6AjNfC+C5UfD0vZW2fFvwnIHgIS7XWTNiLH1iAlaJad1VQRwP
 WO/YztFmhqM3FpaT2dMvQk4xWQRAaPSt+qZaTlktgJyeOFqmj6LwdUSaEhPqzwwCp1dka1F
 /zEHCd26T9EdW2C54/kVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CjQDUJSR10Q=;lreZ8UaYy+BWs4YInYvWWU5j9XC
 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

> f2fs doesn't support uncached write yet, for write() w/ IOCB_DONTCACHE
> flag, let's return -EOPNOTSUPP instead of ignoring IOCB_DONTCACHE flag
> and write w/o uncached IO.

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n94


=E2=80=A6
> ---
> v2:
=E2=80=A6

Should a corresponding information appear in the patch subject?


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

