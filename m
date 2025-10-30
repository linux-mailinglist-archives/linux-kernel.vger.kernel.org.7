Return-Path: <linux-kernel+bounces-877906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B238BC1F514
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36B5D34D55E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53268342160;
	Thu, 30 Oct 2025 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="foGOXW05"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9C92BEC30;
	Thu, 30 Oct 2025 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816804; cv=none; b=ouNrBx2Jheo317pkXKWxXu3mvqIuB3IitmJm8QdAUrySqHOBnHFnYpON303poOeD3/j5yZ75Lu5ETMIwKnUV58QlJOjcwZoRmo1pmqVnxjSEGUiDy7k7BUMALeXIbIXmARrcezeWPjJLP/n5kajusbaANyCkdhrEXwndgDoUtMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816804; c=relaxed/simple;
	bh=348IViIBYTNKkLiaEvgW/CJn6HWLD4TiU5cxj9hvfkQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nn4VEONhwYlPKu0ZS7G5zSnHPJzR+47q4zWqOqi6i9Mdazgl4QMclYWORwzKYVuQ3W7XlNOd3n0YmmyXXUt8KAPRFTi4xaOLTH4PBuhrayyivt8XhZXWKFcnqHtAuAWbtBP8S7GwiW6zaMXZCnfpQbv2yyXTQaGF8AEIZzJUy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=foGOXW05; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761816797; x=1762421597; i=markus.elfring@web.de;
	bh=KZZIcQzYA9TKZZ4pBuqY8Wcz9dpXDRCHUVCzOi3IjVU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=foGOXW05sRd6bbXf9975A3dHUFkyAuPOg3fxfBmR1AxuHGEhP4U0UrBtpspKsG9g
	 2yIOZN+cdeFsa1Fqjh3dCNo2LmMxEJta1wZFA16gK5cQF3Q2HxNCdfYcjoVAReRcw
	 UnkSmNuyA4kfHiyCNow/0M2FNloYWnKCRmJOMTdfMTRjR74rMHqvH0npdNG9lHQrP
	 PKCnAg/i+uO6BFEwIL1lFY8fH6vUchihKHRNZH8+g0fVYvBxQSvJriSEGeGGkiRD3
	 NZi+ONwtSXu7BTb3OdMb0lxsdb5ImBHC9RfDawZqyhpyJMDLKxDxC5Il2UirVkXLA
	 ELiirKNWXUrHItdYLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4KJX-1vE8323COP-00BKsE; Thu, 30
 Oct 2025 10:33:17 +0100
Message-ID: <62441255-45fc-4edb-a8e5-c208b36ca2c2@web.de>
Date: Thu, 30 Oct 2025 10:33:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments from
 memcpy() calls with SmPL?
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
Content-Language: en-GB, de-DE
In-Reply-To: <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:igsxJEJ/bMRLpMHAxUf665lp4BlW1C2RI6gdD73+sOV29FN/8l+
 E5aJSss/Tc+QHQ493hP7umLxqvL9z776LDw57biPDt4Mz/OuIzWGjER0ZTSbJoqRDlKPm8m
 t7Oog+Fr8QMkIC/IHsI+Y3LSTSvBlLjqhDbDDCc8zcv38FZ9cqEB/WQS76wc0NKmq310ttd
 pBzXj1EVxwE7hG1Rkcszg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6YE9pGvHNbg=;QTv9EixLj9QejHM+2M0cMWdtAJF
 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

>> It can be determined then from the generated diff file that mentioned
>> implementation details can be transformed in 304 source files at the mo=
ment.
>> Thus I became curious if it would be supported to adjust any places the=
re
>> according to (Linux) coding style preferences.
>=20
> If you have a concern, you have to say what it is.

I expressed something for further development considerations.
The source code analysis result can be interpreted in some directions.


>                                                     It doesn't seem it i=
s
> about the running time,

Not directly in this case.


>                         so why do you include that information?

Further software users can compare such a measurement with other observati=
ons.


> I should not have to repeat your experiment to figure out what you are
> asking about.

You can recognise recurring development challenges, can't you?

* Change resistance

* Varying coding style preferences

* Code improvement possibilities

* Development resources

* Pretty-printing issues


Another test result representation for your convenience:
https://elixir.bootlin.com/linux/v6.18-rc3/source/arch/arm64/kvm/arm.c#L25=
54-L2726

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --max-width 100 --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/u=
se_memcpy_assignment.cocci arch/arm64/kvm/arm.c
=E2=80=A6
@@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
                        goto out_err;
                }
=20
-               page_addr =3D page_address(page);
-               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_p=
ercpu_size());
+               page_addr =3D
+               memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start=
), nvhe_percpu_size());
                kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] =3D (unsigned l=
ong)page_addr;
        }
=20

real    0m0,606s
user    0m0,576s
sys     0m0,030s



Another SmPL script example might become helpful.

@replacement2@
expression object, size, source, target;
@@
 target =3D
-         object; memcpy(target, source, size)
+         memcpy(object, source, size)
 ;


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --max-width 100 --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/u=
se_memcpy_assignment2.cocci arch/arm64/kvm/arm.c
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
+                                 nvhe_percpu_size());
                kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] =3D (unsigned l=
ong)page_addr;
        }
=20

real    0m0,626s
user    0m0,588s
sys     0m0,037s


Regards,
Markus

