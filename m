Return-Path: <linux-kernel+bounces-780609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C09B305D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4C33BD183
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7810D35CEA7;
	Thu, 21 Aug 2025 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wzQ8CBeC"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B02235AAC1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807447; cv=none; b=KqMRPuTlKjeb1sz2hUT2+hO8wjy+s3M87Ndjr9aKqOHDF+3/2/2qYh7ttxMVVXd0CvMXxN5A1aLoRDPMJ0s6+JehCPVcH3Y7Uyo5aaJB6Y19MleIIgnPwbaLdC6EnU8F6DIivU0Mpkpv5YP0Ezt4EF6XUFKlnxLFvV5xLwulfyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807447; c=relaxed/simple;
	bh=5OohnYEC9QbqJRhQVUqG0Q78T57Jg0nuHmiPVOyQ/oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVESN9m5vM7Mtji6fPRJ72ox+tpaSp85ynW6+sjW1+fFV6vDoMNLrm06pRxqngu2vz6l6sQZCR9R136A9MCYIA1so/deWkhQjiqXprRcn3X9fps0j77hSQYa6uE8D1DYEGajen+jmWhNixPipywjAlx1g1PDbtGHwzNHMXH7C4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wzQ8CBeC; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70d93f579fdso5360056d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755807445; x=1756412245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GKHhIYUvXm1eR7uJDOLbFAeZmD/aNr9e42yLSZS5GE=;
        b=wzQ8CBeCb1XJrqdl+a6Z8Wo8wZJe++Xr9fBl8da3jh1X/32kRV7o8FNnCvPIYJSPsr
         JDwAV67oRcCuZZId5SWlxmqi3Va14bMMws5jAetvUpZatb+WI38uDRx/dgRgGSkvCxwu
         Fuaj8cyOTRMYPdPQJ7Xc5MhGjxnUgopVMGJBP4Gu2K1BNmD1LyxvReNsvP6A041XIhMy
         bCCeL5sE9S33BFI07LWWAMHP5y0NSNRxbSjEySq7AplWumWbqkOl82+s8mORsQ63RG3H
         b5auEw+5XMhvLmjf97xag6GhysTZ3rAIm2evUAbbS6nUlRgUdDPdfhQSZIYV6SjsY8Nj
         L78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807445; x=1756412245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GKHhIYUvXm1eR7uJDOLbFAeZmD/aNr9e42yLSZS5GE=;
        b=gvul63T4dpNp8fDkMQAKq3MPCs/g87ELPAudD9mg7hFnmndpePfGWWrmYrWI+NA7eB
         aEjy4rrFBtoW1oxBrgjJZ1AgCzuyTh1v//TKXM00b6nVrPIazqXLFz9ouagjdL3IMn6u
         9MKcRxFV61L++PdyibsngJ1C13gYHho9CvSA5F1hB2BwNv01/IepMfoq8pcskXU5LJc4
         dEMuy5LRlS+4H5ZBAk7MVYF2DoYAShNVMJo1iLxD39zcJ40JZ13OKQe95HumtSjp78EI
         y8RLvSfKza6hAVJU64jNccdt7IwCChzeriFP/b7MyBAZSf2Q2cg3B0PlNUa5j0ZcID5l
         cBiA==
X-Forwarded-Encrypted: i=1; AJvYcCXKZ0Q6n5DWItM7ZGkCyWSR2u30gzdFR/PMlkmg2eTTNbvEKWFTIxkUgNZ9Qhtq1Uw6J89h6MCLmo3ug+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMPW1hanHRtr5fk4RFxhta4PqjARxYiDJVFyVj/5mA2zZr/Xid
	S+MhAh9j3FL0uC1wzhmltynfezrNGAg26TNJ24EGUpRULMdv7D4q8Db6MzBmZbO2YIMw27Zs1CH
	sY9NIrQvM2gYgM2sKkr3AB06WeS5lvWnkgI95t+wb
X-Gm-Gg: ASbGncuKT9knlNEAsTIg54xGZZOMlAYDblLYUrAnJHxJ675F7izm1dlA1Ctv1e9GD76
	PNhWjL0un4EInYllpjRUGE5YMuk00o6HkJNpG/5tiuCmj8jpHMIf1H7vk35Ur7QaTRhMhv5YToc
	nzXm8/iRU2/C2I0oaO9laeDR3gpflZLLlAVH+JL/DtuTqTppe0aH8Zy15RWwoxmRYyxlEi3ndZc
	fVCHPfyqqui0OjrZY7ksA==
X-Google-Smtp-Source: AGHT+IGN0/BKeoJadYh8tmDP+tf3R8FRAkNUVR/N8DJ2awKLzORsivwfWeWkC8Id+Bb5jHCi6rQ5iDwDGbl3EhLh2sY=
X-Received: by 2002:a05:6214:76b:b0:70a:3792:71b3 with SMTP id
 6a1803df08f44-70d971f6148mr10899826d6.8.1755807444690; Thu, 21 Aug 2025
 13:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821135447.1618942-1-davidgow@google.com> <20250821135447.1618942-2-davidgow@google.com>
In-Reply-To: <20250821135447.1618942-2-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Thu, 21 Aug 2025 15:17:13 -0500
X-Gm-Features: Ac12FXypXIH5pWAL85l1vEigtMRAVThNuoz79IEYMnKkvcTSXQyQlGmdixyUb9I
Message-ID: <CA+GJov7kyZLFccSyJ9VON_GpE2kvgF9jav8FP7d94amHQQkDmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: Only output a test plan if we're using kunit_array_gen_params
To: David Gow <davidgow@google.com>
Cc: Marie Zhussupova <marievic@google.com>, marievictoria875@gmail.com, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	intel-xe@lists.freedesktop.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 8:54=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> In 6a2a027e254b ("kunit: Enable direct registration of parameter arrays t=
o a KUnit test"),
> we now output a test plan for parameterised tests which use parameter
> arrays. This uses the size of the array (via the ARRAY_SIZE macro) to
> determine the number of subtests, which otherwise was indeterminate.
>
> However some tests (particularly xe_pci.check_platform_gt_count) use
> their own gen_params function which further filters the array, resulting
> in the test plan being inaccurate (and hence kunit.py failing).
>
> For now, only print the test plan line if the gen_params function is the
> provided kunit_array_gen_params. Unfortunately, this catches a lot of
> tests which would work, but at least makes sure we don't regress
> anything until we can rework how some of these macros function.
>
> Fixes: 6a2a027e254b ("kunit: Enable direct registration of parameter arra=
ys to a KUnit test")
> Signed-off-by: David Gow <davidgow@google.com>


Hello!

This makes sense to me. Maybe we can work on this feature in the future. Th=
anks!

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>
> No changes since v1:
> https://lore.kernel.org/linux-kselftest/20250819073434.1411114-2-davidgow=
@google.com/
>
> (The change was in patch 1.)
>
> ---
>  lib/kunit/test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index b661407ad0a3..bb66ea1a3eac 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -732,10 +732,12 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                   "KTAP version 1\n");
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT =
KUNIT_SUBTEST_INDENT
>                                   "# Subtest: %s", test_case->name);
> -                       if (test.params_array.params)
> +                       if (test.params_array.params &&
> +                           test_case->generate_params =3D=3D kunit_array=
_gen_params) {
>                                 kunit_log(KERN_INFO, &test, KUNIT_SUBTEST=
_INDENT
>                                           KUNIT_SUBTEST_INDENT "1..%zd\n"=
,
>                                           test.params_array.num_params);
> +                       }
>
>                         while (curr_param) {
>                                 struct kunit param_test =3D {
> --
> 2.51.0.rc2.233.g662b1ed5c5-goog
>

