Return-Path: <linux-kernel+bounces-878323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53127C20451
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F8C423361
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A99248893;
	Thu, 30 Oct 2025 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GnOGzv59"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E22557A;
	Thu, 30 Oct 2025 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831349; cv=none; b=D8rGND866v2v+78wwOchv980bUPkEzD3vUAAWvFCPC3Mtu1rdZYQVc1TMyTNm7jaMGTPsz1lK+PxqIAeO8yc5QlINXQgGJOCMGK7iArhBfUmBH4N7fZGCO3TtAvpTFXO8JkB2u/zabWr6z/GuwZ3D1dU4/C9j75YN9L8J4UoQ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831349; c=relaxed/simple;
	bh=m2Qmhae/FiUtWK9ULlCbo+6E35csdNPL+RSA91kffuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAiac5xOZsty0Y0KGM9n8Sa+s8yiiK7O9HvFdzbRXtEFVz3xykzYJlCgUSXIFLQiCULCkEpHeMygejoPnT26j/j2fRu3ldMO/U2ErGpyJgtsf3mxCTK+hWbel2+h+t29FZUdtid5hiNejE4LgHyjwINscC5XXRQQpTJNbMuBGRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GnOGzv59; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761831338; x=1762436138; i=markus.elfring@web.de;
	bh=BilsgS0YzTDiVqF6CJB7B4DL1rMy0d9AqQ9HtmQkYEc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GnOGzv5956ukglOMTwcSHQPB+iAY7PykZx7uz/+n2u50sZFZg/2kJZrYbunCNFCe
	 8iw+T20ZJIUrYZ39kiGNbHbPzYF69Yee9F4v1py4ApDFaXWmysxwOR/CH5rVx6CBj
	 ULw8x7XMNJMOblkPibS2mlDprA8Rav0uOzUhikDZ07FtE/vsM974NayqFtZcHJyYN
	 3KXXMIUOu5KOdjFIS3pl1bzluIAqMG273JiZsJIYiR+3Ai7WzE8kAxW7lXBDswxFh
	 DGC5AfXscgQSFgOHst/F+PG2yMUrB3B5+E/YEpVwh02WKjMHqaIwTHvk6J74acwnF
	 5soVpI4f9I4Z8E06Zw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqqPT-1w0hj90M5Z-00gDgx; Thu, 30
 Oct 2025 14:35:38 +0100
Message-ID: <abda1fe0-af59-4fa9-a1ec-efda0f63b3f1@web.de>
Date: Thu, 30 Oct 2025 14:35:36 +0100
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
 <60f881dc-979d-486b-95be-6b31e85d4041@web.de>
 <aa99eded-be51-af3b-414-7c3bbaddea4a@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aa99eded-be51-af3b-414-7c3bbaddea4a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ckJGi+MlMgbDDStuXLOJHnmprq4QO9KBym0BQ64Ua/zitYUbB8H
 SxRJNzgQBRamd0XsiDjyR3ylNwxZ8c8UQ0JFMX/k0fozZN+sw7WH22QPKAmMJ6Ri46rO1+M
 nUcEO8xWpxLUfp7n+GNXm0+9d4BexsCizOEP3vha9Fp5n5+ojigIhZG8j+Zc1nvTVdlYq+o
 oOndvvr6JnGre/lohqxOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c04x0g4n5ws=;7+xR6V3YAf0DU0BRRKVwXa1AW/p
 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

>> I =E2=80=9Caccidentally=E2=80=9D tried also the following SmPL script v=
ariants out.
>>
>> A)
>> @replacement3@
>> expression object, size, source, target;
>> @@
>>  target =3D
>> -object; memcpy(target, source, size)
>> +object; memcpy(object, source, size)
>>  ;
>>
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/=
bin/spatch --max-width 100 --no-loops =E2=80=A6/Projekte/Coccinelle/janito=
r/use_memcpy_assignment3.cocci arch/arm64/kvm/arm.c
>> =E2=80=A6
>> @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
>>                         goto out_err;
>>                 }
>>
>> -               page_addr =3D page_address(page);
>> -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvh=
e_percpu_size());
>> +               page_addr =3Dmemcpy(page_address(page), CHOOSE_NVHE_SYM=
(__per_cpu_start),
>> +                                 nvhe_percpu_size());page_address(page=
);
>>                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] =3D (unsigne=
d long)page_addr;
>>         }
=E2=80=A6>> B)
>> @replacement4@
>> expression object, size, source, target;
>> @@
>> -target =3D object; memcpy(target, source, size)
>> +target =3D object; memcpy(object, source, size)
>>  ;
>>
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/=
bin/spatch --max-width 100 --no-loops =E2=80=A6/Projekte/Coccinelle/janito=
r/use_memcpy_assignment4.cocci arch/arm64/kvm/arm.c
>> =E2=80=A6
>> @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
>>                         goto out_err;
>>                 }
>>
>> +               memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_st=
art), nvhe_percpu_size());
>>                 page_addr =3D page_address(page);
>> -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvh=
e_percpu_size());
>>                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] =3D (unsigne=
d long)page_addr;
>>         }
>=20
> Not sure what is the point of all this.  Try:
=E2=80=A6

Would you like to acknowledge that undesirable difference displays were ge=
nerated anyhow
for these test cases?


>> Would you like to reconsider implementation details accordingly?

Are we looking for corresponding software improvements?

Regards,
Markus

