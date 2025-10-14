Return-Path: <linux-kernel+bounces-851880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0750CBD783D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E212E407085
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAAF30CDAE;
	Tue, 14 Oct 2025 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWdPOu/Z"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCC930BF52
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421876; cv=none; b=sAlnPTuByBYS4mtum4V5ETfos7VerpTI6Yu58yb3acmNxKSn8WZpQR+KyobXwHjcSUuuOHFfNxNptHLLqWqfdGrqFacDZ/WInTDCHXu6o95rtMBz+Kqr40mJ2nS/9asmCE9c2JtyV5B2V/R1j9X9uNu0FSkmyzoDUL3m7Qwv6oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421876; c=relaxed/simple;
	bh=tv0xd/ZLUTxahGhqv/v6XY8qJ/8QWSM/jWNbbSekNAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVlVNdZysYZ4gKXN1oMSxaE+DqjRPNtY3Ym4gpS0ybgw07H9aCAsY5BneLJnM0AUW0vA3ggAOA2exGaZr/tzF/LuZ2SNLZxcHrD+IHiLcaLT0AvKwuWFDCAdAgOY1rFDen8LCeCIJtpFWb3/vcAdbz9q3sLyGtpE+3GcQRnKFCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWdPOu/Z; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3306eb96da1so3881304a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760421874; x=1761026674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzZuo7NJ/DlD6SoTWD70pPuh+8rHqp2AyadzZH5QNao=;
        b=lWdPOu/ZNgdIRmt3s1GU8nzMUufS5orl0aFEZDpsNrFFxMZ1aktwrktG9Mm0gNqVJS
         ZsH5P2gOaZTSUASdOcgNppZQ16uvad+PgYoEl1W38BSVi+DjmW0D2VKZV3jxx+RC7hdp
         UNhz84Wp9th9+so84DBjujtRhssnAQ5E06h4LWVuVnwjttbNr8lEIhO61yMHf6zUy/q9
         DRneuFReD5qgvX1aCrrSMoWfoJ7+hXff3DPUp0LnDMSgBo0xOpKvD00Tzb0PujvsAspj
         c7+UvUSE4OB8EWvHjcfs7w/qvUdawh8cDViXP/oJypuwmcIujhlDhFQcWjcSjUl55+lG
         Np1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760421874; x=1761026674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzZuo7NJ/DlD6SoTWD70pPuh+8rHqp2AyadzZH5QNao=;
        b=hx4SjAqPdzESj657C4vTglPidQRv8iODUlU7YdfxYbYY7KGuC+1FqUV08LV5tO4WNj
         1FJiJO1HwIDbaCGVeUHZf1Os5vflwmj9hgYC6iwDd+TrAHmgcAd+5FuUuhuJSGRezlp4
         1loQ5qUSs1PuurzK6jI6pW6HxBeKrb0PRFROqis9qCT7rkLXrGmS/dDJDnuROtNWF7B/
         Rk16JBW3/1saJDII2NXMgs9KIAc8jzxZ7/nbNhzdn5CouMJruqvYILMtY3RECBAkRDA5
         1+Z9/sA9t40hAyODX8xPM7mN3V9PLioFaVIkKAT5XVMaghn3u36n/mMBqlbRZUij7GZs
         7rog==
X-Forwarded-Encrypted: i=1; AJvYcCWSRi00+hSeoy/c4lMpTtMh4M+C3RFsb7WTSwmb2hII1XevmJg+2gJIqpvRpjXGd8BKX/8a6rn88do+WjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJrgzaBB1Py8tGdSK6EtPC735qwB49Pg4edMVpTUTzr2KJ5hsz
	N1zLLwWl5TWLe83/r0vFFWQpYJnCcSL1rw+gr3tYoLIK03UL0hfTpwMJT8qIKYwR7z+owvqYtZz
	su7tgOgmDU+M6IMP/waqRy1mHwGCOOfM=
X-Gm-Gg: ASbGnctZsRPf6mmVv8PNiP40bgG3LbWPaAvOZluKur4RUElaLtbeElEkNXFguPvWOAz
	Qai7/3j5akrd96qw+Mq2NYhV+LFZqL6wkgULzERltVOehEB+nr4U8piPhJ3xcU+3dNmmnLEwn8u
	hUw1LGVMG4L7iEmuzmyk6F75JVF4u3zZVYu2uw4DfjVXByjasAdUm0DZiniOJ5QD98WP2NKE25x
	dwMwIr9WCV7J8cvn3nU6u9LvRcLyKM3TUH+
X-Google-Smtp-Source: AGHT+IHgo+WYjqQU4SsdvUGTS8UzFNwqRmcAAWsiHyknSHfsOn4aG616ucEJLt9ZJx34ZiYRNEWMbDb0/kmXi44bPmU=
X-Received: by 2002:a17:90b:1d06:b0:32e:2c90:99a with SMTP id
 98e67ed59e1d1-33b513b4b51mr35056966a91.35.1760421874366; Mon, 13 Oct 2025
 23:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013134708.1270704-1-aha310510@gmail.com> <20251013164625.nphymwx25fde5eyk@pali>
 <CAKYAXd8bhyHrf=fMRrv2oWeWf8gshGdHd2zb=C40vD632Lgm_g@mail.gmail.com>
In-Reply-To: <CAKYAXd8bhyHrf=fMRrv2oWeWf8gshGdHd2zb=C40vD632Lgm_g@mail.gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Tue, 14 Oct 2025 15:04:23 +0900
X-Gm-Features: AS18NWCJ1qNnENzazf89-ZHRk0M4-ND7Pc4CWd_uJJpk98z55XLeWA5G4CpXXIk
Message-ID: <CAO9qdTHLEEDPWpZeWBq5Awn_wrcpfcYFK4Hhr=AohOhWpQDRcA@mail.gmail.com>
Subject: Re: [PATCH v3] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Ethan Ferguson <ethan.ferguson@zetier.com>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namjae,

Namjae Jeon <linkinjeon@kernel.org> wrote:
>
> On Tue, Oct 14, 2025 at 1:46=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org>=
 wrote:
> >
> > On Monday 13 October 2025 22:47:08 Jeongjun Park wrote:
> > > Since the len argument value passed to exfat_ioctl_set_volume_label()
> > > from exfat_nls_to_utf16() is passed 1 too large, an out-of-bounds rea=
d
> > > occurs when dereferencing p_cstring in exfat_nls_to_ucs2() later.
> > >
> > > And because of the NLS_NAME_OVERLEN macro, another error occurs when
> > > creating a file with a period at the end using utf8 and other iochars=
ets,
> > > so the NLS_NAME_OVERLEN macro should be removed and the len argument =
value
> > > should be passed as FSLABEL_MAX - 1.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D98cc76a76de46b3714d=
4
> > > Fixes: 370e812b3ec1 ("exfat: add nls operations")
> >
> > Fixes: line is for sure wrong as the affected
> > exfat_ioctl_set_volume_label function is not available in the mentioned
> > commit.
> >
> > I guess it should be commit d01579d590f72d2d91405b708e96f6169f24775a.
> >
> > Now I have looked at that commit and I think I finally understood what
> > was the issue. exfat_nls_to_utf16() function is written in a way that
> > it expects null-term string and its strlen as 3rd argument.
> >
> > This was achieved for all code paths except the new one introduced in
> > that commit. "label" is declared as char label[FSLABEL_MAX]; so the
> > FSLABEL_MAX argument in exfat_nls_to_utf16() is effectively
> > sizeof(label). And here comes the problem, it should have been
> > strlen(label) (or rather strnlen(label, sizeof(label)-1) in case
> > userspace pass non-nul term string).
> >
> > So the change below to FSLABEL_MAX - 1 effectively fix the overflow
> > problem. But not the usage of exfat_nls_to_utf16.
> >
> > API of FS_IOC_SETFSLABEL is defined to always take nul-term string:
> > https://man7.org/linux/man-pages/man2/fs_ioc_setfslabel.2const.html
> >
> > And size of buffer is not the length of nul-term string. We should
> > discard anything after nul-term byte.
> >
> > So in my opinion exfat_ioctl_set_volume_label() should be fixed in a wa=
y
> > it would call exfat_nls_to_utf16() with 3rd argument passed as:
> >
> >   strnlen(label, sizeof(label) - 1)
> >
> > or
> >
> >   strnlen(label, FSLABEL_MAX - 1)
> >
> > Or personally I prefer to store this length into new variable (e.g.
> > label_len) and then passing it to exfat_nls_to_utf16() function.
> > For example:
> >
> >   ret =3D exfat_nls_to_utf16(sb, label, label_len, &uniname, &lossy);
> Right, I agree.
> >
> > Adding Ethan to CC as author of the mentioned commit.
> >
> >
> > And about NLS_NAME_OVERLEN, it is being used by the
> > __exfat_resolve_path() function. So removal of the "setting" of
> > NLS_NAME_OVERLEN bit but still checking if the NLS_NAME_OVERLEN bit is
> > set is quite wrong.
> Right, The use of NLS_NAME_OVERLEN in __exfat_resolve_path() and
> in the header should also be removed.

I'll write a patch that reflects this analysis and send it to you right
away.

However, if do this, NLS_NAME_OVERLEN macro is no longer used anywhere
in exfat, so does that mean should also remove the macro define itself?

Regards,
Jeongjun Park

