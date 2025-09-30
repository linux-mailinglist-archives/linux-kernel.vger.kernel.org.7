Return-Path: <linux-kernel+bounces-837882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C402BADF84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D0532269B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514942FF16B;
	Tue, 30 Sep 2025 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KODOBNdk"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B402F8BF3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759247309; cv=none; b=GNQkPh9r2gD9IOAoIZwxfIZuxA5bupixvoPuj2D/FYxZzzkFzE0lOT7Rk+fNXU1YbBlu2HGbxxIC8iMph0pplIgGlb57RV8VX7MIqLdOBu90p+JDwPRJp0Z8v2MvQaXB3MRkZsdaNpa35tJuGg6UN8gwZ9uHhMR4KPzoty7g5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759247309; c=relaxed/simple;
	bh=5dk+SBRw24GnWlhj/fQ5DeJlOcYn8lBKeo22Opld+4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+9sw4DZRe0L8psLaRDADEEFirptx2+x+JEp/ZxW1M+a7imo9q9VFRP7AnablQWw9FOy7PfLjzJpHbUFobaAsf3u0qJFV6/uzO9AY3C3MinbLhY7EgckQtIr2UcNl2MIgFtTkHCAZkuN+dctYroMP1eKqVIqD4WebfwMdg8Knu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KODOBNdk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62fc14af3fbso8999545a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759247305; x=1759852105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BBG0QiSMVhr1SLCtRL7FqkE9Hmi4p6uP4U2GxU0hK9c=;
        b=KODOBNdk9HdXXBKdIZyfRerUQkIBkdQR5Jqg8VXnmyy2YbIBZ1IF75z2lqMtILfC8I
         RVFkcjBfwqn4ggUCkq4TmAxg0MxxJS44XGlDSo8A9f3Gg8lbWP9tceySUIdVxllN/M7P
         1Rs1XgvyRbtCvPMXjZyBi5ZnbvpaqaaMZaeZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759247305; x=1759852105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBG0QiSMVhr1SLCtRL7FqkE9Hmi4p6uP4U2GxU0hK9c=;
        b=gvBLct46/H4Gje/p9jyBvq3/3uh/LuybVmvwsd9DqSDu9rm9Z/PtUDOgpLQvp/Z0kV
         7GoaJjaLxy9B2dJOS+JiU9hyl8w9SjnEOvZsIcBYO0DJO5e+nhX1ZwCKSSw8shyu/y0x
         iWOljfjEmYTsm3J9ufxY97ovqWNrL4KvY16JPyBc2Z4AnJa/tHa8M4cnkOkJcSsnI0+X
         qpOVkdaM7/psUTclueiaGpZOLRCnPYkeJg4rEvBD8IlPZJVVaEqRi0DBMYporleyTwzz
         I+WajXKjV7yHdpWXcnM9wsDbX7cAEVKWG63sq4w5wCWK3Ab1EikUBroTc/o+LkgZqtt+
         mxHg==
X-Forwarded-Encrypted: i=1; AJvYcCXG4/qxcIV6h/F8z8aHp7kwzr3QFPE+GetEF6cXITUubMGmFObTJkx079IZUFtV+UxVViEep+VFlzxcseM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJLgeSWosjFny9xShfmWCsWXV6RXZwVNaPUI4LjqCjg8NTsg4
	2JkGo1kYlgHJmEEFywuIDZSU6zfg4KlXQo2Z6ml+T7dLmU9UkPLZhVKe6VSuXEa/pQyI6b0obly
	TIVC/Z4s4JQ==
X-Gm-Gg: ASbGncsOO2XtTik27CEy3UR0utOcwuqRvL4Ok/anUH5lISvAVU7RC93gCYc8DU6CmMf
	8DruS9QIkeLeWg2X8dPWs0Uwelk4I7sDbEc8Q4aasyrux8aiSNWJZlVsZImMuqJQXRXJgjaBIqy
	0TEHt4CLfktocg0OdjEhAJkjLvvkvsK8HL9UI9IJFrBwutjJLRcg26RFgj5TQYkXohGBSBeWAH/
	mMJVK8XQ+YL7jTEwgbEMnoKIxdfPd78QxsRKqlihdiNebtLbvtdei38cCK6lrm1A/5XT7h8mdcR
	CggxUQDiE2gNFqEgzFpZE7+WRJDGm+3rTvtdLeR5wscxk6CSI3EjxK0FckqQw5umjrQ0waw9z1f
	yS3MAPbpwBOT3BHx1WtuYxJxpKfHxj7wpPwG37Ex2HrEpzBJx7yp4hl7x3lFT4+vuDED+AOQi+/
	SHN/rKEoKnJLaCSSA2wT1j
X-Google-Smtp-Source: AGHT+IHSm8OXarjQhWz/U4xI/8nY/e0deej1scsKlj/3wWnaf6l3X2tChMzUPM8ep8i+YthWbOT2sw==
X-Received: by 2002:a05:6402:3596:b0:62f:4be5:2286 with SMTP id 4fb4d7f45d1cf-63678ba6920mr466173a12.8.1759247305595;
        Tue, 30 Sep 2025 08:48:25 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3629886sm10005716a12.2.2025.09.30.08.48.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 08:48:24 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-634bc2d6137so8683311a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:48:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXXSlhoBCwqDK1Vo97CWv4HmBbIBX1OBK5KwwhoNxR/X8sGMF9bq7H5DBwMXZcImDI1UwEWLEIHbAvFKSg=@vger.kernel.org
X-Received: by 2002:a17:907:da1:b0:b2d:9286:506d with SMTP id
 a640c23a62f3a-b46e612bed0mr11449766b.38.1759247304449; Tue, 30 Sep 2025
 08:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6edbd0e6dc79902981bf9a34e8d41128@paul-moore.com>
In-Reply-To: <6edbd0e6dc79902981bf9a34e8d41128@paul-moore.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Sep 2025 08:48:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfeAjTNomdTU3gx308O+k5+3STqwBMSqrM7=D8CyEydQ@mail.gmail.com>
X-Gm-Features: AS18NWDnegEfxl0-IfjBztjUvXWxvekoliLaNtqKY6s9U9XtFR6zj4hxzgx-h1A
Message-ID: <CAHk-=wgfeAjTNomdTU3gx308O+k5+3STqwBMSqrM7=D8CyEydQ@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250926
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 20:07, Paul Moore <paul@paul-moore.com> wrote:
>
> - Remove our use of get_zeroed_page() in sel_read_bool()
>
>   Update sel_read_bool() to use a four byte stack buffer instead of a
>   memory page fetched via get_zeroed_page(), and fix a memory in the
>   process.
>
>   Needless to say we should have done this a long time ago, but it was
>   in a very old chunk of code that "just worked" and I don't think
>   anyone had taken a real look at it in many years.

Lol.

... and when I looked at this, I went "scnprintf for a 4-byte buffer?"

It uses

        len = scnprintf(buffer, sizeof(buffer), "%d %d", ..

and I went "printing two numbers and just four bytes" before I noticed
that they are just booleans and so 'len' always is just 3.

It literally could have done

        char buffer[] = { '0' + !a, ' ', '0' + !!b, 0 };

instead, and I guess a compiler could do that transformation in a perfect world.

But this isn't exactly performance-crticial, so nobody cares.

                Linus

