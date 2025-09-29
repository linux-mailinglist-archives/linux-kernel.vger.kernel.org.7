Return-Path: <linux-kernel+bounces-836815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC109BAA9EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 23:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE0C1C369D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B2C2561AA;
	Mon, 29 Sep 2025 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNzW64kw"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29989246789
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759180223; cv=none; b=Thi9269XVGYnJZyqcylupwdFsan5/8IuhC61zJo/+BK/zEB+Bo5reC4IcEeqyccSWzDk9w6pt3xgBo+vWJ3llJN0LtwTsa9iHRWYa2VDJfp/pF+JjNdW80qF4TzIScP2RZ//fu5kQ7kHWPT23i1qeAW+S1ijbB7zmkFCLMCFd98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759180223; c=relaxed/simple;
	bh=PnNLfDHqst5vd6hrb/TK0HQlW3cZh7E8xmcGWIkSs4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X35zcF3IOOPXzhiXm+64NaJJvwW1iuJXqQyueim7BV097lxRZ03d3tweBqBxLpFl1CKlRNteLrjla57gvaZhf+x3ZTGbpA5eyJu+ykVdP91oW2Utr3iaf2GPVRNRIvYSC/8ex8UMJilHxebxEFBUK3NK5GK/b3x3E4AFYWy4Ma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNzW64kw; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso7083788a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759180220; x=1759785020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnNLfDHqst5vd6hrb/TK0HQlW3cZh7E8xmcGWIkSs4U=;
        b=bNzW64kwbZdLoiCXBuNIKK+v5tbJpTqExvDDCFPrkP7sMK90AF9hZtMGVWEjmRuo7h
         2hbXiBxMxNHuHZUij7i0cI+b3Oh2j4PxM5SZiy9F3a8NgmrtaF2yXWM5qQ8yb8qmdpsw
         kYs03kwZUlDwfDgaQPBHJULnvFW/drSJ/uhuhaBaTKannWQn50ehWCj+GMAgR828qYFh
         X4N6y1woELjh5uFcL8tZBDHuWwQeqPNH9c64YXV/HtYlLLQv+VSj+hJHlpivIOTMzCqc
         xJQzcjFr54S7wqsY4YH+XeUawl905JKvvjnuUdjMsuFjOcUqyqxeIBR3yLMH8Dtv3cb3
         kAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759180220; x=1759785020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnNLfDHqst5vd6hrb/TK0HQlW3cZh7E8xmcGWIkSs4U=;
        b=xRDsMwWp5agcM68qYlktcMj9+KAMyLB4DmmnW4C897+dHaASLa1v60vCe77wU/mCk9
         Rqd8tKrtk1cOOyWaKq479//HI9xB2yB/yr2yY4c8Ae2kRU8zKfv2jjCqfrJp7seRr0mN
         XoHBFLG/ir9eNLv1v+r0A+Cs6mxXHtv9cPNSHkpser5zA8dW+r34Ch3ptBVWYTWFPOyq
         DUNalCIm9UeYGcXhbsS9NqLut0V1bbY47025Po6o/QGjArI3j4l5DdoLju7o1viK8FyU
         GHvEOvwySm01a4DtuMnuAuJkbFYVreb1jmvOduDbmE+T7jqMHkPqfWO45eRu+AeQ0rdr
         tiTw==
X-Forwarded-Encrypted: i=1; AJvYcCV+4/oASiK0JMODsSuVIESFq+DWBfET2NOuNS7UPeM+/auNdJwqou8x2UWbz8vbz8ROa1Cc0zNZBWHmnPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6WvLGw4vBhlkoyFt1g3cRzax73oxyshVech3EIzavwUpHQ15S
	dBoCxOHu0g08cH3/Wc6kVIs5JR5oqkJlviELl8ye8l+yS4Wf4gmzq2OEL5I7WMnRZV3+HdeQHVO
	86kug1poZKJhDvzQv19KfzUgHU0lmh+s=
X-Gm-Gg: ASbGnct+0/ihguj6lr53Dxlo1bdWvJvvd/jhwx3KsECX1zP0J+uNhR25tf+c0F9i7sn
	8O/tHN2t+vYKmDqQVU00B2AV/8DX/c7ostd+6SAjijoHGjax4PFalIEPVGxc5SwT4Vz0jWAhaY6
	Do7WsaQ03Crwy6oRynPq+zUL4OvtqnP4eO8dr+ObekcFvE15eECCE9hd9bBCvoSe03kJ6GjTfMj
	EaO3wetwa5iHfGcxWcXSFvbGsl9otZeZFxNXP+cUquGKCd7OP23
X-Google-Smtp-Source: AGHT+IH6lV5eV1Kt4fx4PJQ/xnpUMkEAkksSmL0ApQf1NYE5kHd4rYc4X1ZnoqKFvlP4C5fI0NBai3/kdLcOSzqbyko=
X-Received: by 2002:a17:907:7289:b0:b43:5c22:7e62 with SMTP id
 a640c23a62f3a-b435c227f87mr12156466b.50.1759180220317; Mon, 29 Sep 2025
 14:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929160230.36941-2-sidharthseela@gmail.com> <willemdebruijn.kernel.321e70874e73c@gmail.com>
In-Reply-To: <willemdebruijn.kernel.321e70874e73c@gmail.com>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Tue, 30 Sep 2025 02:40:08 +0530
X-Gm-Features: AS18NWCEmn2M-D5zHU0jlR919m1nzZwmzKwrlDEi5S-4Vw12GrNcqqXAq1DzRds
Message-ID: <CAJE-K+B0xssX5TCwxyUwGu=vGMR1u-7r-3wDiMvs4GnqCkYUqA@mail.gmail.com>
Subject: Re: [PATCH v2] net: Fix uninit character pointer and return values
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: antonio@openvpn.net, sd@queasysnail.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	kernelxing@tencent.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 11:28=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Reminder: use the net prefix: [PATCH net v2]
Oh I thought you meant me to change the subsytem in the subject.
Changing.

> My previous response accidentally left a state comment. The main
> feedback still held:
> This default case calls error() and exits the program, so this cannot
> happen.
Alright, I thought error() is like perror(). After checking man pages, the
status being non-zero leads to exit(). So yes, it makes sense now, the
switch case, either loads up a value in the 'reason' or exits().

> End the commit with the Signed-off-by block. Either move changelog
> above that, or below three (not two) dashes.
Alright, Thank you for taking the time to reply. Sending w/ changes.

--=20
Thanks,
Sidharth Seela
www.realtimedesign.org

