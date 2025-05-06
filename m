Return-Path: <linux-kernel+bounces-636690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDC0AACED1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 22:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D461C066AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 20:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE094B1E76;
	Tue,  6 May 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfBrWKc9"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25963139E
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 20:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746563539; cv=none; b=bNKm+FPfPmbXZGOWj24PQ+ysZ0QVSCpIfN8JLQ3ox9TSOeuMU1CjE9IVez6sQXijlDLAp/sjFiV2QPaIhgS11fRfoksAFIjeESCZyaSFzV25TZD1kN9cECWZ1oQ2POfziDJJwp3GcKy9qvaOSaawz9CQuTr7XMjSxakOWhIK2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746563539; c=relaxed/simple;
	bh=tUwZYD4lRH6VdaApuK/2dwXWp/zrHR11uMrefDN0O3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEP3uw/8WeWHsBcJlFxIlcaQ22CKPCw13pXliVbLqOJctBe7hBapL1hFhpvJ7ih9Hiv5fhLF0cofuUV6QUo7Hx6VYg8MI5D/sPS3nTSRRyHIdR/BHOnxiXul2zlmvP0gAWSK1xBdanX+kZNf83zETjmVGmqArIuDTQTyjJLLNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfBrWKc9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso17255e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 13:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746563536; x=1747168336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUwZYD4lRH6VdaApuK/2dwXWp/zrHR11uMrefDN0O3Y=;
        b=SfBrWKc9iPmKY6XP1L8ogUg33N64Koqp5Py1cxrP6bOlBSz/ZADRxnBtC51elFdc0W
         0EX8si1V/sQtgawv8y36UxJTYSdMBJxqBqV7U0Jk+JpaFQs79iKU0fidSe/umS/dpSCd
         On3szway9QXpiRR5nri+T6ilYxpwfDlM3TbRPMtqRK6RL0tSPkFKA/+gMrsYQ0eT+IrI
         zf6Wgyd90BkaulD/ZQKEKnb06sS6VseyHOQh1M6iVC0r4m2MArlXLQeF/+jiqSgeOJTg
         8olsa8UT2L9qUyKiYJqF1IjnBtaAR8fkgR+4iTTYlVHCmYroRdhh24YQ9OTgeN/zfcA+
         2hfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746563536; x=1747168336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUwZYD4lRH6VdaApuK/2dwXWp/zrHR11uMrefDN0O3Y=;
        b=M/fCw6u1rB+pMzXr2z+d38jI0APZ7W3aUPGgU0MnY/zzMWENxBzdW5EvivXle6qi69
         6Vsw6sd1AsxYuo3fWuW40FgHxdHrG8yPg+wTrCVYDIcs7yGIjQM+gohBMJCbA9tMUJYQ
         9jOwJQY4XjvFUtvshmGWyExV3xbQe/OHMtWrB4SPCUxiT+l0wN7WUZNFhdm5Ts1fWkUz
         uQP+gr9+/GM4V+whZrA0hemXQERTm/4jW5FXmXmcCFV81C5dNPup6lZCm7qk/fg0NBHd
         FWBYUKUmj3Tm8L/h8R2fdaCPIoRbGmcvbhpB8LQ90+NLwWG8npvFLRUt3QS8ZuPfwSv1
         0U7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKR2x4fsjZLVoCZpy/WuMcKUaFMF2uzaOOqEBMvGSSFi5IFAzm6GMbMfvLjlWk9/UAR5cKMc6S6cdq3bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jBUM3KNp5e7GZgo1dK1QNN5vjL4N/gFqy3oLm1LbUpsJeWfO
	12cgd6ue17vaJ62ORffFhZH7zBsq/93GGQjkbboxK2IG1rjqEbzAXMy0/wWMQAeJk0ZFhY+quZv
	yVNV48fiRmMR39xvk8i7AJsY/TJjOTsSOeIQL
X-Gm-Gg: ASbGncuhcg39A90YbGi6TCwvD/ytlKVPYQWlBxgFbygajVrzACflx2h7lM4H9nADzoV
	MQWcYobPxIelmn3hlbNvSdMALTp2+Kh8LgrtAo5yEYqFZcvHZiFrZaf9ZuLt7e1fWYzW9+fA/l/
	wFXCcEql13qLa1aPYyfobXoMMkbz8fAQNS
X-Google-Smtp-Source: AGHT+IEViL4DDYdA9BRkFbLcDJrhDyd8AMVyi7Ajmkopmwi+B3g8ozJx81yXwm52KwpCCBwGQVYxLaUMmnJgtUMdspA=
X-Received: by 2002:a05:600c:5249:b0:43d:5b3a:18cc with SMTP id
 5b1f17b1804b1-441d446ece1mr211865e9.2.1746563536279; Tue, 06 May 2025
 13:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0d7d6b9a-e7bd-4225-8f08-05bd9473a894@intel.com>
 <aAviqeAdGn-w1GpK@google.com> <fbd2acdb-35dc-4e8c-9bd9-e84264f88648@intel.com>
 <aAv445Sr71NUJP1X@google.com> <db1fd062-5a66-4942-82e2-c889dd645a7b@intel.com>
 <aAwFhaqQDLXoqbmv@google.com> <4b4ecaa1-2ace-43bf-b71b-0de78bcf113c@intel.com>
 <DM8PR11MB5750B39557F5062038D0E551E7802@DM8PR11MB5750.namprd11.prod.outlook.com>
 <8db47bc1-445b-49db-b932-96aff0eb58a9@intel.com> <DM8PR11MB5750200DFF8CF40E3539B688E7832@DM8PR11MB5750.namprd11.prod.outlook.com>
 <aBI-xQzatja2Y9dh@kernel.org> <DM8PR11MB575014811E4007EA00F5B3E6E78D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <d16ecae1c1b4b6f06565dfe9c47849dcaeb0782c.camel@kernel.org>
In-Reply-To: <d16ecae1c1b4b6f06565dfe9c47849dcaeb0782c.camel@kernel.org>
From: Nataliia Bondarevska <bondarn@google.com>
Date: Tue, 6 May 2025 13:32:03 -0700
X-Gm-Features: ATxdqUE61e7i1k-WDCodhkqZGzBoZRAAXfLn7Q4KHv08wJ97xsX3tgACyJjBU2g
Message-ID: <CAFbLv2cEgABB3jmL7_6_ZyA8-q+8u7C5f-fcoQf8acYytiB3mA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/sgx: Implement EUPDATESVN and
 opportunistically call it during first EPC page alloc
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, 
	"Scarlata, Vincent R" <vincent.r.scarlata@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"Annapurve, Vishal" <vannapurve@google.com>, "Cai, Chong" <chongc@google.com>, 
	"Mallick, Asit K" <asit.k.mallick@intel.com>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dionnaglaze@google.com" <dionnaglaze@google.com>, "Raynor, Scott" <scott.raynor@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Nataliia Bondarevska <bondarn@google.com>




On Fri, May 2, 2025 at 1:56=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>
> On Fri, 2025-05-02 at 07:22 +0000, Reshetova, Elena wrote:
> >
> > >
> > > On Wed, Apr 30, 2025 at 06:53:32AM +0000, Reshetova, Elena wrote:
> > > > 2. Switch to Sean's approach to execute EUPDATESVN during the
> > > sgx_open().
> > > > Btw, Sean do you agree that we don't gain much doing it second
> > > > time during
> > > > release() given the microcode flow?
> > > > I would rather leave only one invocation of eupdatesvn during
> > > sgx_inc_usage_count().
> > > >
> > > > Proc: No new uABI. More predictable on svn change compared to
> > > > option 1.
> > >
> > > > Cons: Two explicit paths to hook: sgx_open() and sgx_vepc_open().
> > >
> > > Why this is a con?
> >
> > Well, just from the pov of not having a single path to enable.
> > Are you ok with option 2?
> >
>
> Yep, as SGX is anyway very much run-time managed feature and these
> hooks fit better on how it is used.
>
> > Best Regards,
> > Elena.
>
> BR, Jarkko
>

