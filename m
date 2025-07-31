Return-Path: <linux-kernel+bounces-752487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6143B1762E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36442179B06
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D485255E4E;
	Thu, 31 Jul 2025 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dLqEFEVh"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA0D2505CE
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987535; cv=none; b=Sd/FpN0L+ZxO7ivQcJx8PLnvRmaSBQgJiPozQYGf9vQHumCnN0Fs5w2WUh1vu7XYjru1TSj7P/DhV4BduWSF6DR79VI5D+7e+vOaq9Ct0ZGYJmDBuHTEy7/GapbsOEC7YZjI2lre2fKZ4DwlqwixcnZO9DwsFkeR21bT2VcHgUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987535; c=relaxed/simple;
	bh=3M3R7EJrFDhwkCVwc6/8EJmGfdEDBNCXRwUt8aeK4BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QM39DsId+99h56j5Ac+KKj4e1f1xMKjeEeh1oZRf8yB8fy4T0CeTde2Zuvyzh2Wt3N48lVFWiOPLOcKzIwTj6xbhCABwyxIvZiUfxlfXa9ICF2KYnUCEA2+SRtBA2seXvtitxI2pDtM0GtSjq1ljg/lXOJ4U4YBIPzsKwBcH8VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dLqEFEVh; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0df6f5758so19140466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753987531; x=1754592331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PzncSLckPmbRbvc5UgW2DQUgu4BP5imhDPkvKTb7j2E=;
        b=dLqEFEVh+39zDciQLMfw8KObvjCE+ah8lReupPLB8oPudc6DeWeB2Yfsj21HADKMRz
         JivzhHkg3bVcFd2pN9A9mftmkXpOprk3N6GRXgxg5jEO6a7uWj4s7ZjVG61U5PuZEDBt
         RI02rP+menFFd5aLd57dLmiOGjXZnETlGyKF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753987531; x=1754592331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzncSLckPmbRbvc5UgW2DQUgu4BP5imhDPkvKTb7j2E=;
        b=NJ7Gec7ajcjmxR8EJgxMLWWQkgnRUhGPsmzWrgGzQbLNVit33AznPRLdq98bZVFfc+
         azxd4y2KJgDAiexUKqSpwfkLQ84HhK90iHMSTZZ97rrjYSyOpCUuKYq96i/pracqjb19
         i6xKnxkspxx1PXSBxkQ30mDnji6Wm9IIIWrkC0TTgbYy+UiRzFl4f6N/gHXp7fX+CH73
         u+KrD4LZ78rtFyrGn6ceg/H2F+y243LS7mVH/SNKU7Bgu1rEMmrWlYrzWujnfZxH0pu+
         +dDjT1MbWjc4vYHzgJ8Wwh7siB82UofvjQ5jnHEpoTouP7Wn8Vsids4xbmtXVdaaMHZ1
         OUag==
X-Forwarded-Encrypted: i=1; AJvYcCX6tOmVUK5ioc0K7qkkm/Tq1A/MTW+vaxghpX0VVcfVIWUtsw3WubWiz/rd1uPvb6CzADAalC8U9nKdSxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxArfHxDphF5QOq1iddllyKB/1SKuz+sPNc5HUUcq9x6ghbKY0i
	MBwEeMstRwnU750i9naBEN2qqDzlTOrTvfesi1u6MpHruXVHMfk4AwuhcGIOr0o+5aHGuTVScN8
	/NtGmH/Q=
X-Gm-Gg: ASbGncvyQG4UnKOtOikrZtdhOBJk8arF0+wr3lJfAmGdjoGy/TyzP1t766KxUo6AQzY
	C1uQmx3Zn2JAgnLQDYo1yqUvv9AafLmWSpd86wZB6UGEBQXTt3+BDFL5iGspQ0sDVN5EhSYjWqH
	5MXMGk/D+t8Go65DNWktKfzUtq+dmxlskVXitiLeqFoc2drdQzQb/YGynySBYasaRpOiD658u5n
	bZtZUs+fFF8eepmsbNE7KUPQ445t0MlhLbi/FjaPj2q9yBgjCpReVsfNFnTLN8Xz+Y84AX/eQGP
	Q/a0FDTZ56E1AGCdl7vDdglz+tlOB/9tmn84QpEtlgnwL50Yshl47u/OgfDYwCceN2POiz7IVJk
	Jhu3kI7RqvsaAJTC9VB8F9a6l8eNJtqrb0yWhzPm51b8bDMyMUzkV9lKA8X0BPItXqirLfClh
X-Google-Smtp-Source: AGHT+IH/pvRSP2L6faBIuVEcVzkNyzyGEctZzDzwziTVaZh4w9XwlM4VFURsU8MkJDhVZcAKMJrNCg==
X-Received: by 2002:a17:907:7eaa:b0:ae0:ab3f:36b5 with SMTP id a640c23a62f3a-af8fd577d6bmr948644366b.4.1753987531536;
        Thu, 31 Jul 2025 11:45:31 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a218cf8sm151266266b.95.2025.07.31.11.45.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 11:45:30 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0df6f5758so19134666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:45:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVc4n2MkxXMp7RdGiyJpOMvZtMstnXh0GLxWDEjiwvxlz2UW5W50+A7SKZG/J+cj72UWtkLATWYBv8T5+A=@vger.kernel.org
X-Received: by 2002:a17:907:60d3:b0:af8:fb0a:45b4 with SMTP id
 a640c23a62f3a-af8fd6b2174mr998226166b.18.1753987530275; Thu, 31 Jul 2025
 11:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729201441.GA3322910@bhelgaas> <20250731181132.GA3423684@bhelgaas>
In-Reply-To: <20250731181132.GA3423684@bhelgaas>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 31 Jul 2025 11:45:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_zZwg3k1QnWbttz+qFTxwAO5aGAut3Z21cC_0nK8LeA@mail.gmail.com>
X-Gm-Features: Ac12FXwhANou0M4tFKH6KhOnLhPbVU-YB5JXS0xrsgoWuoPmLJf_2ap-oCGxMxc
Message-ID: <CAHk-=wh_zZwg3k1QnWbttz+qFTxwAO5aGAut3Z21cC_0nK8LeA@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v6.17
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Gerd Bayer <gbayer@linux.ibm.com>, Hans Zhang <18255117159@163.com>, 
	Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 11:11, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Gerd discovered a regression here on big endian systems.  If you have
> already merged this, we'll fix it with another pull request.  If you
> can still ignore this, I'll send a replacement.

It was literally in my next batch of pulls and was lined up to be
merged, but I have dropped it from my queue and will wait for the
replacement.

              Linus

