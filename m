Return-Path: <linux-kernel+bounces-721708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F939AFCCEE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D37E1898DBB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E5E2DECBF;
	Tue,  8 Jul 2025 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lq0xelsM"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7A2C15A6;
	Tue,  8 Jul 2025 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983458; cv=none; b=HLn/aCE7C0SIy5kmGB5rmPF1o6khmZ/fBJZr0G3M+98WFuqAl+AhiLIGCkC4ZU+tAIBwdjfp1ZpQV+SH2yKhqwQNnlSTy/ChsDlm7pz7/Qk2BEerM8YKTfbBWzozvOUXnm4wAfGvAeyjYiHg6rle6Ltg9W7zQ0chpL+fUsG2JWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983458; c=relaxed/simple;
	bh=tMT8TdqcdoCjqYmHjo60TtEOAFeGLeXifmS6Y6mwk9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrlAFFzvVPRiyGRYoRKtBZX5eCHY78Fb74XQkdQCjPYNCsW+8yR1DMns5D8xxHXH3oKkNJrUPV6nlIGAbfVx1aSsdqR11NOFByCCBtTFx4kWGL3JpPVi24/WGzuItm5+PUBDD4glVOYUTxjM5Dece24dpGUQWwm9qe/kWoaBC4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lq0xelsM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0df6f5758so726169866b.0;
        Tue, 08 Jul 2025 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751983454; x=1752588254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtgbJ10KrJZ3EWuq4BoZPrGsm8VyyDdoigIM7j7cQhE=;
        b=lq0xelsM9yJpUPtxqKpexiODbCHR/HXv8znxScSapgKb6ZSstVojh9E9rhRegnwbcV
         8BCeKOOZy6MsYCFD5CxRLqFGCZofVl+A5uEZjOyoQztX3S01I2cst6ow/uvp7KRYGa5N
         TXraAbUZYbJQcYOvDomLyfTImvpd4mM0w/1xNkSWavg8SJs6sq15sTo5wFwaiC5BSGRN
         vmhxO9gszrBR+TgTMBoORAIpusQrDyxdqb4cP+o83MJOPuFqn7ujdZl+rmbLHGS9PzAT
         XczrGwuDCXZWXenA/BAfBV1VnxoXTPzxvGCptTovRxMAeFszkCB1qgSMUivao8sccwg5
         Zwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983454; x=1752588254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtgbJ10KrJZ3EWuq4BoZPrGsm8VyyDdoigIM7j7cQhE=;
        b=f8pMvdnKFk0E8ac6EsbhePogAxyX8BYB1OzAIv934nCQEDdyLAHr7xUWzIBEzor5Vp
         k6fvJrUvn5z40Y/1ejMg7LpQt7nmbCK/OTt5kYJfjk/CvUXS7In/f1Gr1vlJ424PBGuD
         Sufg0tn1EP1KxUV8SLIMpSAESzQm754TU4aiTJLAYP/WSYsJTOyX3HHSSjMFLRKa1Tw9
         yjIZZ39IKqG0c0SJY6i41cPGQMEWkmItsUy6dIDXRZC/sGjtK4lNpg3cZbf18SXHtwM8
         op4GUYtRB7IWpNuOGXIxzALMgynMCqYGSPJ3U9kBxiWbJE5rjdIY2rTwA4vIUWL2Esvo
         O+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCW8EtMwi1xkyZLr9CPWG2sNencv2ZwECfPV/WBZZFQg7tU9HevmD/so33c4c64qgNDXaDNt9ciPkhXkVLRa@vger.kernel.org, AJvYcCWODaY5aoi/OPRUVUisjkSKNUXpP5H0hL83aYa1MXqyxrTvjYLGzKxzdJN38uwgKe4ZXrThpAzvU5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD8LCoAxj0NRl7s0HnMwIbS98TShFlYcEM4LuOuIw37P6k29Nr
	8Ci4iyKzfUTiNaU0KFxPESLfzW2Jtw8lFbrBUP+ammGHgi6A3tsFdBeSTNCq11HWSDsEttFPZE0
	PhsVdhJLsIDrTrU5kOuUr7nd5+Rbwc/s=
X-Gm-Gg: ASbGncvdQafwCNOxeeuDhSues6eN5GAgOCdhbQppThv/8Rc4qSwERnkkkTWYCxHVedn
	gbOFgUb1kkSf1Tt9SpkVWrqHf0k4aVOvKGj+ov3vkaEZCj8d8FxH7asbTgjg7uU/ASD6nBuPRoS
	iaJoTxzWIAMff+0dio7gVS+afU7wiwbCRORcc0h6mUxPPZ6niNoTHPDAicT90cjpE0ganrGWy7N
	96aRw==
X-Google-Smtp-Source: AGHT+IHdkbFaU+dLpQhDaOZuqg3wNksTld/NxAT2ZZUYBhmA+TLmM6O2a0YIK2eEPzgmT6XcfgyNk2gbzbE2E3n4w0Y=
X-Received: by 2002:a17:906:f406:b0:ae3:24c:6a21 with SMTP id
 a640c23a62f3a-ae3fe4bee21mr1601178766b.26.1751983454147; Tue, 08 Jul 2025
 07:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702201337.5780-8-bijan311@gmail.com> <20250702210323.55199-1-sj@kernel.org>
In-Reply-To: <20250702210323.55199-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Tue, 8 Jul 2025 09:04:02 -0500
X-Gm-Features: Ac12FXwtIN_s91ypTwNfJZdzXrjIzaGmHghhjzuzPbLTZXRFfuLAVVSsTsR3A8g
Message-ID: <CAMvvPS6imiPU-v527rCu=Yw6JA1Nc-Ezkc5_uXOSxf8oDjX2Qg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 07/13] mm/damon/core: Commit damos->target_nid/migrate_dests
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	joshua.hahnjy@gmail.com, bijantabatab@micron.com, venkataravis@micron.com, 
	emirakhur@micron.com, ajayjoshi@micron.com, vtavarespetr@micron.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 4:03=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> On Wed,  2 Jul 2025 15:13:30 -0500 Bijan Tabatabai <bijan311@gmail.com> w=
rote:
>
> > From: Bijan Tabatabai <bijantabatab@micron.com>
> >
> > When committing new scheme parameters from the sysfs, copy the
> > target_nid and migrate_dests of the source schemes into the destination
> > schemes.
>
> Fixing the missed update of target_nid deserves Fixes: and Cc: stable@ in=
 my
> opinion.  Could you please split and post the part as another patch?  For=
 the
> Fixes, I think 83dc7bbaecae ("mm/damon/sysfs: use damon_commit_ctx()") sh=
ould
> be appripriate.

Hi SJ,

To clarify, would you prefer it to be a seperate patch within the next
version of this patchset? Or would you prefer it to be sent separately
from the next version of the patchset?

Thanks,
Bijan

[...]

