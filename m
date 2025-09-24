Return-Path: <linux-kernel+bounces-830133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2294AB98E16
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7094A3801
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D280F286D6D;
	Wed, 24 Sep 2025 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faDMTGlE"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81BF28643F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702357; cv=none; b=b9+MGf/5NuwvNDHsCHCjbq/+77nKwfV4FOf6O6B/HOVU97nkDnsJOxBXuDys4W5ivj+OyVhirWPYg3hJ9NXaBuGoaOCM61nvDgN7KP4zESMpAReiK2EYuZIbAsNCi3EaP2hyURZ1Sd3qXeHT1CCldN6tsEo6tucs8IbJqzbsiEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702357; c=relaxed/simple;
	bh=lFCQJZdTjFr6WHrK4DSsND1e5qvl17voBMG/j2Q2oIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAXFGJ7fawVqlstusnnqY1r/ALNWHDbEZLJefQ3gx845lx+8+RToUrBMgU/6emqyalsNjyC+5T5FDB4bK318ldIVm49pyLnF+qYt+A+lQZ3YlWhWpngAYXC1e4RZ7JszCeZF2tBUJ9GzdDRHS7MfwHWj6qr6mrSf7K/QnUgJguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faDMTGlE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24498e93b8fso7044595ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758702355; x=1759307155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFCQJZdTjFr6WHrK4DSsND1e5qvl17voBMG/j2Q2oIc=;
        b=faDMTGlExaUjCAgePBBA0cG2qAc/ySLzmaB4WeRCcln1OARiNu1iLi13Q3XgBFYJhx
         zwgXAUVmUnDtB/I/HLc5REoWf+MwM/EoO9KNbV5vK98GUOPeTbwfk+Q16wQagTKnCq5b
         8fEEpiHSrpr0vaCXARmpCD0q8YAwcTE5lsP4JiqmPTXA/oeOUNmXA2/0sG9hPlP9SXiR
         KoUcvgZbqbNFLURRpsHgf2tAg4FVSF1P+Z+pYUjaptCLNK2N8w4X0WDJADFVxL3/sDDG
         phEraAkv//EFSPLPsAnmWrJXnVWW1enN2cEeIZU9CXzlEUsjedVH7O1GQTsA1+wjlhV+
         3ubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758702355; x=1759307155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFCQJZdTjFr6WHrK4DSsND1e5qvl17voBMG/j2Q2oIc=;
        b=TGapO7Rn3AAxsn9kf6k8lMkIID1tKvoDUTIHm+7ieBB89ADQsQiSNvFaBJDRMw2c/z
         VmCtpH/9EDD7LNDdFBdv02VPCbu2Yo4QnMxHsl3hp6tGYujQM3YjdYh6BS5rnTAOuOYG
         61K0KnRdnfyGqBbhHmc1j9aTDY2Jnhp7dAzhFhXY7FTEBHIjIHVD+yi/LIYVhEIssEzO
         SO+k/sQYxYAgbJjgBzhQIEKR6fFLonqylFUwPGxI6Ii/q56pE8RDy+/9QsAzGcB3MJPI
         mxHS4dxgzqKAzK1pFd1l7uy3DmXGqvP3qS+CC/MxPaG7/L6FY6k2QrlrSRFdNCDO49F/
         NtxA==
X-Forwarded-Encrypted: i=1; AJvYcCVeH3iZIRzIcSRxGo6xvJi+zP2EEOJsMp24rFwrDM/wvXT5TG/VII4LOnotQzbJRDxE4uICtM1MiSHHSsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWMR4JakYRGtEPzTpMONGJ4bRAuzw/9EupTDefEB5j2ZM0GZfB
	wbwgzhPECoTCMV2YyebfHB6LeIj/xgub0XQCdJrFaNxhoK6cg5RwddtWo9f/wANbfIH6U8MmSTs
	a0OddqXZNj9UMPo2lxTkBxrxFqplveNs=
X-Gm-Gg: ASbGnculHMdKATWR0MTr81XQKMaVQm01l1xSReGrUkp2DIGscG/trWVLe+CUfBktsgk
	fndlRjtJ3WyLsiMOrhy5VJe64Tasjj7bFz0Et+rl5eEqug69pe4M4m9ZdHvByQMla+EZeYboPQ2
	yH3dxrjnkaBiRnA8lH7ZhzpLuXVDlVS9kS/Pm1A2q/BSB0kVIUNK6C+COouAgKmFODBOpoEb0H8
	HAuXZ6ugIXmJMoWH1FyvPSDCrpHN7h/Vtixf/AVgXwBrEZkT2SibDgsT44CVbQfsBB3iDlxYAhH
	ZcelBB4rLh4djnHN093fh10F2A==
X-Google-Smtp-Source: AGHT+IHX+JtOM/NNtNrxMmozDIcbtGijJS/zvmO5qLKiL3fxxj1Vg7iwYa19egMIszAck8PIgRg9YbI8g14g2Cwr2b8=
X-Received: by 2002:a17:903:110e:b0:269:80e2:c5a8 with SMTP id
 d9443c01a7336-27cc94ca027mr42352355ad.7.1758702355047; Wed, 24 Sep 2025
 01:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNLOhQyd0YmJnPco@finisterre.sirena.org.uk> <22591ebe-c496-42e5-b2f8-9ca4f8fcaed5@kernel.org>
 <CANiq72k6fioBpFam4YhHazS1X=EVGV8RM6Y9g7ecZG_0w2FA0A@mail.gmail.com> <aNOl-0O4ikg38x0g@finisterre.sirena.org.uk>
In-Reply-To: <aNOl-0O4ikg38x0g@finisterre.sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 24 Sep 2025 10:25:42 +0200
X-Gm-Features: AS18NWCwc4AFEH_PANQBjMRcRUDCNZIBkz7VNlFchEcjVU9DdlzKW06bCXrE08M
Message-ID: <CANiq72nXFih9J3v2ZHmbadq5=BCpJ7RUTaN+h1OY_kWdHVGH4g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the driver-core tree
To: Mark Brown <broonie@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 10:04=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> It's the whole diff for the file in -next.

Ah, that makes sense, thanks!

Cheers,
Miguel

