Return-Path: <linux-kernel+bounces-761384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9620B1F972
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 11:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C241899488
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 09:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA63D1EE7DD;
	Sun, 10 Aug 2025 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="B2mm2CTL"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D778F29
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754816910; cv=none; b=A0Ifq9NTiBK5bGj+P8hwQF7TXpiY0T1iM3afPSsk1YH1o9lTtXMeygW110wuYvHtKZD5YAR3aIJxXlrIJ8wzYdh1xXlSBVdKktLeG1VoN+233TbH55yrImz3hE2UIzDfXSipDR3MTLeU996WRjHDYIN0m80gDOOLOwRDejHV3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754816910; c=relaxed/simple;
	bh=NqrJcDK9Q9Pbwnv9mkT1gvpoDiy/onKZKuiEiMl6Esw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpiXSs4rNEmwGIkP5uhY7KbrU02VfTWUr62jPXF/uUGR/WmqOwGQVSPwzO6fm5Yac71SNYxDJdK6xD8FCVjg9syj+R3Nz0w3KZ3PGcXQYSFbRWfSJnf/UfckPzRoccjKqR4PepK65k3ludcMp4LdaOrAznd/MTs88uUsHrj2JjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=B2mm2CTL; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b46d905cb67so133573a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 02:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1754816906; x=1755421706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XefKmLNL7nnqmo+5yH2hBjHjtzORSbfHYnDOv5fvrSs=;
        b=B2mm2CTL2ihy+Ec0lj4cIlqD8W1I9JAXNg5OeBbR1lh4it5aM6bQMk7MQtGhK7U85O
         kVDDQcoqx3PXdlBORGfna9HQRT/VFjXpmW74MEgKoYhthT3tmh2ees9z4SkSW5+kvWrA
         +hwtDSXOk+sgZrv5fBRtxC5eTUl+jvUhDdqjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754816906; x=1755421706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XefKmLNL7nnqmo+5yH2hBjHjtzORSbfHYnDOv5fvrSs=;
        b=uaAqYpxu1cmor2jE3h+83YU3GQjejWX8ePbj9IFHa4ROFtSHyznXVGfHwV3OOxHA9D
         YTqrypLBvPUaMl+6wz9Rb3qm4L3m1qh3ZMcG7ynYkYo7k0v+Rv4EDPMYE91uJIaLpceV
         08+8j3WqMCPTVSxbSzin5hagNehJo+II07wlQNPLw1PCgxlGQN+FwQLays2fhP2A/xdp
         AHapnMUlLQ5djaSJ/GDUP1i/t5t/ySp+1Sh3ZOVbr2wm8R+oeL5i/gtY+SqTUuYOv25X
         jMj+RULgwf+S8988tEORm0ZE4uD/Re1Rml3MOF3ip534Yg8nMEhFD5CL65YFtGCcDLR+
         f0QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC21UfgMLjGVHbppwP0ep3n1PpUaiMQhp4pmV81lX9E6CdcgHf3gFVtxf9XtN2hDTCRHk3eV6KpPYTPdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/2bxto3lMF4XkBjdnO/qo4FGKOzMzcrNN2MTrGKHqt4sdLNWi
	D/QtFWdvHUNtrygHXL8U11zcgBDOp1q7n7rs0qEx0zy+3eB/NHz59ywpr8i0EtsiNfyNRZTIoRg
	RbjcrUkoxqO7WhqeWHFhSbi+hTVN3Fn/6QIYrQuJXTQ==
X-Gm-Gg: ASbGncvJ+im3g8u/M6UWZg+TknVkFRwpAuj6tkyUC8rr3xFPZSXDVa+9U4dDphoq8Vw
	mqhv9BtKgVB1Jy1L0eAc6dP1O4p+H/V7ibA97R6FAngZF7G27ck2Vu+XkhnMW1Ary2Ayi8ZwHKr
	GxNAglQS6DodsnSO0fd6kdxKHsGrF4eNoDvQZ1jKLLSuE6udrmbLkUMatFXCJKqseAGVu78dr4j
	m8VuzI=
X-Google-Smtp-Source: AGHT+IGgxGY8TIGss+p+m+rvdoCroOkrH0WSwlEH1yu+EbvcphNklaPzY6Wumaxx6GRiOOtAmCnqSI1I1Q1UxJRHVLE=
X-Received: by 2002:a17:90a:ec8e:b0:321:9462:49b7 with SMTP id
 98e67ed59e1d1-32194624af4mr7997024a91.12.1754816906402; Sun, 10 Aug 2025
 02:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250809015529.373693-1-daniel@0x0f.com> <5dd0a031-dd7b-4078-b1a8-6b760248390b@t-8ch.de>
 <CAFr9PXmF-AOL8yj9FntHw+b1A8HWKNeAHU=rx7Dk7pfi1N_4fA@mail.gmail.com> <d7974cbe-41b3-4994-8982-30c8f660e65f@t-8ch.de>
In-Reply-To: <d7974cbe-41b3-4994-8982-30c8f660e65f@t-8ch.de>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sun, 10 Aug 2025 18:08:15 +0900
X-Gm-Features: Ac12FXzKlx-ot3OecZiA6JO8-sqa2rTE3ab_yidKsy8cX4VcNGeRieYae9c2z9w
Message-ID: <CAFr9PXkJCPm9UwV8-FeZxhB+ODxGgtbKdD3n90UjqyPGF8tMSw@mail.gmail.com>
Subject: Re: [PATCH] m68k: Add target for lz4 compressed vmlinux
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Sat, 9 Aug 2025 at 21:29, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> w=
rote:
>
> Hi Daniel,
>
> On 2025-08-09 20:35:39+0900, Daniel Palmer wrote:
> > On Sat, 9 Aug 2025 at 16:50, Thomas Wei=C3=9Fschuh <linux@weissschuh.ne=
t> wrote:
> I would continue with vmlinux.tmp. It might not actually be stripped.
>
> quiet_cmd_precompress =3D PRECOMPRESS $@
> ifndef CONFIG_KGDB
>       cmd_precompress =3D cp $< $@
> else
>       cmd_precompress =3D $(STRIP) $< -o $@
> endif
>
> vmlinux.tmp: vmlinux FORCE
>         $(call if_changed,precompress)
>
> targets +=3D vmlinux.tmp
>
> This will also correctly handle CONFIG_KGDB changing.
>
> (Maybe the naming can be improved)

Nice, that's a lot better and I've reworked my patch to do that.

> And for the compressor invocations we already have predefined commands:
>
> vmlinux.gz: vmlinux.tmp FORCE
>         $(call if_changed,gzip)

I also did this for all of the targets and $(call if_changed,lz4)
results in an lz4 file with the old header format[0] and 8MB block
size which is not what I need.
So v2 will have a patch to add a helper to generate that style of lz4
in scripts/Makefile.lib

Thanks!,

Daniel

0 - https://github.com/lz4/lz4/blob/dev/doc/lz4_Frame_format.md#legacy-fram=
e

