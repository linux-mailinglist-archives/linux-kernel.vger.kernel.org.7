Return-Path: <linux-kernel+bounces-802125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4FFB44DD8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC071B27860
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7163D13AA2D;
	Fri,  5 Sep 2025 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WCewLAdo"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933FF2874EA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 06:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757052915; cv=none; b=KkuLNC59108Y1qbq7DO1G2+oObLjjTrzhJLwCpUc3EZ+4XupfevjNfkzL5wpYMfa2bUCdhHyawG1W4M41Wq0LOXGyIz7hMOw82HB7xN6mqSYgGyHPCfz60t/znzdVEhC2Vwv+NoKFpb/OQCWFmIXO0a4tx9lX9p1DTSBJgu/JSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757052915; c=relaxed/simple;
	bh=4QB78LNQwxKAsA68SulDE/sw/iH3uDbwsF2AQjDBOCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBn+NvYiZrKKvTyGvLsFAQ0taqYArS2Y2MRzhijSawE8+NBXx0VQ/hRwYO+CimVV++tvj4C6ezUYlz25s1EQt7pGJa0K4FVkW6hUaK/fQkHsTQVnyrHAN1q728vFU/iCNkrC35gV1zuNPnzwnmk3uuOxrhT/CXo688SwxVyMLLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WCewLAdo; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6216e9bdda5so55298a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 23:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1757052912; x=1757657712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67Fan9f0fhfdCk8yqG4XmOKNFNUAhVKb3cVNbIqGl/s=;
        b=WCewLAdoKtdo8jkGFbffWFrZVuD9nvvpv6EPBWGIrbZwEUUWtItcvNcQoYoaszr4PW
         y4Ajw2DZSXyGk9schrUGWnCguNtZQtN1dG7XbbcPJZ9bQ3O4VCeN9fjFcs3Z3zs/a828
         OR7sHZAUQlRZ/CbaPvFsjDiKUBjIt+MHCW6nDu/ZRZrA5JDsIMQfqw89/bFpupSTMTDZ
         QpO7dkLYfykfvD7j3J08M1LWT9FlZZ+/Zp0PNfCOYFSi576Z+970F4Thxi8F4fMMcpOk
         4WVSkGmKZztk8QAvnBqQuNd/Wc0qXrZdxSRlKGXeYKHtsHDgxfqWkxj3lnNuo7vGUxiK
         CS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757052912; x=1757657712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67Fan9f0fhfdCk8yqG4XmOKNFNUAhVKb3cVNbIqGl/s=;
        b=bJYyfTlPxSBlHnenX8VsjBa2nlT25FqGGpbUHHwU0Nt3O5seUS3eK+tZyiN3yl3NYL
         QO6t2TmCM7iKiGNU0ueJX+FAFJDcFxy8XXa2N6+f8Qnq8x9FczbWroB9Mm8b6x2XBr4p
         uNnTc83sO82ZgUMotH8T+tIw53DyKawqjdB0FMImVGUFBRjsf+7d/FsqXIdl78xg1SqP
         m3+kHciHFC9aY6529L/SpNYtSgqzUrVQcLomPCPsRFS6x/lPxxbdtG9Ihi/nnT6+kkkA
         7QuZoFSL2dNfPi0QUp0wkaWQdizJX4ihb2xnIy9Tk8dWpcSTYpg5thgy9KEfOfyfmZkc
         FWdw==
X-Forwarded-Encrypted: i=1; AJvYcCVzhNg9N5QiUV9LkxL8I4gYI/iguuSKoWFoq7NMtyxyK8/spRPD/wRCiDbOXRCvtRs0FG+meR93j453sqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykANr47TUpdrXfHj0FsmDnhdrujZURZEmOhhsyVZDQpZb0MFWs
	KTLxhO1MmEgudM2ozKhoLlGc0oWTCign/XbmcEuWNkiMWkcO3qmj5c8ob07l5tMp3vKBHN2OO4Y
	0sTtlh0lxSIagSkYkAulVbojYnZPDxx5pZGswkada5A==
X-Gm-Gg: ASbGncu7QiAhvbL2v7BcwpsiXkrpGkAobfQG+86qY3csByA15Pw/NqCKMrUyggrX1U8
	YJ7NpIj37zCbQQ4Pr9CDDpMB98DaIYWpDSdqWDFgTylM8ZOGQ2euHrIIgU8/Wctrp9426CnFMMM
	s4ZLXs+5cwtOzTvUPOS3NwxcdX1DYtgatbzbrzJ0HDVUxiHCOSNXG/r+Fmve4/JEVCBlE4ijmi+
	jbz0xTD
X-Google-Smtp-Source: AGHT+IGQxtNMXZdvajLZ7J8QVJRCMBGrRVcTSOlLx1yX827VXeUjk0Y0uoYjfJG3Qk/GwD1+mtNnIEotbRORPtK5gAk=
X-Received: by 2002:a05:6402:430b:b0:620:bf3a:f6dc with SMTP id
 4fb4d7f45d1cf-620bf3afabamr1472744a12.4.1757052911908; Thu, 04 Sep 2025
 23:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aLmoE8CznVPres5r@kspp>
In-Reply-To: <aLmoE8CznVPres5r@kspp>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Fri, 5 Sep 2025 08:15:02 +0200
X-Gm-Features: Ac12FXzLRYvr9qxSpOLdM_cu9n8ZpiBkps4v2s9lawoV77lRbVRWUjzUv-Bi5yo
Message-ID: <CAMGffE=4KUt2y_-C32YaVtJVFiyU+1T=gnu1D0m+MxXs=X05kQ@mail.gmail.com>
Subject: Re: [PATCH v2][next] scsi: pm80xx: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 4:54=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Remove unused field residual_count in a couple of structures,
> and with this, fix the following -Wflex-array-member-not-at-end
> warnings:
>
> drivers/scsi/pm8001/pm8001_hwi.h:342:33: warning: structure containing a =
flexible array member is not at the end of another structure [-Wflex-array-=
member-not-at-end]
> drivers/scsi/pm8001/pm80xx_hwi.h:561:32: warning: structure containing a =
flexible array member is not at the end of another structure [-Wflex-array-=
member-not-at-end]
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
oh, indeed, v1 is wrong, and v2 is right fix.
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
> Changes in v2:
>  - Remove unused field residual_count. (James)
>
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/aLiMoNzLs1_bu4eJ@kspp/
>
>  drivers/scsi/pm8001/pm8001_hwi.h | 3 ++-
>  drivers/scsi/pm8001/pm80xx_hwi.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.h b/drivers/scsi/pm8001/pm800=
1_hwi.h
> index fc2127dcb58d..170853dbf952 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.h
> +++ b/drivers/scsi/pm8001/pm8001_hwi.h
> @@ -339,8 +339,9 @@ struct ssp_completion_resp {
>         __le32  status;
>         __le32  param;
>         __le32  ssptag_rescv_rescpad;
> +
> +       /* Must be last --ends in a flexible-array member. */
>         struct ssp_response_iu  ssp_resp_iu;
> -       __le32  residual_count;
>  } __attribute__((packed, aligned(4)));
>
>
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80x=
x_hwi.h
> index eb8fd37b2066..b13d42701b1b 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.h
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.h
> @@ -558,8 +558,9 @@ struct ssp_completion_resp {
>         __le32  status;
>         __le32  param;
>         __le32  ssptag_rescv_rescpad;
> +
> +       /* Must be last --ends in a flexible-array member. */
>         struct ssp_response_iu ssp_resp_iu;
> -       __le32  residual_count;
>  } __attribute__((packed, aligned(4)));
>
>  #define SSP_RESCV_BIT  0x00010000
> --
> 2.43.0
>

