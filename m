Return-Path: <linux-kernel+bounces-792544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C63B3C567
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9475674F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A82FFDEA;
	Fri, 29 Aug 2025 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJjZrCdt"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3C2D876F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507938; cv=none; b=NRf7NE+9tVoYd1hZwXuWKyAWN8b/0TDiDwYbUDuBHVozoFxSBkRt4UfPXT73O/7G8N1RcOfPqpRj6E60kYWOhq8trAdlWrBzpCPMbA9dn5PwyC33f5quy7/3T9Dkb9FxSo4IDT75cMbnUjpvAuojOQwZQ4opZR2r1akMtImwHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507938; c=relaxed/simple;
	bh=ojwcBl6rtg+6eqPfYuMD6prSTB6az/0FEjPvz1Tm9Kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aJIi66YeE6XkLDuz/gdNvT1JLWpWa5AH8NBlde4/EXA25lVPr2U1fKQcBaTxvDr4GRBMP5nVAvug9gkScmFbMZAFsB6Vn4Tg/VR3fJO6eYrfFqTWhRmcJ0F/NuCkqDxQCmyx+oRBcKHYlPR+llbXUTBdkfJz5Xwfn8f2U/n2Lis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wJjZrCdt; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471757d82fso2002373a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756507936; x=1757112736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdTF7iMYwxPeRfeCg813VVngacX28QeHmpqDAe9jeLk=;
        b=wJjZrCdtvt6xKrXvVv+wXmTdVCl5qmVGqyolGluxsFja/VdIDkYpo57wzGpL5O823K
         z9UhmDoAAJ04GL9dd0yUzUqaSY1wKfc4qSnqgXacNvqizcVJQkWp9V+mQtlQa9Za7Mfa
         bqTDd75RXrx3ImT7WxHdyz08QKg0rSFT6AcaCJTsHuJKkrhBG8nHEnWrCrjx3UVJyeGO
         oPiluMMnt4E3mgy/kRJr2z+MHK4XwuTQO6JJPqiGMYmdGrqJoQOgFS8kcAGncjYZEgX0
         n++RJXj5fpmosACdnyYmMctjfgQcgwFDPALQ63NeAfPNkVr7Fc71u4udMSVm9CnZ0aks
         dp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756507936; x=1757112736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdTF7iMYwxPeRfeCg813VVngacX28QeHmpqDAe9jeLk=;
        b=JCcECkNC5BE+ZS0jPra5IGiuHt7v5FH2AduI02P/DWVHy7AV7TCX/i4d5Exwzbx2iZ
         3yW2mZRbvixLnGycpnbv/C14Vlfe43nKZPZiFMgGvvMvbX/6bWafHGJTsJkXnJqnPz6R
         IkUdftrftd2d6GZW2HezC8slG+jVxaGtmQ1tOQTJEK+nCy/sNgeUQ53vazddNIUXx/Nd
         6i1xET5DTAYUV0EWaE9ak+qfTg2L9hlJobWS37TKgIY9BGsu/qQO07ydgpfDaiW+2ZE5
         K2ZF484JYi+/OJAwN3d/tHvxAXTp+dqMETZBBvz2JVr6ds8Ub3Acn2jKYcUwX3A2Ok0Q
         LpqA==
X-Forwarded-Encrypted: i=1; AJvYcCU4u1LfV4RJ6Jr9WbON6bwRTm0lOebjHaRQg8sH7I9wkp6U4CKtglXRroZW7odoRhfyqkS2LbwUAsz9C78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPoUPRk5ZtAYQV5Damj+1ViQEE1hObZcZRofcDkfuRLCkRFero
	lSh/i1fV1xeodIl8dPfYQVw13/ofK78KI7+gCcPOCKOlWnZ0bfa/gDoBwRsfvMnBL9MtVsSgxX9
	zIelZ9A==
X-Google-Smtp-Source: AGHT+IGqGPzqRupaCDD94OvlRTyG4r6PPoBy1Hyx3kC9aFfjsgUlx9M9dFuidWWIK6RZB0lbxzY8RnfYgL4=
X-Received: from pgct9.prod.google.com ([2002:a05:6a02:5289:b0:b49:d928:2b07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca3:b0:243:b06a:3d57
 with SMTP id adf61e73a8af0-243d6dd4daamr411430637.7.1756507936524; Fri, 29
 Aug 2025 15:52:16 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:52:15 -0700
In-Reply-To: <20250829142556.72577-2-aqibaf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829142556.72577-1-aqibaf@amazon.com> <20250829142556.72577-2-aqibaf@amazon.com>
Message-ID: <aLIvH06e1XDFz9lh@google.com>
Subject: Re: [PATCH 1/9] KVM: selftests: Add pidfd_open syscall number fallback
From: Sean Christopherson <seanjc@google.com>
To: Aqib Faruqui <aqibaf@amazon.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com
Content-Type: text/plain; charset="us-ascii"

Subject says KVM, but I don't see anything KVM related in here.  I don't think
any of the KVM selftests even use pidfd_open() directly.

On Fri, Aug 29, 2025, Aqib Faruqui wrote:
> The kselftest-harness uses pidfd_open() for test timeout handling, but
> non-glibc C library headers may not define this syscall number.
> 
> Add architecture-specific fallback definitions to pidfd.h, including
> support for Alpha (544) and other architectures (434). Update
> kselftest_harness.h to include pidfd.h for the syscall definitions.

This should probably be split into two patches:

  selftests: harness: Include pidfd.h to get syscall definitions from tools/

and

  selftests/pidfd: Add architecture-specific fallback definitions for pidfd_open

as there are two distinct changes here.  And kselftest_harness.h also tends to be
a finicky little bugger, isolating changes to that file is almost always a good
idea, no matter how trivial they might seem.

> Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
> ---
>  tools/testing/selftests/kselftest_harness.h | 1 +
>  tools/testing/selftests/pidfd/pidfd.h       | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 2925e47db..1dd3e5a1b 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -69,6 +69,7 @@
>  #include <unistd.h>
>  
>  #include "kselftest.h"
> +#include "pidfd/pidfd.h"
>  
>  #define TEST_TIMEOUT_DEFAULT 30
>  
> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> index f87993def..c373ff18e 100644
> --- a/tools/testing/selftests/pidfd/pidfd.h
> +++ b/tools/testing/selftests/pidfd/pidfd.h
> @@ -45,8 +45,12 @@
>  #endif
>  
>  #ifndef __NR_pidfd_open
> +#ifdef __alpha__
> +#define __NR_pidfd_open 544
> +#else
>  #define __NR_pidfd_open 434
>  #endif
> +#endif
>  
>  #ifndef __NR_pidfd_send_signal
>  #define __NR_pidfd_send_signal 424
> -- 
> 2.47.3
> 

