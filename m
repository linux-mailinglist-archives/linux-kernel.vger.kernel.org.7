Return-Path: <linux-kernel+bounces-864033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 680E5BF9C48
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C01534E92D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE7A221DB0;
	Wed, 22 Oct 2025 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dyHywGH7"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051CD15687D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761101459; cv=none; b=QL+mgHl6N/PPm+TWdevyua5AYXmA3Ui8xRDUFTCGdZn2eJ0VOyq6iIvjhg35zGstixLnP36sGzfs62TvWANwJvJWa0p42QmsjE6XENNwFJc7c+Gj2PvGH51QVUijDHWND8861uSevS5KeDRsU/zSwWqTKVq6249Ag+upM8D1FSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761101459; c=relaxed/simple;
	bh=74Q/QyxC69gHYqKvcyXF1RTLpkWKNAxTLiRfo0xsGck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5pTG/top1j3D1CrthV4iptuiN6cau41yi3xWSItfJr3YFz+kam2aYOPgzKf1JlEj/MMcJaEsRgl1/5JHwUTatPQ4MDx76vQh7PphvlIvdy8icoTr35d8f7jgxwUwU3R3AJGXIcGtYiNW2h8bYDoEKBOQvw5E9Ik/aEkhLo06gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dyHywGH7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290d48e9f1fso76455ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761101457; x=1761706257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74Q/QyxC69gHYqKvcyXF1RTLpkWKNAxTLiRfo0xsGck=;
        b=dyHywGH78S5yBX7YyqKiXj5ikSYRGPZ+VUDVPU5Fa2P9iGR4sh/wx9xP2sJP8DV9j+
         7/7LFvWcUItwKSLr7HNydWPZ09SVE6VXs2EIcap5pAhm7b/D+ql6x/PHkfklwyttMANL
         Eoujm0q12KvsCdobGOnayhIc1irUUZ+c5QMNMgvPPIsUhjjXLAk1uWVVHr2gXwCO7Ga7
         FzzhADifTQbUCjmgacV1Yv2WDqfdR2/lP3yX+z+bkxOrR+IpK9xETQWKxDowR8QPpUAJ
         DUktG+MBZGvfA9mrcgyH5dHmrILCNZHIlcOnlMnrSm1ZGZAUY+9tapCIwXfOVQF33Q9T
         /xaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761101457; x=1761706257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74Q/QyxC69gHYqKvcyXF1RTLpkWKNAxTLiRfo0xsGck=;
        b=dAcmoPYv7jvJKAblO37o98YpGFG+XuTA6lsGHJUUTVrzaOUNKbJRR/3zgD4V+gofEU
         3d8Tg7r9iDb29WwM1I/7tz3HbrEQo6d6botVT8DjlKbqEufIEOtvFrvi4YmZsOzKsO8v
         42BKD+MZYrChtydoPgOvTfT4yuI1OhoCCe3RUgdVp5ZzaITJYS4ELNdU9Zvm1X2F9Rxw
         3y7PBDbbh/Q2hSB1KqjMcbR7yRohPrXn7JX2eYNxm3f9izawAtvZHTwsyjsNF2i2dClg
         8wV0CTYGkqVTJYrhYo2tOFV+UqoqfRLT1Qxc9K+tpxqr2L80llMM8ZQ7LC+p+yBB6+oK
         cFFw==
X-Forwarded-Encrypted: i=1; AJvYcCW/YLJCtF3SwQIFBsbPbeuYOmX9xKGUobr4wP79LxbMeFK3i3iHodT9lvP6bySbKUWsDLSAy7BVDh9LoP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuR5thdjEBSlW1bMMU+7x68sgtkDs0TJ0CwJ3Gt5D+LUM1awek
	BB+BFF6z0WtcWJu8lxE2l94nFbOFF/H8zpiwMviG9dTTRjgBXTRJzcFWX8yDrClMOoKR4NbEQQx
	pAZ+8VAjsPU3Irh7duvLqRzMHTUOu2cCvfS3oqhzV
X-Gm-Gg: ASbGnctoghIdbs3cx9zyH0Wea1R9amebBqO4FD7mO3lMX0aW3zjwLP60mfhYuy+qAbP
	Feskxv6DrAs5U8DMdzdfckIZ2xUAwsH5QcDlxHNlIYQy4Msxarx66lbkej/N/ulXUdeVZLIg6OB
	tKASbvP3Irdhr80biKOZsNY32tPKc7EIpnhKivQod+tIOW5cQ0fYG7VhJM7H5Ps+DY63eJIOiMA
	M0nCvSkl+IJ0HYX5eOIo4YTuLWy6XOk58Z3QB+pMDxHDJNcywKMs+IcU+GnfW0eocOC8Am278/Y
	gPxoW1FsZsq47fbEfA==
X-Google-Smtp-Source: AGHT+IFkG3kqBGNd46dgK6k1mDuBdTTvwZJXkiU044mOI8ZxoI9hkB/OVHaxUzIqj6um5XEsujlEKYLzOZVTQWu3PkY=
X-Received: by 2002:a17:902:c409:b0:25b:d970:fe45 with SMTP id
 d9443c01a7336-2930238eaf8mr2130905ad.1.1761101457070; Tue, 21 Oct 2025
 19:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901160930.1785244-1-pbonzini@redhat.com> <20250901160930.1785244-5-pbonzini@redhat.com>
 <CAGtprH__G96uUmiDkK0iYM2miXb31vYje9aN+J=stJQqLUUXEg@mail.gmail.com>
 <74a390a1-42a7-4e6b-a76a-f88f49323c93@intel.com> <CAGtprH-mb0Cw+OzBj-gSWenA9kSJyu-xgXhsTjjzyY6Qi4E=aw@mail.gmail.com>
 <a2042a7b-2e12-4893-ac8d-50c0f77f26e9@intel.com> <CAGtprH_nTBdX-VtMQJM4-y8KcB_F4CnafqpDX7ktASwhO0sxAg@mail.gmail.com>
 <DM8PR11MB575071F87791817215355DD8E7E7A@DM8PR11MB5750.namprd11.prod.outlook.com>
 <27d19ea5-d078-405b-a963-91d19b4229c8@suse.com> <5b007887-d475-4970-b01d-008631621192@intel.com>
 <CAGtprH-WE2_ADCCqm2uCvuDVbx61PRpcqy-+krq13rss2T_OSg@mail.gmail.com>
 <CAGtprH_sedWE_MYmfp3z3RKY_Viq1GGV4qiA0H5g2g=W9LwiXA@mail.gmail.com> <08d64b6e-64f2-46e3-b9ef-87b731556ee4@intel.com>
In-Reply-To: <08d64b6e-64f2-46e3-b9ef-87b731556ee4@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 21 Oct 2025 19:50:44 -0700
X-Gm-Features: AS18NWB82gI5mzQohtK6dqujASE7pQMR3DBpwJ7JLgGvKBNTIxbWBEnf-GbjPkc
Message-ID: <CAGtprH860CZk3V_cpYmMz4mWps7mNbttD6=GV-ttkao1FLQ5tg@mail.gmail.com>
Subject: Re: [PATCH 4/7] x86/kexec: Disable kexec/kdump on platforms with TDX
 partial write erratum
To: Dave Hansen <dave.hansen@intel.com>
Cc: Juergen Gross <jgross@suse.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "x86@kernel.org" <x86@kernel.org>, 
	"kas@kernel.org" <kas@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "Huang, Kai" <kai.huang@intel.com>, 
	"seanjc@google.com" <seanjc@google.com>, "Chatre, Reinette" <reinette.chatre@intel.com>, 
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, 
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"Gao, Chao" <chao.gao@intel.com>, "sagis@google.com" <sagis@google.com>, 
	"Chen, Farrah" <farrah.chen@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 10:08=E2=80=AFAM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 10/18/25 08:54, Vishal Annapurve wrote:
> > Circling bank on this topic, I would like to iterate a few points:
> > 1) Google has been running workloads with the series [1] for ~2 years
> > now, we haven't seen any issues with kdump functionality across kernel
> > bugs, real hardware issues, private memory corruption etc.
>
> Great points and great info!
>
> As a next step, I'd expect someone (at Google) to take this into
> consideration and put together a series to have the kernel comprehend
> those points.

Then is it safe to say that Intel doesn't consider:
* Adding the support to just reset PAMT memory [1] to this series and
* Modifying the logic in this patch [2] to enable kdump and keep kexec
support disabled in this series

as a viable direction upstream for now until a better solution comes along?

If not, can kdump be made optional as Juergen suggested?

[1] https://lore.kernel.org/lkml/6960ef6d7ee9398d164bf3997e6009df3e88cb67.1=
727179214.git.kai.huang@intel.com/
[2] https://lore.kernel.org/all/20250901160930.1785244-5-pbonzini@redhat.co=
m/

