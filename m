Return-Path: <linux-kernel+bounces-868959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5DAC06962
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4641A503909
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C0631B136;
	Fri, 24 Oct 2025 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2AXO4Gr"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24CA2F8BF1
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314143; cv=none; b=EO4PrxsJegYyL6kP2Jy9FOm4dx2sg9hIUG6kquzOzuan31DanrydY7IA7ezXkyitYRz8ocKSGULyzCl4lZ1+kOFRNknzzphyvFLdP7naJkpqWgTPZWcQPnKN16bM2zbpvdrnP+9axAAWJhWbasrzDuDN7P2gJtL48px4O8tfvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314143; c=relaxed/simple;
	bh=6EDKzmWA6vlmVD1ip5IeawW7yR9cxhaXiCEY82LwkFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqUDRkO7fzrv5NNP9IftnPRiOhBxR5QWqkIfNOxchX2aqGUOLND1qWX7AE/gxIWF9TnoLSzaAGeFOpY4VQrkSj6+1mtKMEPmBX+J3dEEUYrGp4jjIWnorKVqJBfVRqX11CcdTHU5rJ1hgYNnsXMp4/v8Y7l0ZlrQ7oRoY/Q0NJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2AXO4Gr; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-784807fa38dso24798977b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761314141; x=1761918941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6EDKzmWA6vlmVD1ip5IeawW7yR9cxhaXiCEY82LwkFc=;
        b=m2AXO4GraD+3/tTI7p3vm8xmrmWaW0J5KoRgQjV+l4m599SVSJ/G5UW1l5/J6iZU6F
         lGuBZEZmiVr8lOQhSQewXC+9T2W2yvgUkOE6QEHjCk10eIm5Iudv1WpeS9tidKTIHEDR
         xvMVXMxidzbkXz96jyh3TIKSXyAuwaNM7eWFrxUJf3biQGn9TAAzD6QecCfpg509JGv+
         c16zW3cpCF9Z6JaQqhgxq86jwJHRnPZ34+1UAf9+XyAI1iahJaQumiZfM5mTanL2od3W
         yJRKVn1O8cWQRR3I2+yaXOZ2YEAWeiGddkUK7dC9hPuzmiTHoCde2k62Lmc7BS1Tubwj
         S/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761314141; x=1761918941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EDKzmWA6vlmVD1ip5IeawW7yR9cxhaXiCEY82LwkFc=;
        b=LZMlMfqG60Wn9Vz+LXpa1izkue22w/bx6nYRMNNP5JvlKLuoypisoQV5sUtipNqaTl
         c+A9W8lEG3MZQOfV6iJld0h/qAtUbPeP7MXoQVl2WNdpodMJT98YbZCp1AhQ4q+59Cyn
         bbmjStAC/yRELoikVGsMKijv9Xbdp8ICwSpP0TtAQ71VHSx6h2O2p8rc7SqnKeCpa5fS
         67aqi8mIwTXOQ0hvSEornPKFFVdh16MFPlaXNNPRzRIHXefPLFU3Lv3bd+R1uhoKlB4y
         u1kcAwiRhz9IeAMIM8mlMC50jSen8sD0KUku6KaEN2YCX04+eECVzCR6ooCZ9X/D6sSH
         IxSA==
X-Forwarded-Encrypted: i=1; AJvYcCVJVWscN7i5hEFUKTaqg6V6+Vx8W+1buAq4QykdTqjjG8dnUkwjWcHsjzL9KBPT1CYbQe4PwayTU1WXrRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN8accpPe6JTWAp37tYIuXMGPNlay+vZaC0dUn0Ofcw+oS8Whw
	6r6MhCCnIwj+9/VtcRA0k2YXQjswJ8BgZEV6Ikb0EtmnvtvzDsPqD0UUT9OVd36nU5xNgvMsSA3
	FMzgY4ad7HtDVvxgMHO3JPKYLcDKX4PY=
X-Gm-Gg: ASbGncvQO/Ieck+Jds6kmP8CBqrp6UvRgLrYY3J253MU32ZhlsoBMKy6ihH/5wHDYSw
	pCXmkou9i5JaRHXYadvtMvpLDz7aMBBr2QfEGMEnFFEi6tGvoyLeLHd0X4AmroMMQOXvLVZLNQN
	EVEG0g3aatRxbmxWthyPV0fHPMAoe4JVGaQeHBDpGGCxc41JT6BUXqwEbm/YOIgeejgaoxXEiso
	id43nicgbJuWF/yxePp4aCAmEQeiY4gdKqYMQjXIUDuwps072kURjSstBAjwPAd
X-Google-Smtp-Source: AGHT+IF/XZ65Pa5ogx5jpJPpOQOF+uykXf1zGnLo5yZ8TjK2GtNnECR7Tf/p1bu6J4Q696ZSiZuDwQwkYbc7ilxvBfU=
X-Received: by 2002:a05:690c:4b81:b0:781:64f:3154 with SMTP id
 00721157ae682-785e0267968mr21092467b3.64.1761314140636; Fri, 24 Oct 2025
 06:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023120043.8661-1-chiru.cezar.89@gmail.com>
 <20251023120043.8661-2-chiru.cezar.89@gmail.com> <dnjved3kd3awdseclr56mbwxkbuysxcezzbebrk7fjpuq2kf2p@rhat4xhdao52>
In-Reply-To: <dnjved3kd3awdseclr56mbwxkbuysxcezzbebrk7fjpuq2kf2p@rhat4xhdao52>
From: Cezar Chiru <chiru.cezar.89@gmail.com>
Date: Fri, 24 Oct 2025 16:55:28 +0300
X-Gm-Features: AS18NWACFyo8Vn7Z2PSDhb0T1yGH6jRvkczpxV8a7BTlO5Ni_PM3zGeBqde_w1M
Message-ID: <CANvS2vX2+ZRA_sT8gzmLmw9r7Z1aPEn9d+c=0QigPpeUYb3=sQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] i2c: pcf8584: Move 'ret' variable inside for loop,
 goto out if ret < 0.
To: Andi Shyti <andi.shyti@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andi,

> > Require spaces around '=' and '<'. Add spaces around binary operators.
> > Enforce error fixing based on checkpatch.pl output on file.
> > Move 'ret' variable inside for loop. Then check if (ret < 0) goto out. This
> > improves usage of ret variable.
> >
> > Signed-off-by: Cezar Chiru <chiru.cezar.89@gmail.com>
> > Suggested-by: Andi Shyti <andi.shyti@kernel.org>
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> you don't really need to resend patches for updating the tag
> list. Anyway, that's OK, better to send than not to send, when in
> doubt, ask.

Anyways I had to resend as I grouped 3 patches into 1 patch series

> For this patch I think neither me or Andy have been suggesting
> the change. The change came from you, we made observation which
> you applied, this is the normal review process.

Can you please let me know the process of tagging with Suggested-by
without resending the patch. I don't know how people add reviewed-by
or ACK-ed-by or Suggested-by other than resend the patch?
I've seen it but have yet to figure how to do it.

> If you don't mind, I'm going to remove them when applying (let me
> know if you don't agree). No need to resend.

OK. Do as you want and think it's right.

Regards,
Cezar Chiru

