Return-Path: <linux-kernel+bounces-880312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B051C25718
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 787044F3C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564C525B311;
	Fri, 31 Oct 2025 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nzr0qeRc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C43921FF25
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919444; cv=none; b=jfE1mTe990WH+5PUvRqVDtQ9XV2kS8zR94iJ129WdYGoOevuBM2VxtSnATnqOgxHminaL72TOzhSy5iYJtDKEzn1MlZGrL3zs/GOFC1PjTOQGviU3LaZFT/176Nzugf53PXqLhToZh5B47q9VahcjSkka4D/+WI8HsYX8Aa4v4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919444; c=relaxed/simple;
	bh=8a2FDFsOQQm7Af+U7kvhafozxquJhhTyqVq7CzJ2Oo4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z1J4jZ9RGNmq/5SoK1q+zDMBnJGEbKsfjQe7NXH4mQyF0n0A4jF+thBOjX/9vZPwl8vFicbvQ0fjfZ/E0ujbLypbcvx8H5ogB+7vuMSdqbWNs9MoNhIhP22pQhwZ8ODdoo/7ypTZmw5byjGc2sqBCy0h2ddyTzylBwD3ekJUJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nzr0qeRc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761919441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8a2FDFsOQQm7Af+U7kvhafozxquJhhTyqVq7CzJ2Oo4=;
	b=Nzr0qeRcPY0RVgBkDYVa3uQuH0KYsMrZUegUJxXEPeBXeFCq8nU4EHEIcssbHzTlWlOiUj
	KeWuWKO0nESx/2PxpC1cJqrR58xikLIq00/ihn1jfY25f0vR7J+X2ePA5MmG5MvDKXfHI0
	Kz8O+knZpgijka9F/vBj8dEHQwK+fwI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-j4xHwsRiNk6ciRTCnL2kQQ-1; Fri, 31 Oct 2025 10:04:00 -0400
X-MC-Unique: j4xHwsRiNk6ciRTCnL2kQQ-1
X-Mimecast-MFC-AGG-ID: j4xHwsRiNk6ciRTCnL2kQQ_1761919439
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so1782912f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761919439; x=1762524239;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8a2FDFsOQQm7Af+U7kvhafozxquJhhTyqVq7CzJ2Oo4=;
        b=fjlTsYRWezczT9xpKXzOv4qAlEkc8tB1nQQ0NS0336VZt0ARd2C049goGo+jRSWgPs
         ndxVaGd7yv832Td7hQJxkn7wnG+gAQHB+RrfbIkcWKfd2mY25wyWU8lWizMVvE9y+PNM
         pIq63SQUAVFKG69sLP8To7/kcOBsMlpheb1JSAhy8oIiDi4JT7V9EXVCse2icn0Wbd0N
         hXXo5McWVI7jyUpM/nwjRWysRtjJZI/B/IMJcI5xycYxzx4+5gGfFxS0/uGWeez9T3GO
         9OvIiH3trESGhZiY/W9ipcD6EycpSfLkVKhNUjCnzpiUONNL/ZJJk+1ZC4FyepT0WgJK
         iGsA==
X-Forwarded-Encrypted: i=1; AJvYcCV+q+SM7Ji0U9/poRjEnUuNzWL43EOS+ZPB78zV9LSFinosjpVG36UpXsdT4s15nZ76NNc0h4HbyNVTIvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7yWrw06HuSOMuaXndUN9lJlNpnElASTV2wHDhBOuTUfdVccgx
	tLEzwYPh4TGpKvTehVBZROJM/t3gX1LiX0ZB02EFdgg44okGks3sn6tFJJTKsgWPXtHgUjpl3MV
	gHeTiRuqrS/uoSttBwb94MfPBSzhjAdF+LuAlkWL7QP/lUQvO8uQJdGPKpnBH4332xw==
X-Gm-Gg: ASbGncsGr4owWJHO1mAfD6w5HfAkNfrD+Bb/n6U+DPzAprL/P5AfqILRP7IV+oJB6R8
	VM8mFc9ZcM67LIvl4cMbST78YP9lDlLRL3/OFc7itQAOIWyKMbRmQEHWSSD2RC8d05uVTwHExL1
	ZU7EmfWmlQ4OVLh57R892RRDUvveh/HiMp65RhC29WJh92EjbOV/mUuY9d6skMnEEaMaZ5BVoHl
	yVEyDfpnlZrqW4Tgb2uR8pc9o7+90zaI3zFWNNxxvmR71ruSYjUPdC6HZ/QDYy1JJ6Ylfs6lUW8
	OWG4guFB/6isCEo5Z/phRBq/oF2eY5Y+C13F6i5S6TUKeH89kLEXnXLo7CRgSRKH3cQy9qIeSNZ
	hEc8Jm+Ct36SIyhJbuRyidVsL
X-Received: by 2002:a5d:64e9:0:b0:427:6a4:93d0 with SMTP id ffacd0b85a97d-429bd6be770mr3064672f8f.59.1761919439146;
        Fri, 31 Oct 2025 07:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDF9l8JSchzVCtnoQy5ijK1zVjnL6sazsdFxSMnthezTtq0WVV9lEBoxlg1IFoIeZ7pl0tdg==
X-Received: by 2002:a5d:64e9:0:b0:427:6a4:93d0 with SMTP id ffacd0b85a97d-429bd6be770mr3064634f8f.59.1761919438661;
        Fri, 31 Oct 2025 07:03:58 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e0311sm3616052f8f.30.2025.10.31.07.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:03:57 -0700 (PDT)
Message-ID: <5ee084ed5fea93aced2a3d78ddb480e84b57a68c.camel@redhat.com>
Subject: Re: [RESEND PATCH v13 0/9] timers: Exclude isolated cpus from timer
 migration
From: Gabriele Monaco <gmonaco@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long <llong@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>
Date: Fri, 31 Oct 2025 15:03:56 +0100
In-Reply-To: <aQS-M_6_97ZLk0yH@localhost.localdomain>
References: <20251020112802.102451-1-gmonaco@redhat.com>
	 <3c1e6b45-79b8-463a-8c41-565d9ed8f76d@redhat.com>
	 <aQNySRvImq2yaUef@localhost.localdomain>
	 <5457560d-f48a-4a99-8756-51b1017a6aab@redhat.com>
	 <3ac28b2bf33086a77333791df39b779d55c31df0.camel@redhat.com>
	 <84511fa7-3a28-425c-b0fd-8d971a5f7eb1@redhat.com>
	 <aQOcC1GaUlLWsUPv@localhost.localdomain>
	 <4421ec3d-e4df-4645-9b68-261080bd4760@redhat.com>
	 <aQS-M_6_97ZLk0yH@localhost.localdomain>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-31 at 14:48 +0100, Frederic Weisbecker wrote:
> Le Thu, Oct 30, 2025 at 01:57:50PM -0400, Waiman Long a =C3=A9crit :
> > These 2 cpuset patches are actually independent of the timer related
> > changes. The purpose of these two patches are to prevent the cpuset cod=
e
> > from adding isolated CPUs in such a way that all the nohz_full HK CPUs
> > become domain-isolated. This is a corner case that normal users won't t=
ry to
> > do. The patches are just an insurance policy to ensure that users can't=
 do
> > that. This is complementary to the sched/isolation patch that limits wh=
at
> > CPUs can be put to the isolcpus and nohz_full boot parameters. All thes=
e
> > patches are independent of the timer related changes, though you can sa=
y
> > that the solution will only be complete if all the pieces are in place.
>=20
> Right but there will be a conflict if the timer patches don't have
> the rename of update_unbound_workqueue_cpumask().
>=20

Waiman, are you referring to [1]?

Since that is an RFC, couldn't you just take in those patches before mergin=
g [1]
and adapt just that one directly in the cpuset tree? I guess git should fig=
ure
it out if we keep my cpuset patches in both trees (or at least 5/9), as lon=
g as
the conflicts come in later commits.
Different story is if you already took some conflicting patches in, then I =
can
look into rebasing as Frederic suggests.

Thanks,
Gabriele

[1] -
https://lore.kernel.org/lkml/20251025064844.495525-8-chenridong@huaweicloud=
.com

> > There are another set of pending cpuset patches from Chen Ridong that d=
oes
> > some restructuring of the cpuset code that will likely have some confli=
cts
> > with these 2 patches. So I would like to settle the cpuset changes to a=
void
> > future conflicts.
>=20
> Ok so it looks like there will be conflicts eventually during the merge
> window. In that case it makes sense to take Gabriel cpuset patches but
> he'll need to rebase the rest on top of the timer tree.
>=20
> Thanks.
>=20
> >=20
> > Cheers,
> > Longman
> >=20


