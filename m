Return-Path: <linux-kernel+bounces-842878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D1BBBDDC0
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F22CF4E63A1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAAD26C3BF;
	Mon,  6 Oct 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii9hZK/A"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AED26C39F
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759750070; cv=none; b=T5jnKLqdSN122JEf8WQMz2g+bnfuERvfO/WPrhVfsC3uivx+p+Dr1Geclh4NMGqfNCjZJYgHsZ5n0O1uUoBT5ROVatucrGnF5BkSkt5xFSLw9NO2uca4cfVzVTwSSLZsJEjJAEiLk55Ni1KiKIDdynIYJ2YRWtlbP3XUZ4o+zGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759750070; c=relaxed/simple;
	bh=E/FPw0fY1WNiYy4hyNh9nlCHleoKAmsLZkg3ptd5JBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4Am6VqOHT0Q6I0I8B64vPGOWzm+QyncJp33bZv92sZYdKSRhJjspKuwH/Ym6GbEQmjTVFavXly3dECMrG1vgmmMIr31b4VeuqPpyVT5LtzOpG+QWaXTzyfy+BKLr117L9Uk4IMdfBlJtY+2nExGJxLDT8lhaBHSKWOi1vXG2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ii9hZK/A; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27eca7297a7so6375105ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759750066; x=1760354866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/FPw0fY1WNiYy4hyNh9nlCHleoKAmsLZkg3ptd5JBE=;
        b=ii9hZK/AUgJGOk0I8YPiYshKZ9iCAW29phYwM1KVj+qUqT4tNScpOcq+plPVv2MtiA
         AVkf0ZYudHlZmjk2ao32OTnXqTtRh+kMfppatE0M7R3BSkG4z0kT/bp/9AsqlxJzEC0p
         hzlVJQbNvI14fp/PhMdcdJDDwNrHtpuUHD0wOv6KSlAbK5mSUBFg5msXnnRfiqhom/CA
         abpJ7XO6yhXN0d9EaQJWN8UXLJokutMHpbvTDWFYL9hvKH5ieZrTGDt8nhGZZ99psIeV
         dqNbmtEvySGD9tueSk5zgMFkZiQyaLzTFGCqGP+IX4bxVOzJZxQpAgRCYevYmVFFy+Me
         Sh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759750066; x=1760354866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/FPw0fY1WNiYy4hyNh9nlCHleoKAmsLZkg3ptd5JBE=;
        b=FOdPrP9NbrbjhRKKVlTQfDeqbEhkIAw0O66pu6Hm2iBXA3i0oehncm90I7fq75zUIc
         7ap93hTCAa3bqm91MtUfAOO3d9SKS+vNavRomJsj16S5kmsWOJ3bVZd5wrPoXnfXNDbF
         NK7+L5u1QrcsZjUnM9o9utSGYbnH789B7suDONbRN5vKL+UAgGaSL5006AwWgzAKfUQz
         VMYXiwoGYSRlo8F7Q+3VvNWqj+HTehpmqi5z7867DX5lr8WnE8IX+30W3fDBc7W9mzms
         ypnZpxwkpU0DPPptkSjySA1iusmypKKZ6F1cbjoSAuOPMhliFaUSqz9dTvpx2MXuKf/g
         +I7w==
X-Forwarded-Encrypted: i=1; AJvYcCXTogMkbZ70ki19TFVD8+PLPrmsXcVALZbTD3Qd1kCmGIcK9Rx8/mR8SQWu9LXg0cos7GlXN6i1Nv3IDcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykAcnFi3U+tAzFlkROgpnvxjylHYPhBOa2s+My5S9PiE8Y0yq6
	C869cGTYgmq/6fw/35M5FKtyybzwYrBBtjQZZ9FYh4uDnue1CttJMysFwgVD0PLn8XdQ48Us5ta
	IVwQxq20yI33WSiDjWe84g8Xd3E9/f60=
X-Gm-Gg: ASbGncvM54Iz/DRvagDhhKWsuB8xmx1R8AAnKxTVnOHR10ObjRWfnGsx83eH8kZTzXK
	/SKMbODMR07AnVO7a5NEIeXi82J/9j3QvkHOtq24Hr8hBx8/MNd7bVBpOI4DvsnydKT8SqCCZ8b
	KyVYUQjdgC/eMbvesgo6LiILYoSR4KpBnnjQR6s/0PgPuXSb2TzVTLrYyO705/IoAN1H2dXpg4F
	ZvoULM3dOaTqEq4kaqdAIay3jSK5gOoq/aNwvCcjH5x6x2Bxyk/NR+ToNoaMantbxJnobwZFuUZ
	duuouS2A7jpORLBuvU46paJo7Yinu3FOa7a+093CAu9lL6W1GkZ28XgdWvntFZ00rwQvmFI=
X-Google-Smtp-Source: AGHT+IGU552WBlNxXYsiZP3k+YaYGnd0eztZK4BBARL/9cAMbZoEa5fIfV4DQMF8tLrK1/G2rwbinID+IDLRpUaG874=
X-Received: by 2002:a17:903:18b:b0:257:3283:b859 with SMTP id
 d9443c01a7336-28e9a6ce25fmr71533365ad.9.1759750066264; Mon, 06 Oct 2025
 04:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-kbuild-werror-v2-6-c01e596309d2@linutronix.de>
 <20251005011100.1035272-1-safinaskar@gmail.com> <20251005205335.GA2561157@ax162>
In-Reply-To: <20251005205335.GA2561157@ax162>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Oct 2025 13:27:33 +0200
X-Gm-Features: AS18NWADaxVflRFqTezzJZlF2JybUbasQ-cTILinYfyS9GRIdfm3RSh3CWudziU
Message-ID: <CANiq72kDT_uDpmvMyMEXodSXP3rsevjzW7G134H9A7Pmx6_7nA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] kbuild: enable -Werror for hostprogs
To: Nathan Chancellor <nathan@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Nicolas Schier <nsc@kernel.org>, a.hindborg@kernel.org, alex.gaynor@gmail.com, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dakr@kernel.org, gary@garyguo.net, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lossin@kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, sam@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 5, 2025 at 10:53=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Thomas and Nicolas, thoughts?

I think it would be good to eventually split the hostprog flags into 2
sets: the ones that are used for bootstrapping, and the ones that go
after that.

That way, we can get the best of both worlds, if I understand correctly.

Cheers,
Miguel

