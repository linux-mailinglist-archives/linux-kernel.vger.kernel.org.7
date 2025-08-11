Return-Path: <linux-kernel+bounces-763341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68951B2139E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3063E48A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583552C21F2;
	Mon, 11 Aug 2025 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eFj7Os80"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FCD29BD81
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934544; cv=none; b=a0G6X9nYCReNQ378ijl2ZRSGHTqncWPodBJSgfUJtBjzoZnMmCbt/6sqv4vKknKKfxXYGNQChwTJ2q4CvADBHxYgFd5KIQfi8tTk4nVtrICC8ZXd+Lvb36o9Fjx7tZNHVP/EyOtu7MU5piypXDaTRaIKQyAbkk+egE11ZDKL6/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934544; c=relaxed/simple;
	bh=4kxgWwHr34mUxtsj/GXegd0Nh3IyvQbeVbRqJQOaCFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kY740DyvKPhOqYmSCnoH+63tlKmCpgwvZnj8us449cU4P+UB7MuHFMkFYhEtAPd+qUtCl/tANW8xuvX+pMWpS5g1UWSDTJibKsCsSUEN63PHkb7mHdU9Ks8Fmj48GimA5MlnfGSwuKi/HnLMrlOvboRKAKPd6JKuCvDiGV1d580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eFj7Os80; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bd202ef81so5994760b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754934541; x=1755539341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wt9K5DEyPLjM+bq7x47Rs4ozsUCicWqFg4lpxq8FXHg=;
        b=eFj7Os800Q3R7qhaME0Hgv/gDWgpaNK+wNPmhJvPAuHiS/smFVCMAStsn4vVLsBck9
         UBL46NJTHdsTSOdAJT/i3HjMa/tGqDONVWrAHzWp/5r9L2EY4x4eQpKqsz6qB+ffB67F
         VgmtYHtwC2U/GCPY/63IbszTGfMRxphheCEIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754934541; x=1755539341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wt9K5DEyPLjM+bq7x47Rs4ozsUCicWqFg4lpxq8FXHg=;
        b=ToqNhvoey99LIVRqvAt14XOwS9Ge8xVNTsYa5B8LLVdlohT9cj6eNpmFSjAPt2FGi+
         FRBiupmx8FjBx/bIkLPgjCYIZyC4HA2GSfV5FWUugDeFhPh4i19bj1AQ6JzFhGAYnvWl
         kwM5Lfy5YGoxstrnqVtVhH2x8VJZFlV11RdGzbyNt9eS57KX+wLq7/yBcBfNd0bphb03
         QVuligWE/MFNQ7S76+bspmb5oE5vfeGdxQmER1lD7TPkHonPvSwgcFNT6WOVyim+eFTc
         r6jK6lqts9oYExkN6gdqZDbLLa1o2HYhhE4PPIQoeseOPinqIn52p93SWz4WvGcyAtZq
         g6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDSjTRHw4bMgwZjxZa5FyRLEMZwe2Kx1VqxfVm/S/d5Lql+NF7oKP7jBuNTHFXc0FhH567BqKa8UgHfRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywFJqjMN/lgX7iAUznhObRuEdlM6hW2TvZLHDJP/J+S5LWV7RO
	cSyd5f4bZ6DE3pcxqWCD4rNVnQ1UlBpaoQevKcwu3sjUuBKkWRhRbhSHvv8P53dayjqO3CcFOZP
	KZzA=
X-Gm-Gg: ASbGncv6ki43D66S5utwiTMZttJSb0aKYwdMHCi2AIB8KBrItyk2lv6jteinQ9hg5Lg
	UDw0PNXPpyxOIjMHurckd0JIQARkNZ3cZS5Z4E1sQXHVE9FPf/3TQ3Vb/cjBX7S31zg2IVVVTO3
	k+dEy3WE169/I4Wi323gfBbc2oSKAEiLoJAev/QWmwzkEACYIkI/CjkySvoteh/Uv7tQF3UZvmT
	bKOE2wYSJugpd2F2fic4UEKzPVNh/zXc+6u0j9jorohoG6ym69t0k9uh56r3xtHU+NtneMPfEvI
	iyWbz3e0PidXDq3Bp6jCOVgLbO9X1oxOrBGkQTsy+JjKyqcs1oCgSOSYz2yKHoJXID6JSIyrgKV
	8202LTngzOeIrMjKlhS6r/X/Qsi9mjERyBIIbtSJZ+cMA6LMxeodXEeAbIqAWUrVhPw==
X-Google-Smtp-Source: AGHT+IHt4EekP8LmvqAA9Xfbd0uYfkYgcDCDwbQ1xVEH2hcXUkMyMJkdxROS5IYKvmCHfWqG2eM8/A==
X-Received: by 2002:a05:6a00:1250:b0:76b:ee57:9897 with SMTP id d2e1a72fcca58-76e0df65ef7mr684089b3a.14.1754934540779;
        Mon, 11 Aug 2025 10:49:00 -0700 (PDT)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com. [209.85.215.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c61705bd7sm6408998b3a.31.2025.08.11.10.48.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 10:48:59 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b427094abdeso4318293a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:48:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdVcVTzxg57fUPplVwnuoL4DsNsiplKiifdyHEfUn3ciKvriTw5yUSfIOyZ2qCoH2IWeDJiB+mVO55sno=@vger.kernel.org
X-Received: by 2002:a17:902:ef0a:b0:235:f459:69c7 with SMTP id
 d9443c01a7336-242fc36c67dmr5818775ad.52.1754934538293; Mon, 11 Aug 2025
 10:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811170351.68985-1-thorsten.blum@linux.dev>
In-Reply-To: <20250811170351.68985-1-thorsten.blum@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 11 Aug 2025 10:48:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UrEv+=KmjZTDt7F5ftuw5xrpOyEim0OrGAkoiJ5Wi2cg@mail.gmail.com>
X-Gm-Features: Ac12FXxPkL1S2f4PQPz2QV2wpNlFygKeHqK0V0jC13wbb3oVPpObsEueWXqhEY8
Message-ID: <CAD=FV=UrEv+=KmjZTDt7F5ftuw5xrpOyEim0OrGAkoiJ5Wi2cg@mail.gmail.com>
Subject: Re: [PATCH] kdb: Replace deprecated strcpy() with strscpy() in vkdb_printf()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, linux-hardening@vger.kernel.org, 
	Daniel Thompson <daniel@riscstar.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 11, 2025 at 10:04=E2=80=AFAM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> strcpy() is deprecated; use strscpy() instead.
>
> Use the return value of strscpy() instead of calling strlen() again.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/debug/kdb/kdb_io.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 9b11b10b120c..2062494c413b 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -732,8 +732,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt,=
 va_list ap)
>                          * Shift the buffer left.
>                          */
>                         *cphold =3D replaced_byte;
> -                       strcpy(kdb_buffer, cphold);
> -                       len =3D strlen(kdb_buffer);
> +                       len =3D strscpy(kdb_buffer, cphold);
>                         next_avail =3D kdb_buffer + len;
>                         size_avail =3D sizeof(kdb_buffer) - len;
>                         goto kdb_print_out;

It made me a little nervous that you're not checking for the fact that
strscpy() could return an error code. Without the check you're just
replacing one type of problem (buffer overflow) with another type (the
code running with a negative length). IMO in cases like this either
leave the strlen() in there or check the return value for errors.

...so I looked a little deeper here to see if the buffer overflow was
actually possible to begin with. Looking, I _think_ this is true:

* `cp` is a pointer into `kdb_buffer` (location of first '\n')
* `cphold` and `cp` are equal at this point.

...so you're guaranteed not to overflow because the destination and
source overlap. ...but that means we shouldn't have been using
strcpy() either way. Both strcpy() and strscpy() say that their
behaviors are undefined if the src/dest overlap. This means that
really the right fix is to use memmove().

The above is based solely on code inspection w/ no testing. If I got
it wrong, let me know.


> @@ -872,8 +871,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt,=
 va_list ap)
>          */
>         if (kdb_grepping_flag && !suspend_grep) {
>                 *cphold =3D replaced_byte;
> -               strcpy(kdb_buffer, cphold);
> -               len =3D strlen(kdb_buffer);
> +               len =3D strscpy(kdb_buffer, cphold);
>                 next_avail =3D kdb_buffer + len;
>                 size_avail =3D sizeof(kdb_buffer) - len;

I believe the above case is similar.

-Doug

