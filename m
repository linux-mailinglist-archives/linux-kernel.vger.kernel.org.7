Return-Path: <linux-kernel+bounces-840395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 204ADBB4495
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6813A45BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB8E18DF80;
	Thu,  2 Oct 2025 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6O3BzEL"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8A418A6A5
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418093; cv=none; b=PHitaBJtFJE2jUJ4DHaBQlMD6Ik0omAY4Oyzn/TnpAurIqTzZifMN9amCwxyu17TfHNGUh/0SjxKM9xUPpLGBd7SKsXhgp/E1H1Ynhi/9zsyDY1j+sq5Oy+DAUucd8ius+YMDiuNAjoCsThhD/3az7lDNOtNuvc81Lvwq086ivU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418093; c=relaxed/simple;
	bh=PduUZoikr8LnqAZaTzWf0aljgdXphuwsyDaOnjpUC5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4xpFeBZTRT4mdjVH+Z7UkV+ry5UTCtsffsudIu9tbJc6BljGSGl+yBvLFYqfZrTz7ZNwOCFP2A+/un2tpbD/zhjGgZHMRjs8h/ocsLC8V3tBJGZK6MM8JHB6C2CqeMVNvMv2jDj6AFyrgFXsGulPEYdkGk6RiD+hrpAy9Dgpxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6O3BzEL; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-78f75b0a058so12171906d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759418090; x=1760022890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PduUZoikr8LnqAZaTzWf0aljgdXphuwsyDaOnjpUC5o=;
        b=X6O3BzEL7gA/laF1um/c7axpZUmmp+wVsQtWPa5nsLsmmCwh1m4ALhXJmbA8+cblby
         4888/pG1pDgUXY6e1NDvYWhRNUTqpfnL6To5Z26rQA6eFoTCWig83HXDoEEDDkTui+/z
         LAiQOwG03S2ABLV2rCOtpa88UKRCEWjt1Q4ul2crynEhj04Jde3PSiOp2CNt8gsgEzin
         gLI3Wumy0R/qEo04RYJkl8D3jNWhZZQXQubCv0L9U9oZyZaf4EDH+2JH+ah/Bk9GKM2A
         Xw7HZVJbyoIktiuZVKII2Hjrn0EiTDj8d50jKWdfMIQ85LY8aj52PNPHYpVpExMPrl0V
         TXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759418090; x=1760022890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PduUZoikr8LnqAZaTzWf0aljgdXphuwsyDaOnjpUC5o=;
        b=XAi5VHTLpcg4EixKm40J5bIVhjd1rOlqwsVBGxyxotQq3HM2uWKpZwIVt8ZF7obeyx
         dp7bZLBmK08zrSy+AnTiEyRwQm6PtUqdGlW97SQBlawxMlezluFZeSkVUUKY33Bh3grD
         X628Qcb9Zs4S2MWLSeXbbB7bJoGXPSKPL7CdF8n1KK/DRJYu5mZ1ckftjTd+3OEmRuRK
         1XFEya2lVmXt60G1EpIEkuWXdaR+hkVuA/u+TbHsLmRoV0r+3d41D5L0a5BoZQu00QgV
         /L3XC4CH8yC9rFimnqpfdDxj7n6GsNOqY6D/PdjjVrVGI7AYKlt+yMyKQ0/aYN0I3j6g
         oU7A==
X-Forwarded-Encrypted: i=1; AJvYcCUTqZ17pw4BXJ2cNUhV/zwQ5VZzYd6hW6DedA5ObopqvHUM5D6Fa1bhFabYYelcHO6hTQSgCSLu8HkusNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbCKJ2R4x/sg+H1vDvA07T5pMS8XQklwg46qJxwmpVVQYuQrjL
	zICUjcppLBHGi5MSHGWJ9V6ZlwKTXzoAUzVicKWJD/cAFj84X9G6a5aKAaOg5SYNl8O3Bmwq+P3
	UcBbuPLuMf/94LRDaxFi05YAkmUF7FfQ=
X-Gm-Gg: ASbGnctPzpNtlMEEWFu+4VXXbFF9WARczN/M3qe7SorDzk6B5lZt61saNksFAf0WFkB
	YX45dGiDgdVdwZshbAIekKBALrSZpgnMPwBLxO4Dy1jgy2Bde0Vv74kOI4zhF4mVbOIQpfC/Exm
	4SeCn/ccUzTgH7Sai7YDLpUs+WAgsauDQxpIWg8xqa7vXQXv2tM54mD00+wXESnkGbHxZsbcwdJ
	4y2GXhaD+3+D3IN6rHQrIsqraeObEnAFIiU4o9QTyedaZ21bgEWxQxAq2hc6RT7W0C/Xw8EX3lo
	JIIymBEmZfUFrh6c5FZSvr4bVv/X6LoiOeg/bIgratIrRzYxIx9Xe1cB4zmKxtlEeMJgJ/UxeB5
	qaeEqBXU1Tw==
X-Google-Smtp-Source: AGHT+IGyfzn10GjCw6AbrHIRNFIF7sVwOU2PmWXcEbIdO80lNgoAtt7bNshbrMBB5VQ0QLFvb0YDQlUlMexok3l/HTg=
X-Received: by 2002:a0c:f088:0:20b0:786:d65c:1c3e with SMTP id
 6a1803df08f44-873a06edb4dmr97474656d6.30.1759418089626; Thu, 02 Oct 2025
 08:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7f956b3b-853b-4150-b2e0-ccd430adf9ac@web.de> <a9518620-29cf-4994-a9f4-a6f862d8c214@samba.org>
In-Reply-To: <a9518620-29cf-4994-a9f4-a6f862d8c214@samba.org>
From: Steve French <smfrench@gmail.com>
Date: Thu, 2 Oct 2025 10:14:37 -0500
X-Gm-Features: AS18NWDp3jCCqFOTgwnnq5szZSBZZh9XBeoSBG6yvmFg9Zc70t7XgYEAJdiinjo
Message-ID: <CAH2r5muh7GCAdNmiF4YjJrP5p9wVeU+OLC_41um2_Yr9G8mhnQ@mail.gmail.com>
Subject: Re: [PATCH] smb: server: Use common error handling code in smb_direct_rdma_xmit()
To: Stefan Metzmacher <metze@samba.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-cifs@vger.kernel.org, 
	Hyunchul Lee <hyc.lee@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Added to ksmbd-for-next

On Thu, Oct 2, 2025 at 7:31=E2=80=AFAM Stefan Metzmacher <metze@samba.org> =
wrote:
>
> Hi Markus,
>
> > Add two jump targets so that a bit of exception handling can be better
> > reused at the end of this function implementation.
> >
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>
> Reviewed-by: Stefan Metzmacher <metze@samba.org>
>
> I'll add this to my for-6.19/fs-smb branch and rebase on top
> of it as this function will move to another file there.
>
> Namjae, Steve: this can also be pushed to 6.18 if you want.
>
> Thanks!
> metze
>


--=20
Thanks,

Steve

