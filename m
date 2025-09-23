Return-Path: <linux-kernel+bounces-828492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 528C2B94B45
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13CF87A3C72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41E82EAB64;
	Tue, 23 Sep 2025 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="NYth7GLb"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2231E480
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611370; cv=none; b=uCSnMVXEPGy7t+EJy+rNoHJ1oYFlt946bxzGJ+YQXED5jKrcDg8gnnNqgIRpwpZUpz4hwXdI9I1ObHvbsFvkyw6S3ChH4+H6X8yzpNn3jIIrSM0FT/zad1Al55s7w9IT1OyLIWNnmIj2q5BGRhH7lOGHpUbosGf3tw/PLynkPS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611370; c=relaxed/simple;
	bh=ysHSnboJ1VSr6jkBIcIUCwgVamK+FIg8Tw8ZKEJoTYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cl6Sz9qyK1zboKqeNlPIrp4KOjrtNFvOlrsIZVUjpsuwquH/9bqOMhIfNIau67aTKeSO8au45JCLG43lzPKWvUxrn0U0IhenzYaXMLZdIX6/w4XaT/yj9e+N2FGHfYJNNVSCdjjupKnvuy2C0vqscfH9rPjGngft4U1UjxMtZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=NYth7GLb; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so4635963a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1758611367; x=1759216167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS/Hcgt6nxISZoclCG4XRiK7DJieVFaBpkh9uC8ETIk=;
        b=NYth7GLbmyTAA9EyuPmGZoW2Tw/aemcJPqVaMEmDvY8WDoTPXTp1EYRT4SeP9Zl2n0
         0n2KggAfwo7qXniqtm1PQQDeFWZgGY8NrVReiMKwiFeCs7tcTxcZtkbfUMF07NwsqJXb
         P+wIpilk6kDRQMbSVAdqy46dyPoLNIFGIkgwJytPe9od06mhERN1aiCBXLA9EZI05rHn
         7SyM+WXxTO6gOkvs7wKMiCjAgqGOFUl0TXqKJJT1lTKCWcg3Vqw0Kyo4JgyzpHmDx7kv
         IMN5JeVqYTFUq2sZbuk/hCN2sSyfFk4e6ADbj4DMmhZCq0ns9lgczN7nsvH1WeWSapBY
         9t/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758611367; x=1759216167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WS/Hcgt6nxISZoclCG4XRiK7DJieVFaBpkh9uC8ETIk=;
        b=BnvuwX/S05Y9wPUNfFEI7EiRaFr7L4MqduMqUAE3nIU3X5lFuhVh7hjFgRPcrDLaUG
         t/XJvXIw1PQR+WPwLAAM0xTkNmERVqyK6xwdQzOA46PNnFd/88VJzLlQlCT9ucrhw9ug
         wu/vel75d1jYTDLvxAz38vkxvoOJUJmRAeIpKaKiYPWeuNyVZKCMSwD5s4/phLicYK4w
         5eqgvWzNbhDvdI4LmN5ltJchsbJZn4syix1dRTx18Y/R7t3tKGpPUL7s1JgwahdQz9zz
         CrwdtY7aSj7gOjj9ObcTbam0u984em7sZJkW4GeadGavK3DgbknIWYHQpRBQ8Dt6wBZP
         cnWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq+pQbLFEgBPD0f3tn23Bou/OFjxrRNZXrPxarbKi318wsfByZy7CT3HEQzHO8HeyTwPnoqAGFy5BcvJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7FQUONP4+SwbetRJ/SodqudQCNDrgaIlGM5Ij3vSpr8gIbe9y
	ldDwboyhmuWq5uujRf8e1XbCHS7L/NULvItztqnuVYP+PZ8vVwVSMrM7TclJN0ZRDGZ0fGQAFuO
	MiJnj7xE9B7Ugb4rW1XS8WU530y6DIEM98T2ar0Hu5Q==
X-Gm-Gg: ASbGncvh/ZfSDrioHF5LfZOLKbMlr8KHXJ3YjnCi/RLnjs7WlzQOkmXDFtQ2oYYggtX
	ImJnqaylll7mKloL9AKpX4SfR/Ta6QsqoarjuAbEpV14r2ATpAJmF8CkCvS8tQtXoqO21yojeBp
	uuQv/Q0El+du5XTNUjxeGIs/uSnESI/Xow/TY9npH85L2oOAK4bUVOQQTAVCif1tp9N0To4nSA+
	hlCxGxO
X-Google-Smtp-Source: AGHT+IEgoLb6RErKTnJ5NIZWIJLVpqUBP5g71PH2B1xh1MeH1Fl+3zcfHUqPKMdNb0NwcitDlAsWFhiPjv2M7Hdy56I=
X-Received: by 2002:a17:90b:4f45:b0:32e:64ed:c20a with SMTP id
 98e67ed59e1d1-332ab42e4c4mr2037223a91.0.1758611367438; Tue, 23 Sep 2025
 00:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922192412.885919229@linuxfoundation.org>
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 23 Sep 2025 16:09:10 +0900
X-Gm-Features: AS18NWAU1ht66y9EVnhyxXlwR9JHytYi8_B10g0jSKv9pePNQntsZc8-dhugOu0
Message-ID: <CAKL4bV7Z+Kf=gDvmxL27hV4P8aHqYhOm+n3gU-WoAxESY-dNQg@mail.gmail.com>
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

Hi Greg

On Tue, Sep 23, 2025 at 4:42=E2=80=AFAM Greg Kroah-Hartman
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
>

6.16.9-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.9-rc1rv-gfef8d1e3eca6
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Tue Sep 23 15:36:05 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

