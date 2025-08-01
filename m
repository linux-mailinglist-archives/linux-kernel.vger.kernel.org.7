Return-Path: <linux-kernel+bounces-752822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1188B17B4A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FEC55A2B91
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC2E78F58;
	Fri,  1 Aug 2025 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oy6mt/oc"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B653D76
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754016384; cv=none; b=axZmMte+zPAwnSl7HcqoeoIzZgtsfL3TVp7J4PgneraqJR8QukepLqhmo4hk0Aq9WoZkdCZhE48/saptwGT2go6ZgJvHBo26MVQy7iJqpwkLbRb7ngZMZf6AN+2e2fNVhZRn05S/N1YeAhCSIDhaeB5kUlzQ4xEmcJk8EB66XCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754016384; c=relaxed/simple;
	bh=cZWlU6bu3FF8EyxLJWDuKx43cRZUbSdcaLRNdcM/RJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MG25J2di+jSJEVLjkfgXXRN1lFylNf2p0M9g1vkW8xgbvXBgn99jpfyJui3yDhvv3shkXIvfCS56/v55cm4vEyj4wIRgOF+tf3Um/6v1//biWhz1nzTds58nYtwfw2UBu1Hg4ghZh/mjpxWpK1yeCc2qIzfxi8GrcdhSLfBeHCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oy6mt/oc; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55b79ea50f8so1113721e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 19:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754016381; x=1754621181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZWlU6bu3FF8EyxLJWDuKx43cRZUbSdcaLRNdcM/RJg=;
        b=oy6mt/ocmM44YsNYnVpp8b3afIzGTPaW9WJMIk7gaIsI3LJhqAZuu58Owk+ArIqbet
         DjcOr4HALtk1sq9Qswy/HUz84s1dHJPT5W4HwjKu6LYDAvt8BNGKjrJtp8TuVBCth5IK
         OtLkfxLN1nZ9dta0Q0S3BQ/gNV68iCY5RitcYoAdG5PXlzRSLNG0Oglpu61fpDQP71sN
         oIXv9NrfaQ6YaZZL0FeLn+RQ71T48Z/mBD6cjvPE2PdKbr4bjhbRcM2cQ3EicgJgYiV5
         FslcyhIArb6Lvi0rhZIXcE1bJr7x5JWnN4t/RHw1N0NR6QPQPgK/hW0UuqE4rA8GD0tX
         i6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754016381; x=1754621181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZWlU6bu3FF8EyxLJWDuKx43cRZUbSdcaLRNdcM/RJg=;
        b=sBCo21Img4kRygInAEVKyQrac58dIjJaJhiN4vHuI07DU87+ybcEWiF7Q+Iset9tvo
         O6bqEpsQsRgZNTfwwdlXmQpGkqE/0346ZBD5XKAqInYrTBP01akfjE5eTxaaIwFHd3Xi
         4hVFqeJvpIiQyvMWU965udmgg1gtut4cQnK0O39jna5fRCXcCtyL1aCRuHsG7wAb5NtU
         amxCrR5GGCqOPuGYfVs7iXzt+q6nTGum8oTlc5NPGxFKKhKRoN6ETFQ8fFiU5VC5woSm
         j4k0QznU+LKgAWEzKWTHUhUWQj5NqN0gvj5tVVao4wp/NGL7LAc7kqDtJ1QBJL16DVDK
         j/qQ==
X-Gm-Message-State: AOJu0YyzTNMt+ZDko9/VdHd24xdWvTkP41OHol0HEo00jdRjMVSG1tQJ
	2jKGocB4INL8Exyo6WiQeyWAN6Gs1qrMOrRE3U87o/Ek0HNVKxCdkXItE5panwk7AVzz23C0eIY
	pJcDH80e22sBykXFp0N4QYgs0o4YAjFDLLAAwkHwy3FveBqy5VnXx1eNI6w==
X-Gm-Gg: ASbGnct8vdu0AePUVtAPPLWLKh6Bu5/QrVHaKS/lhaNc1dunCU0geVIkDVBdAqeI8hS
	PloxIOzwmsCZBoXiSwYNdC7CECGRuOwhhFlHWqU40V45eMFBenh65ppW6uxk1Jb30pRk6szf5LA
	Gj9z1MDjYKdjcjcgZnYE89R9m5TNVcpwPyMcUCIjiMwyTAfKccoHzXyG5kknNNKqrND+ebL9v4l
	Xj8NkXNySxGkOgYYk0ZYHcn7ANt9AJvZd1d
X-Google-Smtp-Source: AGHT+IFnpBUOGXZ6buUGy2/OiAe5ZbkRCSguTV5r6aq8VM84XyT+bRdSFU6wowHb9vu2L/UG84NQL0X/fYrixmwfkZY=
X-Received: by 2002:a05:6512:1196:b0:553:2c58:f96f with SMTP id
 2adb3069b0e04-55b7bff3b51mr2621010e87.1.1754016380967; Thu, 31 Jul 2025
 19:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801023358.562525-1-jstultz@google.com>
In-Reply-To: <20250801023358.562525-1-jstultz@google.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 31 Jul 2025 19:46:08 -0700
X-Gm-Features: Ac12FXxNvVFMDXnuJpMnDCeGoMgOnjK3VHQj4x84fOEcPEcizAUFCIyANRzQ3-Y
Message-ID: <CANDhNCr=wSZnnPa00E09OwQAJcPRAC-bDgdc0QbSw+j-BYUeyg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Improvements to ww_mutex test driver
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 7:34=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
>
> As part of the proxy-exec work, I've leveraged the ww_mutex test
> driver to help stress test the lock handling.
>
> Two of these patches I've sent a few times without any
> response[1], but after realizing the test wasn't exercising the
> wait-wound class mutexes (only wait-die), I've extended the test
> driver to now do both. This helps make sure there is more
> confidence in any changes being made.

Forgot to add the link I intended:
[1]: https://lore.kernel.org/lkml/20250715021417.4015799-1-jstultz@google.c=
om/

thanks
-john

