Return-Path: <linux-kernel+bounces-853138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D41BBDAB79
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13D18354F61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8A5304989;
	Tue, 14 Oct 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0GuveuNr"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A23043AC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460888; cv=none; b=jyatiCg8pP31p0NuLm8mdjMHmdAPO6cM28b7HjOKLXs5fh8vJA9Jl6pKqRfNA+42eN8vPetZwzYSwkZo/MH1ZUTmqkdxVcQF2wLCtj2pb8RewHg6XxHViRciFyzUNe5UlPffXTRDB+t3yMXpLhz+m1j3ZJ6GkH7okfi3Ir/2ygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460888; c=relaxed/simple;
	bh=D1GVedUb0QFmnIZwIdVK+2uGHdnzIPnIAYaUHpZc5aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9YDlGp5s5VyoR9UuyBAbPPdGzpaJrj5YhZYRIavkqNgnkOIqsqFIPs6DtCjVNTo/YdjySZOdtHWN4MOAVnzoesVniSexavIX77OLGXGLLthPEJ798YdiuEBSeW+s2qYfJCqwSpDcEVZhD1clYUdJcg5wMSrq4nbKqiUvOW/kGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0GuveuNr; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-85d5cd6fe9fso581746585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760460886; x=1761065686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Df6BZCUDqmZYWW1/Q3uV+enf2JbWxA8H5BbOTsXwypM=;
        b=0GuveuNrXbRIWw9zzbfBrq9TW6LOEVF0X+jY0nOuROJlQ5GrCBaof4EbKh9k5PvJMM
         BtjVNLbKeUlrR+3m0u6sAkedHAySFWE+4EdbOEaBlGtHChx+p9ThRGWkX2Vxz74PaB/U
         juug/H8fPCLlfTEnXlWhGnIkCWqlRJY01wKfGIt5DI//9qM+IlvW4d8y9JMr8Oz7k/kZ
         StdoCViotFves1YqMBB7uNEF9kOyVCsNgWPvCq5aHd0vSJC4LY5k4+aO/RvtIaVyZxYB
         f1sP3f1Aow41Qcu3VO2kz91ClOLr7h/a+cFfe5spn4cq+gfyhVZVoKd7PC72FkC5Fc8T
         JN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760460886; x=1761065686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Df6BZCUDqmZYWW1/Q3uV+enf2JbWxA8H5BbOTsXwypM=;
        b=tEuMlegT748nsufqqgpYsrSmYSs5BL++mETxd2TYeGSxScOP06pCYEboktr/0P9KFA
         uWgV1jar69d1R87AHdM4SwJ8C0eQTXb2tmmxNipmgc4fCg2GjZ8Mj2cd75jHd18knh2e
         8iE2NIjjMd0nrzoEvQymowclK4mhobnrVuNEthAVPCN/58E5rRD7vZ0nCTtyXoksKXCJ
         +iDV7NFsRv7KhDcEYLli/WJxjtZJcRA5gnkG1K2IctYHiljFq7ibmp14U8wz5W6c0cu1
         NIf09xo6RXGbnVJir6sn3zY+x6NdSDJEQAy0PHG5CslXuVw2YMwfoBy3haKtDo5EeRSV
         Wi7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJN1jPh+bRpnbj5peOWkw+fCvIGBlqLxGEz+By040zRn5Hf45Aix0onc4wxqVA/faN33wKSIKBeofni5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv76kK1WwaG0zM8lPiLdlbQOnqGLvgLQCM6qfzs+v1lxVXFlN0
	DF+rVhmfPTmGj0CfgvhFPMRHY3pjKXsLsCeyR77ymHT8ULdHLz2UXIDD87yIG0HenbreP6y2Ekm
	Fq/3PpYMs7+Iv3+aW5eKHw4HG+q0+4BZ3tqTIeA4N
X-Gm-Gg: ASbGnctulC6EpvHTVVTPb0PW+ShdCIkX4i+OJ/EMpqdArfCIpvLhnphHM2pPxvjcNib
	yPw6PxDUrpbNJaWEw3m/EdIZazvNxF5YABZ+PNkgOb/gd1QlB2a2IQwziVvI67W17MIuyh9GykS
	xwXqcgmfJaWn9DtpDoCxQyv8EnsebxGCadJNp3TPQLpU+iyTWQ4lQWhIEM6XY6jOmTiHI2UQ4rb
	qEz6H3F0J3HWub/K00QYJLCtj1RegR8/DR6nFok3KFW/Y+cndoxQegkRqXREWOe8Q==
X-Google-Smtp-Source: AGHT+IFs2gFYcfCXCnaHheGv1p/wPFAHpEAPy0np+u6INKD1CEWs2Qe2zsnL7aytVH5aO6wPXE69vW94D3oxAHQrrSM=
X-Received: by 2002:a05:622a:190c:b0:4e8:8202:a358 with SMTP id
 d75a77b69052e-4e88228caa4mr1291541cf.28.1760460885501; Tue, 14 Oct 2025
 09:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-hid-haptic-kconfig-fix-v1-1-b1ad90732625@google.com> <r8116qrr-5n80-01s8-92o0-88n8q14007s9@xreary.bet>
In-Reply-To: <r8116qrr-5n80-01s8-92o0-88n8q14007s9@xreary.bet>
From: Jonathan Denose <jdenose@google.com>
Date: Tue, 14 Oct 2025 11:54:34 -0500
X-Gm-Features: AS18NWDw2ZPqBXsxEa-0ouLmF3Mps0Fed2-Rbg-wZNaFmSdlqE2JyI1Mab_Akis
Message-ID: <CAMCVhVOXm88TZ1VV2TcMEO9qUn4A=+MWroGOzF+oJOFcxChQFA@mail.gmail.com>
Subject: Re: [PATCH] HID: Kconfig: Fix build error from CONFIG_HID_HAPTIC
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Thorsten Leemhuis <linux@leemhuis.info>, 
	Randy Dunlap <rdunlap@infradead.org>, Lucas GISSOT <lucas.gissot.pro@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 5:09=E2=80=AFAM Jiri Kosina <jikos@kernel.org> wrot=
e:
>
> On Mon, 13 Oct 2025, Jonathan Denose wrote:
>
> > Temporarily change CONFIG_HID_HAPTIC to be bool instead of tristate, un=
til
> > we implement a permanent solution.
> >
> > ---
> > Recently the CONFIG_HID_HAPTIC Kconfig option was reported as causing
> > the following build errors:
> >
> >   MODPOST Module.symvers
> > ERROR: modpost: "hid_haptic_init" [drivers/hid/hid-multitouch.ko] undef=
ined!
> > ERROR: modpost: "hid_haptic_pressure_increase" [drivers/hid/hid-multito=
uch.ko] undefined!
> > ERROR: modpost: "hid_haptic_check_pressure_unit" [drivers/hid/hid-multi=
touch.ko] undefined!
> > ERROR: modpost: "hid_haptic_input_configured" [drivers/hid/hid-multitou=
ch.ko] undefined!
> > ERROR: modpost: "hid_haptic_input_mapping" [drivers/hid/hid-multitouch.=
ko] undefined!
> > ERROR: modpost: "hid_haptic_feature_mapping" [drivers/hid/hid-multitouc=
h.ko] undefined!
> > ERROR: modpost: "hid_haptic_pressure_reset" [drivers/hid/hid-multitouch=
.ko] undefined!
> > make[3]: *** [/home/thl/var/linux.dev/scripts/Makefile.modpost:147: Mod=
ule.symvers] Error 1
> >
> > when the kernel is compiled with the following configuration:
> >
> > CONFIG_HID=3Dy
> > CONFIG_HID_MULTITOUCH=3Dm
> > CONFIG_HID_HAPTIC=3Dm
> >
> > To resolve this, temporarily change the CONFIG_HID_HAPTIC option to be
> > bool, until we arrive at a permanent solution to enable CONFIG_HID_HAPT=
IC
> > to be tristate.
> >
> > For a more detailed discussion, see [1].
> >
> > [1]: https://lore.kernel.org/linux-input/auypydfkhx2eg7vp764way4batdilz=
c35inqda3exwzs3tk3ff@oagat6g46zto/
> >
> > Signed-off-by: Jonathan Denose <jdenose@google.com>
>
> I've moved this whole block above the --- line and applied.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
Ok, I understand now. Thank you all for the feedback and fixing/applying.
--
Jonathan

