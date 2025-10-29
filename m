Return-Path: <linux-kernel+bounces-875843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5393DC19F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 660F44F4029
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA28334C02;
	Wed, 29 Oct 2025 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYBDleOX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3A331A7E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736375; cv=none; b=rKmMPOSXWxOtq6+T/l86c3eoCmYsptDL4wBUWVYovsdYmV04OAHVvk4BFHzhRmzsPSWez8wrGgtj1fqx82j9um/vInAfdZavoZPAr2aOp3veKFOigG0ij7Zkp99E+U6fKKQ+vg4Qt7FtQXhQJnRG3jBvvceTjpmrX9bTO7xKOtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736375; c=relaxed/simple;
	bh=txYqixNO6O28xR4452cP0BY2EHTTPB9PgBzEP6ff4y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/koVpUcoji5/92dRZptqGPsRQd6yGA8T07sU54pNEkIsZiYYL5Sa3AjcfmA7ywFWyQEkc3R3HXpfPaTLRI4xz3MO/8YnK3KdR0UGI28/4PVvW+BvBQ1ONOa2fhhgy4xvvFd/8D/UAgqD8n+RLFF/yMIcRoaPrKKi243curGkL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYBDleOX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761736372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcF2lGOd9L3XLehT3KxyGHuSIDfXwNtuZ/zp8nK6cv4=;
	b=cYBDleOXKL28jKvPEDwRiDdJhnPDQD7hXwU9z/5qoqf2gyHPpK5wXdT/xe91IBTVgReUAU
	quGltkfkvABRICjzSfwD+RYziodM3ZYtQ8X8Ojgw6SG+IqEpbBewp4svUm9ouNYWov6ap7
	cT6fLbswgBj46o2abtqR89shVq9s2gs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-G9yF6c-FN6KjwWCh1qR6lw-1; Wed, 29 Oct 2025 07:12:50 -0400
X-MC-Unique: G9yF6c-FN6KjwWCh1qR6lw-1
X-Mimecast-MFC-AGG-ID: G9yF6c-FN6KjwWCh1qR6lw_1761736369
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b6d5f61877eso497170666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761736369; x=1762341169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcF2lGOd9L3XLehT3KxyGHuSIDfXwNtuZ/zp8nK6cv4=;
        b=eedAl06VPygIUvEl5vcNb61k7e4Rwwt1H1QnT0DjkgbvYCyU5rsHCM5T26QMMyqOhx
         cDi2OSsyNK7CDanIVf9kvnlvir8t0cRX/eZPi+6onXDhYnAa1KpErQ7viLKWEQmiEFBH
         VHKEB1MX6QYLbTdgtmqRd6wGX0yfKrtaqXMdTHGI9f3WoIavTJJXxV7HXrvq+MKCl9aA
         11c9gWensscFaHUgyKiJGO7wcC3jnG2GgkwKkpYY6Le/QXlVspxTBFT39FZl87ujh39g
         9+dDw7SLAVseWUCDieiQ460zr+g7GykpjrwmScn4zgIg6ROKsQJbDFDjgDORnc+ua8pp
         8fwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlfJ11lzCqXbMHDAJ3An/41TxsSbs+1x1gLfOZYNvOUqjnerEDwx3D1Wvl03q/Ad8jMDhUyhGkZpX0N8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ctL4IxRI/4pxw+nuiH+Zzu2LOY4xBN1S48fJ1EwM2ZRiNH5h
	X6GAIzHN4KCKFAy5KD5xTls0QcehfQBtBkabn69cncKkizNJaDmTtA22ugQ8S7M2ePSeZogdm9H
	JVvfWP0oVaUPivoziJHnfxO2cUBFNCjPrvK8KtkrALr99021Ag9J7nR98dqtqurr5U1wPSxrdPK
	4f6kWzKuCCwmUVoJNrTxvLXzfLSQsiLMn2MFhjBKUb
X-Gm-Gg: ASbGncs14AgLSJOqsHy6p4zVzxrIO14pphaPvzxra053r7Ij9V5OrO4fZVBOtS4bvlp
	/WO2Kky8u9eCvOt97zrJ8vySWiCoixydClPqHHjwyKfb2aizMttLYi7Ro33HzW/gfRqgd3GuVJA
	Xf7SJdXUTeH7fIVPn0Cnl0r5/c0K5wXiFsxferFIl/Th1bvwMIj0TmR3eObX4stOLhhVgmr7Gm6
	cBpMVr8tXmcQw==
X-Received: by 2002:a17:907:7f8e:b0:b6d:5c52:638d with SMTP id a640c23a62f3a-b703d2ccb05mr206470166b.6.1761736369391;
        Wed, 29 Oct 2025 04:12:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ4TUvAVJAh6t7ae1chMAhVBwMYOsQISU+eVER7/+hsriMK5kCCdBk10LppB1XbmdsZmpRLLCeisbkxubg9E4=
X-Received: by 2002:a17:907:7f8e:b0:b6d:5c52:638d with SMTP id
 a640c23a62f3a-b703d2ccb05mr206468966b.6.1761736369045; Wed, 29 Oct 2025
 04:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002123553.389467-1-costa.shul@redhat.com> <20251002123553.389467-2-costa.shul@redhat.com>
In-Reply-To: <20251002123553.389467-2-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 29 Oct 2025 12:12:38 +0100
X-Gm-Features: AWmQ_bkp5cNRfZSU0z7x09yirtzGsD82ZgctqjzDcm70-9HfXgEx10dvOZAk1ts
Message-ID: <CAP4=nvRN1Svi5UxN=FxSSFH6JaKTy_nUcz0ARzbaY3-9HSh44A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] tools/rtla: Remove unused optional option_index
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Eder Zulian <ezulian@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 2. 10. 2025 v 14:36 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> The longindex argument of getopt_long() is optional
> and tied to the unused local variable option_index.
>
> Remove it to shorten the four longest functions
> and make the code neater.
>

Yes, this is documented in the manpage:

"If longindex is not NULL, it points to a variable which is set to the
index of the long option relative to longopts."

> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise_hist.c  | 5 +----
>  tools/tracing/rtla/src/osnoise_top.c   | 5 +----
>  tools/tracing/rtla/src/timerlat_hist.c | 5 +----
>  tools/tracing/rtla/src/timerlat_top.c  | 5 +----
>  4 files changed, 4 insertions(+), 16 deletions(-)
>

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas


