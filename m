Return-Path: <linux-kernel+bounces-835555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C99BA76C6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252DB3A62CA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E018F259CA4;
	Sun, 28 Sep 2025 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEip2Qou"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B734BA4D
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086747; cv=none; b=kKbNU15EmVRqKVe6Dw4FoVzMgx3Fwy+v/ZkZwIJ9tAWBwQwTfFJVm3JD9bjOxOQ4f2KslLSApXE5ozPF08p2QdfKCz1xU9uWIdmUgdswSTG7ADvmwRAvB1y/Yqsd+wTIdMbintdYDzSnNWS6fYtVbtbpoQ9J3y9HiwJew/V2RLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086747; c=relaxed/simple;
	bh=k4Nn0P7yaXQ1y1QJmpWUS7crBJP3aAw3tOHyFDDPG5c=;
	h=From:To:Cc:Subject:Date:References:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=TIcToq08akdPagDzTFwyJU3ETXg62GGTxplLYVI8An2NDdrJqWfZ9U/N2MwAvyjP/mR5cYSnzumXk7OITNfz9rGCy2mfHuy2KJmAeUcWWJcMW9PYLP5qUid9ViBYQwRWRuJPHjKGliaPfiycUe3VUaGmat321TmHu4PHEuBXLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEip2Qou; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2570bf6058aso55193705ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759086745; x=1759691545; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6+64T8/OVtDekwKSacVIy7b5udGbpNaR3HNtwiQ4bY=;
        b=EEip2QouD+4rk6r/BxSIemUoJbz5DvFgTH+0Sa1xu0n+yi77Y5xCvXxPugyjcyhZuW
         OWmMVDYy8mQF/37KVoHj/XEYy8SRUsJdDF7D0nPKo73ipIWE/sji/As1JqerI1QINKCq
         oduZzRq8GbNwsrt9Ianh9kpoJSdKaueED1/X1MCQeYoJLahc/dgMXG+CceBn3IivwWXc
         G76Y6fSb8gtPtuWDeMKdprh9ZCK2DngicAqEzABAKphuJWSeYd/FHfRN2iauSDgwJm44
         ueMuVQCbR+FRr08Lu61JVjNZWBY3ur9RShvVDaEeOglrbrHJcjnTTJdKMtpEIYic+Dka
         +M/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086745; x=1759691545;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6+64T8/OVtDekwKSacVIy7b5udGbpNaR3HNtwiQ4bY=;
        b=LD3hSc0cG6kepQ7hecHRZC9tPERzAHAkWnlvAjVbgEbO7tBE+dRdMErRAayan7cK+W
         J8QdZbCcRa4Ar7E6d/7QNpE6irZILiDII+RdAtWl3ng2v+w45oIyGVwyXBgBUnjflUav
         C5QZbSX5XyJWhLLjMCqKBMtom4kLj22guIJjADHHYpPUFR/wr1ggRGizsbZOx+S9nGNv
         yIRKR9RGjjXS4z0ZPdiSHI/bZ9BsQKuBba4Eim+gl+jt5AA8PRQ1D9n39orzPaRXva/p
         Y0e/2LvfdvZYLzbR4UCB/yDMF136CWPX7x32v0aeoPAOg9EKkiamH4V2AGPOOFdpS+LA
         5GKg==
X-Forwarded-Encrypted: i=1; AJvYcCU6ug1s5a2kgDEUrO5rd+q8w4Q4QbkDB4NTrWKsnQaQbjfGi1WaD0bb86N4pfFx5+zXk2VWSeif57uaV9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfTSHYrbyBnfVq/F00SW3Vl7LifzXiyJywo1xl7BA+G8xF//Kr
	Z0c4Rgn2OmM/uoMzWbmFph7eD2z1sYaxdMBizeDHGBdOV0y4KTkoUztq
X-Gm-Gg: ASbGncu2M9Se3OkrK8298bs8mcyrl6KiECmnzqUWOIdSfOtKBGXxIj705aiMriyh+HN
	DwTOtq5Yk04oa08gA7fewKK72KJ+le1X0upD9BCA+2eOOp+lBkv14cCG7rPdJz+YNhWtNuo6h7b
	YMHJem+xqDvsIYQ1YzFTz2fXJxlmrN8hpqEcH2yPNPurlfPcVi79y0m+we3dDpJw0UIiCiLAEiB
	EMcjTSg40pENlYDEhVmAKw2dm06rv+iGEuYztLGakFKbQIB4oIsqSLZJ4gNO3gluq/cZL3Pme3X
	7AM1fn6HOGErXy493uKEzb/92f976RXcrIf9Vlmp5tlxH9aov1B6c2nOgoXHNtZJYMv+phMt161
	9jt4YrnpbfB9Ay5KVeMLZ+gfTh58wuxtIFQ==
X-Google-Smtp-Source: AGHT+IG2g+TWi/xZtsDJNMcrRs7syD1a+LKNars74DO3AjH+g94ZzVbTjcPUhTTZp/04GuT/UkSGVg==
X-Received: by 2002:a17:903:1110:b0:28a:2e51:9272 with SMTP id d9443c01a7336-28a2e70216fmr5541915ad.48.1759086745022;
        Sun, 28 Sep 2025 12:12:25 -0700 (PDT)
Received: from 1337 ([136.159.213.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed67076ffsm107646095ad.39.2025.09.28.12.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 12:12:24 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: Edward Adam Davis <eadavis@qq.com>,
 syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com,
 hsweeten@visionengravers.com, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] comedi: aio_iiro_16: Prevent invlaid irq number
Date: Sun, 28 Sep 2025 13:08:48 -0600
References: <686bf6a0.a00a0220.b087d.01f2.GAE@google.com>
 <tencent_B0B82F456DC094ECE982EF1ECCEC7AEA6D0A@qq.com>
 <2f17944c-80ff-49a7-97ef-275f5e247e8f@mev.co.uk>
User-agent: mu4e 1.10.8; emacs 30.2
In-reply-to: <2f17944c-80ff-49a7-97ef-275f5e247e8f@mev.co.uk>
Message-ID: <87frc62xyg.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ian Abbott <abbotti@mev.co.uk> writes:

> On 08/07/2025 13:37, Edward Adam Davis wrote:
>> The irq number 0x2166 passed by the reproducer is too large and is not
>> within the supported range [2-7, 10-12, 14, or 15], which triggers the o=
ob.
>> Fixes: ad7a370c8be4 (=E2=80=9Cstaging: comedi: aio_iiro_16: add command
>> support for change of state detection=E2=80=9D)
>> Reported-by: syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com
>> Closes: <https://syzkaller.appspot.com/bug?extid=3Df1bb7e4ea47ea12b535c>
>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>> =E2=80=94
>>   drivers/comedi/drivers/aio_iiro_16.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>> diff =E2=80=93git a/drivers/comedi/drivers/aio_iiro_16.c
>> b/drivers/comedi/drivers/aio_iiro_16.c
>> index b00fab0b89d4..e43730f00c8b 100644
>> =E2=80=94 a/drivers/comedi/drivers/aio_iiro_16.c
>> +++ b/drivers/comedi/drivers/aio_iiro_16.c
>> @@ -177,7 +177,8 @@ static int aio_iiro_16_attach(struct comedi_device *=
dev,
>>   	 * Digital input change of state interrupts are optionally supported
>>   	 * using IRQ 2-7, 10-12, 14, or 15.
>>   	 */
>> -	if ((1 << it->options[1]) & 0xdcfc) {
>> +	if (it->options[1] > 1 && it->options[1] < 16 &&
>> +	    (1 << it->options[1]) & 0xdcfc) {
>>   		ret =3D request_irq(it->options[1], aio_iiro_16_cos, 0,
>>   				  dev->board_name, dev);
>>   		if (ret =3D=3D 0)
>
> The patch is fine apart from the misspelling of =E2=80=9Cinvalid=E2=80=9D=
 in the subject
> line, but I=E2=80=99d already submitted a patch for this before syzbot de=
tected
> it:
>
> <https://lore.kernel.org/lkml/20250707134622.75403-1-abbotti@mev.co.uk/>

#syz fix: comedi: aio_iiro_16: Fix bit shift out of bounds

--=-=-=--

