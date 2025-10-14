Return-Path: <linux-kernel+bounces-852748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBF5BD9CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7765918A2567
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A15202F93;
	Tue, 14 Oct 2025 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDe8mJ5b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AFA2F4A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449547; cv=none; b=OE9ZySC8IIQwzsPOXYd5c9q5KQxYwZULM6mm6bIQMKyOkYfBA0R1KFnAULWdXFBC7dOArO6I41yuqI7cFtWUwBxM1gMxUu27XhSCF+UBG07wj/q7LPrD4N8Sfv0jLldq57RHBZS1Zjw4e05JRjnzcpl1cUoGFTOqLmzjfD/H4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449547; c=relaxed/simple;
	bh=UIQXVCBJtfItmt5aAR7Q8u4Kp9Dxpe/5VAwat14nD5U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LNljUUrIRCly/D5WSpPbmrf+tNWSyJgtO2IzKZtkrxV+SRyRV+CWskY+LOc90B7i7D1tx4xpKGkV2mwNStPr9HHZK8G3KtL+5fKKogYva34r94Do3DA01gJuqoPeuOc9IWFknm7FfBGp86XgPQtRFJzT7ILE99oInHkVAuV8mfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDe8mJ5b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760449544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UIQXVCBJtfItmt5aAR7Q8u4Kp9Dxpe/5VAwat14nD5U=;
	b=iDe8mJ5bNfBpc3PxXZL7rKM+7HZI9Pjv8dDRIXATqANq0gE2lQ+gJowqFkb1cbunatu/jK
	Anz9wf4WT6nlO/rT1e2qEkVENdr73A04AR2ju8tdaUmdTnNsEeNHrr9gU6KDOBkL2OMar8
	2gLZamDdZSHikiNEBM6dEQm75/FgaNQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-g4HGchHoPvm8e26l25XVQA-1; Tue, 14 Oct 2025 09:45:43 -0400
X-MC-Unique: g4HGchHoPvm8e26l25XVQA-1
X-Mimecast-MFC-AGG-ID: g4HGchHoPvm8e26l25XVQA_1760449542
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so59019165e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760449542; x=1761054342;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIQXVCBJtfItmt5aAR7Q8u4Kp9Dxpe/5VAwat14nD5U=;
        b=VNMEfGO9LeYv7j3dwmKUSCBUixfuF5ekM+uHH6CuNnKS873A+dIvJ0eV1G66AJqICp
         5cEDKsujK8ZERdlPS+nmoh7kZSTrvGhwXvQ9ED717vjhtGyoNpKWQjqgyOQlz+TPg5R9
         P3v4+HCet+5wtICHH0IYs7yUDF8uH/TDkyXrchDsSuO3G7B0CRdRd8abaSCE6XfrDWMy
         Dms6FhXRwL4bR7GnbNzB9bVIfYJCAbiAbaA9AvpF1iVRDGZc03Wyv4MKwJx1+Y2Ndstg
         KcVuYQYX32bH1m5rx6MW27UYFHtPmoMEvgBodxyA54oiFqNzYvc6LvSHO1zWnTJZgwHM
         oRbw==
X-Forwarded-Encrypted: i=1; AJvYcCUa6xy+qbnFAEVd4AMUJpvYnV8wum2QDs8wCbmiydTJSbck8bQ3GISR1u5QtkTQsvBn1RA/a7WLO6htrTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyioSLhxtctXL+86UY3ZjIrJVCkpzPINPWMDuxEVkajDeaNQpT7
	5aucsbUSB1mGBiG3CtH1Ve27+jNFXX5vCPiQ2d9/330f0KJ2bTyrH3CFWY0L3bay7TdBYoXCHNK
	E3FEDY44dsGWgaVMT+Nc7gZy1a8l+E4f3rz3YeKCMrb8g8Qnh8OAIb4BZjaLF4nOyw1dpPfYemb
	fO
X-Gm-Gg: ASbGncu8RD/1Ew39WJfNGUV0Io5hTWutEFJ22bQdSbk4/BSmUfgHhzBih/29gbmEYRD
	AhIxly1CsgAM4HI/cFeaKgMYsSGgwgak8CA86HhIFZirURNVYjJK+viUAwj/lK26wyCkGhPyMdY
	7DOUMHBqDwua6Ic/hkx2BKEQSAMGuWwy9AvYcpLHJu72wLECI/w22ddIuf3iw4QX37zwMlRCAvY
	5CBy0lcocob+k50TyYxxZDyC96RertT+AOcAdRkves71d8jdt1Wozl4lmsqwyfTlkchtF0Z1qWA
	cgc6T7wKnvr4vNYuQjeTxWZ74ZARYAmkUWrftFKH0uMj8rzxvbbVfU/1YPPoRBVTyKb6
X-Received: by 2002:a05:600c:3f1b:b0:46e:1a14:a81b with SMTP id 5b1f17b1804b1-46fa9b17e09mr165685295e9.36.1760449541708;
        Tue, 14 Oct 2025 06:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlL+rgRgxjvezQCbd2Wr8dlgkKQQptuXyUBRVm3hq6/tSPyP/tOF2+AloxycKsh8x1Jt44yQ==
X-Received: by 2002:a05:600c:3f1b:b0:46e:1a14:a81b with SMTP id 5b1f17b1804b1-46fa9b17e09mr165685065e9.36.1760449541210;
        Tue, 14 Oct 2025 06:45:41 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb483c7e0sm243785855e9.7.2025.10.14.06.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:45:40 -0700 (PDT)
Message-ID: <ef1503b097e6113cec24f2c20684635fe1337260.camel@redhat.com>
Subject: Re: [PATCH 3/3] rv: Add explicit lockdep context for reactors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Oct 2025 15:45:39 +0200
In-Reply-To: <20251014140813-692b312f-67d8-4f11-99f9-73d5d8d34c87@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
	 <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
	 <87qzv6szku.fsf@yellow.woof>
	 <20251014094206-80eb5d6c-e4dd-4704-a40a-e2d0461c2185@linutronix.de>
	 <4d0467cf03f4b818a40344b6ec8142582c26a876.camel@redhat.com>
	 <20251014140813-692b312f-67d8-4f11-99f9-73d5d8d34c87@linutronix.de>
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

On Tue, 2025-10-14 at 14:51 +0200, Thomas Wei=C3=9Fschuh wrote:
> I can't follow here. lockdep can indicate problems, but it should not
> introduce
> problems on its own. So preventing the usage together with lockdep would =
be
> the
> proverbial head in the sand. If the tracepoints called by lockdep are an =
issue
> then we would just not call into lockdep in the first place. lockdep
> triggering
> these tracepoints should not be an issue in practice. I don't see a
> bulletproof
> way to prevent a tracepoint handler from calling another tracepoint, exce=
pt
> maybe extending lockdep to also track that.

Forget about it, you're right. This leads to not using lockdep inside react=
ors
in the first place. We could even have notrace versions of the lockdep call=
s
(I'm not sure lockdep itself needs them), but that's getting horrid.

Leaving for a moment concurrency quirks aside, a monitor that is reacting s=
hould
be done for a while and can be marked as not monitoring before reacting, in=
stead
of after.
Trace handlers triggered in the same tracepoints should, in principle, be a=
ble
to tell they are not supposed to run. This at least stands for DA monitors,=
 but
the same idea could work on LTL as well.

Of course this gets more complicated in practice, but perhaps suspending
monitors during reaction can be enough to allow these lockdep calls without
risking infinite loops.

Thoughts?

Gabriele


