Return-Path: <linux-kernel+bounces-780076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0B8B2FD2C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CF33ACF4C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917F41FF7C5;
	Thu, 21 Aug 2025 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6IzRvQ2"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F902EC57A;
	Thu, 21 Aug 2025 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787331; cv=none; b=qPoAv5FBeWejuTGFCQlROOYeONq4fqHA9o5VrgUdIFkE4piRhfewEAjsEoqE1aycOdTnTmzIKJHzbgBeQvJQ3KwYUyfPsdIR3haUq//ol4CBdf/H0qcS+H8GLJKmdiAMhrDHerfCDmlaNbKLKRcydgVMZsnnH0UTREdvLxkjibI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787331; c=relaxed/simple;
	bh=jW74iq+PKH5N5VV0xDC0l4MRtuVTjRpskqAhgYNv0XE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2/NMAUkbH4yXgIG28LvNg3J4CbfB3Lukm61sHicoRXPdxhVNvaNJG4Bu1APS7h1/LE6RuvDuFF+1Uox5HafxHzq9WPSPUj0NWbaEj5vaMMxcAnQZce5WTham52tiGwLoQB7xuxpr3XUYh27Zn9wDqrH3+nVtkGnyOWg8glJo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6IzRvQ2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24616371160so1032505ad.1;
        Thu, 21 Aug 2025 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755787329; x=1756392129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jW74iq+PKH5N5VV0xDC0l4MRtuVTjRpskqAhgYNv0XE=;
        b=A6IzRvQ25d6fFFRjJlg2ZzMcOPB2noUKQoO6lACiJwejQKUVOY9loiHLu78vbRvJhP
         w2DAXRa7xNd/iiHf4j98ErFVm5Cw+vTh5xeJjwymniJ+3IQXS4FI/0ZlkqHP0rADMJ5n
         e3BJ592c/EqkLpgm7zj/BJHxbp+L8paa6wPlnSvvGO9If1/1656IBJT1HjzVxYTqHfhb
         PHb8beIPVIrDfIHUwny3CzQxL5PNoxoe1bl6CZXJEgr99zYLEODldRLXJdiLeQfGMWEB
         FxMa8bAIVOMR1CRB2fQso1MOS9DmBV8jy1A81divB3uqQ5esptyx/zOr75M4WBUZ49t5
         I7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755787329; x=1756392129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jW74iq+PKH5N5VV0xDC0l4MRtuVTjRpskqAhgYNv0XE=;
        b=qjwmOUWpjDhRezuR5nRCrZNdXUc0ScU4y37gZeZe23gZzLfpIARa+n6/E37D487vhJ
         aAooGOSgGycz7JxS7hZpPGFkNjJCMzmQja3++2lWlToYFAJvuwMgNh7He1EaoIVUZRZY
         xa8RYGSCUghJ/BSKcNojJg4GTKM5OoEdxg/q8BUziv5tjd+aNenuwqUS9qkFJVcOq+oE
         J6Sccx7/nZOZleTp8BeDVWmKQ1m8diImbMMkqbYQECoPCqRVqSw8V0JYFMAWbZNFo5/i
         VutgTvQYRpEiupn1Iub63w/5KQJqG5F0mKOHILi6U8KsE39MsobdqeMoOL33Tnlu1Bbw
         lE7w==
X-Forwarded-Encrypted: i=1; AJvYcCWPUMC94louDRxg04aNNO0z1r4dt5JdnS/VC4bs+pCiRnAqZnCCl6shWzsZuBEMlB23FnS6KlZ7XZIVZNc=@vger.kernel.org, AJvYcCWVm5wEXEQ+aiRKdU8MmBmz/TbJokq89Q4GAEJAcpDR8rsuUmCfu/twzWLb+/kVeB5dPOSYXa+XzhOTfIfkp7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb+7UkVT6920FkqpX09WLXFtFkCp0RypoCFQ3IMeWqpBONFdL2
	k6wOy6unhsVRndEhkq7qUhGdjqL/U4B8ZN95SjXHZFpS91Q/QfTsqzWytnUnFQYvANl1J3Ocppi
	/wD1qL+UHkYx7vjXF/YFu9oyW8h3kaAnxtrqt
X-Gm-Gg: ASbGncvkt1VKukcicrBOMBpLXGqdMY3m71X0jo7jBUZmpGR+IDRFiPpJHyWczJPMJuZ
	twRAmximBouTLRswfutco5zTetSgmz231+WNtmRF3tJo6+1oHugm+vIFkT5PFtwlNtCj3BNBkLb
	3Spq9pNEZjrC7O6Stc0KakoSZreHHrVEOvhNd/Cd1BGdhNWKQt3G1dE3lT0VXdUGCqj+ZbxvVFq
	vxHQuP/7Jnw0raFnmQ=
X-Google-Smtp-Source: AGHT+IHan61aaX3sCCl9KyeasT0oCGpB8IgXHlLdjerHi582y4v3n06S18sC5+n37Iza8oXv9kDlBPlbVcn5TbcqeZc=
X-Received: by 2002:a17:902:ce92:b0:240:1879:c2fd with SMTP id
 d9443c01a7336-245fed5b093mr19198175ad.2.1755787328772; Thu, 21 Aug 2025
 07:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821002055.3654160-1-fujita.tomonori@gmail.com> <20250821002055.3654160-2-fujita.tomonori@gmail.com>
In-Reply-To: <20250821002055.3654160-2-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 21 Aug 2025 16:41:56 +0200
X-Gm-Features: Ac12FXzjWnFxZ2RmOH9AiVIpkknFrai6YcuBi5UrmtKHtj7niXi7k_DEgY0R6f0
Message-ID: <CANiq72=nUg=Nu2dqZTOK6FXJ=z0qBm_EsmSgHjzcFYy5iHm-hg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rust: Add cpu_relax() helper
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, ojeda@kernel.org, 
	aliceryhl@google.com, anna-maria@linutronix.de, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, frederic@kernel.org, gary@garyguo.net, 
	jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org, 
	lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org, 
	tglx@linutronix.de, tmgross@umich.edu, acourbot@nvidia.com, 
	daniel.almeida@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:22=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add cpu_relax() helper in preparation for supporting
> read_poll_timeout().
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

