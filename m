Return-Path: <linux-kernel+bounces-858464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98960BEAE3F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 064535A323D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A4A2BEFF6;
	Fri, 17 Oct 2025 16:39:21 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35292BEC3A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719160; cv=none; b=Inob5wA+NI8PasYjwJaf6OOGc+KapC7MtQsdGVLhzACfyi4QeLt0A7jeP51y8U0JrJKjk9hbaTjYkDyfgMlfovMdjPNrTzSYigaJ/98cnlLdTL+QPC+oTIMjmTgo+oHYMGCAcW9A3mHxyn9ZXkToc1dhHxFBTVkp9puQimGOMko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719160; c=relaxed/simple;
	bh=NfOtUuMo2bwMPO8gai/HvBpCuZ8kXKbcNDvD7FcJZOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hcn0DQpBkcvgipLSA/LzWTaoI/b2QIKRX2vcNwvcF7xUeu2IwdNPFJ6fQn8hV6cbYYx0x95A2jw014aG9gvcNiV5iWJH9+GjkaumxVTVJw95cPjlFwaQr4vEJ3nmLZylvz6FW8sNzc1+7oRJ5QNmHnWXiUVPgoWbMDuxnkJ2ELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-59dff155dc6so1047905137.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719157; x=1761323957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0Tvx9lsrJzDtuSp7NrJfF7JnTCr7NK1zbx5mSNtjN8=;
        b=s6VgjkRR9VPow3BV77fKTke23jskhTfzr23U0VDXhMMdLm8zXxPJtIJNj/r3fmXnVa
         CdeSoivugXQjh0MaEe3VxrPWtDYhwvZYM4KDy+brqI7xZuasT7AWVyb9MT0n9hIJXSXk
         lPXsGiDqtx4cflh12l5ZzhqHgLKAEEW6zfuOJxA/ezbenjokwm05n9EEVIiXfs12LARp
         0w0ykae3yWic6poAVN/EphqvaJakyQvEkBuF6oNUot9VuvzhbPtD5gb0SHoVb5Rz8As+
         F6os6RnnC4e0+72Gz+/IdWCMzyd+8qWWCbZhEptmNngsHGn00NmzxQzeHVUgY/EWtGmO
         fqZw==
X-Forwarded-Encrypted: i=1; AJvYcCXBMJbsuNrirV7t66n/Ef1vMu4VzKIVUzg9N7D7wl5KExWi6EmakJYT7LMQZZass+xuK6ngIttZqHktTKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4EULrdvWQRXh9hEwBQdmmtbyGyTvD0Zv9n9MtWqSuAMDBfuQU
	T3YNKCNGLHn+wSU6AWiW5yKRkLTpNBmHjpiwDG8O9oE/k1Yjn3ka18fU1IwAS7zt
X-Gm-Gg: ASbGncvCPE/lKPKcQFzQHi8ZsnvfHL6TTMkHtANYzLPwgD7zumEmfxuKaQfbUbgqMku
	aMRtOzMYPwCgZsuQ8+GwA1W4Fa5YzcezBo9ejxxLiF1+El5fjX06atw15huqeVUHx/qBuTE+TsD
	jpJZMAtDycPr4clKn7U4aG1F9FgZYH9VB1zAb1VWxJfw4Nxxwn6rV9i5ONATybMYtgQl5fZwjXL
	hlyU+vbwUMuoNHvkgmCuDnKXbdfUcovdscsa304//O7gKTRM8w4GAVSbvNSYzLC2am9nVi76/fh
	SAG6stWd7dOlAfk2KCllSJ+l+tVrVKzB7rv4zvB34dDgbu3qxtGx94G/gFaG4MBNdzR1o+S4jsy
	ZuS5n4prTJux7BKv6/bdZQhEMjAKpQN5+6tfyw3plGNYKy2ktE3D6uBFD85wfWnBfxRf26SLdw4
	KDwLNTS3YX8K5ShZzODn64anFoNO3nBpbgiNvWzg==
X-Google-Smtp-Source: AGHT+IFjaJNP0OmaSsVXXiyAcdbahS5cH6NUBwWipaOwoTaDGUYPRY81Tlzu3ETR37bNQ+/tYwCJGA==
X-Received: by 2002:a05:6102:358a:b0:5d6:101a:8bb5 with SMTP id ada2fe7eead31-5d7dd5c0730mr1877059137.19.1760719157552;
        Fri, 17 Oct 2025 09:39:17 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-932c3e479f6sm80597241.15.2025.10.17.09.39.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 09:39:16 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-932c247fb9aso135838241.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:39:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9JpJH0YRXnooEPUSZP86SrZPQVJEw+yi+4j5Is9ItHbrYWUzWT/yNFzbh+Mds2zj2L3+LZU7WojQvB1E=@vger.kernel.org
X-Received: by 2002:a05:6102:26d6:b0:52a:c340:11db with SMTP id
 ada2fe7eead31-5d7dd6a51f8mr1798386137.27.1760719156495; Fri, 17 Oct 2025
 09:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760617634.git.geert+renesas@glider.be> <e1c0c2acbab60630cf8538ac5446f91970dad92d.1760617634.git.geert+renesas@glider.be>
 <20251017122904.GC281971@e132581.arm.com>
In-Reply-To: <20251017122904.GC281971@e132581.arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Oct 2025 18:39:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUH2AN7tE3C7cPWeNJDW6jL9vQOktaRDW2HChDwvroSg@mail.gmail.com>
X-Gm-Features: AS18NWA0zz6hIIpzSiBNMZXGZq9sP-ysnqlRTvuWYFFdCu80QapeqEG6wNBFpYc
Message-ID: <CAMuHMdUUH2AN7tE3C7cPWeNJDW6jL9vQOktaRDW2HChDwvroSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf build: Add Debian/Ubuntu python-is-python3
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Leo,

On Fri, 17 Oct 2025 at 14:29, Leo Yan <leo.yan@arm.com> wrote:
> On Thu, Oct 16, 2025 at 02:44:12PM +0200, Geert Uytterhoeven wrote:
> > The build looks for "python" and "python-config", while modern
> > distributions provide only "python3" and "python3-config" by default.
> > Suggest installing "python-is-python3" and "python-dev-is-python3", as
> > available on Debian 11 (bullseye) and Ubuntu 20.04 LTS (focal) and
> > later.
>
> Seems to me, this change is not necessary. The Makefile [1] searches
> python[2|3]/python[2|3]-cofig if un-versioned executables are not found.
>
> I confirmed that I can build successfully without installation
> python-dev-is-python3 package.

    $ sudo apt remove python-dev-is-python3 python-is-python3
    $ make tools/perf

Indeed, it still works. I am quite sure I had to install both, and
even verified that uninstalling them again broke the build again before
creating my patch.

/me dives deeper.

Aha, I found it.  After uninstalling python3-dev, I got into the same
state as yesterday:

    $ make tools/perf
    [...]
    Makefile.config:875: No python interpreter was found: disables
Python support - please install python-devel/python-dev
    Makefile.config:918: *** ERROR: No python interpreter needed for
jevents generation. Install python or build with NO_JEVENTS=1..  Stop.

So these error messages sound like python is missing. And "python"
is indeed missing, but "python3" is available.
Hence I installed python-is-python3, but that turned out not to be
sufficient.
Hence I also installed python-dev-is-python3, and that fixed the issue,
as python-dev-is-python3 depends on python3-dev, so the latter was
installed, too.

After removing python-is-python3 and python-dev-is-python3, everything
keeps on working.  But if you never installed python3-dev manually,
and run "sudo apt autoremove", python3-dev is uninstalled, reintroducing
the issue.

So just recomming to install python-dev-is-python3 in the error
message should be sufficient?

What do you think?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

