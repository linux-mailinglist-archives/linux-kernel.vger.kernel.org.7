Return-Path: <linux-kernel+bounces-889648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B30FEC3E23F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 02:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EBE24E9C22
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 01:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127B11DDC33;
	Fri,  7 Nov 2025 01:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtF9BvTw"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A0C1D61BC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 01:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762479348; cv=none; b=bUAZngvvT2wIFxXm6/pW43roFwG8unizRVwhljv9nup4Ch89sCfa3C/hTHrMNnSaSjf/eoXyHhz8z+1Afaqf88XkETW7alQJViHyXBF7zWV1IhceZ2QQ12gcigwsfFt7icMuEgLv0jbmPFCzjPOZVzg4l35U13aVu+hBVijMDbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762479348; c=relaxed/simple;
	bh=ALv3T0LdZlAXXjuCf1bRzW5Nc+7vXsSilbrpqKU8F5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmNjkr09n/D38QZSKeTnJz2qV+fdLcn2m3uF/hNY3VT2rYgfDluXvobtuAoOIkxQHZ7BOzbOUCSPhe7mcCwrhEru4eskZ/qUULuUc7ItOsSKeamcXFsX1EW4zUGfUdQ+8xpOeCTOgxmiyHCPx8X+PIQ7nX52YjxZpFHzCgr/010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtF9BvTw; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b9da0ae5763so38731a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 17:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762479346; x=1763084146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALv3T0LdZlAXXjuCf1bRzW5Nc+7vXsSilbrpqKU8F5I=;
        b=QtF9BvTwO99ypH/3su0OUvoDSKhTro4nJ/FhDiw53wO84/KwdBROsltJfelyjWV1/X
         h5rygbukzif46hJpSYDoAEkQ/B+c/1u9fXhWm9lKZMr6ln71w7MdwWNcO6PwCaN3xmfn
         iuQA8OaDgsi8mt3TA35PRq/5W2rUBKVoVtGErYfUHnIr/exNiqmv5r12S/gUbwlj9Y9U
         a+zcUWD1RpwVBYNoGI3tK0wgDX1aovolFtQENUoVi5nNizrU9gImC7gVH23JeMy35fTu
         K3HFi81dfz6sPbd6IlfSTl45vbVvOV70+i30ezUY7VtglPVs9aAi8lmWj0dlRUeAiW/H
         HeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762479346; x=1763084146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ALv3T0LdZlAXXjuCf1bRzW5Nc+7vXsSilbrpqKU8F5I=;
        b=qWs2gtQazzvFbiZdBbcZ21kYJbNqEh9OCWw97NpIitNMvZzPVp036Z98wNvcmbEgLJ
         vC4CCblE5iptGOO/B2Pf37Yqz1jYb38TGq8aFwt563Ilttij/6qZ4EPYvUXWxr7/SHX3
         0ASNVlWQBHUKiYXzRZdNRE8ORLMQ5UByTuNNpxmQ/eaEEwpHy6g/hQe7jpYGWNaetOyg
         lxCYVsozuPgThQvZ8d8ENWpuMj6tNSIs0gip1YXJvmllJXVuYnQsc0zCrC/J1c9ja5A1
         ZFtRSW9OiWJ1CWfDRDiMd76UJGbECZ/2EO+MSNjOAmX19JxgYmTv+FBWEdGghg+/0eYZ
         fZ1A==
X-Forwarded-Encrypted: i=1; AJvYcCW/0nmfRmKTXmcOAbsFhdEWAERNRSB+y6WE2+0RLBm9bNYMHtZirjPkUUr08W58K2QpewWb9xjMB0dthFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzITEIMPPWl549DhVfyxTMv0xIl+xdjjZj36uqQKYcaQHe9zeLe
	6VvS7R2K42rMdSJz8iX3M5/OAGOFH9G1xxDIkFIcMzefMm9/XSpH/lZ4FJr6fXVrhULCPch8RqY
	nnhz4B+5NQXOrO9EOnvNIzrbn6RezpJo=
X-Gm-Gg: ASbGncuQ1Ykw2mH7zZm62V8xt+f0sTu/qTEKLYKi34ia9YqY/fz3Q5CegpduKU078Yl
	/LHZwxjr0R/L4Yd/8PAVYhzP6R+xxGmo3EsrUwmz8luKEkavXcv0LemXlKd/RYDpG5K0BU1+zdc
	48xWSfZCiOZmgKe3ZnLDYMjbDi4bVdvhi07S7FLT11SFEAOLxQVg7SdmKZf4CnBHobYL61PEuSc
	jyu0yMexJEJDXUGoRBij0A05pK8otJhYQlwFu+vjUIoL986fTFsbe1i37G5LAS1J1alLh80Hig/
	tc7DBPDMcswFNhxY+Py4S5VQ/VjnrjXOuKB50PqHIEl/b+rOgEIMkYjE4EDksSGzQ0gwPpzrfqK
	78Ss=
X-Google-Smtp-Source: AGHT+IFdOCSY6O8qmuLhpo+egzhILHqwOsqZrle6tFjkwWMOjETCtWvvAvG3V2hIcW/LcQ1fDLv4kKGz0fqfoB3p3m8=
X-Received: by 2002:a17:903:41cc:b0:295:558d:a464 with SMTP id
 d9443c01a7336-297c0456faemr10946665ad.7.1762479346436; Thu, 06 Nov 2025
 17:35:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQjua6zkEHYNVN3X@x1> <aQltxZIVd6w5VNtI@google.com> <aQ0ERJiTpiA_rL5D@x1>
In-Reply-To: <aQ0ERJiTpiA_rL5D@x1>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Nov 2025 02:35:34 +0100
X-Gm-Features: AWmQ_bk2zd2IkmzGmtFBN6lT1ctf4sW0mHoVMUEeA7J802zxHrPs42dRjI3qLOU
Message-ID: <CANiq72ns1sRukpX-4L3FgqfJw4nXZ5AyqQKCEeQ=nhyERG7QGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf symbols: Handle '1' symbols in /proc/kallsyms
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Trevor Gross <tmgross@umich.edu>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 9:25=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> So far, '1' symbols are Rust symbols, in the Linux kernel, for unnamed
> closures and its prefix code checking for stack space, Miguel, do you
> have something to add?

Wait, is `1` the symbol type? I don't know what that is. That column
in `readelf` isn't the symbol type, no?

And if I use `nm` on Fedora's `vmlinux`, I get a `t` (and the
`System.map` has the same). Something is fishy in `/proc/kallsyms`.

We don't handle the big symbol double-byte... I will send a patch.

Cheers,
Miguel

