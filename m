Return-Path: <linux-kernel+bounces-815632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE5CB56932
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D127C3BCA4D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6468C22AE45;
	Sun, 14 Sep 2025 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNVFUZ02"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B40919DFA2
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757855835; cv=none; b=Tnv3HRMIVcdyEJPMoJcWKVfhu4kPYnl+TG+DIZj9CbPL8baV4oJlQRt4NwJJzn8haYP4F2Yv9GbbhchGnMyBX9aQOakKeoVO72PzTjJW6oxuv7sXtAV57u4hQ7xgccZ9T2jg9gACjxbppYmnmDmfu0hQ3BKkVlH8TLnBwWLSMTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757855835; c=relaxed/simple;
	bh=4IJzghTZyFk+V7nl6fQn98vKJnXu9hEQAbqGTMr55Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/xYWuFPQKO6FEauD+GgPFSP1KKusRswOj+aFBkjNmxVc7fWte4wUAMn73PW7YZy4B/FFWQQlaeJUmkEzorauYZMzYepgPwmHNHmrq9wqQUjbOtXoQu6lY3rhdFxU5Fb3xVM0gxtvM9vAVGyvXgiFQyCPtS/rUHkN09StQMmbzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNVFUZ02; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b0e7bc49263so41684366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757855832; x=1758460632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMvCzG2QohEMnNbVfOkDiJ2slh71CG2iSq4/6TwPDRY=;
        b=eNVFUZ023qOvwSPxEYP1hQu7C2nF8+9zjQUldquGucEAqzQomr6AgrX/zDfCq5mCb2
         ekwlR3hyJOh37T/haVyfpDY+Da7rjvjtd9EBV13aDF9NvPJG7wauyiMS4nj0ytfjpDqI
         PDy+iSorZjbYB7opSx2xmEt1CymbwOeRa5EVEq8aXj6nYn6IBiRj5R1gTWUcPOy14kLY
         Ly1WdAfWoUhWOr+VxDo2zXFn0mgmS3ycYOmzuFW8SfhUtyoAkDRV//wdcXoqXe5KB4o8
         hpN08t7b3BckEV1llpqexzS7pm4wNiDAZKLSiJQAmG1fBgxcieXS/QBCIRrIzhV7xcIG
         IixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757855832; x=1758460632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMvCzG2QohEMnNbVfOkDiJ2slh71CG2iSq4/6TwPDRY=;
        b=N1F3yN2ROA22OVG9I2/fcvgvxEzK7SWJXiIDizEapRTqloa6G8/tk4o/qfjxcCd6H4
         HMpcGsGlS89fqiOU8fxgYSh7AKGpk1yrsrdlNiEzhaC1/lfs8s4tw4a4MbbEvEyzSmbE
         5+f+1ozXJMQd8A+kUVbYCVi2uWQuFu8cF11Kh0tyP/yjv11aG1PASxIwa7ZFj1jLWvDh
         iJBk+Z39xR3pZqBMKaqpYbbLQflovdKy55SSGHszIJ0ir8oZKsfUUXRJwVoQ2FXhAflK
         Mer5OsM3B79Jb0oCCwVSTOcQU/HPsa9hvSsDUe6Nhu6DHGdch+yMzD3Dt1Aesb3+iMQe
         MwLA==
X-Gm-Message-State: AOJu0YyJ3lxZPVv1xppaenzdYMatDn5t7m/OC/5yqA+UUIIIuiaA537u
	7c9TcN86pKgzB+0mhINu772wQiXFJ/jg1tLewJWBVMv3RhHaz326FrF9gm1QNL1sPqsHi6Bb8Q/
	II8bc1QXSHqX5vw7rg257WGNcxFzNFKE=
X-Gm-Gg: ASbGnctOB/oBtI2LixFFKFRKXBgelqKUA24ZdNEumXaEh5eCC+FH5TQlUL/+vEasyC6
	9XhxXJM/BK27IL2OtuxaUk+5oSmCTpiFtBdxuTqamMeKKArjSdr/XQLKyfuQQ45AV0Y2/d4tsJB
	fI3iCBz9E+cpSLp0NJCSjHQ//BNr5SrJNwbL5+ACta5qvVQfYgz1v4rMKmn2eEBBC+ZfbttYd3L
	FYyJeg=
X-Google-Smtp-Source: AGHT+IGQWCxR2Gac4xPiL8D9KgXgiGtd7tFcnyGpphGq+VIE+n1JrTdBZSMFUWqAi5ICISdmwA3yCJQTbDVPKdRiYZ4=
X-Received: by 2002:a17:907:1b1d:b0:b04:2edd:280b with SMTP id
 a640c23a62f3a-b07c37e1907mr843954466b.39.1757855832412; Sun, 14 Sep 2025
 06:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913204110.24980-1-shaythomaspower@gmail.com>
In-Reply-To: <20250913204110.24980-1-shaythomaspower@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 16:16:34 +0300
X-Gm-Features: Ac12FXxzo44Yh92_XgEzXec_KthqwpOATtacfY4xJGWidLeF3FTQ72dLqmHLyew
Message-ID: <CAHp75VeBq4rR0kqhFF=koN-Za_RdhWbzN0W7MHF4LWORsn1WAA@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft/fb_ra8875: replace udelay with usleep_range
To: Shay Power <shaythomaspower@gmail.com>
Cc: linux-kernel@vger.kernel.org, andy@kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 11:42=E2=80=AFPM Shay Power <shaythomaspower@gmail.=
com> wrote:

You must provide a commit message explaining "why?".


...

> -       udelay(100);
> +       usleep_range(100, 150);

In both cases this, besides not using fsleep(), moves from atomic to
sleepable context. This is the must to be explained in the commit
message as this is the main point of the change AFAICS.

--=20
With Best Regards,
Andy Shevchenko

