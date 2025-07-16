Return-Path: <linux-kernel+bounces-733579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE4AB07692
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E60E189D008
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4438E2F2708;
	Wed, 16 Jul 2025 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1eVNaAP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E579423ABB0
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671160; cv=none; b=kg/TTnUQK9p/2AdfL3RnGlOtDw3izPloxVcXPqvcrCFUCN0b1I4LE47on1A8au2psdcIKvg52tphp1sHLCfoFqTHfzjvNG7mDzOt1YAu0fRwOUWR9k0K9FepwbZqsE8bqdgXIzw4GBmDKQTGBNIWcRhkR0JVvQ7RHeCyvB0r4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671160; c=relaxed/simple;
	bh=4ZmhOoUxCuA2rjLNG+0JnXyxAuGvkq9t47UY1t09UyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=owiyjBPQPhcJXCmRa17MoFu8Unx2K8OH4dCrdAQPjj4ShMzXosdC+PYoC6ekvCXuB4qxuftEPCyPOEHT0m5M8+8Te/uu4DLppEGvdy5oiDb7Kr7d8g8AYNfnhtb3ILJ/in395opCVDr8M1kchkRd3rwW6iRQ/1RGudj+U4OTuoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1eVNaAP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752671157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gd7zAnIbJVOfFTVHEt6M/mwsOHbTA17lPEzKnqlmFys=;
	b=G1eVNaAP0NXE7n4C4Pc86ZJTxsTpdb89BrBxQLbqwpRSIlglqtLjn/EA8YOHfmZMaHFamn
	eSvpAxlADjU4gwakk/XszYOERW+L26O2WXaiQcugawVca8AavNn7XXbhqW6l7crouI9lIU
	D1sf5DtTfLcOI1B1NG34kzutEwXfLXQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-AG8e84OmPUKeCn_fMdMlSQ-1; Wed, 16 Jul 2025 09:05:56 -0400
X-MC-Unique: AG8e84OmPUKeCn_fMdMlSQ-1
X-Mimecast-MFC-AGG-ID: AG8e84OmPUKeCn_fMdMlSQ_1752671155
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so2781418f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752671155; x=1753275955;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gd7zAnIbJVOfFTVHEt6M/mwsOHbTA17lPEzKnqlmFys=;
        b=uG9qQLAX/W+keXTDS1fZUohjejuTEjPZ+Tu1zlqifino5w954/jlsWWmyW22rc9Y0O
         DpT3sVglq0ouAZED53+9yfoX89s59FfSSGy0HtU+e7a/pki6yn2frXROR47uV9vRKkot
         654izls/KE/Syse79k0pxJAIPA7Hy7segLv2DPdT0Rf3VP8+3WdlMqtz9by3M6LwvoY2
         Sv7JBte48kAiLXqIe01e9ylMPdP395/HjOsyXFx6hoGVBV7wR7sNcP0eIO9fPhgeAd47
         eDE9ULB0d2YH6ulae8IGVrJWIUJSBmgmA7h9L0HKUNiY7Pi5It4WYfPbws6eCkIsj1AH
         L7mw==
X-Gm-Message-State: AOJu0Yw/IATd5fC/wKui4wRf7eEBxzOnac2xMgYe5L54+hFbz0V18O4A
	KUjkJrqyMB/NAOnDddAp5iaingHYFA8vWUuDb1HN6pRKR67KRBDFcaJO8Y4PNvyov0yjbMDb4Ec
	08QhJAx3JwjF1ayxglcBnEbO7vrfwxAfDoUi2CfEo4eVqrs3yZ1m74L/Y/BAIIolGng==
X-Gm-Gg: ASbGnctN/v0WKJMAaSIwjSK8zW0eWBNkIdYiPHr1PSQUO4FQDHE0sMelVC0EQfPS6o3
	XrFofGSFEqI0jHzgAJQSUhodE/3McrJID/MRCWHRL7Ux2PvJEHVsmStNrhiYkJUzpm4vO6KR1aP
	h/DySD8jLb4jXMpLkvsW4/diaCoL5ePqIJC/b7pvT4ZaiZpaBwbApgGr7bbC7OsXICs/9C88DP5
	7zvWpZVUnpOCJXDy61pFaoPjRrXv4vE2T6+v0p8I0i43LMwKrNY45yrN0nOgpPxbbj2JSLnF24I
	3nJrSRZsknvsoTCNvflfaAdm71nP4iRD9E+xiDIND5Ghl/cpCCcn5vVYK6J9gzWaxg==
X-Received: by 2002:adf:e6ca:0:b0:3a4:c528:9089 with SMTP id ffacd0b85a97d-3b60dd8870amr2159948f8f.42.1752671154834;
        Wed, 16 Jul 2025 06:05:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpfbjIynuUiT1DaZVKUwoILPAj9L75cgG3aw0ibfUnJMhCy3x9t3t+39d69bvnLyuBWUDfiQ==
X-Received: by 2002:adf:e6ca:0:b0:3a4:c528:9089 with SMTP id ffacd0b85a97d-3b60dd8870amr2159773f8f.42.1752671153045;
        Wed, 16 Jul 2025 06:05:53 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e285sm17581026f8f.76.2025.07.16.06.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:05:52 -0700 (PDT)
Message-ID: <5aa9b70894f464dbff8e317cbd8fc188db9920e4.camel@redhat.com>
Subject: Re: [PATCH v3 01/17] tools/rv: Do not skip idle in trace
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Nam Cao
	 <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, Juri Lelli
	 <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
	 <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 15:05:50 +0200
In-Reply-To: <20250716124105.GX1613200@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-2-gmonaco@redhat.com>
	 <20250716115027.GV1613200@noisy.programming.kicks-ass.net>
	 <21b23f125e20102440e36da08a039d88bdf58eb1.camel@redhat.com>
	 <20250716124105.GX1613200@noisy.programming.kicks-ass.net>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-16 at 14:41 +0200, Peter Zijlstra wrote:
> On Wed, Jul 16, 2025 at 02:18:28PM +0200, Gabriele Monaco wrote:
> > On Wed, 2025-07-16 at 13:50 +0200, Peter Zijlstra wrote:
> > > On Tue, Jul 15, 2025 at 09:14:18AM +0200, Gabriele Monaco wrote:
> > > > Currently, the userspace RV tool skips trace events triggered by th=
e RV
> > > > tool itself, this can be changed by passing the parameter -s, which
> > > > sets the variable config_my_pid to 0 (instead of the tool's PID). T=
he
> > > > current condition for per-task monitors (config_has_id) does not ch=
eck
> > > > that config_my_pid isn't 0 to skip. In case we pass -s, we show eve=
nts
> > > > triggered by RV but don't show those triggered by idle (PID 0).
> > >=20
> > > The distinction between !my_pid and has_id is that you can in fact tr=
ace
> > > pid-0 if you want?
> > >=20
> > Yes pretty much, no flag is meant to skip events from pid-0.
>=20
> > > > -	if (config_has_id && (config_my_pid =3D=3D id))
> > > > +	if (config_my_pid && config_has_id && (config_my_pid =3D=3D id))
>=20
> But should we then not write:
>=20
> 	if (config_has_id && (config_my_pid =3D=3D id))

Sorry, got a bit confused, I flipped the two while describing:
* -s shows traces from RV but skips from pid-0 (unintended)
* omitting -s skips events from RV (correct)

If we are running a per-task monitor config_has_id is always true, we pass =
-s,
which makes config_my_pid =3D 0 (intended /not/ to skip RV).
Now when we are about to trace an event from idle (id=3D0), we skip it, alt=
hough
we really shouldn't.
That's why we also needs to check for config_my_pid not being 0.

Does it make sense?

Thanks,
Gabriele


