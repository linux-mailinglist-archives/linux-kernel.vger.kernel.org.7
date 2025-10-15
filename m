Return-Path: <linux-kernel+bounces-853658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B10BDC3F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24163E9C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D4D30DD3F;
	Wed, 15 Oct 2025 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp1XYJb8"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8712A296BDE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496998; cv=none; b=T0Y2EZmnHRN0fNt3tB6Cfaos7vrwIxRYIc6iRUY9nWrlmbeX1vkpEO4AW2hLrECsnSGLTZOHyjoGfI+Rf9mjvJR1CiIrMMx3TFIhfe1EtC/ebDuxK4pXTHmQgHICotaoq8Yodl0ldBqyp+RJkfjUtQWyAnnzim0CgxQQcdORXdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496998; c=relaxed/simple;
	bh=TE1qHUGtE2qlD/mCekHEiwVSHgeYLYgnt1C5+7OY8Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzVvvXnhTblhuKWgGPimft6A0Yjj7LMqmPmjpzXXU7IkLukfROZQw2iTwGZ8CHuWx743U9w2/EhxHee0JrX3Paw41EXk4i1skRwfyd25jkW0VluxOaCr+BK3pmUdkT0+wnVu0PB/Q/K4K6QVx/qMiIaez7TNGkGla72Opi4phnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp1XYJb8; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-74435335177so9646557b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760496995; x=1761101795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TE1qHUGtE2qlD/mCekHEiwVSHgeYLYgnt1C5+7OY8Hg=;
        b=Xp1XYJb8IPTrpCM8JgAnFUHYW/+r2whVO2nqOQxAC9oYoOZw0518fQarJrcupDcf5J
         Zf3KzxU1eIqbgFE0AFX7I9BLlgsgqcqKr/mO56M3DiI+I/m5KVCb9DN3++a8480XclVD
         iVyl/jrLlyvG9nMPjTRImBWe80LsWgiB49531fOIsyL8XZQgv5hZYWfuP/Ao4KD0vmSj
         GAA2x2zG+z/XC+ExGb47M89juZE0HkdDCjAX5yT61IObekr94i2acHg8y0T6Ljdvea3H
         YRvagA82+tz+84Dh3AFZh88XCdCju954XBEKTcxQMtrh7xldkpxAvnejCqF1VDP4ZVIL
         78KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760496995; x=1761101795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TE1qHUGtE2qlD/mCekHEiwVSHgeYLYgnt1C5+7OY8Hg=;
        b=kaRPafeMX/zhir2pTwq0YB/kJ7XaVomBtI3lQNoFO7RFMyjar0zru2eA8ZsWNiF59M
         ciu/HeAp+rM8F47LWgV+9TUy7sr1STC5JE7zI94PModKp0pBhVVoD4jKDkUGDc13X5In
         xZvzk9P839Ddb2rxoL81WMzyTD6riWleJPqrG0V5X+jiSJK1V6kBT/taghVTwmT7SDhB
         C3TSmyWpujwPhH2Fcj6n3bLjuO77t7BIUpLmj4B0AhYpXvvzNSDaifexXoYFQeGPRT2v
         kHikGSOLR8CXLVGr/dXL0D4MxPQQW8QhoMf9EsgAdta3q3ZXFm4sUsJJ5NsAT/dsV3qy
         lF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDrLEOlUaytAPPHGjlnNr/XbOSQ/+iXDTwjrjy4oHpf7synqOB+NVocI0BRdTHIeu3dRm3uOyaKSA8K0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2tAEOh4lwj0VwHfKrSO/e5KX+Xxq7DGCbawWSLCNVdKa6UvY4
	JExKHbul+iCufZ8oUcaPMCNnE2BSAWPQkQUcUvszaJ4izBssPYBzHlvl/GzPtFoaReYPp4XQEsV
	u+JhcWA7BgGeRuOwYo+WL9Z1t1qoUv1A=
X-Gm-Gg: ASbGncsZIYb5MIuxwfLvrqT0J2BZnxWXWOROk7SOyiZRgzz+nhtDY18DgP5eZIh2kUP
	/LH5D9u18jrmovtTe2McuPXA5sKbU+qudA5bQz3dbyFB3fz9NAWGjrtLGHUpK8Ill594btZ1ziF
	U/9Kt9voiFFzLGMWIR6YFVrz3hFTfGxIqGRlCi/8W6gj679DATM1lPe5GZhg0MR6Szb2wWQ6D6z
	D8JREBWwbSkwGDAdq7tO1Ov0rmA7w==
X-Google-Smtp-Source: AGHT+IG3HRitPb0dlcLGv5LgSdqyT8KuXHdCc4yeCJu3F1DpzIoAorsJ2rfH1BjAA338ijrr0+SbQ3r37duOGjwCMlA=
X-Received: by 2002:a53:bf83:0:b0:63b:a691:71fa with SMTP id
 956f58d0204a3-63cbe06465dmr19731581d50.4.1760496995327; Tue, 14 Oct 2025
 19:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009075149.1083040-1-safinaskar@gmail.com> <aOd27ViaWbsdwNDR@levanger>
In-Reply-To: <aOd27ViaWbsdwNDR@levanger>
From: Askar Safin <safinaskar@gmail.com>
Date: Wed, 15 Oct 2025 05:55:59 +0300
X-Gm-Features: AS18NWBIftPtYmrWrg2OYbA_p_2SzeJFq9_j6ArULRBmZaQNo6Xg6r4qfIVGAdM
Message-ID: <CAPnZJGDsrSk6GUYVhpofoiTKLS-pVJE4TFU_hA0gttn6Or=q+Q@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] kbuild: CFLAGS=-w no longer works
To: Nicolas Schier <nsc@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	regressions@lists.linux.dev, nathan@kernel.org, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, ojeda@kernel.org, sam@gentoo.org, 
	thomas.weissschuh@linutronix.de, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 11:49=E2=80=AFAM Nicolas Schier <nsc@kernel.org> wro=
te:
> If you want to hand-over additional CFLAGS to kbuild you need to use
> KCFLAGS or other variations, see Documentation/kbuild/kbuild.rst.

Oops, I'm sorry.
#regzbot invalid: there is no bug, kbuild works as documented

--=20
Askar Safin

