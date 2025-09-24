Return-Path: <linux-kernel+bounces-831390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A41B9C889
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618F73B31DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC122BD5AF;
	Wed, 24 Sep 2025 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nst1VxXl"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730D429993A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756288; cv=none; b=IPzVX/iSgHR/TdotmEUgSYPCVHh6E4fXhqbKDfGE5aA4t9iGP1PuOwZihykUvUNXALuwHkMqc9bXmwuKUMYOsqdGO8gcFcC0KRam39KMiPXMOAB9D8+bClEI6u5uvxPlyRNs1wLXUYeXaREb8mgRkS0vN3borQwh4SlSm0jsY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756288; c=relaxed/simple;
	bh=Jet9kq8CcDeW5yvSbvCPvhCQfK1lFKgzanZH5IgLSak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVQWCAWqf5IUCV0V5aAHK919UfceVpfgkGTN2Uqgber2zWVJKSWDgpsMlAok/OL3CzzEkGSFHiO+cW4Xh0XNyj+rj8RnG2Ia5bpsSmu14ZXTGskszaIBop07iVM4CGckm4RyfDGK1VbRsxyIpbJ2rD5CPQcX5IiqIdSo+U6yMbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nst1VxXl; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4248a13fbe9so1895625ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758756285; x=1759361085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wq5rS7xIu7WGCSuxCIQa3Zphf2jLEucbvivd19Lb6wY=;
        b=Nst1VxXlYNlMvSWhwgnAk2oTzSN//QgFfJ8ujbYkSCr8MpT4H/MpsNwzXtGnbHE3Od
         Y+kKZX555IVCAQWqTq47KsNVydKaZ0wQNmoyMsA+32VdNzW3pMZXVx2EIzmBpAOmaqL2
         fQhoUwQdWLVWjeOrtKUwI/4mXwMiTvA8lqJQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756285; x=1759361085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq5rS7xIu7WGCSuxCIQa3Zphf2jLEucbvivd19Lb6wY=;
        b=FaAYNb6dSiBpQlbhg0hN0yMkhnTkGokYhl7xXbKMpQ+8EuW9rhPnrN6/a06RRbeEZ0
         mMngZzSwNQAs3Zh6mVyyLgy1RDyy9OwZihAxAJnO9+ciUZtt8wHQuAYM+ZLymR7dao/c
         LCCfopjevrhFFDJVUJmjvHKviSwi7nA2riRzJlSLy/md29LKV8QxLXZ1IExelP8wxPfx
         zPiPIbLxiwBxXx4eg3BY1FQpz0rKw6Ci3MxEl+9WbCMaF44BVf+RFK+kDSuIsSfyqWDD
         lIcKHz0jlXBaVTKMyWh7JObpY9Iu15eQK36xyn+EbSOiOHvt65d76MwGZcauU6Q3z7+D
         OJYw==
X-Gm-Message-State: AOJu0YyEBJe4pnhhTFlHE/CJWe0jbRWiDyxfurObg4Qm2U8kCQX+WgZI
	xQ/MP0MEFo4+RPjgyvpgR0GwDfM4u7QrsmV4KifOScmOzrnICBS6+S9KNzB5yP9mGso=
X-Gm-Gg: ASbGnctVom4WHqHF+iTlPd2riW5C67N/voYzohXTFzvC3O+77T+BKjKL1Fl2f73aOb2
	1ir2cUvNoWysMMXy2YN9un/xHY5B9u4rA+LWs9m/Kf0AHptGWPvnlcIiwZW+azY6YxnKjle99qt
	k1H1+sGKn8WYOKbFnhDz4vJ8spfk/SZT0VqVE/cQbeL5WyBH9lkxqKmzZWmYCq7RX9llpzXd1xK
	V6Iqu3Jmm+UwVVzWwGFjqLfwEBbxmpiaWlG91l4aoKpWPJ08NqWZsLgrMC0fIiDiJ44ZoWOggRO
	6nwAuAqlBiTyO9V9S0dd/Xcd7IYc/TIXrTSB/R0zVNrCFFzXagvhf+5foCB629SUJa3EgMAccVb
	i4+O5vWB0hvbGioZllUUmQa8fFf6pRAly2iw=
X-Google-Smtp-Source: AGHT+IHtbdaGjSQ1EGfQsTrq38djkX8/uDp9qw42nO6KVolXPaXkx0LkjW7ug7t2nqAz5ORH3OQ7cQ==
X-Received: by 2002:a05:6e02:8a:b0:425:7974:fe21 with SMTP id e9e14a558f8ab-4259563dd93mr20006775ab.22.1758756285448;
        Wed, 24 Sep 2025 16:24:45 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425c0546fd3sm2131295ab.45.2025.09.24.16.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 16:24:44 -0700 (PDT)
Message-ID: <d8df684e-0c09-44ea-87a4-cdbaf65ab0b8@linuxfoundation.org>
Date: Wed, 24 Sep 2025 17:24:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/acct: add cleanup for leftover process_log
 binary
To: Madhur Kumar <madhurkumar004@gmail.com>, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250922091042.149117-1-madhurkumar004@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250922091042.149117-1-madhurkumar004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 03:10, Madhur Kumar wrote:
> Some kselftests generate temporary binaries that are not tracked
> by TEST_GEN_PROGS. Add EXTRA_CLEAN entry to remove process_log
> during `make kselftest-clean`.
> 
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---
>   tools/testing/selftests/acct/Makefile | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/acct/Makefile b/tools/testing/selftests/acct/Makefile
> index 7e025099cf65..16eb97079e63 100644
> --- a/tools/testing/selftests/acct/Makefile
> +++ b/tools/testing/selftests/acct/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   TEST_GEN_PROGS := acct_syscall
>   CFLAGS += -Wall
> +EXTRA_CLEAN := process_log
>   
> -include ../lib.mk
> \ No newline at end of file

> +include ../lib.mk

Why is this deleted and added back

Please fix the patch and send v2.

thanks,
-- Shuah


