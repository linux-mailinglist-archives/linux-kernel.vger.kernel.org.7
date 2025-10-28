Return-Path: <linux-kernel+bounces-873595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED388C1436F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 963884F3350
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673E629CB3C;
	Tue, 28 Oct 2025 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="Ao9ZCU5R"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD6F304975
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648569; cv=none; b=M04WUb4uIVt4Ibn9C48ZKIAssOMUTcytDlfUA/WYGxg4e/g47ppsj30lMl3McQd3+VreSUT09GUw+p2g4P9IJQTRJKjBXcx7OB/pZJW+McN08K6b04Y2bPElYsFnt1wgWATz0bCq4IsTPWiQ1lu8htSKsrICwKmMJJE3slnqKik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648569; c=relaxed/simple;
	bh=LfGgAPErQXeXoyFHe8PvWIEu71qn/w79FkU6l/R8Cto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzrBejciE4Ehl+zMtUICdw7qnBqImiYn3t7FkijXBOaMqd0R2hlSrNbqjfYIH9NOEAw3ODr82hqognYJhQC0u4IFbhAQGg3cqdmTOLj7BwR4Od72AW1DMdI6p+2vWDIje1amj08MRAd1cFASWYi443pQCtSqfjN6sBP7CuiU6fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=Ao9ZCU5R; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b550eff972eso3900957a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1761648567; x=1762253367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyrXWow90L7YCheeS5gmaxrFltylHWAvgVWWr3hrODA=;
        b=Ao9ZCU5RVXnwg938UrqPIaYSy2ZGUgd8IuUx7mneUm+y6tVcjGhzLt2JfsMwvg3JsY
         f3Er6VfEOzUd3nDaeXKXR2Y/juUz9YobcjwaK3IcpVw2W+02nmakoFy6ZTlG6a7LFah5
         m2Q+0A/wu1rPuP0POzmLndlHrFS8LAmJl6mqMac1C8Sts2+xRHnyLeb6kFYwRZTUKDk1
         XvH7+4TUWAzfQ4PdI51imLfAbaVfqJGmFBARX3WBzBfxRqOrjAk6vKt4KaWFPT/YU36i
         GEhq7FZxb/BUTw9t120+vhueOBAoEUs7dK0hS4Y5qkHjqAMkCf/gxp+eBHiSrXq/z1YQ
         sh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648567; x=1762253367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyrXWow90L7YCheeS5gmaxrFltylHWAvgVWWr3hrODA=;
        b=Aq29kCeVrCEUzYwPMN/AOsWEA+wn1WF1b3hfS/PATwodP/VaFT8Ggg3QMsn2YQLkO4
         V2b/4Nl2c03SScF6Z7csVyU4Nhx9raJr/xdzY6TxRRzalbv0Bstgy6k4ETTs5CXbcFop
         Da0r4yCMbs8ffjDvj1E/TwbBVddbeLTEezumVVuV/76oyrvqJvx6t8GgPoXttUe5vOUM
         lrkJiWj6wdto9qNKDFS7H4UJ3eVweMqmXKPxMQ43XBJ9xakMuGcbGdrzyg3/6S12HZVz
         nuOS7Pud5BRLhrgirjYJx3XIqEfUcY2JfkT0U1pVZEyPXGoUWRUTtg0ADjEd2nYP55Qr
         GjUg==
X-Forwarded-Encrypted: i=1; AJvYcCW28r/BG0ZridivwtCEMaXndg51u8IR5rBPsy2MCg8HH/LadxYX3rcNQFniQRHUMlA7G2cqwRq2crAl3R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVcssWoOQOO4inEbU3JwtGIgog490DH+4gERHZTEkC4KEF07wd
	jeLht4G4AngWpLU3R+szrss7C8mQajezS1eXJEqZ88caKI80eiUQKgTSusyYZTnS6mZFCauIO60
	fRnBDQI+GalfMzWKBfvh7TYmzIczG8SCAofXIwVUfRQ==
X-Gm-Gg: ASbGnctyrke5w2JSmWVPQ7NR3FiOXWbsl0V0BiX7V3gXMScvVwkESGb4X2aYO9Ehacj
	h8DMrk1Q03kPGbzz25qfO0efM0JokgEBO44PF9me9oLU6hVfK5pY98uF18kkCI1dQghncJlw/xL
	0Z1dD6agZlRK2WjSM/ZR/grSFQaBn324ae8mODxWOYeNpHqOHqCJ6p/iDLX01FcdZ1MUbbl3oNs
	Kw+syU48wkiOIk5in/fkNAjjVSN1mR5sjckNb9zJQ7JrrZnJNBSxEqxtWrutdXUWM7qwcnltpAb
	IvlLfQ+f8Rfc/4UWaQ==
X-Google-Smtp-Source: AGHT+IF3dhR4n5aqKeDp+Vo+LbBF2UMwZi7my529wiBD8hSsnjWc+zt+s30wJlDBzL40QuQ1+dCmkhZugs8gcsNfW9M=
X-Received: by 2002:a17:903:1249:b0:290:9934:fd04 with SMTP id
 d9443c01a7336-294cb4f2ff4mr35535735ad.28.1761648567248; Tue, 28 Oct 2025
 03:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027183514.934710872@linuxfoundation.org>
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 28 Oct 2025 19:49:10 +0900
X-Gm-Features: AWmQ_bkjtaUA0BELjnw4P7h6Xptc718dXITNsaZ_Mm7C6-RhotK2D0-z3iB_A4s
Message-ID: <CAKL4bV7qVfhVdp=gDShvsjLY4g0asdhTmgsT2gj=FC_4c62pwg@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/184] 6.17.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Oct 28, 2025 at 4:35=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.6 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.17.6-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.17.6-rc1rv-g10e3f8e671f7
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Tue Oct 28 19:19:34 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

