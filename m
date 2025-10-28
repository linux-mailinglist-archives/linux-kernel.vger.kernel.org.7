Return-Path: <linux-kernel+bounces-872849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF25CC122C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615A3563212
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D821EC01B;
	Tue, 28 Oct 2025 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0KJYVbFc"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC4319755B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611649; cv=none; b=R7I7EIxFWAlcBkJx92g76PHx4TvEZLOJiR3/CadChkT/Jz9g0UOf2oCeniWItNb6DtFvLq5Lk5m6hxdBIWbhKiArSc6zE1N0akRWMj8QJFGayRGMagLcCBcApJgZFXbXjrMJpXRVd1abYrrMv7je7DC+r0xajODkVVysVOzG6U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611649; c=relaxed/simple;
	bh=np9MHnvkGUDtn32mHRigCmaOIGhYbItN3DN6jEpgT4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVEzmoIsEMDlazdv0cVFcOWUfmPJNJx/exvOR6fISragLlwCvYEpBBOQE7zN/z764nCAELqz88NJre/JfV0fVbKl2mU49V5+crgquf7uGVVjft6Sx/4Soyz1vFwuTPQ0tYT+2vLwg6lHdLaNTOaq5PS1UN1dCWdj03Wl8GcyDbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0KJYVbFc; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ecfd66059eso158251cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761611646; x=1762216446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=np9MHnvkGUDtn32mHRigCmaOIGhYbItN3DN6jEpgT4g=;
        b=0KJYVbFcTrpGpo8qv399sSGsoBh0XICxBm8H0NXzCe4jFVymDIj+26neKMMjn9Bw9C
         Xn8aMwprzdqCNgWzetXXQLq96D9k8ezsFH5L8v3AEzcar2BQ9ehqTlUIXqNYM+xSJW3e
         l4kkqRioC0/LwSSD/LFh/4W3mBBdUeQ3R0ID42GqeWVJj/litLxsg3SJEHJ46EqjkNAB
         H6FJJXbmA1p0+GdFC1pFC4DJ3yIQ91lno1CjP7Dj+0+0RtmGuvrZv1RJuSXR3vSQ98cX
         aHDZRGNlppk1K4cfiuGCVS98uJ+GgG1F1FASLeWL7F3zK8aQ0hQz73tEJLQLZsFKYTv0
         C0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761611646; x=1762216446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=np9MHnvkGUDtn32mHRigCmaOIGhYbItN3DN6jEpgT4g=;
        b=ZEPkoA/AdTSDLfUBPIqUwrZRVChTpoddBKkqiqQp27+Hfc/uPjyckHXfZ50Re95erZ
         DQpHnN5JOmHN1zO9pJTXbT698jMwVQOA2+QuKMlCs0/bYFsIGYpCnCH2KumR8dkiqh6n
         dr7aO2YI6gjWr1ZHsFRuin3i6/ERNsuwYkKrzXEGzPQJKikx9SzoYR9pHJ95w7piXtsz
         aSm8a6xsKYURfChWHjFPbkjnc0qXoV5Tlghph5395O84L4nCooHvb0Ja0A4vxOpupZ7u
         tuRdrvBGOyTd0xOjwhdlu9tqHP7HuHw6KGbB36Os3bXLdWpm6+kyOR6rfoc65EBjP9gw
         541A==
X-Forwarded-Encrypted: i=1; AJvYcCXN462NdAZgy4Lp7RxctMjJDW8tIwoGB7VoMtPPNkB/TogirR8VypklBuGAUXSBsgV3vsL3eDR15fID7UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW1uADEiUNgdPuQb1pWWD2qNZ4MgZ68jM84TmjSz0J0yu2uB5Y
	B6EKCq97zP9dZeiDXWL4a0NZnyPqFI8PkFXoxiot1kjluYAZfGB1FYNCm1OfUhlGepS6ZkTZ5lq
	QxCZQxDeJlnJoFl8XKrsYz/6Vr9G7bfDvEODFHqQh
X-Gm-Gg: ASbGncu8mU9SRXLWbEk1YJKzCcEirtVe5rBAqigUU4hzZZl48sxr7BlDsRoAC2URi3X
	yTZFluCZ0YBVQb39+mbPMtLLPLq68YXIc7CQGm43g7KA7a7zi7tL9XNL0PSMSoZ5948JzwdXb5m
	OpeGFGE3kbpK/Tkzr00fvvCL/obX/907Mvwchl3fvCjZ8PTxhADzHCvSezfXyowd9oEZ7TwEp/H
	BeQyU8Gg/FcVYpnmTdFPGrE1ReukIRFIQPWssKmkyxnFZUWHQceW2u0rupw
X-Google-Smtp-Source: AGHT+IGtobyKZr3Buf1Y+gJy9ka3rDheXwEbcoUOoOvotxlR0nNAoWhJDpymKwu6u/e0XgHLkC94HPaBwWYZ4rty/j0=
X-Received: by 2002:a05:622a:4ccd:b0:4b7:9b06:ca9f with SMTP id
 d75a77b69052e-4ed08e325a7mr3265881cf.2.1761611645431; Mon, 27 Oct 2025
 17:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
 <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-1-47cb85f5259e@meta.com>
In-Reply-To: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-1-47cb85f5259e@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 27 Oct 2025 17:33:45 -0700
X-Gm-Features: AWmQ_bkh5rEwLV4cV0XCq-XK-tFW86EJg2CGfpJXDPMaZ1YEH67NgQRLYqXDCEI
Message-ID: <CAHS8izNSO-4efu8x6OqxHdyuyqQgS_t6EDh3JjjC1k4R_Gtm2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/4] net: devmem: rename tx_vec to vec in
 dmabuf binding
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 2:00=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Rename the 'tx_vec' field in struct net_devmem_dmabuf_binding to 'vec'.
> This field holds pointers to net_iov structures. The rename prepares for
> reusing 'vec' for both TX and RX directions.
>
> No functional change intended.
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Looks like a straightforward name change,

Reviewed-by: Mina Almasry <almasrymina@google.com>

