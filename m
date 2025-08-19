Return-Path: <linux-kernel+bounces-776000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2AB2C749
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA875E6DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C6F27A12C;
	Tue, 19 Aug 2025 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVVRvzbM"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C726F285
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614430; cv=none; b=r10wt8UdYjn6NJ8Tv2nR1nyGVJ+4dJBEaw8CLa4WO7imAkEaL6/sBWtqCFE7z2WZ0iWnahwZr0VXjzaURbsAKTvTfZeUDHd5oiyl1n3Uzkw90A5B+0/sAiKf8n540l/3/KsvEn+A4/t8GlvGunHG4ONh2i/gRtsgMPT2gIcDb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614430; c=relaxed/simple;
	bh=powjH4/vqCubBUe1QVVYigDqOzHRtOCPyZsTT8uZncI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAcA20f55m1UhaXg6ZXhJncqQ1lKQKwcmJ8LwKKmExikXbX4bxiHH22mR/fiXA2pQ1HRc76UMoiaVANIlh092AjqaVs7RNwYuBa6zMPmzjNwPVyxeVLRlHE9cGAtNvsmogGc/DOJWByTtnpv5yrgZPvBPpFLIxzjG3hFBkDo9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVVRvzbM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24498e93b8fso2851055ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755614428; x=1756219228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=powjH4/vqCubBUe1QVVYigDqOzHRtOCPyZsTT8uZncI=;
        b=OVVRvzbM5nTL4XWp9xxJ1iWw72OT/BrDP+PoNmIpkaUIf2mqnOzXhFt75iTXQihnVz
         VZerI8OnDTrFz/0vbqSUcmtsfgbkHMXar75GKmp0RQrk+KeiwRn+t3bjFHfj1Rjygw0i
         IHpmQ+7lg0CNGHlHQrdB0xT/a+zweYjbBd3KbQlqnS5LquEXswg5+CkUXwnddFFUmumC
         eKmDJB6dPOOOQL3TeFNr33iVnRT/BacO4dyoT4bOK2QygcExw4gzpvyuVM/n9GBSN2f9
         3WGf8sdxusa7UPjGThjjt4xuSS7xPd7qJUcMHIPh3rpoQgT1Zy8p+6WSb496haasuRP4
         Z3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755614428; x=1756219228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=powjH4/vqCubBUe1QVVYigDqOzHRtOCPyZsTT8uZncI=;
        b=NwweiRREXkardZnbYathz2L/6VJjetsKXvYWfIAHss8D2oMASXixLQ8M6Nts6qhlN1
         wjUNgSpHgTU+xikVbOzekkq/U5EQM/gkhNbej+JtvHh5DeaYPc3cDv7j8dz+DIpWh6FL
         p7Rl7z96U2Eg4Q12PRUq8L4IU1PqjNX6uEQ9Yfmr/iBVevCgCkNYG3xRGAKYz8eGJjeO
         0om1rWcdMYoTKkugNMbmiqGhX+G6gyd7VO0DlvY6yV3jjGYh2aN0jvokINGsDCbvfZrm
         Ct+4HvtupcIJuvxvg3HEoE4WDWwUopTdwuYksE04wdft1mNdsOBNIvnN2P9pfflNVIPQ
         Vczw==
X-Forwarded-Encrypted: i=1; AJvYcCXFhH0xqmVOflXCiyopD//74PnAiFCDVuKGKcKZ/3+1R9zfvjXGlAuX/s/8Foy0/5/mY5dtVUKC83gPj/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLXCe8F14OyoKLtjW3lLnsP43zXn6W6OyBzW4twRd+tOoV8Lp
	gV5m6dD6DTT3C7LPO7PQ9L1IpqV+PvZ65YNEAxP0E00TwWRP7q/Qy3Y8xI4pNIcTR34BGZ2+Wpk
	MT8/rUAamVy2us+JekbvLXLd99mW3L4en+iA4
X-Gm-Gg: ASbGncsNt/rJ/goWhQwm0GMUHABuR6dzARoRyNvcb1D8lB0UoXmCXwOyNfPTXaNlayX
	eUZWChh8cQjiurr0+2cNhQTvbltlQf8bX6crRjKTmVYyOZVEbvb9St2CghI7uX3JMKUpGMWtucn
	DnCZI/mz6Fjk9YenF2OfONavOwB+EpLmHTV6h1CZLQI0lSbuJWzadaJOJRh99WOEfQ25KmQhyfO
	FvePN3lp3DEcqFDugI=
X-Google-Smtp-Source: AGHT+IH7MYmFa23RpmbCC5xNupyWrRDeZDzMvO2feUZecAoH9ROtEE9VWuh0ZJT1c7iBGj0TEZtfjUVpTFP1cvuqNmI=
X-Received: by 2002:a17:903:183:b0:240:3e5c:476b with SMTP id
 d9443c01a7336-245e02dc5b5mr17518885ad.3.1755614428306; Tue, 19 Aug 2025
 07:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819131330.153128-1-liaoyuanhong@vivo.com>
 <CANiq72nNnz5esQpGFsENUm4cgGOAkkkqCuHyNxfEPHUrFvaH8g@mail.gmail.com> <893eb958-68f9-44f7-a1dc-4869af87c7c1@vivo.com>
In-Reply-To: <893eb958-68f9-44f7-a1dc-4869af87c7c1@vivo.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 Aug 2025 16:40:16 +0200
X-Gm-Features: Ac12FXytkFzeV2Lqy2E9L8BEmlogdGabMiaG3fk8wFFJtslSIfJ0Q2M81yFT0aw
Message-ID: <CANiq72=6+Fv2c6RWt7tAUTNODm2MyxcpMnRDLrWWgJS_Lm6vFA@mail.gmail.com>
Subject: Re: [PATCH] lib/vsprintf: remove redundant header files
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Petr Mladek <pmladek@suse.com>, Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>, 
	Sergio Perez Gonzalez <sperezglz@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	open list <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:18=E2=80=AFPM Liao Yuanhong <liaoyuanhong@vivo.co=
m> wrote:
>
> Thank you for your feedback. Do I need to submit the v2 version without
> fixes=EF=BC=9F

You're welcome!

No, I don't think there is a need for a patch for this, since the
issue was in a test merge, not in any particular branch or patch, as
far as I can see. So I assume Stephen will simply fix at merge
tomorrow.

However, if this slips and lands e.g. in Linus' tree, then yes, a
patch would be needed. Maintainers may mention it to Linus to try to
avoid the same issue again in the "real" merge into mainline.

I hope that helps!

Cheers,
Miguel

