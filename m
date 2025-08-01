Return-Path: <linux-kernel+bounces-753326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368D1B18193
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEB44E32B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB14246793;
	Fri,  1 Aug 2025 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlUh9G0A"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC79246765;
	Fri,  1 Aug 2025 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754050784; cv=none; b=tuGiPNT9MHl2dRaJaPndM+h9qp+a7nJJ/0bXmef68wvM98p6yAfl/EjfY6YAwHnYRdAItw1+4bCE1wd83qbK91j3Bo1g9fvZuzuMWFUN7ss5tgToYAxCl+QNUkNGqJv5eH3+xMqd+FfIxQg40SjIjRZ2KmW37xQYrpU6Tl2V/7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754050784; c=relaxed/simple;
	bh=E5ucJWZK26CYGuCx0hTvlSgmID8FvE4hHQtohgaxYrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFsql7JxL28p+bGT/MLWUX057feuBib8YbJ33h9JZ0B4hXnsbN3W/1fEdZILUrfIRCZllwVZ0547NuUgV1bSgX1DVPlt1Z/RTjGhHhtMt9ox0QZKKrUhl0EEvRKhnictgS9HbJyJyroCn8FnbymBU5KNlgo/CbBzSjvy0O/3OAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlUh9G0A; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-240240f1478so3766365ad.1;
        Fri, 01 Aug 2025 05:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754050781; x=1754655581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5ucJWZK26CYGuCx0hTvlSgmID8FvE4hHQtohgaxYrQ=;
        b=LlUh9G0AV3/740S+vnAhskzAtaorbAPZvH1PusLlzKXt21Teetj7plcqe2U9m0zUd2
         aYwsUP6On8Txlj7pQ0+jWuscZlfPY3LWu4qC7Cs4gr5vPP7z0C+GZHBY0xFZL11yhwkX
         YAenG6QC1+uH1pyprsHw6GrzXU/JW69Nz+bE103+VkmtY6q/WuxqiC+A07rT+5IIpXQe
         nVyqDvwOyCpTO53Pi5kuiwhx0gPFe2/a9pS01JRdB1np2KxcC0U4sRWcMIkqU+tiQldY
         DjcZbk8/lIyrDPQ1qGJuCFsd6AYNmfANKrq1gx7WJRIvu5NmfVJgwQEznLj+gaKTWxRk
         llmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754050781; x=1754655581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5ucJWZK26CYGuCx0hTvlSgmID8FvE4hHQtohgaxYrQ=;
        b=chFWKkLY4Dg8TWS303jTBqwXx0dcOP8LazgBWrytxYxD+qMX1Hqk6Kv+QgP+1fxrRC
         0wuSdWwX8nYbVD7fHMXVPtqTrVXWqV6ViRuBBgpmP9kcKc3sHIr8jX8rF+9rKWrarWey
         gZzB0Xb9qKpAG1nuoQfPvURJSsTD3KfJDgG3mTrH0oooQVqWDHt+7t0b9nfAL6lF2w4H
         p3csQ3MwDq40tWsuq9qRkmPJcCFWJronhuGXuQ0d1HzHI20QRZbVV+ffweHyICMEtMKq
         4zAMK4DyP+4jVt5cgwvhPCom6EjpaOdnyV9iqOpZTHxZrreA4nqZ14zNF/GkMj/ucWcd
         jx4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTN+/6iYcHjMD+COTfVqfAJb737uJpCvYajUVPBkVAnnnPpWSq12eypROXUde2iB40X7H5vavMRV+jQv20SK8=@vger.kernel.org, AJvYcCX6e8ia0xP3CMNtj5rYpFNqf/s69L+8Z8WABKq+qG/TTXaeLOsbFOzKttT3+cn1ZUHwmhc3WimpBrssQBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypTXeKf8frd/dTG9NOMfK6amiyCBRhrcToSDTLI20fkJNI+5ne
	jzi6+1i8AjA+9o/ltQ3Qxa99L4OxqsxSxz8jZQJON0oHmKLmgJjP+vJlMDDzIb3+6G8scR3Oz8k
	Pc9bECVRgiVs8vifyf0oYvA3VrzHkuko=
X-Gm-Gg: ASbGnctPt0mqZOpzSjoqAThqe6rPbQILfCvFbf4abAu8EY6wgS5xWeeBkCgV8x3WMaL
	fKmQ050Zk7tmJW9ZaYo2aOXJqvXBWjgblh624eimiWm7pRqSblPmLISvM9FKB/HctjCFQcwpwiM
	Dbi+xg/N29ves+mYlH1EH3S5yHtUDXWwcck2qxyGq+CIC6k1LNBWI/eoiTFo/bwUM0NvNg300Cu
	O/YAwrs9iaEFDYpEuI=
X-Google-Smtp-Source: AGHT+IGSkEGAh8RQHooFN4XMx9mIZkhD9qsm/F7EHJWiI3Ihlyq0RCC6ip9r+ksfPtD9bqL/B/S4sPujooHDkDeGaj0=
X-Received: by 2002:a17:903:3b46:b0:234:df51:d190 with SMTP id
 d9443c01a7336-24096a5d1fbmr46397345ad.4.1754050780912; Fri, 01 Aug 2025
 05:19:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724185700.557505-1-lyude@redhat.com> <20250724185700.557505-3-lyude@redhat.com>
 <aIXVzIwBDvY1ZVjL@google.com> <f92b5f82b3ad7bb8d5bf60b272aac8cf1e6ced24.camel@redhat.com>
 <aIi7ZycRtmOZNtcf@google.com> <ddea64af3b845d2c32d807c5aab6146a9ce3c2bf.camel@redhat.com>
 <CAH5fLgi63Avw2VYvaOEdZhw93Qb+1isuW-CsyaD-_ask62_tcA@mail.gmail.com>
In-Reply-To: <CAH5fLgi63Avw2VYvaOEdZhw93Qb+1isuW-CsyaD-_ask62_tcA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 1 Aug 2025 14:19:28 +0200
X-Gm-Features: Ac12FXyppiVOSM9kAdVVdNa7pzMQtgTjeEzv-BNsRkeIv9E1KjQqT9KtDUbHK8I
Message-ID: <CANiq72=P0zXVOBgfWU7cec4wDiXoV_jUtVR8vANT0M5=pcaYRg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: time: Implement basic arithmetic operations for Delta
To: Alice Ryhl <aliceryhl@google.com>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 12:10=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> #[cfg(target_pointer_width =3D "32")]
> or
> #[cfg(target_pointer_width =3D "64")]

These are in other proposed series, and in-tree we also have a couple
`target_arch`s, but I keep wondering about the familiarity of using
these vs. `CONFIG_*`s. I guess it is fine.

Cheers,
Miguel

