Return-Path: <linux-kernel+bounces-896921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AE2C518C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 684614EB496
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BC12FFDFF;
	Wed, 12 Nov 2025 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MytEszeF"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBEA2FE580
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941428; cv=none; b=OAtQgUeDRn+iCyOTKm3VUof8WAi39FuulQGJesvpF1vB0yONS+klkysVpzc/AmZeAF4T6HgS9vWWQsBYU+YCp0Q7+ws2sRJTc18Ceo/kilX75QAt/0+Gqq5zrus8Dq0CmaVzoJq8QUKlox7+xOpyOdPqkn9x8XpEpX4vjOSriqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941428; c=relaxed/simple;
	bh=CIbkZoEcvxMuArEM88rMsYIiHa3ILLozzeTvmZfTtT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asI9PAaDCaBk5AKmFXZ7pRUuUW85mC4Dc8bhDT6gVDzn+zs/B9ucyD9xPfWaSzyZ+bpl9OBKrijegiJC2TsER05ZlAt8aJX1/VeSbX18tEpIy/uV3+16YdTBHEY9jANQLEHJ+a6KDjD/UiiQb9ICo1yI7h0zO1Z/mj0DfJsN/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MytEszeF; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b983fbc731bso24172a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762941426; x=1763546226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIbkZoEcvxMuArEM88rMsYIiHa3ILLozzeTvmZfTtT0=;
        b=MytEszeFd0wvJ/wuqK6NxlN1QefOYVAO9HXEowT45u60+HCefw/nIrfoaXUhufX2nU
         OkHgE1D4A9iOBTlIofrniMgpiqFrKF75GddJ3Oo+JCfYBQg72HHTIBCx3dE+fGZnTvTu
         1gwrZNUsThvakhEB+6FDzD4zWq8ue6oIWN3IHfKzurWTANuMSONyGxpEec4xQbQTS2rD
         4vSFASjxFFOsB6ledt3cJT0SLeildTq4VcMUJj8cseWdQYRqiIQGqT1qIN7qyGw/SQSX
         aM9EjLnf8wl8CvXnBxun86n+eKCkZ3Ix7JJfd0GlX73XpVzpFplnvKeZ9swM5HYITGtg
         3csA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762941426; x=1763546226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CIbkZoEcvxMuArEM88rMsYIiHa3ILLozzeTvmZfTtT0=;
        b=X8Yl6jT4b0TRHmj38+3VY3BotgcBJ6sOQa4AUgtsPl0aZSJNGTiY3JSmxW+blBM2yd
         jsW03xAoskHul6nNL2K0r9tB+kA9v/r89KpNkovL7hOy2n7Dr9yhfgzaLWfLjh0Rerfq
         mu+NwYlHmwbFVlufBxukEtaFm0D4V62ugZgaJPCNwpT848M9VLmV0bEqS4GhceqOMdDV
         jXSlC+sDRYko0Cqby7VRStwrFL24vYB3294cc3rHEr+Yn9FKZUJc6703LfEp7brWbL9+
         J9UBxAznWFSL20Q6cxkXMSCUPW8Q6DaPnu4YsGAitjsaruqL0WVXrkRtBQxfAL2t9b1G
         HkRg==
X-Forwarded-Encrypted: i=1; AJvYcCXWiaQSUZfFatWcYyUinRfapwM6Q1vaY9DjYp91vHEu32HgnBgwB6Y/PEDQ+0JW1u40aej3zxNrGKq8urQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAMbRl3gdZD9ZeTYXRKhFL8OQlb5tWRupzNG8NdwavSQuPKE01
	ZCFR+iND4+nrX7N1HSihMyc5nN+MDW9P8D539C64pPxGDjE8MrbCT0xi6eq++Jz7yDuG3JHZoIp
	LcPIKW8gpXVW23qoLJ/djynGPzvJUgLs=
X-Gm-Gg: ASbGnctfC7t+taychlDmIu7lRrbhsOsQDIaIgzmpVtixLZ6HRST79yxb5/8Bjksdzki
	OSXHSClCB5RVZFbP/y8Qn4Cj4tYRKWLwVtUjcOJuOyIhX1iZiX77ndp+N065ELTIIkRWtBzPEDu
	cA0oz7GQu4bS9/5H0QqraTf32r6JzsdRGjJUZtQBEL+puYKWuZo08L9o9Jc0YqR4XQWnKvWNnBc
	IWsGdJZMf2iwtB4mSUu98pUDcuau99yTEvzybzxFCoMtJK9bGCRNKyTq+smeKlCZAobydeutJsX
	+uJ25CV2eJHHkSXluRKxV/iBium5dTMLcebCkUdQEvuQ7Dc3n/NF7KR3eDA+He9qM5IhxdknGxR
	xcDvxNInV5TMl6g==
X-Google-Smtp-Source: AGHT+IEhemJfSLH/p4Bhjk03hiHG8nPZMckQ4o1gzMhDR33YwdnDKqTg/WdwFRNF3u+gDynCToXBRDMfK6PTspqbdUQ=
X-Received: by 2002:a17:902:d4cf:b0:297:fe30:3b94 with SMTP id
 d9443c01a7336-2984ee0ca79mr17858365ad.9.1762941425924; Wed, 12 Nov 2025
 01:57:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101214629.10718-1-mt@markoturk.info> <aRRJPZVkCv2i7kt2@vps.markoturk.info>
 <CANiq72kfy3RvCwxp7Y++fKTMrviP5CqC_Zts_NjtEtNCnpU3Mg@mail.gmail.com>
In-Reply-To: <CANiq72kfy3RvCwxp7Y++fKTMrviP5CqC_Zts_NjtEtNCnpU3Mg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 10:56:53 +0100
X-Gm-Features: AWmQ_bmwDCOcARGiEKIpjIRnRae5yfDKTRIUwc3OloyDgPkRmaMpijy0lYQ_hkA
Message-ID: <CANiq72=yQ1tn0MmxNHPO4qOiGm7xZzHJAdXFsBBwmFdsC37=ZA@mail.gmail.com>
Subject: Re: [PATCH] samples: rust: fix endianness issue in rust_driver_pci
To: Marko Turk <mt@markoturk.info>, Dirk Behme <dirk.behme@de.bosch.com>
Cc: dakr@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 10:37=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Cc'ing Dirk, since he tested the sample originally.

i.e. a new Tested-by is appreciated if you have the time since you
tested with QEMU originally, even if this is a no-op in x86 (where I
think you tested).

I guess we could potentially consider something like returning a
wrapper to force us to explicitly pick either LE or BE to prevent
things like this.

Cheers,
Miguel

