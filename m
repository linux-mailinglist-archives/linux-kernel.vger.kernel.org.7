Return-Path: <linux-kernel+bounces-745608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5CDB11C20
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58EF41CE4E62
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548902D6412;
	Fri, 25 Jul 2025 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Oli8JsCc"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9971EE03B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438708; cv=none; b=BgRqRJIsjKCqun6bPbkVkX0LgNmSKhok8gKhxgoSp0XtmuC1crQjKIyN7fefU32nVKhRk/Swx8dISHugbooBx9fP9Zm+OfPCvE+8owPaIzV21mqQ9ggJllY7pVNCLzHiOVsli+xEQzMXcxbujXPZ0tTwxiRuuJfccvIlqiC1ShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438708; c=relaxed/simple;
	bh=YYZ9wBxVry26yCtTrzlfpW7Eh8IcQ/VBZk5LVzMoGIg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=QfiKTvZ2T+QlNbuCqxYKeLd5Qg7G3GBM0wUTYwc6nvXo41rN3C1rWx5ZGomAi1asGIELDV4dVW8rGqDXdfws6E/jdSCdZAzgf1QZP9SG08LipfMw+8XsZMGyJagtETikPZk4F8J06LWVqvqtpE/jYWiZbZMqzVnYCuT0QTKIY7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Oli8JsCc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4eed70f24so114518f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753438705; x=1754043505; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYZ9wBxVry26yCtTrzlfpW7Eh8IcQ/VBZk5LVzMoGIg=;
        b=Oli8JsCciYFcKf/JOZnc9ARtSfNr9CyxWQn2Y34sC+QlCvP4Qi1iGE8GhAmLC6vEPL
         kuGeLByS0HjD7zFACl2iQ/SxMdwWFBjR0Fy+w8RSMzDqvui9Ksi4gVhi5uO6wz/25YIM
         n07dm6vEOpRtcLzctK46LzCvhiVb43NOFw+UXlC7xlxX1PbyjY621jIgazLipPq/YTxo
         6veVj0t9RMW6b/6ST8g1Z8M3R5CtYHwNrv79WeeqkLvkV+45yLiVKBoe3iuU3wHQgvpz
         /dcpIZj8Jg21WibPI+1G55wMQvgoAQWRMTVnTHIe17ttOKNqefWsGwgSgZEmjZNcnCiA
         oKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753438705; x=1754043505;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YYZ9wBxVry26yCtTrzlfpW7Eh8IcQ/VBZk5LVzMoGIg=;
        b=caJGneqxje/F05Yg0NTFa77uOj7374kWh8gc8afTFhiqRLk1XhEeEPdOobph4m34es
         wfbIF3EW8Z07zQLLMhE9TxNSxs4EbaY/EZ6ZMHnmNmiNNuDi+/lr2kQClYm+JS8U1x9I
         bGZcNx1wDJa8UeP+7ihiUC1UWqKbtJbyNe3ZNUuOqF4gqrOsok3iaUsAWdyOy+wi5H4/
         0C1knxrljTY5Cw+KgF8+FSvf38FPxwKQbLrq+UC2XY40Dr+sW/LVhb7+YjtQB8Expx3L
         VdG9PUU1j3TSNOuefoJWEAsUB8luG9k7Mi6C4yR9Y9sQwwgVrKh78tBY4m0FupPkha+B
         272g==
X-Forwarded-Encrypted: i=1; AJvYcCVhH1bTyZTvtYGUi4TUQNcvJExPdn/hZy6CpQaihW4wmc+uOv/hwu0HQoSNDvieCYyJ7Lpv74uibE1aZL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsxF2lPHL316xZNlAsyy182QxVLei0seTppUNI7pKFGYHyQz/B
	aZDgHFkbrKzJmeoHPlmnj1sxVuTngogucnyG+XXG6TfxtixuB+TackPQhBe0yazzbv0=
X-Gm-Gg: ASbGncum66KWxnz7fPFM6syphGQjhfKjy/LSy8JKuoWcklUUKgRjHXR7VLTxkPZcA8g
	A9QYBV3wjHB0eV4ChDt2yVgnpSVf5o0sGQZoVrjSGoQnZlfROHl6YvQ5wdsV16UuHm8cuBJAoDt
	b/K4AOFwvfTwIXKPDOsI051sEgdPzvYMr4AU820hCYHeZSyoydCLnW0uuR825u455r8K4eaFH2+
	E6gCTx3uexc3CRBvgllul7zy33Dy4RjrL1Bd70KazzOnN/QH9K9ryEPjN6OmgT8soxHnQZm2MTV
	/cBhvkmVpEVbsV0eMy3rE3tdlJaRKGufZ8ySLwjS4AgWq8MYsuRSmKZFk/nUd39UxjDRvyQNtEZ
	2ZItovn/Bheg3ypHWOjWqjbJjMizO1A==
X-Google-Smtp-Source: AGHT+IGn5WRAMtlU5cklPYxIOVfVV5fz2fA+h+TjIZKCuxFwKLN9BLlRRKIt3jUZj5c42/6P+CdRHg==
X-Received: by 2002:a05:6000:430c:b0:3a4:f912:86af with SMTP id ffacd0b85a97d-3b7766d2f23mr452692f8f.2.1753438704893;
        Fri, 25 Jul 2025 03:18:24 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8c15:2281:5347:b367])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b76fc7724esm4655765f8f.32.2025.07.25.03.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 03:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Jul 2025 12:18:23 +0200
Message-Id: <DBL2588APTCA.2XUKQCJ0DW89C@ventanamicro.com>
Cc: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
To: "Vivian Wang" <wangruikang@iscas.ac.cn>, "Drew Fustini"
 <fustini@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, "Alexandre Ghiti"
 <alex@ghiti.fr>, "Paul Walmsley" <paul.walmsley@sifive.com>, "Samuel
 Holland" <samuel.holland@sifive.com>, "Drew Fustini"
 <dfustini@tenstorrent.com>, "Andy Chiu" <andybnac@gmail.com>, "Conor
 Dooley" <conor.dooley@microchip.com>, <linux-riscv@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH] riscv: Add sysctl to control discard of vstate during
 syscall
References: <20250719033912.1313955-1-fustini@kernel.org>
 <cc82c938-def3-4df6-9fc9-fc321af7d54a@iscas.ac.cn>
In-Reply-To: <cc82c938-def3-4df6-9fc9-fc321af7d54a@iscas.ac.cn>

2025-07-24T05:55:54+08:00, Vivian Wang <wangruikang@iscas.ac.cn>:
> On 7/19/25 11:39, Drew Fustini wrote:
>> From: Drew Fustini <dfustini@tenstorrent.com>
>> Clobbering the vector registers can significantly increase system call
>> latency for some implementations. To mitigate this performance impact, a
>> policy mechanism is provided to administrators, distro maintainers, and
>> developers to control vector state discard in the form of a sysctl knob:
>
> So I had an idea: Is it possible to avoid repeatedly discarding the
> state on every syscall by setting VS to Initial after discarding, and
> avoiding discarding when VS is Initial? So:
>
> if (VS =3D=3D Clean || VS =3D=3D Dirty) {
> =C2=A0 =C2=A0 clobber;
> =C2=A0 =C2=A0 VS =3D Initial;
> }
>
> This would avoid this problem with syscall-heavy user programs while
> adding minimum overhead for everything else.

I think your proposal improves the existing code, but if a userspace is
using vectors, it's likely also restoring them after a syscall, so the
state would immediately get dirty, and the next syscall would again
needlessly clobber vector registers.

Preserving the vector state still seems better for userspaces that use
both vectors and syscalls.

