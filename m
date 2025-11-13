Return-Path: <linux-kernel+bounces-899985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6E1C5966B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFF2C4FD084
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A303587C7;
	Thu, 13 Nov 2025 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRGd8D1d"
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBC62FD1A4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056034; cv=none; b=Yw01keGjCGybb7gj/vxwKHNC25LqyPCZU9TEqx7ggdf7Y67zN8X+JsHGE+cZrR8x9mwm6bTYmpFW8lk2yO9hDGSuGPb4P7zrpF64ptf3a+0Zfzcu5nL8Zo2khpL4c0dN2/KR+3EQdgQJ3ukGHIaixfgbMNCpgb1qMPJKZ4At/gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056034; c=relaxed/simple;
	bh=JYaVx6vTjzhqcXYaKW2hxzSgFo7l8Lr94ey9SKNy8jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUx7rAIOcXlACYcFchiwW/yeTM1DoLS2zioOFaZj6aq3c32w7i+feijlzaYDrE1rdSZkT9pX8kDROnAjweKEdBfvQHq7nDHqro8dDmC9sr/ZiHGoYegOXWh8vmESweQlsKRlcMptZ1dj6J6wqAMeYUPANLYLh7SdUyQ/3kDCZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRGd8D1d; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-37a48fc491aso10295431fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763056030; x=1763660830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYaVx6vTjzhqcXYaKW2hxzSgFo7l8Lr94ey9SKNy8jU=;
        b=LRGd8D1deWmppUdPpJrCsZsitqW2Cp6zpU1SGfrYKhAx6H05hQZlilfvqaLSLjzd41
         wNVjAA+iRZ46yAKFY4FgP1rzVESHTISnxlHwX5qzplORRIJaGOzBiFOMfJT5sFnyyXNF
         vjxKTtC3Qq64/kFuHnULKohilnkDhw99l+k0NhrfkfTYsz2rS4FLv9HK6BTvzTackTZs
         e4yEciic9F4FQHpNEKj4lljaNbgJ/jUrPVU/UsS1pCWLa7B2sI7qY1umtBAqOg5HXPje
         CdnQ1BkPRNCiKcvWGUWEDIv+FEP4Y39j2wSUk5UOB+Ss1EEu8pdurShGDj6fGXE57Jl/
         TJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763056030; x=1763660830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYaVx6vTjzhqcXYaKW2hxzSgFo7l8Lr94ey9SKNy8jU=;
        b=eONhf9AdQLl1G6bZUhTdD3AN8PLEEpVl7WjfrZqqrUXfilpxulKn0Rv+wtpRW6Pr4G
         sGVuqqF31rwnhhvCSi3mk1x/TaO9h6+5WRN+LOm7cBZ5tBaMgQ8pyc+ICj4TC/scIzfp
         mOlPEe5eRcz5CeMyhZ8N5bScHhoFeHLl7oWmVeKJeZ+ilqDoteY/7bOs+L7XtT0aEZt8
         cFNLNqKeu4fzjT32Yw5vehsOO03u0ADjgteN651rzCLbFOQWuuH5xjmdLLczWjSyI49W
         9IjrVzYW8kGuACJewjVarkw1pXHZv1zaP1b/F4LamCdTRqJMWkKSSOxeFQW68w5rxKk/
         V+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSBu8CCOrjm1ceCSw495WNfUf41uyHKqfNxHkPcirSQFaBWO1cUY7glFF4WbcOjpFFmjt3iVz/F4JmcBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNxFZHkvIJYC0/5+x6eWrY0HgLqB01AIQbfjvWUrvVuuJZj2B2
	Oy43bYMhFbgOLNp70OWlDNG8625OUI2psr9oXyCSWXNO2zB7wKF3eQBSEUZ9OVi/Uy9Ncw8yxI0
	azEZJnrKJHDzqz8kcbCJ1sw+vQDyVg6g=
X-Gm-Gg: ASbGncsgoO+VBiLbO9uAVcTxI6DZK6GhbDiNDWsfaWyfhhiTxhO32sV7NDn9eZr6WVi
	4IROzhAJmZeIAvwRDFqKCGK0enLxdGJE9W/+XfisxUOkSzhbIH4lMslOtj4cy2bpMSpOdpRDr/o
	yVPAh/qr28trg2Oo7QMojARpJwxoUh8rkJdxPRws4tH/EQQqsPFTQYEnU1bnO3WNpQ2SKvtMAfP
	ZQqNN8+nc5fsOvsgHlf0Fce9+GlIQf8FLe4kIzc/fd82emay/bk+ama5HOBUUJsq0My/5Pz5PNx
	sEUA
X-Google-Smtp-Source: AGHT+IFgB0kjuMORkTltHirHFcCnBJRgvsiK/Z/+CjneNP+gh7LvQ/Gf8vYZ5usaLeqdqcUs2vx3AZBYNtcINT+3isA=
X-Received: by 2002:a05:651c:25c3:10b0:37b:90fb:9caf with SMTP id
 38308e7fff4ca-37b90fb9f43mr17097651fa.41.1763056030026; Thu, 13 Nov 2025
 09:47:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB7XQsFfTn3gL6TksbTNnC3E7SRPt+odtkVUJa24b=LmP3615Q@mail.gmail.com>
In-Reply-To: <CAB7XQsFfTn3gL6TksbTNnC3E7SRPt+odtkVUJa24b=LmP3615Q@mail.gmail.com>
From: c Z <rollkingzzc@gmail.com>
Date: Fri, 14 Nov 2025 01:46:57 +0800
X-Gm-Features: AWmQ_blavjoBc_Q4UMNs19jvBo28Xq4bnE-KXgrDVxv_yz96--bN119-JfsCxpw
Message-ID: <CAB7XQsGB5nkTnCbbzmEhZ2f7P2mYixiL286f_XT4mEBQ8qKTUQ@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: SCO: make locking more systematic and fix
 missing locks
To: bluez.test.bot@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi
maintainers,

I=E2=80=99m the original reporter of the SCO UAF issue=EF=BC=8C
but I=E2=80=99m writing from a different email address now because my previ=
ous
mailbox is having some issues.

Could you please let me know
whether this patch (or series) is currently considered to fully fix
the reported UAF, or if further changes are expected?

Best regards,
Cen Zhang

