Return-Path: <linux-kernel+bounces-770147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72214B277AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91ED603B27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DE9223DFB;
	Fri, 15 Aug 2025 04:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M15DhATI"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFF81DA55
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 04:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755231296; cv=none; b=pYMtCXxbCbd7cXi9IyNUdgNfYcPp228toMJA40oz7210q/xeOihnLh9CdjyWELcHpGfS0LvCgBUQyfpBvr3h5B7hhYnKiQo5w7Sji3ZkgYnDuTGV/fRu69y82Ol6OCTxArkWDIiD5D3wEEwBi6jZrQela+ieiz2USl/DiHgBJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755231296; c=relaxed/simple;
	bh=MqO7WvtgNbZKWD8uq2q1m3YqKMotdAclfYip+JQ1678=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZ7Tb2aLlngrPLeEXLWKwGcahP4AvrVb5schld6Z4TVOZLCACdkgC3tHMt/zuONlsdx9xzTNBcxHV/EdiMMCLaGuVAjZxHy+ux+ecc/JULnR7s7HfWa4UAStqAsfDUhWAY68Pr62dcTnerSnW+Eh66I56iaF1JLHWQVc/ZB7+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M15DhATI; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b0bf04716aso119361cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 21:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755231294; x=1755836094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/Wbp411RtpskyWq9UJk+ehIJ35XDzwl3pNsoidpEgk=;
        b=M15DhATIg9ZLyITdlZ8kuJAVFEJjNZOgOMXgTCMbKXfw/mXLtLXsreTlkbZQ+ZwzLk
         3ZOzcJcPq+8uFZ9YQM5tnJaA9mMnnekRnwx/lpuCb34JRd7VyvFEjMkGIpd6AHMW9DCT
         itWUewzkFpr4lWdHCSLdZB0ukDw8P12E4hIlisn38BJX2faU+8HWLYM2sJrUhcuhwr7/
         sfEu4iNPq4qA7IwsO3NOIfFBT3sSioqaII0d+M1s8IxoB7rUZ9Lvldf6SrhHy9Kbx7Gn
         b80WtUk3gaNKMytTZ781TsRGiVSSC4ZmywdVdfhsRU2z4oXUKKAuMuDrg+06H5CgoWsU
         U55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755231294; x=1755836094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/Wbp411RtpskyWq9UJk+ehIJ35XDzwl3pNsoidpEgk=;
        b=u0coeLT9Ga182erxPg5lRaBQSCZ+cj7hkh1cpCGstYPh+7gkjveoDgmnh6ep3Yd+4o
         iDys195nH9/VRmyAzZMcHwKJY27OmwvgVCCfC3LH1Rd3r74ykhawlXqFu7H7sUk6iRmL
         amXoQ1jxwq/hTjpIXk7QnSeSy4ExYJhyLXGb2FSaK690h4gNStveBoeCoEkYUFwtC3lg
         uv8VS0HcLecLsILbvU2VKp9Q5Ncl+CF/OW9pmc120h8r5p7KqD41S9BgbDbgGGDnQo7P
         I8xFGa+ld9Tfo/LN6AFg1nPkGlUfpWQpz1O2rYZG6qG5EPxL9XU+I2NLQtxrpyyiEpSK
         +qyw==
X-Forwarded-Encrypted: i=1; AJvYcCVNbPc9SZmRGz/dczCvSMSRWoM43rcNakksTpfJYw/e0mSkBRLrmycd0FyMML/EkshGix2IgpHthZs559I=@vger.kernel.org
X-Gm-Message-State: AOJu0YycgD6SVZuC85cwohAf7rssZu2BmG0SgSmO6TfCJuSCj2QzphyV
	hTXD30vKb3RdnbETVIPnsU8ytirPnlinkOKM2drpzk5PbeFO5xLhBX+ZG88BgyGa/MyrsU2j8i9
	fh7Fr9nr3H02yDxl4lpI1i1szxRX3tNV2I9tAZhbU
X-Gm-Gg: ASbGncu1cqH+iG3n1Rl6AhxEfHvjrwrzk5DKTX9aYILWBw3PUBGGE88Hkeo8N9A3py+
	l/yPGW6QF0PopgdtOo9KFOtPU2RL1HT8uJYFjkadREn5hPkb/F1x5lGFPfNKnH/nbsL+hXJEy4s
	EVAoy73wTL8J/KyLkmSNXTL98YuapdNfTA6utO7A4EHzd+wj3xdt7FABWZ+d2pu20hPnx4MsIu8
	vbEQHccMfprNJak4gZOyrm9+6je5HQCsLw6S8+N+UmO1D/c7aKnHH5B
X-Google-Smtp-Source: AGHT+IHdLyoV1GqzsKehbtyyH1BP6XiYh4lDSXbcDsgyxiNyrdnGC60SGOUsn4ECO9SuHxVLTaL7GG8NefWkx5sU9uA=
X-Received: by 2002:ac8:5d88:0:b0:4a7:bed9:5251 with SMTP id
 d75a77b69052e-4b11b74a91fmr1955601cf.9.1755231293609; Thu, 14 Aug 2025
 21:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <aJoqqTM9zdcSx1Fi@google.com>
 <0976e0d50b1620c0118b8a5020b90f3959d47b4a.camel@intel.com> <aJpYWVvNXjsewl-b@google.com>
In-Reply-To: <aJpYWVvNXjsewl-b@google.com>
From: Sagi Shahar <sagis@google.com>
Date: Thu, 14 Aug 2025 23:14:42 -0500
X-Gm-Features: Ac12FXx7pDBZJH3JjanZX38nHfaWFcUbiCvl5vzB97rX8vXCUsDbtyyRYTosMH0
Message-ID: <CAAhR5DFFRRV9hH3VOmZqb6TArcZL0=893oi3M2rZgVC5Bu-vJg@mail.gmail.com>
Subject: Re: [PATCH v8 00/30] TDX KVM selftests
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, 
	Ryan Afranji <afranji@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>, Ira Weiny <ira.weiny@intel.com>, 
	Roger Wang <runanwang@google.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 3:53=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Aug 11, 2025, Rick P Edgecombe wrote:
> > But Sean, if you want to save some time I think we can just accelerate =
this
> > other reviewing. As far as new-fangled features, having this upstream i=
s
> > important even for that, because we are currently having to keep these =
tests
> > plus follow on tests in sync across various development branches. So ye=
a, it's
> > time to get this over the line.
>
> Yes please.  The unspoken threat in my response is that at some point I w=
ill just
> start NAKing KVM TDX patches :-D

I'm making good progress and the massive refactor is mostly complete.
I believe I should have the patches ready to review next week.

I'm also thinking that it would be easier if I split the series in 2
or possibly 3 patchset. The first one including the setup code and the
basic lifecycle test and then the rest of the tests with possibly the
guest_memfd tests in a separate series. What do you think?

