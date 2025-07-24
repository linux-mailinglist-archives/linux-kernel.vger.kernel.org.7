Return-Path: <linux-kernel+bounces-743434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC2B0FEA2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC25C1CC6021
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A27A192B75;
	Thu, 24 Jul 2025 02:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIq6WftX"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446A42E36EC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753322731; cv=none; b=ssd2AIoERsTKVXQrYyzgxNHempzv7BVCQnbtBdwKGA/57Jj5jA2O0CozwRdwUGEwMKm7qPC8X3YHvSQPutR0bDtmBMbUSeb/gQRojBIa2V51s7nyUkjXNx1aRuDsihm5jWU8KeS7bzyxlIFmTDyXBjbQJE1N0DtJOmhL0BpXmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753322731; c=relaxed/simple;
	bh=qoxO/t2HqqWgt0wqaYNeB6LybJXDl4DsUk2bcFlF3Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePm76NVXYZZ1Fp5LiXmc2pMWL0nvdAtU1iFBMbD7eUcIQrl1yn+FzPerEsr+2Hath7AYwnX9jhydmR5+g1ewf+G7zk6S23cRGZD/3B0JjosIcCsJXGEONXWvEinzTblVMM75mazvY5/VWRXhKXWkt4wEw05Lk7Yl/ZexJzkMmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIq6WftX; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so80247466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753322728; x=1753927528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qoxO/t2HqqWgt0wqaYNeB6LybJXDl4DsUk2bcFlF3Lg=;
        b=NIq6WftXDYcLu4WwKDWpLYJ5ZiEUsPmo7YzWRqDvEU8wcduBTJAtptNerAeVwWHX3N
         vHzBXWOIA7dDlbU60Lfo5KGzq2Wrcf64Oyxf3Joig8fP8t/yGhO+x9xqbThCm34pDmTj
         X8nb0NpYzSAhitgzki9eH+I3S4pT84CG28n33BdwekTa3cMesme+bC7XHEMdSWN7zi48
         HBKwD6duNXOIHJJgWqBG/HueWk0ogtNHDRWNQl+rTEQPT/10jBthWn6N3UZFHKZqKRgv
         cZL80UxBW5TKV02yKNEu7pVXxf7BwlHWZ6lw2qt13dCEMgX+mfSvjyeRxO1aX/1R9QXx
         t/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753322728; x=1753927528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoxO/t2HqqWgt0wqaYNeB6LybJXDl4DsUk2bcFlF3Lg=;
        b=KwvRH60AuFn2ImZTEZZWuUjYXfDbstfYb9rQh+NbL77ay5BzaBV5GdzQqza0AgWSSe
         NolneuE5y1N4R4WZyKQIy8MVTnDNlD0ouWc5hrd8b4ltkB3LECv/U3rrJDHG1brRi2rk
         L+mkycwiDDSe0j5NYN5dN9/YoNwCXauTW5JiF+ur3jNQzd6MH0sQw83N5UIzXVHrHIAw
         Dk+cKosfrIQf/HAS29gBlcWKa/+pEd7JB71vFPQqrl8JM6Ij/4V/LirBiV1v841vjV+2
         Oin0NUTYyoaVHLVqvkaxkhZFHfUifNVyycnjqRUBb0y1cBoeP4aAakzqAUZCiDrcAoHm
         9lrA==
X-Forwarded-Encrypted: i=1; AJvYcCWbDrTRRrlaTa+ZFDJzCIvAuySEonrF5xxAjoYG5S5lRoS65FRSOeptg1/swUVi7REev27q2PLHwmHAkuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVJ3bhaL8s0REaaxjMUAMnF473LI5rliUQaGGbTiEuGJBRqBh
	4j7m1CzaPXXZ5hgqYLkT3H+cePaV3bwgGMSXrqhA6T7Me7TcwE3evS77S6XBFrzFV+xFvOJ0JWr
	pHB32QD/ag7sja/OXaaFvNHS16pQhPjs=
X-Gm-Gg: ASbGnctSoB8uIg5Zz289Hpybm52HT9ISwSP22IuvIeLRzg7Ty+QMmoxx7vcg2+79DAz
	umSoT7LkiCLVcBX7CMqq8HigXFWeAdzCf8dP4rIdRZmpOwqbEmrOCqdQa75WNC013NAIxjVAe+S
	icUX+C/SAFkWKDan+0007lg6SPrkSm3yLe3VnT1Yo7Xr/E+BUvv0unzOqSmS5rvlGYJz+K0+uLm
	XFgFA==
X-Google-Smtp-Source: AGHT+IHgT1htUDvnyjVtLqLDcTFKVHnNusF2fxhRiQSaqrcP2J0p2sXCbdzkDOVUVWIgORWkxZdDOuLiMVaW0R7k24s=
X-Received: by 2002:a17:907:608f:b0:ad8:9466:3344 with SMTP id
 a640c23a62f3a-af2f8d53bd3mr564341966b.43.1753322728253; Wed, 23 Jul 2025
 19:05:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9twUCJj4X-2jf0VG5+A2YN9Gk8hjOAhJ2hxq4SdgZfvtMA@mail.gmail.com>
 <CAHk-=wgLQ+EPeV+JzrvkPWt2jeteqwsRkf-X61jjfV8pefgXeg@mail.gmail.com>
In-Reply-To: <CAHk-=wgLQ+EPeV+JzrvkPWt2jeteqwsRkf-X61jjfV8pefgXeg@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 24 Jul 2025 12:05:17 +1000
X-Gm-Features: Ac12FXwgacPq_LmQOaqm7vLoci_B1iQ_12PFAOVERPpyC75eR6ZSArprlhiTSYw
Message-ID: <CAPM=9tyCq9kLeYD71oxzvkRzcAEqHjaLKKras_cottvZOogOGw@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.16-rc8/final (resend in txt for sure)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Jul 2025 at 11:59, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 23 Jul 2025 at 17:40, Dave Airlie <airlied@gmail.com> wrote:
> >
> > (this time for sure, plain text).
>
> I knew you could do it! Third time's the charm!
>
> I hope I don't need to worry about the branch contents as much as I
> apparently need to worry about your email sending capabilities?

Should be pretty safe, whatever muscle memory I have to send fixes
pull requests, only seems to work on the weekends.

Dave.

