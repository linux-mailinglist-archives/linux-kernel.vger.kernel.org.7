Return-Path: <linux-kernel+bounces-730277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDE7B0423D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69F116AE04
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4B2246BC5;
	Mon, 14 Jul 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BCWGotm9"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9F25393C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504827; cv=none; b=I5PIRW19V7nhnp9TLEbiKhVsQj0Cu1OhG7H1lVN0Fbzrw5pYq+xCHl+/C3VqHwRvMDZpEuMeXcWI6ioDIYQkkLgudi1Y4wCCFsXuLKI8xTtiqqRjuyu7/o6IoYO6DOIPVyuIcQrHLSXIJAPKKf8bTR7vNkBC710dXEgdG5yEfOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504827; c=relaxed/simple;
	bh=dmCH8nLpuvbR8C1ZmHGLNHxmpbcr2QrDgRWychPUdOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrXSRXBhieLRMXw1mS4Kouske+udFVwyX546tkk5K76EwaPRY5ud+M+XXka14Q4ph5uPlyyDN/JRgWcKheoct1tcV0HpXZ8oGiwMVDWIgmJ2LtC1/WxWeJQThYXYogvAhK/SX8SNFsyR/vslsyeAMbltL4Dh+Nk16663GIE1C50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BCWGotm9; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso3806400a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752504825; x=1753109625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRS7KVxRS0W+fx13p1N+pmmO7RXDwXvW5xZaAlDLlWI=;
        b=BCWGotm9/T7J/RJNrsSOt+cioBpvjoHY+diYRA2Ta72r6UREQAoXwB/QksiVzjUx9i
         y4ucwzyXG6sti0xwVP1GrTnDFSMK9ap76rkj23IwN39BaOKrazMIw80YAv1E5qvMABXw
         aGWl5Yb7sLLjKOoUv/c4Ci4tbVnjt0KadVPEjFvg28Oq5DXwM0krD5qBErjtUCeQg/74
         eoa9T2EdXI1s7ZyT9/AQMo32vBvW41dh/ukzSwcmEA+sIDaWcl0bcLj76neHwtN/LTVb
         xRahxkFGekmVE7s+p1sh9qqEPAoYeOPWZVnbKR9hCfHE65bZ58sL8hcYK00e8Yu67RzG
         tyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752504825; x=1753109625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRS7KVxRS0W+fx13p1N+pmmO7RXDwXvW5xZaAlDLlWI=;
        b=OWgoKwSQ0ZsnA+ybC0gEVVZ+xuIvA1QVuRnNQw3VvP3zJSigIhmx6gP6DBXD7luGE/
         ihV87yDTI7gqfcnr5vufYjR7pqGNcp/jkSDErWxrQDvwy7vET13bgI3XChBqtnWcGhIV
         b2PX8wPD7t79vK6CtNd0peWTpHwGxV1NTSCviCjx862hZO/MS5j/zte6mkeXx5pdKycr
         8BEhTrTKCgAH86ytziP81/sD2dWROnnnGcB1wk8QebI++Ro/ZhvHTco8zuA1Yl/zEFRt
         b08UAiuWEosgocYma0tG9f81Y4XV/BqkNXXWN9KW2DUm9LVqqniUghjRRTRi9bKdVCoE
         fKFA==
X-Forwarded-Encrypted: i=1; AJvYcCUqoivAJCOjBBu5zqCclNBGD26+gCpOSLfBa3Sx24/V9wXSBhZUKbYN7m5ZPKmJP4WJ+xkDtymUcqKMvL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybP1/WrmvQ5LQbOe275qsJjCm6FXXeJSjplednFdCEPOl+n9FX
	z1m4ffUHcN4Xc9+rHgTuyAZhcsPBEkaPyAbGHsOWwwqaA7jpr+Whpct5/UZhztC9lvaS/p5OOEZ
	koogcrbV4IEHfTnpW+Y8bNy/xzHCAJTFmNb9+h2yx
X-Gm-Gg: ASbGncvA3EofkyNlB10hJ+wriXAzhHR68aDwrrCvk9rqMLTYtEaWqk2kqy8kDYf7kA3
	kWX/fLVwdvHnudtVJjSvcH3RvlHlK/qse5ShyFBL/xqa+aIUKx7IOgeLE4jk77/sgfSSAUTc19L
	tVyJAWPOtepY2qUgf55H1PMFEM/tNfJ2lkv7Fo2nS1GTeDq+CaHXDirkfrHPZWOcORFF/qtch//
	a8Ap/Q4HbYafDovCTBPrVPw4EtJX6UsLOxvfA==
X-Google-Smtp-Source: AGHT+IEmImtWKne0fXh/9EoZheSYc9ViDZzryJZ8eda866NF14PYMINb7G149CT3MobK1jQkkMisymqVEAyEM83YC5M=
X-Received: by 2002:a17:90b:54cd:b0:313:d6d9:8891 with SMTP id
 98e67ed59e1d1-31c4cca42e0mr19743605a91.3.1752504824807; Mon, 14 Jul 2025
 07:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714110229.141221-1-krakow20@gmail.com> <20250714144837.GA2996266@joelnvbox>
In-Reply-To: <20250714144837.GA2996266@joelnvbox>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 14 Jul 2025 16:53:28 +0200
X-Gm-Features: Ac12FXyf7w4PNNBTUqz17dhSkzaXwGCVMM7xX5_IyWW7AMetiwQzySVecf0ZfGo
Message-ID: <CAH5fLgiFOFm+Lh0K_PDZ2eCFa0EAOMk9GRh0Cgh2sm8fay=qnA@mail.gmail.com>
Subject: Re: [PATCH v2] gpu: nova-core: vbios: change PmuLookupTableEntry to
 relax alignment
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Rhys Lloyd <krakow20@gmail.com>, acourbot@nvidia.com, dakr@kernel.org, 
	rust-for-linux@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 4:49=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> Hello, Rhys,
>
> On Mon, Jul 14, 2025 at 04:02:23AM -0700, Rhys Lloyd wrote:
> > Instead of the data field containing a u32 and changing the alignment,
> > change data to [u8; 4] and convert to u32 with a helper function.
> > Removes another magic number by making the struct the same size as
> > the data it needs to read, allowing the use of
> > `size_of::<PmuLookupTableEntry>()`
> >
> > Signed-off-by: Rhys Lloyd <krakow20@gmail.com>
> > ---
> > Changes in v2:
> > - get_data helper function renamed to data
> >
> > ---
> >  drivers/gpu/nova-core/vbios.rs | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbi=
os.rs
> > index 5b5d9f38cbb3..339c66e63c7e 100644
> > --- a/drivers/gpu/nova-core/vbios.rs
> > +++ b/drivers/gpu/nova-core/vbios.rs
> > @@ -896,21 +896,26 @@ fn try_from(base: BiosImageBase) -> Result<Self> =
{
> >  struct PmuLookupTableEntry {
> >      application_id: u8,
> >      target_id: u8,
> > -    data: u32,
> > +    data: [u8; 4],
>
> Instead of this, could we make the struct as #repr[(C, packed)] or does t=
hat
> not work for some reason?

It would probably, but packed structs aren't very nice to work with
because Rust has to be really careful to never generate a reference to
unaligned fields.

Alice

