Return-Path: <linux-kernel+bounces-848608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5BEBCE291
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5F819A3833
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67791234984;
	Fri, 10 Oct 2025 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bb46iiyl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9056222580
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118624; cv=none; b=rVBXEI9OcLoFN2gh91Yjg/sGWA4RiTTnpiXIH046m0E4dIu3j1EQk+QtUvT939g3xliENH02dFE6FHaxOiZdY0oIlkUY6wwilo9XSECeXEOqHT0V2PrlAyqiBvYXM/Ii2gcwVlwgOAoUxISrC1UTdW1K2nKUrALp5Xj0bXPGQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118624; c=relaxed/simple;
	bh=rLfW2f2M9XNswFGXljZ3Iduk5Ck52EhLpoddlrpwCU4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZrTGunReSaJeQoOp6hKLUIuaMRO4D7GGZjkAJKiylv1156RpVcuh/jSk7cva2LqX5AtR7PBaS3zSYi1ZYRpB6VuCKch/+copJbbS4VtkQK/uHwvLksPEHO024yUgC/4qayXM6haXhQByryjNBXHbQNkU7L4uc17Tr3PT904EnX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bb46iiyl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760118621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLfW2f2M9XNswFGXljZ3Iduk5Ck52EhLpoddlrpwCU4=;
	b=Bb46iiylpWfiOwHOgiOfJjPsGz4s8QGQfWB50x6on3MtegpYJaYKpNWEqTLCpXmC9yinWy
	WdXzvaYOyr0/N7uU+RjyOERlvJ8QTsaDdDTSw0te3h7i9TLVCLaBtAZo8x+VDys8vW5dOi
	/sx6YN0e9C5Mk39Bx01D6bJk7ALwPxc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-DzMKAKcHNJe2OTma72_7DA-1; Fri, 10 Oct 2025 13:50:20 -0400
X-MC-Unique: DzMKAKcHNJe2OTma72_7DA-1
X-Mimecast-MFC-AGG-ID: DzMKAKcHNJe2OTma72_7DA_1760118620
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42f67904af6so153255365ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118620; x=1760723420;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLfW2f2M9XNswFGXljZ3Iduk5Ck52EhLpoddlrpwCU4=;
        b=NX1zTVvZkEurdpzKLSAupQVk+ecBCWs9Wk7fCX9P9u/GdHOizzK32NUMUiASxS5qqv
         tD24qmi/lSIJgtBqtA4YtUaBxL5r5MmzNAwjxX1r4jA/yR8msEAXHXgdfaVthdCamWnh
         1lG6S4lLAtGfEPD/1a992rf0ci1PNuz0mb9XNYPdPr6An5I6Oh0OoFRhB6mJyKx9AQML
         jtyLwGY4VmLvV4mRLmU2QNVV5EKTaBe2WvD91gAUSu1xA7q4TysAbc04J7rRpcqwDSnL
         bLVuy3Y9zXBnX/xIYF3avKGiEbsaY7e8mKowjRrWa3NVODKkQMv1dWcFo23Q/Y3oACvk
         cmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuSomiNln0OIQZyixj+FDnqeOE4CBfo+7W8MkiOoGUjjdhKiuJYwxrQPqWpiUbLoDd4dTjV8ExsGO+ZbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKOWn8NG6EElKgwb/yGph/W1NwfTOd2KLsbGygh3XAVA81+bk/
	N2Ej1YKFA43F6aQxJIVPnYU9SXADdU3Wn8H45euPZEiBdp/P1MsO8lW+F2SRfV4ltcIOBRAG6zY
	P9tJx6WHQbGnanLEU/g+z+l41T/3mN6n7shwzzXQqLeB2XHBJDejJZa+5xu/iN2PTEQ==
X-Gm-Gg: ASbGncuEg3D6blw2r82hijx406OC+NS8t1F7dHGtMR3hI2FYZDvCndit1fDmWCKebas
	9x/jL5peBuolNvWeDylpRmN58apu2a2XHh/CRxDxVkCePcNN/tPLF1ic5JNPR+gutGeBibWOVJA
	WYMmwqz2QCD3OJ6pqgUqaxfCnULu00iufsgs+cQ5ZEI31Pb9mkTIBsNj6yDgrI5HFPyFatpokuf
	AfcjMqFxHcGnZWdsIvlN3c7S35zKOvDmlUlNuBDAmYzTp5gPwmOf7rjyK4NSdpamUQO8Dky4Izy
	+/ApGqrsgCv4QMjdVmTWEQ9dPT+yoCs+1tw2VqEjak+H880EUZmDEqP0UF6LMWARQJP4b2wE
X-Received: by 2002:a05:6e02:214a:b0:418:3b13:d810 with SMTP id e9e14a558f8ab-42f87369997mr124814755ab.9.1760118619732;
        Fri, 10 Oct 2025 10:50:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuEr1LbEgCdvx7M0g4qU2T30kNZutU1XAtlJUA2qld1e1AJmZAVgTNchwHGkxRss8qWACILA==
X-Received: by 2002:a05:6e02:214a:b0:418:3b13:d810 with SMTP id e9e14a558f8ab-42f87369997mr124814435ab.9.1760118619250;
        Fri, 10 Oct 2025 10:50:19 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e2594a558sm117662939f.7.2025.10.10.10.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 10:50:18 -0700 (PDT)
Message-ID: <c60f6d32159d02df6c2c98477d22705539909245.camel@redhat.com>
Subject: Re: [PATCH v1 1/5] tools/rtla: Add fatal() and replace error
 handling pattern
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
  John Kacur <jkacur@redhat.com>, Jan Stancek <jstancek@redhat.com>, Tiezhu
 Yang <yangtiezhu@loongson.cn>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 10 Oct 2025 12:50:17 -0500
In-Reply-To: <CADDUTFwFerzjRTPp1F+Rw+_U2DoomAxyDonXudCwh9gyXSn=nw@mail.gmail.com>
References: <20251008195905.333514-1-costa.shul@redhat.com>
	 <20251008195905.333514-2-costa.shul@redhat.com>
	 <34afd8ffbb1c889e91fa536cf60369a697d86575.camel@redhat.com>
	 <CADDUTFwFerzjRTPp1F+Rw+_U2DoomAxyDonXudCwh9gyXSn=nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 10:20 +0300, Costa Shulyupin wrote:
> On Thu, 9 Oct 2025 at 00:55, Crystal Wood <crwood@redhat.com> wrote:
> > Looks like there was existing inconsistency with newlines... maybe have
> > fatal() include the newline automatically to simplify callers slightly?
> > We're not going to print a continuation if we're exiting.
> >=20
> > Otherwise, for the whole series:
> > Reviewed-by: Crystal Wood <crwood@redhat.com>
>=20
> fatal() belongs to the same family as debug_msg() and err_msg().
> Historically, the prototype and usage of these functions is identical
> to printf().
> printk() was identical as well, but now it adds a missing end-of-line
> automatically.
> fatal(), along with debug_msg() and err_msg(),
> can be upgraded too, but they should be updated together for consistency.

Only fatal() has the "you're never going to get a chance to print a
continuation line so why would you ever not want a newline?" aspect.

And this would be consistent with panic() on the kernel side.

-Crystal


