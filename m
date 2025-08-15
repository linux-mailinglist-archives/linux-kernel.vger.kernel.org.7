Return-Path: <linux-kernel+bounces-770246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE587B278ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B398AA0422
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1372829614F;
	Fri, 15 Aug 2025 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWLVMX/z"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57CF280037;
	Fri, 15 Aug 2025 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238472; cv=none; b=MlV9dIRMtLYFgPeGp8m/Infl9F/YzxlNbUgRHynRo1N/ba3WwI+haUV3J8jpdD88IVylf98yco/KoC2dFGMhkELGu5pwKtbE0rkBZosPvyTVwCa5QuANwa+3vyhQCahgy36We7KlfVwEhURjz3aQMYMakbxAobL5n3omtC9NCJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238472; c=relaxed/simple;
	bh=juAK6C8QbNuY02ZQECecfitY90SDBcEZK0IXBgIcZ3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1z4lYyuur21xJyiRb2kOtKjYbbTj8pX+D9DaKFm+TQw2li66V5KXjC9/ZHWPU2E+0NolGRCAWImmcs2aSitV1gEVDeQQdxxXSmkGM7ISrAOogIbHwFk7p4okiNsZ4EzKGkxhYrE6xUv+JkQLATA0J1CzHknVlcdjASNj/UUgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWLVMX/z; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso1356118f8f.3;
        Thu, 14 Aug 2025 23:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755238469; x=1755843269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RC3G8Ydq/hH7/R8jIdeAziyUg1MV8Z+nvGhUkoaFFOw=;
        b=KWLVMX/zx8Ny5wi4Svf3ECDkq0Lw7Qk26VLi8gRX5xiiuuyURlIAoh5CH0uvwMtDWv
         Us37HOcAN673jqNE7WEMP6yU+3qK/dshj6XKKoxWODz4rPMxDgqsMExRUUsKm5RMGIpk
         mTXvVGFqV6tkLaKFleCcIU7YLhhPoB3qUdzBHdpnwHLU7kJlKtWP8ZdTuLltOh+WEMw3
         DCG2dLzZ1cARi/rTaydosxgkKi+rmWc0q9zODLb3ROtfaS7ouHdVEu4LWzdwUsxldJsT
         mxmSvPRSYJE8MS+Mc4clVNERx6i59s2gRMfaNIbsxyEwv2r7ccMAXn1f7Us2+cwrHlPW
         rRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238469; x=1755843269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RC3G8Ydq/hH7/R8jIdeAziyUg1MV8Z+nvGhUkoaFFOw=;
        b=OenzhbUPTyNSKtKHRxk59r+2kSmaKo9Ewj1qEKMoPnyPG/8sHArZ8HXGddZoOCqtIY
         XewfRMXkdcQRp9a4+xJLOM7GM4eWpq3PJM84hiRu7wcJK7brVFT10NFbj4n0fp14Eh+E
         mqh1gpW1IIt9/u6SeGpU6kr5OgWXgLzOKlsx4xecetoliRZXwnZyy6DiAYb6Ev8ARNUF
         v95GtOiYf5Xft553IdzGdVyhSjonHTwFGytoiIAOnvWai4HtUXcwNFt1cvA1iAjN4/YV
         Z7Qpz9hk+wuDPKNk3E/koYojUIcRGSySEdkTf/n3AlrZHGWifM36dX9Khyu4yIEVeYqj
         M13g==
X-Forwarded-Encrypted: i=1; AJvYcCUZibmmAmJO7c/6iSYcHrWi48jr4TpJoCKQr0rrEAR1881u3zNonqXsrBVf7n9GsK0YFIY91w40/1q0tn9r@vger.kernel.org, AJvYcCX4pYEwQoXjsDhRzX3xFcYxhRg1dvuVjFVTgL4loWuhIlV1SjLhcEMpJN6z7w55EyI+S5W7jlUeb3tj@vger.kernel.org, AJvYcCXwJGlnGaarzp4FeRN2x9t1m2BkFDtga+yvfhzrAeByb4voZqZN57PkrBq4xD37sSsrzqa1s9mn1jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjAYNPePEks3GFih+J7A2rq8w8vyCXOa+HpeLYiyyfmKji6yw4
	S5YIMAyExUrgVY70AeWsFkB5Qd/m/o/qkPV1zz7sg2UYpXH1fI2smz/aUN8pElZxa/TAX2CfErN
	pT/g7+QEiyr6ALIEZGgiYu9QBuraYlmE=
X-Gm-Gg: ASbGncuis7ZhMPevvPtxkhKvNu/xAZiNwK2kvWAGXDUQzkVk3DfNwbqmysihQTzcRsT
	9Ve4JdcmjJb9TIQBJ+GsC3JfZ4suMjYvVb7395mK2m7AcMVY7rE5y0Elt0+U67nT13be99UBXP6
	mCAzNQ+6jticPm7at984UhUi+7+f8v3nwk4rpJ1XQYaaj0rQLhtjTIj5LRShxKOIMl0cJn5I1cj
	bIf28Ni
X-Google-Smtp-Source: AGHT+IGcfJRbvVjPwlmwrtipABpPT2k1A2y354zwiag+PFS0u1nqei6MBVPlvAO14bH2h8cPLQmeAXffrbKgUI/mnik=
X-Received: by 2002:a05:6000:2584:b0:3b7:8a49:eed0 with SMTP id
 ffacd0b85a97d-3bb671f56demr475473f8f.22.1755238468843; Thu, 14 Aug 2025
 23:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813175335.3980268-1-yeoreum.yun@arm.com> <20250813175335.3980268-3-yeoreum.yun@arm.com>
 <CA+fCnZeT2J7W62Ydv0AuDLC13wO-VrH1Q_uqhkZbGLqc4Ktf5g@mail.gmail.com> <aJ3E7u5ENWTjC4ZM@e129823.arm.com>
In-Reply-To: <aJ3E7u5ENWTjC4ZM@e129823.arm.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 15 Aug 2025 08:14:18 +0200
X-Gm-Features: Ac12FXzA1cRDanNY9nNRCdMRqZ-71xbNZTcaUrUR9hUEP-TJh9C4NEiHu1Mi5Xw
Message-ID: <CA+fCnZdFVxmSBO9WnhwcuwggqxAL-Z2JB4BONWNd0rkfUem1pQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kasan: apply store-only mode in kasan kunit testcases
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, catalin.marinas@arm.com, 
	will@kernel.org, akpm@linux-foundation.org, scott@os.amperecomputing.com, 
	jhubbard@nvidia.com, pankaj.gupta@amd.com, leitao@debian.org, 
	kaleshsingh@google.com, maz@kernel.org, broonie@kernel.org, 
	oliver.upton@linux.dev, james.morse@arm.com, ardb@kernel.org, 
	hardevsinh.palaniya@siliconsignals.io, david@redhat.com, 
	yang@os.amperecomputing.com, kasan-dev@googlegroups.com, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 1:14=E2=80=AFPM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
>
> > > +/*
> > > + * KUNIT_EXPECT_KASAN_SUCCESS - check that the executed expression d=
oesn't
> > > + * produces a KASAN report; causes a KUnit test failure otherwise.
> >
> > Should be no need for this, the existing functionality already checks
> > that there are no reports outside of KUNIT_EXPECT_KASAN_FAIL().
>
> This is function's purpose is to print failure situtations:
>   - KASAN should reports but no report is found.
>   - KASAN shouldn't report but there report is found.
>
> To print the second error, the "TEMPLATE" macro is added.
> not just checking the no report but to check whether report was
> generated as expected.

There's no need to an explicit wrapper for detecting the second case.
If there's a KASAN report printed outside of
KUNIT_EXPECT_KASAN_FAIL(), either the next KUNIT_EXPECT_KASAN_FAIL()
or kasan_test_exit() will detect this.

