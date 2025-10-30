Return-Path: <linux-kernel+bounces-878196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F9DC20011
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66CB64EA998
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE9B320CCA;
	Thu, 30 Oct 2025 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QmLj2K1r"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340431E11D;
	Thu, 30 Oct 2025 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827185; cv=none; b=RiVPmHu5X4rTlz5GiHuPWMPR8GIoRUlXV0pwK8+DHZV8CvzH0FZR1L2fPN8c1zJ/zNiCDCMcSi5ydEKhufD48dTp28+LC4Yg2rV6XqS+2obcQt5QR1DsIVpvnfF6seOIrGDJPiWINTqrVAvkP0xx4F6aZHVVKcIqc3LcKmG0SS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827185; c=relaxed/simple;
	bh=jP0A3P/RsWKTWV1WIWX8B6eAavrOI2ou0sMjmqcEYP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVXRJgbUCgx+HoIwuqvmlb5k3wdIysuvnYZe6l8Mfjhd1VCWPMzVlEsx8wyhQ81IAnkKACv/EWro+ra6es63YlGy7pdIXUn37DXrCxhhlzsaJc2qijG3cjKs/mnqdR7hHFy5Vfqxcu6UofslqKBd9NcBdRmdfyYecyTSOWsPlDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QmLj2K1r; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761827180; x=1762431980; i=markus.elfring@web.de;
	bh=wKRq6Ju1skhSe8iFmdeF8ZRGsydXVNDSbV0PmfELvbQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QmLj2K1rc02+Van8hHM7jt2OsJzq+A+mom/MwJ8gPxVJ/mLeGVZO92P6p/4XULuL
	 OEz4HrdBmX6Jb/vurG0UQgRz8FuiqFjjn5uyl9XjklW1Y6SZKffqLZUQYt8hmRCHE
	 wEQBfuuBPBU7DlrXM+7IaCzD6+lDSrSXBsq0xxWrpRR8Th85VO3hUf/JWEHXmfS3P
	 D1lxXPeOPl03zK8ku/FKTic5Z+k+wBaAICSNRkCLmfmYUAyrRODAdkphQujmSscPS
	 138VQVBc9Mygc93Y++4UJBxJ0yHAPUAM62kbIIUbKk0RWVYiTxDL44Nrcmyq4AX34
	 olFkdR0LvyIiRTn2FQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5j1c-1vKTLN3TiM-00HCVZ; Thu, 30
 Oct 2025 13:26:19 +0100
Message-ID: <60f881dc-979d-486b-95be-6b31e85d4041@web.de>
Date: Thu, 30 Oct 2025 13:26:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments from
 memcpy() calls with SmPL?
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bz1ahwt8PKujpvFw+axgHQjxI/y34qeztIKDsshP/5jj4yqxJIN
 MrV/2Q+fofAth6RwA2yPXkCAAKu7e10pQfbTAbdiwWVguUJclSdgMrD9QKw3uwHr6tbNfW0
 bGwIeMDqDgzcfgKQME2/Nt1fuebSzMi4o1WSQXpfGoAKO0T8tPYpfF29RJvhRX2u5ZkmeZa
 qRIclI5LOttQuQD4z1s1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Yuy3p+mWVqs=;uJZegLi1wAsQ8tyOHJ/w7UXw37I
 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

> If you have a concern, you have to say what it is.  It doesn't seem it i=
s
> about the running time, so why do you include that information?

How will remaining open issues be resolved?


> I should not have to repeat your experiment

It would be nice if further software users would occasionally reproduce
presented data processing possibilities.


>                                             to figure out what you are
> asking about.

I =E2=80=9Caccidentally=E2=80=9D tried also the following SmPL script vari=
ants out.

A)
@replacement3@
expression object, size, source, target;
@@
 target =3D
-object; memcpy(target, source, size)
+object; memcpy(object, source, size)
 ;

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --max-width 100 --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/u=
se_memcpy_assignment3.cocci arch/arm64/kvm/arm.c
=E2=80=A6
@@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
                        goto out_err;
                }
=20
-               page_addr =3D page_address(page);
-               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_p=
ercpu_size());
+               page_addr =3Dmemcpy(page_address(page), CHOOSE_NVHE_SYM(__=
per_cpu_start),
+                                 nvhe_percpu_size());page_address(page);
                kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] =3D (unsigned l=
ong)page_addr;
        }
=20

real    0m0,578s
user    0m0,524s
sys     0m0,047s



B)
@replacement4@
expression object, size, source, target;
@@
-target =3D object; memcpy(target, source, size)
+target =3D object; memcpy(object, source, size)
 ;

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --max-width 100 --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/u=
se_memcpy_assignment4.cocci arch/arm64/kvm/arm.c
=E2=80=A6
@@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
                        goto out_err;
                }
=20
+               memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start=
), nvhe_percpu_size());
                page_addr =3D page_address(page);
-               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_p=
ercpu_size());
                kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] =3D (unsigned l=
ong)page_addr;
        }
=20

real    0m0,565s
user    0m0,533s
sys     0m0,032s



Would you like to reconsider implementation details accordingly?

Regards,
Markus

