Return-Path: <linux-kernel+bounces-786705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D68BBB36408
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62561B63776
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B212F6564;
	Tue, 26 Aug 2025 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="r3+VQ1pM"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A0D2D191E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214876; cv=none; b=jAaqvQ/mDb9l4Q685xJQK1RblgPoVCgymq3wfULIcr498qhv/ywc5VKhuVJ7yNodxz4E+L1556I4tYHtTxnPRvf0dqrXSwYYjnAFTsyZPb6Al/KS++w6/1pzk++er3bUH9lRTjVUsa0JcQatxEcWxOBO+6iw8cBpWoduZaNswmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214876; c=relaxed/simple;
	bh=xPc5VouSLZAk6rtzQm+iCZVTSD4C5Pa1mhNOLz1cBgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsgfWVhH8+dOpYeOzlU3yFJgiZS8/Xj4wWl6f+xFuqoq2gVngJuJTtCSCy5WOyfHY/tJyoRBudS6Exg+ByJdYtGic1scsWiLp7rJrqIofsM01QJS55ZsWOEqZgEXp7XtLIiwSBuJDG+8voqnjMjKidPw/sn+biT868vdcZYybao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=r3+VQ1pM; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4c1aefa8deso1409883a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1756214874; x=1756819674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVZs1Yt4B+M7h5+3RE2O89FKpxSDOyOXZc0rIy9h7QY=;
        b=r3+VQ1pMj/yH7w+RPZsZSLj9fEOcw4gGSEO3pFN22urfgv3MtFWaQqv7AycfwSkWKk
         Y7hPE+k/q2SNsbFMwkDCB+8uoaGMNDqgQs1alS+iBrROAVNeLaMVvwMIN0nVs3Oa0I2I
         0Xnx3N5GQOFmBTqhC5a1fowVvRsQEclI9Ms0J0v8VMNzWHx14Z0ZXCgh0lxZ+k7l/3Dz
         Imz4ZmFJEyvoKotmMGYtnwR8PZz/TWFzfq+BNF4M7Dusc627FgZItZVMwVJrnR5IpBS/
         eguI1CvlZAYLniECnAlZYNYzre4KAdkWojWtIvDwBweR2tBJ9RgUHoQHvXEq52ff8Cxx
         nw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756214874; x=1756819674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVZs1Yt4B+M7h5+3RE2O89FKpxSDOyOXZc0rIy9h7QY=;
        b=PtqxR6yLLqNWDyZ3LTOIfSqffj/lQNx2aaxdLPdzCJ/kjSTBdfqwiuk7WdN/t6oy2B
         d6Y30BlDN/EU1+uzneT5Adcx3d2u3hz28J3UReFOHWD0IfiTToaBpjhD1BwqJTTUkO9X
         UeDK1grTozescwxYCKPjKea2RbZJxbbrWTaTDc3Jtj03WEI62pC2WXaTwlOS2EO6fMNT
         bR/hj5dhjTOck3nMVpcTaJ+ZEuny2tIi7YtGgRT+eFFHYSQnsX7IZuMryQF886omIidn
         tysDaIynOowtekIOBblfQWK6KRWNgLxV/+MsfPTGJP6N3dgvfwsS6awpEe830p7c4Kd9
         hcJg==
X-Forwarded-Encrypted: i=1; AJvYcCUkkm9O989h/wjtfBQHbp/dJ0nSi2/rvNibWWWZTW/KV67HmFzIi0i85jPw62Wpby/801g7QY3yrsIoCfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+pnOpNlx/c1VlS8yVrD/4zWs37LxyDS+QBnydqHGFY+s2imTN
	tp/qkop+781+yulEf7mNWfXgfNYkKh+ggh9OQmDPGahFaPgJdVZW/AeeJkICJsZ6kBFlI+cbVoC
	KGegjvYqJ0FnZOxti3EXgeefccBcdMZ/ZZJmJ6vMFLA==
X-Gm-Gg: ASbGncsAkmGA17oNPSQ7cHOed3E9IvyB78y2/qJDuzr0ZnfjkAnk8s8sJDDGlmm4amQ
	WucSwJYisYmiRbGh7bvLDmZcJyivASz6mI7KzbpLXgfQbiZkaa+KEC7N6Ed8N//465IeUC1S828
	Gqivqup1xE7n1RwBLDPxukRAtXBNR8TYZx4WudRhZZwiCXUZk/jFgQV8IqaEYymn9V/FZ5lUH4v
	W4SUA4=
X-Google-Smtp-Source: AGHT+IE2SVk4t97EhOugJmDZ3uaQs0E4tn3j9laRwvd64gm7WJAI+S2PXD6GkLMAVmz/RilHosSphia3Mhafwg0GRug=
X-Received: by 2002:a17:902:db0a:b0:246:f123:ccdd with SMTP id
 d9443c01a7336-246f123d18dmr59187785ad.8.1756214873982; Tue, 26 Aug 2025
 06:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826110937.289866482@linuxfoundation.org>
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 26 Aug 2025 22:27:38 +0900
X-Gm-Features: Ac12FXzRfFlBpNNsy7AVluxhNzcPDiGjNZum3e6mUgmwnrD5CHykobV1b5JZI_0
Message-ID: <CAKL4bV6_QsjosQHz-vVzwKBN2Zu=vc7QwEM0djuipP=g77d3_A@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/457] 6.16.4-rc1 review
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

On Tue, Aug 26, 2025 at 8:14=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.4 release.
> There are 457 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.16.4-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.4-rc1rv-g2894c4c9dabd
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Tue Aug 26 21:54:15 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

