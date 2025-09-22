Return-Path: <linux-kernel+bounces-826704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF44B8F27C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236FC1647ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9974E254AFF;
	Mon, 22 Sep 2025 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lc5SqjpP"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505AC223DED
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522778; cv=none; b=bYp8x7AtJcxTSZHCy/TlHjhipxsvCppJElf0BsGAvHmirxJeVMYUMTrHjkzff2H/i7m3CG08sxGl5aPaUG5J9rsdLtJ923H6xwG9af+rVB5UM0KJdAXoTlHD+5HYpgDqC1smYz2AEPrnRyV2Od8THEn0xgFSP0EBhYY3GZNPOiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522778; c=relaxed/simple;
	bh=wYD/M6PxWq/wgZene6AcBP+PiIeNlODJlqiaad3A24w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0+hB0eJsmVxKYLq6KUDwWRhNKAcb2mk+XdedcnZDqD6lnr97rfsne/+5xsNfDxW4EbnRKhP/263bp+lAYq5JWy28fC6uATmXm43Yt0vG+1VPT8+uv2jsxASAJlJXbpC0iZQSCWDBMUfSXnK+5/yafeGi5a3QQmS9TY6PLnd+Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lc5SqjpP; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b29ebf9478bso153378166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758522775; x=1759127575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYD/M6PxWq/wgZene6AcBP+PiIeNlODJlqiaad3A24w=;
        b=lc5SqjpPrLs8tcBKKoL3pvOyuvcbvFapwBfqPRE2F1sIL+vDghgYjAV0mk6YlN65gs
         JF8MRJKiMnJgD4z/n8qWja/UTDQemsCtJB80X/D+6dV10NqfFHDX1mVRq4hYm/BsKtMY
         t/MlcibUutM7BxroowdrWBlr/evMim/Q/MdqNJDduaqC3t8AQ/J0k8FL1d3LvaAOG07l
         KVZjvf888RxUehAEHheOeogOU6B3lA1OmuDoYroPy3uoQf753Ev1B6ssuk7mTG+1nxb9
         JHA7rHP4yvkvqNIgxl17tAZhu3VXBM4z3UlDDTMY//xnrYwKVO/DQQVmJ9Burmx9CF6k
         LJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758522775; x=1759127575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYD/M6PxWq/wgZene6AcBP+PiIeNlODJlqiaad3A24w=;
        b=gf6a1EODnix5ILY+DArNZU5kt8gWp58bTYbUmAXsl8k09pcyzDbK/py+a3zTQ5HliV
         xtwxhwcpU8EsQ0HchmwcLdRZ9cOUfsqaVeq22cKIsSP2gv/MnZBMx5HjUOErvFSG342V
         cHcKYkoMWmkzHI+wXah4ERMVIu7bfxyJ908cIZzdXrU11irZM+SrsUydTCt1+4Z/MA6U
         bMDag1ffJaer1fnGc7eo182VhM+WnTHv6ewJ8APaCT/EUolin5eA8wNoGHDzHv1WNMwA
         +VwG5Me6zBYKOUe7VmxsjuH7Ag7ASQxoQirrN63alWnQ5ujSVdr3IbFh2lDiANvqiozf
         zYgw==
X-Forwarded-Encrypted: i=1; AJvYcCW6xC6kBEqnMZvRteJY8wUXDiB64DiGnGVH0FPVeplpamihKMjztZGaIRQZHpTzWkvb0CzaoFvK3weR46w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWbzc9ADLhEU5HVc7KIn1Vydm9gS+ORFaYV3hNdebbzAejZKrw
	wG1o8+zg+tV5GbqjMMbwDRPmxg35jcgkxqqp/D6gPTTzLxxCGcPdjxBWQI6Feo+ow88zWsBaUAW
	aA38ZvfS9HRVb7/hzIK2bLmzbFZnm+xE=
X-Gm-Gg: ASbGnctAPZoj737ojGTenjJdjoTN5OyjZUhlaDwLJ/gUV8V6JWhHprNk6iKG/jdvpoF
	iWXdVkrZc8+UPeJUuTz6a8G8YFndB3czndxzKqSAEUuC5P89AXCgDUAWXHVU+c6t5n+DZ/qJC6+
	vAA4sjWd6yLAkULPCtaueiIkthOj2dCgjXYa6F7YFfXLggd/yoxnU5p/+BhBaOiVxc3bQe8NTYs
	T0XZ/TIrQ==
X-Google-Smtp-Source: AGHT+IFt32g296/v7oUwiN3/2WmyoTf3rvdIov16mqu8J6Z28WBVs12Cjb1LzbSnQ8aw+EuwgBCTUHBHTozQRlQCuwU=
X-Received: by 2002:a17:907:934c:b0:b04:5b0a:5850 with SMTP id
 a640c23a62f3a-b24f3e59436mr1217337066b.40.1758522775353; Sun, 21 Sep 2025
 23:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918190729.387117-1-akshayaj.lkd@gmail.com>
 <fe32537d44cbb187e1518740f33e3a6716dd363a.camel@gmail.com>
 <CAE3SzaReUnhWyzA8RtdizKeRU2zMsGbvQaVT-ug6v+=Pqq8WzA@mail.gmail.com> <CAE3SzaRsGw0coOWVmnN94E2TQJTOsoxBquYp-PSQrbSdpGGSCg@mail.gmail.com>
In-Reply-To: <CAE3SzaRsGw0coOWVmnN94E2TQJTOsoxBquYp-PSQrbSdpGGSCg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Sep 2025 09:32:18 +0300
X-Gm-Features: AS18NWAPruRnjqpSbd4xlkyRDkq2iJo0pBBP6U8n9ilb2ExxqxI1feVAik6XECE
Message-ID: <CAHp75Vdo2SpO_HnCDYnEkZ1LHpn4s0FTO5TjSKRNG24s-ByNDg@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: bma400: Refactor generic interrupt configuration
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, dan@dlrobertson.com, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 5:59=E2=80=AFAM Akshay Jindal <akshayaj.lkd@gmail.c=
om> wrote:
>
> Hello Reviewers,
> Is there any feedback?

No top-postings!
No HTML!

Please.

--=20
With Best Regards,
Andy Shevchenko

