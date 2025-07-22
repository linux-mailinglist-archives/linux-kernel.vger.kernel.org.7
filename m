Return-Path: <linux-kernel+bounces-740024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D86FB0CEC5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDF417B136
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCB8487BE;
	Tue, 22 Jul 2025 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fv/EL6ZD"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1012F195
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753144439; cv=none; b=JEWm9kUcduKSY9N+feFsgULM1LD4YP9pGqempksPvOyV8zjczJ6cKdsNTbXARuwGAVvnCKtBWn5Bc5f27KC8mB2K0fx0pming0WJQjYCTMhssEjTlkegDrvrPKQoWLr94zv3nlf2VSuZkFsAKgYhPkb6ZBr8GUwmy/mRI/8yfzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753144439; c=relaxed/simple;
	bh=wZtlK/fCCRI+E9S5gNjgoVTfYtUgS2d8yDeWriMrCBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvGiaj8yTetDFiBNpIK2L+LUvNui/JIQxyCU7AdVYXHZVYqaffUR3qiI+NCaRk1bzg0QPUErEeWA3psZKcFKSmrS5djoQAsEt1L83xC4FNFSch1Wo89+/NNNGgPLQSw64djwnOwq/Om/Dq3XjdReFG4wAWJFM/bdyk1Mn9d+zS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fv/EL6ZD; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-556fd896c99so4558613e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753144436; x=1753749236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZtlK/fCCRI+E9S5gNjgoVTfYtUgS2d8yDeWriMrCBU=;
        b=fv/EL6ZDBnfmSYERbg2qrC3CwrB1yg+Hy2wJ0KzR0VO7RUAsDRLdgZADseWOW9EGn9
         dcujOJt9YaZEbvOBlWQFFx+wj9wbsl20hmbrzmz3xmIpkaZVfbE0rwdQ3fAVZDkBuZLA
         AHvUQZiru6hOo+Jl+rxOZnDrLWCeMmzIa1qETrQu6i9t8R5pdYURKOjbYEIttwdZQJLb
         sePwNk4usZtMBIHjVwSb8xD5B8nQXKglZg4FHQEE0WsvV53hq0RehsF7hpYr/zkvaBet
         bgSPN9SS8HwQlSzjlwN8K06STxhT/Za7i3af8XIqThPEp2kW6MuqHA1W1JWZJA4/92Ps
         vRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753144436; x=1753749236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZtlK/fCCRI+E9S5gNjgoVTfYtUgS2d8yDeWriMrCBU=;
        b=Ookd1VbUO258rpOR/XDaJZFOy64Hj+m/nL6Xb0q5KfpLDQJQuuTrevU7cCNVFmCOg2
         KUFUAoXLoZzBVPAkW1emDbY8h3HffcPVCYmCzcWJPhIPgx+TnsrvET6TXgmC9ee00dEu
         SYJ0F/QZnWbCXZRESV8rk4K/9HgJpQaH7iByEbjfPSYo7CkywC4zYTK0DiGdrgmYDKdB
         UkuLv30sYd6HINJdKdjWbSN89fGtJ/wWRXaLdSKteBxPTY7XGY+Ha+3v4quDtgwOnEHV
         PAQt7mzr10SyhlMUX58quBjs/ZjeYcxo6FIIbtr2MPsJWj7wH6H3JUCwR5FE+n4Plwpj
         AolQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5AcL7rvcimwdOgLNAMzMzp3RF0sfs7zhrNj9u8Anj4KGIBckUo/pAV7e+ZkFYQ73IJdETN/56+NIvOMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZVslJl+x5x2Fpqj3q8U5tCdohqCUt8psUK1maXmUUaQyU7yvU
	ye8MkzhypSQUi/57+YJg+eFo2wEUOIqIkUUeQHf4SiaIKg8KCDV3UWVYGES8Q2C9Uwd5aIX31RO
	BJsWdOmhoZnzTdL2gPGmg0UFS99WBSmegYWTYOwU=
X-Gm-Gg: ASbGnctco4YjLZ/MkfQjgP1frrHLr/kKaMCy+6EgSCTYl35B+2vw2i13JPANZ4kARZ7
	u/dnK3DjU0a6y87RBQSPAFIaUg6Y5JuCSfK+mjldl2SYjN8F+zC8yXjQV6jLFuSTIxhTIoGu10N
	EXcaZkAmMEhFgr/R0Yll86ZVudcAjUP9FHrt8Vk77rRmD1yyTTl05gj8kzPJ4GoybVfp5ZafpJv
	gG2ypuoeu3B3LuVlDI8L8NQSdmoDna2JFM=
X-Google-Smtp-Source: AGHT+IFPkdz/j0WmlQPf9eirRVv4pzrJfVe9XcNeD9iftAmBq9pNEGWwscLQQrIDHxFF73EFaTg30vEM0mhYbaxj0hs=
X-Received: by 2002:a05:6512:60f:10b0:553:2645:4e90 with SMTP id
 2adb3069b0e04-55a23f903a8mr3918362e87.52.1753144436009; Mon, 21 Jul 2025
 17:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720-timekeeping_uninit_crossts-v2-1-f513c885b7c2@blochl.de>
In-Reply-To: <20250720-timekeeping_uninit_crossts-v2-1-f513c885b7c2@blochl.de>
From: John Stultz <jstultz@google.com>
Date: Mon, 21 Jul 2025 17:33:43 -0700
X-Gm-Features: Ac12FXzw8e_7tK347TOtMoDcf7inbuDAbjNTfhyZDD3X2xHKbAXOB6AX_06IwXo
Message-ID: <CANDhNCpE5KPjdJVsB_UszmA0eePnZTtQ9P-Vye2rJQRhBGFTLw@mail.gmail.com>
Subject: Re: [PATCH v2] timekeeping: Always initialize use_nsecs when querying
 time from phc drivers
To: =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, 
	"Christopher S. Hall" <christopher.s.hall@intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, markus.bloechl@ipetronik.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 6:56=E2=80=AFAM Markus Bl=C3=B6chl <markus@blochl.d=
e> wrote:
>
> Most drivers only populate the fields cycles and cs_id in their
> get_time_fn() callback for get_device_system_crosststamp() unless
> they explicitly provide nanosecond values.
> When this new use_nsecs field was added and used most drivers did not
> care.
> Clock sources other than CSID_GENERIC could then get converted in
> convert_base_to_cs() based on an uninitialized use_nsecs which usually
> results in -EINVAL during the following range check.
>
> Pass in a fully initialized system_counterval_t.
>
> Fixes: 6b2e29977518 ("timekeeping: Provide infrastructure for converting =
to/from a base clock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Bl=C3=B6chl <markus@blochl.de>

Sounds good. Sorry for sending you down the wrong path, and thanks to
tglx for lighting the way. :)
Acked-by: John Stultz <jstultz@google.com>

thanks
-john

