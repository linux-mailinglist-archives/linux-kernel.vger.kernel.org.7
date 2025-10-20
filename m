Return-Path: <linux-kernel+bounces-860844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEA8BF120C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CDB5034BB01
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81A13112BB;
	Mon, 20 Oct 2025 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="FaHjD9IK"
Received: from mx-relay18-hz2.antispameurope.com (mx-relay18-hz2.antispameurope.com [83.246.65.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A012FDC20
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=83.246.65.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962928; cv=pass; b=QP/1RlN+jWP5WhdN+J4kbQmOdISd2yF+cEpK2hsq+OxAKQvjDvw0Ywt762dTzeU0znt7wHQDRfJ8/xFoWTjygMRJ/Zh0e78LiMKJVNeGTyh/KWFbGNnZlZACS4qJluVdcFsmlNoTdoRTCnj4jpPwVTzHeZml6HAM+lmJg3FGCdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962928; c=relaxed/simple;
	bh=XrS9PhrVy8J4MNVTtRttJ7PJLldirtTrN2dE9PctUhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2o2lJ6PfAYpaABWi3tpsmWqYaNVaHWZLo/f3H89VyNq9bUk4MQP3sqixGZR7/U8alaG6GLEA2ZP8KV86c+VvE1T7tpGiBLAM26JB4URLKdnHwzYlP0aenSvU7i723zC5CCq3Xxt5vv/FOMncWaLVVXaDmaDWJoRIg1/VzJErKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=FaHjD9IK; arc=pass smtp.client-ip=83.246.65.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate18-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=FEA4yVHPGp0l+38xITknJy4FTIA46F5K1JVqc30O/jg=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760962851;
 b=XfNIf6NQZRD8DfUQXzvV8INu1NtJXr6527UndwhPZ7DIBW68uR+dbLJQANKCmz6LjGqHaU42
 EGSlARbtyUk8k46FOI/Dby3posYB/7M4KErRhZbuI6UPHs1YOtcRacjZUHrHG7A2Y1/2tRhtpjP
 iYwhakQ4+Mj7IdaYm0W1pWJDK7acR7CD21CsDUDiems/Ywj6m5A15bCQAbV7+I+9DOcygQ9ZUxh
 BnSvYn16utZoO0SIqc/ugfGCmDgAffplCRsmEHbNdXEfvvWrz2s2NX/hwJCwv3gI7u0uPjQPJx8
 e32TewTEeWMdZCMvgo6OtC2De7FqZpa2zeLl0hxUV2AVA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760962851;
 b=kI43ryCx9W4sWzsow+mv5jBu2KGGdOqi3dNWsw/y3pZlV6Wb+BU5HywnRq7UNFUCR2SDcMIR
 gLzAEFGI3pTQOSsEY2quYmlahL5w74fOEG/k5TxQ36rNvrpRHnDLEYdP5M+PFNlGzLNa2wG6ffP
 3sWOyXIkIpJCB3XeM9fzqRTI+DkiwSgD/bQfl6GQ43Hg9LXpel18Dnn5h4YHXJ+bqvVahSMXzGL
 I4YY0Dh6dxINtUHNXAXqHzkH4v5aaOJDCAqAYjCBAfmyN+nlrQiQTNY0Q4RQ2/YBEKiL8yN3Mmy
 jCZvFegTSOThSqDwWcE5I1/DNIDOEbSY/OE3jkaYyV3BQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay18-hz2.antispameurope.com;
 Mon, 20 Oct 2025 14:20:51 +0200
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 1FFB1A4118D;
	Mon, 20 Oct 2025 14:20:36 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Joe Lawrence <joe.lawrence@redhat.com>,
 live-patching@vger.kernel.org, Song Liu <song@kernel.org>,
 laokz <laokz@foxmail.com>, Jiri Kosina <jikos@kernel.org>,
 Marcos Paulo de Souza <mpdesouza@suse.com>, Weinan Liu <wnliu@google.com>,
 Fazla Mehrab <a.mehrab@bytedance.com>,
 Chen Zhongjin <chenzhongjin@huawei.com>,
 Puranjay Mohan <puranjay@kernel.org>, Dylan Hatch <dylanbhatch@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>
Subject:
 Re: [PATCH v4 08/63] kbuild: Remove 'kmod_' prefix from __KBUILD_MODNAME
Date: Mon, 20 Oct 2025 14:20:35 +0200
Message-ID: <5936475.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To:
 <f382dddad4b7c8079ce3dd91e5eaea921b03af72.1758067942.git.jpoimboe@kernel.org>
References:
 <cover.1758067942.git.jpoimboe@kernel.org>
 <f382dddad4b7c8079ce3dd91e5eaea921b03af72.1758067942.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay18-hz2.antispameurope.com with 4cqvdx0wRjz2lHKX
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:e0529b78e306560c4cb6295130408c3b
X-cloud-security:scantime:2.046
DKIM-Signature: a=rsa-sha256;
 bh=FEA4yVHPGp0l+38xITknJy4FTIA46F5K1JVqc30O/jg=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760962850; v=1;
 b=FaHjD9IKWWFa/3kBLISQqlIj/j+xU8f3rhZHKPqzciX0QG+qZCaAapE+yrvnQWLOyB1o9Fvz
 kq96cJtEfykOM/XAp3knSs9/o4SEXRbw2bT/4j6R0i8z4B67x3X9SU+IlCt8/e8XeAYdmHFOh19
 9gwO87LRqC78Hem1UOdFIiWCe92G1JDwklZOVcDZWg3MovJWhMBZ1T7wq1Zu2xn5olRz0CuMh/V
 mgTmlDtTy51hA6VekUzFw5HPSEJghCOKniF2xKKP6JVRs8KugUsP11ZSFivyHfec2PPiUNjpgkT
 nM2yGsWEPCL/ygV1VTGNsGSZxsYtrnagDQ3l0fejORnlg==

Hi,

Am Mittwoch, 17. September 2025, 18:03:16 CEST schrieb Josh Poimboeuf:
> In preparation for the objtool klp diff subcommand, remove the arbitrary
> 'kmod_' prefix from __KBUILD_MODNAME and instead add it explicitly in
> the __initcall_id() macro.
>=20
> This change supports the standardization of "unique" symbol naming by
> ensuring the non-unique portion of the name comes before the unique
> part.  That will enable objtool to properly correlate symbols across
> builds.
>=20
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Starting with this commit 6717e8f91db71 ("kbuild: Remove 'kmod_' prefix
from __KBUILD_MODNAME") in next-20251020 I don't get any
module aliases anymore.
modinfo spi-fsl-dspi.ko returns:
> filename:       /work/repo/linux/build_arm64/drivers/spi/spi-fsl-dspi.ko
> alias:          platform:fsl-dspi
> license:        GPL
> description:    Freescale DSPI Controller Driver
> depends:       =20
> intree:         Y
> name:           spi_fsl_dspi
> vermagic:       6.18.0-rc1+ SMP preempt mod_unload modversions aarch64

but it should be like this:
> filename:       /work/repo/linux/build_arm64/drivers/spi/spi-fsl-dspi.ko
> alias:          platform:fsl-dspi
> license:        GPL
> description:    Freescale DSPI Controller Driver
> alias:          of:N*T*Cnxp,s32g2-dspiC*
> alias:          of:N*T*Cnxp,s32g2-dspi
> alias:          of:N*T*Cfsl,lx2160a-dspiC*
> alias:          of:N*T*Cfsl,lx2160a-dspi
> alias:          of:N*T*Cfsl,ls2085a-dspiC*
> alias:          of:N*T*Cfsl,ls2085a-dspi
> alias:          of:N*T*Cfsl,ls2080a-dspiC*
> alias:          of:N*T*Cfsl,ls2080a-dspi
> alias:          of:N*T*Cfsl,ls1046a-dspiC*
> alias:          of:N*T*Cfsl,ls1046a-dspi
> alias:          of:N*T*Cfsl,ls1043a-dspiC*
> alias:          of:N*T*Cfsl,ls1043a-dspi
> alias:          of:N*T*Cfsl,ls1028a-dspiC*
> alias:          of:N*T*Cfsl,ls1028a-dspi
> alias:          of:N*T*Cfsl,ls1012a-dspiC*
> alias:          of:N*T*Cfsl,ls1012a-dspi
> alias:          of:N*T*Cfsl,ls1021a-v1.0-dspiC*
> alias:          of:N*T*Cfsl,ls1021a-v1.0-dspi
> alias:          of:N*T*Cfsl,vf610-dspiC*
> alias:          of:N*T*Cfsl,vf610-dspi
> depends:
> intree:         Y
> name:           spi_fsl_dspi
> vermagic:       6.18.0-rc1+ SMP preempt mod_unload modversions aarch64

Reverting does not work on all building platforms, it works on one but fails
on another one.

Best regards
Alexander
> ---
>  include/linux/init.h | 3 ++-
>  scripts/Makefile.lib | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 17c1bc712e234..40331923b9f4a 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -200,12 +200,13 @@ extern struct module __this_module;
> =20
>  /* Format: <modname>__<counter>_<line>_<fn> */
>  #define __initcall_id(fn)					\
> +	__PASTE(kmod_,						\
>  	__PASTE(__KBUILD_MODNAME,				\
>  	__PASTE(__,						\
>  	__PASTE(__COUNTER__,					\
>  	__PASTE(_,						\
>  	__PASTE(__LINE__,					\
> -	__PASTE(_, fn))))))
> +	__PASTE(_, fn)))))))
> =20
>  /* Format: __<prefix>__<iid><id> */
>  #define __initcall_name(prefix, __iid, id)			\
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 1d581ba5df66f..b955602661240 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -20,7 +20,7 @@ name-fix-token =3D $(subst $(comma),_,$(subst -,_,$1))
>  name-fix =3D $(call stringify,$(call name-fix-token,$1))
>  basename_flags =3D -DKBUILD_BASENAME=3D$(call name-fix,$(basetarget))
>  modname_flags  =3D -DKBUILD_MODNAME=3D$(call name-fix,$(modname)) \
> -		 -D__KBUILD_MODNAME=3Dkmod_$(call name-fix-token,$(modname))
> +		 -D__KBUILD_MODNAME=3D$(call name-fix-token,$(modname))
>  modfile_flags  =3D -DKBUILD_MODFILE=3D$(call stringify,$(modfile))
> =20
>  _c_flags       =3D $(filter-out $(CFLAGS_REMOVE_$(target-stem).o), \
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



