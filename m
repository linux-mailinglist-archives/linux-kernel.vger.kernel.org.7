Return-Path: <linux-kernel+bounces-802786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E33B45701
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459585C26D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A1734AAE5;
	Fri,  5 Sep 2025 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VmCkVL9c"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193A834A337
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073447; cv=none; b=gaBPKa0nQ2FPGtfjH3+BJD31aMlVop1h3Rt3iU9uII4rNtMmRGK+Bwr1neh9tfqFaDqSEu3Pf6g1x/SN1IPDBEYzhdHcu5I9ef2BNkOvjRATBGQxbxK+uAQQunst076eTkJnyLZfldxaG0mJxlmh0YbY/MRaur+VCO8TGFlQF+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073447; c=relaxed/simple;
	bh=BluZ0n/EBlrhIwiF/nNBirH31HIee/3BeX4W5N3bLk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSsSF83DWtGZFILzvyKY3R5yLVHJ0Ttm0gEh9RvaT82MGmAs70SRw7YRoh/k+AL/iUD2cicfYNgEuQmhXZV8WAfCHgWcfK+nZlIYqlKNqycfYQqg2GadZ2/KXVOtCZfna9r3tlYg6Buqt1mHYWthfLtoJIUrN/7ms8kuhWJTVpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VmCkVL9c; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32b959b4895so1185771a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 04:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757073445; x=1757678245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwRu3z/1tyWo2AWlw49rwHDq7UFt7Y05nNStcD8eOx0=;
        b=VmCkVL9ceOg+Re7PUO1xnFzASe9Q/vMXp4Nl1wmJpAEHq6bRXyTCpjoIxqsyWNpCAj
         OyD/7IpCfoIMgmh1F20hLrYpzLwjjsRWvvDaArHy7f9mCJPWlH2ws+zatZ+tq8lsX5u0
         crg2LK83k8Q3SvzcTpxPRaf6h+Vit2VJVjKX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073445; x=1757678245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwRu3z/1tyWo2AWlw49rwHDq7UFt7Y05nNStcD8eOx0=;
        b=vbMDvcJXzUhS0e0K2Ujk7FpQ3R6BhiLBPIX/RPooyEK3Wz8oX6TLux1dK7yEQTHKuR
         QqIxnBxskmTO7c370jNc2NtoSM0hg7+SttW8bI3xP3bnCsA6xHOuWrcarpQfnDFl0RW/
         jC6Ii1AUt4OPg4hVmHfF/KPhTaBJbXiTFmfTSJoTxpMVI0DEk5O0AE6TAtbiQskO577M
         tTdPdRawGPVB2mhCxNHHVn8nBXyiWnUvGRAy8JGMWsJfIcK7X6zd6716JbfVv1oOAVuM
         NfSJjj+Mw9lb475yp0NtDUD1akPFSe4EN+9P9RtIZeWELvG2q+N/K5OXLZg1Gw01ZcTP
         00Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUSk8W0CbtjdvJDrxiQw0yhqrhklxfI0oCE05Pvx6E50c0Hvj5n98IuwFjrGMbDqh4JHy5fIKoVxNAi++g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2iQ0xD2A1Xa8LD+IvoS6RP2xOKbWSa26vLDOdkyFP3WsDUC2y
	yD7Ac6jqV1u306EXEoZJVK1GB/Nu7vedvw0bXQZ+KH4P9t6wJGbXh3FvkEilR38xL91ixWg9AZX
	e6rduhFCsjdWcXgWIpaOxgdZAHiRmbuX3b/0+kWHL
X-Gm-Gg: ASbGnculJzOFvLcY3Tv32MsYeqvHL1Rv7Bo7lLK+ZJuPVoLGoZitDaXIz2/ZG3Y4vym
	pfsG2hVphrGzhIQYaGVtYRGzO0B5/Yj/zv7q1MTjrDERrnw0hcK6yV3+3unaXMc9MdPnwLRzJav
	hHN273ub+7I3FDaxSA/jbAWrzwWQx0l7jB6FkWhJLsj49/k2bLIhvjAPxq02Fj3fih0UnIvsViM
	NoqTtBRfFGQKEYSZSCYn3WE/As3tNkmyg==
X-Google-Smtp-Source: AGHT+IFSzOFurkAZqFfxwqHBU2GIUt8H3fpkz2wPZsZF2x3IJHiAn287LcomXMAQvQuyZgs8kf5c0zVpFXrvE8TpcWE=
X-Received: by 2002:a17:90b:33cc:b0:32b:958a:51da with SMTP id
 98e67ed59e1d1-32b958a55bfmr8103099a91.16.1757073445301; Fri, 05 Sep 2025
 04:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825145750.58820-1-akuchynski@chromium.org>
 <20250825145750.58820-4-akuchynski@chromium.org> <aLq0a4fPzeWKzaxk@kuha.fi.intel.com>
In-Reply-To: <aLq0a4fPzeWKzaxk@kuha.fi.intel.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Fri, 5 Sep 2025 13:57:13 +0200
X-Gm-Features: Ac12FXyOmhtycsbCUf38YB5fZkBYaTh89EyZOhotIirneDMW79KBs6Uep0MbAXY
Message-ID: <CAMMMRMdU91u1dqhXyRPMrB2ybxMMUMgQNfpWZWMBqOTCJ+Cwmw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] usb: typec: ucsi: Set alt_mode_override flag
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, "Christian A. Ehrhardt" <lk@c--e.de>, 
	Venkat Jayaraman <venkat.jayaraman@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 11:59=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Aug 25, 2025 at 02:57:48PM +0000, Andrei Kuchynski wrote:
> > This flag indicates that the PPM allows the OPM to change the currently
> > negotiated alternate mode using the SET_NEW_CAM command.
> >
> > Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> > ---
> >  drivers/usb/typec/ucsi/ucsi.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucs=
i.c
> > index 0d6b0cf5a7cd..85a6b7fc6d93 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -1632,6 +1632,8 @@ static int ucsi_register_port(struct ucsi *ucsi, =
struct ucsi_connector *con)
> >
> >       cap->driver_data =3D con;
> >       cap->ops =3D &ucsi_ops;
> > +     cap->no_mode_control =3D
> > +             !(con->ucsi->cap.features & UCSI_CAP_ALT_MODE_OVERRIDE);
>
> Fits to one.
>
> thanks,
>
> --
> heikki

I miscalculated it. One line

Thanks,
Andrei

