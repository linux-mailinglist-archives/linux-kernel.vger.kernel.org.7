Return-Path: <linux-kernel+bounces-829015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F38BAB960CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35A42A70E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912B2327A11;
	Tue, 23 Sep 2025 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="g+Fnp81f"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ACF126C1E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634947; cv=none; b=fve+GEcgyk1k2s7Byk7Z+LJgBfPywZ1jwML0YIJMGOLM4hExa9IAx2DDQ3L8UcjfYB3Uqjmvf2DV8cth/FVY0dtvQ86M93hmqRg/dBuH3mmsJYEGtT2S5rjdmABjLUkYMpsM8pTHQrdVbAcJ2c+h5QuFpXO5t4OjSpi86RCdk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634947; c=relaxed/simple;
	bh=HS9NBcbYrfF6iVaTRVwQjnuNP9ZIEYwzdwsQ7rWcF6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoCVu5YxGZteAhVnhfPVmgK1imF5Z5H4MviVk3iKY6Bx9cW3/OYFDTVY9ZG/ayTdWavalTh5lin5XHlcEaeP+NkfJSbjMJTSkD8XQqniyKzQYc3lZhYf4L243EhFPbU8UlvRqoV6t09zUtzvHv7GIgzYvGl5xOY2A9f9oJprnDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=g+Fnp81f; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b5ed9d7e20so54396231cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1758634943; x=1759239743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJZq8+MPLRJ3ip5LcrsBDiUfLaLP/BnDgi1MJHXazU8=;
        b=g+Fnp81f8NEBFGQD+r4hiyqktMd9n/P398edJxqfW9gfCYwiY3SYI6AEP4Iw48rye/
         HeDnl2QiPD7t6czMd+Tg1FhzJatV9ZBQbX67UPKo7V36l6vRd2h3rdsw8PDM66U/UFml
         q7M1hPsAwHfnYIWgLkpt3UzthOR79jaKmLX8GvogszNQ5sG1bl3fABVWIamJ61c/WLpG
         qvSegANZCOTtWDI8cBOwo9xv+J9vcvq1fEmeE4CisP8sgqjPacFCXsgB+LSpj8y6Sw19
         DyxDYnEsWKaRoeBmq+EiWiAtRySfLUk+R7atXlG2ABxWJCa+BU9Qt3Y7Pr23/ZSGbg+q
         48iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758634943; x=1759239743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJZq8+MPLRJ3ip5LcrsBDiUfLaLP/BnDgi1MJHXazU8=;
        b=DqankvGkmS5GcgJ/jw7u+KMffbpddCYfcLdRibbdfpa/n6eaCVzA66QdDIzmoPRoPu
         2lLioZXJ7mx4Aia4c2uv2QVRmF+BZ2Pwki/YDI7fhBZRRpBotvG2m87Zkz4rFtH9P/3S
         YHeGqRIwG3xUVf9io24o/JXfKMWBytluiWaEOVw9/sfLmzzXQ6SFT50uExAm2QkUdVBl
         oeL/ofgtPRK8NowD2mtgnR4WDpbVof4dw72i0+Upo4Q+M59WaT0jutB5nWiBuI1iOKmp
         b9UdlCK6iunWiTY0G2TN2G7AJp5HZ1DvEzCtkAAEtvoMi1qTvBJ7vNq8gI728avuy1De
         Tkxw==
X-Forwarded-Encrypted: i=1; AJvYcCUFNXJ4fScYJhY5swixf/e+i+nKjn2eC6tqLymKxrzVlBe7IR+ZUT7c9VyYEaDhsVmQGbUdjKl+DGDrD70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxKA6AbQdF+tL2jHfHIUOd5U3TqD4l9xJLBLUgqEj7c2FgUZx7
	qJBYkccmTDDF/vJhPnHlL3O2ElK0VH29TAvKK1qIiUevByk1itEtp1510TQ1KWIE0+uB9xY3Btc
	7rmuMyj6tlPQl0Uc+d89zzmpL6nnGWuOp+DdIMU9+GQ==
X-Gm-Gg: ASbGnctpnZocZo1+jdXIbbXJNC3Yl9ekNxk1Vp3nIdQWwbZL7hrZ6lOzrOJFIxbc0Fp
	53uV8xWSzEAkkbmhuTrJVNiTNImfDQUDY6VAbgXEexBD3th23a66jbGDThY2qOB6IOTVozOcZLF
	2BWftkTlx7pDUc26bhtbxmptlqQ6MiKd8CP4sLXgmkBAeL7gHWZi28e8fw9VKjHXe4PcvBF8NV2
	E33Izj6
X-Google-Smtp-Source: AGHT+IEqCByMJIyOisFneYcEhg1XccZAqMYXIft+cqIQMRrJVBiZ/D9q5dXHkPruO+JLDBqSs2MuwjOhSz0Yq99OO8o=
X-Received: by 2002:a05:622a:4a18:b0:4d2:6ecf:9123 with SMTP id
 d75a77b69052e-4d36a18d5c2mr26501131cf.34.1758634943106; Tue, 23 Sep 2025
 06:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922192408.913556629@linuxfoundation.org>
In-Reply-To: <20250922192408.913556629@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Tue, 23 Sep 2025 09:42:12 -0400
X-Gm-Features: AS18NWDivHJSj_z1iQ5jwb40ouc0fUOHoSfttu2yx42awG0vFzK1u2_FMqUyWE0
Message-ID: <CAOBMUvhU3VMwD2OnmR3zewO=MQhT0o6WbE=4rEbZiC=xTn_xcQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/105] 6.12.49-rc1 review
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

On Mon, Sep 22, 2025 at 3:37=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.49 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.49-rc1.gz
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

