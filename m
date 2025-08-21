Return-Path: <linux-kernel+bounces-779854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B270DB2FA4B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F4D1C87D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049EA3314DF;
	Thu, 21 Aug 2025 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfnSiBk+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22EE321F5D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782550; cv=none; b=N+0cHR1LxdO18sid1qS+Qw+yCEdCuQ1Jc0hzJRlFPS5BC9U0igrn7FRc/hOphKEdM+yZNxysym3MP2OyYn92Zb4mQBdZtrqfgzBC3DNTOj0BLSfnIMRBbB02BYzwjcm4jFw5idSiKZSo/PGWl+F6GbVZIIqXl2BMbBU9ik7X1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782550; c=relaxed/simple;
	bh=YJxrQ7FD5/mktZk9Z49i+8l7WqlZZGyKMw2C4BluJ3M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iI1jDhIHColB8lknPzdWd0+B53lwnDhLwhKFFBoKUAlmIH5WtxQO6ImN95g8mhEnGSDtOGTGqXp1iHIOK0v/nkgAJ1BvU2D/27DtDFqHKbc6vTtoTn2+D3vT7sV3+Suuy9OylusXzeZmTtlkHSNtwfSGEnrQuUmcqNrG/69OtUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SfnSiBk+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755782548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YJxrQ7FD5/mktZk9Z49i+8l7WqlZZGyKMw2C4BluJ3M=;
	b=SfnSiBk+bUccezP+VXVtDG2T7tqspA+RBP80TZ/YIr0hGS1r4Rt2MA9l+xisdmfE+X1H2+
	i2NgVUO73j8ox9V1Pt/CqvkNhYGCy3NfhG1jlKRrFKHYCQvljE3eUVpYMvd2iJV8FEFs1X
	Db8BSwFMMUuFIWFwkRxSlY8i0IVNklA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-ONV9Q-u_P0igtwN9tSZ-Ow-1; Thu, 21 Aug 2025 09:22:26 -0400
X-MC-Unique: ONV9Q-u_P0igtwN9tSZ-Ow-1
X-Mimecast-MFC-AGG-ID: ONV9Q-u_P0igtwN9tSZ-Ow_1755782545
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9e40ffdffso645378f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755782545; x=1756387345;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJxrQ7FD5/mktZk9Z49i+8l7WqlZZGyKMw2C4BluJ3M=;
        b=qVoiG1XJwVhznbi9hdzOMW0CfK3AF4hvgEVvXoMJxcQhFQlOoDtkcpOR3VgkZXFuk0
         /S7HFmAybceAZne40tBUKzmf4KcIG82B4JANo0d7bu9bH3YSSaTmZHSN3//alpTwC9BT
         7McwxCB572B+cAwJTWi+rGYDvq8yEXGzDOtQPApg+2Xy+K0mKzrtsPK0H/qMTChO9NgQ
         +a6ErMiADtNEkZ/nEId6803SGmoZBHEiBJ82N89m9BPilDLEQDpwKmjwhGq8QKpUDsPI
         FhL6ccqVCg9Q7oFPfrMRhttA2BmbN29q5HFE9kUb5HICPIztv6BwJVIMuZcC0hzeFAMX
         aVNw==
X-Gm-Message-State: AOJu0YyfsLQ5UBBiEqo31TSidTa8QiNcRG7GyRsJG43QHGuvKmlyRQmE
	kga8q7pTn8x5Lv6lFpZzGltIK3UA8oP1txAy3PsOulcjHVuMcBYqK9qmYtG9Vm3E+CqkZRwoldg
	8ZoW1dGTX8T0MZ8ncpPFtOLbQiZBcfZCQ7+dniH/nygyuUSfwnBQC9CC0rAj7o5LKOA==
X-Gm-Gg: ASbGncukUVDVKcJfpVkx2NMQy+tUhlAm9dH+hC04WYrW20JVj0NKg6H672KcFasxtSu
	KKa2xO4Z0Ru7AYJGQSCu759/32FViw/JylLqXCasRLAsRbfOQRYg0MGpVhUTScoqeYdKqVMrDKb
	KChJPna3l1aqyVaAEBYIzar98nUTxbDhaol9xgNVeJuz2eYZ82XK25dEgsL9wjkX5TCeBaj7PJL
	LGAHXDclj4ZVqMoVrQZudGesZB61j/lvv6xD65OAs46LLWrF4LHOFRzytzIEwkFZPq50MALBYoH
	rlFbAoVsQrWm12JE4q/y+iUzrJXacI/Qd2FYzyaCXJfdiWjTPkxcc3FX5qT0mc1FHg==
X-Received: by 2002:a05:6000:2211:b0:3c0:5db6:aed with SMTP id ffacd0b85a97d-3c497274a23mr2285741f8f.54.1755782545376;
        Thu, 21 Aug 2025 06:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKWmMoUwH90shvbiFwGWyOGLnBY4pbSOBI6/RkBga7+ERO9KAT/vEMDc9J8jOx3Yd+hLCURQ==
X-Received: by 2002:a05:6000:2211:b0:3c0:5db6:aed with SMTP id ffacd0b85a97d-3c497274a23mr2285725f8f.54.1755782544997;
        Thu, 21 Aug 2025 06:22:24 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077c5731dsm11591509f8f.59.2025.08.21.06.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:22:24 -0700 (PDT)
Message-ID: <a87d09f61a873778fe9f737ea4ab7c62dc43e950.camel@redhat.com>
Subject: Re: [RFC PATCH 09/17] verification/rvgen: Allow spaces in and
 events strings
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
 <jkacur@redhat.com>
Date: Thu, 21 Aug 2025 15:22:23 +0200
In-Reply-To: <20250821122210.B9iAsUFG@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-10-gmonaco@redhat.com>
	 <20250821122210.B9iAsUFG@linutronix.de>
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

On Thu, 2025-08-21 at 14:22 +0200, Nam Cao wrote:
> On Thu, Aug 14, 2025 at 05:08:01PM +0200, Gabriele Monaco wrote:
> > Currently the automata parser assumes event strings don't have any
> > space, this stands true for event names, but can be a wrong
> > assumption
> > if we want to store other information in the event strings (e.g.
> > constraints for hybrid automata).
> >=20
> > Adapt the parser logic to allow spaces in the event strings.
>=20
> The current parser does have a few problems. Not all valid .dot files
> are accepted.
>=20
> I have a patch buried somewhere which removes the custom parser and
> instead uses a library. But then it adds a new dependency, so I'm not
> sure if it is worth..

Yeah it isn't really robust, I tried to improve it a bit but sure
something is still failing it.
We don't need full dot capabilities, but just extract some keywords,
I'd avoid pulling in a dependency for that.

I'm imagining users would either generate graphs from the
Waters/Supremica tool [1] or copy/edit existing ones, so I'm not sure
they can go that far.
Still that's hacky because some things are just lightly implied by the
code (e.g. initial/final states, edges labels, etc.), so one day we
should at the very least say what DOT is valid and what not.

Do you have specific examples of what doesn't work?

Thanks,
Gabriele

[1] - https://github.com/robimalik/Waters/releases


