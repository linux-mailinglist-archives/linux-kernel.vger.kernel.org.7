Return-Path: <linux-kernel+bounces-878449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB75CC20A07
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D30B84EEEDC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A3226E6F5;
	Thu, 30 Oct 2025 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM3mZNsw"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2C2258EF0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834847; cv=none; b=JR5dNTeZT1r//L4/kPBxuNAlvQ95hkcRHml/6AmS4W8zl/eGXJW6DPNXG+7FuSpy2acEam6mFmj0IQXibGs3I8igYe8BZQMmvMv1TaecYWHhluYmxyVQMGUTzvZS0I0c/EzNTpF3fNZ9JZ6Pam+ahOkI2KEq1mbrA3SAU5qeCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834847; c=relaxed/simple;
	bh=odh9ZxKKeGxYrq3EK8kPdZn1pd8MMFHTauQdcNpIKh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMDf8FwnhV3NL189+lp0RUjVsMG2Wb0D417p2uL7tl+hH/v4JoiJqwi2boBygYrdZ4fHEuwO5QKUKqQ/av8QoI4AnHHb0aJxJUMTBD8p/5PD3YK38TQcYvwsdm1wF7Nia876mkkVz1GvK2kJWBCTMGh2ON/u8B7ByhxGlf88mpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TM3mZNsw; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-427084a641aso935775f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761834843; x=1762439643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J38IhobkxaN2Gk5WbXyUkF8oPumsLrjm7BrbGyCEjLc=;
        b=TM3mZNswH/pguQZkn8ioHHVODnxw9hlcW0bTOG0Ir/PuozJXsbTBb7sdsIIYd0Z2Z9
         6cDa26SRGmLaD6e35tkey1gK5I5qQ/GybF/IMzjwsQ+Iwr/BliHMCFzIOkuZzdmZP1Rw
         aRQ8B1dgpr1hchPCWGUzpEDBPGar9NvjN7s16Pm11/vugOH1J8mAbmdNwU+TzKPPbSEr
         McuYcHvh/2JYC8SmimPX6Iwo6ucA69V4rL0Y6qFdDX3UE+XssoPOeKojrBM8RZmsx/5H
         oDhJvxzFraVnENGSwuTz2EPxQrvfbjSxvajI1jES5rJEqjTarpApaCpQEWUU5h4OX0++
         ZiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761834843; x=1762439643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J38IhobkxaN2Gk5WbXyUkF8oPumsLrjm7BrbGyCEjLc=;
        b=XiHX5onr6uH8n8xjbOekC90iPNMPbb0UsurD9cjDcv/tR35H9GR23D8+IjNsnvpJ14
         s1DMXEr70oDzy2R8TnIWrN4PkWKVQjr1Ybyqa6Gj1pjvrEv41ABfw7Ynu55sQsyYMHS6
         AWVRmqLGvGykzClzid7cWWvkrbzwD9Anb7pBGz5XDGnwY+NTSTAhMeGG7GvA5FP7162F
         fcahIjOo46MeCUBg4aTutysGPQ6KFWDxYJIZEfCq7oWCE2ERzhNjXWZY+jtZVYPurV5I
         9BLZFeqdZxjd1uA7QF+KUZ1RSV4EmSRAS00Wmrg8JTnk3V6PEdGtatV7ZOQ4V4HlyXBM
         IEAg==
X-Gm-Message-State: AOJu0Yw0W9pcK6tKC5GBsSnBa0LjA3MGs7d52w8rI5nrvOxFM3NeZPuL
	3J5bIMDzaX3bTilVwVA9Goylvq8iYRJXECjv1gW+qCdDHLaV/aAgTV/qiCYn1Q==
X-Gm-Gg: ASbGncsl24Y0K/NjXaPEOYUwNvMaRGPGdTAPMa2Dea9zTmbtYcOj5TTdFM5uYQez1Fa
	zqGXYntlyyGy6XKx1bCmkErjAZKU5xBjlGsL4+EJ4fwsCKTkZca+ZZcVvOQvWincR3TkQS97+36
	ZRbsn6P3YgyQKE6D9G1sPG6aCtOrsLJOL7tq+xVxaM0qKXPMaOvkWFHEm38zFz+4c0B7Gu1ax6e
	UGfNR9dAdGA+JYk5C4cTW4TTvez82J7qsoGasJJVVnNKXkR70ELzaOkjacED52un7TyxevudHK6
	6AfQ69gcUkqvJDR2rZhbsIf+RMPgdHxGmWD54ezpVM2ugZ79X3yDPC9B8aFntTgc5MnUTMSWVtK
	3YQOVe6z0frrcRoaaUwfL2nSeb48S6V5OCN1uQnssOW3/2DCY0DGwbpxrpivkPwyZ14YOURPdvs
	1hvNwEmP9SeXn422GebuUwIsBlLHzHtyA5GFVm5C3KDH6XfUIjj1kJ
X-Google-Smtp-Source: AGHT+IHI8r6Y5Qu6MmO0KTWK+ZhlblvTiwEj554fnahrKlI6MqsZ0iz5RT8A1I2OMGLDjALtaKdYTw==
X-Received: by 2002:a05:6000:480f:b0:429:b958:218a with SMTP id ffacd0b85a97d-429b9582382mr1643853f8f.28.1761834842625;
        Thu, 30 Oct 2025 07:34:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cb7e8sm32732992f8f.19.2025.10.30.07.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:34:02 -0700 (PDT)
Date: Thu, 30 Oct 2025 14:34:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Kujau <lists@nerdbynature.de>
Cc: linux-kernel@vger.kernel.org, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: maple_tree.c:3738:1: error: the frame size of 1040 bytes is
 larger than 1024 bytes
Message-ID: <20251030143400.09fc0a89@pumpkin>
In-Reply-To: <769dc761-3ea6-76b9-d6a3-cd64a3fddfe3@nerdbynature.de>
References: <769dc761-3ea6-76b9-d6a3-cd64a3fddfe3@nerdbynature.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2025 14:35:12 +0100 (CET)
Christian Kujau <lists@nerdbynature.de> wrote:

> Hi,
>=20
> while cross-compiling the latest mainline checkout for x86_64, this=20
> happened:
>=20
> ------------------
> $ make -j24 O=3D${DIR} ARCH=3Dx86 CROSS_COMPILE=3Dx86_64-linux-gnu- \
>             CC=3D"x86_64-linux-gnu-gcc" bzImage
> [...]
>   CC      lib/maple_tree.o
> lib/maple_tree.c: In function =E2=80=98mas_wr_bnode=E2=80=99:
> lib/maple_tree.c:3738:1: error: the frame size of 1040 bytes is larger th=
an 1024 bytes [-Werror=3Dframe-larger-than=3D]
>  3738 | }
>       | ^
> cc1: all warnings being treated as errors
> ------------------
>=20
> This is basically "allnoconfig" with CONFIG_WERROR and some debugging=20
> options enabled. I found 44081c77e8a4 ("maple_tree: reduce stack usage=20
> with gcc-9 and earlier") where a similar issue has been reported before,=
=20
> but this was 2023. I'm trying to build this on a Debian/13 arm64 system:
>=20
> $ x86_64-linux-gnu-gcc --version | head -1
> x86_64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
>=20
> Git bisect pointed to:
>=20
> ------------------
>  commit 9b05890a25d9197e39fcf5b2298f0b911c323306
>  Author: Liam R. Howlett <Liam.Howlett@oracle.com>
>  Date:   Wed Sep 3 15:00:01 2025 +0200
>=20
>     maple_tree: Prefilled sheaf conversion and testing
> ------------------
>=20
> This looks related, but I was unable to revert only this commit. I can tr=
y=20
> harder, but maybe someone has an idea how to tackle this.

Does marking mas_wr_bnode() 'noinline' help?
Some functions are marked noinline for KASAN builds, the comment suggests
mas_wr_bnode() is one of them - but it isn't marked at all.

I'd try an unconditional noinline first.

	David

>=20
> Thanks,
> Christian.


