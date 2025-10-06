Return-Path: <linux-kernel+bounces-843511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E64BBF9E1
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB9A94F2D8B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9849A259C80;
	Mon,  6 Oct 2025 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hcVP81YW"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF60621C9FD
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759787698; cv=none; b=uZ4HCDAemD2+gCJ0y59vu9LixPFQSYOMNJZ7YCtjn59lDsMLZRZJ9trPcR/wPkZwAOs3YT98ZDGy/DisgSd8DtReo/MmTHRpu/r3p/aThfjomVy4654pOHE80NLP/tNn+q5Xy8y7zasiFXVvcYajbmpBaLbCzeBxNrgyh6QEecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759787698; c=relaxed/simple;
	bh=TWxpUrysf16+ov9dpvsDDDOufpdomI5DiZFLgIza93w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdAS0dgVhPOe1toVH88vnqmz9CY0+K2ivDbLFt79gLvw4gx19lUEA1J1C9cN0vS3XyMshkBkW1hrs9QH38h9gvKEN1IADaAwr8A3w3xDr3tGUw7SuOCUvTdfYNsK080Imd1YtZ3dq5DdMHjV/Oy+oUAkMEh5gp+CC/mvdN07o48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hcVP81YW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3b27b50090so1017359066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759787695; x=1760392495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SDCKn2qbtodUcRBoRw+ujzLtuCdD/rFo1KUv4Z7GG4U=;
        b=hcVP81YWcwMP5v9qflhqYXohel5Sxj8C0QeydzniX3m/wxiqBm1Dvvw4YgCI2yMEQP
         DCBs/0obkzJGMSvQ60zncf6W2AzI+W+f+KsdV2dIAFmug2p+Sus/5QYcYU0qFKqpCevT
         SZAKyLxyCwkPCHU7zhjYZijQuQKvPk6EC5mE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759787695; x=1760392495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDCKn2qbtodUcRBoRw+ujzLtuCdD/rFo1KUv4Z7GG4U=;
        b=sNRVoJGBSisPxWAPl5d0Geg5bcfX8ElrXpgeXW6fi9yrW6SNga7/MSfcV4TGkxL989
         tNo3wgPnm5no9qbrK/asXU3KRbE2WCI6T0tXWLFrn63XISIShhgS4AKv//Vm3thoWk5m
         6K20nng/u30t9BAtG8NaPHjtZgIX/z6XoWjkh3gN/ZPAZjnudgYktLVNXubAMQO/ZXGT
         8u+/O1wySMwZ+idNuaul9di0WystKjBQOKutEOKPfvzrm78nulW3DBa3Nky1pUGhf6Z4
         qL8tNciimIvEsKtIrFlkHgB8Gzlj8ZjW4tuzAALi4Ues/fGoXSiFh/SJTw129Rw3ARUy
         WO2g==
X-Forwarded-Encrypted: i=1; AJvYcCX8LT8SgzJ+TA0n0cKlGG0oQFN92Jar13PHgbVw4mRAvxEBVR+znFl82bcP5AtqttYzCWYSoYJazSw08TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwdZ7lEw/o60j7NH8oR14Jsqv/moZVm6HiiiDKahRaPNMJa27X
	Y7LZhu5tD9Fs/0W1iCyLQzGSTSBQzqYCDhxsVFJ0GP/4iSrnRiMWobX6Cr2Fw1sUanzLK/eun7w
	o2zQ3EPc=
X-Gm-Gg: ASbGncvhaPeuWjSpbLDApwFCDdZbm2nGk45+yqG52EHLVBKpi2AD0TCHdN3PNoVdHxD
	ju45bNPD5An55Wt+fyJ71AsezizRafZZUll+2K94yO7jZe0bGVlDa8mQaxPotgZS5kQfgbuWtSo
	IzmHec6GbknLvKc4myQyOscTpo2oKTw/cGjo3lJ3KqGzLeLg7WWOJ2aybcEMCoNudbrG2ELDV83
	XIbL1kgJyK9l/t1TRjRtYcgbsaGZdEMURurZ6DIrFKP/lsa7QnEU/w5cL7/PgGP/q3CwV3qooAE
	QrtiCXy+73g/aQxX3+5ZyYNHH5ZwIZS54Nv8xNvRmpYxybPZbPXpAvwmPa9+cvyjsfC8dZwx42p
	HZDdACVcAkqBUOrdAph92oitFERUrHy0bXfK211DjmDe9ETqvmyhmIjy+kYulcKHgFrZZG4iEta
	yN7E/M89PMoVNEl26aeC1RQKJWX36Bhdo=
X-Google-Smtp-Source: AGHT+IEu5n7w4ShUoewWTiMMTuBi2YnKPZI6Fd/hOHe6Lw1QNcSxf1qaXc653e2FUF37dnMrlsymYQ==
X-Received: by 2002:a17:906:1393:b0:b4e:d6e3:1670 with SMTP id a640c23a62f3a-b4ed6e31c41mr257619166b.11.1759787694820;
        Mon, 06 Oct 2025 14:54:54 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4f1d1sm1218839566b.71.2025.10.06.14.54.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 14:54:53 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6399706fd3cso2946845a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 14:54:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQMH9zWezU3rV+9nlOXoMzD6whEKg57aqmKw87k68s86u6w9DU2EXYYgO26sBvzHqG9u4RcgU3MfRe3Vk=@vger.kernel.org
X-Received: by 2002:a05:6402:5191:b0:633:7017:fcbc with SMTP id
 4fb4d7f45d1cf-639348f1c5emr14975075a12.15.1759787693294; Mon, 06 Oct 2025
 14:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006135010.2165-1-cel@kernel.org> <CAHk-=wiH4-v3YxzN9_obL8Z_d9+TiFOdXwiDAauHqO-1vymY-w@mail.gmail.com>
 <9636431303ae3a8b24c84b885cfadcb963124232.camel@sipsolutions.net>
In-Reply-To: <9636431303ae3a8b24c84b885cfadcb963124232.camel@sipsolutions.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 14:54:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDNJjvBc3+nAH9jTd4NHwiCizaw+0ZN9VSCpzT5jRTHQ@mail.gmail.com>
X-Gm-Features: AS18NWAGZxnn0FJ50TTFvawTEJndCY266DQLf5nNwVGofZLyRQSE7F8xjpkpYFs
Message-ID: <CAHk-=wgDNJjvBc3+nAH9jTd4NHwiCizaw+0ZN9VSCpzT5jRTHQ@mail.gmail.com>
Subject: Re: [GIT PULL] NFSD changes for v6.18
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Chuck Lever <cel@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 14:20, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> That doesn't mean it's between the host and guest kernels, it's just
> between code built for "userspace" and code built for "kernel", both of
> which go into the UML linux "guest" binary. IOW, it's just for
> communication between hostfs_kern.c and hostfs_user.c, which nobody else
> needs to care about.

I was worried about people having version mismatches between those two parts.

But if that can't happen then that certainly simplifies things.

> However ... it looks like hostfs_kern.c is using ATTR_* in some places,
> and hostfs_user.c is using HOSTFS_ATTR_*, so it looks like right now
> these *do* need to match. Given that, we should just generate them via
> asm-offsets.h, like we do for other constants with the property of being
> needed on both sides but defined in places that cannot be included into
> user-side code, like this:

Sounds good.

> (that passes my usual tests, if you want you can apply it as is, or I
> can resend it as a real patch, or I can also put it into uml-next for
> later...)

None of this is the least critical - the bits I actually reacted to
aren't even used by hostfs so we also don't need to synchronize these
(potential) updates with each other.

So it does look like a good idea to remove the hardcoded "these bits
must match" thing, but clearly this hasn't been causing huge problems
in the many years they've been that way.

IOW - I'll wait for a later pull request from you.

            Linus

