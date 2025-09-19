Return-Path: <linux-kernel+bounces-824245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C407DB887E6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4EC173D02
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C452F3637;
	Fri, 19 Sep 2025 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf0DDs2u"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAB12D061F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272265; cv=none; b=AJ2xHhYU3fhNIxOT+WWRwrngDy5Mxm9QHyBQVIF4TP3tLvUl63eMnsZuSkK14L7T32IstbR0LD7vwm4gYRb5oAdwPRj3EfwYNv4Ik8wSIyqBWUILO4XWMzVmu1HZfGrFkUnQz8Gu0skysxRiJI4m1RHeI08KzMbeoaRGj/GmCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272265; c=relaxed/simple;
	bh=JZ8ALzi4l89b67PM7h3d2OpqJrjHcj142Sm+/TmRQXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4Rk+xpwX16nGVcQsv/fwbXwrpZdMOcvBPLmdkCfq0sNmtUHYLbumEAKYj02PHzPbBd4JzmpShP84sjYY87PsflveE8fB3LhgGCyyM48O/j6PSXgtYIJWGzDsswpuf6vPOUlNRQ0KgCicvgAftu1zNI9U2hFIf+NNOFAeu1Q0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf0DDs2u; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2698384978dso15016295ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758272263; x=1758877063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IVX4Bv4ex+uyVv1pbESwXdzZsofD0/jfymFeQrylr4k=;
        b=Wf0DDs2uizMTfq3zfvBcKXu5ATpz+VEOd8RMG064DgUkkDalD60y+yLLeBEiWtKQHy
         ClYMfxp3q3aQUl6fh6aLBhPK6SjnL6vo0imXY3afGA9TmkfaDjaJ1ttGhFe3PhFfg1/u
         mD4paJW5zfBi5T6W4B57CTwrG+wb9HSJwtYzKQtBp6+/BkN8clV72/fN6ASniYsiHh1l
         nn3ZBwGpcfOUFi+PA80U7f7sC5BIKplCLKTBU0pVMHtF3QyDEf4OqLDfCL6yfNiLEEup
         c2ULObJPLklcWFN+v8ERY88+k2l3lmrcLrOFEM8KP+YZOjtJKIuuzcdx1pV2D7SecLA0
         KXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758272263; x=1758877063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVX4Bv4ex+uyVv1pbESwXdzZsofD0/jfymFeQrylr4k=;
        b=H3anmdxTDYInstnrCFvQckIpiRprokaJW2cgkQAwtVmSJm3rt476412PGdXuS1DZGs
         vk6Y8JDWuBYMj3RkEBDy/1jOgognaYI01eO723qnI1tZLf+YA6ms2eeqD1UCpzRZC2pw
         rqCup2JrYT26NlzYo7s+17XP7JItLJppwpyVDVVtOLXT+AxgoVyGoAjsoRXLo8AnYhdc
         iY/mncdN7wQVwSuEiFiUCCWNpPLU/qqJwQB++7vDZ/yniidrTFRPpghxuBqbTLmkEWnF
         0GgUCZUlJBdy5Gfu4kGZ8S3ND+JN5EfVGEVcsjpChJzE4IkBDcCeJmRr87WRKs6PM0Hn
         Kgtw==
X-Forwarded-Encrypted: i=1; AJvYcCXUmC8/odIRPVbca3TqS+eu9tTQF4W97ZU2YKQ7wlR12tK8ldUa98MRb1OOp3cPLdh9NCggbbi1BoqpAng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxEu/z0WX8iOrsGoF4B8ADCD+401O4IlpNtPeNCs/sioBqnRV9
	3aWqzn2QtCWljfpv9mOc8Xvp1mJCeeyzSjrSvmGmaJzOskQIc/cluXHQwuMhrvQ2X726xK2dVUK
	+6acUw4Y3Q0cGAFiJCheC7LFyzF8RWBI=
X-Gm-Gg: ASbGncu2sc8Xv9DKKOjz0kB7PP7vZgn31k/QSv1TFN+5oOq4fOGBvQabTneeCnztXTt
	D4KR6NYz+7cjWriHuz4/69WbZ3AMa4KTboACjX+hgQ7mJS9KOa4B7Th1CKc2JoVKVy3jCdtAENt
	e/TisHp1taU6+gj+P0FDIvjensajyOLfHxK3tIAVoPxOW2vJaDv3jKsi//ZGgmIih2B0auI+3Iy
	oqOLHcNyAGPXRs8axqk
X-Google-Smtp-Source: AGHT+IHUvEeTq8dbZhTVSYIaod2IJCP9IAd80QKZqmcoGD/pxowUWYdmJQVUNvAlNGoK2mzZTyBH/w0E0uCfSxtDO4k=
X-Received: by 2002:a17:903:2f08:b0:267:a231:34d0 with SMTP id
 d9443c01a7336-269ba527e91mr32353655ad.42.1758272263501; Fri, 19 Sep 2025
 01:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRLqsWnWnDaY2a23HctbxLKquvw7Ax30YB-tdBmS59RtQ4JBw@mail.gmail.com>
In-Reply-To: <CAFRLqsWnWnDaY2a23HctbxLKquvw7Ax30YB-tdBmS59RtQ4JBw@mail.gmail.com>
From: haoran zheng <zhenghaoran154@gmail.com>
Date: Fri, 19 Sep 2025 16:57:34 +0800
X-Gm-Features: AS18NWC4ROcPlc2EncCLRhcJUzB7R-S8-CSg44ldda1VIZQG8MqmarJKmJUInTc
Message-ID: <CAKa5YKgAP5L+uBr3R0Au_n_s4N73y0NPFVh0y1XYPaAJyuCB5w@mail.gmail.com>
Subject: Re: [BUG]: slab-use-after-free Write in sco_conn_put
To: cen zhang <zzzccc427@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, johan.hedberg@gmail.com, marcel@holtmann.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, r33s3n6@gmail.com, 
	linux-bluetooth@vger.kernel.org, "gality369@gmail.com" <gality369@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> RACE CONDITION SEQUENCE:
>    a) Task 31374 releases socket, eventually leading to sco_conn_free()
>    b) sco_conn_free() sets hcon->sco_data = NULL and calls kfree(conn)
>    c) Task 352 (workqueue) executes hci_conn_failed() -> sco_connect_cfm()
>    d) sco_connect_cfm() calls sco_conn_del(hcon, bt_to_errno(status))
>    e) sco_conn_del() attempts to access already-freed sco_conn via
> hcon->sco_data

I think this vulnerability should be located at sco_pi(conn->sk)->conn = NULL;

Specifically, when sco_sock_release is called in the Free Path,
conn->sk is set to NULL under the protection of sco_conn_lock(conn),
and the TOCTOU problem occurs at line 87 of sco.c. When performing the
if (conn->sk) judgment, conn->sk has not been free yet. However, when
sco_sock_release is called After the judgment is executed, resulting
in conn->sk being free, it causes Use After Free.

