Return-Path: <linux-kernel+bounces-849164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D981BCF533
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD596189C63C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3377B2638AF;
	Sat, 11 Oct 2025 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="Bs5gMXCP"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0E98479
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760185620; cv=none; b=f1DxoK53y694MD7QQRw/JOymJJhPmIK0PX5OKPrDXDafZUIdFkSKdr+RwKGIzE0ldZRD1LkPvBoUpsFL03QuBfZHb272hQM/o3vC1xCmdV0CQ/pPLUmSli8BNHgf5AIQ247E3C+x2zt89sN5/yaN2hLA8UC0LEH9omsQZDzZYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760185620; c=relaxed/simple;
	bh=d/gW+e3GHHoTmcok1pFTm72qSk5L+TUgVsoAgcd1XhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IALsU9KX7zUbyBJR+3sHTAyu6UVFjeL4qcTo3SrrKX0iERuHmGNFj6nI4BMbBYhtATYT8QJEAPWNQ1yR6WKhfAuQ/d2yhjki8neJ31PO/Kw2sNHYMZCP3HeHrwLmo+8e7HmQxD6h1LPsWveNsk6K/9qf2KFxBxqyIvAIC0DQRBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=Bs5gMXCP; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6271ea39f4so1960214a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1760185614; x=1760790414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NAHnoAtDAEnsbgsmp2/eZQvCq9Zlcq/EHD9Uesa57g=;
        b=Bs5gMXCPcB2UoXYxrgl374eP6IlRa1XHOFu47mve3/OybCmbxlCccz95HsDHVs0Nz5
         qIKzTaXBORW0RumteK7DG/9T5nke+382oqi42jTCxefs+eFfOUYTDQjtXVenYxDgXTqP
         tpjhlrTFnXfCZ/fxh7X/+TO+vUX+7CvE3soy65KK1Mvf+wZQRUSSxCesig0WN+Cr5bOC
         PGxo6Z5Kv0paeD9Ki+H8wjvHcrY3xBpHodoEAnqdZe2u3VaUp+245IcGZxSILWhIV8Yy
         pj8Btyap86tuyvkBcoVFIeWJgZEBC4uSopMgRSQpbF8K/DS9MBOWy1/pdh4vnEQUpfO7
         nulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760185614; x=1760790414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NAHnoAtDAEnsbgsmp2/eZQvCq9Zlcq/EHD9Uesa57g=;
        b=Or/vyJOt+M4/2s182MlUBPpyJoOfv8U09hOJW5kL23KaqRB3cCx/nb5b0Ap0AvEJ6B
         jOerXuGmLeYoJvwexvsvWL/PhSRBgoaVOlHKXsMAoz875dgkV25WqBYwcXNgnjcvD+C/
         QZRG7Y9SDuOhJlpwD4X3mzxjKO3zZwwGY9eQOrLS/7lyNdY1Xr2bKUqwRPStXTOtKOHg
         S9JDUKJZbwyOXs/2OvYPBciQr7XdALDkbTOzrSVXNPK228Iv2WYwkpl80UstWKcnHQO+
         RThPU8pPAYJcY4/q3Li7FK/mwObwYQfEETVGb5geHArWgkzD5tzbxPn896ePJfR935Jt
         DRjw==
X-Forwarded-Encrypted: i=1; AJvYcCX8/DQJrPitbJ5CvuW1BGOZpMqoYDqc8L3jlKSZbMH7IWqPzSlCBMfoJuSq2IP4kS8VL1Wamr8jNgvpy4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpVFs0Kcihm3AGgaPiJnEtj2UySRMMa9sdPI+37c92SE4KQ1cm
	5DD/mbI7oisFMvxle9NXeMoDqlRlr2a6FN9+LP1+Dz5488sPdsOMUIm1g3mIw0rY/zqQCmaiTzI
	oFSipsG7ArR24mEXfqN+MIKiVXzikE5vj6NW66XXVGg==
X-Gm-Gg: ASbGncvyw6TSwZ1p/0c9XZpss+VzDAR9Af+KSKE9OMIXWv8isZZpfKScsIm4Gxj0ISI
	HvtGtBy6/OUtmi4R+SdSNwiIDDg9Ld0ArSgiCpo9Mi4pRTz3soLfJLlbgHSR13ZUjjVx9+JwY7s
	G3Wmd1EyBlfazitj9LXe4yNQ+Ief9HdPaFtQ8QtphRvWdg5/2TtUYvmUxnCm93IPX6Hcwi2kN1P
	SeS+gHwlcCwP11eoz1pzvfe8Q==
X-Google-Smtp-Source: AGHT+IGB0K9uNg6w4xUEupnOm6RlbrvNDms4n9KNEcFdqdNDe2QcuThbe/3xmLTU+Ir4S6Gd+o3uf+iQiYX4+WiWYgQ=
X-Received: by 2002:a17:902:f650:b0:276:305b:14a7 with SMTP id
 d9443c01a7336-290273ef0ebmr198786305ad.33.1760185614491; Sat, 11 Oct 2025
 05:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010131331.204964167@linuxfoundation.org>
In-Reply-To: <20251010131331.204964167@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 11 Oct 2025 21:26:38 +0900
X-Gm-Features: AS18NWDBFvwGIZ0Nwu0A830RD6bwht5kpABe3Vi9XiyKw1xcSWYW82-8SOUaM2I
Message-ID: <CAKL4bV6WEAjVSDOXoh4KPUNjfK=QJ=1RjuXGn7_Eo5Z3VK90SQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/26] 6.17.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Fri, Oct 10, 2025 at 10:18=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.2 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.17.2-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.17.2-rc1rv-g8902adbbfd36
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Sat Oct 11 20:59:52 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

