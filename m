Return-Path: <linux-kernel+bounces-876305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F24C1B264
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2B81B22FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2A1299AB3;
	Wed, 29 Oct 2025 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2AkzQhR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBAA1EF0B0
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746304; cv=none; b=CEjp3s9GNYyh/naLoLeUWnEbCuos675PDVRk/fu5TCEShiiAk4VVbmNNSerWgDOhb/vu+GjNcV1GxvoiH+sE2VMi1h04O6HdqENMFDNKBKHX76VTfAFJJZ3eOlDXOYOJxiU6fokU8B1oQbF51TsVGqg4tSnlxurmViQsTAKar8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746304; c=relaxed/simple;
	bh=eb/lecgSj7pZ4dVPEsUUj8TIQ+srrjC8ULRf0Jm2+SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBfzv+QbsmQLM2A2ZakltVU4SOUqpm+jGY9TPo3r1TalomiYs/tcHp1UBafEPJ1nDkwxSvAoHUjqSF5OnHuOuOqo2ZH/Bt9N8aeunIrE4lHJcCspO7JC4bci6qSbbVCG8TIrjnqTCLmFXqT7se9unsizerLLgCJRW0PxpQyrWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2AkzQhR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761746302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YzNMOzms2O5d2a24CLqvGn9BwifdwOkeEqcANjalJ2g=;
	b=W2AkzQhRX+sHxJa6EdA/ov+a4Ytgld4E6Yf7SPGDF9wdsezncw/aukWggJ1fLtpuBouQyG
	91IwKSr5WhD3um8NpLUGeINFlqfRaRlWVQDrCmFF5vceQK0ArOjws91/8Attp8Ps290Sgc
	qfwcyVGZQTUSq/3bmA5WLY9yeRcFEow=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-_xOKjgr1MVeubqIfHZqDmg-1; Wed, 29 Oct 2025 09:58:20 -0400
X-MC-Unique: _xOKjgr1MVeubqIfHZqDmg-1
X-Mimecast-MFC-AGG-ID: _xOKjgr1MVeubqIfHZqDmg_1761746299
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-592f33729c6so4045299e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761746298; x=1762351098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzNMOzms2O5d2a24CLqvGn9BwifdwOkeEqcANjalJ2g=;
        b=Ti1eTM6s7yrM6aVeDVXEwUtTeSzTf6c2w70tigTw9QokIHjv8+9Kp68xcrwvB+jRzC
         bN7HdRHtmClxbqVUqaHOqXyNqt6JylD4kRJfbnmUfjeZtmeU7Rvax0WPwf6wxHPS6D/9
         5nG7DhB5oSrcoyON1DgTgVt3lVU68uu2YRsToqDHHeVJo0Q7dVRejRH7zSJn+UxI7jtY
         JM2a+8CfAoiT0K7dk5WAZrwNER9TgS5pzvmPEGHQ3gk1RrhA+wIgxBV4CS5umcUV6LaN
         NXemWGy+ROz2tZk8Hz1RQxH+If4niNHMno3f6+qAOJd5HG97O38JDs3JgTTS67+qw7R+
         1K9g==
X-Forwarded-Encrypted: i=1; AJvYcCXxkRczjhAoJ03+qHysEc690WDjIM1UgMZYZZeYWQmdR4u7HkwfC9Ru6zU1SipDPBD4iG6P6lalPmy4Zzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOUWRN7/JbCMNVlwvZhWVVGZw5LmiA1pRiiXLn0cRjmvMPzZ+S
	1qhVTIi7zIacFYKzWtxfTeaZC3X23MgdHmnS7/yPm8SCif65KB1C86RxoBGXiYKbcpavw8FUAmO
	h+3cSLPfxCB2hQtmnYScKowUirwwC4cYGt/8pd6xaKCwN0c2N6f7DoeLmB/KmeRX3vBI72RXhF7
	4WiCF7D15NKiGbxlOb/B1PD/pcOrYkJRu5r70cnMx0ztL9urgj
X-Gm-Gg: ASbGncv33FQPJPAKfe8EPl48tQfXRu4114NeG8yDzN4tLlZNXWlHGj0nTWmA+n+HTM6
	P5ILedmCRFqKb8cYhRIEKdv0GhQs/iJHwV2FMHfR8R4SrHThQ5nI6g8vdGHYm710+JfUpueLO/H
	r6lCI1CxmhOlaeWbPj8wLEHz1D5IBAHABQ0wiSwY8rB6Wsj1paIes0C7sIvViIvtxqAld9CugYB
	bdicQ2F+biCLA==
X-Received: by 2002:a05:6512:238f:b0:591:ec59:2d4e with SMTP id 2adb3069b0e04-594128bfbc2mr948406e87.33.1761746296960;
        Wed, 29 Oct 2025 06:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHENcild87oyJavKrMajfFtJmvIPZWqbmuIDtqlYAc21RXT91r25XmwlhMpaWQmY1koiPE7JQjfkX6UdmNgtqU=
X-Received: by 2002:a05:6512:238f:b0:591:ec59:2d4e with SMTP id
 2adb3069b0e04-594128bfbc2mr948391e87.33.1761746296236; Wed, 29 Oct 2025
 06:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002170846.437888-1-costa.shul@redhat.com>
In-Reply-To: <20251002170846.437888-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 29 Oct 2025 14:58:04 +0100
X-Gm-Features: AWmQ_bk_Pa7PjTlfBu4mI5xpRQYogtwTJ-LtD_tM-yThYPQIs4QykeGaTsRutv0
Message-ID: <CAP4=nvT5WTKBfeihWy-FAc4hKFuJj45Be=P4U2Acs-jVnRv9oA@mail.gmail.com>
Subject: Re: [PATCH v1] tools/rtla: Fix unassigned nr_cpus
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 2. 10. 2025 v 19:09 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> In recently introduced timerlat_free(),
> the variable 'nr_cpus' is not assigned.
>
> Assign it with sysconf(_SC_NPROCESSORS_CONF) as done elsewhere.
> Remove the culprit: -Wno-maybe-uninitialized. The rest of the
> code is clean.

I suspected that the warning was disabled because of issues with an
old version of GCC, but that is not the case: I tried building RTLA on
RHEL 7 with GCC 4.8, and got no warnings, beside the real bug that you
fix here.

Therefore, it can be removed, so that such bugs are caught in the future.

>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/Makefile.rtla  | 2 +-
>  tools/tracing/rtla/src/timerlat.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas


