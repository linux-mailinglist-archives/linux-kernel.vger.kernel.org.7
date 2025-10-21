Return-Path: <linux-kernel+bounces-862255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C69BF4C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B553B46F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAB026A08A;
	Tue, 21 Oct 2025 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Ohw20PP9"
Received: from mx-relay19-hz1.antispameurope.com (mx-relay19-hz1.antispameurope.com [94.100.132.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828DC2147FB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030067; cv=pass; b=owXQO3wuMwIDO1KcA7loXQK8BXMwA8cdmGVGfu3j2OyZrBUXZQRR7OjjUIyVit02vFS4Vw4igHMjmNA4GJ7TrsJtWU65BY5EXBmWGfUaGLC2ovlfaDfk7yPfQ3SbKu3eDLk5CYZB8GteUzaB/QLN3jpWLcjr0ZEWXxRjpcv5CMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030067; c=relaxed/simple;
	bh=Q8sTHyOz97Zfu+JuJfIb4G6hqQA+e+s0O6Mbm0Jd0UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fO3xhZ1fR2RknfufBROR0RiYvy7ht2OYXVXd/geL3IZqugkoDXtdP+IbmrNm+B3lptrKHZqs+P7XsCQNglOxqd3LdoSKxVTT8u+tUSa20F+q/yU7RbUE6knqR0kO+aSnvijlViQAGc/VmFh1u3IjT0NpkV3XeqRJsL+Wrx7+MVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Ohw20PP9; arc=pass smtp.client-ip=94.100.132.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate19-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=RXCPO1Vsv8GCMq7O/Lb/mclvihGadUe/ChieUPYMtvE=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761029980;
 b=YPErXlFnQebUNkobij39qxLyVJtcOTNebnCck0q49IpqExs2PrVe2vYpXwiLP5VkDamsyWwG
 tkatnzQa3/N/yWXVolnpiH5UeuVAdxUFz+VLdkPxOoTrtlcXYBr5e24WAIYjVn+nn73+FdquDjy
 21IHBjSeX6hmgDY39ioQ8pq0jWhQfUBYwUTfFRaNv8wg9VpL/CtdIX7DBNsub3HHHCG9HIqKuhI
 TZR4WSuqz0uqLO9l9Rh3cXkRJqe1i7GEqy5cpklCmi2oTmglP3VJvTQbnDJnpa4oZ9LHH56MK2Z
 TIKp0uj6jodE5GcLSZclOgWRIZTXHF5I1tvpwhw/DNgCg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761029980;
 b=MFwJVTGMmNnm2/Wtxm0I3Us0MPm2b2n3B00svxfT/zjHWrJlvOhbNVsZshcMDcp0YRW8Yj4F
 O/7Nxl97ZnQyjKBMxtnfEviQnVQJdsTfJkVTIdmv/mJzqhD68up88VcOL24VjnPlOe0CluHGM3k
 Hr/gwVIM0N2ZGhPwrBoAnOI/z3CVKqxGQBPXIUqLw+LtiXm0lllRUAa4rjrQx6sTruAc+VzsZLZ
 Zl55spuK9Zzb99TdBHShJuMSLdlo1zUcAO+WdLoT62sssP67zUe3fl4IXdZH67JNMB7tPjH9345
 wPYx+fsuyHecELBW8nh67BgMumP6McQolDtKV35UyRu7A==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay19-hz1.antispameurope.com;
 Tue, 21 Oct 2025 08:59:40 +0200
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id DEEA8CC0CC7;
	Tue, 21 Oct 2025 08:59:21 +0200 (CEST)
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
 Peter Zijlstra <peterz@infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Mark Brown <broonie@kernel.org>,
 Cosmin Tanislav <demonsingur@gmail.com>
Subject: Re: [PATCH] module: Fix device table module aliases
Date: Tue, 21 Oct 2025 08:59:21 +0200
Message-ID: <5024487.GXAFRqVoOG@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To:
 <e52ee3edf32874da645a9e037a7d77c69893a22a.1760982784.git.jpoimboe@kernel.org>
References:
 <e52ee3edf32874da645a9e037a7d77c69893a22a.1760982784.git.jpoimboe@kernel.org>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay19-hz1.antispameurope.com with 4crNSp5ySrz3D7KX
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:7e70561755faed15dce06a351d980bd0
X-cloud-security:scantime:2.178
DKIM-Signature: a=rsa-sha256;
 bh=RXCPO1Vsv8GCMq7O/Lb/mclvihGadUe/ChieUPYMtvE=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761029980; v=1;
 b=Ohw20PP93uMC0tUa1Dph5UN0e9SGJ62lFEUIY6FLgfhw9J580w+Xuqe9xOMWU070aO4OGjbQ
 o9jrON631gYL/ABjGbUlfSQ44WBkNKFQKs9ASkBFkMHsB8O0SvPgp4+rqAC4MhRcVInKYon6usn
 K8oz0kpqf5rIK5rafEsK/EFbM8/80d5evY4B8sW0IqoQmB+Ji59/0eM8ugXbKfH+aMUpN7IX4Xe
 sFkjR2KeXREs9O4gxzbeW7qw4vH4ukYa6R5ho55zjC5padNaDJJN0fq7hJoey2OdQG+teb9m8xH
 GCxWc/wQIkemSb7Vv63VNeA09lg5VTyxnyY4s+qaCr5Vg==

Am Montag, 20. Oktober 2025, 19:53:40 CEST schrieb Josh Poimboeuf:
> Commit 6717e8f91db7 ("kbuild: Remove 'kmod_' prefix from
> __KBUILD_MODNAME") inadvertently broke module alias generation for
> modules which rely on MODULE_DEVICE_TABLE().
>=20
> It removed the "kmod_" prefix from __KBUILD_MODNAME, which caused
> MODULE_DEVICE_TABLE() to generate a symbol name which no longer matched
> the format expected by handle_moddevtable() in scripts/mod/file2alias.c.
>=20
> As a result, modpost failed to find the device tables, leading to
> missing module aliases.
>=20
> Fix this by explicitly adding the "kmod_" string within the
> MODULE_DEVICE_TABLE() macro itself, restoring the symbol name to the
> format expected by file2alias.c.
>=20
> Fixes: 6717e8f91db7 ("kbuild: Remove 'kmod_' prefix from __KBUILD_MODNAME=
")
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Mark Brown <broonie@kernel.org>
> Reported-by: Cosmin Tanislav <demonsingur@gmail.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Thanks!

> ---
>  include/linux/module.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/module.h b/include/linux/module.h
> index e135cc79aceea..d80c3ea574726 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -251,10 +251,11 @@ struct module_kobject *lookup_or_create_module_kobj=
ect(const char *name);
>   */
>  #define __mod_device_table(type, name)	\
>  	__PASTE(__mod_device_table__,	\
> +	__PASTE(kmod_,			\
>  	__PASTE(__KBUILD_MODNAME,	\
>  	__PASTE(__,			\
>  	__PASTE(type,			\
> -	__PASTE(__, name)))))
> +	__PASTE(__, name))))))
> =20
>  /* Creates an alias so file2alias.c can find device table. */
>  #define MODULE_DEVICE_TABLE(type, name)					\
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



