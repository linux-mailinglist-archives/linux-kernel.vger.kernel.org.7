Return-Path: <linux-kernel+bounces-877855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5A0C1F32F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66ED14E7EED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AFF337BB0;
	Thu, 30 Oct 2025 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNhhqVtp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DCB340294
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815454; cv=none; b=PPWpULYslc3goyw9SPONWUkkhJOSDnhdeATAmW5XPkD+U1pUDOePnnk7ia2yst9zh0I8jbENNmctJDt2CvOJlW+rUKQO+T09XYCNQiRxqvpS9c8LgfNLjM6vETX/Zz3eN3qL/pAp9mOEqmZwT68N1y6h7xP63dZ6oOtIPYyhYZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815454; c=relaxed/simple;
	bh=troghh+EtnIk9h397iUL1P5hBgqhBFYUDWJNFG20LX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/Iq9y1dYexEiWBw92o/dJ2+E8rgObVFnof/f5H7OJ1Wbcq5Qwh5NgvByOI6mBv1gz4tU1hYP8Yvd+Lpfd6frs37CDxkF/bKSM9DFObqbxvnaIkGJapCte+++xfGhmKWTF6ct413GD06uHv+19NLQ+DQ3p1qIpM7uRB7VfScfYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNhhqVtp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761815452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMeWelBTpKLjORlzb8BUx/v9zk9wij4ZcdP7B2QI6to=;
	b=VNhhqVtpsy/NaL30NDrJ+l5e4fqBN016dnr6d4ko1YNW1PWRXS+vESXX4gDo7I1v9j46JJ
	kSXohI4q3xqBCOKvPOaJZ6IeAPFsvtemrXT6NhklqrYGTCXXvc+Bc8A4nqyhrZHlEez851
	h+Ub4ypKBvrj4qz2bhKVIVEXiDRHJyc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-CEN90px5Ncih6GfFXvRcxg-1; Thu, 30 Oct 2025 05:10:50 -0400
X-MC-Unique: CEN90px5Ncih6GfFXvRcxg-1
X-Mimecast-MFC-AGG-ID: CEN90px5Ncih6GfFXvRcxg_1761815449
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-37a0cc22ec1so3464611fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761815448; x=1762420248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMeWelBTpKLjORlzb8BUx/v9zk9wij4ZcdP7B2QI6to=;
        b=fa7/Ql9PAy2ELKeLWDGdKa3J1XhFvPEFm0g50aP8z3vBGHka7RFxD/JDO6hTgEwPxN
         ZGR4a41Dof8cHvXD5QzZM6W+uBDBNoIRW7oylWlUzpWFrfVEczjeRE6uuFmmeUTyruTx
         4NFq6S4mXIW+S+y9GNJTVZC/f1OtIa0XMWdNz9+x/xrQ5MkSfVvAUShpONf0aryK8bHj
         jS8HYoXWoq7tR3Ey1d4SXmmc0MJjz3qRlP/ZCd00LfnHoqfAn2liMHGWyJFzLE8TI79O
         Q+0FuUqD4oo+SzgA7JrF4p3JFEXltD681cVVR0RTQu2l+LrDGkk+jxP0xzuOGAxhzFvf
         gC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5tSSPU2X2fNRTOnao3fZ6IUJ3IfMJKPDjAt5hdXbDRytu7c4mK2YmJYCdFs3Z25pbKJ4xoHJxMvYOAMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmkq/OgqJVN3up2E97R1dtyRdb3KoyUAqG3y/MpsFKtScEDcvp
	pZUabLICyrNpijF+w+sW+BO8x6Nv2qxyWmC3fO0EbVD4ZiDs7XYWKTHRL8bKCeY0kaoS3072dne
	cUIBWEiv6WXivI2bSeaGngSAAH6RbyFlEIuJ3bCXIOe0/jV3ETOrOHz00T4TzDbGwCorJYZncX+
	F0hbgOWCVe/wDjgTqyEsB9skQmvu/a/5qd4SRxp/NvsxR1FV3J
X-Gm-Gg: ASbGncuLSsosw8Lws9b7Vw7Q3xrZr7kZmbSZvebEnOXbA8lekfHGtHNZriVTNsLc+iP
	NMgfxCxLhdjjgSTTcomKo3sjCKghNtEZQbPDlv2syqO76559ZjTOkNgFJhh1aYFxylHaDPRNPJI
	P8yMaGHVDawlNxxbGTD6Pg8ElmSz61poeev1jZXX02oCH7i+tuxbSEYQ==
X-Received: by 2002:a05:6512:2391:b0:591:d7e1:7859 with SMTP id 2adb3069b0e04-59416ef3b0dmr833633e87.56.1761815448063;
        Thu, 30 Oct 2025 02:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP/kQzE0RNM76fJcR4JF1n9agyalrVPw4P+d/1DyMASGn27+BCcr/ZMHo4k0Nu5jckBVa+UTheLuwKQaCsORU=
X-Received: by 2002:a05:6512:2391:b0:591:d7e1:7859 with SMTP id
 2adb3069b0e04-59416ef3b0dmr833623e87.56.1761815447591; Thu, 30 Oct 2025
 02:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002170846.437888-1-costa.shul@redhat.com>
In-Reply-To: <20251002170846.437888-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 30 Oct 2025 10:10:36 +0100
X-Gm-Features: AWmQ_bmQbxEjDPYY78CtDBSW88IHSLgudrACU9vS2dpfYk6ZJl9LPEG1O4-mr68
Message-ID: <CAP4=nvTZP+=_hALnW2VB35KWwu5TNJ9m4FS8pLfk3hxFLTTtGg@mail.gmail.com>
Subject: Re: [PATCH v1] tools/rtla: Fix unassigned nr_cpus
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

=C4=8Dt 2. 10. 2025 v 19:09 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> In recently introduced timerlat_free(),
> the variable 'nr_cpus' is not assigned.
>
> Assign it with sysconf(_SC_NPROCESSORS_CONF) as done elsewhere.
> Remove the culprit: -Wno-maybe-uninitialized. The rest of the
> code is clean.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/Makefile.rtla  | 2 +-
>  tools/tracing/rtla/src/timerlat.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>

This is another fix of a bug introduced in the 6.18-v1 RTLA code
consolidation [1], this time affecting the resetting of idle states
set through --deepest-idle-state. Could you please also add it to your
RTLA fix queue?

Also, this should have:

Fixes: 2f3172f9dd58 ("tools/rtla: Consolidate code between
osnoise/timerlat and hist/top")

[1] https://lore.kernel.org/linux-trace-kernel/20250907022325.243930-1-crwo=
od@redhat.com/T/

Thanks,
Tomas


