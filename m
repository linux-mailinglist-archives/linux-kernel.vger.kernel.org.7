Return-Path: <linux-kernel+bounces-839579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA71CBB1F43
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A076A4819AC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F6D26F2BF;
	Wed,  1 Oct 2025 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzW3dHUW"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F6C27281D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356798; cv=none; b=R/hhUK28m/iCRmw8jeJRPi0DUn/XQsCzePhAMNiAXFNULTYUbK3mBtj0jmwShbrlsHrI2i2nvLWmgNNv9Ct/yjzii/1/Kb/+NbD+BUCsG+va3t5Fg1YLmKx+pY8b6RlIJ94GRW81iA/weMOE/mPxy3108vCwPbmWi274yD58KwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356798; c=relaxed/simple;
	bh=tPndpULAbWoWY8UTLQ/AFwwTVczo7jTM+rf4CZLnwMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbVEPvcf81bMSQuoVNqpEM9C9MUMHWUaSyl1ObJcQHpaMAN01W1REzs8LEFOAGzHht0HJxu70rgbFFMcNZgu3WRD3Cyoitv1IAEA6xHlisfqtAz0XipOx1LGgPiMptsfrVAPlY9zSTf3qjngq/qoEatdscioC3zJqEsJucCV5Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzW3dHUW; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5a3511312d6so186150137.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 15:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759356796; x=1759961596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQuuPVRaUFdks4kqpb8QsLkv5DxP12dTUeHoSfN8GNA=;
        b=dzW3dHUWN6cm67HQXCzpnEMUbfAc93Fl7BOEA4l+fzY/qIZgD/+Fy9h9vTl7z9LPxG
         T9034FnVM4+hHKFz86WovcrnIx1yIjCz37zU52UBlg7h7IFp2SqV5aaU5wvCLHlUXD6v
         yw/nSKNgFtAGWb0bCcE2oknhjHVenZgupKdYSMaksWIppuK0fSstRECnI7DVYfw4M3yr
         otAFu5HZa+wUEk1iAfE6RPtFwOdyHUT0/IhGS4kr40edIg+XxsTqeJ7+apeGgo+Hpxob
         JUlEWxFXJg0Wi82TdNcF+laBV7TXRVFsOTLRM8RFt7Zl4zgtr8aTOGXtOqKeOIGsX9i0
         Ddaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759356796; x=1759961596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQuuPVRaUFdks4kqpb8QsLkv5DxP12dTUeHoSfN8GNA=;
        b=cXrK0Q2cTSpezaTvOQrhdtfMYjxsWq/veJ/W16tbesSgffLLopL2i6ilnwhClgAFZ+
         Jk2EwDSlCg7/WTtzKKqQWMOiZtalfohmCuORHnYgchOMc8VaDEmPNy4KE1FMTQKBharI
         1/rquGMjHNHpN5Z7IPl8V9W0lqLhskFiROxZmdy1efnfC2ggDJtbfD6+FVV+536Hf+88
         vrocYEesd+Iggi9B4xEKlD6Vo0x80Kc8hjlkVIRUvVhdZW6Nrot4snEBnUbmjpTYUIrm
         xzXrQcIP67ZeCC6R8JbLI7riqgb1iw1gOwdh+2fotVs5erld02uoBtxuduQYW894fAfp
         fP8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2oSLD3oLHKIvVX1lW3KPO16gpxJrB7q1DsCiKMqQU46QzSkfEcpwttXiVu/UYX1JoaHhbmAxYptuOmUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWTrKxWkIpv2AP+SdSCW+K9j2Oy2d0lzCmotSJyXtYISCQkaDg
	x3w6ya0JWYXKWTzDMP6U4sqEgOmMAu+UtpOUQ5m0cpiepTtjoaOS72oBQuEU2nDjVBq/+SYLI+c
	hDuLTH3vOtOqKcu32oQvLzvsj5LwCMAk04d8uAlxTbBcu8ZAt3YHHhkSA
X-Gm-Gg: ASbGncvE0PqEWQF1ERiFgVQreuFn90z4VgIM0AkdkH8Rjgbv0nt1TqmWKojyMJ2wpHL
	1KM59bj01puAMBI7sJOL8H2EURO1t9IQ6R90O5lVy5KlSQoZkBTMHS5lzc4mgoNvfqAZU+7NCK3
	HEo0WjImUjwWOYMztyb0MCH9U/Zh9YUPBfVlyrG1Nv/iHM/c4maA2R6LHaFbo0aaPQq1WKzniqW
	l1/SaJqfHA6YM4m5AzRjBBS4g8p54TT/wtd0HbzB19Z1sdUrnRhHJrLDdZq5qzqez7i
X-Google-Smtp-Source: AGHT+IFA6yXrzTsp2xi6qyZXmsCuf00PfNjig4VyTKkq9GW9JSEit5FmDKebVLalAegijKG6705sSMBG5qcDZkyMO7Y=
X-Received: by 2002:a05:6102:304e:b0:59d:ad3:e1ed with SMTP id
 ada2fe7eead31-5d3fe5075aemr2155954137.7.1759356795431; Wed, 01 Oct 2025
 15:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911185314.2377124-1-wusamuel@google.com> <CAG2Kctqf=Q+nuuDqzkrOpjp+tOttf079DS_R8Q0pHU-k8DmFvA@mail.gmail.com>
 <CAJZ5v0gtKmtiLQwi-2qaw2G4O4PF_iqz6UbUZuaknepcJ1ToZQ@mail.gmail.com>
 <CAG2KctrK0JrP7JNUyzF72JeDgR4-GSRmJDe+yEnav=gQCAf64Q@mail.gmail.com> <CAJZ5v0g_HXQjWfp=L0KetRCHMTD=QsP3wJKNZnadJic2yccCUQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g_HXQjWfp=L0KetRCHMTD=QsP3wJKNZnadJic2yccCUQ@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 1 Oct 2025 15:12:38 -0700
X-Gm-Features: AS18NWDfY1WB4mqgdo-7TnO01Va9Bg6a13NPoxHIrZI5kNp7HZrddVfJLsSFVIQ
Message-ID: <CAGETcx_Fn3AzZo7gNvJnPxy=CNHpqAviGdUrww++SGySuBcaZw@mail.gmail.com>
Subject: Re: [PATCH v4] PM: Support aborting sleep during filesystem sync
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 11:22=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Oct 1, 2025 at 12:37=E2=80=AFAM Samuel Wu <wusamuel@google.com> w=
rote:
> >
> > On Tue, Sep 30, 2025 at 11:51=E2=80=AFAM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Sep 30, 2025 at 8:30=E2=80=AFPM Samuel Wu <wusamuel@google.co=
m> wrote:
> > > >
> > > > Hi Rafael,
> > > >
> > > > Just a friendly ping on this patch. Please let me know if there's a=
ny
> > > > feedback or if you'd like me to make any changes.
> > >
> > > Have you seen https://lore.kernel.org/all/20250909065836.32534-1-tuha=
owen@uniontech.com/
> > > ?
> > >
> > > If so, what do you think about it?
> >
> > I was following this chain
> > (https://lore.kernel.org/all/20250908024655.14636-1-tuhaowen@uniontech.=
com/),
> > where there is some ongoing discussion on converging the solution.
> >
> > Our changes aren't mutually exclusive, and tuhaowen can build changes
> > on top of ours, even indicating:
> > > I'm happy to work on this as a follow-up patch series after your chan=
ges land, or we could explore a unified solution that handles both scenario=
s.
>
> That's fair.
>
> > These patchsets don't negate each other, so could we decouple these
> > two patchsets since they address different issues?
>
> Well, I'm not sure if they are really different.  After all, this is
> all about avoiding having to wait on an excessively long filesystem
> sync during suspend.

No, it's different. We don't mind a long filesystem sync if we don't
have a need to abort a suspend. If it takes 25 seconds to sync the
filesystem but there's no need to abort it, that's totally fine. So,
this patch is just about allowing abort to happen without waiting for
file system sync to finish.

The other patch's requirement is to always abort if suspend takes 25
seconds (or whatever the timeout is). IIRC, in his case, it's because
of a bad disk or say a USB disk getting unplugged. I'm not convinced a
suspend timeout is the right thing to do, but I'm not going to nack
it. But to implement his requirement, he can put a patch on top of
ours where he sets a timer and then aborts suspends if it fires.

> I'm also not sure why it is being pursued to be honest.  Is setting
> /sys/power/sync_on_suspend to 0 not regarded as a viable option?

We do want to sync on every suspend. So, we don't want to turn it off
completely.

Thanks,
Saravana

