Return-Path: <linux-kernel+bounces-825327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E55B8B8F0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB5F64E2437
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0302DFF19;
	Fri, 19 Sep 2025 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpNU1SxH"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2590D2D6604
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321492; cv=none; b=FMvVyg1LfmO+Cd8jfG8VRKuXLTEdmCBPyJgScHxpGpmD1cSXqA5w21haUzHIwEp9BEboevfwO36WS+5iI3eaJElZscNLopI8/uJDC1bhRn1F5vqP6DTjuGQ/pA6Qm6sxELEFR4d1tL67wrpUViXvI6EndCvrVYHHFU8bH6t1oxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321492; c=relaxed/simple;
	bh=1QDuwK6JmCs3mQmCp7IrqlLAjWOOFGEICh6QKC1G0Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlKxbBkzWgtr8UBq7h+eItgwC8IPwVykIceN5e/eux/X06D+HeqcfIpOf8Ge9zPTB+CyuMOPPjxf76YCcPS/94VXFAhRwtxAzKFuv7eV0oBlu9rM8+7yr7K2AKquLVws79z+yzZSqGpL99BD8EoMHBD6RXv3AcpL5Am23LSM3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpNU1SxH; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5515eaefceso1476005a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758321490; x=1758926290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwMdv+p19BGi7esfYOG2GhYtNoTlMjkcb80apKjxE8M=;
        b=VpNU1SxHpu+eFxeyFow1pdCBSvXPPckHzlBkpLfYY12XjLxazMH7hYUZUJYrejH1o7
         lpaY+d2FpMZWDGb6OP57OUjm18iu7lkvOhvp7psYfU7a1U1T/noMQY7VMKGLlVmx7ei7
         MZxpoi94vtoArZdl8McxgzAHhypVeiQF2Gkxf1I8mjjYVGo3t0gKtcraaq48WSyVJw00
         q+E+BKwSvmRMJBIr7qgwMz7LBW+S/Gg4o1doy+RfMGYA353nRmMxZDLf/Le0XveKOOQF
         uMlHxnUyrdRYrNak/UNZTG6hFDgkLhRhU4FLpbgWvL1F39EmoI69nduLNMDNISPmW0aF
         YvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321490; x=1758926290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwMdv+p19BGi7esfYOG2GhYtNoTlMjkcb80apKjxE8M=;
        b=MQn9BfAz6NAVBPq4o6jRCgO5kcTeqlxSFv3Hc9jA28TVhcLWGJ7n9jTHruXMEe3Aol
         aheNLw5UA8mVfrJJWkKTPS1rmwMbFhxIkQmnZJWo6f6TwJtTHjIzIgS7unUZiW+ViGJ9
         0GEQ/qUbAFsTDd5seovI3PpviwRuT9BdJJVy0rqGGXltbWCLvsjwiT5qsuDn37VAixDw
         YTi4K4NURkqqNzbY97YvVQFsnCEHkSQ6Fv3FcfuNujS8pjboImA6Qy2fBe1Sykqjf13Z
         ZRnVg7pCTrSmhU01m2gbPfjOZx0m7zchmI5FaG/vQD2GG/cymoDyxyn50Q9jkpDRdnIC
         eUNg==
X-Forwarded-Encrypted: i=1; AJvYcCX/LQQvR4wk/SL2/XQUXhHHkaDimkxW5pOIpNBNmydZBZDZNWQqr8XM73hW6tV5eSclKkZIMgnZdfOU4E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNcqD4DQFDhjR1NAG0TdJ71P5dhzdXSq2ixE+V899qw/fejFtD
	PRC5lGb9WUuKI6y3B+9vKWXO/abYK+/XTkEc4Leo1x7tTQDi8he7RGg2neFwCcIfE96kULQ/JVy
	BZZAutdNzuk6Qh8LK38nHRaS4YFHnFs0=
X-Gm-Gg: ASbGncsj8sOvl0pvALmn8TjDQDqOUjudxx1lPu9TZegxi9Bz6yELOS4NJRTOAwfgQBW
	oDPzgL8kpYvlS+IEvFvTszWAslvm3zY8YUJvI8ryrkeK87oWzxilklGd4GQvH+DD0VwXhPl8Po2
	iiFejJNsbW1KMif5dJC5dwUnzhMmMK0JUO2bDXcbCUhOSrMaBjgaQi/7FhZhI64c3IuWPxRd4rN
	SId0i+V5MHf2myyWwCoyNE=
X-Google-Smtp-Source: AGHT+IG5geaR0OTD/awjdGs5/vlEzVQFwf3QVLO4VifwvhZLe07HajKCLeG+iAVevYXk6ErhK7TN/q52Y2EL8n/fzcs=
X-Received: by 2002:a17:902:ccd1:b0:264:8a8d:92e8 with SMTP id
 d9443c01a7336-269ba5782a1mr68547505ad.59.1758321490463; Fri, 19 Sep 2025
 15:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919034816.1287280-1-chen.dylane@linux.dev> <20250919034816.1287280-2-chen.dylane@linux.dev>
In-Reply-To: <20250919034816.1287280-2-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Sep 2025 15:37:55 -0700
X-Gm-Features: AS18NWB691QlcmBJKikgcgx1RsqS2VESdVs2gFgHpIjJauaKsboNjsk2CHaQDRk
Message-ID: <CAEf4BzbmTK9HtR0RwY30bPa1oObALv_prfZJ2sZq3eZku6pTzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] bpftool: Fix UAF in get_delegate_value
To: Tao Chen <chen.dylane@linux.dev>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 8:48=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> The return value ret pointer is pointing opts_copy, but opts_copy
> gets freed in get_delegate_value before return, fix this by free
> the mntent->mnt_opts strdup memory after show delegate value.
>
> Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  tools/bpf/bpftool/token.c | 90 ++++++++++++++++-----------------------
>  1 file changed, 37 insertions(+), 53 deletions(-)
>
> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
> index 82b829e44c8..2bbec4c98f2 100644
> --- a/tools/bpf/bpftool/token.c
> +++ b/tools/bpf/bpftool/token.c
> @@ -20,6 +20,16 @@
>
>  #define MOUNTS_FILE "/proc/mounts"
>
> +struct {

this should have been static, fixed up when applying


> +       const char *header;
> +       const char *key;
> +} sets[] =3D {
> +       {"allowed_cmds", "delegate_cmds"},
> +       {"allowed_maps", "delegate_maps"},
> +       {"allowed_progs", "delegate_progs"},
> +       {"allowed_attachs", "delegate_attachs"},
> +};
> +
>  static bool has_delegate_options(const char *mnt_ops)
>  {
>         return strstr(mnt_ops, "delegate_cmds") ||

[...]

