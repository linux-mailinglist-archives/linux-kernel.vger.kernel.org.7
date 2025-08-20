Return-Path: <linux-kernel+bounces-777042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43FDB2D465
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C3EC7AD7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022692D248C;
	Wed, 20 Aug 2025 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4EO9HPm"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F5211A28;
	Wed, 20 Aug 2025 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755673326; cv=none; b=paX3Y52odHLZvJdLaDMfjEUUiiGrJ7EE4SOB7SEQHcqkUtePtIdMPsAkQnhvsUqqjOX4L3MRYrGhgV9z/5Jytzv/rcaJK3BJ8cQNUthMrntWy7/UH8kyJjo9akXL7uaQ59Bv8W4r5lmJAkD/A6hbsSazHINhPJXUHFoSnF2O2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755673326; c=relaxed/simple;
	bh=i4ERcuBkz054ECPJjThNCwPQD6jSP8StzwVOwKtQP5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJxWADH2+Rh0GjUnJ/MPR124zjW6sBAU6fCAud8y4NvdR9W/1gcZio7+cLkYiWHedIuu+lNkLWoKAnJkfjWol901+N658a3ktKieITMSF1Q2uJ12X0qo3IXg0Efo8ZsLwtpIujpsf58YASZrr/V6ADKxCdWL/Pj5r+EcrJKhpRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4EO9HPm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24456f3f669so7427955ad.1;
        Wed, 20 Aug 2025 00:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755673324; x=1756278124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4ERcuBkz054ECPJjThNCwPQD6jSP8StzwVOwKtQP5o=;
        b=j4EO9HPmX+GqF1Wn9wFyqQLXQqr5q0UKEh9kuFP1e5iXfQ8rBDglRQwfACCeP8484q
         jCv6xrsbxlPI1CHDvP0V3e5zdpGNqi2nlDGpd7hsqH7IPlbhyiQrZPhnSDqqqVD4cunw
         n9Vq8hZ0PC/eiP2wOVPnddQ2uE28BmOrpYCKJCoqt6DdDTRqe6Q8kz3uSzXbVfCnQhid
         fRwWbthMnvmlb3L+0mXOYUoMidgJg/jKuOs2wFdQ6VCmAkjC8E3lcaBOpf7dUmR4X91T
         x6BKZzUbPQOQbMwf4HrS+ZoxJGISU7trdH4kU4NN2NLftiipVX9fUNiYHjO9tEJIYzfQ
         P3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755673324; x=1756278124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4ERcuBkz054ECPJjThNCwPQD6jSP8StzwVOwKtQP5o=;
        b=I9yBAX4TzyY6T74lgjSphJsXbiLrgbfPc9Ttztk6SX2CYVOnT4hQVnr5SZZloLVI09
         wCrcz8C8+Ha7OE/prXAkPWLH17DNhLdlyoIDTTFqAYlFO3oQRh4qIGMZG7X1OX8GicDs
         n92bXqLUuESIzFg59boSdF0OR1+A3qN3L62/geIAa9fsuMXO0pymUxXto/xs9Q2kMsOh
         KqhuElCR/CqYRLw2IWdBux1fSHlau/okD+0cm9FFGhUqfxUJsBqzhO7sTynutsqK1GAt
         zSVO0s7HjpHsiezLTVZHp/zjkTnQPGzBHpUZLc0oXptQLMOdjBRwm8tvYX8TQakaf4Yx
         EubQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7qdbFBd2P+GP2cMTn17sqZe9d5Kk2J5iCiVnB0A8b2YFgCQbnfhPs2PEnPt8Y/XiRmCLoDN/2u8vbWTc=@vger.kernel.org, AJvYcCX9mcGuNFwFxVQn6o/YrSXXkUMj4JNTyB/hNyILOWxUO3diq0vkiduACRA9GBS4aeW5lUtkhWAummAJbIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOcV2BlaOWOEmSILp2IfKaVlL+TQS/1LHNNYvpb66/I855XIFw
	DqttN5AXhjCHe0o70tuw+V/tYkFEVoFd/AuPBll+c2LcwAbWPzc0Ljn2o8ZFJ2c6djqPIvQTpp0
	7VHM63y4TXnmyJM1vgjgShQgaTrGLF6Q=
X-Gm-Gg: ASbGncsRk+fmk4aS0ORjkhAITarhI3OtV3CwqWxzTFG2a4aFZZcFmdAV5uySKkTFrst
	Arw0CXSw8Lzm0AXSXQ7conaDZIMLVODlIqGN4BOt6fcYMPuqp2VNUwUH/VyvttQWFvki2qLOCp2
	AzHLRxsi7FPBCGzkwaoDU0zZwS+S+Jfy9r3UizI9zM0flRB2xRpuJPqO85BErIKWZQiIednvcRN
	r8F
X-Google-Smtp-Source: AGHT+IHHPFivguwx59JWvlat8wg5hbDcpzsuPKOdRHB1YVSeDKLyRD8WBPzrIKMxhH4SbHdZoh8skwBl5m7DkXSMwqA=
X-Received: by 2002:a17:903:41c2:b0:23f:fa47:f933 with SMTP id
 d9443c01a7336-245e0930050mr60894285ad.8.1755673324182; Wed, 20 Aug 2025
 00:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819112654.588527-1-zhao.xichao@vivo.com>
In-Reply-To: <20250819112654.588527-1-zhao.xichao@vivo.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 20 Aug 2025 10:04:15 +0300
X-Gm-Features: Ac12FXwHe-YqwF-mmb4ygo_BKMAbaiq0WCeVkeFd0iiGVUmGKDnWjNYFXTSpa3Y
Message-ID: <CAEnQRZB=fq7=ahMkFWaQ58SR_yftSTYqZKFBh7YEXz2M7PyXsQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: imx: Remove the use of dev_err_probe()
To: Xichao Zhao <zhao.xichao@vivo.com>, Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Cc: lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com, 
	yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com, 
	daniel.baluta@nxp.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kai.vehmanen@linux.intel.com, 
	pierre-louis.bossart@linux.dev, kernel@pengutronix.de, festevam@gmail.com, 
	linux-sound@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 2:29=E2=80=AFPM Xichao Zhao <zhao.xichao@vivo.com> =
wrote:
>
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

NACK on this.

Quote from dev_err_probe documentation:

```
 Using this helper in your probe function is totally fine even if @err
 * is known to never be -EPROBE_DEFER.
 * The benefit compared to a normal dev_err() is the standardized format
 * of the error code, which is emitted symbolically (i.e. you get "EAGAIN"
 * instead of "-35"), and having the error code returned allows more
 * compact error paths.
```

Thanks,
Daniel.

