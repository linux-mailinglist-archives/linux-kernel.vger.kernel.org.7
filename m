Return-Path: <linux-kernel+bounces-835443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AB0BA71AE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 16:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CF7165E67
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 14:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02491202C5C;
	Sun, 28 Sep 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S682uVXe"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF01714B7
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759070373; cv=none; b=bEv8zEvzpA9qrexMk5Xr2z9bZ7ISvGxAIifE1kUV6P6xhvPKnUg09RkSgox6yj6jH4cTHa4LGuVDOb306B38ETxeY2FND9lwK5JnDBdf/rptGiqRCgjE1PfQP0j7qTQPbL7NTUGWZjMypwP+gTDp/JOwMdgePi8RSdU6FKwS9d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759070373; c=relaxed/simple;
	bh=7miexSVIY9sXCT+obT1zQ1e0Pd02sjjmXPW7xBDwtGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiSj/pPZfI4hJcerEUINCtdZO+VhDE/XuaQK4SJMe6t621ZYe++dCWQo4am94x29xz2lGTO++DbSQHMXqrMERyhAQV1PDdJJKsi3t5XCo+cyb9tFNo//ZCDhG/eZn6/pSP6/XChCAH9wQjP7LruuTM+OlXqOt0nVMJaaRk/dwfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S682uVXe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2680ee37b21so7655275ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759070371; x=1759675171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GheiArk7ypVMh1/1PtNPjvR+VE2OgXKMbbYZQv3X8+s=;
        b=S682uVXeMB/CqumVsJ/zhIw6BnfpWhoc1KKvHSBkqihLxPivYkoI2UVsYVPq4bBaI9
         MboNn+6PoW4AMMjxxKq2eKGviWf0E9KNlPeKYdwdPcUvcZU7pHFOfpzN49ppJwq38mWt
         yFcY2QrgLZ+gFJismfdV2muFRSCK6iW5120gRPhOfWP8BEZLNkLn1NPnowRoeG5Itkux
         YC6jUkAaZ7ygysEevjsiebke7avT0bsIx3CtiKm6HlB/dB1AtLERUu7HBjUE4FUfsbZr
         7UMW0wVcHg9B0bC5n0iGeomAuOW3Gex+fyHfEkZXloonmawRGlO9usC2udbOYbEi+zze
         GWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759070371; x=1759675171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GheiArk7ypVMh1/1PtNPjvR+VE2OgXKMbbYZQv3X8+s=;
        b=cOlSSCStORdka6vpq8hHzGhGbaLZ6lIDZLmaoFbqibPqFPPfO3rC8lVYbP/HH+ntcp
         r9PrcYtxAb0fXx9dJAnQOqQjIL5bPNV64H/ifKmfkyyBQEl44mE+1rIJ1ByT/dG+meQa
         UTxqRUoRKR8bwUjcpk7+84UmsTjNY2Ijxk8iwqX03bTKK8R7MSbEmjBmKGwRRfAqDZaY
         NQaijs4LDvXIdkpgCBheLqK5F8o4JBW/TQWcWkRVsxmcKsRJopIR3iDTgD2Q7jmBQSxp
         MK93n1A8AYgCBX+iyzAdoisplZD3HVAoywl6B0AwPLvq89rsdp6wuykkRXwJCLntEMgL
         a3SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEzX8Rdd1WmOutk6uczK4fPEIiqlhrRTic8szkrBBPvsTslzTjY3h+BSPM4jZpdYrpDSJ6D9nBCtFgo1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7EdgkfSZuXeNcYh+GX8yL3JbnwoG8nX1ENQSi+Gu71c/KChkJ
	F4Xay/0j6YEKDJ3fWAr9ceiCYjqfZOGaXykU6Qdi6lDmECvKCy2winRK+KPlTN2qJISrLJ+B4Vm
	Km1GnMqTn7u35/Nu8bxWxQSWYtx3jwE0=
X-Gm-Gg: ASbGncsKKa0K1y6aufcaHEEjc3WwaSLpkEClaGtfGNXZaXQaLv5fKG1GA4ERLBTc3mp
	mbTglrkMQQL1ATAr9Acb/uEmW2VnhGMpBDnGeXaPfQqj4I2H/dQJXBvWjQrUrc0NgiFXegxkkYX
	MQEwCZ8ZiPa91nET+NcDbZCp/ZutdOfPtvF4WbmZMq4mLSvPHPs7qqGP850vOWHDoZPqBaUCsa7
	lPBV3vUyQem2Y9E8EIwUISQD7ebm7BOLvPzahS+SzSVzheJk2xJxlaO3h/FA9iwNN98rQHZyT4Q
	Q3Akudn+ikq6L6BDbXTg5XfcSfyfsm0kGmG6
X-Google-Smtp-Source: AGHT+IHYuLoigCXO/IuVYAvcStFqo7zlZrUbxDGRobz0IRwpzlqDn+RVpePg9UTv4hbc9kz3W2vIkL2OT4f38G+Rpk4=
X-Received: by 2002:a17:903:2341:b0:257:3283:b859 with SMTP id
 d9443c01a7336-27ed4a47a07mr85244135ad.9.1759070371229; Sun, 28 Sep 2025
 07:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMlhpIhjbrDR4C8L@sirena.org.uk>
In-Reply-To: <aMlhpIhjbrDR4C8L@sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 28 Sep 2025 16:39:18 +0200
X-Gm-Features: AS18NWBnSfhUHigPfGdLGRaT5eXdBPpwwiSWk230N8BH4GkuRtPWn8V78nifa80
Message-ID: <CANiq72=jq50cCg7Xotc_wruGHiwy3CKcCH8D64-F+BEKznUz=Q@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the drm-rust tree
To: Mark Brown <broonie@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Tamir Duberstein <tamird@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 3:10=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
>  +use crate::page::AsPageIter;
> + use crate::fmt;

These should be the other way around to pass `rustfmt` (please see diff bel=
ow).

I noticed now that we have cleared the other issues. If it could be
fixed in the merge commit, it would be great, thanks!

Cheers,
Miguel

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 3d38d9bde582d..2cc147a4cb881 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -7,8 +7,8 @@
     layout::ArrayLayout,
     AllocError, Allocator, Box, Flags, NumaNode,
 };
-use crate::page::AsPageIter;
 use crate::fmt;
+use crate::page::AsPageIter;
 use core::{
     borrow::{Borrow, BorrowMut},
     marker::PhantomData,

