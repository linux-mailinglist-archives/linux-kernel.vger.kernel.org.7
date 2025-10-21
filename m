Return-Path: <linux-kernel+bounces-863280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA94BF7753
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3C1D4EF493
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A5B340D8C;
	Tue, 21 Oct 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnGDtgJ1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B8F2E6CA8
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061540; cv=none; b=GmKtBafuXfUHcjFvo3134faY24UL08JJLPVwueCxRm42Kw+x2McAzfRKnG4AkZM1trcD/u2CL7khsLMaNI3yXvaRuXvKqI8naiaRk1BQqd8ZxKRM/88dN7SnMiGFxB/mnWX7t1yh/2+XVZwAxenQuqc+XfUSrD6+0F9SSu+WotY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061540; c=relaxed/simple;
	bh=kpzpGzaDchyC3g6fReGgH0mCBJ5LX61PxEyAOyWy2tY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y4nntrAjQMot8lJpoRLFZ0X/aD4XdkxMWyVziXQ0RFYVvTH0SMGUqZHEwPFqlu+saMlW5hcx+5cR1XZ+hcaiwbsm87M4nG/LuUvwuQxOS2XDJHZh8Mn2xAg+it0FqVEADlRSWOiohtvPEosI/odZsRfoEgdyn3Ie6sTdgCvZeMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnGDtgJ1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761061537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kpzpGzaDchyC3g6fReGgH0mCBJ5LX61PxEyAOyWy2tY=;
	b=SnGDtgJ1dK2godRQ9keC/pYQovK5H5IXf0SzhiZWT2vd4SM2wwq7wOvJFmF3omU8xvHxlx
	EsYsn4nk8zKPiRRg2AGb+sfUaJpqbvfi2u6GS5wv7Lp7hGHsrJkZkADpYigDfc1Z5iKRJl
	R1ocbm5K7DHi4KccrCSBqWRilQeq08I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-gvG187KLPs-1O72ygeJfcw-1; Tue, 21 Oct 2025 11:45:36 -0400
X-MC-Unique: gvG187KLPs-1O72ygeJfcw-1
X-Mimecast-MFC-AGG-ID: gvG187KLPs-1O72ygeJfcw_1761061535
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47107fcb257so79108435e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061535; x=1761666335;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpzpGzaDchyC3g6fReGgH0mCBJ5LX61PxEyAOyWy2tY=;
        b=BKAixJ0UmeSuAxA4Gh+Paiv0aE0NtpUAIGCjoivDC4bg3exCS48RGkA0R9F2uYIRkY
         jb3i0o7V9eX6J1UOUM9c7zPNtH4Ofa2olMFyk842yh764JnYL5bEn7rNYPsGJCZc5JUV
         dyQEIAZwPNH1kDc2If6ob6DtaY6HmXytXmcTQen5HNe6vuS4n6aFsJHMGi07yJsHPXUF
         q0uK8VIv3ZTYqSR/yLsEyU/yVZhie2Rma9lyKUK31xQA95/Qd15BbhUtrZBNEsi9wYmr
         wQfjcgpJjD94hwL8QfHA5enz9RoOyrfV54/88DZn1MUKC151+SmiEsbkli7Ox5c3CRSy
         +w4g==
X-Forwarded-Encrypted: i=1; AJvYcCXXxPCyoB95BQaXJRlbDbj+zsIJB+mgXAvN/G8+R3nez4O8X8vnD7k+TMj7x7tbhz1SL8VGJRq9pdfEZSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL/ec/k6uJyyo9n57CT6Om4Jp+fVnYkZrLLDUn6Kej3K2CqjNk
	9yOkyEgFcydIhpnn5RlNIbuYTc2BZHBQeXQOk7/TGEC7j8J0nU9DHY90TafRMPa4BBxNy9vC2at
	8yLb/Yzc+GkKABr4QSQenSslA2wTIgfJVlhL213KwQnKlcX+Mnuj4Qa2gj2+AKS2wfg==
X-Gm-Gg: ASbGncuKsQYmpatfHtdZ6n+73KTZbOG50OzDaDQV9852gs4LjP9Amd9Uab/wpqEnluk
	PZzgSVW3Jo1zLYg8ikRFkEBNKx1jGuY5m94mf2KPwi4F3pA5rfbPCBGmXOWIdYjtbCHEAyOFHT0
	qisVxWK7PCzC9fdP9n0fBdrWRN80F9d0jgTIFvhp5gRurO1t6I2ni3DSJflkWxMJJCzrI/Y2Mfi
	lmrCi0MVzqNr3o7l1fplhMyAF4+q6gek5kH03BfQjcl2FFNwxlr2iYIwlqkdQLHsiPTrir2sZNw
	lSb0m8nTLiYTw+x8y+U5PUIRWa7niUHd9jhXE0O8XUn6TzxgAP8LqGTTV4sCoTYkVEXDnQRGoOJ
	Tnz5uMHmeUKSgjs1gOPdA32ln
X-Received: by 2002:a05:600c:190b:b0:46e:3b1a:20d7 with SMTP id 5b1f17b1804b1-47117903f8bmr135934545e9.19.1761061534759;
        Tue, 21 Oct 2025 08:45:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9Ehm46h/d4SRNrf1wmAqWVrd1RpoVylC+bIY/lKK1Cq73XYCkx2qwEidebhFmSBfgPMwY+g==
X-Received: by 2002:a05:600c:190b:b0:46e:3b1a:20d7 with SMTP id 5b1f17b1804b1-47117903f8bmr135934385e9.19.1761061534419;
        Tue, 21 Oct 2025 08:45:34 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d90bsm202343125e9.2.2025.10.21.08.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:45:34 -0700 (PDT)
Message-ID: <0cfa54fd4b095b0298e2cf4ab04a0db2f9b5f08b.camel@redhat.com>
Subject: Re: [PATCH v2 00/20] rv: Add Hybrid Automata monitor type,
 per-object and deadline monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-trace-kernel@vger.kernel.org
Date: Tue, 21 Oct 2025 17:45:32 +0200
In-Reply-To: <87ikg8bguc.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <87ikg8bguc.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 14:05 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > This RFC contains several related changes, I'm sending them together to
> > give the full picture and get early feedback but I'm probably going to
> > submit some of them separately.
>=20
> I'm done reviewing the series, sorry for taking forever (I have other
> urgent stuffs going on, and this series is not easy to digest).
>=20
> Overall looks decent. Thank you for this work!

Thanks, that was really appreciated! This is quite a fat series to review, =
I am
well aware of that!

Gabriele


