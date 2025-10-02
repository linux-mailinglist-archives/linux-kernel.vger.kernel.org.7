Return-Path: <linux-kernel+bounces-840448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92958BB472D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C61517F7D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A96242D7F;
	Thu,  2 Oct 2025 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXYB3VL/"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9E32417C6
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421377; cv=none; b=HTaU3GCTdTgsAzwUtUt+0FsP9tOuQQ+7iSNMsa7/EBmcY89bUy0SchmFGUQyaFzhAK7MgAmz6RdkNIZSrYV3pbUGGNra7RP9cUlBZ+xQ52Afdi+L57NK1ZJlC2w9el8i4w8W4bWoIMJZCSVDVaFdxyz49FA2eUAbhc1IJFFCupo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421377; c=relaxed/simple;
	bh=jynfVcM8i52XQQmSZJi60Fasb9iYKRRdPBtB7suA36U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i81WXISzgRp8kL9ur8f7krWR8kYTAITa5Lklt9a/zeWDYMP+zkFQmWzpS62SRe321j1oK2uwkyKUy9gH03qrS4jLphuAiubBW5o1XbQSNd7nzlGQwglmaZgJXu8NJF9wKstRZ/QxCPFRpY/SLW+OEEeT2LJTGGVGfJFqNaTr5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UXYB3VL/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57d97bac755so9565e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759421373; x=1760026173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYaSxRZcAE2xjpCgMhj4CSwwcibne1lj6Mtg6tgQtr0=;
        b=UXYB3VL/VICOoSMQg9ZJ7S5Ncjf+RjahAzqLPnntDpZt0ki+iuTFjDEfuy1QctACJQ
         aIPMh73QWhWFBiacxQrOD56W/raht2kjrjt1ii/wtNil/ZoUBjnESyWrGseSQTlq7jWK
         YA1oxUQR6rswZgxLN5aKG0g2u1NV72dRc7JzCs2p+VXkKg3gbIZdGoQwzIDFVlelOkPL
         iFKfLiWaw5KGSA3pbmkxq2GRlkdYOhIGZEzVd0QV+jAKeMPiy5OhlKLfnV3Apv34h8Ou
         qkkTPt6mHuHVEZJzJnOSgFrkCapoJireScX9zGHKDsXCQngCdrkRnpg68c18mS3WvSdC
         JIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421373; x=1760026173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYaSxRZcAE2xjpCgMhj4CSwwcibne1lj6Mtg6tgQtr0=;
        b=ZTzkDZD2rHP1Api6EDTEGT71LQCTI47W7imB4C0Qa8sYiONrc8mjxWHkRoHJ/UwWam
         qBwoZUi4VSvP3lkA7ukFqZYmCLDy7W1SD/V9h9Tv7dVZax2lQaogMiBK5DHOLj+2D+Z8
         gPwaz0lHPxzw/2rpU4zKMHgYwzB9gaamwSwRKrVrYbwbDf/QtwKByi9cRZeSXelAFHDf
         nb93tNaXmJfwpmfvNUAHSrHzuGO0OoBwhbTtyqQFHJQb1LxWEBP9v210HXuRnnj0uJlp
         EEGIkOFqTR+GLCdrAwYrroxRPxCkpPQ67DcG1Rp1Uqe6jQ1gc0Hh64rEphR/2sDqP+Lz
         5HBw==
X-Forwarded-Encrypted: i=1; AJvYcCXOO82M9Iyk173+uIxILqMJlh81rsthChvhVn40uhEaODY//Up2BRE0UsYdeLK9W8CnT9eJ1zkxB48Dk0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh65IEyfJiaxUiOQcO9vxEPr4Ae6ovYEfe3FBlDix1Pn7d2DQV
	edt8iYZm2rFwTQEZ6lkGmGjUfsl2mnznVs4o5WtGAGQL60wlZEo23DYCU7xCvI6yyxqsgmazwXn
	GSRllIizlIl6xo8XlU4BMfPnBD+7nEYKLeyj5nGLX
X-Gm-Gg: ASbGnctRNlybcqrY7vxScqxt1wVNeT9sT1oMj/rH/iJkxWCX/dLLcnMWwVqHgpMszfV
	FfHxhrWj3BB8yL7ZtyFfbay1vcS4o6Ej8Ys243+dNfW1HCPxmN31S5GPJFrVZQq3j45XkSc4QhE
	VeLc7b8IP1Ft0+5f7NQQntajJOHXSAgktH/arxI2cvtIvnegLIlDXszBGAT7iONbjKVzuJ1VBId
	OtiI0qDKO0epJp89CJQl5oLsg4B3iOlJ+ROP1ZxW50UmCoZ9uqRGSIbuFDNiksFLzdUTBpHS42Y
	6tzWCg==
X-Google-Smtp-Source: AGHT+IE0aOK9/s6P3Bt0+HH6g7rOWTn4mSSWgFpftjNPyu9JGjNcMfZaz8ssxl3nqGjjdzhmSSXVI8NcWrhOPLCdG3U=
X-Received: by 2002:a05:6512:3ca1:b0:577:b58:6308 with SMTP id
 2adb3069b0e04-58b0235044fmr311879e87.3.1759421372912; Thu, 02 Oct 2025
 09:09:32 -0700 (PDT)
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
In-Reply-To: <5b007887-d475-4970-b01d-008631621192@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 2 Oct 2025 09:09:01 -0700
X-Gm-Features: AS18NWAb3xAzNHgehZPxAk9HSv432Ypkc_6eBOTjRMrO-VySkrKIqS9Age0OH1g
Message-ID: <CAGtprH-WE2_ADCCqm2uCvuDVbx61PRpcqy-+krq13rss2T_OSg@mail.gmail.com>
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

On Thu, Oct 2, 2025 at 8:06=E2=80=AFAM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 10/2/25 00:46, Juergen Gross wrote:
> > So lets compare the 2 cases with kdump enabled and disabled in your
> > scenario (crash of the host OS):
> >
> > kdump enabled: No dump can be produced due to the #MC and system is
> > rebooted.
> >
> > kdump disabled: No dump is produced and system is rebooted after crash.
> > > What is the main concern with kdump enabled? I don't see any
> > disadvantage with enabling it, just the advantage that in many cases
> > a dump will be written.
> The disadvantage is that a kernel bug from long ago results in a machine
> check. Machine checks are generally indicative of bad hardware. So the
> disadvantage is that someone mistakes the long ago kernel bug for bad
> hardware.
>
> There are two ways of looking at this:
>
> 1. A theoretically fragile kdump is better than no kdump at all. All of
>    the stars would have to align for kdump to _fail_ and we don't think
>    that's going to happen often enough to matter.
> 2. kdump happens after kernel bugs. The machine checks happen because of
>    kernel bugs. It's not a big stretch to think that, at scale, kdump is
>    going to run in to these #MCs on a regular basis.

Looking at Elena's response, I would say it's still *a* big stretch
for kdump to run into these #MCs on a regular basis as following
sequence is needed for problematic scenario:
1) Host OS bug should corrupt TDX private memory with a *partial
write*, that is part of kernel memory.
    -> i.e. PAMT tables, SEPT tables, TD VCPU/VM metadata etc.
    -> IIUC corruption of guest memory is not a concern as that
belongs to userspace.
2) TDX Module/TD shouldn't consume that poisoned memory.
    -> i.e. no walk of the metadata memory.
3) Host kernel needs to generate a bug that causes an orthogonal panic.

*partial writes* IIUC need special instructions.

>
> Does that capture the two perspectives fairly?

