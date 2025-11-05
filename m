Return-Path: <linux-kernel+bounces-886699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08439C36515
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A590F1A27B36
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC7933A02B;
	Wed,  5 Nov 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXd0cDEk"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FA033A01E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355530; cv=none; b=ogCzDwZfumPKG3RSIP9Io2ESswtMhI8q4ccx9XrvZFBnraCj8GKh3RkiQBqc213PfpGFON7+KXRK9xKgbPD+lGo58DF8DHPnjVrvzIGEMOdcvkX6CZ6H523Tx48wSg4qhszIwblvO7DdeL3Pb9nrywHnOlWbrTDnn14TZ/itcX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355530; c=relaxed/simple;
	bh=aXYLUN6000x0NsONU2t3i/H9bdmZ2SlZPiI9xwpFxnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4d9LkkCEFyv+818z+R8ljbeF8glw7X4i0kWsTsqsMbkPKRSrbIh+z4BLbAJFagw6DS6bwf+KqNMJ8zHu+h+oRljaMwPPab8pKcfJGc3fWeB093YTABx6xg6oSv5PQAO7EkMV6ykL5n7uL64VclJaMKVdNaywM3ccVtf7E0QGKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXd0cDEk; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-654e25cc7d7so3037471eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762355527; x=1762960327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXYLUN6000x0NsONU2t3i/H9bdmZ2SlZPiI9xwpFxnE=;
        b=FXd0cDEkNZFZ0zTj6OocZtHSZYFgwHkqxGFHPlPXzEmYCb2R7EyUJKcW0pVndIbmgV
         isDLRaSJpVcddQuwjHB8hVRdh+cv5+r8lx4d8BHTzTfMwRADt+72P8o0KH3ZxBURfbAv
         kfskYMad8xvxN9HUAWIqVrwTjHkSTuAmXO/GvdJnecbUp2+QTxEo6piyod83uiCDAGqj
         jNyK+8Y43dMpTGkFYxh5j1PPeuwCGF6oGWeFdLJCy+mdfLStwMBAWLCAqyXWH6P17ARs
         xkJoI2IiYtZwCt3ZcmOnfZlGP4AIIWm3cSeE6k2zOCiOx/6aypS97pYawiItj5HkWxs0
         qTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355527; x=1762960327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXYLUN6000x0NsONU2t3i/H9bdmZ2SlZPiI9xwpFxnE=;
        b=ru+N2LnwmJkpIX92JjOKVGAD+1+6+CPE/2VEHgmhUPmCVETevF7KVC9BD/U9OEMjcY
         s1Ez9EDgItMqlBcYXZAPgVQPFul7n6wKoqobq3ojiS1t8eKMwbFuZuNPNvNXr5PcvxZp
         3+PBM7fuhdl6G7hodBEmnvqqyphkSJj33KOTEH09HJkIZQWKaRFywKCNcEBMrS2bQ0vN
         Q+7zJHs8KfG3hh/Wz9Y3LRdsp+9OAEKny8jloLHNmX8bUrB4trJXpMI2GkLjE5UAcGLu
         GriQZAkCQ4neF3i1bs7KNoUdUBkEK99lxwpDi898HsEfeTOnbCdra6CbkvhjxdxU57to
         71Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUYoUwm0ZzROqau5MxspYap9fPYRURiuA/0LW6ltbdYMHrleQj/HFrDmHa/ry5n81s06XhaA0UleNqp5MM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyob/gSo5TIsnSHDL09EyGmJnXhX9LwuSGoaCJRtM3A9Ecrx/VJ
	xQCcCs4mrIK5uHfBcpSRlB94GimQZYOdbRrR3S9uhsv5A3FN55dP3hP8xQ3/ZbkXjd8Z05rfDwl
	3jhXQApZHpylOVUxUnNP8vcsYHWBEsec=
X-Gm-Gg: ASbGncv0ydc2unB3DaroYD2y5p/7WF8iuT7NPo8icwEzWNZDqIVwotuRY+alYsgev6Y
	4+95EKi6+Ekz1nK3tdLAXLGNa4Y7NR3/W/m31qlHaDfNV8i7J77wH2F8I7PHtyCbtgII5VNs0X3
	smoqJRrShMY/c1pSqRqZT1SF6i1Ty18S85g92BdomELGoE2c3mPr2I6KUqEGj5t+/2I/GsBf/+u
	CaVbGYMAA5M/jkiJbsUSXahrn9Aop7/3cs5D70Q3Xc9JJ+H/TQCkMhGkObcfg==
X-Google-Smtp-Source: AGHT+IGpN3cph/fTvH9jq+KRBNqMTr6RA5v+48m8NpKXPk/rwPyh4Vcq1cEfPxDOj3gbU9uNlFul82BSyE8W2NvIdis=
X-Received: by 2002:a05:6820:188e:b0:656:6e2f:628c with SMTP id
 006d021491bc7-656bb4ce08fmr1557691eaf.0.1762355527268; Wed, 05 Nov 2025
 07:12:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHRbhAkDcYQj=VQrNdc7T7WfDfiuDWpnk2s3pjoeouptgy_K1g@mail.gmail.com>
 <66711258-dc14-4469-bcb4-d341f4572488@opensource.cirrus.com>
In-Reply-To: <66711258-dc14-4469-bcb4-d341f4572488@opensource.cirrus.com>
From: Iakov Pustilnik <xyapus@gmail.com>
Date: Wed, 5 Nov 2025 20:41:56 +0530
X-Gm-Features: AWmQ_bnwQdwMX-icaH0OpjGc8Kgg4eMBoQA1sDSRTI1pAys6H15oQSEV58qBkYc
Message-ID: <CAHRbhAm5B7s5DScs8tMVn+kEWG=HaEC7FtPRH0f9RTFS5RHixQ@mail.gmail.com>
Subject: Re: failed to add SPI device CSC3556 from ACPI in v6.17.x for Cirrus
 Logic CS35L56
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: david.rhodes@cirrus.com, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Richard!

Apologize for not finding it myself. The custom SSDT patch from that
bugzilla ticket solved my problem!
What a great community! Appreciate what you're doing here a lot <3

All the best,
Iakov

On Wed, Nov 5, 2025 at 7:51=E2=80=AFPM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> On 05/11/2025 2:13 pm, Iakov Pustilnik wrote:
> > Hello to the Maintainers!
> >
> > I'm using an Asus G16 GU605CW laptop which has a Cirrus Logic CSC3556
> > audio subsystem.
>
> Duplicate of
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D220152
>
> We have been told that Asus will release a BIOS update that includes
> a fix for this. Until then, there is a workaround on that bugzilla
> ticket to apply a custom SSDT to override the BIOS ACPI.

