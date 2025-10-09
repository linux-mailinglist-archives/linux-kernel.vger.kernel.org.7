Return-Path: <linux-kernel+bounces-847564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF7CBCB334
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738EB19E7720
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFEB17A30A;
	Thu,  9 Oct 2025 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdDBoi3Q"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842786331
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760052644; cv=none; b=r1yejuDSlaua+5ICfyhaSkjc9UOi+ZXmCwzmsa0qNmPzhdio6jbD8ecEgew48OqqITxRNfO4lcrazTd4UBIht5fVkiCTIwnH7rNiJP4ZDw9n/kr/6+7lXQG2q/vjR/9TELez0wqSAjpItoerIblnXhhXD4SdcpfZNkSQ/JpF6NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760052644; c=relaxed/simple;
	bh=ivnI95/4wH2sE/60lYNix0grZ+S99Kw1ZPGOz1sP24k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5Wj2N6N0/N2QqY9ifYtoNN327Oy6H3dqMPsEzGMT/gQ2NSZ46OQC/LY5VDbM9NcvoI8U52nAev1LvJkWzswwloT/TfRLDW1TRDZZJi0ln8Mb2wZUOx0xryUTVYk0XGSNnuQ5WsegXFlADue+fcQu504CSpvzRiIhggFyUVrdes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QdDBoi3Q; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62faa04afd9so2680a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 16:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760052640; x=1760657440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivnI95/4wH2sE/60lYNix0grZ+S99Kw1ZPGOz1sP24k=;
        b=QdDBoi3QsyiVc4X4yt1Fo4RAionuYP3ST1YBUwKAIJi3s7zCdZFZ9yV/oxoABBWZEy
         WQRN3wmZfgex/tpKAXiPrTBoGzIbdYTAK+BKKxiQBAXSvDOwtod3TOIA34XipddUIuR6
         iRzyFWWujWW6tibq2Pd6A8tuAF/VjlZ0WdWZgCz2V2n5NiNPMpdU0pvdr7or9DW0ZT7j
         tBDfwD7JcSDNAL0LE9Hbl2ePOxNJjU2ImxITUiD0H9lafoHnRmjSiMFMCXLL+6G6iTk7
         eW2frtiAaBv4ZGbY3q4VWuREOEYr4Tt0MgLM09550pAchfXrJR+wyH2zrVaGAZFIKfzD
         vf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760052640; x=1760657440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivnI95/4wH2sE/60lYNix0grZ+S99Kw1ZPGOz1sP24k=;
        b=fGLTTywAU5Q9ZS9uhitw57POM7+aPIeInGtbeBlebM/sI0kgE94qV5oMNvWLsJJX5O
         43HN7esspVJCFz56XoS4pj2mYeL5ndBmi/X3Vaql9zc+jfY9SkkhEM4EycyFT7jgWUHV
         zxDR5IsyTK1nbhZgh1v5FxrtxTZjNzIzASwFtpIq+rL88mUPJdSLsby8RjbZY9Piylu5
         lxS7k00rFzWNyaER4+cDRzLzlY7mBtC3Fa4oJrpPk0dEE2vBGEACORgrpoDB3HrUP2bU
         w3Lmj8AGa0QoabsEl6lhWDIi+QGcD7cbpVncUuu6gXM1Q1raqxLM0Ptj+OOgkrrrBmHY
         nfVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXbjalN5MTP3+Pu6QxkDQmP37/LVqwoggoB+kMLreuN7oBs5ECseqPRNnJeMA535zaLr4hqRx06M5dd/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZa8/TjFVSxAASeQKq89tVAVUeA/KwDqE3GCYoD2to8gT+a5RX
	alFfkLU3gCYvFrw4qm2Le+isaAMPeHOo3hJ+vNsNxbWYabzYNusMmYCLcOwx2wJ6/3VzEn2CN01
	Ru9okPs6TjCJo1acY3AGNFVLdhqfpMe+7m4xzZS48
X-Gm-Gg: ASbGnct0U56VDh+6a+id9KCICFlY5JUakiwjzNUbnkPUdvMNS48i6Yc6OTDye03d7I4
	ujjtup0205jf3g4lvGAUMfOlVb9UAko5PlXnc2Wj1JAF0Z/vP/I5cu74xRJ9ppraoYuNvF9el+G
	oYEdVaq0PT7vOI3FfZJgrqBslnqCGMyXoGUtMXg33ory6heAlArePKQHmprEjibdxTNobN5BKyd
	HYoqYaXXGa2xURqVjSrVWQ/BJW1SK5gs9CPipo0BeqeJs7K
X-Google-Smtp-Source: AGHT+IEOTBj54UYI9jTz3gxGnclJ1kayNjmHI406lzTf1JgANvppGkPbXbIA+gJ6Kl3ZFbRXnOZW0vEKxs1YBObXV70=
X-Received: by 2002:aa7:c354:0:b0:62f:9d69:9364 with SMTP id
 4fb4d7f45d1cf-639d52c2a3cmr318785a12.5.1760052639765; Thu, 09 Oct 2025
 16:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001145816.1414855-1-yosry.ahmed@linux.dev> <20251001145816.1414855-8-yosry.ahmed@linux.dev>
In-Reply-To: <20251001145816.1414855-8-yosry.ahmed@linux.dev>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 9 Oct 2025 16:30:26 -0700
X-Gm-Features: AS18NWAx8ShaL3lmvgtqy19Ov8ozeGmr75Qa4-GnxpsoU7OynbrKVwVC3OfQ5OQ
Message-ID: <CALMp9eShyXSx685qTqY_ADEk9O8Mk3btLPPE4-WYPxwghHbQPg@mail.gmail.com>
Subject: Re: [PATCH 07/12] KVM: selftests: Pass the root HVA directly to
 nested mapping functions
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:05=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev> =
wrote:
>
> From: Yosry Ahmed <yosryahmed@google.com>
>
> The nested mapping functions used to create EPT mappings currently
> accept a struct vmx_pages argument, only to get the EPT root from it
> later. In preparation for generalizing these functions to work for NPTs,
> pass the EPT root HVA directly instead.
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Reviewed-by: Jim Mattson <jmattson@google.com>

