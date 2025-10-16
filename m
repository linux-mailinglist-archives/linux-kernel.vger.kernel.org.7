Return-Path: <linux-kernel+bounces-856132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A19F4BE3302
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 507224F4BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2923231CA47;
	Thu, 16 Oct 2025 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8M+ypII"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B02741AB
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615553; cv=none; b=ROGZ+yZEGdbHoNxjoOfjeEta1qx5VypiW7mNbn0EQx9yBdU5w6h03erECAtMdGOI6XrXYHu8DajettydheVfBp43Fd157F3gFfk8jn7B71KoWhdyTNbU8ugZffggyE6DqmGFHThjZ7MaOO+xqM/8v+8fvAYKSTPmQmVqxo2NZ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615553; c=relaxed/simple;
	bh=mC+9tDBrABDE/IJ+3G93YVagmcCQSUndMoDjtVKH8do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTr4XHNfHBJwZVHZ51nHGrjFn+Ux3ezEiz6l+E24Tt9aIdcYIB9JTAItCBcgp/tesT2SgVAX/zmDULH2dKIVrhVKNsiERsAEqOWZHiTUwTaNRCfXNNvlXnkqLjaC2z1/Qmcjc18i+k+Ejow6tLplCyfcVf9DHTvnCIOja6fpQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8M+ypII; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3c917ea655bso411193fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760615551; x=1761220351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mC+9tDBrABDE/IJ+3G93YVagmcCQSUndMoDjtVKH8do=;
        b=M8M+ypIItBI7oRThWFl4sOdAJoXP6jcdl+tQ9PtmRACAEJprF9ihfA2WRBjumA02M8
         XhI8WpisQIPABUk93jne2TcGkjnnCUyK+0V82itEbTEUgHMSy/6bVnZvr8ggvG4W7AWy
         9wjxuRjKkgzmW/OSczTylqNDZpqMHW3IQCaxMMOR7PYZ+7HbhAWLWZ5Bapfefb3Aw8qv
         4ycVv9GWWFlnfj1vHiiCrPN7QMPUUCXuScAHx9ZG/FSYwFVju1oGS1sp5/eg8qBprCqQ
         gXrbTGNTZkwy6oytA9gYElOhy39qOso2y/6mhLcXn1TI+5wU55xDPmPH6o74+X0z3ZvJ
         kKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760615551; x=1761220351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mC+9tDBrABDE/IJ+3G93YVagmcCQSUndMoDjtVKH8do=;
        b=CG52nX3MfjJOuNMmGfkJy7tfgM+tPAAJExxgtUVvw/fXQZ9+g+4U0RvcVfo4RAFxsq
         9zNjfUBwERQdTGnHYRPqcuSJmHGnjrJcLU+Y0tng8G9mhEOFF7AFkCSjmAtnW8jhHdQa
         CVcbpt3uMXzmTPtdCs1LPVKmgWMj6O+NFw0gV9c7PvxDf0qE36YHbEMqjNp6Xx4mT4A5
         2xnGpQb931/hJSdjadTsW2tWSopXE1HkA5stiCALNW6zewxrqTCpgJaM7Kdh0AFK0Mi3
         7E5hFgUo8zToC37f4JEwv0Ri+2pbWau2Nn6K9jijDeLH1PHq0AOf47rQkNs4YWMf1KOK
         +E5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDyy2PLJ+jcMwwRGfNvde3RRzC6zTEP9KOVKMmneXQa/3SZiOuolxNSAmhJHQVk37yfoMTIicOAfjGl7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0rZhxVW0qoEstkiE2rSCOSRoxPcpIrIT7a1N/BnBo9nitGTGq
	ghBEs1J0/zT1GSNnbR1xwy/Gwct8e+LXp4LK9XVB6S00TAyquC5SJPYohOuzFOeJDq+RaSXERQQ
	5LJfjuadjxnIA8UmMiwoqnpGddTv6VVA=
X-Gm-Gg: ASbGnctvqIj1sL2xpCTo6wvLARHHIaDpBa3L5ofKs7kR3CiEVrfQFDFHxdej1n4aaVt
	R1YkrXuRKwdpfO9MaTIXCvv5UgDLk76jtltuMTMSyjXtGoskVVFLqVVYYqTB/JWbkQADHg0Bcra
	iFGQEe4AEQBXJ7gYeCbhK2iLLg9ljjXEmd5oHrASJWCYwR3XKTsZjzcj8P6ulTrdW2mNgtCCYSp
	yeOewONIK48glh8TGC4bNA5AibkZXD40m1FE91AkBpDFh0AwXicHZAUBi4sGQ==
X-Google-Smtp-Source: AGHT+IFauwwQS3WETtyLhzy44iD48OMfA608HyRDHXmXr5xDQLt9tlht985FKph/VCC9SYR1RyZpln3F5+TQqJplHjM=
X-Received: by 2002:a05:6871:81da:20b0:3c9:7398:51c0 with SMTP id
 586e51a60fabf-3c97398642fmr902024fac.31.1760615550975; Thu, 16 Oct 2025
 04:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013185645.yhrtn64mwpfom7ut@wrangler>
In-Reply-To: <20251013185645.yhrtn64mwpfom7ut@wrangler>
From: Karim Manaouil <kmanaouil.dev@gmail.com>
Date: Thu, 16 Oct 2025 12:52:19 +0100
X-Gm-Features: AS18NWB3B3V_JmGbFkguEBUx1ZHqqCPVgptVO3r8ni_Q_BkPMq6dhfTbp54BDYA
Message-ID: <CA+uifjMUQS+nkaDqGnm77tLG38k9ZYi-mcF2eqpOKHnaF2Nvhw@mail.gmail.com>
Subject: Re: Which amd cpu families support ptdma and ae4dma?
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>, Nathan Lynch <nathan.lynch@amd.com>, 
	Sanjay R Mehta <sanju.mehta@amd.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey guys,

Just a gentle reminder. Much appreciated!

Thanks

On Mon, Oct 13, 2025 at 7:56=E2=80=AFPM Karim Manaouil <kmanaouil.dev@gmail=
.com> wrote:
>
> Hi folks,
>
> I have a dual AMD EPYC 9224 on a Gigabyte MZ73-LM0 server motherboard. I
> am trying to use ptdma or ae4dma to prototype a memory management
> related patch, but it doesn't seem like any of those engines exist on my
> CPU. I loaded ae4dma but /sys/class/dma and /sys/kernel/debug/dmaengine
> are empty and I can't see anyting on dmsg.
>
> I cannot find any documentation whatsover online on those engines.
>
> Could you please tell me which classes of amd cpus support those
> engines? Is there a chance I have it, but I'm missing something?
>
> I am on Linux v6.17. I also tried to check with lspci. It doesn't seem
> to report anything related to ptdma or ae4dma.
>
> Any info will be much appreciated!
>
> Thanks
>
> --
> ~karim

