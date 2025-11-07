Return-Path: <linux-kernel+bounces-890586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A543EC4069B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9822B189C65C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7087232AAD9;
	Fri,  7 Nov 2025 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ifXSMORQ"
Received: from mx-relay36-hz1.antispameurope.com (mx-relay36-hz1.antispameurope.com [94.100.133.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BF52D5932
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.133.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526648; cv=pass; b=awSl4hLtn0MHUmKjUz3qEZPuMWfGNmo809MU9Iaz03G2+1IBtIMzy26GXB3lakLZF90Bk7JAHfPBktO6YZNxXEzZhn1FJ/Z1sUoQusbKz8PKEq81tU1dm/VqLlhgLinM0JstbTnw9Uw4+9WUcXdXuJSC58ZH6Vm2uI/qZUCwTrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526648; c=relaxed/simple;
	bh=EP4WSYGKJactOtWsPoOMhl3qwGmxc6EFsx1JNDl4Jqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GyLZkjjkbhR4vur/0A7IqeYCueJx8Ypo5ejkl0CE47YowafhzL6swflggngZyIHBbvVE4lfWu8wnQ9MsSZ1/VapAIgShVf3vzaSj0qFgVzVnCE7icM9Ll3lx+quCDrn3y2IOZK42il6N0Qn9t6S1g6xeuFbXTwbPIIg3rMdV0dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ifXSMORQ; arc=pass smtp.client-ip=94.100.133.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate36-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=2O/6xfFM31BvnbWJwW7ji3pCjMHZkaKAX9fc6k0Ej+s=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1762526582;
 b=BLDLlOSe3pLI96bWsIk8ynWTLQBpTCdoWAkhuLwUAmstCZTCzLd52AdTAy1qCRJyAeD84Wf5
 hAxwxDkU0N5YppOD20s1bXFViU5X/36HegXxSl6SFb8P/Sw1KvX/NrSDtOATcn5QXGoRm4XOy1l
 DHmotZ+/Y6EIxbpPbMkdzC3TCcn5Mm4M7it0/m76Dn3sgf85CMB+m+ZSY55onAaPi1vmLjpzda6
 rWDQBBQlneRSrAs1SDbLomVdCdYR+cuBADRGSn1eJXZOWzeNL55xlSZMXzf8X+pWbhvyxkrdLZ0
 +uEt1DeangL9kCtFvuLtLhWShyUBOjOyOE5ubxm1rMKJw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1762526582;
 b=c1rDHD/9jmz8s0JyVhOGrRrHD/rXPq29zuYxK1hoTqqKm+9Y3S52wIbP+yN4A1wfgEtG8FWm
 XePdsQ2MMhnk7sMrIfNKcgNYxVpmBDuX5yDLPiyt2H3mDEG+iXtZLApH6NMHbF6iB3kIzQEUNwz
 6GH4GKpztazUgMPnzIh86yxWxdG05RGFOsIcyM6Ev5Ir6NJEXoI7vNBbq5kwfscav7tWg6sRhpT
 MLln/C5wtRi3KDhzMKLuWKWWblVGtfEFEe23shLDEi2G6Ya/a29PpQoeaAx/i7zPHgTN939HH0P
 ksa4hmOc9+LoYFF4cZEnJ+fIo5lkxUsKr9Rmt+0XZk4XA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay36-hz1.antispameurope.com;
 Fri, 07 Nov 2025 15:43:02 +0100
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id D4150220D2C;
	Fri,  7 Nov 2025 15:42:54 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 1/1] tools: use basename to identify file in gen-mach-types
Date: Fri, 07 Nov 2025 15:42:54 +0100
Message-ID: <13360982.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250826142518.2583999-1-alexander.stein@ew.tq-group.com>
References: <20250826142518.2583999-1-alexander.stein@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay36-hz1.antispameurope.com with 4d31xq13lSz2HYtB
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:2e0f76516db0893b2f62585e13d283ed
X-cloud-security:scantime:2.133
DKIM-Signature: a=rsa-sha256;
 bh=2O/6xfFM31BvnbWJwW7ji3pCjMHZkaKAX9fc6k0Ej+s=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1762526581; v=1;
 b=ifXSMORQITen9O8wxwxFWz2IuhtfBMzEePCab7JYHAqeVC4t1kOO7qP8chr//ZTMlIxX29MH
 VnQhdzXMVsDX8B3LCQAUHo2X5vSO+Ta5DO4iZhbRBifldfDQoh18joJOCs3hYksnLbT03jmsTnF
 wo8cXARVqKb0Puc1J7lONyBkcC3t3NtytVWFhElcLb/4BbVW0Qnpi3s4wXaBJRJ6dM3zaolOKJZ
 b9dCEYcN1IcVhbmt3eXMQxKQKDU/W6EFWdzRZy0nGvtsHD2FXOMpjWCHJm1vvwMJIIKQ3Mmf0U4
 cxHWqxCh+5Hmj5k/NKhHYNvTm2tMQoOHY0W8zY71j/GWw==

Hello,

Am Dienstag, 26. August 2025, 16:25:17 CET schrieb Alexander Stein:
> From: Bruce Ashfield <bruce.ashfield@gmail.com>
>=20
> FILENAME is replaced by the full path to the executing script. If
> the script is executed via a fully specified path, that is captured
> in the output. Although it doesn't impact the output, it does trigger
> reproducibility warnings/errors.
>=20
> So we introduce a basename() function in the script and use it to
> make sure the output file contains only the name of the awk script.
> The motivation for this change is Yocto emitting a build warning
>   WARNING: linux-tq-6.12.41+git-r0 do_package_qa: QA Issue: File /usr/src=
/debug/linux-tq/6.12.41+git/arch/arm/include/generated/asm/mach-types.h in =
package linux-tq-src contains reference to TMPDIR [buildpaths]
>=20
> Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Any feedback on this?

Thanks and best regards,
Alexander

> ---
>  arch/arm/tools/gen-mach-types | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/tools/gen-mach-types b/arch/arm/tools/gen-mach-types
> index cbe1c33bb8710..ab69d408f9e12 100644
> --- a/arch/arm/tools/gen-mach-types
> +++ b/arch/arm/tools/gen-mach-types
> @@ -21,10 +21,14 @@ NF =3D=3D 3 {
>  	  num[nr] =3D ""; nr++
>  	}
> =20
> +	function basename(file) {
> +	   sub(".*/", "", file)
> +	   return file
> +	}
> =20
>  END	{
>  	  printf("/*\n");
> -	  printf(" * This was automagically generated from %s!\n", FILENAME);
> +	  printf(" * This was automagically generated from %s!\n", basename(FIL=
ENAME));
>  	  printf(" * Do NOT edit\n");
>  	  printf(" */\n\n");
>  	  printf("#ifndef __ASM_ARM_MACH_TYPE_H\n");
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



