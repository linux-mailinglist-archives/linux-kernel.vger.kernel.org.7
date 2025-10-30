Return-Path: <linux-kernel+bounces-877978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD32C1F7CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927BB19C0695
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C964834FF5D;
	Thu, 30 Oct 2025 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uGbNo7GP"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA192F6912;
	Thu, 30 Oct 2025 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819556; cv=none; b=KxhFhjUtpRFZWpeLiTTw0Yj+9/a59lJOMFnPJAD6vRIqiX2fFSTnTk61JkbkfCZFJnLXP7YugCC5Nq7FLtQUFpb+/qfJinT9pL2SHkbzweFhkkqxiOyVmL2HUIsAwgG1C9bLmE3tnn8vCMK4qP1I4Bd3EQ2m7yxRaLkTkxzjdmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819556; c=relaxed/simple;
	bh=8r4VUhEYebNsNF2AEqSRPd9vtuWgWzFVlCZVqHYM/so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgkwLSw++1R3oBv3pL0tVWkr+giCcBsr48dZLplpqZQvqJaWM/4ZOUjhMvd3dxDDg0pazz2T0nOjHeBE1jm2/qLLBrvL/W7LYH5LoPgWr31ng69heU7jFsdPfXDcUs7tS60t88xAAWJE81/jFWgzwmAppezDdDkOyrowuFufRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uGbNo7GP; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761819551; x=1762424351; i=markus.elfring@web.de;
	bh=T4mdMIYJD64rI3SfecthJkyL4hRE4/9i+B2hh7U0c8g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uGbNo7GP6vxBRJN78XTbio7edtpwA+YEsWB/M4CS4+Lf3i0lyTr0MjxZMQI4b5ND
	 45I9S1B5CvX8TpuoXmtn0Qx5GVL2UmOq3BHCrYebj3NCkqKHyv8wuJwy1twdSCe4p
	 0XZa28rxqqTdo/XEDGkeuBd9K3DbcR3QHkl0YKv7j0ryTDN5Ia6mWWfkcYHpamPhr
	 Utnpss+Ik8JxyH7/9zsXksMWn+fyBNr4zzKIl1T6E0O5pPicTEGQBk+v17SARS3zL
	 2p0mE+VKRId+ibBie7UsdhjjTOvJapLDuNAnqWvkUYapC6HaVlDIJsh8itF9bJx+V
	 xSzj74WVMYgU05om/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbCDq-1vpwM31wF6-00lKI8; Thu, 30
 Oct 2025 11:19:11 +0100
Message-ID: <d227e982-d69d-45b7-9388-9082f86af69c@web.de>
Date: Thu, 30 Oct 2025 11:19:10 +0100
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
 <62441255-45fc-4edb-a8e5-c208b36ca2c2@web.de>
 <53e91f9f-bfe5-5c57-157c-fc456bd430ca@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <53e91f9f-bfe5-5c57-157c-fc456bd430ca@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ywwLXbduOsoW06QN+pXnwIKTCrW+Kfv4OD6ahjFYhG5aJ/X+JeQ
 r8zxsg9Ep3c38PiFcWU3vUkT/fdofAYSJi5EOFMjfIdzbl8JKEZ8zcmCFIZ0ep2vRiSFMNk
 6w/U+Mn3sVYNmhx5s3/+7ZhONaeKFsUa8WojqFFmZjyxkgvc1GqD6/rsk1j2U9aULUL9bqV
 rdE9agOzeoRmmfLLYqJhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tiqaCECiz8k=;TOFJyoQYE2tdwcd979yiMfRIucW
 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

=E2=80=A6> I think you would get a more satisfactory result by just removi=
ng all of
> the code and adding it back. Then Coccinelle would take charge of laying
> out the whole thing.
=E2=80=A6

See also once more:

>> Another SmPL script example might become helpful.
>>
>> @replacement2@
>> expression object, size, source, target;
>> @@
>>  target =3D
>> -         object; memcpy(target, source, size)
>> +         memcpy(object, source, size)
>>  ;
>>
>>
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/=
bin/spatch --max-width 100 --no-loops =E2=80=A6/Projekte/Coccinelle/janito=
r/use_memcpy_assignment2.cocci arch/arm64/kvm/arm.c
=E2=80=A6>> real    0m0,626s
>> user    0m0,588s
>> sys     0m0,037s


Regards,
Markus

