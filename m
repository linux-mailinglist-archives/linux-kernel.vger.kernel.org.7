Return-Path: <linux-kernel+bounces-798492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66428B41EBC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330BE543B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486672F6178;
	Wed,  3 Sep 2025 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNoF9vFR"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1180B19E81F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901977; cv=none; b=oEvlEUJkDVIjgXw8u1WtacQpPyJCtpBa14khTyesTZC0to+7vVfWF47frqIu/FRH3arJslyvcBZq4HyN1HSNnhIWFHX/iBu8o9JzgfkEnGcQEo5ERRCYq6pzDPCshU5wxcDUNIlk213FxD76cz4ic7AOh0U6c97jTNmaZHVDpQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901977; c=relaxed/simple;
	bh=cQj6PCOZNiFK/zIlAgCSnuZrDtbLL+TySoisKqNB/bc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qTYXQmQ6Xa9Q9Zw+VazUiriFrvcvV2X2Q48nZLBdJxW55SJ3iLGq76QMd1Vgd6b+XYWIfyLUMNSqB8S7jNfcdw4lH9FBYk6k2+LrVwdCYocqJp3iAvL7CeUeI5U9+ucyDdsZgS85I/Y5M8i0dp/Y6UrSrvtswzVCijeDbEPc2qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNoF9vFR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61cebce2f78so12267727a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901974; x=1757506774; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cQj6PCOZNiFK/zIlAgCSnuZrDtbLL+TySoisKqNB/bc=;
        b=RNoF9vFRVatClPypoizDajKuzCgcIvzRBXrqX1ZmQrWDR2oZiaRzmzJSFgH5baXQMu
         pIGsYZMNqCeEhR4OURaXzz5qGuKobn2yya8DR1RPwTVytPxL7KQW9eabE0s7bgSHxuut
         mmm4nhfEQWpYjUv48Q6jwQT1tWXLpst+oydGS2dqdF3GPytW/7ZWJDCrGCKhtc5a1nEO
         XCcXn64lb7bam5DyY5l/7j0+juF3UAylkCnVfxrFC90oeHO921lA7u1coTSVf8u2xJ+L
         1/1FjH0+dLPe3hbowIc+VzQhYdJ6Jjdr3WA+bJl6+Wvc1O+Bgdhxl4geLLMDtrTtQWz5
         EquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901974; x=1757506774;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQj6PCOZNiFK/zIlAgCSnuZrDtbLL+TySoisKqNB/bc=;
        b=M6tknSGHMTDo44fQS4xkYsdcxkGSk5P7lBMThwWbyIv9X1ODlMIpvKR2bosdnYjJZO
         sfDjnY/0aK8DMSkLdpwB07q6pzDOjvdczemdd0Qxnw8NzeBQoMSpqbPLd8hkTq67usR7
         EQB57q6eyPVMNYxJ/liGjsemLdFGgSqaBQbxjNb5MdAMEjxlX6Waez5jjFC03giPqjLa
         cJDs7WKAKB1FCpBZv1vLnSuYVI8Uv3T7usaxDk7Gkbzyl3dQY31nWxlU804r+3VVj7Ud
         /CxeRl7C6T0ateeer+1J7Gb6nomewqNGjmmKViuJ2kato/tJNicrmmXiSaK/95YzeanH
         U5sg==
X-Gm-Message-State: AOJu0Yyz8Nv5DLH2ksiH0vmYssiKwE+4Ky2xVZN6TenzrgekrHLOjubb
	eiwVJnSidq4KWHY5JI1Manw2e2BiTOaWfGcCcgKoryqNXR2HsJriNq1c/nCeTEMROrijeNgpmWU
	OALr9NQTJ2Q0BATG2MKgPJiguKV0APC/KsQfH
X-Gm-Gg: ASbGncs/Vn86ySmAR4ZY6M6igcyzW0DRHvwo2Wta9hRjxgwVxhW1rg+6zdlpsxK4UDC
	cDvckiALztwxpRri5tGtb1gVwWdAoVj0pYtw/7Gw4oF2en7H3s+M7e5CcvgqMvNKuZ+5lmXoDtE
	jiT4aFz5hfFOPPbz0WE3w0di2geMNZy7ZLHhE4rMTQl8gW1VmU92DQIpvsV4kNUGjMLQ6JiSMmI
	diAoUOp
X-Google-Smtp-Source: AGHT+IGqrD5JdZp1xWcxoiWeQcHzMK/ny3uSQumUm0twQTyOcUjSaGWDbIKSsGDph2jI8jlNv5RPrdgBBQi2m/dRGX8=
X-Received: by 2002:a05:6402:52cb:b0:61c:ce93:8f7b with SMTP id
 4fb4d7f45d1cf-61d269a73a7mr12064337a12.12.1756901973826; Wed, 03 Sep 2025
 05:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sebastian Ramadan <slay.sebbeh@gmail.com>
Date: Wed, 3 Sep 2025 22:19:19 +1000
X-Gm-Features: Ac12FXxO7Ty20oelY-_E3FaYVWHju4IGaS4xFSpimJP1Z45340ULWXPxihkOpr0
Message-ID: <CAPKFLCQRG3BTfqR22tc7YC1kQW-678Doxg8GY3D0rw_0y+0cCA@mail.gmail.com>
Subject: Re: [PATCH v2 RFC 2/7] kfuzztest: add user-facing API and data structures
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

Thanks for the patch.

One small note about the line calling kfuzztest_parse_and_relocate() =E2=80=
=94
specifically the use of (void **)&arg. This cast is technically
nonportable and invokes undefined behavior in C. The C standard
doesn't guarantee compatibility between different pointer-to-pointer
types, and this can lead to issues on architectures with stricter
aliasing or alignment requirements. While this may work on common
configurations, I'm curious to see the kernel realistically meet its
goals for wide support across diverse platforms.

To make this portable, you could use a temporary void * variable
instead. For example: declare void *tmp with initialisation (no cast
necessary there), pass &tmp to the function, and then assign arg =3D tmp
afterward. This avoids the cast and adheres to strict aliasing rules.

Alternatively, if the function is only ever used for a specific type,
changing its third argument to test_arg_type ** would also eliminate
the need for the cast and improve type safety. I'll leave it as an
exercise to the reader to find a way to bring anonymous tagged
struct/unions from C11 into the picture if that needs extension for
multiple types.

Thanks again, and hope this helps.

Best regards, Sebastian Ramadan.

