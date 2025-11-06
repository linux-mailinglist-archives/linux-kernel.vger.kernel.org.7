Return-Path: <linux-kernel+bounces-888310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A0CC3A7AA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D26FD4FEB1A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF3D30C601;
	Thu,  6 Nov 2025 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rV5Pn6gn"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8422E7F02
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427244; cv=none; b=lFNW/QXOjTaiuCmqcg78uG4n2hpbYkwQloBA8/rRLTv554hHbiqY0uq0kN5xbYnmHU3i5sFv5C1NSjfvjHExCpsMcGX367qX8q4ty5x1C4UYwLBVL5eeib5XtEqOrTgcdOApaeMAbMHiKlv3D0lCoHj2zOmrRGffVFjZ2xYU6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427244; c=relaxed/simple;
	bh=H0ZdH+nx0rZ/pZHZK3BneUY8rwzBPM85uI4MwicRmNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doPwROdwT2VtkER5Qysqx+QEZvhoD6SA+nXkUpaG0tcbE4bw1a8QaPBnoQoGJEK9XRK5WT8D61lpPpN8JIUxH7RTwI7BhvxWZK2n6PBH66kSWEE7qOgxV8FMd/hJ9Tey9m90e/CS08rCpyoRVIugcFKCCHC/5jMktzEt2qFtPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rV5Pn6gn; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ecf30c734eso6574641cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762427242; x=1763032042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0ZdH+nx0rZ/pZHZK3BneUY8rwzBPM85uI4MwicRmNo=;
        b=rV5Pn6gnT4Q7LcRnxkiij/NfBeYHxoIeJFZvjPdYZUl/9A/r/UheF6pJy3tAPg/Lcq
         33KUW+jTduemo+byS1u9gzcFcE47vluC7J4wpHj9xJN0Jf0rztnsXdUhdN0OPQMorYBv
         dHFB6elLRqCx9DdXigCdSnwlgLlK3O/qYfZW5ajj/OC3YIsUvQ2/Zz8apKIlKcQR7x9L
         uoNc8Kst/W1h4u9GUsXR3LPM61K5fY/U3JrxvbcFEGgTD/9ZHdaYY+LWGpVHLZb/vIem
         VGAyqQe2QDKqZ6zwcnZpz5lRCJIq8TQ10NbpjgRyyZa6oMgloCB6sIKiy6qmUGMmgPa1
         Lo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427242; x=1763032042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0ZdH+nx0rZ/pZHZK3BneUY8rwzBPM85uI4MwicRmNo=;
        b=ZglFYwrjEHGW4zzywtS9cRAoFbztzXIWjA+hb2eio2AcKHVsCJhZcSMw6droAiVd+Y
         3ZKaQAG0PJWYU7XFM/0WDi5Lq2ES9h4hXK5ASeoTPZZL6sXFSCwuVhTIsl6IwzJrrdVC
         0jz4x1iwJmEIYQEP+RmaJOstrbRhUq20tBJ0VrFd2v64svEd6FPFEp5bCxO4fWZDp+rx
         CcMisoIbU0wtjisqr0LT5i+ZTNsiHAAeyIRTH0PQw83IFxTgVDh2oDxEsIl7VZxUeMaj
         mAluAWl7VmEk0Gi6m3yZPYz3lpXyMkjX4D27XI+h9lPYMThWcnEheoGJO1vr9oa+UuFU
         GVXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW36kFRpZXLuMcHc7+aRO892SHqeTR1sBG1nKH/rTNNB4KJAQP0MtdZX3UNXs1e1WDLb7OqZFV2fZ/p2y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPHz1Qak3zCX4txylxHUO55xXkBH73OT+8I83vy/kk6wFVgtU8
	U+MfA/ATQKARZeSROCvYqxGlVcnkkLALzDLCixNuedp8Sl7Nmg82ORVYK8ktdVJMukNjwtuRell
	DRNbSpuMR+qow80S6B5gQ4eBR/esKQ6rYVsx/n1CT
X-Gm-Gg: ASbGncsHpFK1+0dciN9Ew9V7KBfa+Is0UUqvOiuk+YOCvQYPSAPuT+MrtfK2m7jBOXZ
	zbtbVg4zQlpeinB1t560DK+h/th5s1EtakH078llNh31vBUnAOgNugdf+eFde0iHn/0gQb1IC6L
	+Yes6JvHgNrCcp6IvI0t5knkQI6gbvShIGWQWjSrtA16Srmx8OAuNI3sTq78Qt+fKTgt/isRO7D
	HH7qjAR9cXknS1A3qhtF0wZzlufS9o7feMCl8aLJcLX+cOo3cTVUDd8B3cGyrj6XF3sgjo=
X-Google-Smtp-Source: AGHT+IFsyvu6ZTz0rAtb4IsdFmSi8tGXLk/9EUNnH5UQ3mMWlgq52v7rMBO/1u5TYQrjkJOaQBFPj5cYnlhEX0kYgZ4=
X-Received: by 2002:ac8:7d8b:0:b0:4ec:f940:4e65 with SMTP id
 d75a77b69052e-4ed725e7ba3mr63858621cf.51.1762427241397; Thu, 06 Nov 2025
 03:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
 <20251104161327.41004-2-simon.schippers@tu-dortmund.de> <CANn89iL6MjvOc8qEQpeQJPLX0Y3X0HmqNcmgHL4RzfcijPim5w@mail.gmail.com>
 <66d22955-bb20-44cf-8ad3-743ae272fec7@tu-dortmund.de> <CANn89i+oGnt=Gpo1hZh+8uaEoK3mKLQY-gszzHWC+A2enXa7Tw@mail.gmail.com>
 <be77736d-6fde-4f48-b774-f7067a826656@tu-dortmund.de> <CANn89iJVW-_qLbUehhJNJO70PRuw1SZVQX0towgZ4K-JvsPKkw@mail.gmail.com>
 <c01c12a8-c19c-4b9f-94d1-2a106e65a074@tu-dortmund.de> <CANn89iJpXwmvg0MOvLo8+hVAhaMTL_1_62Afk_6dG1ZEL3tORQ@mail.gmail.com>
 <9ebd72d0-5ae9-4844-b0be-5629c52e6df8@tu-dortmund.de> <64a963ed-400e-4bd2-a4e3-6357f3480367@tu-dortmund.de>
 <CANn89iKt+OYAfQoZxkqO+gECRx_oAecCRTVcf1Kumtpc9u+n0w@mail.gmail.com>
In-Reply-To: <CANn89iKt+OYAfQoZxkqO+gECRx_oAecCRTVcf1Kumtpc9u+n0w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Nov 2025 03:07:09 -0800
X-Gm-Features: AWmQ_bm5Kc1656Fqyva8wNAL1lgqqHH7XdmS84y-uVKeorIZqI78IoRwP5JyG48
Message-ID: <CANn89iKpsVStgFLNzx8Nv3C-qRZdY9R7_Rh1mWWxf4MN-oTAYg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] usbnet: Add support for Byte Queue Limits (BQL)
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:40=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> >
> > I compiled it with CONFIG_PROVE_LOCKING and ran iperf3 TCP tests on my
> > USB2 to Gbit Ethernet adapter I had at hand. dmesg shows no lockdep
> > warnings. What else should I test?
>
> That should be fine, please send a V2

BW, no need for a cover letter when sending a single patch.

