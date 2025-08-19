Return-Path: <linux-kernel+bounces-776644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E7EB2CFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700281C445D6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D438425DD07;
	Tue, 19 Aug 2025 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4sisD16"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE9212F98
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645494; cv=none; b=OJlCTr6YbyCwbfYJ1NQ4ImxtJ5nliwuvloE76myVsufADKfPLkEd7qBUEA6MrYiarA8iWnnmAfDXeRT/vZOWC5FoBz/oGMLgJ1rSGRSHo0K8Ruf+xXQ2Y4x2YVn9oBpq8RPQbRoT+oyNRti3Hy5GAWh+3hvksr4ztpsdfPc6ikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645494; c=relaxed/simple;
	bh=GxQ3bI32BWUEQbQQr2ztR7iscpZBTjInSD7DrhOawt8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=C1Gkygz7vljugxGB90tZGFJtmqM8E3aQaeQ9SQbY+8x1I42C7RIGtPH2zKo6VBWtpOZcuFuQETydJo8h0P1OrXXqwC5Z1xCCPPL7Mnl3Y7TvJdFJedmDpHksA6Tzrii4XsjYTtNezb7z5Cigdg51uAKisRXi00fZ2R4c8d7vHlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t4sisD16; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2430c37d06aso2698165ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645492; x=1756250292; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sDr1ilphEHq13aUEE3jJLkUxtKv+xNh38Lb2+aXAA/4=;
        b=t4sisD16gaali2sNlbBAi4+C5KLrXRwK0f/1ot3beW7O7GnjsTWwzROTnEbbCoNtcM
         v3YY9CFuZsUQhIy7g+0nsm2x1fs5KcAuKjqQBZ3iSkUjg3zGQEBNVm+eHGvjSB10bSnI
         dWVM5601koxGhBeWhT8Z4YBfOVBvzMAxjl0jIcQd5gZH8HkqYXgAfZh6plZ+Susk0uNs
         +OHjfCZfIuEWfXgAdujFa8AJzqa5nSYXXuGH4Ba4KC5Bc6BjDqzV94cblW+OZEOaGhMX
         d7aMfk8Regk1DMIjkhQ4yyp0BhcUByMZlXQoFts/FMOJhuR7otuhwEP1D7jE3lm7WnEl
         4Z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645492; x=1756250292;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDr1ilphEHq13aUEE3jJLkUxtKv+xNh38Lb2+aXAA/4=;
        b=c/diVWQB2d9BuvBmAwXXH+4KzN+WlesYxhkxY6B/wRC8t8/f/SuleQ7bVSSJxONPsQ
         xfjpCzY3kd30ifFLCv7Lve/63X7SwdflLdWKt8NsuN8tSj57npWPmhA7i+b5CHOY47Ft
         /UuTl/2TcJCSN1+VL+f5EMfhnwTQN6uXFxH8mtq/xOS4S51zsLbZSVzirZEIteQHPZuJ
         hMv2yzkvEO3QLFYqpEm8MR80raY/4mY8o6V82Jvwmv2WeeSWeNZCLKCPqFlqUTgiBALJ
         +gIwEOdkIs/rHDwhw5jnQiJqnkVzQC47irmX0eTNWdJFHaisJUqC4amkYaBSUyThUKvY
         OjMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw4Cq/CVjq+3n9bJ0XaLJ1UA5C8DVR++yTMHdlvDRpvuHM8RaKQKljdc7rYRtrYKX8l5ARGFj0JUFJRSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9cRzMfvp45FA3NfPVM9u/69YdTD0dVSlrsQDEM9fU3mwNDiRU
	IxR8Zmc0tAtpZ4ywmUFCaq5wtHdShdJxZOhPNIe4mJtX8DJYMg518QLTwXHNuvT6wS35BKcitaC
	9ecJZ0A==
X-Google-Smtp-Source: AGHT+IFDxnpwzMVt1NN+yUWtyyyahHTDf5WVJVXVoBbADQGx4NrJypC4B971/ZM/ZXkrYBiA56ui6MOkVfI=
X-Received: from plpc14.prod.google.com ([2002:a17:903:1b4e:b0:242:fe10:6c5f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aad:b0:231:d0da:5e1f
 with SMTP id d9443c01a7336-245ee14e028mr11522745ad.21.1755645492331; Tue, 19
 Aug 2025 16:18:12 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:12:19 -0700
In-Reply-To: <20250808074532.215098-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250808074532.215098-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <175564424895.3062965.10260628110611509312.b4-ty@google.com>
Subject: Re: [PATCH] KVM: TDX: Remove redundant __GFP_ZERO
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Qianfeng Rong <rongqianfeng@vivo.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 08 Aug 2025 15:45:32 +0800, Qianfeng Rong wrote:
> Remove the redundant __GFP_ZERO flag from kcalloc() since kcalloc()
> inherently zeroes memory.

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: TDX: Remove redundant __GFP_ZERO
      https://github.com/kvm-x86/linux/commit/7cbb14d361bd

--
https://github.com/kvm-x86/linux/tree/next

