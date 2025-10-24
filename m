Return-Path: <linux-kernel+bounces-869524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEFCC080F8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20B1C4EAE25
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E09D2F260A;
	Fri, 24 Oct 2025 20:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bEiAuySE"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497BE2D0C73
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337734; cv=none; b=UirvQdOZfzbTFy3tk136+xAH5CTjFWF/wiHz0Jy2jVzkl7UdENe2H6A9DNFrdB/utemPtQ9yxrrTY0flFL0N/NoO6P4o3+T1GJsf+8flX5QsEI49Jxm0eJCgZwO3TF9AilkFSQTCEs7/pKYl5w9dBM1OlsifqL9c0WbtJVFDCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337734; c=relaxed/simple;
	bh=jo8amBELp4eKdALVS/S5urhl7jbbmcZer91cQALZFPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QK0N6+pCdTykBjg0vzU8N00urT+WdrSoktdxQt1zkMJsy2TewVhifLMJYAi44egBPz4bdHp2H+LkNqbtUczVz+tLBv76blMSN4+uO+I8UTw7MO2gcAMI+jcn7WXCkiHj87BCmJE853pN29kWJeH4fC/gEEbcolwnWIj2UP8KUos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bEiAuySE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28973df6a90so18657955ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761337732; x=1761942532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+4IPzzdYWtWkG3HuAFdre5T5bzC0IAIoWb6FazeX8Q=;
        b=bEiAuySEZFop7iClMMyzh547qmCNh3jqP2YL+lw9wqtlcVee9TDXHYyFx5L8uziCJo
         BKj+EG8TvE6+syXXLjdBrkE0McaS7PAM5jgCFhJrMJnQtzhtK56NOsLOpYJkp7Mbm0rv
         ZPBAxhWOeRd+g3rk77qL1eVIrabECmEP2XqQ7bAetcISgINS3KdMzMFYYBblfqNgbp4c
         LXCEVF7Ng5xnfuagaVVK1zDbt55LzFkSwbrzNE6u0HtsIUiizf23jldWnos91I4d9FnU
         lmJUgcw+a5TK7vszAiF83uDYdGC8tcPSGSD/tzVRE75FXe9CTSMF6b/Nb953gTsWEVdO
         CuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761337732; x=1761942532;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+4IPzzdYWtWkG3HuAFdre5T5bzC0IAIoWb6FazeX8Q=;
        b=KUTGnRPqx+zKqn508YvaySQ8USPueDt7G7jBlqhIzYpn8R0Dex3QnNbR488wrxK5hM
         m3ugIrpXGf7iMy0SB4eoJUexoa+2T9IGTCwyXztAM6BMgN4osZ9iGl5nQ5tANXn1OqSd
         Y4DXTlh187dwMfbM4QnksyiMHVMfmQntr8FirxKYuola1V9w5VjkG+0WAFGIXbqUzfON
         oTJYoutnHPiqvgGJDyCpjBmiAwL2eY7Reh6QRSC7sybK02zyYnwkiJwdiUsqaFeBJRb6
         Tp0FF9gb0PN+WRtI28nWKAg7Yu3cwTtS/xRgqZR3z1D+Pk7TXbaWfoscWbvm57lQxhzK
         9Kqw==
X-Forwarded-Encrypted: i=1; AJvYcCV3E63U0JA+PaT5uhrTgWiNDH3iZYtKB97ieiUpT7nhjVhMrwcflhwHKPPLEvXsXb/zRjhleq6MKCPc0xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySypbgSVwK+Rhz+cYg+7YNw2ifz11id5Ms/R4u2bltZ18PYUNO
	NlRoyjAXXCXw2/+Q5HiMH9RTruJmpmDf8zU3A2xdyqdxaQehkHt1QKHovFiGnwvlxuti1f/jCti
	1mbUEDCJ0mw==
X-Google-Smtp-Source: AGHT+IEDfx0aU+hhz7SVOGYR//sorbk2eL2SCI6p1wnoPUhuIVckkR22ONhfTQMYqzeeUGM//9UXhJJno3TR
X-Received: from plhb1.prod.google.com ([2002:a17:903:2281:b0:290:d14a:9752])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d487:b0:252:50ad:4e6f
 with SMTP id d9443c01a7336-290ccac98cbmr381783575ad.54.1761337732439; Fri, 24
 Oct 2025 13:28:52 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:28:50 -0700
In-Reply-To: <20251024161525.1732874-1-cmllamas@google.com> (Carlos Llamas's
 message of "Fri, 24 Oct 2025 16:15:02 +0000")
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024161525.1732874-1-cmllamas@google.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Message-ID: <dbx8cy6cavst.fsf@ynaffit-alt.c.googlers.com>
Subject: Re: [PATCH] binder: mark binder_alloc_exhaustive_test as slow
From: Tiffany Yang <ynaffit@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?Q?Arve_Hj?= =?utf-8?Q?=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kees Cook <kees@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Carlos Llamas <cmllamas@google.com> writes:

> The binder_alloc_exhaustive_test kunit test takes over 30s to complete
> and the kunit framework reports:

>    # binder_alloc_exhaustive_test: Test should be marked slow (runtime:  
> 33.842881934s)

> Mark the test as suggested to silence the warning.

> Cc: Tiffany Yang <ynaffit@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>   drivers/android/tests/binder_alloc_kunit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/android/tests/binder_alloc_kunit.c  
> b/drivers/android/tests/binder_alloc_kunit.c
> index 9b884d977f76..7f9cc003bbe3 100644
> --- a/drivers/android/tests/binder_alloc_kunit.c
> +++ b/drivers/android/tests/binder_alloc_kunit.c
> @@ -554,7 +554,7 @@ static void binder_alloc_test_exit(struct kunit *test)
>   static struct kunit_case binder_alloc_test_cases[] = {
>   	KUNIT_CASE(binder_alloc_test_init_freelist),
>   	KUNIT_CASE(binder_alloc_test_mmap),
> -	KUNIT_CASE(binder_alloc_exhaustive_test),
> +	KUNIT_CASE_SLOW(binder_alloc_exhaustive_test),
>   	{}
>   };

Reviewed-by: Tiffany Yang <ynaffit@google.com>

-- 
Tiffany Y. Yang

