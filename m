Return-Path: <linux-kernel+bounces-868995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D57BDC06AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 786824F682A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D811FBC92;
	Fri, 24 Oct 2025 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="DCjiPUx5"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745481DE892;
	Fri, 24 Oct 2025 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315694; cv=none; b=qc1nHTA3Oud9QiTHXzkvPRBBC8FUYjiCH++bktT9OeTLWQb22Q14WZe0Scj/alm267Fe7q6gn0DLpxudo5CKRMg9T2vct7EK/f07brrnluS3EybqUJ9UcQa0jUFsuN7L9s+3dECXXDKCpCSt5TnXqQN0kaMPKTF/1HaJnKs6PRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315694; c=relaxed/simple;
	bh=GTrP85gjNLGPzO42dWPJ55XCS4SRGJy0uSR7+gh8n6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaEQeaiXDpcoFFW93hZeeEQqNuHfY9BclxD4nLZNr8hb3FkXFEFoMsWvhiuyPNjcQt/eHMSANeyaN3jR81GLzH4R1WHDsZggO6jrhQ2kxAxfaXuH2shtU2ARVjoP0YaBKTUrpc2yPer6V5ia+NqHs6zw1CUSaR03V1sHSSPvG6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=DCjiPUx5; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761315598;
	bh=ylc6GQ1hJ0TbYatd4EtuuHeOUs0jEjk+TPTEgYS83so=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=DCjiPUx5wGt/K8UzRKTjKNF/PWL+nVF1aojEuBoFritg726dk5GpZuYyM76qo0niw
	 VVui7FIGOhdHAuItmLgRPx6/ldGLuw3gZY4r8StFwzbIIpDjt/WqC10ZI2wWBNd8I6
	 64Tnu6BwYF8S/UuqTqRMCOXqQJZEgsqD7JhTsj+c=
X-QQ-mid: zesmtpip3t1761315596td6aca7a1
X-QQ-Originating-IP: zR/JaMMb0y/zEHR3rB1xAYJP1BB3pKKuVq6gci5Q7OE=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Oct 2025 22:19:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8195043091810859412
EX-QQ-RecipientCnt: 11
Date: Fri, 24 Oct 2025 22:19:53 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Yixun Lan <dlan@gentoo.org>, linux-sound@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: spacemit: add failure check for
 spacemit_i2s_init_dai()
Message-ID: <5446E6EB4FCF412B+aPuLCQcV8hMlBLjk@troy-wujie14pro-arch>
References: <20251024-fix-k1-i2s-dai-mem-v1-1-15f5f1ec294a@linux.spacemit.com>
 <aPuJnJIeupM1PV09@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPuJnJIeupM1PV09@stanley.mountain>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NgaheRY97EnbcGSBrTOOlFa+KwSlGtxw10Jq71kMZuYIdRS6LNEqMaaf
	EeljPIi+JR24Nqd5PDYIXRkGtm2j6ZFVM30Ul/ab9p6HHreA2OYXNMdpGtXxYBml6kU1Nc3
	lwIw8LjisRod3PNYXD6O5ffC/cyqZ8uWbeJmVkLIwQyT+hGVZ37ZK4qubHuud3jbw3oa9c3
	q58ooSBMdy9G/oPkBqJfBUuPQ1ObSf+/0vEg+GgYGiUNHH2d5AIKAlZbrpeMmXZz1t+imal
	5vG5W1dUf1vO4g3pTJMFgaDrhTT2jILCOqF879g1p0/7yQlOAmfVwYMlMXN2++u9HCBx913
	rS0swhCtdh7n+Ed1VPFjknIHYNWcGC63LiOgUu0R0sZ860h+chx2dLxomUGPmHv+katCdsY
	yVgZbx8rtAubGNfox40E63+qUKDs1o3/UR7/31/Affl0JlAwnKe4NvM2J7gkAfhmrLjAA57
	ByaQH9Ozcusks38hAMYCcy3xq6Prd0UzrpFvFh5Y8CjMZvX8XW616YyalJ/l9I0c85Nw8uJ
	hvwOtF9KOli5kEVq8sd6YSLWiW453SmGanKkocBwRRl2faPE6mmsJD+8g2nPl00ExTleMYg
	B7ShjIQ50Lw06e08Swr4Ci7fK5SezCZEuqeZrwtEacp0Z91lh774me9nZ5M6bTSejdxG3pl
	Hgnys2xp+TKhM/rORb9sCxs5Yx0CPs1HnZvRQ/ipVPvObrk9nZrtYsYixA/HJQAA2RwlALD
	tE5infnf0IIM/bFkdPF1vjaES8SzHMSGSzpCZvGV+aTwy35BrBJgbki1vuYUjzkEKpGG65P
	0gc2f+qXxUb/PhRLE5+HitQhDXMiXIholbYxpd0RGyF5vO3249XGqPkNRbhaMGGJBxqpblk
	bt18arbbYMzOt/K1tXJEIoyfic96HSAM4lrurRkmB5V80RVCa3RBdBA9naM4P6DnvuRlvD+
	qIxmeXVP1Yqv92CBRXZCJVVjWVmBPEsHabFMmOiOcogi0TiIGVKzpq1zr8SRkicgoronKFz
	q/gaawER/Bxjk4mWDTclqM6M/tV4/v0LB70aSa/AByjNhSNmpqdwLdIzwI7S9oPFCoDSGlC
	BHM5GOdJ5KBT+7d1qGV/avJmB+9tslQ4g==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Fri, Oct 24, 2025 at 05:13:48PM +0300, Dan Carpenter wrote:
> On Fri, Oct 24, 2025 at 09:11:01PM +0800, Troy Mitchell wrote:
> > Add error handling when memory allocation for dai fails in
> > spacemit_i2s_init_dai() call.
> > 
> > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > Dan reported here [1].
> > 
> > Link: https://lore.kernel.org/all/aPtiNCZ_KBezL2Dr@stanley.mountain/#t [1]
> 
> Thanks, Troy
> 
> Normally we would say this needs a Fixes tag and the Link: should be a
> Closes: tag.  It would be easy to make the argument that the
> allocation won't fail in real life so a Fixes tag isn't appropriate.  But
> actually it's simpler to add the tag...
I see. Thanks!

Should I send v2 with Fixes tag now,
or would it be better to wait a bit?

                - Troy

