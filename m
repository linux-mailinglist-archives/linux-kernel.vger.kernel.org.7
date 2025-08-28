Return-Path: <linux-kernel+bounces-790252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6BDB3A365
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CED189B671
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618401A5B8B;
	Thu, 28 Aug 2025 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="DIBZydPO"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA53E23E356
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756393338; cv=none; b=Z/apzYVmZzdAo7IOEOV+uk2VN6BK7DhSiA7lygwMBrMsW3jhS3KYUCPDjZwCwWVt3QIQ/5P2lZNhsZ680THyQkt4JFMqx7E4P1PzSCnH/lJMtCE37c7Lq0t5qUOdrKyJ8Ww6kqSg1hAeNI71j6oMcC2O3dBcF5uIdmMgo2qokKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756393338; c=relaxed/simple;
	bh=q6ddUStciG6COxuYJZfg8lpo+NvTrwyMon53V2tvsSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVACYqsCAZRyrbWpzflvafNvZZY0ZvWbMS5t0QgCN7Bqd+NtSUpECgBx+ydu4YrTf7JSlMpV43Peme37giOQWw+bLGKfgxKcKZLafrJc7RhhPoaoKRdtQbFfSWjIklL0PZ3hDmq6lfTELqAK3p21aOsAcmDflvs/TqXB+6rMsoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=DIBZydPO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b7c01a708so2655825e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756393335; x=1756998135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KR3uP2tHoxqPBYsBUj0fZf6IIWL0ISvbw8NHKPCMuLc=;
        b=DIBZydPOsLtYqzLkO5V2cscKUyt9QiRGHTxG0b175y12FobA7TPzmTVzXfen/Kjnez
         OzxvzUUMgGqERyCKNeFGVgw7ND7W7LvaF4lzb9ZL/43U7XQg6T/MCX4aWgR2Jcj/j2Jr
         Ga5L5x/nezpdaTJKCE620wUBG276q/HLluF25AEHdEcR9HYwLS4b4jMqIKUKVzP9xFY6
         3C5hSBd5f42z8J7xfcnps1BsuwmYrf9DIReCNGwCWGcIQ6ym+EYBTthgLI2q4LVN/RVs
         VIvK1J9JeQCTu0wZm2n+ze6bb8jc0N1A8WeMTsLm0lXA6PPMWu0wBrJfpUcI6DxY/WL5
         cmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756393335; x=1756998135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KR3uP2tHoxqPBYsBUj0fZf6IIWL0ISvbw8NHKPCMuLc=;
        b=TSJqb/G0iL7ADS4xkWSQTv0SN/qSibVfuobmIgLw5ZclS27Ye3q6mSkjqyFDyeeaGK
         wAMcf8Xu7do68goy6BQ7NLsDxDhjNy53GdtUqcs5+iXt2yQpRd3c7QHI3DL/gxN/pM9X
         RtTtVvjKDFmwFBrDq+LsmFVNXptqug9P119fFz0/mHoKHYJp+LS1BUjXgTyyhk+5yxEl
         AYU01KlOQ9kNaDUiVqSFU4tyreH5eyx1vZOQa2qYXHDmVfBpEPV8l5+arJbItyCxVxrk
         qspGpZ/6hUMsjYN0TmayG13+uXcc2UqkpKxCkYiMUnNJ9jgSaxFiH7c77E/p68zxLT4U
         cQ7g==
X-Forwarded-Encrypted: i=1; AJvYcCXiRBwMY1P8B3coON4vEXBKa0xRmdsM52BN/8qY7ZodftoAQHW/xh3ogZRu9X1EC1flxTFBZfl2CXvVa0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYR5qF7m7u5W/H00nHE1kNNFdf/JcEqM+zoIOUcqwW+kxKHn69
	psoNK89UorNz3S+Tc1hPkcMNjbOcNKhjJe1s9i7qbKsHrSrP9rmJozKChzS7K+g+HkU=
X-Gm-Gg: ASbGnctoMamweepFSw6nsHhgvizkdXR/xto3nBQXLytqwvh0jk9vBNs1UONaeqlnc/N
	ou0w3N4IEZk1Rn/ZzCF8Vk9PR1WyjOBKuVh2bOWW+xkxSbIeJdoG2WbkMAJvJh/lyMEiNFMLmuZ
	IwuOHPzDtOIu0TykEYQ76/6jjkjmnXi1BHLamqkEnRQEFwogoGfNVOkSo3/VFtDQ4WG4uL1ZPSZ
	FjNtFqou3SwUVaUNXLVpN0L+/F3aNLLOzQROf4h6iOBcJEevwUL0Gse21EUXZEOhz4wpBGZt6CF
	lPkdhxO1+josezRFjGe5kzfFztuvMSt2/g6MAA7WyEbSH4wnI2Fi+3KzyZl2AiVYdclZwGexyxq
	wrgphzLjjF2Ma8uOqJc1enixnM2LX4lQu+hp6RVVq6s5dlw5mWDgUJfckzlA9WBwaMpul6zPpcY
	E=
X-Google-Smtp-Source: AGHT+IGCT8QE0tuRPEr2sAjHd9Ua1F6DWShmwMCiVJhOf9bjKN9y/GnaNC2XNjeXc9uY7L7xQutnhA==
X-Received: by 2002:a05:600c:3589:b0:45b:765a:a8ff with SMTP id 5b1f17b1804b1-45b765aaa1emr30253045e9.11.1756393334627;
        Thu, 28 Aug 2025 08:02:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b797dd66dsm35576975e9.20.2025.08.28.08.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 08:02:14 -0700 (PDT)
Date: Thu, 28 Aug 2025 08:02:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "K . Y . Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Kelley
 <mhklinux@outlook.com>, Long Li <longli@microsoft.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] uio_hv_generic: Let userspace take care of interrupt
 mask
Message-ID: <20250828080207.6d9d3426@hermes.local>
In-Reply-To: <20250828044200.492030-1-namjain@linux.microsoft.com>
References: <20250828044200.492030-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Aug 2025 10:12:00 +0530
Naman Jain <namjain@linux.microsoft.com> wrote:

> Remove the logic to set interrupt mask by default in uio_hv_generic
> driver as the interrupt mask value is supposed to be controlled
> completely by the user space. If the mask bit gets changed
> by the driver, concurrently with user mode operating on the ring,
> the mask bit may be set when it is supposed to be clear, and the
> user-mode driver will miss an interrupt which will cause a hang.
>=20
> For eg- when the driver sets inbound ring buffer interrupt mask to 1,
> the host does not interrupt the guest on the UIO VMBus channel.
> However, setting the mask does not prevent the host from putting a
> message in the inbound ring buffer.=C2=A0So let=E2=80=99s assume that hap=
pens,
> the host puts a message into the ring buffer but does not interrupt.
>=20
> Subsequently, the user space code in the guest sets the inbound ring
> buffer interrupt mask to 0, saying =E2=80=9CHey, I=E2=80=99m ready for in=
terrupts=E2=80=9D.
> User space code then calls pread() to wait for an interrupt.
> Then one of two things happens:
>=20
> * The host never sends another message. So the pread() waits forever.
> * The host does send another message. But because there=E2=80=99s already=
 a
>   message in the ring buffer, it doesn=E2=80=99t generate an interrupt.
>   This is the correct behavior, because the host should only send an
>   interrupt when the inbound ring buffer transitions from empty to
>   not-empty. Adding an additional message to a ring buffer that is not
>   empty is not supposed to generate an interrupt on the guest.
>   Since the guest is waiting in pread() and not removing messages from
>   the ring buffer, the pread() waits forever.
>=20
> This could be easily reproduced in hv_fcopy_uio_daemon if we delay
> setting interrupt mask to 0.
>=20
> Similarly if hv_uio_channel_cb() sets the interrupt_mask to 1,
> there=E2=80=99s a race condition. Once user space empties the inbound ring
> buffer, but before user space sets interrupt_mask to 0, the host could
> put another message in the ring buffer but it wouldn=E2=80=99t interrupt.
> Then the next pread() would hang.
>=20
> Fix these by removing all instances where interrupt_mask is changed,
> while keeping the one in set_event() unchanged to enable userspace
> control the interrupt mask by writing 0/1 to /dev/uioX.
>=20
> Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus")
> Suggested-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> Cc: <stable@vger.kernel.org>

Makes sense. I think the logic got carried over from uio.
Does it need to make sure interrupt is masked by default to avoid
races at startup?

