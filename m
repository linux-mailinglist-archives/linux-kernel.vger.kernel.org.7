Return-Path: <linux-kernel+bounces-883765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C72FC2E5E8
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1203A9AF3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E642FE58F;
	Mon,  3 Nov 2025 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bGw+++mj"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D022FC86C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211090; cv=none; b=ptMI6whZcDfpuEf22ifsQ8pdVE/Q9+63emEO87Ed6WoJnjzK7VLUxivZZB8EKTYYpV8v4ELGNJiJFoXJ+0lK+KSjHbtaYjKOR5hVcObIrVYH/twjGlpVeM82hIv/5lhS4c41hk0V4FJ1MUW2qcUVSbSc911NFn/U9kJePwpuVZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211090; c=relaxed/simple;
	bh=qFJb3QTz/3jg/L6x2lbG2psgJfjIQh5q1KW1+nPPaBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2QBXwAFfQCDt6nUR3Ttqhr7ijuK5cGdly/j3K4fQW/6RRwyBiAnoYqYuWEAhKAiKkRliXe96mHZ+lK1CcK1DX58hdaje+gbZHjJPNRQMke/rdL8pEuVpCwelRISK7PJkR8VV1buPzcJuqJWgW2/aE3+ijQmRhM68GUbQW0zXzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bGw+++mj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so989171666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 15:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762211087; x=1762815887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH0fDpUKrbZ7Y4RH7y1khfYrGo0F4yDKdY+imctMyp4=;
        b=bGw+++mjPYnWZOYiS6EcFjJzEyuTPJUQqXmW4FOvtqPBOG+AEaph4a7eceAvZWI8sN
         R74TLprWSn9DqgtcHyPzPf4wf8FG9rBlSIZbYpVeKH91J9lQiGihNuLD2YemdmX+AfI0
         vxH9nHyZHQoa5N9Z3rudNTHD7bXvZuu2Kaums=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762211087; x=1762815887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZH0fDpUKrbZ7Y4RH7y1khfYrGo0F4yDKdY+imctMyp4=;
        b=PmGARPSuvnmyBUmzQxAh/+NLm895fXXkVvVjbzsXXJ4/mXPf+r5sW1e6XGwo6wuiWs
         5vc0fLWfXc1US6fYrETGvvRaLBwq+ya8zuXDpSYWhpJ10NNCdqKO7i3/EvY2g4BkezgM
         vgb4UEqTh/XDb4rMa+Xm+RqeVrX9/cWC3HnJQzyEY3uDWJwtqyf2xw0fk/k32uOLW7xh
         qzMoNuFr1h2AGkC+KBwK6HWO+xfOv/vnTmteF6iDIpwYXlZCHJmRlmy00nj9TxnU0G2P
         Ky8Raivnn2f3sYjjt9PmAdykhNgDzaSYRXrz0Glp4a3MAkhigaHQ6Z36V9ZMZrVo98gg
         jNdg==
X-Forwarded-Encrypted: i=1; AJvYcCW8t6k4NKc6WUdTuLRS+R1ecXD6g66boh0uOkk6GAkljOCzI+BXwBj25UYY+S/QzeGExZ26IMmpdJKHaR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7N4JPldpYfHdhi4LMKmNrqxpCEpghEU/VdxM4tqy6q4bk1k3
	4mOH4hMndjVnko6I7ceqMNLWfc85lxdTE9Jil2Rjq8tKdPRr0wncJtMv7NwWQh3zcnOvMPAbzON
	Wx6brADfcMQ==
X-Gm-Gg: ASbGncsA7tdofddAnX8sZ3CYoTScLtKEQEGTaOU6RyUmGP3h1DVHTGYusXfFp7+x3bY
	NJ0raQHEcG/hciJa+epmstKqiDWWvXveJg5wlxPpuX1zk/MLfTTjF9AyJ5VRoYls+n/wE5CQu2o
	vL6DDmK6Jan53x7b/EUctqq7pfzL7DBXx+QZP317xx6+wvLELxDU9EDNYHnhOa2vp2lRaD8Jt7H
	g2qFK0hrgooLRteweSxkreG9pB2muPt8EkWLHCjFMe8LeKtQ9VbAb0i/b/Q8LSEu+7OAbyQP9yo
	AaqmiGGMWYP7BMct5GwXjapZMkZzB9POBqo1YW5ntbYY9d34sLaJMlbtK7F70zZVNAdtJtM31gn
	tnDD/oLsfvpynL14eC18L3u/H4KHgnwEVJuddbEY972W3LxWIPcA/uxJrIHnHUIogrrOq3xD/sW
	7s2AKJyxpZBRdYmdndWzarwBGfI0FWSdCxQLgkl+xOnMjF11rJANE/uZQnY+LY
X-Google-Smtp-Source: AGHT+IHmu7lh6N0huLKCFFEBLHBweAIl8bSl2tz4bEAWr+NSs802R1TAOIMQwtHbfTWXOZf383SjqQ==
X-Received: by 2002:a17:907:3da3:b0:b3d:5088:213d with SMTP id a640c23a62f3a-b70704c3e65mr1483476866b.42.1762211087137;
        Mon, 03 Nov 2025 15:04:47 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a5c881sm552462a12.22.2025.11.03.15.04.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 15:04:46 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b70fb7b531cso232815666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 15:04:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXcoUORZTBQrxpAgs7F0Zihy+50fda++6+jpznUjxlcjrS24vUPrbimQ2jatluTnkJqJSTO6t77ubujf8Y=@vger.kernel.org
X-Received: by 2002:a17:907:1c28:b0:b71:854:4e49 with SMTP id
 a640c23a62f3a-b710854688emr499540366b.56.1762211084280; Mon, 03 Nov 2025
 15:04:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org> <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Nov 2025 08:04:28 +0900
X-Gmail-Original-Message-ID: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
X-Gm-Features: AWmQ_bmQaBgs1Hs2Yx75LVx_L0plRwfdpBhmjm5wyWf-G7aoJOGX7gmwXWEf8f8
Message-ID: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
Subject: Re: [PATCH 14/16] act: use credential guards in acct_write_process()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Nov 2025 at 20:27, Christian Brauner <brauner@kernel.org> wrote:
>
>         /* Perform file operations on behalf of whoever enabled accounting */
> -       cred = override_creds(file->f_cred);
> -
> +       with_creds(file->f_cred);

I'd almost prefer if we *only* did "scoped_with_creds()" and didn't
have this version at all.

Most of the cases want that anyway, and the couple of plain
"with_creds()" cases look like they would only be cleaned up by making
the cred scoping more explicit.

What do you think?

Anyway, I approve of the whole series, obviously, I just suspect we
could narrow down the new interface a bit more.

                Linus

