Return-Path: <linux-kernel+bounces-752429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB1B17577
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D09B1897EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8D023E32D;
	Thu, 31 Jul 2025 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MbXYenEA"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B007C21CFF6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753981852; cv=none; b=TEnHi/HKdVLxkBji2lD4jwEdb1LVYFfnss4Paq9WB5zFVcyONzAji5ccHg4+D8LwrJjb025OjQl66XSwUQacv3+KNQGGd6fsqjTO7okpkHerWagqJyGVs2BWLtgqLhi6vEn1UXgZsh9P7TMT0fRYe7I8AREiu6KTWBLv3It2CzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753981852; c=relaxed/simple;
	bh=dyRDhTOVyF16pOrySSSfQhRdw4SXfIfFB4wTi+vHY6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhz/tpIyoJlg8cgGeuIjPe+9GAN1iHE8q/9za4kaxrftV8l8TVZgPIDNPvB3D3OOqSrq8tsKusHUi+LVkscsiyNf5rmCt1cKWGAJskF6ZyKqrH4S7/R79IsC/mL7sN+hVAUKPNoS8Qid2V7h+krwfAGudhhsf8leiQzdCtSaVAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MbXYenEA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae9c2754a00so275197866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753981848; x=1754586648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pnzLH6uf3DEV9O17GgRnugOfi8Wzn+Qhiwp4n865PpQ=;
        b=MbXYenEAnqXNmi/uYXUanB5ZqDASBTpPeOaWfs32M9laQyA4mgQn14QjC8shhO4cWb
         JCP5pmkEB5NTvwubY6O0vtnp4BIzU/bh3/MlWiZWwTnMrIIarLo2Vf/milI200GeXUFj
         Zm8fFxplxh9UnTTserSHp30R3u5udxs66Il+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753981848; x=1754586648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnzLH6uf3DEV9O17GgRnugOfi8Wzn+Qhiwp4n865PpQ=;
        b=fzNv4AtEYGH2jeB1INtUmx3Or5xU2uVrIe3RmGLZRSFoA8GHp+WYtlw366m9neRdxu
         vI75gZX8AT5oero6L91TumXmyf9t/rKh+CZB1D6rXB9UUFGWDC+ihrwB1GyMEOA0BX9n
         acYq+IRLO0wX0ERwPmQygXmpmPz0G+BoBSjmnOpLcTnc57kEtJ7bU9yeB2Y6Hhw4++Wd
         +VbGzG34ErsEBvUBa2cHIxZGgd0Hd3iJGR0q6x70mKk5SFnNyPdtFneT00wYU51b4WZd
         q0Wns2znvxHtD1msexLKjKStWGrLIocSAj5lv6de2XkPKYWjkm3zelusDrI+5fxBThuq
         0i8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9qcxqjXM2A6hF9mp0oiuu9zHFH0vRr5z8vu6ejzYb2p1rjqS+Tn8E71777Clrp4/hREnfZ3RzQq2ha5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXV9yExBzta8FKOTspU6i4OH8qK0M5+A42lJEq/c3T3RQu/H6
	yy/mjN6y2xnb3KSQGkqqTCDPYOxR1VLveLLn9Y2O4UqJRYfTlR4PJYtNbL52UWZYinBqEJxkgFe
	rYIo2JXw=
X-Gm-Gg: ASbGncuIBC48yTSb+6mQaOvxS4PhxB5RGnfhY5m3dhwMCk7Ny1T2/fdl0mduSTp9eLc
	bAwMGVXippSHWQ9YimtXAN9gXLhE4VRBgT3M8fvyfZOTKLKgORFRxuEeJqfa3UEwnAIHoI/hise
	orbTlnGaKudH5YNh0EfZJCWles9WhTpPdYIuHDP3L5JrB/stxwrTIOgarsLTojdNDhjGwQtAjYw
	0ttQMmMatgpoj/KUqNxwjebLC5sTj4lokw+B1UEmjBqz3wdPGQ3P8IOkz6Yaak+1CXKw+Pr7AHo
	5ox15hZndkfHy5Qy9P+WE3+jAi+sDa/MPwtGt9p28e0Rd6rSGK7cDI3rlS6bFZ74O5q9Z6lD2JP
	qgI5kFnmlIKKLjRQJ1DQy296j82q9WLAJFobTCvsWVr+eocDDIum6stGkWHXdNWk0lxI947OG
X-Google-Smtp-Source: AGHT+IEd32hx/CinlFfFQr9390mw9HHeYMbCYxUi6XLDgSpQL/1IIkhE3uQVouMEkOE1CueUxp0oQA==
X-Received: by 2002:a17:906:ee8e:b0:ae6:f163:5d75 with SMTP id a640c23a62f3a-af8fd69b8b6mr844220966b.11.1753981847691;
        Thu, 31 Jul 2025 10:10:47 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c10asm139418066b.116.2025.07.31.10.10.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 10:10:46 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61589705b08so2322307a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:10:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgEWPqNxS8mZL4bRZHSWGM/B0vO3N4dtnUKyr9yCQHgo2WY603F7G17t0uIbg6cV1Odz9PoakwyMBm2mg=@vger.kernel.org
X-Received: by 2002:a05:6402:51d0:b0:615:9242:df7e with SMTP id
 4fb4d7f45d1cf-6159242e195mr6154463a12.18.1753981846212; Thu, 31 Jul 2025
 10:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7787490.DFzTOozpa1@nailgun>
In-Reply-To: <7787490.DFzTOozpa1@nailgun>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 31 Jul 2025 10:10:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNLbhDHSqVke1=b0QV_CNpLhLxnELVK=5arNVsT0eRxA@mail.gmail.com>
X-Gm-Features: Ac12FXzs9mAsXY6GkKaxy_rsJ7KQpBBHN9lOKvPvbNi4FOy2MbcwFyubn9YlRn4
Message-ID: <CAHk-=wgNLbhDHSqVke1=b0QV_CNpLhLxnELVK=5arNVsT0eRxA@mail.gmail.com>
Subject: Re: [GIT PULL] UBI and UBIFS changes for v6.17-rc1
To: Richard Weinberger <richard@sigma-star.at>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 13:10, Richard Weinberger <richard@sigma-star.at> wrote:
>
> This time I'm sending from my business account because Google still hates
> my mail setup at nod.at.

My workflow checks the pgp signing of the tag, so I didn't even notice
until you mentioned it...

              Linus

