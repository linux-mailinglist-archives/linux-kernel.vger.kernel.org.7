Return-Path: <linux-kernel+bounces-810746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBDCB51EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2364E1C87D41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B9B311950;
	Wed, 10 Sep 2025 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nWWKufl0"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF0B2472BF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524736; cv=none; b=FaQYdIK+b9tFoMXXAWdgL6k9XH479/fndaKKdiptaKxmAz8dMtJZw3mkY1I4yhPs4CEpeEwUueyMu+6XuwG6ZotWSmIJmf47EwN8BP6YUr4ti8mW+LPdVcQ5NGdFivILiaMK6+v9q8VDjaO4Nrd6ZWMmX89u46Kfpuo6r/LFhAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524736; c=relaxed/simple;
	bh=8NO5AGg49+T5ajYObkd0y9xDyV0ygdMLFtI81YL8HQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1hGsP4PmOlfJMl0CLZxToeS7vT2tX9QPyU4exkNmnWGWYdh5Y82A5CtE1f9cHvirKEsVCqK/WqHPVSUbTF5U1jbI/H/Bbi0BgUKHgykw36ZRVgJuMcdDDKnmBX5EW2nAx0au2mRJIdFmepsIMvhctHnXY7ElpaYTwgucPEo7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nWWKufl0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24b2d018f92so11025ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757524734; x=1758129534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NO5AGg49+T5ajYObkd0y9xDyV0ygdMLFtI81YL8HQI=;
        b=nWWKufl0VQnPx3YMgbuHNwTTI+Fc7n9fz3C+VO8NZmfrCYh1ZmUFHdgfRsHN1t3TFk
         YmUyQVtrzjjj7c1aKjivW4UsGvOql0dL6PMSKUzOtd0jCjZF+0os5e0hPuGrwQjWuGpg
         K9JDCRr0O8eRjIxTmlKQUVP6XraOQ5UrS3Vzit9m5dW97CEIIgg2qkzyjsUXpeWqaqUE
         nF+jmIQdOTx1TXxntPd0oIRuWyL9HOt8eQCEPYmcl/E4UqtW7X2mZMMv3uF5e14WZTbY
         oi+itCTkKc880XAkHQym43G4+L8QV7NA3lsWYvXWQP/e91rm6PaGXE7J9O7cPwQA23c+
         rfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757524734; x=1758129534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NO5AGg49+T5ajYObkd0y9xDyV0ygdMLFtI81YL8HQI=;
        b=taX0s6dT2l0Jc/2ByLzLBPqb37r2ZBXZT91cnWFEPyZiEaoEuu8R9KDxehi5svZhdn
         3JgA8N5Wv1mAthGPr+PYW6sXKbwgUrXpR0qicZyDX11nTSGAEsOxI/je/yzx85wKVC+M
         2CG5BoZSDd0GqfP2jdB3Iko15HBfrp8xKv9P3Q7bFBFUYJOqhjSacJ4IYqF53JIt2W4x
         x2On3JBiYk5Oc7Jx3YfQxjIae3CMd6uBOlUGwTfNctRIx74U8lmjClVus3wLW7tiBUsm
         5DcmpHefqSPwdJOzY/nVkVe2wZdD49u7XejN0OBVsWk6GiXLUWf3ux3wo6OJppJ48pSp
         L0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUQB7+jHbyv+7uzdLsfsUHgukvU348qKKAC99X8tN5dGbm7olvlPYPxRmRta0OsuUH6X4AISjgWewk7Niw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFvfbX4L7lq+TvD9N/OvrnU33VgQB+Pmm7qCDxbHj0Rlm/2D9u
	kihsXZjg/2FyREr1Mc87s0tOI9TpFoa2TWj0S1zvPRSMAE8LEmQlwvF911Dklhq5YZnQenqYdjK
	XvRjbW+NyQh9xWzq70WViwEo/6SivTsCWCwKQBAdk
X-Gm-Gg: ASbGncuALEbBCuPN+cmLAceVR6LmPQZe3R/G2+49ZXpREoFLSl1VnE2vhnc9j4kNHyX
	8wukKvxkbXwFCPji93Y86vHr01kNbMfkqMwRtoiU8KIsLhpqrgsQm2fjmPtTMPO6nbF6YL7gzez
	OymEaCAcfDIwo72JuXlTw2+5TZ0FeegA+NxSSLk7QrlCyxH5j1LaiAg1HaoLQ/5DsKGSNQ1DSe2
	P9hFeeidu3wX4z0bO++Qiec45VL26CiMmm8y2KhV1VF3eoaV1/yv4s=
X-Google-Smtp-Source: AGHT+IHCUkd4DH5Y6JVUzen1aiRKVsuVwVddE1fVh3QxgdLia5R9VcHQ0lxR8oXmVv5fSqX3gWLykbYPG5i7ULXFWuU=
X-Received: by 2002:a17:903:32c8:b0:24c:1a94:e603 with SMTP id
 d9443c01a7336-25a7d6a471emr4327895ad.1.1757524733490; Wed, 10 Sep 2025
 10:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609191340.2051741-1-kirill.shutemov@linux.intel.com>
 <2537ad07-6e49-401b-9ffa-63a07740db4a@intel.com> <p5tqgxmmwnw2ie6ea2q7b2v7ivbsebyjpucm6csrvl2eghuzw5@bods3pzhyslj>
 <4be5db34-aadb-49e3-9a94-49d39c8bd31d@intel.com>
In-Reply-To: <4be5db34-aadb-49e3-9a94-49d39c8bd31d@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 10 Sep 2025 10:18:40 -0700
X-Gm-Features: Ac12FXwizQV2e3Qmj9lOxxFpjbgzFrxvQifAmyKv0lv5qG3kU9tlMxyMvEl_A1w
Message-ID: <CAGtprH-MnG6sxjbWZBLMM83j6mohzRvc-shv3XCJOjJWqwQzXQ@mail.gmail.com>
Subject: Re: [PATCHv2 00/12] TDX: Enable Dynamic PAMT
To: Dave Hansen <dave.hansen@intel.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, pbonzini@redhat.com, seanjc@google.com, 
	dave.hansen@linux.intel.com, rick.p.edgecombe@intel.com, 
	isaku.yamahata@intel.com, kai.huang@intel.com, yan.y.zhao@intel.com, 
	chao.gao@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 8:24=E2=80=AFAM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 9/9/25 04:16, Kiryl Shutsemau wrote:
>
> > And it is going to be very wasteful. With huge pages, in most cases, yo=
u
> > only need dynamic PAMT for control pages. You will have a lot of memory
> > sitting in stash with zero use.
>
> I think it's going to be hard to convince me without actual data on this
> one.
>

* With 1G page backing and with DPAMT entries created only for 4K EPT mappi=
ngs
- ~5MB of DPAMT memory usage for 704G guest memory size. We expect the
DPAMT memory usage to be in MBs even with 4096G guest memory size.

* With DPAMT entries created for all private memory irrespective of
mapping granularity
- DPAMT memory usage is around ~3GB for 704G guest memory size and
around ~16G for 4096G guest memory size.

For a 4TB guest memory size with 1G page backing, the DPAMT memory usage

> Even then, we're talking about 0.4% of system memory. So how much code
> and complexity are we talking about in order to save a *maximum* of 0.4%
> of system memory?
>

