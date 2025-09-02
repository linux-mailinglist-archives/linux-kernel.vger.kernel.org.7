Return-Path: <linux-kernel+bounces-796596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B151FB40310
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5201889A9A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C24F307AC2;
	Tue,  2 Sep 2025 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/hrDcoM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F1E2DEA84
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819436; cv=none; b=Axy4YVlZ+K3YJIrhloHc1D6QeTMZjJB7VNP4JvBob1duyC2rYslXkRspUxgYVDi3tohC0/7pw8oGAahW5svoIZFZbEKzYlJocMPyxJAcruA7+aSXpZU4BvhJIjKdWH3ReUz330HfcFc5LO2Mv7Sulpx74Oh4rOwZKuipzhpTkzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819436; c=relaxed/simple;
	bh=BghHx78w2eBm04dY0udjEHAdDP4+MGpJR2iCDFB3B8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioZXsv45geV0qBfmBScgm8zFlONlVuduQZ8i6D/VCVn/DFw5VBegQosDN1B7KK3aajR3Uyouk1SXtlMLuz8p511H1PzUKOtdbtXpe7r7+Q9mZIO8NtOCCd1wWuDK6iDUluSUQj6xMXPURnoBTaUBtCfSKveyGFO00nYWEIWeySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/hrDcoM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756819433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=keYWhxw77DCnP4ATStvL7xyBqHqD8YMxeUpPHYlowhs=;
	b=A/hrDcoMclDVwjiJ2aNtAMzglDIhvpqr5hUBYSmo5UE9+xuXdM5BqOM0sU/xKgAGKvpdKR
	0pf450DFJd8UF+u0cTQSfNfdYXUSKMZ8e36ZKxCvJIttl4rO5INTeiUekYhQlZvEDSYGoQ
	pHS/nKFg/gGjWer0XOdcd+ZmySsbGD0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-ydh0_ZMZPwCzCt9N3x0EOw-1; Tue, 02 Sep 2025 09:23:50 -0400
X-MC-Unique: ydh0_ZMZPwCzCt9N3x0EOw-1
X-Mimecast-MFC-AGG-ID: ydh0_ZMZPwCzCt9N3x0EOw_1756819429
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-336c4c73e44so15310391fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756819429; x=1757424229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keYWhxw77DCnP4ATStvL7xyBqHqD8YMxeUpPHYlowhs=;
        b=PMd66j/yo5jq+OTawlsTT3Qe+3wzwka2RTWbM7GpBeGQQd7hfmFhLoBSrPzv+4IEjG
         iEWZaIcne5Nrj/pfOJX1UFoJUzcOEcE9ESBgvyfa8id3C19AiSsZFGdF+a9HI0cjNXTW
         xjr/sEseoUt0NTvea4mo7+wnVV0amCKLj1FXNhqxsZX8fI1OJE+nN2WP1vkZkOx8i7nl
         klCrYM4XCOK1pS0+UH2Zi64nDOqdgL02XSon2sexA/1sFKik2W9CRouBiU311fUUySaX
         eLPwS+npaN6wGforsZHP2UkEYiYHxPHh6dy5esinnYDMCOltnwU+gr+bUjG0uFGA5dut
         +jbw==
X-Forwarded-Encrypted: i=1; AJvYcCXF8uO3Q9PDjfe4ZyEFnysOTA5wzutoiQXY2Pkl/v0oMCdmKX4lnKf9u6+vVLhkAWLqlPOhwwKr3QTU0LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSyS/wyzSDKhtKjo5ev2NNto+lM6232Z10qdnekCWY/C9qbRZk
	TEJzr3W9zb++SHgoNqEzjRpqzSesXxMn3g86r6MBXSqGQb6Le4sWwKrPpX06SBQ/SbvHjlqivCV
	dxlMmvFZCf/u6xT4IcawGZG3V5+r87Xr0J4Mph93tjHHlaT+wCbYgE+VtvMOBczlqT0THNA/XI/
	IZLLfMybnYY0bycrakJCOl5ti6v/2DGCfRikylcoT5fS5+5rIuL9/LXw==
X-Gm-Gg: ASbGncv8FBx8wqPG+wEj/854C3eT+BG/ecZnrj7ZUVi/8rTavIBio48MNAig7JAC2OL
	hYb3g+8vEo5CNTyvkMTA71ggUIwyxDj4QUPkjDG0b58dDEtAAb1kn1IwgDskSubg+yp5RXsi+rj
	waqCGHCbjel9ymvjsvAA389g==
X-Received: by 2002:a2e:bea4:0:b0:333:fff0:7d21 with SMTP id 38308e7fff4ca-336ca95a342mr33887691fa.10.1756819427050;
        Tue, 02 Sep 2025 06:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcT7cPp+UnG7lIIOV9SxTwhQbXg1xHDcH9jqEMVEqMlEpkDwbCfgUCeDPbwb5bGfUErqCVNlbgtYOIHwmTOzo=
X-Received: by 2002:a2e:bea4:0:b0:333:fff0:7d21 with SMTP id
 38308e7fff4ca-336ca95a342mr33887401fa.10.1756819425084; Tue, 02 Sep 2025
 06:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901-nvme-fc-fix-leaks-v1-1-3ae0aa88d5e5@kernel.org>
In-Reply-To: <20250901-nvme-fc-fix-leaks-v1-1-3ae0aa88d5e5@kernel.org>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 2 Sep 2025 21:23:32 +0800
X-Gm-Features: Ac12FXzr_vFxaGgXnCYVDwNxKYkvmNxqEe2JJkAWFfqshFoTKnLq5QQfPxa6IvI
Message-ID: <CAHj4cs-7v_=LD5oKSGimH1_vKp0T5tmemqsMoAw+ZZGTMP9k9g@mail.gmail.com>
Subject: Re: [PATCH] nvmet-fcloop: call done callback even when remote port is gone
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 11:58=E2=80=AFPM Daniel Wagner <wagi@kernel.org> wro=
te:
>
> When the target port is gone, it's not possible to access any of the
> request resources. The function should just silently drop the response.
> The comment is misleading in this regard.
>
> Though it's still necessary to call the driver via the ->done callback
> so the driver is able to release all resources.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs-OBA0WMt5f7R0dz+rR4HcEz19YLhny=
Gsj-MRV3jWDsPg@mail.gmail.com/
> Fixes: 84eedced1c5b ("nvmet-fcloop: drop response if targetport is gone")
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  drivers/nvme/target/fcloop.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>

Verified the kmemleak issue fixed with this patch:

Tested-by: Yi Zhang <yi.zhang@redhat.com>

> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 257b497d515a892a39da82d2f96b3fa3c6e10cdd..5dffcc5becae86c79ef75a123=
647566b2dfc21f6 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -496,13 +496,15 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *lo=
calport,
>         if (!targetport) {
>                 /*
>                  * The target port is gone. The target doesn't expect any
> -                * response anymore and the ->done call is not valid
> -                * because the resources have been freed by
> -                * nvmet_fc_free_pending_reqs.
> +                * response anymore and thus lsreq can't be accessed anym=
ore.
>                  *
>                  * We end up here from delete association exchange:
>                  * nvmet_fc_xmt_disconnect_assoc sends an async request.
> +                *
> +                * Return success because this is what LLDDs do; silently
> +                * drop the response.
>                  */
> +               lsrsp->done(lsrsp);
>                 kmem_cache_free(lsreq_cache, tls_req);
>                 return 0;
>         }
>
> ---
> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
> change-id: 20250901-nvme-fc-fix-leaks-4a25ca3875ab
>
> Best regards,
> --
> Daniel Wagner <wagi@kernel.org>
>


--=20
Best Regards,
  Yi Zhang


