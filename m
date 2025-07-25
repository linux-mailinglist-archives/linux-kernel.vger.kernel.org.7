Return-Path: <linux-kernel+bounces-745448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 691EDB11A24
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B04227B9205
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AC717D2;
	Fri, 25 Jul 2025 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlZJkZeS"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEAA2BFC73
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432948; cv=none; b=assSBHVbgC8Gz0KMxGv14uaRXGMdVjJzuNTPDVf1KrpT3YgZiN3MKfB6qHH6xrvB18l5XjJxVKT/U8KOYWKEPJXV8U9HGAjURALPIHrVxrjoBamzaSwO0KEjHQnG4EuieV8Qs77H+vs+ZcwDLg3oIypJZ+AK/M037o3xmNN6nj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432948; c=relaxed/simple;
	bh=0VdI9Xfav68u9AfVX5VANCV5qkHLL0bR3T+28mB9B2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1n3sxr2avjyfSOUyPrzLYCgn6qNHhYFr462eOeUHzCd+eP+/mfE5MlHa4E4sKxzuitQzIyi1nUX9LCEVR/6PC8rNj8QlrrOZ4/DcQwlOdmRtnICF9bxtbsO63y4jzAof2udjj3dQvN5daeIiy/r72HDDQ8rsKKzujvgwRpdJhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlZJkZeS; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2ea58f008e9so1378999fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753432946; x=1754037746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RtRwewxpwq6wdbx4qVBSFtRxsYRj3bEn6apmzcYXc4U=;
        b=BlZJkZeSamDr7CwWUNmZ4jyEBph4w5kpOiXqDCuTBn8hGCERnzcrCqL/KOR6MInKI3
         lo438X7H6snu8zXTHolYBfM9x6EAOKJZHgfdNftFwfRAyuTbJYZ7vOJ/MPgLxvBABfT9
         AXwvfDFE3Z8F6vLGHF9bd8Nc0q/MYxIIM4yE9+xg5sydO012imRpaarvEUknSc/zkrRL
         rPh6z7U1dMNR+zMbEqn6aT0bMJ+I2TnKaCVy5y9ttR5LkV7/T7wBNs/EMc0Pg1+Wn2md
         QxVgBn8f3gL17RyYKZQ4ewjSfHrx6rO0Bc/9PGlc+/d7WntFKH3dAwKBayRWLQugTBAM
         gYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753432946; x=1754037746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtRwewxpwq6wdbx4qVBSFtRxsYRj3bEn6apmzcYXc4U=;
        b=vRK9roHbo6wug8S8g3chsQPYeLWVXylH8AX0to3vThcIWBHQTPGLNwYEqD0+IgZ7uo
         oXsmrSekfrMxuD2pD+eOnqdkj7H4CejZJsGZRS9yHlaTDcGibFlttUbe5VKnMQkNJL6b
         SBBfe41vBFVacGc6y/TIzqGi8xDPQkNo+IOOuYj3HdKva1cGGzSuUUBkmNGpMdya9EVX
         Ql7fDCuQ2MdbSs93AXSHMkmSOUpGfnzWOt9idQ97l7e++0Awys1XfSc4Bxhq9mwk2vYD
         muSr+Tfc81SS8zl6MN7hrJGjUMRsQ3wtlbH90bdDLfmrJk6ADB8FQjUCFTCzPbGtAQIE
         E8Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWX2+5H94q4mKcGoO9IK/3xEwQzzBDWvWDyj6xlHKwm4sOYhj7Qph2SE68rY+EIq5C8CwbkxJ7CR7zLCsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy/JGlUCRZQ0GemYTm5DXUosNfOx8h3CEZLz1QTLmXZtNKnAGD
	8MPmVmjPwQdz4LSCfjzJPV5rPzwE7aChbKp7TRzyUtukNW3gsgbPC6Ky0+CH5f2BKjABn30hi3Q
	ASv/ljv5Dmx26nO8zjplN55jtZ20pJuw=
X-Gm-Gg: ASbGncsxYgqfPbGURu+t1jEvmfs1thokYMJJqdDHhDIs8XAxeq+sslqq7aB5M6pZ5f4
	0bg61BhkCaoOKoegZLbIuDgxwpwOUMinJ9V2kP9SW0USkXlNhZ1xonJQ/cnljP6eX/PthnnLIjl
	CVBbqKBt3ToLnBiKZLjF4BnR2d94/fVNC1yrI7kQvBRyiVzziU0IWYw+IEKqiVl0ZQ32V3CwCmy
	XEtVIxlfYOTRcnQO9c=
X-Google-Smtp-Source: AGHT+IEVFljy3riv5EFfk3X+lUpRuFxZgCwOrvFCvupN/y94Ps1Jz3V/M3D+xKgRnuMZ/6lDOnpaj2GSxOEwWjj3QCE=
X-Received: by 2002:a05:6870:6591:b0:2ff:a6d7:52a1 with SMTP id
 586e51a60fabf-30701b95dc2mr743859fac.35.1753432945740; Fri, 25 Jul 2025
 01:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724165639.13926-1-suchitkarunakaran@gmail.com> <aINB80UeE9pqKvrC@arm.com>
In-Reply-To: <aINB80UeE9pqKvrC@arm.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Fri, 25 Jul 2025 14:12:14 +0530
X-Gm-Features: Ac12FXzZNc1wz0lfkqTulvOvt5tDVpytLFbz6qy0ZVkM2HN4QImTHaxW2rcRyCw
Message-ID: <CAO9wTFjYnNAiGXqczPMgmCMno2Y-T5GCmgBgjGfDRbEcvsyNhg@mail.gmail.com>
Subject: Re: [PATCH] arm64: allow NR_CPUS=1 for non-SMP and adjust default accordingly
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Jul 2025 at 14:06, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Jul 24, 2025 at 10:26:39PM +0530, Suchit Karunakaran wrote:
> > The arm64 Kconfig for NR_CPUS previously required a minimum of 2 CPUs.
> > This patch changes the minimum allowed CPUs to 1, enabling single-core
> > non-SMP configurations.
>
> Do you have such single-core system?

No, I don't have a single core system. I've just used single core VMs
using QEMU, etc, but I don't know if it's equivalent.

>
> >  config NR_CPUS
> > -     int "Maximum number of CPUs (2-4096)"
> > -     range 2 4096
> > -     default "512"
> > +     int "Maximum number of CPUs (1-4096)"
> > +     range 1 4096
> > +     default "1" if !SMP
> > +     default "512" if SMP
>
> It's been some time since we forced CONFIG_SMP always on for arm64.
>

I'm sorry, I wasn't aware of it. Thanks for the clarification.

