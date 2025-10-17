Return-Path: <linux-kernel+bounces-858742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 368D4BEBB18
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C96944FB46C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCC0247DE1;
	Fri, 17 Oct 2025 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="QuywydNj"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B2D1D5CD9
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760733088; cv=none; b=MS4we4kt6U+BZDKw3XdLgIHsVMsTBCtkUmkQk2MHG0eIDVtboSD2z+otpeyMGCVnJPafq2ShKQvhBuvagi2Xc2ib2jhonaw0GD86Iq0apf3CuJwO0XhAF0/Sq/yhxxMxoM7Ka+BlBDfGCam9SJzCzG9FThBthHbJYljd+6Wq2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760733088; c=relaxed/simple;
	bh=MKk7ulg8THfN6IMYxwH8fJ0oDGq7pR+r1xwzI/IoyqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tS8Hr3iGCHSFyufjtwLbiwWOU/kW8lkOmxmShewOYrzmZFygnqH2eHpiUz44gIfCNKcV4uArQxxSNvhnNRaa/pkbLG9xuqfkMl7VbaakDuymLWJ2d95RA7HCL/RPbKIWul7f/ek3QcWvgbmU/MW4SvEqPmDZb2DEp3We4yvHNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=QuywydNj; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-81efcad9c90so41598846d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1760733085; x=1761337885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lPpXtKNC8Pcljol6lZmI6XFoGZEJXZUpwOt8AD0/Gk=;
        b=QuywydNjcm27vQc791n5AmY//nevEF1Kg5ym8e4hlgMfm3jZ7Xc8kCd6zGSOzwLHVl
         06B7afgDe/8nWP/DNfIlABHnfk4pNPlLfQvB1N6e68/0m/WaUR/ZQwzFKxvXvW5pJoB+
         54UcDNbuQ/yIc2EjV/W6UPTRX9mzCd6aPPtfYpJMXlel3UF3ZsX4N5LI1B056BZO6m98
         WCuUMsLOV3zMNEIVL4SJ++Hctj7bwHgXi0gPwIq/UvvXytrws5YKIBzvUX7UW320nRix
         CUu0HR4QwimBe2zGbInM08vqSgx7FgJm4B3NJWrGVqWVDj2lqwc+mHp+t8wiZftzTS61
         H8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760733085; x=1761337885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lPpXtKNC8Pcljol6lZmI6XFoGZEJXZUpwOt8AD0/Gk=;
        b=sRP35PEeiqXFIb/cuxWMTb3gUP871z+Zf6dvIKJ3yB83d+Ncnmp7Wbc2ypstajGS3E
         qgwwwC55WSbpoCSVRQVY2jCruDIP+1woJdHDcLwOKUd85YT/eOwIRcHbpVxoaRr6yRLg
         0PjZ7VPXSw145ZK2cuQjDj/h1aUtAPFV0xTZH0u4EjVMkRHSzD/dryprekFIP0RbS/EP
         sGNxPYkshCe1Z/AU2p3YHUfRNTfv0+82Jt2cGYKAzZCgw6QZ/W0X/JiANf03X4XfbrBP
         wcIbfZ/KLYDqGSCiQZNBlQcgxPaN1PvoqNbS1y66qgn79EoBJR8ddlPebRBpFQVOVpgQ
         yxpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZUtj1wx0M6JG0gWY1A2i599nNA8g8NygNC5AT2J3wEzrNqed/fuiFRf67w0sWqvejx+DLKVCg+jOx70s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/mBQHVlkb/lrA3JWKX+a122EFWaUkvBh5tPYMMUbxxU9leKTK
	Jtmb8BNYiCk6T8h6McfZORoeiKMyb5+IR9JSsfnwiJ3epaaiB2GaQxyI96cgzeJJy4DnmzcpCxn
	pxA6WJvFVh6yq7IihWD142L7Qs4F0HP0RZbvlomAPag==
X-Gm-Gg: ASbGncupkDrkuN0vcsBey5VzoUKee2XQ5KJlNnEVjUIvHKnJvRw11bl5UbOY8Ff44wr
	WQPoQpBPyATiLwamAyB7vVnp+E7gqiWHDdg5oXn7ijluRQ8oJ9ykiE4O9ipyiYO30Ns5WAzw18E
	31nDAXoM9EcFcpux9fSMX6OGb8O25CtZgec1jTyOsoIMjbDZ2Nr0u4vS6XmhR0eQcYwP8PfaFck
	twQy4sGJ0FW+1+27bGobp6f+iddH+HjKmnE26wTOz/BwirKd3URL4uW2qHqBA==
X-Google-Smtp-Source: AGHT+IGQFfaB9wOSLxDZqrYjsq7EvvuhGYx/LCDuuPQUSKlNN3GFBd2FmzvCC7AVAg1tdTIrtigxUrv4wdP7WpBC77c=
X-Received: by 2002:a05:6214:c64:b0:87c:a721:42f1 with SMTP id
 6a1803df08f44-87ca72143c0mr20321786d6.52.1760733085286; Fri, 17 Oct 2025
 13:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017145147.138822285@linuxfoundation.org>
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Fri, 17 Oct 2025 16:31:13 -0400
X-Gm-Features: AS18NWAWVvdm9jPTS1ddtyd-wd5oGJSWRBN2RKy5mD95QqYr0wV-qU9IWXqpvdI
Message-ID: <CAOBMUvgT47EEqCi9_np-Fx6j7dR9=RhqY_tsb7+gMYi7Jb05WA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/277] 6.12.54-rc1 review
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

On Fri, Oct 17, 2025 at 11:16=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.54 release.
> There are 277 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.54-rc1.gz
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

