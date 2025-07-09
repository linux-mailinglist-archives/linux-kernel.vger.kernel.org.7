Return-Path: <linux-kernel+bounces-724285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 125C7AFF0CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1327B1C83B1A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3743B239561;
	Wed,  9 Jul 2025 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O25iQmHV"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE98A23770D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085338; cv=none; b=XvhCkdTo/nerJahqzR7B5lTRTWIc9lmFOtjOfLzdq8eAgPPcfStMHonXD2QXV9Ig01YIQa02FW7+rhFkAHvko1e4a60hOKJwFxY/5snD8SwPgw7tVaFdEAX9nXn6MAjkCUwMHe5R1I/cDPxziG7e4EnCald0SgxIopPJo/45r3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085338; c=relaxed/simple;
	bh=DHJISF5PClkUJdlEi0cvLH7QxOFYVlfzk8dRf+9bYpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMGhPocnTbHqNTD+/4jxdBi11WjYn8TYhNAjXDuWoj86gxVQ8UKcu21riHOSElry9vPdUO03j9DRieVJoWemzyRgz7CUezk1MecJmPvMFphU9nYw133M3MFb4nhMs5ZVVAQoSAWp543vHcpdt/SLO6SLllFatbo+CS7Am9qhgQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O25iQmHV; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0d7b32322so18174766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752085335; x=1752690135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=USgUKs43X1RXi7eBmcZt6DCdTGCOb+krmsvl5A1pYq0=;
        b=O25iQmHVkfAv1KtnCf7RWAn1wEiemrjIhDniWIDgWqQj1Oyn0abWFoQjODuEtqiwPZ
         GLh6GWv8LpJWwc5c1oXh/gPZrpgv9RxmX4/BjjPWnEbgX+ZIYrDXeCOZSY5EOoynaBcE
         lgMsT4wlcF0Za1vUYq7qn7YMxzoidHLYJb1Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752085335; x=1752690135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USgUKs43X1RXi7eBmcZt6DCdTGCOb+krmsvl5A1pYq0=;
        b=M2r2pVLDvFnhb3FLP/U8wcUXTaRkqIWGtUP67iuXkYi8KGpWx/mHm3FcFn/CZ/HN7w
         bFnw/ObZOqC9xTXwqiP5XSA+UXZhPQQhIman1tijuND0D8u9dhlwEPBiOnvkdspSyqvM
         mZL4s6wYfsiL58esh+w2nqOXR0JCjr4qTANUz57914ipQLRm4QL/1OTYwQeg99gAtruD
         yYs1PJRYlX0wfYlqg7xiOkaUoEW1v6gWOROqOZB2I+h5IOiIKvQkYfO44UImrxV0QV6Q
         pVfqZmhenZDYbwk3IuQ+6L0iPAA0nPBP6q2bbu8gEw7xb4IiIYn8H532LNpaXhtsl/P5
         LrHg==
X-Forwarded-Encrypted: i=1; AJvYcCU8LUcdkYtkT3KvX3/pcuPl6fjA235Rv7Aet7s3Go+UfO/Qz9jJC8LyF050SXtQYIS48LZfQ3uV6J6xtMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynxTQQRQc9sYWb4MnHNdQi4VTUTSd2qlu0CdFCpwu974ev+8m2
	LQLYW+rvmN4a1iqao6fH4g1cc+kTByiDI3oOTPv12Bo+h78yw3UoREt9u4/EX3x2wc4hSCN7kV7
	sYhethKU=
X-Gm-Gg: ASbGncucnMz94YR5D9TNx+/lHP5DrqpKk2j8uvzdr7ST3sgigJQ757O5fURfLastuP2
	peoxBcDMh6lOMassK6QU9HLZJb6B5CdqIntvFXyczltiHQfatpoOGipTjwQlgpPV1uSeTPVlpHS
	7iQ2ra0DcJ5NkDA8biHlQPQLfe/PiEzq596Q8FmhLVe2eel0MFx4y1Sh9jDOXy9ultsNIU2AoMo
	wswjNaIeNwBIgj+SLhFvW/4j+pBuWWDrfVKH4CdK2puEbunmAcr5I6fTfaZpVHj4KFbJNQe9lxZ
	uR2ukaRlqPN+s7f1XWKU2P/tOvHl7VOcZrdvTDBQ92/ho5FpYpFMMGTNtFqKYyphdbtf2mzj/2l
	V9yYfRIJD8f8ALsM3TecB8K9WvAXzQthoj89fc033MkWxRok=
X-Google-Smtp-Source: AGHT+IH8+tJdMHJiYGobqCWw9PtVA9nYtZpdSgxhoo5479n0vOhcNXmhflh8wkIRKp+cmMsgw2CH4g==
X-Received: by 2002:a17:907:724a:b0:ae0:d1f3:f7f4 with SMTP id a640c23a62f3a-ae6cf5c6031mr365809566b.13.1752085334761;
        Wed, 09 Jul 2025 11:22:14 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b031e6sm1132583166b.123.2025.07.09.11.22.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 11:22:14 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so142869a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:22:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFYMYEiaWT7HxHQEBo4KvRNI4Hwcc3l6iNv42m0EBR+xlGYpBzZspqltuNgTGu1L4kQfvnNQfqCssCglE=@vger.kernel.org
X-Received: by 2002:a05:6402:2554:b0:607:206f:a19 with SMTP id
 4fb4d7f45d1cf-611a704da42mr3019019a12.25.1752085333606; Wed, 09 Jul 2025
 11:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709180550.147205-1-longman@redhat.com> <CAHk-=wimw8A1ReDPMyAVPrB3rEzenkk-u21RN123BGmnGBwjiQ@mail.gmail.com>
In-Reply-To: <CAHk-=wimw8A1ReDPMyAVPrB3rEzenkk-u21RN123BGmnGBwjiQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Jul 2025 11:21:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVBKwK83R_7+52qzZb3DpFWGG8L=V5bDG6VS44e3=1-A@mail.gmail.com>
X-Gm-Features: Ac12FXyLTcQ7P0XGQBPOF7RxDx6sFsCFMXmRrzQJhAQpr3v5UDxqSxmKlrZTPdw
Message-ID: <CAHk-=whVBKwK83R_7+52qzZb3DpFWGG8L=V5bDG6VS44e3=1-A@mail.gmail.com>
Subject: Re: [PATCH] locking/mutex: Disable preemption in __mutex_unlock_slowpath()
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 11:19, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I absolutely detest the notion of "let's make locking be tied to
> object lifetimes".

Side note: I wonder if there's any way to detect this kind of race in general.

And I suspect it would involve the exact *opposite* of your patch:
make mutex_unlock() actively cause preemption after it has released
the lock but before it has done the final accesses.

                 Linus

