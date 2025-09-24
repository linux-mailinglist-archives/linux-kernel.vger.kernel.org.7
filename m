Return-Path: <linux-kernel+bounces-830615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9C7B9A1F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5144A593F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB44305050;
	Wed, 24 Sep 2025 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biIpIQMr"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7422FFDCF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722160; cv=none; b=l6ChhdWn0wy0539J2X98RVKaBpgMSZ26LlPydvYMygZX/iSXWYKc6+RhDdwZXHoEmeM9JFSTbmCBL6+dbwTEKb7D9u7+mfM48/UJBIp7KhZgLPkmHNgUMl99hMUSiyqFq00m6SOQXpLUNNuMVm2TcfffwFOfKXd3cmTp6a4Hn4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722160; c=relaxed/simple;
	bh=DcpJ689quYGtSVJ/jZ50x9baeFfRVXjVK6frpcghcfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjSFT7hiygPquIbehRaljHPbVCHX8PS84FNbNVtOI87zGswJ2kdOogo8SNtrHJxO4sDeKHkB6/HLZkULB4LvTQ6jmEJW+wXc942RCwtlRAVDm3XA0ss1Xeva8OBmeeLA86g4WcZmdDhg/jiX9Z+G5b/zkeQVULrLb7OO5KEK8l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biIpIQMr; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57d5ccd73dfso3598541e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758722157; x=1759326957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZpCdxXN+Lj5Wtx0PEqxVxK+0pszwy0+LCFjR3ki0Po=;
        b=biIpIQMrF4TaUkg6rBPvACClC/j4cy4SwIWwmLA3rCb7ltLj0AZCuHItI/pC3HJ0ul
         3wJ977BgMlQ39W68QF+J4sONffg9pW727zOyFJG8pmDmNuZRXTauufu6vKQTRt9p+H/Q
         mGdHHo+oQYgTaVq7IKQ2rSGx8hPYUvc2c0PGdkip2cYVMiJ3BQlx+pLSilXMqXU5earQ
         0Zcz6HaSSipBi3uHjIl9KNe7znWQ3DpPu0olWUT1cdcmusPaBTaV89jGHwb45r5BI1IL
         N9BTJOo3dh8jFXBLByC5EQUmJIUJ1aLfguqKGfTCjjiIA44heOZicGAwIgzL3A3y8/un
         udzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758722157; x=1759326957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZpCdxXN+Lj5Wtx0PEqxVxK+0pszwy0+LCFjR3ki0Po=;
        b=j7+vexMa+4jOOpf1JCp5EZTXOSDK6Waw7Q6/JHaTq0fTPCKzjNWJHoYPip5eCw3Bd6
         WaXBGc3EZJ4O7h9cjdyEqeozkAg0GVv6dzUdSxTR/gcCyAOhnRnxJBnmXBhaFK1LbpDe
         631uKYurYd7mldWnfGGWFvEXrEAoVtK2f07OLiIFPpTNXj8eHe+WdYAl9l339BJwr8Rg
         yYvyRl29cvzhmUBleAYcH3oKrG2mTvhT1nb4xxVaH2GYrEHNMWqSb7DtnNHG3XFDiQJN
         UL6+uNV3pym7cN7Mz1Yo1owOsTm2dFRH/dfIt4001iTQa7ztpSQ/Pra3o3hco62766iI
         b8qA==
X-Forwarded-Encrypted: i=1; AJvYcCWoYn7fPjI5JA3GE2SMDBOCKQBaPaiOEkdzYidnbeaUg31IIrkyBItBJ3E/Yytj29rITfS2wJmezUz4xlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVtkw2NxqTIioYhB+yy358TmAW2n/FtxkATUMiBS57osyybLHI
	0RU9Nhff0griLbUqVzmYEQxY/iHhBEMoqxF+27uO2BoAhEqnfW2jUOgZmeXSqAiWw79+jEQ66bo
	HTdqctMpUuRDWU7n1wdWgB+dKi2tZ3zo=
X-Gm-Gg: ASbGncuYbFade4Su46zQ7H1j7cvxp3i9ptkWyDGwzUyeNIyBwF5Sh7xhQGzQBACIZSb
	X3Z0bzw9+1pzlJv+tMdTjKamqV9Sgs+3+JbJR5VegW0Q44ChqoB3ZmbY2dJAywDcUKJckUKzvza
	XD7AKIouByQ9Zaa0AR/0vpPSyofDJlECJ5/iCICr8hIIPpgdo/hJhD4qYOn2zaCneheSg0kA//k
	ooT/sbv/jI5vviV/PCbj8fYd+dJgfWsZ3hknUDFkg==
X-Google-Smtp-Source: AGHT+IFFrQiSJq3sO4DDheNScCAZEm7ChSSXL0OrRgD+E9nQCbhqy0d6xm+S7jAokm2e7jUsgL24742yoK4fyiXLJlA=
X-Received: by 2002:a05:6512:2903:b0:577:1168:5e44 with SMTP id
 2adb3069b0e04-580732fc04cmr1917640e87.38.1758722156813; Wed, 24 Sep 2025
 06:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922192412.885919229@linuxfoundation.org>
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 24 Sep 2025 19:25:44 +0530
X-Gm-Features: AS18NWBDacVBK1YPgwur6lrJBXLhApl2Qt6ZIWcyrgcUSkgfBZfG1VuayMkdzxc
Message-ID: <CAC-m1rryCr1KGcCWYWkd47sy92-SP0+3WFqsU2mPSxmesQr4yg@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/149] 6.16.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 1:12=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.9 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Build and boot tested 6.16.9-rc1 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without
issues.

Build
kernel: 6.16.9-rc1
git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git
git commit: fef8d1e3eca6557cae4f0149eb2071123c473c26

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards
Dileep Malepu.

