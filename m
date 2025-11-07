Return-Path: <linux-kernel+bounces-889771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BA8C3E7A9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 06:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C650A4E2CD5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 05:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D184424A05D;
	Fri,  7 Nov 2025 05:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi2O3Jbe"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD1318027
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762491764; cv=none; b=lPZsfElJLZyhv9OuMtDsler3K6SoW7BPedR2W6Nnyn6lT3dt41ZI8RK9peWjGPzR1mx2qPcXflEYLPKzH7Oo02vFC6dt/9c6Rpp/4ire2dansaWFky5XKgaGu8yY4vAcPGnoPoP3YW0hcqDrYzE8vaCoARS4ihtLQvf9pAydWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762491764; c=relaxed/simple;
	bh=K/570kVOABpxNWUETUYfvu1aPCwlcAjbLItwdY0GNbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7iHhD1ssLxTHiWMdP05Wecq9Gsv7RE/QaP7FjFILi21me1qrrTSgMzBrAdqnUq+L6KP2OP0oSoZVfMaJz2vfCY5Rtfi2JK6hXVU/c96Adtv95QhKIn0foKEQ7F8ZsRLw2tZ7n5Dd+SwYEuSHOwcYSc7OMc2E5yu/I9wE3S/aWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hi2O3Jbe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29633fdb2bcso3736315ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 21:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762491762; x=1763096562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/570kVOABpxNWUETUYfvu1aPCwlcAjbLItwdY0GNbA=;
        b=Hi2O3Jbeym2bggYPEgZhHaYPJO8vp9OnPJH2gdY9wsxS8z1DKmRcVfLYFmqERYbLVe
         tjhDvHL0Ilcm2TzIYxRhaRd1E+aJsReL45gongHhMqF1YcPP/MTe6GKrYmL8nA6KQ/0F
         KKXEC67nYATTN8QKqYfcAqOONl9zgMAtx7aMixhIQHVfMN87GHwTd4jt4lbeMRQ8aneC
         RXse0Zr539X588niBwAwRDKdpcsdWB/Idq2CdPArBkdK3ry3YyN2JycYm0U0LkgbHctE
         q1paei9Se/tT8e0DBCmnW/x5kBvd/bMtoPziL6CTKfYidPdcCjKkiFvwYF5YYETFiWic
         6mtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762491762; x=1763096562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K/570kVOABpxNWUETUYfvu1aPCwlcAjbLItwdY0GNbA=;
        b=UNUkasDeTXRS9lKtkWryudJGEZ0JSmlGmNeANiBA4AUwgmueo+ksExuqz/IbCON9BZ
         Vn44h0LjZ6k7ET6+S4nI/DCqJZTOx+JuQDOaHMbbYNy5Cbwi3Mg8vu7BEDGdqfvWJWDm
         fSoXUzHvOrgCsWNZd7d6GdYgnPMx1rXfJ4aPuNQRK+mOfpNAfG4IkZELUnme2ToWWiwZ
         UqU5DookCmMAzOV8g2oFPHuNmvnm1UPaFQ8ryR3qHrHmx4qzA9/CylAzngiJw8MHN5M/
         BHflSieBI3xKy36wNcZzb3OYxEgxHI6G2V6B1Qq2VjHf1SkV1kIaKQYm+k0271VMJDaX
         5KmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMMtjmY7n3XSzyd+F4D+oEKtXNqtyn1oNikn5jeUu2unBgSMBBsj+DLmYUYZprF4EDeHCWkw8ZRcUOCw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9oz+91RAeDKbRrOaWbdX0pJccEWuln35sJXrGsxc7eh1jr5cK
	sJ45PQCOS9Zv3EXijJESnDRkRU8f7gItlez2/iKm86PHklnO81hFvHZVA0lgWiEwIpXmwFU+Zfq
	2UbKowLbnleWXwCIGJV55PnLas70UDmKi1w==
X-Gm-Gg: ASbGncsoi1E8OOgoql8ltZX/By5H8DvwQC69C0xgsS0GBkpmoEO8i1f0cSOU1CWB7j9
	NPatcMsW2a2IIl9jOXFXLiH5lTkUDdKlHIfAG+ppEMXtzUAFQC/g1fJejWg7bQxGajLIaxDoIsP
	VJxQlG1+ul9Wz0tgY9Z8p8NPhHkSd2agbMN053CUNHuRZ4S8MwrKY68pw1T+iR6q0qOOdC+tEhK
	5QjN40QBwHKuiZym+AsOxzsBg6PeIs7PTSqDrEKFUlnW/tO00sMeAsy5WSxJ8pLTLeUov2jhNFX
	d+KtSaCC9LGAwWqELs0=
X-Google-Smtp-Source: AGHT+IFkTy6bthzcml/gWK5hi6r0GHQfrOqeahZZUlgBhv5ohTM7S7Kd0pM2PbsWeWHGExIwfHF7rV3+1BrAdSjcERE=
X-Received: by 2002:a17:902:ecc3:b0:295:9db1:ff4b with SMTP id
 d9443c01a7336-297c03b71c5mr22942675ad.4.1762491762059; Thu, 06 Nov 2025
 21:02:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101052651.6197-1-opensource206@gmail.com>
 <959ac74b-a8b7-4d4e-9d34-3b3d971f9f8a@linuxfoundation.org>
 <CAKPKb8-nFzqgh+k3aBxUvZ8g28usiAt5BEdFDQysVnCk3S+sEg@mail.gmail.com> <c64985f5-f1e5-4880-876d-0a3c9d83629c@linuxfoundation.org>
In-Reply-To: <c64985f5-f1e5-4880-876d-0a3c9d83629c@linuxfoundation.org>
From: opensource india <opensource206@gmail.com>
Date: Fri, 7 Nov 2025 10:32:31 +0530
X-Gm-Features: AWmQ_bkB1gZgyHljOZHhfX6ld4J6AvQVPtB7Mr_H8pBdlKriiKvm9XNpxJZqZIg
Message-ID: <CAKPKb8830YHuY=h662wPVPvTz3LcyLio6pRDy9ZGStkqwu_Vdg@mail.gmail.com>
Subject: Re: [PATCH] media: vimc: add RGB/YUV input entity implementation
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: kieran.bingham@ideasonboard.com, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 5:41=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> On 11/5/25 22:03, opensource india wrote:
> > Hi Shuah,
> >
> > On Wed, Nov 5, 2025 at 10:43=E2=80=AFPM Shuah Khan <skhan@linuxfoundati=
on.org> wrote:
> >>
> >> On 10/31/25 23:26, Pavan Bobba wrote:
> >>> Introduce a new vimc-input entity to simulate a color frame source in=
 the
> >>> Virtual Media Controller (VIMC) pipeline. This entity outputs RGB888 =
frames
> >>> and allows testing of pipelines that start from a pre-processed RGB/Y=
UV
> >>> source instead of a raw Bayer sensor.
> >>>
> >>> The patch adds vimc-input.c with basic pad operations for format
> >>> enumeration, get/set, and stream enable/disable handlers. The entity =
is
> >>> registered in the VIMC core configuration, replacing the previous tem=
porary
> >>> use of vimc-sensor. Frame generation is not yet implemented and remai=
ns a
> >>> TODO for future work.
> >>>
> >>> This change enables link validation and format negotiation for the
> >>> RGB/YUV input path, paving the way for software frame injection and
> >>> test-pattern generation.
> >>>
> >>> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> >>
> >> I see 4 patches - are they dependent then gerenrate a sries
> >> with cover letter explaining the changes you are making.
> >>
> >> thanks,
> >> -- Shuah
> >
> > even though all 4 patches are part of vimc driver,
> > these are independent patches
>
> Independent in the sense that they can be applied and tested
> independently?

Yes. all 4 patches can be applied and test independently

>
> thanks,
> -- Shuah
>

