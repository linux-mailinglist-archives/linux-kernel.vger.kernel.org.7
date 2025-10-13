Return-Path: <linux-kernel+bounces-851151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FB4BD5A96
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3486D4E9FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37AB2C15A2;
	Mon, 13 Oct 2025 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFIt2a3r"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA902459D4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379195; cv=none; b=E51S3fl4AO+2sNR2NgETTe+PDG2QvL1dqKhKdT3JRI7c14ACjZZ/1oSw1T++lgHKYAOKAn1ZZey1iXQRyyh3CSahnXDfPGJwcehwb0VMl6HZZ0F5oNB5igEe6CBtlHeTGMphVe4mI3Yx8eI9p7s/ElsWREsgQQVhHJClvncx3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379195; c=relaxed/simple;
	bh=OTScJF87r9gVg+1Yo/OxYg1HFqlCLltq/YnKA/HBr3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUfumPtcHJzVBuPe0plAe7qU1KsY5JB9zr3Dyyt8PmUKnfNhgpu7Zwv6QfapVWuKZ1bD7eJ3XQY6gRdD4MQmj/9lcVDnvV10eeLI1nMpFo3Urqo2qU+rJJ/sGf+0fXC27PB36rrxLTMAqPoGWlA5lW07zap76Unh4Ppyc+NZ/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lFIt2a3r; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-930d9fdeb96so262841241.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760379192; x=1760983992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBDGX6PRnwkKDbG2N1uag2K8s9MQDp6R5zmbaCCPIKg=;
        b=lFIt2a3rAPTLgwTWPP0IuTZa7Vh/Mevcn0ZhO0M478Q9VbAL2r1RbKxrsmHR5laKdU
         uAJY4NtKHPMCPqEZKAdKzhUha7qbeq5XQ5r0yzcdR3+/Cxt2J6okd1E/TUqa+JIEuN7y
         rMON/lyE+3Ws1ICAegk/jYGDvpSGUt6tkREowbydYcA/LZ3t9RgZVp1EOsT3xZaL6xNr
         QbWWCBtnVesoU08NPGEfWjNxfyLtg3n+cSF1qAD5Nzp7xU2yeEWxGZ6rfN3NLA02vMim
         vo14dYUqu5CNrEA3VQeisfEq8o2dN47pIKnz4S/g/P+cCbykdNL2A6YPNuRqXpUxBIgM
         ZP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379192; x=1760983992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBDGX6PRnwkKDbG2N1uag2K8s9MQDp6R5zmbaCCPIKg=;
        b=hjIwk7AGrev+hYDyqe7HcHaU52JpAhYmTM45j2yBnpCDwbLFbChPaOt5UGrw4/ATJz
         DilVJUBJRQ4Do2c1FnShzJrQkPcpEu7CYmQAHgCoFYdsq0fnzoFVn+fxP4vdPH2EfsyI
         jTV4riMjCaML1JQLmCLJDIr6C98OTqEARXvx9TepewkczTxGSaNOxW1VnnfDq3TN2jg6
         MYNEDKBna2wuxlRuAWzQetU79gtnAy/cSYHYoYKDZfJTgytdrSbuMPof8uiWiu7XRtl5
         0ibbId1oouX3VHXzjXNC5LWQOY748zkvmr1J6bfcU1hJu7B/N1ebnrBLv7sTM4Y4H01v
         6k8A==
X-Forwarded-Encrypted: i=1; AJvYcCXQnd/l51uzzGkiQuKAz06hNK8I356wvQGacJOgs/kMHEu7+CMpaPQ8sVdNKena9AIlFIy693xiQmc9Ino=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiQeHcBGpBahgKZnlITUnv5KGnVDwGmpgdKXN6kyeSUFIzAljy
	iEVG70EWxvAh2YU870i4M/khrg/GEdM0z9B/QBhI55K54h8gujG5xvfZ5FkAqK1WBSprBQ8QJGW
	dGZT3+zkmyW2o2TyOGHNNks3t42hqWa5wTA1CkPUU
X-Gm-Gg: ASbGncvOGdLGuUJJPk1kliyUfS2k1BLDbZcP7R5EluPamoG2h1fa+QX3DxMVflTsQu3
	opvUu0DVcT5+0UOl2paAy5pXjAHB0PKaZv1A8u8As0WFRIT9tzsQk3H1MfCOWbQc6jROSkg8ZM6
	TteCo4M98FYb5HIDRoW0ouQgpoqcZ6AWpU5oR4XdvlXYAVn2+yY8u7LyCOFxF7v1ghtxEKGuIuU
	/MXuRWUXZgp49clo72Bki9YR34Sz/SqT9ci1P7JiA==
X-Google-Smtp-Source: AGHT+IGKw1l0F5gWDhtAGsAbrwQ74p6Ay5ZWwKVORS1MVWNtBycDuWsd9eKy3nP4zO1syMlrDCis3sMsarbSEjEa01c=
X-Received: by 2002:a05:6102:a4e:b0:4f1:7946:ed52 with SMTP id
 ada2fe7eead31-5d5e22514cdmr6942540137.12.1760379191925; Mon, 13 Oct 2025
 11:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911185314.2377124-1-wusamuel@google.com> <CAG2Kctqf=Q+nuuDqzkrOpjp+tOttf079DS_R8Q0pHU-k8DmFvA@mail.gmail.com>
 <CAJZ5v0gtKmtiLQwi-2qaw2G4O4PF_iqz6UbUZuaknepcJ1ToZQ@mail.gmail.com>
 <CAG2KctrK0JrP7JNUyzF72JeDgR4-GSRmJDe+yEnav=gQCAf64Q@mail.gmail.com>
 <CAJZ5v0g_HXQjWfp=L0KetRCHMTD=QsP3wJKNZnadJic2yccCUQ@mail.gmail.com>
 <CAGETcx_Fn3AzZo7gNvJnPxy=CNHpqAviGdUrww++SGySuBcaZw@mail.gmail.com> <CAJZ5v0hbtHxFo_z2fp9DMRDi75k6QL-kcDHD+o8zabub1YdCKg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hbtHxFo_z2fp9DMRDi75k6QL-kcDHD+o8zabub1YdCKg@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 13 Oct 2025 11:12:35 -0700
X-Gm-Features: AS18NWCB-Biz5jvCAgmtrZo36zLv97GN145bed2sSqifeKMQMjaNvzx-gALNA5I
Message-ID: <CAGETcx_XFUg7V5KEGF+eqDtmhbUoufs8xARhaB0KJeh7Lzaj0w@mail.gmail.com>
Subject: Re: [PATCH v4] PM: Support aborting sleep during filesystem sync
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 11:02=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Thu, Oct 2, 2025 at 12:13=E2=80=AFAM Saravana Kannan <saravanak@google=
.com> wrote:
> >
> > On Wed, Oct 1, 2025 at 11:22=E2=80=AFAM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Wed, Oct 1, 2025 at 12:37=E2=80=AFAM Samuel Wu <wusamuel@google.co=
m> wrote:
> > > >
> > > > On Tue, Sep 30, 2025 at 11:51=E2=80=AFAM Rafael J. Wysocki <rafael@=
kernel.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Tue, Sep 30, 2025 at 8:30=E2=80=AFPM Samuel Wu <wusamuel@googl=
e.com> wrote:
> > > > > >
> > > > > > Hi Rafael,
> > > > > >
> > > > > > Just a friendly ping on this patch. Please let me know if there=
's any
> > > > > > feedback or if you'd like me to make any changes.
> > > > >
> > > > > Have you seen https://lore.kernel.org/all/20250909065836.32534-1-=
tuhaowen@uniontech.com/
> > > > > ?
> > > > >
> > > > > If so, what do you think about it?
> > > >
> > > > I was following this chain
> > > > (https://lore.kernel.org/all/20250908024655.14636-1-tuhaowen@uniont=
ech.com/),
> > > > where there is some ongoing discussion on converging the solution.
> > > >
> > > > Our changes aren't mutually exclusive, and tuhaowen can build chang=
es
> > > > on top of ours, even indicating:
> > > > > I'm happy to work on this as a follow-up patch series after your =
changes land, or we could explore a unified solution that handles both scen=
arios.
> > >
> > > That's fair.
> > >
> > > > These patchsets don't negate each other, so could we decouple these
> > > > two patchsets since they address different issues?
> > >
> > > Well, I'm not sure if they are really different.  After all, this is
> > > all about avoiding having to wait on an excessively long filesystem
> > > sync during suspend.
> >
> > No, it's different. We don't mind a long filesystem sync if we don't
> > have a need to abort a suspend. If it takes 25 seconds to sync the
> > filesystem but there's no need to abort it, that's totally fine. So,
> > this patch is just about allowing abort to happen without waiting for
> > file system sync to finish.
>
> OK, thanks for clarification.
>
> > The other patch's requirement is to always abort if suspend takes 25
> > seconds (or whatever the timeout is). IIRC, in his case, it's because
> > of a bad disk or say a USB disk getting unplugged. I'm not convinced a
> > suspend timeout is the right thing to do, but I'm not going to nack
> > it. But to implement his requirement, he can put a patch on top of
> > ours where he sets a timer and then aborts suspends if it fires.
> >
> > > I'm also not sure why it is being pursued to be honest.  Is setting
> > > /sys/power/sync_on_suspend to 0 not regarded as a viable option?
> >
> > We do want to sync on every suspend. So, we don't want to turn it off
> > completely.
>
> I wonder why though.
>
> If suspend/resume works reliably, syncing filesystems on every attempt
> to suspend the system isn't particularly useful AFAICS.

A lot of people's entire digital life is on their phone. Even if
there's just 1% crash, when you look at that across billions of users
it adds up to serious impact.

Also, there are classes of devices where we do disable sync on suspend
(I can't share specifics). So, this is not an arbitrary stance. For
phones, we want to sync on suspend.

Also, your question could be posed equally to laptops too. If suspend
is reliable, then the laptop can always wake up at 3% battery, sync,
and then shutdown. But that's a leap of faith none of us want to make.
So, as long as we support sync on suspend, I think it makes sense to
allow suspend aborts to happen more gracefully.

Thanks,
Saravana

