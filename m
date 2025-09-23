Return-Path: <linux-kernel+bounces-829566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3454AB975AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19602E4F66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AB72EAB64;
	Tue, 23 Sep 2025 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLHnp32o"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D4258CEF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655987; cv=none; b=sugS9nw7AREWD3Ae3cVIn1DQ5e17GSAsfITr7oiDbT9fNwaiBh7NihB/94Nhrxvq5XtP6lLTtBO5lOrC3PK901g/u6MyTJZKgGomal9oIKLjpbjnxdZjfQL6J3NCCmwb6roBhtQqf/apSwsp9Qmi5bfdCfnoBhCMkxuHt72bdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655987; c=relaxed/simple;
	bh=0MuzrNmVFvlrMIdu4Hu0o3+JM08RVibkcmhuvrt61xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7IrgMvBMnx/p/Vx0vSVp6JoJ4ipIfwzykrKYW/2h++e2jwQigUb8rXKp1HL/PFP676eQMq7cbJMZC7Xn5fKdAW8tMgmfv10gZqW3KUPm6GPFGEtSeh2Xb0isSCt0w6XbplR+qwN6J7RavEhTD70ObzSlMy3FzxM9P+WNZK2dPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLHnp32o; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so37421675e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758655984; x=1759260784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MuzrNmVFvlrMIdu4Hu0o3+JM08RVibkcmhuvrt61xk=;
        b=KLHnp32orXrM2GtsPRiP5QbRQMX7MqAkpHpNRJT21Iy2itg5e2MN7Bbgg21lowJXyL
         /Y6/hU3ZvJ9Nos1tw2pGfKOftzf7mdTeho7nWjlu/Bw08prtirC+2m9RASoLV1unSzpX
         y8TdY4oNFpn9t37n6D+a41brTR8cPYIDZo6ZbTPLfWYe+a4SUyjg2eAlROQ8u2RR74GY
         1WDssYXOMgY5iwkzKxHek0BfqtA1ndZou5ymSo5qYknhMDEpZ0mEaxtGXZwnkZBSECEG
         SotNnYjOp55iZS681rPitlvzXTAufk8eqluPaq0cNcJ6ZblbvkFixTGx23E1RrW/3pcq
         9g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758655984; x=1759260784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MuzrNmVFvlrMIdu4Hu0o3+JM08RVibkcmhuvrt61xk=;
        b=Ka/Nuq6eM+ykfcY72Fc5RSNP4xAYLvfAp6fiw4nywamb+iSLuB5UfXcdW6dHLVZQwu
         EIQGaJqVB3G0ptY5t3QyYaLPTsbSuxiacNA2el5P5/ZczFrHf30YdD+RftMl58QEgKkS
         WZaFPeeUMwhvqMeFt2x4nebOcXqUUr3yWIdrgq3aVvhIMbuIYqP2yG8ZfQgPabnQqvyv
         ep4HaoKXeo2oetWeAfG9iHvvBqAV8YmajzY04/E+zESKH8nx+jpHUco/0d0QdxfsUI37
         scl71WwF9IlUzOVWN8p9VOw0+xBkJ30N3Sg8MQpSSov1Z7NDuhXK3URvbEgZqqSrTKZU
         0/YA==
X-Forwarded-Encrypted: i=1; AJvYcCWY4IvF8sVDMRC4PNpSd8Zvy6P6bCHf3gZTdVBXaxMtf8tm8qXioXVMf6+1l1lzS7rYBPI0BOYz0BmRKfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Pv/aSL9yUklbI3TPkexuuGOsc+vVUkDx9Nr/qTaxPUbcS593
	NtUCnUyURbxc9quYsz4vCdoj+xKLbcHbej9+o3tKV+ZZv5bO+CJvZPEJXMrUVgvXUw1GmahhMNd
	2K4EFa8J7ps70MAGx5FKq5z5iJEXaGzw=
X-Gm-Gg: ASbGnct7X0GvKkI/VU021ERL4AdLAOdGBA6L/5akHZrIukTMrlzY7BJ8MwsFtlqmfPq
	Jc71zUUAQJHRMk07ZfJ7y0XDgbNghRztRtrkHFRlT5Jn9/JYop17B5KldwQbMebYOLUj1vCLi/w
	NkVpZtOzaPDxw8HTO7DluMmtn3rZ1sYYOlEns27oFLhu9YuQ4jgsUZ1ozjYWxiAqkVaQmGFEIPG
	q/poM9ktjtszB12Kg==
X-Google-Smtp-Source: AGHT+IE8XrcOsL1rWzwkMbgHflL8vbyW2fCrqZ3kwKccRiEzS6MH+EPt7ULGAqOqBI/jjSYJ4B8a4jczeivubLyQDNQ=
X-Received: by 2002:a05:600c:3b11:b0:46d:1046:d356 with SMTP id
 5b1f17b1804b1-46e1dac2e1cmr31049435e9.27.1758655983762; Tue, 23 Sep 2025
 12:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACKMdfmZo0520HqP_4tBDd5UVf8UY7r5CycjbGQu+8tcGge99g@mail.gmail.com>
 <CACYkzJ7X2uU=c7Qd+LUKnQbzSMyypnUu_WCMZ=8eX6ThXn_L6g@mail.gmail.com> <CACKMdfkPsemrUMPXNO5OR9Y2y70xNVVY9ss-3hX9NtGXFJxyQg@mail.gmail.com>
In-Reply-To: <CACKMdfkPsemrUMPXNO5OR9Y2y70xNVVY9ss-3hX9NtGXFJxyQg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Sep 2025 12:32:51 -0700
X-Gm-Features: AS18NWAN9XrK1XwDoJdvOpkTTC6Whfk3KPMyB7ODQPD4-VPHBDtcbbqqaxPHF-A
Message-ID: <CAADnVQ+XW_YC6Edauhf+AoWLx4uSNchbQUic33oTeNskp9yt3A@mail.gmail.com>
Subject: Re: [PATCH v2] docs/bpf: clarify ret handling in LSM BPF programs
To: Ariel Silver <arielsilver77@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 3:03=E2=80=AFAM Ariel Silver <arielsilver77@gmail.c=
om> wrote:
>
> Just so I understand.
> 1) The docs are indeed wrong, correct?

It's arguable, but removing if (ret...) check
from the example is worth doing.

> 2) Any idea why I get an automatic response of "CONFLICTS" when I send
> my patch? Even though im 1000% sure there are no conlicts

The patch doesn't apply to bpf-next tree.
Pls use the right tree as a base for your patch.

