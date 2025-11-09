Return-Path: <linux-kernel+bounces-891861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2809C43ABC
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 10:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 240FB347379
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 09:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0BB2D3EF5;
	Sun,  9 Nov 2025 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khN+CnoG"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812FD2D372A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762680636; cv=none; b=qhMMr1KAicpPAPRxo0srZJNThuSo/OuOTsKueR/aWGRNPjFgwfWxnfR1jUJ80/30WWpklsgWJfFfICvR4nwiKCxCAo/z9aeJQbTfEKiIitRmslUwIDEdLG0RZBA75DrbMnd64oBKbGluVdX7gyufUFg8hmVUZCAj8AhW7KT9WY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762680636; c=relaxed/simple;
	bh=pvWRPE72f40c7vbjMbihtTq6zbZEeEjjJRM9awt+iQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNa+dTyDW4c9j3pbYT6Oq+fO/ucMu5/0u+AfgfRbxDWGd+2xa8FiMXfB/kBZzQTlTjBT7qSll43wpuza3XEfk9Ee9jGYgg2faEv81zH2eDIWSAAR0LIJBCE54e5QXDRRf7hhYWSMlv2yEPb4hfJ8xyGiqySxir5ATqPfhwAsWRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khN+CnoG; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-786943affbaso15101757b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 01:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762680632; x=1763285432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvWRPE72f40c7vbjMbihtTq6zbZEeEjjJRM9awt+iQ4=;
        b=khN+CnoGm3vz/K3mwxzrzDgWwJB6MrWmi76SW3PVSbymhaS+EvNLV5WfZtyrwnw0Ve
         N3gRikJ2+15/a9W1HNnTMnU25s01G2ikAV/LKjTY4fiQ+YZ97Pr8wRUxCHH+uVVMfnpj
         4MzdtaLOzmWSCf6DiZyVVd0ZDmR13oyICzLnJFh8YCHq8CU/LKHcN9CFKyVVDmRlp681
         CPAeeB4tZVUdHodBf05EmW9xnFwkyJgCY2NvT1iJ6WYm4bZjOqC1AiyEMji42CxeMkci
         96Bf9p1EUveLGHrPs+ag9cCEE0A3ZPSjEFnEKtGPs14CztFWv5OwNclNBkL9OayWN8bC
         SGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762680632; x=1763285432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pvWRPE72f40c7vbjMbihtTq6zbZEeEjjJRM9awt+iQ4=;
        b=aeju94hHOEaUUoYRrETOdoJuBSHiRtTxeNdiEF7gRLixtp8yR4/Z9U3vRXrIdC+GyQ
         jyiIONvdulPbte4Z3M6n6HdyYNuZQcjSs8eXA7pNYZ5T1pjT0SlRMliU8C+2qsaO2vwb
         /jU/MrZceI2yQNJSKHNRxIWguTH8GaLCr1l5d9zVzc9S00Y1nIJns1suZh1F+00qTwtu
         xUcRgBfrTum+6RAkZDbuL6UepwIyfYqZMY4dB0EjwWxovfxBKiDTb1Ydg5wrq0bB6W/v
         rPLT57+p42DGRVuET45AOxiJik2mOXtNT2mcByMMvyNshUoaVyz0HPNlxVGYArJ7zN42
         ZWVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEzr/pJy5xV03qdolyvgAHDqrswD1/5Z9ksMk1BX76NsU9QVThZvKyxiWw+8TaN2mPa2ck6WRioKu15YE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkpebv1/Ef6X7ZrdLQJhHiqrzllbNYFsgpHGOFovhLmddTyVXS
	WZlgpzqKxDzwvImJgkoUAuimf/icQhGqivsNk3s+P2ErYLhu07RY61/ubD9nzFNgnjqHmk9kBHE
	KHl0kp7iUzsh2tbmM1NOsTlq3mo5gwWun0TGZNTTz
X-Gm-Gg: ASbGncujByb2LdzyWC7sToQFLYrxzP6XxvS0OT2bPfkve8Jv+eY76pBT7MbcsnZyilu
	QACs7TNc8XdfajXSaHJKuthjqBIhrBTI4GcR3hDHMLBFYRgfqhH5fLE1fH8hyvwy1lf7YdQGFrl
	RTwxxy/Oz4FaTQD5w3oxeENR7NZEt5ZfJ5Wm/puQhOx4noQw7VZT/ViSdgqFSGaqA+zVMwBzyk7
	z+NMXzybtcZ7F8NcUf+3PrbHrvPMcyLmeujwVocGM4N4tkiWPBM1k6gmdw=
X-Google-Smtp-Source: AGHT+IE5Lz5Z8TvHu/XPQZ7xcW35xLYMK4BSsLRb4ZXHHryfbWTXxcK+3KOErSSKFwSY3Qpa/b+Dwb6scgyk4w7oYOA=
X-Received: by 2002:a05:690c:3341:b0:786:61c6:7e71 with SMTP id
 00721157ae682-787d54000e5mr44006727b3.33.1762680632121; Sun, 09 Nov 2025
 01:30:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109091336.9277-1-vnranganath.20@gmail.com> <20251109091336.9277-2-vnranganath.20@gmail.com>
In-Reply-To: <20251109091336.9277-2-vnranganath.20@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 9 Nov 2025 01:30:20 -0800
X-Gm-Features: AWmQ_bkbRtNWGfCqQhtiyR-WwP60coqAmrQ2s_Ti-H7itEOnkdEhbjX53fOS4EE
Message-ID: <CANn89i+zVr6RwHPgDLcqovYXYwXHA_zHZ8i_1fq0idsN83MHuQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] net: sched: act_connmark: initialize struct
 tc_ife to fix kernel leak
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: davem@davemloft.net, david.hunter.linux@gmail.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, khalid@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, xiyou.wangcong@gmail.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, skhan@linuxfoundation.org, 
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 1:13=E2=80=AFAM Ranganath V N <vnranganath.20@gmail.=
com> wrote:
>
> In tcf_connmark_dump(), the variable 'opt' was partially initialized usin=
g a
> designatied initializer. While the padding bytes are reamined
> uninitialized. nla_put() copies the entire structure into a
> netlink message, these uninitialized bytes leaked to userspace.
>
> Initialize the structure with memset before assigning its fields
> to ensure all members and padding are cleared prior to beign copied.
>
> Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D0c85cae3350b7d486aee
> Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> Fixes: 22a5dc0e5e3e ("net: sched: Introduce connmark action")
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

