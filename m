Return-Path: <linux-kernel+bounces-822821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1B4B84BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E07175259
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE23E308F1E;
	Thu, 18 Sep 2025 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="cvMyrK4j"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9966422F74F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200932; cv=none; b=tnvF/OBJpm9/O7X6JuV6C+/Pg9XXk9Ig5HcMEyA/Ab0EfEMQq2ezQ4h7pAzNqef5MH7NrtWz8YF3MNZCQxw1d+LI4Px87FjyorDUiCHbgfmRVD1WA6xeq4JnB0S8+6B56bIVnIDk0gMenI1NHipZnzkZ0LIIFg3NYUhVzbMl1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200932; c=relaxed/simple;
	bh=MiPOtFlUbt8t5mkkoOEMpCXHDPi78OTH6xbWfZ7DGRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZtoGrgx14o1Ucz2tJNclg2wtji6bQ0hi1BOzbSLq8xX471q1bIizUmNU5YcFQ8rPn5ufuCvn17RspQZoTsAaCGhbavBTjEQ9hToKufG8sg6FXe9DoIK5GzXolxZ1Z70NWstTNNHVjf9VC4qPcGY0xy/v5FkAMKWRyDa/CFBhpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=cvMyrK4j; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-82a334e379eso60630485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1758200929; x=1758805729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGbQKBDEp65TUh3jBVAZzg6GKFTf8pj7WLSq9aZrdY8=;
        b=cvMyrK4jw4vXNIEmJIAqxeK+WB2a5AleM0kd36tdUhN83d2gvUm4D18z4abCD2OZM/
         RDPW7kfBZvXJnVmffW2hgJNR1FXL7wto3Z6OuR9tgIH4BxVfonT4vi34msow4JAP1VfH
         zvqJOBjL4OnJJmeeK91u5mpLL+co//VguE7dGoKLQYZvQFyoSX2E2e92YvGp40AX0Nhn
         ia3/0xq27A5XL5PC8hAcvpvKV098JO2ubsV0xStnQ5Qz4sF/y/1MYAvkQaREK0bqGQMj
         Mbyt45BzG2gHz/ayOm55WR7yt4L+QukdAoOfEI8KKUu8WpQfcIawhX3q8DihyQB8J9/0
         /q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758200929; x=1758805729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGbQKBDEp65TUh3jBVAZzg6GKFTf8pj7WLSq9aZrdY8=;
        b=doVMWOiFPb/ZTb5zvlkK+zaC6+/GfQLqTX1vwOu3NAWBGFGapYl4KHkoBw65rjYcpe
         HQZTTWElgFJJhlh8VvWCmL5/tOLJ/njYYabZpdBamPaJuAYjP33+VPoGmax9LgjvYbIX
         ccPHWt6bJ3ZcQYH9372bIZtN7adhWxRsxDC871dHBV63ds814/ghb0ChuYm+v0at+VXo
         fA9aj/hMcwvMU/71GyGsNZQtYYexIHSuEjCZTpk7hg/G4m6IV8TBR7C+dDKBkalxmj/R
         47WW8mzHIBdXGhvrABt16476aJfKbiP9k71SP7/XW14Vok2FiONVeM5bed6wXtCFvSG5
         nwMg==
X-Forwarded-Encrypted: i=1; AJvYcCX9ATlV8U5Yup8awY3rUmLH/G+Z01EfWdTrsChbhKc+yPXEFps9x8jV0kmwdHZQkZ526Y2JcwpF2cQneaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSav8n+0dJxXQR8I29nPqOvhP4PGCIw6MZHSkm1WkFEI++kZo
	vMkLiWhd2KJyK7HOL7GJPJu7yokhhmhm7b6LNGaj7S/bo4knOk4wKUxh9rHqgtK0iBopSCbmxgw
	vKHZMezGffwmzKLUyDoBpG8CTkgmdiSvn44Dey/5hSP2yzMZ9rTMi8K4=
X-Gm-Gg: ASbGncupCgSSdn936i2VGXKI4cuq6wGQI6CoL3vieDI+f2ix3FLKdHO4I0S29DoTAxz
	u1KUW+n/X9X9uU38HMuICqkekgS5IBQxgV9fIEmStpYX8skOxdSd/pk3izprbbPMR8GHui7J14t
	CEh0l/JZ87zLcmRocIPyPYlObq+UT9I3vtFUOUYwh12p3Gc4BGR7lspHuiWJK5uH067uOpVqgl7
	GjHX8iTMoMepFATO8qjxqV7iHc=
X-Google-Smtp-Source: AGHT+IHelxpl1f80CJWLjoVJmEHYdJGPILPJ9Om10uXhQBYkh+errVXpSNl2QIO11FjsrjCy/TZGGAjpjeDzf/ykliQ=
X-Received: by 2002:a05:620a:29c9:b0:828:47e2:f407 with SMTP id
 af79cd13be357-83110afbe1amr582735985a.60.1758200929182; Thu, 18 Sep 2025
 06:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917123344.315037637@linuxfoundation.org>
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Thu, 18 Sep 2025 09:08:37 -0400
X-Gm-Features: AS18NWAnVFAbN7cGEMPi5uSP6yfieOtzy8GuF5GwV4ANGOF8knGeTQaKAOU9C1U
Message-ID: <CAOBMUvhwfizZxP-YT9LsOwxEJuasazs=JHhh44EkLzoE8q33Xg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/140] 6.12.48-rc1 review
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

On Wed, Sep 17, 2025 at 8:52=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.48 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.48-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

