Return-Path: <linux-kernel+bounces-722434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB51BAFDA89
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD0F1BC3248
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1AF253950;
	Tue,  8 Jul 2025 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWifIMU0"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B4253340
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012425; cv=none; b=HBDt7ljjKI07/i8Y8TlekLBItUP+NhSxUn3xhbjrccEWtRArewsSYvM2zO2h18s4SGd7hw/P9rqRhaRssQXRsDtEpLslAXKCsHyARNxqreMAzOTDvBzB19B1QbQyaxxrVbAXxoxcXQj5ZiO99i0k3la7mJxMHHm/Mt75QhhtxZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012425; c=relaxed/simple;
	bh=8So5NaK4ITsWb1JLI8HHak357LS3qba3l/4eJ/fFX0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhlVDcp0+27La5ZvKfPHF/VfZyk2yPSnwS2JrXx+POXa7lWW2AJbBBUs6QvOgRtropAk4LBi55xW5ZDoSzkgcla1YUbl6R/OE4eH68B+5ax/Tv0HLBdcxNMxxo7rVhKKzBDM2o6euAZD0pKxFPWcmoT7HSjKL1vY4kWtZn8YiD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AWifIMU0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23dd9ae5aacso29155ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752012423; x=1752617223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8So5NaK4ITsWb1JLI8HHak357LS3qba3l/4eJ/fFX0Q=;
        b=AWifIMU0qbggEc+QRkSmTUXDbLnleSWDdSpVtRTxpCqAVRdqYTVw/OdiEdJBGHVt4C
         05Kv363SRtN9Opu2bTAo9J8wwMoyq23nIMnBzL/XbMimYMuJr4kcShIfC+R+R7PFRd5k
         Pd/a/uuIMjs6r28H30INam3tYOALXX7rY4G9kmozJ68N7bNiHLsJPmDYHL/2nbRFhgdS
         cUr6142j6eWN9UzLeFKUK3zfxJgvn8lPnNvJ62WkjHF1AZ82p2aB3KCkG1mcmmyrzENy
         uq4wllhMPkCHG7+ycs8G3CJYLrziCKqVP7V1VCwQR4Aohi7Q+OcDJrf5C4ioSskQPeYb
         QWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752012423; x=1752617223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8So5NaK4ITsWb1JLI8HHak357LS3qba3l/4eJ/fFX0Q=;
        b=ifDih+Lh7C0AaevkpGquu/H5r28DPaviorqY6TEy45+OevEGnMLdynQsfc+xQcen8P
         qj95qjf0nHgH9QMZYdApMiaXmdL+VnYphdevuVvHbT1TZhV3scNuWmWqccOuXPLS3N8+
         xdg2Yp3TAv6Od49lOVqjIUJ1cozMfk+6kdS7/CiurYG3kDQfJE+cu/o182FB+h1tlYe2
         lCN/ff2IhhLE+6tBjS+zyXQN+pyAZgugEn95IFZBv20MM6nmzeP/ky7Eg9loYixGysGU
         62jRs8RYMGRJNbHf/j/oCaAsBBNda0Ft3VxwzRpLj1Aqtsnr+/ROq4A+VDYR0sijzATo
         sHOw==
X-Forwarded-Encrypted: i=1; AJvYcCVdwQg06vH6KTvDTcrae7ivVwh8aiOb02T3UD9n12JLerkWmuHD2gjLevaFdbuUii9yAzjPKuvdz20ZgPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvNjxojIme1mkROvv61NuZMHQly8JJhq/nqBjew//5ttcX2DFm
	7M2/6UrN64+WnG1tzjJHASytskBF9lsOv7L9yc3BsAhOK32GOfzXXQ6DVeY0c/LjhVn4WOXo1Uz
	3/rWFMqhhoWFISMUEMz7jCAUt0HdCX8YfJxuNOW/g
X-Gm-Gg: ASbGncukCXL5v66AY6YmajesXkwkapVp/TZ/F+kmxxX+mUc90vc7JSOAa0j1/vs+xY+
	IJyDiVCdTAORGiF0KpHXu3Ulrw727or9TQOpnM66uVj446RwU/uXE8NhqnbNvjm0fvVFBmQfT/J
	EEelCb4cDLMmuxjTi2XoK9ezg7MUTY338hgF3/FpZceOoQXVFO5XT6bo/WM3dMrfRwoW7MGEM+F
	Q==
X-Google-Smtp-Source: AGHT+IH5IJ8HNpiEZYh10CbJaxAjkSsuUHlgnKX1sWoyaldsn92XCiQJMnHWi4rJqpPBxJr8CCqNIm9QU70Iyr1i6Zo=
X-Received: by 2002:a17:902:c942:b0:231:eedd:de3a with SMTP id
 d9443c01a7336-23ddae0b0c3mr296315ad.25.1752012422906; Tue, 08 Jul 2025
 15:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424030033.32635-1-yan.y.zhao@intel.com> <20250424030428.32687-1-yan.y.zhao@intel.com>
 <aGzbWhEPhL/NjyQW@yzhao56-desk.sh.intel.com> <9259fbcd6db7853d8bf3e1e0b70efdbb8ce258f8.camel@intel.com>
 <CAGtprH8jTnuHtx1cMOT541r3igNA6=LbguXeJJOzzChYU_099Q@mail.gmail.com> <c22f5684460f4e6a0adac3ff11f15b840b451d84.camel@intel.com>
In-Reply-To: <c22f5684460f4e6a0adac3ff11f15b840b451d84.camel@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 8 Jul 2025 15:06:51 -0700
X-Gm-Features: Ac12FXxX5qmy6UxKfBIguibLuIDgqriyu2oK_ekMZ1Ln0SJA-JjHUtRtOLOejns
Message-ID: <CAGtprH_tgn1Xn-OGAGG_3b2chOZBkd4oO9oxjH5ZMF7w_kV=8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 02/21] x86/virt/tdx: Enhance tdh_mem_page_aug() to
 support huge pages
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
	"Shutemov, Kirill" <kirill.shutemov@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"david@redhat.com" <david@redhat.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>, 
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "tabba@google.com" <tabba@google.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"seanjc@google.com" <seanjc@google.com>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "Peng, Chao P" <chao.p.peng@intel.com>, "Du, Fan" <fan.du@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "jroedel@suse.de" <jroedel@suse.de>, 
	"Miao, Jun" <jun.miao@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 8:32=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Tue, 2025-07-08 at 08:29 -0700, Vishal Annapurve wrote:
> > > The original seamcall wrapper patches used "u64 hpa", etc everywhere.=
 The
> > > feedback was that it was too error prone to not have types. We looked=
 at
> > > using
> > > kvm types (hpa_t, etc), but the type checking was still just surface =
level
> > > [0].
> > >
> > > So the goal is to reduce errors and improve code readability. We can
> > > consider
> > > breaking symmetry if it is better that way. In this case though, why =
not use
> > > struct folio?
> >
> > My vote would be to prefer using "hpa" and not rely on folio/page
> > structs for guest_memfd allocated memory wherever possible.
>
> Is this because you want to enable struct page-less gmemfd in the future?

Yes. That's the only reason.

