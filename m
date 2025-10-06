Return-Path: <linux-kernel+bounces-843309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C3ABBEE2E
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69718189AECD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5EB248F58;
	Mon,  6 Oct 2025 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ggsYQF7s"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EFB221543
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774014; cv=none; b=RVpPZUfP0HIT7ujUR9mQkhBHRsV/FGT6pNbTzapxQKRZ7FmK3Y8JmVpJOAg5zOfD42zAB9VPQEI99iqtov3Yk8Gohf2EUolNZpFdEiBYKZmptkEU55R4d9mFpEoQ7nbI7Iumsif3DLpSGKoxMV1tvUyWOp0KPF0UfLRFHhzuhw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774014; c=relaxed/simple;
	bh=44EQK6dLj/vVJbnQAMaOqI2VKfynAQswxAG+H2Hgwh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTf48Bd9fvfOfqKPVqt93pT6Am8fA7nGdC3+FsJY9LumyI8orczVx5r4ubk2kLNsF02OD0ZeP2XbLoWdpu5ViSwBChpYBD/2kVs4Kwmtru2UOXz+9DdR1MpqkJItHJsSbZKc7MAfbRP2Wx7IE1/sG6VaiuR0Nm6bVOnuu9ChFpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ggsYQF7s; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3d80891c6cso981970766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 11:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759774011; x=1760378811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O1YMJ+aXl7EdGap3QzraeXgeu0wLn2f5cQEayrv43cM=;
        b=ggsYQF7sQKUoU82e/h81XzhjaT2uUNsTw7CQScO+tnPYzAuRS4dCQc5ik1vgT09lDv
         E4suAVNuOE6gQkzYJNpLWAkh7dQqIE+FKE3ODB2X4XYi7AYKWTuQajNhlNb0hLby9zBs
         HfO6j5kFpJPifLP2DAcbNSSw8EIkeZr1o5H2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759774011; x=1760378811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1YMJ+aXl7EdGap3QzraeXgeu0wLn2f5cQEayrv43cM=;
        b=rg0fvqYM/XoFQ+B0puz8VZl20EjKBZtFOsD7Tk8y8qNibCu60x3EPupjnE2Um06yis
         iz/K/JjvXFTzeYK9rZlmia8WXziQr7aO5c7LSzrnvYrRmfYUaaL/DR/cA74zP0nD/Gwx
         S4qa2pv0qym9DtCf7nl3lAnChyBKlB5uVObVfvedGbOeNtEowwcpihirxZekx+awb1Py
         Q1N0bsg+q/1K3MVqkDXHQMgEB2M6nzW4RaYBj+aG+28TCWnTAE0D/yHRFz2V+3kGdvCH
         7slfkHvD+yj7R3vRQceGiQ/3uSpBUJaRX8RpJF8ubKbtSqEVtn1b8xh46S3qOYk/Wzm1
         mMpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXISDg1oyRzaj0J6xl6n/5tKDz+VDSOGYKbwFzF59k3t4K0ghqnQiW+lmQ/mK8G4ox7jKTRBI0mobNAh+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YymeZNwCWtl3jDYainWebtEGIMtwnimwShs7y4CXuheoewLl3Kd
	OHPc6C+tDlMMVZTG6JgxIAySV0JE0pAAxaXObKTvbf9dAgF5gbnqx2TXQN8sthK0oP8oCxQEfh+
	G90e6htk=
X-Gm-Gg: ASbGnct68fd8MbKKb5ZNNrjY/xQPzEUGj8ckbeRGU4nwoOiOld1ziy8cGwO8mpRemWt
	+2j8C86+h1yJJkXbGk+OAidPwFiN6SQTXKujo3ncfXju7FlhkKZtosOL0R7JofMphpSImIosfgM
	jJ5JkU8q29P91liL3SVaH9k8oe+3EKivPRIpaUTm4CepXqtQWPSyM9/yJ0FI7Tq2+4oawN+5z0v
	P0d6ZvibLZh1a0WRl9JHDf6cwIlCJTHrxoGvQG2ajN/kvXBOwOufnwoyWjZ2bOKfi/47XxN/iSo
	uhzA/Cq/pqzUM7LWRCk38ZVDoooUltiyAcLtn2aCsM39bqn6uFbeJ5SAnxxgQ6LmJaqDRC0DBN4
	1owTMYDvyk3ifhVqJ2vwFEFD4L/AZ6xgbsL52KfF+HsSFK6HJwNGESoVpIbAkm9AJZznu3ZOTBO
	qiOmKo3XQL0mIA1Edw2Qa3inZzHi666kc=
X-Google-Smtp-Source: AGHT+IEc8N5gaMlhinAt3u3Upj8YAvscjkiaPYAcOWp/8Jo3EKDAuehrHtPq7hJd39iGtp783S6ioA==
X-Received: by 2002:a17:907:d412:b0:b3c:d31:31ca with SMTP id a640c23a62f3a-b4f429f3443mr69305966b.17.1759774010633;
        Mon, 06 Oct 2025 11:06:50 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9ebbsm1196306166b.7.2025.10.06.11.06.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 11:06:49 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso12699740a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 11:06:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPTI0AOAMabJsV8Rn4UDzr5rDWEGhMasreG1+csZ3aLbHjq1DeczaSdno1BOU0Yb8bYlX7i+mFpkV2uS8=@vger.kernel.org
X-Received: by 2002:aa7:d996:0:b0:62f:9091:ff30 with SMTP id
 4fb4d7f45d1cf-639ba74c4dbmr516017a12.3.1759774008962; Mon, 06 Oct 2025
 11:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175974403177.1372080.12078001360837326466.stgit@devnote2>
In-Reply-To: <175974403177.1372080.12078001360837326466.stgit@devnote2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 11:06:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whv_JYJCh48wj7vOZmAB2aLdeCXQQHeKqZKuS1+Dunbhg@mail.gmail.com>
X-Gm-Features: AS18NWBuOR09k1xaNmGZuydmVihgjXT_rrOWnCxozUoDIf387AUt-qXMBUx4cgQ
Message-ID: <CAHk-=whv_JYJCh48wj7vOZmAB2aLdeCXQQHeKqZKuS1+Dunbhg@mail.gmail.com>
Subject: Re: [PATCH] tracing: wprobe: Fix to use IS_ERR_PCPU() for per-cpu pointer
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>, 
	Menglong Dong <menglong8.dong@gmail.com>, Thorsten Blum <thorsten.blum@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 02:47, Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
>         tw->bp_event = register_wide_hw_breakpoint(&attr, wprobe_perf_handler, tw);
> -       if (IS_ERR((void * __force)tw->bp_event)) {
> +       if (IS_ERR_PCPU((void * __force)tw->bp_event)) {
>                 int ret = PTR_ERR((void * __force)tw->bp_event);

No, this is still entirely wrong.

That casts are *WRONG*. They should not exist. And they will cause
compiler errors, because you are casting fundamentally different
pointer types.

They don't just point to different types, they aren't even in the same
address space!

Stop adding random casts. They are a sign of type errors, and as long
as they are there, the code is buggy.

And no, it's not just that IS_ERR() that was wrong. That PTR_ERR()
won't work on a percpu pointer either.

No more of this randomness, please.

               Linus

