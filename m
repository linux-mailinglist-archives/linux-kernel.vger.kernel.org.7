Return-Path: <linux-kernel+bounces-887198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB134C3785E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05E074E36DB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CEA340D85;
	Wed,  5 Nov 2025 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NFntWLw4"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ECB258CED
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371683; cv=none; b=evMMzT8nc4lZEevBxUKWxhf4n8Gh05RNk48B6evai8rBezu2M+f5sZKcc6V/u10K6iVo4iDnUQD8lveUFqSVXlgBQYf8MatN6rixoDW3bKE29N+/u9W/M0tlsRfRLGdr6mD0/FOfjUb1stL/iPb9xsaF0B2WSkbDPJnVg/h1LoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371683; c=relaxed/simple;
	bh=bZHv94L6/tQUoE0h96uu+ssXsm4jrc3twKjnXVEhbVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfyiflPIp2NUo4po6OUS3p09A3mtHyLpy+xSf/MoYY+X9lt5LcjfSJQYqG4ta5RQC5wx/ZZtUtI/B9AqymFoyAXpivInYp/IOx9Mo6QfErtpA2KviuB03FLJ0+qxBmsOgXNu/Z7ivadKbuu1ySAtYEhKDjhpzwUE+BvlHRYysx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NFntWLw4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-594330147efso176997e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762371680; x=1762976480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZHv94L6/tQUoE0h96uu+ssXsm4jrc3twKjnXVEhbVk=;
        b=NFntWLw4oUOLucF1nBEsLwwyWmFE/9KfBzstS7U6Y33KHiiJaaXzjJOnV4SefYuiFe
         9fD5/ZIlkxZmQaQNyvMGOTKLrHspoBXHq2/n/S7W8qnPg3G4bg/7ZrOeLiF2DYf8UBtO
         qLy0hadsOHnDuzvqxzCzprvZ+pxf6PS8qsFvk4qKjU8BfVyY8mBDcyDYmHlA67Uo6sFQ
         Qd6szAio1IC+q8SDs0mSlcEgZgAxxz3yc0bT1c7oGWdHv3H1diMlKAz+lKFzF7WGRZyN
         H/Fu/jjp1zQDbTggPzIDD+RrjEdJssOlk/nIeF5sg0o6R5soj0kV+4oD/zTQ1ISuU5VT
         f4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762371680; x=1762976480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZHv94L6/tQUoE0h96uu+ssXsm4jrc3twKjnXVEhbVk=;
        b=kmn+ny9Q0IWIF2CZUmUZckyASD5vumkpIENrvLmwp8xLFcjlKDQtUukG860Yi7FwSo
         Td1mNq7EZpuIXXxeMQet9rMMNfOs+YjiW2KOD4mLwJO3ZqADBbC57id7J4U8swcBRNAH
         gtM0tgpCY7a+xv/wAAubZOWAfualMfe9pLb6f1OfGgB0lXXMrrg+5rJx04y6UMsOuVPz
         4AurRYEr6/WrgQ7g8UWeFHVZdOWitoC6nPdCFDrwoFvknETO6OuSh5NgB4cP9s2cASPB
         ILd3x/VlNIbKcJta9zvN/HnHVKcELKbelsYNew9KacY9aEgf7OTZulsoyEhHEAc5XY/4
         f7CA==
X-Forwarded-Encrypted: i=1; AJvYcCV9zN8BrR7uyRhfq02Y/HsNUAb089/ISRE9Lfd9ui22dYTICDPNN8w9JuMNTE9SdoQM36aZ/k1cQSuc/2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0biBshnstCQYs8D78EO9y6FuobFQXyDJzWW6Ytxuw2ThQVKac
	RdbTkBM4jeP4yAd1MK+MeBjFb5VRjC02DKU1wExDLHeVha9IdMnzH0UyTUWREcsEA6M305hDwDp
	ULOkWdhhacRJRmrDUyxTATvNl2ZF3KNQebeY19RY0
X-Gm-Gg: ASbGncsQX/olyyHFrmSVAv4a5hfTSmfAlu6o4lkDO2wk1lg4RFo5CiibY9HitIIKabg
	D1486ieWuHyqIzOTbiHfOD3KxCpBtSFdjPFcn33ZqEq421+H7ODjBDRa46TIIWO4Pts4nIUIeq9
	lbhj9xjoL2ZeZrVOVRHf4PDzo9r0FmTesPzu2G+lx4RloaCITfrpfXIkEsyJalD4YHw0QPPfuyy
	/NMQdsf6IODlOKLdTOoePl0rxBwd3UNnvgBVuklyqy0sXfh5Hqt4KXOpUKo87+tosvTwoRVc+Da
	W/B4a6N/2MOkhb4sPohamcw=
X-Google-Smtp-Source: AGHT+IGQIiPZcHHq1WrKLoi7cZHVRI6qNimojPh1PTmb/201EYfhPdIi91zsPGboaAy7eklJpvt+vajCMx08/Xsmdrg=
X-Received: by 2002:a05:6512:1287:b0:594:2835:e751 with SMTP id
 2adb3069b0e04-5943d8044e6mr1659936e87.53.1762371680204; Wed, 05 Nov 2025
 11:41:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010012006.2282321-1-svv@google.com> <no3r172s-899p-7s78-o199-8q8oq1r2nr71@xreary.bet>
In-Reply-To: <no3r172s-899p-7s78-o199-8q8oq1r2nr71@xreary.bet>
From: Siarhei Vishniakou <svv@google.com>
Date: Wed, 5 Nov 2025 11:41:03 -0800
X-Gm-Features: AWmQ_bnYhq1zuERdrkg_2iQXFsAeKs5IR_ItocUtDqbe34Aptv1t2IbqkWYTTkg
Message-ID: <CAKF84v3zxT5siCOnXwn6Xc80T4vTDpP08K1Pd-J8XyBtv-V3Mw@mail.gmail.com>
Subject: Re: [PATCH] HID: playstation: Remap joystick axes to be centered at 0
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
	Roderick Colenbrander <roderick.colenbrander@sony.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 31 =D0=BE=D0=BA=D1=82. 2025=E2=80=AF=D0=B3. =D0=B2 02:00, Jir=
i Kosina <jikos@kernel.org>:
>
> On Fri, 10 Oct 2025, Siarhei Vishniakou wrote:
>
> > The joystick axes (ABS_X, ABS_Y, ABS_RX, ABS_RY) for PlayStation
> > gamepads report a neutral state of 128 over HID, with a full range of
> > [0, 255]. The driver previously mapped this directly, resulting in an
> > evdev range of [0, 255] with a resting point of 128.
> >
> > This approach is unconventional for Linux gamepad drivers and has sever=
al
> > drawbacks: it requires userspace applications to be aware of the
> > non-zero resting state, and it is incompatible with the input
> > subsystem's 'flat' (deadzone) logic, which assumes a resting point of 0=
.
> >
> > This patch remaps the four joystick axes to the conventional signed
> > 8-bit range of [-128, 127], with 0 as the neutral state. This is
> > accomplished by changing their evdev range in ps_gamepad_create() and
> > translating the incoming hardware value in the report parsing functions
> > by subtracting 128.
> >
> > The analog trigger axes (ABS_Z, ABS_RZ) are handled separately. Their
> > resting state is 0 (un-pressed), and their hardware range of [0, 255]
> > is already the conventional representation. They are left unmodified by
> > this patch.
> >
> > This makes the joystick behavior consistent with other gamepad drivers
> > while preserving the standard behavior for the triggers.
> >
> > Signed-off-by: Siarhei Vishniakou <svv@google.com>
>
> Hmmm ... as I am rather unaware of the existing playstation userspace
> ecosystem -- is there any way how we could now be breaking existing
> playstation-specific userspace assumptions that have already developed
> based on asumptions that we're centered at 128?
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

Thanks Jiri for looking! I chatted with Roderick, and he brought up
similar concerns. Generally, most of the joysticks have the "normal"
ranges with the 0 value at the center. However, I understand that some
user-space apps might have hardcoded some of these Sony-specific
assumptions.

Instead, I will change this patch to provide correct initial
(centered) values of 0x80 when the driver first starts. This is needed
in order to fix our Sony gamepad tests on Android (and will help
everyone else, because now there won't be a stray "bring to center"
event emitted from the gamepad in the beginning). I will follow up
later this week.

