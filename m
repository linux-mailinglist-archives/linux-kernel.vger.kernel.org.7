Return-Path: <linux-kernel+bounces-733071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC5EB06FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEFD189F683
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A6028A1C8;
	Wed, 16 Jul 2025 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b="E66Mh1Db"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A1427144B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653035; cv=none; b=TAKKDtI1keSMVtlWEB9UNvlpTUyrcDeBWavNDwTbLCGJSrzVC0rexQhqea+0yAsOWSqfrhRXJA6q9IIy1Vv7eIxcWAsQCqcZmuL8smFOXCMvNOcRwXVnovmqcdPqAlYxS1fXgJuoJfgXPGTAA8BVb6WJkDKt7b9Vzb1ZuI1ZWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653035; c=relaxed/simple;
	bh=PWyG0Hvg1POxl02CDV5NXpcMX19Ft9gYgcFyl5hDkns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jf0o0+etbeK8MBOSPstFoPKukdsydEEnp/nD0GyRrRntHPzL6j4aT7ZwcpoeSaj7rru9nCHEEdrCW3eu3ii6PrBjoWedg3ndOZQ1QoIry1GsZLCFYiq1EkT9BIFIkbb+kmY5m5B6nPGogqQWrCY23So5x0/EgH2ET7ma6LVY0IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com; spf=pass smtp.mailfrom=qtec.com; dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=E66Mh1Db; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtec.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5344894a85aso2763564e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google; t=1752653032; x=1753257832; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PWyG0Hvg1POxl02CDV5NXpcMX19Ft9gYgcFyl5hDkns=;
        b=E66Mh1Db13FNw8d3pIhYvoT0UW6wSZPIUYAySSGh23CaSCg/1SmqaQdUABhT4eETms
         jMAI2amU2J9JAvuV4qzlCRRRJZuIt+CQEZ6WeowH6YT1sn0qmvQOjwPyVDIMkCiZ3cmV
         mH1g2vZy7G6+TVh+mDyYoDAcj3yp3/WLrELWeSJ2eqodTvFkUgXnxxvSvnmynb8dDi4C
         RZUU6Wqgqr01JKKO3PDpiUOIFoyOtNITJERTXWYtawyKDmNOyl2bl1TbyxJgAeH0G3Cq
         faB1YGlh75JII7Y+ft3MMo7waDZxBCSrL7rVwnWysb0ETeVJKhJLgrSCZoywLxXVPOC+
         HUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752653032; x=1753257832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWyG0Hvg1POxl02CDV5NXpcMX19Ft9gYgcFyl5hDkns=;
        b=bLmL5zlQIfk3nsVVBLdyUOKBVnh6lrCvGZF5V9C84GOKQB166XF9ci7Ckme10E9nQ7
         62Ar8WbApFxryd5gyQmN9qtH828ejMBeBSWy91ykq92gXQ6qwD/rT2ZQ32TkVSnBs97o
         hnAxBadLBmziYT3ziNe6POB5D/IOL+XqtZmu6IMzEcQvYNeLE/y9pt8FsM8SGhWB+w5U
         ArB0hnp/negzTRyQtMjB01ZqE6YwoErUGGSE1qHsSZT8kR0a6BdMHeWNHIrsH1ydOhCb
         ZkcBMMy9Aov6CCcUhSZhGn4xWcT0pwF0ZnfgV99YSDQ0WiLgiwbICDYdDp6zvLGN5KUY
         cfpA==
X-Forwarded-Encrypted: i=1; AJvYcCVd8T+l8qz1QmbN4nSpU/OzxQhd+Ar/LcjKriDtSe3rRFDNcpVKCH0+n/7a9h4jCqxiEsa0yyBah7FTyBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7449DFy0CsNhlXZ1tQOQmMObyYPWWFaubEvOZUDAcFiYvaKnt
	h5C/6bqHg6Exv96ByfsEofW+mMIWIbcRqWrkjCmOPqJN1JnznZwBUwbhruZcVSh4y3buhow1SV7
	GMznUDld1VfcCqAtHFGlcPYC3TBq3N1I1PWGRNjglMA==
X-Gm-Gg: ASbGnctemcJfgG3MWGyJcTklAjsZ8FnXa9LWYxnXboSBkP4uowHNumUw7xMNmf1KeXS
	1Cq8XIyW7dCdXaqL9fNL1MDGAb8OnEG3bNshE6uwN9cOW5uFXZmTCagk9LRcYt2fagmngd6ytJM
	83CbqTqXaX0bzryZ+vgp4HWd/EKHIx37Qf48MKKJUobeYCAxhDKqkDyPSbTGGacdYO+QsNPg1dm
	2HwzDNI1G1FbxmB
X-Google-Smtp-Source: AGHT+IHuTp8Oe9gp929kW6Hut2cz4zrvspJHOxYdcWVKQbc+cNKYd+ZvcRbFGDU68t4/pUeH0eIZfybUIGS9src9Xjs=
X-Received: by 2002:a05:6122:2492:b0:535:aea0:7a0a with SMTP id
 71dfb90a1353d-5373e272f46mr1343232e0c.2.1752653032364; Wed, 16 Jul 2025
 01:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local> <20241219164408.GA1454146@yaz-khff2.amd.com>
 <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
 <Z78uOaPESGXWN46M@gmail.com> <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
 <20250621145015.v7vrlckn6jqtfnb3@pali> <CAJDH93vTBkk7a5D0nOgNfBEjGfMhKbFnUWaQ1r6NDLqm0j3kOA@mail.gmail.com>
 <20250715170637.mtplp7s73zwdbjay@pali>
In-Reply-To: <20250715170637.mtplp7s73zwdbjay@pali>
From: Rostyslav Khudolii <ros@qtec.com>
Date: Wed, 16 Jul 2025 10:03:40 +0200
X-Gm-Features: Ac12FXz0TL7qGwSyQ1mpiWrm6IGZDPvVlKHX_1XmAYakRfQ93gQ8h2JQTcbg__o
Message-ID: <CAJDH93uXuR8cWSnUgOWwi=JNuS543mHLPJb9UUac2g=K4bFMSQ@mail.gmail.com>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>, 
	Borislav Petkov <bp@alien8.de>, =?UTF-8?B?RmlsaXAgxaB0xJtkcm9uc2vDvQ==?= <p@regnarg.cz>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hello, thank you for information.
>
> Just I would like to know, where did you find information that the
> EnableCF8ExtCfg register was moved to D18F4x044? It is documented in
> some AMD specification?
>
> I did not find anything regarding this change.

I mentioned the exact specification in my first message. It's under
NDA, unfortunately.

