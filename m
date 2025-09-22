Return-Path: <linux-kernel+bounces-827822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE250B93336
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AD0167D13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356312F4A11;
	Mon, 22 Sep 2025 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSmaDQ51"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D540F2ECEA7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758572262; cv=none; b=rR1NjHOeTKro9WIAR5YsC2uD+Y5+DSTRlE7Oz4k9vLAtTPtFEK665d7uWe+lyMr2FcWOW7SKrF3b/YhgTPQNPmUMpnvh431CMdFZcsI48O2rD+YdKg6pUvt6Dl4h7TQtfBPEKbyv1FbUVE+lNu+A4W2EDBNreh3sPUeveJ6eflM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758572262; c=relaxed/simple;
	bh=nmtqbHU/w/B61zuLXPpSmmuVWqr/lOlDK84jUWG4zdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnWSNG5iw5ZXDOroNGb/wPStkaGSaGfnV0H4iDrcIO50U2DQZk6Jp35HGNYE0evHPlAdJDZoSFM7N9kbFr5NCTLP5JNrp14l01HmmLqPuYE/VN4lrMmcgO2Zn/OsooS1sBsUKNTgeWDjmR82tjTJC3AUyQmMG0dd/FTwNO7k8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSmaDQ51; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57abcb8a41eso491e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758572259; x=1759177059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FWtQpQUzJ9r+dDTG1AXpfBAR2RpoIfe3F7cTMYfaN2A=;
        b=MSmaDQ51fKyzm6PI1NTJw21GpO6V3rz8skHp0uPwapIEEqCT4rtgVz/caC5i1ugkgI
         T81temQRVCw5fAUKfI+KuIZqMESLl/Pd4+MOSMEBvOygVgRKZEefPD2c3lFbTRCmAKmZ
         HFf4JtUELBa+fdBNxuWEH9ama8zkApepJaGH2IrqAIQihpsLHKcsLIXlncw16xh0UcSP
         q1XKp069hDHU+V67oa69A2Q6myYMsMuh4N8E1Q0lYe80VPH2mRE3b/ciFKd163FfDoac
         yrRHzkZ0v0VbZou6usffI0LPQvE8H/xgbS0FGepru/hBIbOUHTo14+jyAkbZY83IG5Mi
         i7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758572259; x=1759177059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWtQpQUzJ9r+dDTG1AXpfBAR2RpoIfe3F7cTMYfaN2A=;
        b=fTHt/XePNLQ4Vgi5z9lmElBTF5ZXM2UxF5xICi/oJMryK3yvpvtzBYa03fzMqlIyUA
         Fz8GffoSa/cfj6s9jBNe00IcFosbzSaSAv407ovqD2j8x0inTKIdmcm5JbHP1uVgNjzO
         HyNpzqk683jTuIO0WuCYLSRRK+upPVjPP4OgDk/WuGdY11HWlDdkSMLjBCQsrgWAMTqZ
         ah2/CMGMD0cPtHsgjT4zWxBZka2p/7zZaVXQ4hHYv6fIl6FxT5stXxjYVdZ7ALLL5U1p
         NBbFIOHzwAzpHWtM6Tw3FKZGU82pyskPP9nchLcxwhf56OuH9MOE4bgO4xgpmj0zdLnO
         4qJA==
X-Forwarded-Encrypted: i=1; AJvYcCX+KGht1RdmDXJj2EXmVFp86Xe6qeNinBdCfI2Y7NpDVkH44P8Ox7++TNZ+QofSQ2mo+o1j8hZtclL86WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKSY6kNFEFkqVP8w1HhzzvtFMlwZBseosePU11rdIUwX8voL9J
	P4WgRK+FD/pk6QZPnMHZ5k8eW5RUWfFCtRoT/vWWVJamMak8n4zjyx7THPUcEHr1JTz6J/j1z+8
	QP8V5lG/cRi6V7n+SBtLVbrrKu19NVs5qDhl3MqHB
X-Gm-Gg: ASbGncvLJzvPmfKA05Qb9A9EPXmDJdo8Jh/Zuwa9dHVwGARmkYoe6bmwQVAUCKbdX4u
	E9dusjoiP4OwibiqCOoR8E1/syE3EfJWGda4VsbZr0RDwP+GCVIw8dPj5hGHZIv5zeskjUt7rxb
	6nnpWB9uY0/zl35qndm+3A1zhhRXFuTZ9uVcNu25jUPM7OooGBFFBYt2yf3yZmNIiPernTVEW1o
	Lmfrrso
X-Google-Smtp-Source: AGHT+IGj40k0Zzp2Zts4gKKxfvVZo7SESC+oB/L/7btr7Jz+gFTswsnF97s93sXgwzMxhRFPeFiftbI656ORBiYokwI=
X-Received: by 2002:a05:6512:39d6:b0:57b:43e0:ab17 with SMTP id
 2adb3069b0e04-5805f834784mr14939e87.7.1758572258627; Mon, 22 Sep 2025
 13:17:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912100015.1267643-1-gprocida@google.com> <aNF7bMbCLctgZQXq@willie-the-truck>
In-Reply-To: <aNF7bMbCLctgZQXq@willie-the-truck>
From: Giuliano Procida <gprocida@google.com>
Date: Mon, 22 Sep 2025 21:17:01 +0100
X-Gm-Features: AS18NWCRygDx1l5PpFOEIBdc9FaO-Su34gj887gjfAMUSPHftRgTWnJ_N8qLGLs
Message-ID: <CAGvU0H=Jup8bYYgZ1EbYHZMSnf_SkazXDfOm7h1QrcL-ZKw55A@mail.gmail.com>
Subject: Re: [PATCH] system certificates: specify byte alignment
To: Will Deacon <will@kernel.org>
Cc: dhowells@redhat.com, dwmw2@infradead.org, gregkh@linuxfoundation.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Sept 2025 at 17:38, Will Deacon <will@kernel.org> wrote:
>
> On Fri, Sep 12, 2025 at 11:00:15AM +0100, Giuliano Procida wrote:
> > The .align macro is architecture dependent. On arm64 it behaves as
> > .p2align. The various alignments in this file are all bytes.
> >
> > So use the .balign macro to avoid unnecessary padding due to
> > over-alignment.
> >
> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > ---
> >  certs/system_certificates.S | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Does certs/revocation_certificates.S need fixing as well?

Yes. I will post a v2.

> Will

