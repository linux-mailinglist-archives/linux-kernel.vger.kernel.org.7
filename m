Return-Path: <linux-kernel+bounces-751542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DD7B16AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E2A6247B2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BCA23C4EC;
	Thu, 31 Jul 2025 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5vIZhW+"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D423B633;
	Thu, 31 Jul 2025 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753931701; cv=none; b=gQGJKSujVMStjDyWCnvHrte+yVispC1aSjdylWE3vdiZRh1AuS0AhmjeXpRhoZ3EP1fU6ORtpktJRQAxrgG6D/ERjHvLXHyGmWhn7/MQp/yop8ZnNrZsW8msfIBMVGPCMlog5tqgrRpmuCn9ly+XXwpLgxp8OxZR+kXokyOZtog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753931701; c=relaxed/simple;
	bh=ikTEp9LiFmXNGSR8YYEQh4lnqfKSUXj8SkD4ux/kLBs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UqeEe87+O+0ELiDEbFcosuAyYnrSPDgvUtkhqgiyADGV4rgGFeeYOoQbYsvkemjWoYPc2qass8yqqwH03zOL27DlXOP3+NR2m4zZz8XzuXr5sY8X/VKSBScgLFZmLf36fqwJjxVf2o8Rxi1Fnros003M23Z863MQAL86y2oImIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5vIZhW+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2401b855635so4204615ad.2;
        Wed, 30 Jul 2025 20:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753931698; x=1754536498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlUn0AMl+wjuNGnj7NGLqH/4T6CpK18vMCU4Bo5pArM=;
        b=C5vIZhW+TAosf2PoLxqJEkMAx42RImmPhS3SoSyurGmYTUJ2thKsoqKAxPPSyRezZH
         Amts6XzR19xJ8CRL2Rvaky2cqKAkUMrvX7BsjmiQIFvALKmdUbOdj6xmE1wLf+qdjhc1
         0ofa86TRVgFFRVEXZcWw5XpJO/1iZUD5kTSuZkQ9lJyHOLJljfHHVv4V/DgFhXUEKkRb
         h50RTvBfa943fzn8q1EBaMScN85uowezqiGkXQksFPhV+HY++4Me0OKSoTb50H9BqQEo
         WPmb9znVvEFvy5suy2knYxLBUpFqINoOv32p08iykfwSUHQoK3ooh6pwEfQCH8uzKTIP
         O+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753931698; x=1754536498;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlUn0AMl+wjuNGnj7NGLqH/4T6CpK18vMCU4Bo5pArM=;
        b=AlbU7i5ukczlsiss6IQY9ZBhm9ekDPbU2l4okPFuRIhDXitwWhcwtWAOjP+1y7VldR
         VjpBUdET25HDjz4+u/aTEFynEs1jOTKY5aPiezrOTH3N/6uQViqDk5/LfHpoIiyCKryi
         bQMSNoi0E4vrLUPC5wu8UhpufoeLa916wkNcdRNJ7rmL6FxI/DMM/cUYQhCVrr8WJiSW
         XV0jXgEhIdqFznRjDhxyogJIGRhsD01Hto07idfWaysTUytkp7Wf1xk9Xn1elCdxFm4p
         daEeZMDeqjG59pdvb37r6pfByvLb6C7MKGxu2f7bJf3pVI+GkWkIKmm0tfhUJLJ6L+QK
         iYBg==
X-Forwarded-Encrypted: i=1; AJvYcCVWWiNXtQNTzEiKXGl5oiTPtqRCvEiElLVsXoL7+PoRlsf9aJfeB9rKJOul+EbePotzYfRkxaKugEoM224k@vger.kernel.org, AJvYcCVyDn+/G+e3I1Ic92O+HVYAYGEICI5rNedO7qBIQkw/lOeh5N70NemWo/T1A3fd7ber0X9GV58MwSU=@vger.kernel.org, AJvYcCWTXfxQ4rIlKk8BX73rayg5fAvPN29ny4EfFHxCnl+sECqj/oegNN/3I7diNGT+IClh3/74SzOlD1dr@vger.kernel.org
X-Gm-Message-State: AOJu0YyOkmg965t4HNgwhqDIXy9y09m6np83ysxWoBJ18jFzSjl5xhie
	XVtN3uOFZ/73e5AbnDzjFv8vj2VDB0PJRmDWrWUL5hHnkuaGRJcLIkmfIIoyRQ==
X-Gm-Gg: ASbGnctSNxM2wlKkWlGJ9M3KISahyP7CEm5FhPDH/YdFv7GaAHLnBv3ZTczKUVaekeh
	pCOs8/vHmfcQ+1MNjfDghWu3bR0ltJf/Bz5k6BIuorUpBat+22OlsgDrpr/NcRJRiyfdjsiQxNf
	LQtNVG4mnmT7rZCBtWbRl4Dm+gtBsLu4vIqyL+3mmcQLMcSK3s5/zkj+ZpjfHwEhRrmOI0RPS84
	+0XkgGYBgfxrgnLtSxJEzOp/YXKRr7ClM8aEwngjtzqUWV7CZFfuf+UrXp9nj8cCdx7B9IIYA8e
	ilN+8YjxbaAcE6oBlB4nKfZcCSieIrCaDIJobgi64ql4MxQSEZK8lKSNYqBrZo96XMneTovB+8v
	V+D/F1rx3/d1fWNZLVbar/P1fCO6j4JJwOB8JJ0KUPY6SaChM4+wMU4rc50u4QgQDcLYtvCADlj
	GQw5E=
X-Google-Smtp-Source: AGHT+IFnPbEiNQ+bx42jpz4b3DzT71R99kNkgHE4vssHbdCc/I98r322iHqp4OJWwPFZKuLSEbRUBA==
X-Received: by 2002:a17:902:ec85:b0:240:66ff:b253 with SMTP id d9443c01a7336-24096b5d423mr75316495ad.46.1753931698428;
        Wed, 30 Jul 2025 20:14:58 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef5934sm4741315ad.21.2025.07.30.20.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 20:14:58 -0700 (PDT)
Message-ID: <aa15a1f3-0efc-419a-845c-d34937eedb0f@gmail.com>
Date: Thu, 31 Jul 2025 12:14:55 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: mchehab+huawei@kernel.org
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org
References: <b03b95b8d09358e81e4f27942839191f49b0ba80.1753806485.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 2/2] docs: changes: better document Python needs
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <b03b95b8d09358e81e4f27942839191f49b0ba80.1753806485.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, 29 Jul 2025 18:43:04 +0200, Mauro Carvalho Chehab wrote:
> Python is listed as an optional dependency, but this is not
> true, as:
> 
> 1) arm (multi_v7_defconfig and other defconfigs) and arm64 defconfig
>    needs it due to DRM_MSM dependencies;
> 
> 2) CONFIG_LTO_CLANG runs a python script at scripts/Makefile.vmlinux_o;
> 
> 3) kernel-doc is called during compilation when some DRM options
>    like CONFIG_DRM_I915_WERROR are enabled;
> 
> 4) allyesconfig/allmodconfig will enable CONFIG_* dependencies
>    that needs it;
> 
> 5) besides DRM, other subsystems seem to have logic calling *.py
>    scripts.
> 

OK. This sounds convincing enough.

> So, better document that and change the dependency from optional
> to mandatory to reflect the current needs.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/process/changes.rst | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index bccfa19b45df..4c9088e429c8 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -61,7 +61,7 @@ Sphinx\ [#f1]_         3.4.3            sphinx-build --version
>  GNU tar                1.28             tar --version
>  gtags (optional)       6.6.5            gtags --version
>  mkimage (optional)     2017.01          mkimage --version
> -Python (optional)      3.9.x            python3 --version
> +Python                 3.9.x            python3 --version
>  GNU AWK (optional)     5.1.0            gawk --version
>  ====================== ===============  ========================================
>  
> @@ -154,6 +154,13 @@ Perl
>  You will need perl 5 and the following modules: ``Getopt::Long``,
>  ``Getopt::Std``, ``File::Basename``, and ``File::Find`` to build the kernel.
>  
> +Python
> +------
> +
> +Several config options require it: it is required for arm/arm64
> +default configs, CONFIG_LTO_CLANG, some DRM optional configs,
> +the kernel-doc tool, and docs build (Sphinx), among others.
> +

Looks much better.  Feel free to add:

Acked-by: Akira Yokosawa <akiyks@gmail.com>

Thanks.


