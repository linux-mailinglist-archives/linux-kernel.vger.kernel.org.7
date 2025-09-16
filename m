Return-Path: <linux-kernel+bounces-817980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55BAB58AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FAA83B29DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5531C4609;
	Tue, 16 Sep 2025 01:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3SI0fwi"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C3CA4B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757985439; cv=none; b=N/UtL+53pF+iRrnHGqZ3hOpL98LsfV89RTkRO0GU15vfd0ZF7NxOFDoLf10bJ5qXstLSPWJsctps02hkscdCTBftW2dZvQp5kK1xeE20B7vr9tQDU3tCWUPNrX6o5QFZyDMWWtuv0JU+wlBN6EM2XINYDbwkrP4vQzmdh7c3aRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757985439; c=relaxed/simple;
	bh=PyJB0ENIMUDRtIURvvD1XkQGW4XedUBpE0oQUvJrBQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVZrOSPRKEENDxw9ms7wKKndAUO2fS3VolqhWwdVO4xgxfv2cnF9kr6VUzbL8+Zb2oVNjwTDbZwnO/4pPrhwERMq1vx2xST5JTI3fVoiQNsOqZQlZXmPFHal+ozre3YdesVA5aXGG7hUfKyVFivAJzB2HWGcmTTYQ56lTIhrfCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3SI0fwi; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32e0e150554so1691214a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757985437; x=1758590237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyJB0ENIMUDRtIURvvD1XkQGW4XedUBpE0oQUvJrBQM=;
        b=V3SI0fwiPw6AyxvQNoI2VAu6DyVN3eMKaJCRmCdHyCErbL5r4lJtz6j4l3g0ba9tcl
         hIdLcJfwZRaIUEaZw75RUgW+0MZCpVpJSkDkD8wJv7LRreNc5xmdZkDOzWRr6zJFslHs
         nXQjlCxIXBJyGaUND7lzj7lll4T7H4Ng03/6gUP2uOy+j6vZVVok7Xr/q+WjvHOlpV06
         vxUkfQumWyrsxj7FAVAXhL/sjK7AjCigFVZZ2m+yK0MLWn8+1AYuur6gu4CaM9cwhBdo
         IZd8EPNFD36auBpJAq/9P8PbNTaP7rGDwoD29nHYmPTDwA1c0lqJ009BOAeaa29hA2fE
         4fIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757985437; x=1758590237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyJB0ENIMUDRtIURvvD1XkQGW4XedUBpE0oQUvJrBQM=;
        b=Ltn3Qt45rPfZ633ugoPUmROuvJM+SBmlRFes17e3mgFVPdOsTeeofehKaeErKq10z/
         cFHGe297ZV0pDkBMzJG4jpPfhvCyw0CU/Rnib7yn4Jz1MqlSYx3IXEux5tkPvHyc8EcD
         ho47g/RO4LTg5+P+PL6hZ19qi6lJT4DTXXkYED39KhAuCtwHsK3XL54zCSldL99C0K6l
         w4t3aJ/OvZU4e7lSgzPYB9ibe9owqURmz/i0hVxCk+uvcyIt/Dl3XI1eVsj+K3HlVh4M
         RnXimiuAT0mWcaZ85FXZhnV0ct7rKPAk76JHKasY+p8eURAKp27rtIwli0Ct5AEx/bnV
         /s3A==
X-Forwarded-Encrypted: i=1; AJvYcCXYbX6lzPzemwj1d4hXQWZp9Zk6WGW9AiT9F/oRNRr4EWkCkNz4O1+Ke5PFpNgpFd5jHfRvrx1D0IckicI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTeKcHn+tJWp+R4lQe5T1yLwsmlYgRDAceNvpajmXEEQOdxy4H
	GEklRrhD2kuIb0fteLWxvw+B0MnYyxDZzeLcHcwJn1NmWmXJ8kbHvyldctXO2hXPABqWaqe5jbc
	Tl/1DbGB027sJvoi+9EP6DkuS0BJ4RCM1sazJmjh80g==
X-Gm-Gg: ASbGncu66r04zOHNZl0FjarhJ7NRZUcf4SeVewKZ2zVJiUMO6shieQHHfHsOnl9bZJH
	Y/B18qwhdmdmfY+mTVBrFsHr57EX46KRUVaEamfDGhG0n/RFisaj3u0UseyTWvrBY/GpKFxfg7v
	4DHpYfeOM5DqDTzOhGqwjGc6b+8K0ZNdJS1pwa035V2HMhG9ZOSgNGfEWNLahF1zdBfBp/zAG4p
	7o+q8rnMg==
X-Google-Smtp-Source: AGHT+IGSiIkfYJ59AMKEF3SSALX/as6soLj0t8TIeO3YT4o0IJDiCKHFjMlLYaTp3IlNzB9lzvDnIffcwlkjKK1oicE=
X-Received: by 2002:a17:90b:4ad2:b0:32e:7340:a7fe with SMTP id
 98e67ed59e1d1-32ea63043f5mr611572a91.12.1757985437480; Mon, 15 Sep 2025
 18:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915130606.97949-1-pilgrimtao@gmail.com> <41ff57c2-19d4-495b-ae51-f30e555a74b4@acm.org>
In-Reply-To: <41ff57c2-19d4-495b-ae51-f30e555a74b4@acm.org>
From: Tao pilgrim <pilgrimtao@gmail.com>
Date: Tue, 16 Sep 2025 09:17:05 +0800
X-Gm-Features: AS18NWDEBZP93btmwWYHEn7-NuuwXh2fW45dap0sZybJORI2jvMNz_YOASUEO7A
Message-ID: <CAAWJmAahdw_nprJXni_2L-WgfVK=6pR-F7hW7Hj1fwhsi4p6mA@mail.gmail.com>
Subject: Re: [PATCH RESEND] block/mq-deadline: Replace DD_PRIO_MAX with DD_PRIO_COUNT
To: Bart Van Assche <bvanassche@acm.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chengkaitao <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 11:59=E2=80=AFPM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 9/15/25 6:06 AM, chengkaitao wrote:
> > Remove redundant DD_PRIO_MAX and enum types, Move DD_PRIO_COUNT
> > into enum dd_prio{}, and similarly for DD_DIR_COUNT.
>
> Why has this patch been reposted? Last time it was posted I explained in
> detail that in my opinion all changes in this patch makes the code worse
> instead of better. Additionally, when a new version of a patch is
> posted, it should include a changelog. I don't see a changelog in this
> patch. Please drop this patch.
>
Regarding your comments on the previous patch, I have also provided a
detailed response. However, since I did not receive a reply for an extended
period, I am resubmitting it in hopes of continuing the discussion. This
patch is simply a repost with no substantial updates. The link to my previo=
us
response is as follows.
https://lore.kernel.org/all/CAAWJmAbumBHVo-8neC+b8WqJzzLbWqARpc3vkBsgs9j08w=
h3kA@mail.gmail.com/

--=20
Yours,
Kaitao Cheng

