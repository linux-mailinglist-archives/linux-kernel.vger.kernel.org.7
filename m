Return-Path: <linux-kernel+bounces-734404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAC9B08126
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D96583359
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A51C2EF2AC;
	Wed, 16 Jul 2025 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Mu8WZV/K"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B71C3C1F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752709930; cv=none; b=i1uGTvPpZtKOWYXYpVx2amAkxY7KARTNdG0aCs4877Lhvi9zm9jnU/PVO5edGartlQ9nh0A8MGo2lkk1BW1U17sWx+fah/tZnQSk+VPvZvRx6eh+2LljTNTO5lIpyGYfqhFSuMPWbwCGFh4VIS3jXhFgR9tbAiHP2+BwVCexafc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752709930; c=relaxed/simple;
	bh=8cc2Nz87MAuzNDTFYLrAfgQhXEv/HRfUJbJCoQPND0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaEmviso9++qzpa1gFQj2wAtHqnUQCLlNYCeVoA7YuMdGbAQOm3Dgdjgrnk3gOpIkzWcWSRLE5RrwD0Ad2lj5SIAt3TxQn3vs9J96PkHplirqozgtLNja2vp8J/XAUP6jI6uaXfFcXXOc3jpqm0uJfBSYCnJHnqc746K1u6Hc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Mu8WZV/K; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso352682a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1752709928; x=1753314728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9iYhf+TmOaeuGFTnHtMZsVUbgjznZbhmRqA/iiwsEQ=;
        b=Mu8WZV/K+dCgYDZ0EFvxwJn7z4YOXD1bsuHZqqP1V/kfTqca+1d9vqEio19KxAlG9/
         4A7Wo5tRnOOPZ8sniD+dy5ZWXsSBuw1PuErww259WISuPzaFOmB0ZjSUM6FqLXtwY1Ub
         N29af4gOqV6O5ZkyuhRJRNFX0BhKUnsDTVlCuMXQenDQG/jiic0NhuG5pJmHE3fyxnbQ
         /YMvVLmmSiV80vHWTkmSCy52sqdWNO4/PNVXO5zegR7ElrsYrys92d12xcR7I1p06VYS
         VPoYF2Fr532yc0OpsvCDLKUH9gBTBriWyBrV7KWNNv+O8nmtfJVUjvT1S5D5FzhF4sty
         oo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752709928; x=1753314728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9iYhf+TmOaeuGFTnHtMZsVUbgjznZbhmRqA/iiwsEQ=;
        b=Mcdj2UdNqWKWqGpwxrkxGZKfLi8+HjMZHYjcxVbFnCl5sCiQO7qYt5wBwVkxuhYoG4
         siit+2ECgT9R66z5Qz7fHD2rl4BgLJNAjn3pt94ePKzEcAFrMX3tSub3PAaWaotmeRUM
         67wgJkvTLpJsRLW9tt/LiHjbO+W16Qfyf5PHBMl3P4Eknoo79BcFlHRmWIlVjJYSIJZx
         7+xK02t9W6YEIj2aUzKU2jW87pII+pBMwIyTn5JiwP/1fyoiDVUpHjEDZ6DInEmnAMcS
         RpSwg6GGlpKCO7/xvX/seC9niB1gimcYWCUasiujqmFeYRloxBsqLdOKk6ft0n6TT/D/
         q+pA==
X-Forwarded-Encrypted: i=1; AJvYcCVAAYGyCVtkhxpWeIbi4Ee2j/cQ7SIZ3XXO+PzFo5LLKPNtOYurFPiiVdUaCgQ1fznbf+Pt5O7K6SIbZD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoClJpSQMCzgj+iCXr0TVTQq4RJUAIICHpIoxrDK5ed8Mk9ljG
	vRXLeUzsVwxjYAnwnnQ+2SLlNDLqbDZcgVWmAEn0Ga6YIzpRMpGgAzbdzJCxtGr3tn8=
X-Gm-Gg: ASbGncuepewFN6fbcrEoAkR8TLlVu9z7Cq8M0IZAanswsG1uWIxzKSTJW5nKV0MzDPF
	EDSqtdK6vulizGwHSHNTmQO+3uE2KPhh6v4r2RQDe0KZZOBEnwu6rPNS8yCQW89+S2aiXEsQIbI
	VcxevsBpC7Vs1STDAb7nenO+URNfun1STfdYtIhvXKQ4r9r43KDDD4KaWD9q3QOtT98ntZWd4A/
	SiRXA93kLuthJN9lsKHEJ8eyjP5XX3BSd+wr4063EEPKWMSY+SAik258/TW1anTT5DR3Lu1FKes
	hMusZghYjn5nuwBfI6eAnTMgWW/EcTTlubhefSQFOeP3F4OtL2ZdEZ2NWTuuNne0uQYqtopf+QE
	5kfLpM2mCRXkJZZc3ucsMTZRzmG+e25bNunvzhWR79ZH5YuuYO8+v/bTmyauPV1wWRmRN1DTzhw
	==
X-Google-Smtp-Source: AGHT+IHUiw/cyohjV69lTrcKLCPTOr7ZJr1M8ncyo7AQFt9fgkchZHyM+/jOrI9YcMR1a/4YY9Pd7A==
X-Received: by 2002:a05:6a20:734a:b0:220:3870:c61e with SMTP id adf61e73a8af0-23810a5901bmr7838780637.4.1752709928032;
        Wed, 16 Jul 2025 16:52:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-64-170.pa.nsw.optusnet.com.au. [49.181.64.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd714bsm14430679b3a.6.2025.07.16.16.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 16:52:07 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1ucBuu-0000000Bx4E-1rfh;
	Thu, 17 Jul 2025 09:52:04 +1000
Date: Thu, 17 Jul 2025 09:52:04 +1000
From: Dave Chinner <david@fromorbit.com>
To: Marcelo Moreira <marcelomoreira1905@gmail.com>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] xfs: Replace strncpy with strscpy
Message-ID: <aHg7JOY5UrOck9ck@dread.disaster.area>
References: <20250716182220.203631-1-marcelomoreira1905@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716182220.203631-1-marcelomoreira1905@gmail.com>

On Wed, Jul 16, 2025 at 03:20:37PM -0300, Marcelo Moreira wrote:
> The `strncpy` function is deprecated for NUL-terminated strings as
> explained in the "strncpy() on NUL-terminated strings" section of
> Documentation/process/deprecated.rst.
> 
> In `xrep_symlink_salvage_inline()`, the `target_buf` (which is `sc->buf`)
> is intended to hold a NUL-terminated symlink path. The original code
> used `strncpy(target_buf, ifp->if_data, nr)`, where `nr` is the maximum
> number of bytes to copy.

Yes, this prevents source buffer overrun in the event the corrupted
symlink data buffer is not correctly nul terminated or there is a
length mismatch between the symlink data and the inode metadata.

This patch removes the explicit source buffer overrun protection the
code currently provides.

> This approach is problematic because `strncpy()`
> does not guarantee NUL-termination if the source string is truncated
> exactly at `nr` bytes, which can lead to out-of-bounds read issues
> if the buffer is later treated as a NUL-terminated string.

No, that can't happen, because sc->buf is initialised to contain
NULs and is large enough to hold a max length symlink plus the
trailing NUL termination.  Hence it will always be NUL-terminated,
even if the symlink length (nr) is capped at XFS_SYMLINK_MAXLEN.

> Evidence from `fs/xfs/scrub/symlink.c` (e.g., `strnlen(sc->buf,
> XFS_SYMLINK_MAXLEN)`) confirms that `sc->buf` is indeed expected to be
> NUL-terminated.

Please read the code more carefully. This is -explicitly- called out
in a comment in xrep_symlink_salvage() before it starts to process
the symlink data buffer that we just used strncpy() to place the
data in:

		/*
                 * NULL-terminate the buffer because the ondisk target does not
                 * do that for us.  If salvage didn't find the exact amount of
                 * data that we expected to find, don't salvage anything.
                 */
                target_buf[buflen] = 0;
                if (strlen(target_buf) != sc->ip->i_disk_size)
                        buflen = 0;

Also, have a look at the remote symlink data copy above the inline
salvage code you are changing (xrep_symlink_salvage_remote()).

It uses memcpy() to reconstruct the symlink data from multiple
source buffers. It does *not* explicitly NUL-terminate sc->buf after
using memcpy() to copy from the on disk structures to sc->buf. The
on-disk symlink data is *not* NUL-terminated, either.

IOWs, the salvage code that reconstructs the symlink data does not
guarantee NUL termination, so we do it explicitly before the data in
the returned buffer is used.

> Furthermore, `sc->buf` is allocated with
> `kvzalloc(XFS_SYMLINK_MAXLEN + 1, ...)`, explicitly reserving space for
> the NUL terminator.

.... and initialising the entire buffer to contain NULs.  IOWs, we
have multiple layers of defence against data extraction not doing
NUL-termination of the data it extracts.

> This change improves code safety and clarity by using a safer function for
> string copying.

I disagree. It is a bad change because it uses strscpy() incorrectly
for the context. i.e. it removes explicit source buffer overrun
protection whilst making the incorrect assumption that the callers
need to be protected from unterminated strings in the destination
buffer.

This code is dealing with *corrupt structures*, so it -must not-
make any assumptions about the validity of incoming data structures,
nor the validity of recovered data.  It has to treat them as is they
are always invalid, and explicitly protect against all types of
buffer overruns.

IOW, if you must replace strncpy() in xrep_symlink_salvage_inline(),
then the correct replacement memcpy().  Using some other strcpy()
variant is just as easy to get wrong as strncpy() if you don't
understand why strncpy() is safe to use in the first place.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

