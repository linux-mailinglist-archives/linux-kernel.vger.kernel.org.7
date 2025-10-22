Return-Path: <linux-kernel+bounces-865730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E046DBFDE12
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06553A3731
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A71F34D4CC;
	Wed, 22 Oct 2025 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2D7zDZX"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5DF34C9BE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158310; cv=none; b=tOOem6m9Jyi/wLHYwKlQCp04peCrjqM5pGVJ4MxL2ObEqCn/OQTtubGqvHU2GCX7rTfuy0n+y2dh3m0/jLPI2eIvhX3nTqIYH5/K8vRS6WYCo0bLsj6ehPBQew+uaWfQfsxawpDjntUlSZSVEq5xHvAIBaoXo5uDV2oF6o+GFj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158310; c=relaxed/simple;
	bh=+7BWihRlJ8Uywum9OTClo26XvhRXZjhPp+IFefFzinU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SkF+SL2OFWOiDmpEfhxvkHJSuXcCvnrivQN5qY0Wvy3t1d5biWyyHdDYwCsp6KO5Tb4M2JK+AFoZi41vIVaEhyvlcQJNZLMQuWVCErJKCpKB4dzIarB81AF4CCUBKgOJNfpsKag/O1FoN29fLKJHmOkpiYnGw88eLG7OZosQCB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2D7zDZX; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57a960fe78fso9152737e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761158306; x=1761763106; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3IFbl3pFvGjSyCTQkeb4hK6netTTK9K7KiLnJEXCIXQ=;
        b=b2D7zDZXWdfpPeOXKwSwUrwCRdXmJCOkxfOm5Ll7+HPNg/T6OHA8lGsJF8lQoHamIL
         U1emeLKE1W/yPS/PpDwMz0n3RzHb/b369wLidgiL6qY0ITsj5UV16elpuGFTCdBDnIdf
         qRZAeweE5A5Y1VxeJEZgvPqZKUjfF9w0JXYO0FCRvbkIwNRBHjFZA/rKXRnnj0iI0lf7
         FXuJWiEaSYMzmwZAUrvIKF6y5vT35F23NaZlFzFbFZdGApLIwzTNRucLmLKLKSf3Uj0B
         5hSFSjDbH+uo2RTd4TBRvlIXc+1VzJzoPMSdfe4mPF8it5vRL4MM0QwIz6MTqCWfDdGz
         elLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761158306; x=1761763106;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IFbl3pFvGjSyCTQkeb4hK6netTTK9K7KiLnJEXCIXQ=;
        b=JhWvwF/D9h0fIz7sZQsymbF4Kth3nTzMtbKicYs6EsycALw+OaXf3bJhviIdRPAqvj
         vxQfhlmmI4Rpzih88WvSdv1zkiYCeCtjPHw4TmKABjufMEUqOKVtV9pgQYt9j+7WKicB
         bDXtwEI8W5ciBJf6rOifRgqmki33hnca8elOoVoL27KXAOjNdHCU26KNsRArEA/eAS1o
         gP+OV2zCaneHiPJWKIOpMWi3OJZRU2EWbOx/39ucYEbuFGiXonhOhQSvW4K2atpr55OV
         Lglzafe7r6pcrDwFZgECT2VNcdQnouSkPJxJzOVbDU25/pMzCb0uJP5zRfJr1m8La+ty
         E0hQ==
X-Gm-Message-State: AOJu0YxFwmIJqQIUco1u6x5C1SNSdqK4ePFEux7pRV2K0MegS+h9HqKP
	HX9drMmrpXAp1Gho+mp+pZVkz8Jwj/6S38QmYnQHPTDnIiDpLKOc9j4sl0qL7vYZu3fD4V3YpNP
	9V/1ThsXME0gUniAhj0rl8oFhkyofwbzg8ew1
X-Gm-Gg: ASbGnctuOYExAgi7CU3WZuB/53ZcwBc2pE2S9MjaaIRroIMb3tC+pg1z68Yvo6ieccx
	qKTmQDfwRpRJorCXLOQl32LCovoHIzZ5W7odV7Eo4Lle+BnQOuJ7V3V9o1wx9tsJu3IwaDxQpfC
	ETF/LLKLyAGc7+fgFKI7bYCzdfBCyU/9oVBVNW+5GFutQhazbrpun/DL0ll90Ue5+aQHfIr0KDj
	t+a2j9Q+BZ7DRcZER4vZ5gjvU2TYc9HJKrV9VUjYDu5DNvj060HYZ1ml7Fqk5AeP6b2
X-Google-Smtp-Source: AGHT+IFhdtCIfHd3i6uCMzv8evcOjsm7J4w+SNVGqYJg5wkRZB0orvP5tLp/+pucytiat1HX/U2nmhIrV7gF1iSG4Ws=
X-Received: by 2002:a05:6512:1455:20b0:592:eea5:fa43 with SMTP id
 2adb3069b0e04-592eea5fe6cmr962460e87.22.1761158306073; Wed, 22 Oct 2025
 11:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eersten Keer <eerstenk@gmail.com>
Date: Wed, 22 Oct 2025 11:38:14 -0700
X-Gm-Features: AWmQ_bn73F4Y16UNf9De-Smk6PDuboaB_89-wTFMAdsoGBcr_8csKqmJjnmqWIM
Message-ID: <CALxUCwJh3Ki7uSZtcOzHpkPpC8kOdWHoZThr4vRnAuL1D4dD3A@mail.gmail.com>
Subject: goodix touchscreen drivers compilation fails
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, im trying to compile various goodix.c drivers i found in
several places all fail after i set path to include, making me think
these drivers are too unmaintained for newer versions of ubuntu. i
even tried installing ubuntu 13 to compile. this touch panel is in a
tablet from munbyn irt05 or irt08

ive tried this one which doesnt have dependency on old gcc & kernel
goodix.c - drivers/input/touchscreen/goodix.c - Linux source code
v6.17 - Bootlin Elixir Cross Referencer
this fails with
/usr/src/linux-headers-6.11.0-21-generic/include/linux/atomic/atomic-arch-f=
allback.h:2581:25:
error: unknown type name atomic64_t=E2=80=99
 2581 | raw_atomic64_read(const atomic64_t *v)
      |                         ^~~~~~~~~~
its a looooooooong readout, before i paste that in here just checking
the best spot to get this driver

most common driver i get pointed to in searches is this one
Nicola Landro / Goodix Touchscreen Linux Driver =C2=B7 GitLab
this requires ubuntu 13, simply installing an older version of gcc
compiler didnt work for me.
after diving into the trash for an old pc that would even look at
ubuntu 13, it couldnt find the path so i tried compiling with
gcc -I/usr/src/linux-headers-3.8.0-19-generic/include goodix.c -o goodix
and then i couldnt find asm so i did this ln -s ./asm-generic ./asm
within the include folders

any clue how i can compile this? it seems im solving many dependencies
after another... there are emails circulating on this of ppl having
compiled this in the past. within the last year.

