Return-Path: <linux-kernel+bounces-845848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA00BC64AA
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54680189AE7A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7292C08D1;
	Wed,  8 Oct 2025 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+jNtKlZ"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C252BE7A3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759948053; cv=none; b=khHcUJA78AHiFF56A5zl74mmmo5xyEdefYUQRNMEEPGuswDlt+3PRjKcZF8STn85cB7x9ygcDRSAFIqDIt0YBum8EQHQadNiKJnQxHFC9KsAn90bzosVBHq61E0CBylGRFmHJ11a08l/phdN7NJHO2HjEJrnymMtIUXtE8vqkA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759948053; c=relaxed/simple;
	bh=X5KE258P8Aj7dusM1Pm2AVhrTOXDwBUXq0YvAeLT5dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcarK215Qm+XkUexQRX3RvlSXtuXPcRuJSBKyHFv2+B11rS1vE//yJdtgoFwmGiSKAzmwQiSIT0qy+LA8hyu/qSmuHuOcul8Oxh34gPTuF1K76qkpXF8lhM2bQVju74JluYCkVz6XOJwlPHbIaxaFu32al3yTdeyRiyop5drexg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+jNtKlZ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7b6d6a1e4e4so100297a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759948051; x=1760552851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5KE258P8Aj7dusM1Pm2AVhrTOXDwBUXq0YvAeLT5dU=;
        b=h+jNtKlZVdWOhymP5z28+tIA5Z+Dk3s0lM6+/ZJe+gYgGpZWH1aGiOfy14Kk8mJO1v
         GQHFavIBbrxI2OakhEFGsFz4wAW4MFkjutSmBaPfCyJ0tL+Le5ZttWBBRikSpYbpnTI5
         I9jC/2/dOW1yW6slRPbjt3OaxPo9Kr+jBAcBSCbplUTtR7SJxXnNCa/fSkdtyNha8Su7
         VxLk9vV322czyfcU0Nd238xl6jkG/HrCzXOjmORh8e2fIkqCj3hWr93Uc6mAdoiG/5E/
         pDsd6bscNfn+mQtgGNxkDb1nOXSHWK11T8EHkcNTaurriFHhsgJ45EUsz8PTDsG1pBSh
         S+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759948051; x=1760552851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5KE258P8Aj7dusM1Pm2AVhrTOXDwBUXq0YvAeLT5dU=;
        b=mqMH7NUdwAViy7ZYWm4GRYDeuDafchu3pAtjGJNoxf6z/cn5b/A7jyBqu8lWq+1fvM
         MgQRHP5cywmTygV4ElnXGqvyl285i4D6pGZoPCwy19sUCK5cMcQDt91TA7QG98j1JSeH
         /EXqjUuteySvnKc2g38X+Wl4KpWhXQAoLAAL3bLGODKfqueumNAYf/GaOBlO1+QxaBqk
         fFHS2nUbUogW1C67MM+RaznSr9Z46/mwM/EE6rNlCAHBkNxmq4++5/zzq5IkaOJiQckA
         9M7eTlbIGYj89y7QdYMrrrqHSfnKhXzK1Vnh15zhu0ntvYXUarL4ewSR3yFRHYM+658s
         BskQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO28RFg7qI0NFDng8M8ajbgeLqE6Jt+75np9X/bqvsRDOK3QK+2WiIuMne0sOQPLs9v+DpofpTNZagSJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEe4bnmgoD9t0aKpp8OoV9WjHUmfSZABTO+DkeaEO/zJggPyTR
	z5fRfo0mIjqP7k3SmG4w6KUolWeDDMoty5WpAbDlSelUoU0h8o/fkMhC8erbhz3lEavAWrs2vIt
	jL5VTzCNvKvOVbyNZCqEUGI0LxkJUPuU=
X-Gm-Gg: ASbGncu8QFG/UYojfQhe9UCYAlMBjdUuUvTl/tFTQtSUmnq4M1AcUD889Jn50DzQ2NA
	gFUkAdM+8pLegLQjLhTVrMMy9NRBWWTsy24+7/bAmIdb5V5z5Cn/gcbDdkpYmnP5bqMAWGm1X9p
	98mcuPKLKWCL1u4KRkcvhAEvUKqa3Q5kQwBhevZSBLpyPhOHYAY3Y0IhRXU6/TAu6sR7oHVWrG8
	uTExgnKvwREs+pVFlTbQXBcjwqjR+dksSNWItBUkQ==
X-Google-Smtp-Source: AGHT+IFnRf2GQSKa550UVxDw9sIO7tr+JQRDDcfRdGkN4ltK9UKnQdGqlMbx32lOz9+0pjOTN9QiDMi3j93c4DGdHjE=
X-Received: by 2002:a05:6830:6507:b0:792:5c6f:1409 with SMTP id
 46e09a7af769-7c0df72937dmr2918784a34.30.1759948051398; Wed, 08 Oct 2025
 11:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008162719.1829-1-briansune@gmail.com> <aOacZAiWxG9XfWLS@opensource.cirrus.com>
In-Reply-To: <aOacZAiWxG9XfWLS@opensource.cirrus.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 9 Oct 2025 02:27:19 +0800
X-Gm-Features: AS18NWB-GcIZ_mPyCzjir3k6Fb5HGdTgNj6wS6-hz1NI3LVxsTOWjQPenFeav3I
Message-ID: <CAN7C2SCDNz5TB3deVziuNNYFnPV_hmrsPL1k-j5Dsj58wvC2rw@mail.gmail.com>
Subject: Re: [PATCH v5] ASoC: wm8978: add missing BCLK divider setup
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Charles Keepax <ckeepax@opensource.cirrus.com> =E6=96=BC 2025=E5=B9=B410=E6=
=9C=889=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=881:16=E5=AF=AB=E9=81=
=93=EF=BC=9A

> What you missing here is that your bclk_divs are sorted so all
> this min_diff is wasted effort. Each time you move to a higher
> divider there are only two options:
>
> 1) You are closer to the target bclk than last time.
> 2) You are under the target bclk and the system won't work.
>
> So the last value that gives a bclk above the target is the
> min_diff by definition.
>
> Thanks,
> Charles
>
> [1] https://www.nxp.com/docs/en/user-manual/UM11732.pdf

Document had read and indeed it mentioned it will be ignored.
I apologized on my strong words about IIS standard about extra bit clocks.
However, it just mentioned if there are additional bit happens will be igno=
red.
It never said this is a way to relay between MCLK LRCLK and BCLK.
As such I am still don't convinced this is a proper way to reach the
targeted S.R.
And my stand of MCLK <-> BCLK <-> LRCLK relationship still holds strong.
No matter how you do it, it will only result in a close result but not
match result.
Doing faster BCLK but unnecessary just make setup/slack timing issues.
Any specifications on how much you can overrun from first place?
Which make zero sense and reason to do so from first place.
If BCLK is slow then the final S.R. is slowed this is what it is.
Same as BCLK is fast then S.R. is fasted as it is.

As for this patch do the current version introduce any error or bug.
If not then I will stop the patching.
Leave it to other to patch the approximated BCLK.

Brian

