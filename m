Return-Path: <linux-kernel+bounces-841508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6232BBB78D2
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EC854EB34B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F08F2C0294;
	Fri,  3 Oct 2025 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="asnvuUgI"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135F82C0296
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508920; cv=none; b=Ch1ru9+FurEfqmN3LOHoQI6ZXbjQuqow8wNglhu0B5wJumFCRCNdRwEfbPxAhEPzz2rKHunGo5JUMzf562cHD6sZ5+5wD2ey5nHFliZp8+slnP1MGB3IKX8fmhjBThPwIZ8SKno1MXbl7uj16wuy1+VhR46zMNGjw9mNUvOvCJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508920; c=relaxed/simple;
	bh=cwz04LCVXZfN+AY4Qan7hQEjgfaTBfDS1fi9Fkv3U1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwAYGJ+1/VM960D5cnDCg5vJ8A0a0kJQSNBgtN8xVlw6k1CnXUkSmbfl/fLhTktxGPHtC9647mxgjgUiUc5bnAvrLMBEipxuiDL2iK2RHC9ZYFJKxksN0LNTmzOhQX1AyS03pEIEU9FQWGK1hzoxoZFd3DL1H8XvTdM/PlX/8Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=asnvuUgI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8572d7b2457so276547285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759508918; x=1760113718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwz04LCVXZfN+AY4Qan7hQEjgfaTBfDS1fi9Fkv3U1k=;
        b=asnvuUgIJjQW1TanNasuRjI68hE/nnrni1rN3PR2na11AOQUVszaMw8psQjJb4fNnl
         ee4VmFQW9feoia5QiAeYH4K8Y5dAcp5/EmhRGekaU21Wv6h6DMJsAJkyTDUg2EUEbkiZ
         IUWMGsEEBJk0Z8sydOPTiKw9k0Cx0MOLnHX7yHCx3luDRo4WdY6oEkLmolAWtUGrQqm3
         eAhoH7dURIfPCUG362VgTJ29H0FdZj+N2A1D3TWH4xMmiXgofW6FKFBiqA/XjigNmAA2
         GTcV5+b6gnbf18MPeuXxA/56YHvU0szvnaPGdImqRJwWT/Stlk4dAHGZEIejnPFDwm9x
         wDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759508918; x=1760113718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwz04LCVXZfN+AY4Qan7hQEjgfaTBfDS1fi9Fkv3U1k=;
        b=WS4LCddGj1oOlDTkXhH7bi5gIvTAXTLiYKqsv0srGV/d94PRFVJ0WwFAn2TKObVNe1
         CwvN+cwSTFipNjRze0xyhWjTyU9Qp2h2AtTNx5NYT/v9QOM8dCSEl5jBgvOfJ0V5EoMj
         7HgywYxBF/bLxmq+xnANug1sLhKPpMq8jrikKXkfuK84zk43DO0RZMOwfmZIrpxzK3b4
         hO1650YbWtVa+hThMgL76exNEvGZeMVa0qyUL2QzhB5tfT5r5RcfOhL2uMIcbS3rLl1D
         Ehrnrss5at5ltlPWel2NODxMlCPEzuHfyp9116yWzRQr+Qy4c5BPdDoYWmxTTC08RH69
         6Tbw==
X-Forwarded-Encrypted: i=1; AJvYcCVQEChBogdqaj6wn47x43FeSfFHe01/F5+hRfnPvu6iHnoPjnLyGcMqqX7SsotaA+doLQjP6MUD2KwA5lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvYu1/57ZWVo4pPkW5iFzUsrV33WKagr9NPV+ylOqx3R+JR4Ka
	bV5TTUrRXAlySko/yPWn5iFUsJBiV5bQzhWGmbyUAB42C985p4yHm3EliwWICdnQGARQeIfdy+O
	nd4K1sT1RrhvRmwrSSu4d+/a5c3cs8YjWmYW0O5HwqQ==
X-Gm-Gg: ASbGnctKdVeTEbZr1uCwJ4mTuZ3c/V8vZNO983Naq+kVAEdvh0pctqkIZk0F+D3N8hS
	KOLoVo1OBka4rp7PAja0vVm43gooq6apAmOE8lUPpwuKEVRHEBqhAKKWkWiwgO5G/ntQWYJ3kku
	J86BXftQyn0riNP6ju/lN/VG8HPnYEmmnh63mNmNe8lPnhGUwCvMDeinU0LsuHb4ni6WnGoBk4c
	zUxclhzE+wcF7AnQoqkhtYIKzjF
X-Google-Smtp-Source: AGHT+IGRIixVdtmeOFjO118a8JrECEI1Y4RPdInhz/esowkW/CRBGY/zsPPIbjs9YJ/9fXBRw/M8yAQgEqAmqYkP/Tc=
X-Received: by 2002:a05:620a:4004:b0:85e:95d9:8997 with SMTP id
 af79cd13be357-8776d89ab34mr1063023685a.43.1759508917927; Fri, 03 Oct 2025
 09:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929174831.GJ2695987@ziepe.ca> <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca> <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
 <20251002232153.GK3195829@ziepe.ca> <CALzav=cYBmn_t1w2jHicSbnX57whJYD9Cu84KJekL0n2gZxfmw@mail.gmail.com>
 <20251003120358.GL3195829@ziepe.ca> <CALzav=fci3jPft+SXJ6tPG3=jRX7jjJPwnP=zWAb2Sui++vKPw@mail.gmail.com>
 <20251003161642.GQ3195829@ziepe.ca>
In-Reply-To: <20251003161642.GQ3195829@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 3 Oct 2025 12:28:00 -0400
X-Gm-Features: AS18NWC4qysxRWQgrKLz5j3weby2D_QNJ0TOooL4n65xeseqNhqAU98HM21pC0c
Message-ID: <CA+CK2bBLuGAMwVgj87p_H12P9yy6J99WwX8vwZbFfY0RTYsXDA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Matlack <dmatlack@google.com>, Chris Li <chrisl@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 12:16=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Oct 03, 2025 at 09:03:36AM -0700, David Matlack wrote:
> > > Shutting down enough of the PF kernel driver to safely kexec is almos=
t
> > > the same as unbinding it completely.
> >
> > I think it's totally fair to tell us to replace pci-pf-stub with
> > vfio-pci. That gets rid of one PF driver.
> >
> > idpf cannot be easily replaced with vfio-pci, since the PF is also
> > used for host networking.
>
> Run host networking on a VF instead?

There is a plan for this, but not immediately. In upstream, I suspect
vfio-pci is all we need, and other drivers can be added when it really
necessary.

>
> > Brian Vazquez from Google will be giving a
> > talk about the idpf support at LPC so we can revisit this topic there.
> > We took the approach of only preserving the SR-IOV configuration in
> > the PF, everything else gets reset (so no DMA mapping preservation, no
> > driver state preservation, etc.).
>
> Yes, that's pretty much what you'd have to do, it sure would be nice
> to have some helper to manage this to minimize driver work. It really
> is remove the existing driver and just leave it idle unless luo fails
> then rebind it..
>
> > We haven't looked into nvme yet so we'll have to revisit that discussio=
n later.
>
> Put any host storage on a NVMe VF?
>
> Jason

