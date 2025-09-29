Return-Path: <linux-kernel+bounces-836805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22440BAA99A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB0F1923454
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F5D253B59;
	Mon, 29 Sep 2025 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+BMWILZ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CB31E51FA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759178037; cv=none; b=Ld5CNur2KCb4a9IQ8RE2hl3+bt3Y9+O4QTyBr+oc22SrvDCxLpN9Ll5CffPYqmGP6WGi61boxpy+X7eV2C/ZThe91Jsddk0h2PN2O32MqD+tYftjfnHJB91blQ81Is3UYNLT+QLdmZucB0MSagYY6C5Ppdf4lnJpDl4kYA8synQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759178037; c=relaxed/simple;
	bh=zooox9letODSfQhkabg91arQYc8at4FO6VhA79la9PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgoFdodRQ+VTwuszex+ep5xeqwvUzOLcrHKUGau4+/FJhrxVa2KJrttuvUwVATDSfpGyN1reqPbMN4koo7QnEMElEjlrA9j+8iQHioA5hUnUS8jempXim5hGejrkZY+8QaG1c1nluGagP68Tnhnz7wo0wHyNcxxH1imFoXU7lmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+BMWILZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e2b7eee0dso4405e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759178034; x=1759782834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zooox9letODSfQhkabg91arQYc8at4FO6VhA79la9PI=;
        b=J+BMWILZeq+cl/M2ogBYtS5qyyYwSWBLnMb6ARV2e0LndUqnz43vFLopt2+fECqZWa
         jrUaXOiVmybpG+8qejZ4CPlPLVDe19r2m6wbvQRoY8vC/OvLv5g23wyJJQ/5CZMMxnob
         LI5g2LCokDhKquDAZHWcqVT0WyPAKoDvkNmMBnPG0A02GxFcud9iQomgMw2rEQEUQfzf
         BjWxcHJzu6Uc6U2F58GnIC+dwx3lZcKRUad3Vhe0T0UFmc+HTZRHC3skW+38WvRBY8ru
         tvetvYz56a8rbgT3BoqtI5wLwWouyiTTOjcAK6NrtxqlFl8c0nhlTlqfjD8a7YWn6TZ/
         J8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759178034; x=1759782834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zooox9letODSfQhkabg91arQYc8at4FO6VhA79la9PI=;
        b=QsnyTZyRFSzex7GKfvpXchYYjLBAvE7NNczqIXEWf8wBdckFI34xfrmiVkw6HUJwO3
         vDVslXTE9Ac/I2hHfOqlHirgk5N2ClEBk89okkCeQWPWcqd+Y6NdpWrLc1BPYyU/K5Kf
         JJ8wt9Rzeq+S2IanCyytRnC3438qJqvwD1zVOfn5XMj65Qht5bIJIO8HzHs+kT3QwZQo
         +hiP+86NvzZCLfCNIs98q5tr1e5im9r0KnC+RoM5wJE5EB3rJDV8csjLRbdh6+Jwyr/b
         nMLYNfQxEgqZpJnWIAyF17sn3UYwSpnHqS81iPnxpOS7txoFVzb2QfOdcYG2nOr9SK3A
         3eww==
X-Forwarded-Encrypted: i=1; AJvYcCXHgKkwbPjmY3jWHFrABCytIybu4WMGImeIHCeP9C4d92epRj2sq2VLhp5oijnSySQOAhcCQKH3q7fiijg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUWddPhEGozKKYDqH9XZJ/u2s1uvf5Upp0IZ/mX+DTeebkbHkC
	0PjHJb4622UdgGyxyRwEx/PYWGPzgwippRCxddJAc3Am6aIE0ifsTVj4R2SmeU0A2eH3S5DK3oJ
	7zc/2EoiGhUiRDTkJFPAQUm1kCk8T4Bxj13JR4Kju
X-Gm-Gg: ASbGncsGg/TdFoVFoyqaENuUfBgMoUkqkwLmGcrCy9MEKjYM7Z9Ry+xrvcBXwQC30bw
	ZJelnTZgioERl9lG3fAb74qPpnpQssrGVwH8l7Wrhf37OF93PzXMdvqHNkWkiBerQS61OAtcaVB
	WWC4K+P/uI2OtNSvBhZOZNDRNYWywP2nN+Jw5pyAIb/tIvmCVlsPB+zLiJWIDincyGsT1OePeVL
	D+Vd112zaedd+7kSBAphbc17yfRMKrWvhKcwTURgw8P7uPU69GITms=
X-Google-Smtp-Source: AGHT+IGJUkOfSqWVDmFZmnG50Vkevh099QmVVU2lqSkkAhKs8Kt0LbWZK60A0sTVrvtkh+1zZJRW7uId3xoPtHHPkS8=
X-Received: by 2002:a05:600c:5599:b0:46e:1b09:1cda with SMTP id
 5b1f17b1804b1-46e5ab1140dmr114385e9.5.1759178034297; Mon, 29 Sep 2025
 13:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818071304.1717183-1-elena.reshetova@intel.com>
 <287a2652-bce6-4084-b9b5-c8feb24a2940@intel.com> <CAGtprH8rPg30gsrhJ9=44uaePqf-Ay=R+O_+D8isH8TzM4uQXQ@mail.gmail.com>
 <DM8PR11MB5750C11091D7D90B60FE7853E71BA@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAFbLv2dbF4=vEvuqKFweRR5P6qtm+E7U29=f2ByM552j6fd9Vw@mail.gmail.com> <266dd7f9-89b3-4297-a179-9fe57345abb7@intel.com>
In-Reply-To: <266dd7f9-89b3-4297-a179-9fe57345abb7@intel.com>
From: Nataliia Bondarevska <bondarn@google.com>
Date: Mon, 29 Sep 2025 13:33:41 -0700
X-Gm-Features: AS18NWD3JoxsS6rdDIDIHJnxn1QxhAdsjzhFS7E7McIEzE5CohGNlP80llYkVHk
Message-ID: <CAFbLv2fPwV6u8HX=zKntVLwKeBsbEu62J49uC0kL237HDRiUfQ@mail.gmail.com>
Subject: Re: [PATCH v15 0/5] Enable automatic SVN updates for SGX enclaves
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>, "Annapurve, Vishal" <vannapurve@google.com>, 
	"jarkko@kernel.org" <jarkko@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, "mingo@kernel.org" <mingo@kernel.org>, 
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"Mallick, Asit K" <asit.k.mallick@intel.com>, 
	"Scarlata, Vincent R" <vincent.r.scarlata@intel.com>, "Cai, Chong" <chongc@google.com>, 
	"Aktas, Erdem" <erdemaktas@google.com>, "Raynor, Scott" <scott.raynor@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 10:35=E2=80=AFAM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 9/29/25 10:12, Nataliia Bondarevska wrote:
> > Tested-by: Nataliia Bondarevska <bondarn@google.com>
>
> First, thanks for testing this.
>
> But I'd really, really appreciate if these tags (top posted and without
> any context trimmed no less) came with at _least_ a few words about what
> was tested. All I've got now is tag from an email address I've never
> seen before which is (apparently) only used for sending Tested-by: tags
> for this feature and nothing else.
>
> Also, by "a dearth of tags", I really did mean *all* the tags:
> Tested-by, Reviewed-by, Acked-by.
>
> Could someone please spend a few minutes to explain what this tag means?

My apologies; I've clarified the details of the testing below.

The verification was performed on a SPR machine. The objective was to
confirm the successful, runtime update of the CPUSVN using a targeted
microcode package.
Steps Taken:
 - identified a microcode package version, designed to update CPUSVN
number on the machine;
 - initiated a dynamic load of the package during OS runtime;
 - confirmed the CPUSVN was upgraded post-load.

