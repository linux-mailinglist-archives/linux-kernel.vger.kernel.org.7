Return-Path: <linux-kernel+bounces-744732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C2EB1105B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7088AE3DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AA52EBBB0;
	Thu, 24 Jul 2025 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0sk+V9R"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DB02EB5DA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378201; cv=none; b=rlsOZduNa9mHHUbegIbHUm8yQfMbo2TBhJqma3Q3vpPwCloS71/0S99q/GvfLJGf0mW9UssFg+DZcl12vMPc7l4H/FwUqR5yamy2+mdReMGVAXfFt/PwekLPLtXET6qTWWqTJJmkoapY3b8OvRNjiTZ57fzvhEBnI+IvvzjifoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378201; c=relaxed/simple;
	bh=06S9RKRfp+cnfs/TJq14GArVdEgaYHDcxuCml+aYm/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMsR2L2ZoA/MXuH9pwQ6YmCai+qfHZMKi+D/wnkYBLtiOgli8BadckoTnQd3KOdEmvEM916NRYq2LpFJH9cwdlETH3NVXLpZtpbrvnjIn1zHgSk30hKL+At6eNCAdfOAZxrZnP/pwpiMlWUGWTiUQiMupZ2zudxw6S4zc7eWQNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0sk+V9R; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8dbe824ee8so1157732276.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753378199; x=1753982999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06S9RKRfp+cnfs/TJq14GArVdEgaYHDcxuCml+aYm/M=;
        b=Q0sk+V9R3HUzJgbcO2la+R9O+iaCMm3Ro8QFKtw0s8saajM5/RrYm0OAD9NUYyNnEV
         7OYkoYDdN/LN/fP9/n0kDMRTRSvWfjnuCkFL6s4ZPYosBn+vybiaX5iaSY77eVWxXrdu
         bBzYLUNoJBdUgTnMVYUQnA46lB3AGOiaVO5NrHz5kluTPRZbCxkSG03U1Tdtz208w/DC
         fJFjRvcnrgPLkZaOw9Wxrcj7tlYYy7pvNrT/iNyle8BMey46238AAwJEuNSL3fj9E629
         dkrDoxS9/Oj1ABf439s1t+1nHZeNaR7IXVdUpqyawBPtZTqf0AKhao/endqbCTSJ92Jd
         VTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753378199; x=1753982999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06S9RKRfp+cnfs/TJq14GArVdEgaYHDcxuCml+aYm/M=;
        b=FWzeaLfKjcrL3ZJVQFRBcrmBMzP94oHz5oUu309vz6Qk6z7AjSz+kSZFDfMBveWawt
         fXcVuZxVzm2R7WMLGNJbvjrKFOKR/6yz4ScZt9AVMCoOjtc5OJFPjdZO5No0TUiWs9/a
         XKO5xR5n3Urp6YFE2SoHOcy5NgPwozwE6LfEBvC94F0p4Xb6Jbu4mJlotdmHcGGMUMCj
         t89K97VFiV1YostcOxPgsaBQYTnxApXsjKFGFPr3pLlSOMh4QKjTxxPgNxY9w5o7WxDO
         a2ygtHsE8sJ7/Qev18EP2rA3+cI2zsVt6MF2pBwGmD0+r/7knGcvMCpLD0KfIzRx0O2B
         UtTw==
X-Forwarded-Encrypted: i=1; AJvYcCXjGBZMnn6aODu6AVdMIF/e3hg6hofkPC7rBuQukkf9WH9Bp5j0/by3a6pxgYFh4w5mE9HVOjGeBSLao18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwZjfbOaJMsW9OyFCISTRVT/uV8UzVEVGmNmq1MF1wcDGJmQhU
	gLU2IMSUA9c2XMT6/aQz8e2ZSqc2e3dddBhyBzU+p+zIEtZyh9Y16QImXEBnHo35Wfo9gJHTSY4
	nXfhIoia5QNsKutigZZNSIqNysZ7xn1M=
X-Gm-Gg: ASbGncvGOLubdD3p3traZI4B9HhwkGYbS5HF1yS6q5Hki+9fQ0DGZ+Ye3ZU9kzPzHLh
	DB4YldCWebKXixdxnCGF/5Fx9jGf7dWIjId76uK/aGALhXiOSzWasUrWnPbOroE31pGcecowjqw
	i6paWQ6a6t34q5qCkzUqwW26ox/by2Xl2ll1LmXQ02MfRY8DTrMzHvFAFoeZGbEVidQI1Qu0qZv
	NzS3VmR
X-Google-Smtp-Source: AGHT+IGXCqJpGzDcK9DhCmm34b5oIP6A3t7lWhlHgTRkUbgYJM4J/Cv5Rh+zxMzSX3h6njctRUMch60LPfM1KZ4JPoE=
X-Received: by 2002:a05:6902:108f:b0:e8b:bd51:f480 with SMTP id
 3f1490d57ef6-e8dc58ce28fmr9558146276.6.1753378198933; Thu, 24 Jul 2025
 10:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724064051.431879-2-moonhee.lee.ca@gmail.com> <20250724155832.GU2580412@ZenIV>
In-Reply-To: <20250724155832.GU2580412@ZenIV>
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Date: Thu, 24 Jul 2025 10:29:47 -0700
X-Gm-Features: Ac12FXxZSBVFS9UvJkmSwqLpfRfSy-CrpvvZo-9vMPZ5dvXz5x5nsuFmQ_UZOHM
Message-ID: <CAF3JpA6FguWASZM98DWsvEasOAHH2WVkSmcY0D-V6V=-DFjoJQ@mail.gmail.com>
Subject: Re: [syzbot] [fs?] [wireless?] general protection fault in
 simple_recursive_removal (5)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 8:58=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> It might paper over the specific reproducer, but that's not a fix...
> I'm not familiar with that code; will check the details, but in
> this form it is obviously still racy.

Thanks for the feedback, Al.

Agreed, this only papers over the issue. I'm tracing the
sta_info_destroy() path to confirm the race and will follow up with a
proper fix if confirmed.

--=20
moon

