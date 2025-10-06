Return-Path: <linux-kernel+bounces-842858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A463CBBDCE3
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F09188DC8B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9991F2620E5;
	Mon,  6 Oct 2025 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcD9iO5S"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED6F247DE1
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759748093; cv=none; b=pEHtAum0EhcRQxfiFCc1trIulrFJkF7x4QpvSjfmjmIcq3Y9QWKRGEOrU0NR/kfjvD2jQRHWmCl8PPFumUiaMhPiKxq9GYEA7gk8Pk3v0BZTgNzg3Rp7PlMpSOWzGOHkpcrMDQBhA2/97BTAiPv8NMlcm0kqVL4apBwy+ub9BCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759748093; c=relaxed/simple;
	bh=qXNXLA2jr121IED5txM/3X9BlnZFSO/JqrdDDHaU+08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uvgwIiiA95WJCqT8FZJB54f5L1zp6p8ZCb+MhRQfvNNWMdtj2fo1pJ3qrbRBP/bpjMS5jDmutBbfxWJtmQI2G/2wqk0DMhifxENpEtOGZeIEjqtIzkLIvhlLa3OgkjtptPA66GJ7gcKo1vT/GrDd9rC+RbGoWXe1FCjqimR0nqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcD9iO5S; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b40f11a1027so856284066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759748090; x=1760352890; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qXNXLA2jr121IED5txM/3X9BlnZFSO/JqrdDDHaU+08=;
        b=mcD9iO5SD00hbHWBr0Dhlc8KF+ra94YzesMKP3XXBwhNP8xToWwzubBEpzahu8QqUy
         zI/WgdSEYkwezj0ymaSLJF3ewQVBsMUYg2oQicusBkCsLJH2HDUxs3HCQlfPuT46gZPX
         FhYGtkldR1Pqq/d6t/vTl9yOPLBw9ldUUdRJXZ5F9wIJSXqdFaG+t8Gc99cJvBjgl7Tb
         9TuVHFU+lWg1TH8U0pjU23c+I68ScA5DI3YfijN8X8Pq1RoALif0DICnL+iB8MBpiZmf
         5fC4Ij8jbQH/lXFy11ZMr8IT6K1bysipUr8eWSdvZkpIni2AMIvq5KNtqaKPqxrd+guu
         90Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759748090; x=1760352890;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXNXLA2jr121IED5txM/3X9BlnZFSO/JqrdDDHaU+08=;
        b=AHMrwZFZZqz/OfS1ictSv3SzlTvZ2lnqSoRFB7gyBb4qx8GYW6ms8YKE9g2Gn2Z3ET
         eUgzGKC+++4XOYg0kREZ1Ds4X/a70qb5+z89zF+k9Qz+QlsWiczZOM3j+3vSDAXNvwuC
         XG8N/bjoQETtDyDPt4H4GycpHiC0Peb9FfffxOgS+7+6OwPSH/l+PuDte+FOuJVkIUTL
         M+ZwjJeX+IWZf4tBse8rtxeV0ro/CxzmF+El2eqtRX/hr0zX/lVWJAbaAujqS3ECZe0s
         A4EnE++yxB6AwIlNqOvu7oYdfw2opYEML6xRGFUbIVFIWg6H8fzVbDK1nWZ/foGMJqiJ
         GS/A==
X-Forwarded-Encrypted: i=1; AJvYcCWQnT1yMIV6ojx4RyqQtPl3tJb/pQqnlmD23FO/swETkRRIJOt+9HQ2E1I4vj8xXLsGmu5CS8Mt16wRH5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhqMI/Sx8bphYCRjP6V22nT++fzqw30a1Pao9dGtwLl9WB9vgM
	w6ZnaUbIhGzbKtvoX3OEaV8LAthQe2r10DUTsj8HRrhL6YWIUdUQ61dK
X-Gm-Gg: ASbGncvCsoB1C6RcWDNP7LsuRjCff2mckZPUR9ctk3XOP+gSuRuBTBVCACnAddDgAYx
	sqr4sD7dXaKRuOkNEH53IQ/eIzdFX1m3jrAK8RC/uwMXO6fVIozJ1FJrYPGL3rKQBmHoKN2ZBJR
	eyPyL5meYcPcdTy4IIqkLK/kj+D/IuTLvpML6/G16FwPdY797wwEnPGVz3Y11ovv4FP5L40YqzZ
	WHOaSX7b6ihVrF2zEzjBesEonexbNji1+vaiUAtYpk2cgrd4X2mXGYArDWsfVK7wa1pxgpOxZNZ
	s9TJptcsTqQCm7kd3AKiRFZ18o6b2Fo2MoBiBwpI7lZWW1jlwBizjHHaGyPMeDYPNOblcZIPm6R
	KytwVlG9DEYKQii2rODggE4SniwWTKSH9WJEpaor0LvXMjzYv1g==
X-Google-Smtp-Source: AGHT+IFsbJIMX046ZdbgwCO0LHE40l3aSoIKhdw9r12MAKMtV4NAk+2OeC5sVS+LTODNz1eBr36Z6A==
X-Received: by 2002:a17:907:2d26:b0:b04:3302:d7a8 with SMTP id a640c23a62f3a-b49c4394dfbmr1406539366b.58.1759748089518;
        Mon, 06 Oct 2025 03:54:49 -0700 (PDT)
Received: from [10.176.235.211] ([137.201.254.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652ad839sm1117104566b.1.2025.10.06.03.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 03:54:49 -0700 (PDT)
Message-ID: <41093b6af67db2073a141527e44e575d0811d55b.camel@gmail.com>
Subject: Re: [PATCH v2 1/3] rpmb: move rpmb_frame struct and constants to
 common header
From: Bean Huo <huobean@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com, 
	jejb@linux.ibm.com, martin.petersen@oracle.com, can.guo@oss.qualcomm.com, 
	beanhuo@micron.com, jens.wiklander@linaro.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 06 Oct 2025 12:54:47 +0200
In-Reply-To: <CAPDyKFpyh7Qag+ckCcPkr1RWh8YiST-4V2_Y7xvBU4LRLNC28A@mail.gmail.com>
References: <20251001060805.26462-1-beanhuo@iokpp.de>
	 <20251001060805.26462-2-beanhuo@iokpp.de>
	 <CAPDyKFpyh7Qag+ckCcPkr1RWh8YiST-4V2_Y7xvBU4LRLNC28A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-06 at 12:21 +0200, Ulf Hansson wrote:
> > Signed-off-by: Bean Huo <beanhuo@micron.com>
>=20
> I have queued this up via my mmc tree and plan to send a late
> pull-request to Linus to get this included for 6.18-rc1.
>=20
> That should help to land the remaining pieces for ufs in the second
> step without having to care about the mmc parts.
>=20
> Kind regards
> Uffe


thanks Uffe,

Kind regards,
Bean

