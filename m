Return-Path: <linux-kernel+bounces-776632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08087B2CFAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC10627FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BD827510E;
	Tue, 19 Aug 2025 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hS/8rA0e"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F0A253F39
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645242; cv=none; b=fjMoXF5hYnYluHdbae8fgEN9ARVJLvekpj7EThDDW2SDLC6w/BuYUqUG4N00sejy7As2e7CPhe6tAAAbhy0e8opAxfzxqGTOG5ugcpE5I9ysfeJuqKdQawXHfbUFsExMqsJGoEsrpxgJWWNbBn6bqud1oxIaS8+v8BHBg74nNYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645242; c=relaxed/simple;
	bh=BscqRSuqlz6evC0gBvdrI40lPlwU7QYtRZGh/zKJNk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nqPICBolpKFFBUp5dPRE9tW0N+Q445mjPdZaYZBcvUAomDg8YElUCZ9GtyboWjpCz4vbD2f0O9K5j4Ah6ee6ufTU3QdsOCtokFUsnKWd2L2oqwXyU5hNSWlh1hLBeVf+Bm8CkmHC3jasFg0W/Lj7vIu+WIgMiGlEhOvP5K8XGzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hS/8rA0e; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323266a1e87so6097979a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645241; x=1756250041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z68cqsmoG9AHIoM+FC5zPMssxNvG4vU5VkPcD/bxa6Q=;
        b=hS/8rA0eQA5eUMhlNsC//Q8ogWsgU32FGFRp4tA7crXO93ToZbf/Jer7Tlg3RyStlG
         qcmkBzbtKrlpq80ZXXeNY3UXe2ZwjPfLJQm2EWadpt45Ue+td3vwv2ET7rwM8HTx5zdK
         +Xm2UI/pnqg37bbPPKYE7j4vGh+sSaRKpgjE2U0iRtYxiK4dFIHGmgFrpb/QMu8SsPwP
         XW6OuaiKzJBqPnCO4b4DuZF3k4t/jToRZlBE6E3y7jseVTMeixpRuhU3dpHhcxYNN4xU
         5iStPsdvP81wu0MoR0BPEOlGYCXz5VXaHxUgkt6A7E0J0um1bEyU4OrNJ4UbiOPyfuXk
         c/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645241; x=1756250041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z68cqsmoG9AHIoM+FC5zPMssxNvG4vU5VkPcD/bxa6Q=;
        b=HjY3AdvPhCoUoGKTOgo/sWzFzdptc9+3tEslVFcrLkU5fx0QuLVONA0ieE7wVUHLK6
         JqkrDoiKOwOSTgEGtuC5TlfL0pX1V8NsvBY+fyqVuvaPA9mfCNprb4IcB2srySCOmuxk
         9Wysc9K2C4c5YwOhBOqJNgojpsuGH9Ij2jwyZTklaF1AG1+hTWzjVgKTilynSoQdqx2T
         jeKrne9PC/VznDaiMVrKlZ8rVI4wTlLSrk5dRYjdLf/GzizwjGyOT5ihUk87OAzJFQMH
         deDqI3AohnDZ9Z6yKUcA/ziFs3aNkfD2DLVqP2ult/oOvKGiPfpAglibp2mfDArR5kot
         J5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1R65n/xhpcX9C6jRUA2bF5Z5CWKVpWHALZlNyYQTkDWd8YErc19Trmze7dJcV0SwCsvXdzNRRlq9/o1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH8VLyNpqaobh+ohhpi48ldUe/5o+ah08y0CficLaqdhgtkwLa
	zpO8xh8w+7g2/QDzvUOMHZDsvMJAvwyAHscSHHr5TEZ9wjL0cVEL8ARRib2KJ0+MXMVg5gz+KRW
	nQqa32A==
X-Google-Smtp-Source: AGHT+IEqNJsIq5Liw9qDu5WPmlcYNAlr/ODudB/x5SzADoBq9u4dVRGhcr3oNvyWVNra2lcBkBBfuevz/eA=
X-Received: from pjc14.prod.google.com ([2002:a17:90b:2f4e:b0:31e:d9dc:605f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5748:b0:324:df5d:e694
 with SMTP id 98e67ed59e1d1-324e12e28bamr1044307a91.11.1755645240913; Tue, 19
 Aug 2025 16:14:00 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:11:57 -0700
In-Reply-To: <20250818083034.93935-1-ewanhai-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818083034.93935-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <175564446520.3064288.7316885414458356151.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86: allow CPUID 0xC000_0000 to proceed on
 Zhaoxin CPUs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ewanhai@zhaoxin.com, cobechen@zhaoxin.com, leoliu@zhaoxin.com, 
	lyleli@zhaoxin.com
Content-Type: text/plain; charset="utf-8"

On Mon, 18 Aug 2025 04:30:34 -0400, Ewan Hai wrote:
> Bypass the Centaur-only filter for the CPUID signature leaf so that
> processing continues when the CPU vendor is Zhaoxin.

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: allow CPUID 0xC000_0000 to proceed on Zhaoxin CPUs
      https://github.com/kvm-x86/linux/commit/1f0654dc75b8

--
https://github.com/kvm-x86/linux/tree/next

