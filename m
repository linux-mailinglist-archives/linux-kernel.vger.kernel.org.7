Return-Path: <linux-kernel+bounces-861374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D754ABF2913
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 350A934D30B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB54330308;
	Mon, 20 Oct 2025 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeKcGWor"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90202638BF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979537; cv=none; b=cS6pfqoeLQQin3ehXDF5XXDvSjz2VDqP5BsyRgVK70lU2DwHYGOBA1xRaXk/CfGZhp2UaBGxkOb5FDaI8Yb0WXQsyAGmZJqeaL5Zqc9uy/dggQeg+Fa490fXkgjMHGTldeWyjig90gBFRE75EjQE3PFwkkJ+hvOLv7AZsMXf+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979537; c=relaxed/simple;
	bh=4bQ5dGdI37+mKtm3nyfRFem5GeQNndtwmqJv6QZC4X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9PWi9uz+qmx+qbNhecAfStfFHh08FT0GcxjSV+vH3ciZhU+h7ugzkVNwQw0wkngnp7i/6v+i404LWfH+Efd6zA7wcW1lP3NJcAH2N5VubYnQYPc5C1fr+Z1Jgz6K7OzbO2NQUWFE3UwtLnqW4M3E9fM56eT7e/UwspgCKhoe18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeKcGWor; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-87c167c0389so74437756d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760979535; x=1761584335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgsdylpKUJQfQkBSHP7xg/RD79zsocybv4Uh09OP8R0=;
        b=MeKcGWoro02/4Eg8K9LVgB9EI6XZMMdkvBezzHR9H/bq9oKo86d4lpqZvjhBJ4YivJ
         NxtjUsp/enHfGZ84xtDNbbxfwcKknwJn5Io2fXOOnH0rQEegINY/LgyoufTcPT/0xokX
         0GG2Xwx4aHoFNuKl4RjCSkjLMjxLPsafu7+uuLzGA2Mnqq5V1gODvnaZm7eAg4CSn92h
         d1V6kLk1YSbTQ3dGYsWAyGgkfgscH+9/izwj+XbtiwbeCp93/VZj0FOQVlqfghWzBp8/
         Brv5Mq9fdgx7dRk67pWdFRh4Z64J1UTKhYhxNP1DBy7iRKGWRItJQnbawzA5fE6IZw/e
         A3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979535; x=1761584335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgsdylpKUJQfQkBSHP7xg/RD79zsocybv4Uh09OP8R0=;
        b=xJHBboapLhie2wrgNJ4e0z1rWb33Yp1vvBFfm32thIRiTQvjyMHHXeEZE80/oK7GtF
         pVUdG88fqkjoWpMfK7ZhuWllXEQ9qo5Zubmg8lG3zq744vYMB6Hxmr7Z7zu6/hLsY6eG
         0n0aCmFpvOuQjj6DV9Waq5yzvcTiJYm5b0FMNcojyKDF0p0bo2+OCt4Vf1IzwE66sNRP
         fPJ6pSsbE5KPopKg2F4cvWPfzd2sC/UZ+yC33NClal+NPu0yPB48EZKn6vv/PU2lMpOA
         aFpYFMU9U9ZP+eOd0U+CXjrFrKPhfxV97X4xfK6msiWcKE+ViwskJI4oZTe+dEzqU+Kf
         003g==
X-Forwarded-Encrypted: i=1; AJvYcCWgQien7XB6tFy2lmwcn5Vv9jNIy0jFcgN0SN3mRsQiUTr9elZPqg6FCylL7L1IYs1cIDPXi92S0j6F8OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNoYCDNGuH5CF+nip3LBSKGiNsOiijQ6g0RPFJBm63LLmo6EUW
	6VHEUNVyX/gHxTvEBN+Bs903ZoP0WnEdPYOaJ+YtIRDG2lNzLr1l8T8g7TPDqBkeOI/Y81xxphf
	P+HcHQbfVYfzp4wi5d3DerK5vrD5Jw6Y=
X-Gm-Gg: ASbGncvJ30KQOqcjpN98/UlWt4x7sbzKacaxZAP2BkOjiHTxS6v5TvEWKsVYe1jxAza
	Tmr7OnQgN4OjplpJa3EC/xFmYU+i/8Uv5HOFGY1ZmKDyhjtFWDG9HSDJIQrjDKiAIg1BHWjSCYf
	x94/b34FbOFQlphrrfWSl+EebQYU+EeSHuPu3ww4vsEmDm01uWssHS3QxxO35EPJ0zwZ7MObZ2y
	EFac0j22azvqgR4bTRmKblpdgzK8XQt+SicGU8ndNIMaI4u+Z4ddilxl5Po+e8YSToO1toPW2TB
	aszYDIVbpCcN/kclA8ESjdG4Nuv4ENQPcY1n8tDQyJDJNOyS9pz0sevEQNWiDHHX129E+V57k6C
	wgfRV/hkDxxo24vNTe6/Fpamm49OxtsWan26HrjwP4CHAHMnO40j2YodIWdMrMg4NXHRBZpcfmy
	LSE6VtCxBV/lHoBPAFa8Zz
X-Google-Smtp-Source: AGHT+IHbXFlV0wP4FY/uwKW9bu6aO+4kvfoixtYtWRosnhokGbPU8PEqiSlE80WY+IOyu6/479D4KFoQCxyPQIW+q5g=
X-Received: by 2002:a05:6214:1c09:b0:87c:dffa:3291 with SMTP id
 6a1803df08f44-87cdffa3562mr107155826d6.43.1760979534432; Mon, 20 Oct 2025
 09:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1006942.1760950016@warthog.procyon.org.uk> <vmbhu5djhw2fovzwpa6dptuthwocmjc5oh6vsi4aolodstmqix@4jv64tzfe3qp>
 <1158747.1760969306@warthog.procyon.org.uk>
In-Reply-To: <1158747.1760969306@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Mon, 20 Oct 2025 11:58:42 -0500
X-Gm-Features: AS18NWCQzB81UKEefQM5CmQBxxIlIJnyDPWcumyA1Qwmkt85JWSyfbkHNlFn7yQ
Message-ID: <CAH2r5mvOwmdcP_5kjC+ENgtooi06AuPvwBXrMnZrfy7_poAoFQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix TCP_Server_Info::credits to be signed
To: David Howells <dhowells@redhat.com>
Cc: Enzo Matsumiya <ematsumiya@suse.de>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pavel Shilovsky <piastryyy@gmail.com>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	Bharath S M <bharathsm@microsoft.com>, Shyam Prasad <nspmangalore@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 9:08=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Enzo Matsumiya <ematsumiya@suse.de> wrote:
>
> > Both semantically and technically, credits shouldn't go negative.
> > Shouldn't those other fields/functions become unsigned instead?
>
> That's really a question for Steve, but it makes it easier to handle
> underflow, and I'm guessing that the maximum credits isn't likely to exce=
ed
> 2G.
>
> David

Interesting question - I do like the idea of keeping signed if it
makes it easier to check
for underflows but IIRC that hasn't been a problem in a long time (adding P=
avel
and Ronnie in case they remember) but more important than the signed
vs. unsigned
in my opinion is at least keeping the field consistent.

I have seen a few stress related xfstests that often generate
reconnects, so we may want
to run with the tracepoint enabled
(smb3_reconnect_with_invalid_credits) to see if that
is actually happening (the underflow of credits)

I also was thinking that we should doublecheck that lease break acks
will never run out credits
(since that can deadlock servers for more than 30 seconds as they wait
for timeouts), even if
"lease break storms" are rare.   Maybe we should allow e.g. lease
break acks to borrow echo
credits e.g. as minor improvement?

--=20
Thanks,

Steve

