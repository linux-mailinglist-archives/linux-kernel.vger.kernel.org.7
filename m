Return-Path: <linux-kernel+bounces-730911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB05B04C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572FD4A23A3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F185327A139;
	Mon, 14 Jul 2025 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BexsRlHF"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE6DF76;
	Mon, 14 Jul 2025 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752535918; cv=none; b=STKiZyKetb8ryD8aex0IEBVczEhvognEpKbAipQIMdKrRmxIpersEB9CyvBV9Dt481qVKOPUrISohHIhi0vo0fdYFkANitCIv9p63GVCYP/yW/1g5TrsimUwRDui7cYlK9m6kJkZIIqxgWcY5M9UY1QhKVhUeXF2NoTQbHE550w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752535918; c=relaxed/simple;
	bh=5DYhIWiVpbviyeviltRjQNKz+SDlCzUTR7SrrCEhZMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ch1zZV2nn/bZXuCJjQXF5R1sePIH4Ts4+GezF4N2jGN3JGTP1NNNdoJz5xrkLYdsVXTApgiJkTyMz6OZn5k6Nj05z6crVp2qbikBjHs8/HBx6sL0vOBBFUcjwbfuXRq/I5sl7Waw2kmCi8DpCWtbnK2LuQBjYoXtRSOaS2oFZkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BexsRlHF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31308f52248so887869a91.2;
        Mon, 14 Jul 2025 16:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752535916; x=1753140716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DYhIWiVpbviyeviltRjQNKz+SDlCzUTR7SrrCEhZMw=;
        b=BexsRlHFDNDIna3k4S7qKI2EVatbNWzUa9lJR3wH11qYyIljvLIg8rqX8kKFE9bZrQ
         TeSg5e4hDkFGvbxfeQRCU0RRBcXKoHl5yUUzMx5zAvu3Ub4XpOnsBvgQneHFQ5zDhd/j
         LStBEUc8L58uj2VzvXsqdieduJHl8RJnuvE90ZBBVjlZf1tU3Oqdyz5cx2azr2jYcmpc
         7F1fyIaHig6BU0RoDbVlKahnY+HqjjjRj2wJzUepfPBGNymODLzPQU3UJY00OKEur6UW
         +CG9AXKfoUondqzOzgkcTpde0hWPyTOH7Ndm4uwJsqM266XUkaaW8fQhszpXXUqr4dgF
         RXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752535916; x=1753140716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DYhIWiVpbviyeviltRjQNKz+SDlCzUTR7SrrCEhZMw=;
        b=Ztjdcfu80BjUx2KCbWqtFJ/E4ciJpbZEynBikmD+Xx8/PWrFOY/ZhNqeebUyiLBMS3
         PttT1MtEnK7JEhiXRiRhRqXW93KEUvaaSI8wuBbB+Qyp2xG33Wdy9q0qRw70VrdS6h7P
         QmijEEkq/n9ls3hfor+H3JBWs5+QNFG2tzlhSm+5GQpRy2VCAnltx++qOp7wVm49jxT9
         fRM/zq4u9be6I3BWFC3VK/F7HuhC4QN4E8lhEi4jty65gC+/U3g8rKu4NKlav4WweD+k
         x+4Gl65L5QS8QiAmk5YQLY1QUkYyQjp1AJvLELkMpbX32PoRCpkdg14TzYKx1efa3zN9
         kWxA==
X-Forwarded-Encrypted: i=1; AJvYcCUR4SMBTOhJQ5AR+aI6kq3iKHiBn/sO3Bm8OsonrqvEgOxDbsqwxlCX4V8+Aojpdm2awT/Aj7kmplgAjEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5o0ParuiZYr2R+qpQfbVZR4Gva6QTaC+EoD56MA8s36GJM+y
	RYRk34FdeWHhBu5lPMO+ygNEU3VFvcrzIpKSWaYmLPJzORHnfObQbzD005wM3ePZvwbFKccATY9
	DitN5apnKruJdIsjTzfCZFYcvZdQ+AgA=
X-Gm-Gg: ASbGnctYncqcJAZetdGsPWoyN26pZV6+dl4ULjmV4lxWawOtKk8SIm6YxDnnXMbEXHJ
	T8BI5V7G/NRVRBSKP0IO5T2mbEKnVO68R8IOb2n189+qXqW3bW6nWq3RldQ3w+U2cSXqvnfZ+6o
	N1erPrC2yjToluh/DV+ZATsyhdfrGQeh6Pg69l/BNu3ySdMP5MDR6tPUcDro2bsFQ+ak9C9gqHA
	+yodmmf
X-Google-Smtp-Source: AGHT+IGIfLO/C1ar200om5JMV/P/HaOqUUd5cnHjPF3YbkSys/NYlXaADz8wLWvHAAO2H3iQjlEyDM5NYQiS4xT7HZo=
X-Received: by 2002:a17:90b:17d1:b0:314:2d38:3e4d with SMTP id
 98e67ed59e1d1-31c4ccedac0mr8858804a91.3.1752535916305; Mon, 14 Jul 2025
 16:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629152533.889-1-prafulrai522@gmail.com>
In-Reply-To: <20250629152533.889-1-prafulrai522@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Jul 2025 01:31:43 +0200
X-Gm-Features: Ac12FXzvT3OeHNofF0uX07Bip9As7s_RgkT0FJAbpi1Vz2ZM4GmTyIPKIzjwMpk
Message-ID: <CANiq72=aSUtWVGVkK3aKo-WbuuEROmijE6+PVciGoH+iisjGrw@mail.gmail.com>
Subject: Re: [PATCH] rust: helpers: sort includes alphabetically
To: Krishna Ketan Rai <prafulrai522@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 5:26=E2=80=AFPM Krishna Ketan Rai
<prafulrai522@gmail.com> wrote:
>
> The helper includes should be sorted alphabetically as indicated by the
> comment at the top of the file, but they were not. Sort them properly.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/1174
> Signed-off-by: Krishna Ketan Rai <prafulrai522@gmail.com>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

