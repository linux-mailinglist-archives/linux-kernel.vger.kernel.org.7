Return-Path: <linux-kernel+bounces-737908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ABAB0B1D8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBE25617C6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151AA2309AA;
	Sat, 19 Jul 2025 20:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGpgoMkq"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAB84502F
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 20:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752958071; cv=none; b=kF41HWvzTpLCnf2nMvLmkWc2/sdRxPG0NXb20/fmb6uSvZf83lAv3vH2z8mO4Lg296FZd5s3/3U/yK8qOU3QYCaaa4sRAr6+KweSUJPCIjvyYVRrWtspJINksWqvKoJH1WimBt14uh/NPFRKyHK8WW0gd3cX4/y5M3sNlsMjJjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752958071; c=relaxed/simple;
	bh=ZqBSMniEcaFXChwYMzdUsMBPNlZ1Idmp4wPb7MOhB8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfNmqpIRZrAs3pdmtGPrhKFRWNh53fpJj7zX6+xHeEjNZps6KYV4bpnsGiWrcFmDhUnp6eMnejQPzhX4aRX+lhNED456iaNww/TjnzZNe3DOPfbRpczsxqHU157Y4Wp4eq2sobRaE6QZrAQXVaYu9SAMdcc5j47cXU/gKLkYME8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGpgoMkq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313cde344d4so3274480a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752958069; x=1753562869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zX28BVJ93qamSCefMG+iWdnBnQuAtUdA3vDpxETj3g0=;
        b=uGpgoMkqFHFJsYvCYRYmb0J2FoMqIJH041sPllra/8oV+9xiib3ATfrr8d4bNty/UQ
         Q6w6DFHJOZmNYzJeLdknv5V3CNFtr9JwJSXRVyyqNV+3FZcyS/reByFitG1Adh1+SeKa
         jwf1DsLWNYrzZs5uAY9156URhYqjrjDxE8Py3Cp4qzw25h++C9kNv4oeDFV6k7MDnVJ3
         2ZwoRCBsjVnLjpnJvoZPsAOFfzUX3gEXxUQIUkwSfvWZXws2quSPNp5z57YpddKmX7FJ
         txoUigYN8QayDA84/+8aAQ5i3xgCj/w0aoIP2jrVybPChCW1oS5QhBZke3U+DNtF1Oen
         RHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752958069; x=1753562869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zX28BVJ93qamSCefMG+iWdnBnQuAtUdA3vDpxETj3g0=;
        b=n5H8VVZFYaxm8whDGWwBVSE8a1mZUGaIJ/fwmsqpoh1p3WUdjWzopVM3aFI9MR2rVw
         dpIKI+7F598O2oGgkSW98IiNv08zxQxyYTqogMcbPYwyVUGLnkSKiJ/iN9MCnT1Pbnh+
         ZhD7bDEkjqE2N6wt4ds+cpnGDX5CL9Yd/iQUWwANbjLJghuKftGgKuRf5HvnfR+K/tVG
         aW3jP8HbEMVG2MqrYhIb4G7EaxBVwJuIarEnbJ5tq16DYTgle3J9qFYsyPfz/GvP7OBi
         nUkhIJIr58OFgO1U6Rg00PahvOWWBliyXD5sswRprJUE4dE9BB17TfVb9eg3dk0M1gwQ
         r70g==
X-Forwarded-Encrypted: i=1; AJvYcCU/i9QptG+QNQ5gvxCgYDMLx7n6zN/gxcDq3V0h3t0+UPbuVP7/ulgvir72Xtzyn+J8DKIoUbh8vbVqFAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ/NshGL2bNJDhew0ZSEjuZpx26Y2wB2wFOoUZecTmQ8Wz2IhX
	jgd025/F0lP5DnnhDlGDaBpOrFvf+nglOQsVX0L0bJSWdZEx4r3vjggM+vHRujhKHpkb8hiTjQN
	X5y7zZZNeHxHznMBUNknMC0F+jDUSb6rzUR76S+ww
X-Gm-Gg: ASbGnct2shAxTXo7axbFxuwRFgcMRdfqmCPzVP4i57pIruU1Agl64uWtcc5UGaR6pwV
	G4IjVOuFbrcQ3ComEzYsDtNcg1jIwmrFbsagDdRIS/AgtXjx9wSnqzqw9PfWTfe0BAAXC1/TT81
	3paJ9NVSNXmRLOpSDR7ZEwo4NIgM64S4OsLHkm0Xaq9cmL+KXpkGBB4stc2KVlK10GThbyByV8Y
	8xvVI2bWHgE2i9AyJwSkSNPl7ym+UlXXOVypYn5B/wF/RY4j+A=
X-Google-Smtp-Source: AGHT+IFsBJFrAVwoybcbClhbtkk6+q8fn0XpsL29CyxbYcZsn01RsMz0QJdas5oeFENVsTV7mWK0xrlHVrkZaylEWb4=
X-Received: by 2002:a17:90b:3f0c:b0:311:e8cc:4248 with SMTP id
 98e67ed59e1d1-31c9f44e087mr26700843a91.33.1752958069394; Sat, 19 Jul 2025
 13:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1752870014-28909-1-git-send-email-haiyangz@linux.microsoft.com> <20250718163723.4390bd7d@kernel.org>
In-Reply-To: <20250718163723.4390bd7d@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 19 Jul 2025 13:47:37 -0700
X-Gm-Features: Ac12FXy6EAOOfaaxCqmoRw0ddlTwqZX2GFu92iR5XeK54Otp2RZbW_v44V-SJDg
Message-ID: <CAAVpQUC_sH2UDdf0e5c=iPFU5EcaB7YeN=__2j6w_h6_pe8m_g@mail.gmail.com>
Subject: Re: [PATCH net] net: core: Fix the loop in default_device_exit_net()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Haiyang Zhang <haiyangz@linux.microsoft.com>, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, haiyangz@microsoft.com, kys@microsoft.com, 
	wei.liu@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 4:37=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 18 Jul 2025 13:20:14 -0700 Haiyang Zhang wrote:
> > The loop in default_device_exit_net() won't be able to properly detect =
the
> > head then stop, and will hit NULL pointer, when a driver, like hv_netvs=
c,
> > automatically moves the slave device together with the master device.
> >
> > To fix this, add a helper function to return the first migratable netde=
v
> > correctly, no matter one or two devices were removed from this net's li=
st
> > in the last iteration.
>
> FTR I think that what the driver is trying to do is way too hacky, and
> it should be fixed instead. But I defer to Kuniyuki for the final word,
> maybe this change is useful for other reasons..

I agree that it should be fixed on the driver side.  I don't
think of a good reason for the change.

