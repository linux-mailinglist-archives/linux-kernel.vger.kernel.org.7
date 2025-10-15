Return-Path: <linux-kernel+bounces-855040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB06BE0034
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24B0188AF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB42301472;
	Wed, 15 Oct 2025 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6iYrQ72"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EBC21B1BC
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551853; cv=none; b=NzggV66q6aE5tunWd/sIpXZnzDBVw9a8rrarLYU8qPoPSYXEzjNDjlFPC9vU/ePqrA1+Af1ugFFnjziy5XA/b6f1eTTf1zAZTBzYwtMOHGyPZsne2QGpNLm6m2VnK8wbBdxowb+B/1wYBAbaa3CaIt4uDyEyx4ZPJxHYwOFHCkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551853; c=relaxed/simple;
	bh=A1Yp6U35cANnY8G27X9QHKs7ZC1uiK/VGWHHtWeVu8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EctuNJ9P2+NDIsMWtwEwyY3P2FWrtTxW/luSm7CaAXKavoaQ4mbmsLRtVlUnwhcRzDy7e139tOptuk4cUBmGVK3fxyCDYImMHHOltTIgBBXdZOUR8UMbOho+JN4XsUoecYuwwOdEBfisE5ghcAHYv/uwJ3CGIGLxkOhoRN90bW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6iYrQ72; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-78e4056623fso93144306d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760551850; x=1761156650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqA7k4UVVoz1WmvKpqEl1VWC0k/EIByv+fhLJjtIG9s=;
        b=A6iYrQ72i70wKcH+lwKdRv0LQ53a3isLZ679z7DbNBds4diWJX4Zpkh5ySfsfOLhMY
         lNT2EJBpGU2OGNi0mW4xqbmIv8NqfYwRVokPd1MF0b5RayS2rgo+jZEYoS8DzT62rZQs
         lwj38Iu1WNRlNUUYRzorQdphahmLEOPXXBiNcMj17PBpvlBHMk1se4q/WaZbrfVEq6li
         R/Vfg571qRjD3e+aQlMJgyTfRREOHmvcUimk6QZShneN59a8J88SkYTIgKNEurDPhaP1
         DzS+ySXUycFjNafnHGDbQU/BWWzV+/Jo8LKbxnvvFO/oAXCkVhBtm8QMpAmqWM7SgEIP
         h3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760551850; x=1761156650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqA7k4UVVoz1WmvKpqEl1VWC0k/EIByv+fhLJjtIG9s=;
        b=vmXiBtWG8un5FDTb7otPPrwMpc01fu9vO0pFHNbMDBMBEJ1fsHaxjJojgpxJiF3daY
         qFFMYvMVhhNpe7cQfF7JW7RHLFgMRg7KrpbINVS4sOAoSxcGGUU3zx2SuJCgDmbhStI+
         BiMCD1tTWgJ6fi2O70akwA8znOLZ2oidvCANuEUjyKR6glCpDeObG7fAxgsa88jZOq1f
         4aQlS8seLnSfqvuAOGTYYTY+VdDD0oXycMArIak6aV9ankI/tEFCVs/gVAkiuzBi5gcZ
         hHRf2u8hGUvnYHtxBEYbW5U1b5eq5gpOHVOA6lMKqeoZ0gmqko7kYll62q8vIn+Jewj/
         FG+w==
X-Forwarded-Encrypted: i=1; AJvYcCVpShh1kqFeveoVCBPMLMRMnT/09dQaFTBumylxUD2FItfRbEqfXNyrq7B7Bw3XxRq6ojLwBvUN0UQb/98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZS4XNJKGXiBBpJfshZ8Kx/536M2sIeqDELkf999AcJwlOjbWV
	Q0QbBM58TYxMac5PUBK61o2p88S7wE5WS2rsy9VHLOyFyPLW7wZnnS0HdJ4AM7s8EN9U3VYhUDC
	GTdyHcS784f1LPUiI2trtxQWdFzMqbv8=
X-Gm-Gg: ASbGnct8EWXK28Ge17VajxKNft7T5CHXGuvMkse9xce2ggjGFRg0yioPq8BkNO9B5zl
	NyqT2w+4A9l3gNb48M5jGCxboHPWZsc3d5aoKJcDHgvefTDlmOqfGw3W9IHe1FaWiGQ1ZIVCeCa
	SmUi4m6ixdI3ze+2tU8Hjx0ft3MWv6i1il1FGP3NtL7UjaVSqtZ2DObDBW3NwnwG6Mhz9IepkC1
	TNhGuU/TANZPc56paAkSKI1F6M0izp3eGozIakDMhXVrfTyA2xKc+y9rHdwY+AHGaoYMx5O5zWZ
	IxlkRulcoifHREVA6Sfzj+91mnSGdh3hPcSbzW9yPrvrMK3fHC2bFXeSPcogYVd8l43U/TO9ezO
	cGsptgXvQEiF8SVmDOrFb1YASL2Q226JWFoZ5Z+cR
X-Google-Smtp-Source: AGHT+IHninkPESQS8dHVL1fQL53uOsfSc1mur/cEdxDh3bmiIBfWuhMXmHWs7FOB1Mg5kel/vGkCWetRJzQIDq/GUh0=
X-Received: by 2002:ad4:5945:0:b0:78e:c8a6:e891 with SMTP id
 6a1803df08f44-87b2103f5c0mr366857086d6.24.1760551850329; Wed, 15 Oct 2025
 11:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aOzRF9JB9VkBKapw@osx.local> <6599bf31-1099-426d-a8e5-902c3d98e032@web.de>
 <aO/DLq/OtAjvkgcY@chcpu18> <6eeec2b6-ef28-4280-a854-cc22d2df55ed@web.de>
In-Reply-To: <6eeec2b6-ef28-4280-a854-cc22d2df55ed@web.de>
From: Steve French <smfrench@gmail.com>
Date: Wed, 15 Oct 2025 13:10:38 -0500
X-Gm-Features: AS18NWBfaSIxv2RDHlnpAQo8uwRpyrQ2N8ndjpwz_0K_rEufX1VnmPESyUOVHfY
Message-ID: <CAH2r5mvg2Ask8SXOQArDLnKOjHHSPKGwuHkYp9NuuzEqYcZNEQ@mail.gmail.com>
Subject: Re: [PATCH] smb: Fix refcount leak for cifs_sb_tlink
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Shuhao Fu <sfual@cse.ust.hk>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, Bharath SM <bharathsm@microsoft.com>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Steve French <sfrench@samba.org>, Tom Talpey <tom@talpey.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I agree that "callsites" is incorrect, it should be "calls" e.g. but
the others are very minor and I think the existing wording is fine for
the others

On Wed, Oct 15, 2025 at 11:25=E2=80=AFAM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> > Fix three refcount inconsistency issues related to `cifs_sb_tlink`.
>
> I suggest to omit this introduction.
>
>
> > Comments for `cifs_sb_tlink` state that `cifs_put_tlink()` needs to be
>
>                              ()?
>
>
> > called after successful calls to `cifs_sb_tlink`. Three callsites fail
>
>                                                           call sites?
>
>
> > to update refcount accordingly, leading to possible resource leaks.
>
> * Do we prefer the term =E2=80=9Creference count=E2=80=9D?
>
> * Is the word =E2=80=9Cpossible=E2=80=9D really relevant here?
>   (Would you find corresponding case distinctions more helpful?)
>
> * How do you think about to increase the application of scope-based resou=
rce management?
>
>
> Regards,
> Markus



--=20
Thanks,

Steve

