Return-Path: <linux-kernel+bounces-763599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249EAB21742
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496CA7B60F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE24A2E336F;
	Mon, 11 Aug 2025 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFUAn3t1"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB102D9EC4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947389; cv=none; b=ZaoXSM1bhqFoUoRig+KcMe76Ff47nLZ69ck8bT0whDi7uSVB10xppcyb7wqh/YQassfZ4IRCUcbMKVukAlUheV4CtLOkVS9hz/Yr2dkS6gj+slGIy1RZpvgYEk9SUVBeH/nxZJxF64J6fbnUUKbWrfxYuIbRCPC6RfLdhG8BAZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947389; c=relaxed/simple;
	bh=4nxY/HUaLkGg/Sja8DVECdqZSiZ9DW57Q30+/BRaPw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zjz+fWp1jR+LrL5IE7inZgB0v+sEi+29d/LtFecmVpTjqieXW4o7j6C/tsW3JKwbf7yOOi2cAucIyDG0hRQ3uRkaQsJIejNHlG+daysIH+aThQCFsFlg9H6D+QBi1gbs8CfLXOLHCV54V0bfyntx5r4YhwcM/iBGGEqO6WuQMGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OFUAn3t1; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5006f7e71aeso1577779137.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754947386; x=1755552186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZdqMxmyzBB1OkAkLeaTzK+1PBVEWeH6ndA/ynyWuPQ=;
        b=OFUAn3t1S1zKIFx4qHEwE9Ag2O5b+ma3NLtTkbATvGEY449xoHtkzkuoQ465EhV5Rc
         noGCnONEUwzwzJ02fA40MkwokYLjHhLREjXy40HNSjnB8Vgi9Z4sA6Pe5ZtQwl+THnRz
         iWJOon2c8wztDaa/QvPqHKNtjd1Sh9AxKXg49caK5Tt9cVT2NfixBGGkolAR2Q+iiHPg
         WeDw+O1XACy7RJSQ9ullIndxjF+3Qq3DTa/pOLLY5YTSh9Q7mv08LodAh4vNf1rdKsVD
         AR29qbBiyP/fWTW2mlfwdLCpnRTiHekVHSwm14StJdzVkhZwcertomCQcTX0yFAvz2BW
         v+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754947386; x=1755552186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZdqMxmyzBB1OkAkLeaTzK+1PBVEWeH6ndA/ynyWuPQ=;
        b=GeChtPLfsuDeLG49JYA1S1UXG+YdQRwbLtv0MfthTFWLn1XBP21//HwIWNpBb3gh+p
         jXpYeBr/Wq+UfJOXCrXK0Lzsua7+WGSKjaqgxf0uztAJs/BRqBw247FyglFC9QRgb1HX
         qMqRsYcU0yzvW8XT5BklTJ/pfhjvBTZjMjCZhhnWEdx4bFkeXU04cYlmLFvRPGL8YQ/C
         8wYq2wvljwV2ur3DlMktkIYUqrdcadrXHH04ipzPb5cT2xjp+svkc2O/x/4R6IcEadS9
         SlNPs9cfF/BqrUs7SB10HR1Wy48ekBHgBPXL+wN+gZFGsAW6ger5S1+OJ7gWlvcPSd1l
         C2+w==
X-Forwarded-Encrypted: i=1; AJvYcCVcRAcGuEV5I/xgOhTa9e8PH+MxTu+imT1r85DWf1SSX9cvKTtagXfBKLGMJ8BaHJHTfKfdPcN9r3ZNIBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBL7+GhSRxhhHSN44h38mGSZeN1t8z7UlDhvkb2bs7Es/cBppX
	TbFN18oaDBjNBJPVjd+gVGNMiN92x6YVY19F5sJq8+chh7Q++Cv5h/8Oo8q0nqJ/75W0+PggH4H
	ZhSzMLzdrW1tLkNS4U04nTCkD58dzyiyZK6Ok591d
X-Gm-Gg: ASbGncu51ANgqAU7MU4f3o0x+UhSVMMPOsRFcrJF+nNdOH9QdguxHY3J1yvIl1AK55/
	d6DhBCnSqxLb9SjDnDEKKYcKCUpSro91Er2TT6T0I38Ai5GTofJQf0qVdGKsvjF1bec26tHmj+/
	6WsXs7v6Z/Q2LUxr2IFJIN2BJQlbUHgX93YCgY4FB+jsVoIeffcKqU2/ZHMDpLncYvMeyIz46if
	iwzkJIV8rbFkfevzp9fUmCYVLorQuUi+oOaZT/ikKPBTn0=
X-Google-Smtp-Source: AGHT+IHNSP3vbp+tuQbd49qGq2dEhZY6RoOdr6qnUgW6nP39Oelsmfq5rhveK1FlrfgOdmZxbuKZm8fey7RqOl3kwf0=
X-Received: by 2002:a05:6102:54a8:b0:4c5:1c2e:79f5 with SMTP id
 ada2fe7eead31-5060eae4ee5mr5032632137.16.1754947386206; Mon, 11 Aug 2025
 14:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723183543.1443301-1-frankramirez@google.com> <yq1y0rx9odi.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1y0rx9odi.fsf@ca-mkp.ca.oracle.com>
From: Francisco Gutierrez Ramirez <frankramirez@google.com>
Date: Mon, 11 Aug 2025 14:22:30 -0700
X-Gm-Features: Ac12FXwXtPlgcqTGdIdExolDfW9JzJwF7lUfU4iCVvyT-kj1KM02fwvKMuSS9o4
Message-ID: <CANxonXNtbo5UoaT0cvdZxAHo2jnmoQn7bzaZ2dk7_=Pf=M6LPA@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm80xx: Fix race condition caused by static variables
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jerry.Wong@microchip.com, vishakhavc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin,

Thanks very much for taking the time to review my patch and for your feedba=
ck.

I'm writing to provide a bit more context for the design. The function
in question needs to be called repeatedly, and the struct helps to
track state across those calls without using static variables, instead
tying the state to the specific controller instance. This ensures the
function is thread-safe.

Please let me know if that context clarifies my approach, or if you
have an alternative suggestion for managing state safely in this
scenario.

Thanks again for your help.

Best regards,
Francisco Gutierrez


On Tue, Aug 5, 2025 at 7:30=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Francisco,
>
> > -     for (; start < end; start++)
> > -             str +=3D sprintf(str, "%08x ", *(temp+start));
> > -     count++;
>
> > +     for (; pm8001_ha->iop_log_start < pm8001_ha->iop_log_end; pm8001_=
ha->iop_log_start++)
> > +             str +=3D sprintf(str, "%08x ", *(temp+pm8001_ha->iop_log_=
start));
> > +     pm8001_ha->iop_log_count++;
>
> Since the start, end, and count variables are only used in this
> function, what is the point of putting them in 'struct pm8001_hba_info'?
> It makes the lines longer and harder to read...
>
> --
> Martin K. Petersen

