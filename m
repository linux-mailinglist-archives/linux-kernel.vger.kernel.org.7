Return-Path: <linux-kernel+bounces-814830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE26B55914
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CB967B83F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FF2257820;
	Fri, 12 Sep 2025 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H7UOBnbD"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25798B67F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715763; cv=none; b=sMGi7djmZB5Y86rgx37i5mXlv2Yv1F6maPoPnP+R31bP2zQMdIakb+7O4rbknY3I4CG7Ykn75pnBJvwAGA1ylXUGPKC0+hd9M3qzbiiWDKYB9BOjdIUTGtTezzoiGOHgGFsX/jtcITN/LkBhpFAPc2RKn7w8CtdGcrGcMqt4QIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715763; c=relaxed/simple;
	bh=5xbuOCkdufBm7jzWYxJeb8y1j30FN0f4rsdeSQAU1KY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnFH+vKmaeLQZVHmmzC87y4cU0xmyKd02sfI5qGfYalJb/2kbn83Axo1P8tAxRE8D1ez1G8qUjgRJsiMDcXLxxqxJMJpetCDxikVmBy3akOUvBHpohWBEwivNGEPrlWav+YXrPCU7Xw3fAd0VjhVmEgeRFFQAiTTdnW5ErAVWl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H7UOBnbD; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0787fa12e2so352258166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757715759; x=1758320559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l3IX9tXeCZIF8Yd1dUkTz5M/Vlip5AauSTVnQe4su0Q=;
        b=H7UOBnbDBDkIlSVQyggnYMR1UFvkVs93gc/zy0yj/qHuwHTPiQWpJiU1yXyywzcFm2
         6D4KDE65vVD5eFENDx+j6E9Qo0rAgQJGU4WEe/+LZUC2hqP+HuioBV53VJI9CYZDj2cl
         N+YpjInFbXNkr4SIvbWvTlRta/tVh2mCdJQP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757715759; x=1758320559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3IX9tXeCZIF8Yd1dUkTz5M/Vlip5AauSTVnQe4su0Q=;
        b=RzeEKYU2COcqlC83/P7ZB2ePd3e0pMJR+UaUqCA7ek3HUKKE3FRbRZKi5hRCxkhMOg
         85vXqm4xFAAlEWiOWC0qRHiqMDYDjUXJ46XruTyEoF7WUEOBUcU+V2LG/79fhXG3GQaz
         OCTZ0ePFa71LM+TAMaCdDswWAP+n2aFxpvwnSlL8HuKKDuozqU0+NyfT4CUixA3s0MjT
         sPbedcdhWN8Sx0mns0ABevlQNeT8rrG51Ri+yJQRydANagTu7U1WlGIWHRzMSIxPJDxY
         wlckP6u/6ydw6MaQNBilZNAXZU+YUXK7B4h+qnhfFF/ACYzQ7b5tHKZOKtegUwG0pWtJ
         27ig==
X-Gm-Message-State: AOJu0YxAcPdF4P1RL8bjykfslRmN4CYdl4VeKoHR+kFKiMbdgDDKfMUm
	LFPxCctlvoxibz8bJjNoA3mlWJIMbWhqIZZiLPn4ZZaeRn+B2BizoqUSk5WslET/Awi+rEctU8c
	478lM
X-Gm-Gg: ASbGncuy3osHzX6Nov0orjlnUk0Ft6dqP47ZzweYhZBNBB7KKCLs5IL1vqL+RWc3Jxk
	gs4EOecN6vbaowAPgDpyZM0XMyQk4RrnPFoHNlR5ang5Asks97DwlJlE26DlkfSvLxQ+VSgx6rq
	Qp8+nwp5bggWbyMS3D4yeVsoQG34FWk/Ba3pmqp7h64FiT02BFFqbiK6AGi2GoHa4xrPQCHUoL1
	25n0S+Nyas5MTHwIzVEKGK6xKffVGPJNZLO6EHH1GLx86QmP1+LldckQ02b1xoHrzu+9Ss2ZHr4
	xmHvSTzHHDInNBbn25Dszwpc55VEvwkcMO3KznAs+irATsLZh6rImuXDnUJLtD+aVdHv353h8WC
	W4P71RFqjrK3JSW6jmmT8gkFg1X4NF8hnB4mO4BPOC33+Srwjh4HzrvXVZLCbcnCu+etUq3GaLe
	Z1nf//Ogc=
X-Google-Smtp-Source: AGHT+IE+4lBFm4RizFGj7I9am76Y4Dfhp1Pm9UsNYR3ayBNK7wZ+6zGKQTCxH8ehdEXefCqpRsmJqw==
X-Received: by 2002:a17:907:1c0f:b0:afe:8b53:448f with SMTP id a640c23a62f3a-b07c3575011mr427848466b.16.1757715759258;
        Fri, 12 Sep 2025 15:22:39 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3129199sm445301566b.36.2025.09.12.15.22.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 15:22:38 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b0787fa12e2so352255966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:22:37 -0700 (PDT)
X-Received: by 2002:a17:907:db03:b0:b04:9854:981f with SMTP id
 a640c23a62f3a-b07c38404edmr467650466b.43.1757715757580; Fri, 12 Sep 2025
 15:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wh5AyuvEhNY9a57v-vwyr7EkPVRUKMPwj92yF_K0dJHVg@mail.gmail.com>
 <ef8479be-8bac-42c5-bac6-5a5841959b45@kernel.org>
In-Reply-To: <ef8479be-8bac-42c5-bac6-5a5841959b45@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Sep 2025 15:22:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wju1GO-AdGHag2v94mXdmg2uaFez5R8YE2js7ngn+hJyg@mail.gmail.com>
X-Gm-Features: Ac12FXwPT9-JvAKDoIpe7VsOCbVoWoWfZBEQn8Iy5ViAVoefLXjYcd9yuyFNq30
Message-ID: <CAHk-=wju1GO-AdGHag2v94mXdmg2uaFez5R8YE2js7ngn+hJyg@mail.gmail.com>
Subject: Re: Commit Links [was: Linux 6.17-rc5]
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 23:24, Jiri Slaby <jirislaby@kernel.org> wrote:
> OK, can we have Submitted-at: or something for the above which you could
> completely ignore?

No.

We're not adding garbage that I'm "supposed to ignore".

Stop this idiotic thread. Stop adding crap automatically.

I have made it very clear that you can add "Link" to your submissions
as long as IT IS NOT SOME AUTOMATIC MEANINGLESS GARBAGE.

I have also pointed out that you can find the original submission in
various much better ways than the meaningless link think you argue
for.

So stop arguing for pointless noise.

                 Linus

