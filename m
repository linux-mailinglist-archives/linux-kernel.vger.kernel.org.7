Return-Path: <linux-kernel+bounces-845611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E7DBC584E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8556F4F861B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784BF2EBBB0;
	Wed,  8 Oct 2025 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeYxgttr"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D59F286413
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936071; cv=none; b=jJmRbyA7JDult6blYkdcejUIPT44zyPITPzRDMiPme+C8zR4Y5QxFeEXnWEFA/KBPjZIvvXXJyuayKRidvCF7cXvWXCArBj8Qzznjr8IiVwqDTd42Sjvd50o2pe/aBco+4Kxm5oLK3JROp7TcCt6BI4N/putQgUxSBwnMtvR03Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936071; c=relaxed/simple;
	bh=cht59tIOV0KBWttxvPs+3jMxO8RPnxFFXpLBu4tS+3M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M/zyublcYKNvjog8/anmvUWqd9xQwBQCWxpdDTzgRJitA/NA31DZEzin7vVLfBdLEshyj8lu1LbRiolnrh6dhyQvzzV37R4TUjiAOE90anYZlIBcb2cJIdt1nkLa5XwE+E+ufbqJoTJbnZvKLxpa1ZXp609u7fLM0GYFE8p7VZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeYxgttr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so1394036666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759936068; x=1760540868; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cht59tIOV0KBWttxvPs+3jMxO8RPnxFFXpLBu4tS+3M=;
        b=jeYxgttrR9ztk6P9ejcjhmPJmwTgaBM+89VpfVDUmTbhdDYrTfGqSfewj+clQ9ecgW
         dwqrQbmQCKYRTw1zXqM3MGQYRED8MnND7PahOGZl/cFGaC655PNHQOfsG/cz5H00lb2L
         m/fGjuLv2kFAW8jeuKk5zO7dpFr+vuLSf+uh7sBOPjjTnZ7LCagktNaz413eAj/01dr7
         OBUIvMnQrBkJ5MQMUqs8JAJqNeGDueccImi/pzAMsuS6/VXkd70tVBSODyAEHJgqx3M5
         WpB6XrD7Ir5cyso1QIeLQG1z2yLgxvvSozdgMeTxsWssN1c4yn/opIo/C9yH0e1CgwYR
         ms/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936068; x=1760540868;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cht59tIOV0KBWttxvPs+3jMxO8RPnxFFXpLBu4tS+3M=;
        b=w60hl9N0g/rithhU40aZgmbJ7x3Ah+R81I9XAcG2w+H5b6DAmBW2tI4s6BRvyCGko6
         8YkpclaFHUwYHXJ3f97DTcZvRZSK+slhvI92p11tg6ttnOxNSusBvh18WBkgDiqAqCRQ
         e5Q5Nesad+iRj4obRbEXA5/dY0Q8F85yn9nRvMACcHVNvZtOt6rXuSbWvTSkQJ/3146b
         Ye+tlamkT9hAEr7sy9xro4tqd8qhQUh7Wn24dW9vrMHSe/W9G7O9aJ0AXNbfvefyil9s
         ER/U70Cf2S/85dg36CBCYdXl+n8PbKoD6ok6Uj0UsA999duLXOxoq5vstkG9cAlLhyUb
         i80Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAwOgj8FeRw9pqZoj19+Okm34rgdYgyoNLNRxim4/CmMYZWKooATjvuGd5pBdY4x+ORBQU98aoEF0bk7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNKTqZh52c5vvtL9EJV7kT64bMf4JJsRAi3q1fuJjjor8nXZjD
	u9a0Au5keO3lQGlsaxRVb1OcY/o+io4CkGR6bZCngbA263nST81yDwbR
X-Gm-Gg: ASbGncscl5wDuiI99PX2CMmulc0/LCkfnc5POUY/oL9ktvhDHRpEAuX/FTfp6PPvds+
	Kh7e9yH4fuDXmBPnJ7m8fUmh1S8kesXmrvlMRgFonKpCqFMZce1l0fWsY6qQEJ7zMmNI24LWZdY
	rsLQf1is+cqAHCHHouKpnLWVNgUHWlI8/xvh8rqIh46tx85FgPSUte6nB/XcBrdo6HiiqUYgkrW
	m7+53dZokesTAzV4ucbWW6BxOlvCza3Z4tTXGX+CoIJsdgRG8F8SpnhJuAO7KJ/uGD7fk014Kb9
	zAHeVDDmshlBR3AlJUBbm88c+wqj3nCRucipef7vXetyXu4z9teyPYo0M2UH1HnDdIzGqsc4j5J
	llro7iNajOryHvchc85HQKjzxtDLCeLxDRja9uGOCkQQWDGOTOQ==
X-Google-Smtp-Source: AGHT+IETj/eEYHIbcpH9RCQeb94pCTXGLqKLtThMw+whCTYetguG/N32W3WQ2+0w2pr3TOAhygHBUA==
X-Received: by 2002:a17:907:7244:b0:b40:6e13:1a82 with SMTP id a640c23a62f3a-b50aaf8caa1mr378744666b.26.1759936068245;
        Wed, 08 Oct 2025 08:07:48 -0700 (PDT)
Received: from [10.176.235.211] ([137.201.254.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4f94asm1673206466b.79.2025.10.08.08.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 08:07:47 -0700 (PDT)
Message-ID: <893731e9c8e4e74bb0d967ab2e7039e862896dc5.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] scsi: ufs: core: Add OP-TEE based RPMB driver
 for UFS devices
From: Bean Huo <huobean@gmail.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com, 
	jejb@linux.ibm.com, martin.petersen@oracle.com, can.guo@oss.qualcomm.com, 
	ulf.hansson@linaro.org, beanhuo@micron.com, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 08 Oct 2025 17:07:46 +0200
In-Reply-To: <CAHUa44HA0uoXbkKgyvF4Rb9OJa1Qj-Wh7QAmQxXYAf3grLdktw@mail.gmail.com>
References: <20251001060805.26462-1-beanhuo@iokpp.de>
	 <20251001060805.26462-4-beanhuo@iokpp.de>
	 <CAHUa44HA0uoXbkKgyvF4Rb9OJa1Qj-Wh7QAmQxXYAf3grLdktw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Jens,=20

I incorporated your suggestions in my v3 excpet these two:


On Wed, 2025-10-01 at 09:50 +0200, Jens Wiklander wrote:
> > diff --git a/drivers/ufs/core/Makefile b/drivers/ufs/core/Makefile
> > index cf820fa09a04..51e1867e524e 100644
> > --- a/drivers/ufs/core/Makefile
> > +++ b/drivers/ufs/core/Makefile
> > @@ -2,6 +2,7 @@
> >=20
> > =C2=A0 obj-$(CONFIG_SCSI_UFSHCD)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D ufshcd-core.o
> > =C2=A0 ufshcd-core-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 +=3D ufshcd.o ufs-sysfs.o ufs-mcq.o
> > +ufshcd-core-$(CONFIG_RPMB)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D ufs-rpmb.o
>=20
> SCSI_UFSHCD might need the same trick ("depends on RPMB || !RPMB") in
> Kconfig as we have for MMC_BLOCK.
>=20
> >=20
When RPMB=3Dm and SCSI_UFSHCD=3Dy, the ufs-rpmb.o is compiled into the buil=
t-in
ufshcd-core, ufs-rpmb.c calls functions from the OP-TEE RPMB subsystem modu=
le,
The kernel allows built-in code to reference module symbols (they become ru=
ntime
dependencies, not link-time), please check, I tested.

> >=20
> >=20
>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rpmb_descr descr =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 .type =3D RPMB_TYPE_UFS,
>=20
> We'll need another type if the device uses the extended RPMB frame
> format. How about you clarify this, where RPMB_TYPE_UFS is defined to
> avoid confusion?

As ufs-bsg.c, we could use ARPMB_TYPE_UFS for UFS advanced RPMB frame, if i=
t is
RPMB, we take it as normal RPMB, the frame should be the same as MMC RPMB.


Kind regards,
Bean=20


