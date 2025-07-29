Return-Path: <linux-kernel+bounces-749113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FABB14A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D7C172B97
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBEC2853E3;
	Tue, 29 Jul 2025 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hK6XMZsH"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9E2AF1C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778409; cv=none; b=kRNJfzlfBQlwRBv5zJRu7TK5MncG1r82Wj7vQmsQ9gMDHgjxIU8dKgRy6Qc4ulhw9lvExuZjE1JY5o15nf2/O5kXQGpuCamNkLNEYDb2D9aOOJriWMnKXG33IHeS9WyG3d3wy9L/1jJ4RrQNAnaAkMJsAM6xzj3llYfpjcizXtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778409; c=relaxed/simple;
	bh=uoz7ZkMcJQihlXVR0BYuvVm5pG5ejigHZYyAWdFYZd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTs9ghEQE2gwlHWoqQYNx37LJzv7Mn+2T6HyLSrXyMUywjE+v/3kQeras7TmLnJgwC3qLextLaSdcZdQH/Go1kZMdAg0YdrqbVyW/VyT7cQfRHzW8S6ys15v3EerDQCtQvSvNuwm5xmpHo70HoInewYSEYov55Jq8sWHZDzzAQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hK6XMZsH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6157c81ff9eso53931a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753778405; x=1754383205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VEdUxaOYlkg5cSBRz/WIlFpn0QDWtHgN/FibMeZhMLM=;
        b=hK6XMZsHr2J3tFvfIRhB2ah5ZBwlvH1HDmYNT8X7LaR98clPJhIJs20yUAQmASh1ru
         qQPUspa0rPVpMmCVUkYnvPywredaFD7gTSa39fQohxGdfjto3C89tfnS6PaZq9a7gPB1
         IsRh+GaVT+nuRkekKm+qEv8NID3CTJMIbQFc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753778405; x=1754383205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEdUxaOYlkg5cSBRz/WIlFpn0QDWtHgN/FibMeZhMLM=;
        b=bVV0uO3h8XzE/8MDhinX8B1xolFp6zhrXnl0Hq3CvkDkfHYtzkIZlMXufos+A0MH7Y
         8MANDPV96zUUzCmhfWu9JCZoZJ/pyhVbd4aDAGj9Db+OoSjyAndyVdbDcNLkOUiUaZdH
         2+982yxdAC68InauO/DXWUoLeR3pRzQwSG6DTVuc7DgBKm9sggWsHgWeDawDRD2CwT2f
         Iz6jUBbTKiIBQiZ5ZDsBEHQOHnLn0MhwoTz5xSJuKbhMkxFxmu+HSbka/iCXC51LjDSi
         CGKPk587me6X45jBdVLSZC01czEbq3WdYK7ZM3Imm767+i+CKNOOGFmdHwynMiCgOljp
         Mezg==
X-Forwarded-Encrypted: i=1; AJvYcCVIbX1ojdCMZmNrFqP6sET8NUArJYZ5wqxrExSvnTbtOj3mrOYHTY4VOsmLd/UisFeEzZntj3z1FBo+rgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZzt00jTy4PGd21cOfa7b9epF1b3/zrgzqGkb/WDisTDqCJTiv
	+dsvLhqN0wWIMfL+41cv++oWTGAevdknf5YXUjTiFYy0TSphrxF0mgxGOu5vGbcGtsy1NNBYMw1
	cfxrDEZ0=
X-Gm-Gg: ASbGncusYg91fNC2Wg/hMxkP0XcOGxqSSZODh4mUVAGPHXcbUY07136WSM+TUJfziZB
	8oL1b2J1S1GiZHPoIYEDVggxXWDyl1bImzV5Hf0oexGK7jr5/xwkiCtL8LUGFSh4GVd1u9p9MI8
	h+eMQ7DHwNVs+YhJZBL8sJ/8XdgLxA4Bxq1UBrKt9FQQeyrO4Yrd+IOyVbKUO6iBthcsM3x7yac
	T+031q7GEfGvxluXWrwacSJygjlabWUVFyHAdzbJc3LiVPyIfab4iv39YwvIoGR8FNyBYe4lH/n
	/MI6XJtO9JednIa9W3GdvpMcZj8ExZxXXtReMYqCm39h43LM9FCG0RHDEQdaltf3INwVcQtQfw/
	hOy4a+NSWWC3j7XSgV5aUvjIOgNA0D7w3IvjrevWOoOEUFFXOxrNdFZXNQzLqiKufaP7HbEtCbk
	V5C9OJCRM=
X-Google-Smtp-Source: AGHT+IE2xaAfg9Aly4umeJ5Rk0eSQK3jDOK3NmYz5B0yc1VOyHmUu52WErq7CT14+AR44fHRqTlJfw==
X-Received: by 2002:a05:6402:254f:b0:608:8204:c600 with SMTP id 4fb4d7f45d1cf-614f1bdda7fmr15234609a12.3.1753778404707;
        Tue, 29 Jul 2025 01:40:04 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61544a81df7sm2083465a12.59.2025.07.29.01.40.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 01:40:03 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so9750384a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:40:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpkHLToL/aP7HShk7gflEfPBFgQKxUvKfzkz9EDYeT9x45LGgKMm+2Ebs3YK0aPCj71O1DKPPSlSd984o=@vger.kernel.org
X-Received: by 2002:a05:6402:254f:b0:608:8204:c600 with SMTP id
 4fb4d7f45d1cf-614f1bdda7fmr15234556a12.3.1753778403272; Tue, 29 Jul 2025
 01:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-integrity-d16cb92bb424@brauner>
 <0f40571c-11a2-50f0-1eba-78ab9d52e455@google.com> <CAHk-=wg2-ShOw7JO2XJ6_SKg5Q0AWYBtxkVzq6oPnodhF9w4=A@mail.gmail.com>
 <aIh9CSzK6Dl1mAfb@infradead.org>
In-Reply-To: <aIh9CSzK6Dl1mAfb@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 29 Jul 2025 01:39:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2KaNHTs-gUa227ssG-pE8NMsaz3bg=asx--ntVJaqJg@mail.gmail.com>
X-Gm-Features: Ac12FXxiou34yJ26O5gObjzUmNr77eJrMpDAem_rcuw0KJfYqhOYZO_2ZZE5Eak
Message-ID: <CAHk-=wh2KaNHTs-gUa227ssG-pE8NMsaz3bg=asx--ntVJaqJg@mail.gmail.com>
Subject: Re: [GIT PULL 11/14 for v6.17] vfs integrity
To: Christoph Hellwig <hch@infradead.org>
Cc: Hugh Dickins <hughd@google.com>, Christian Brauner <brauner@kernel.org>, 
	Klara Modin <klarasmodin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Anuj Gupta <anuj20.g@samsung.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 00:49, Christoph Hellwig <hch@infradead.org> wrote:
>
> I don't think overrides are intentional here.  The problem is that
> Christian asked for the flexible size growing decoding here, which
> makes it impossible to use the simple and proven ioctl dispatch by
> just using another case statement in the switch.

Right. Which is why I put it in the default: branch.

IOW, just handle the important real and normal cases first - the ones
that *can* be handled with simple switch statements.

So putting it at the *top*, and then saying "if it returns this
special error code that isn't standardized we do the normal ones" is
wrong.

It's wrong because we literally have over half a century of confusion
about error codes in this area, predating Linux.

And it's also wrong because that new ioctl simply shouldn't be
prioritized over existing ones.

So I'm just saying "don't do that then".

               Linus

