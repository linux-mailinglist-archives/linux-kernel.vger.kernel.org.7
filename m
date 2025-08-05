Return-Path: <linux-kernel+bounces-756752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4B5B1B8D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891003ADE09
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2C7293C67;
	Tue,  5 Aug 2025 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1UIN4ta"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F3E21A928
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412720; cv=none; b=WvKM7g6ymRyESXbmEEtnGrbx/ivQjArGG1ub/dq+flNhUzolz/LYTWP+KAnJOHFX2UDGOq/YP093gG6IpfD74n+HyCRES2Ock5cBJRW5kD0q5sATFwRJ3ai2IFtzZJZ66l8pEJOX40Y+PpAP+Y8WQtVarqRbRH599L6WxyyQPAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412720; c=relaxed/simple;
	bh=TtQz9oZBcUxEy3cvbREKfQnFEd4wyNFsn45a039ZSW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfifFF2MrUn+oXJQ46iO9Jjm7jnzpXb017GovU+oHGKFX7trNa5VRkRnffEHQ1dvEoSRvgcTuu8oMowce37S4qtbRzX1LuXUsSlM+RMv3XdsgPeoFqtDB5rkYwpnhqa/3E8mMm6KGGyKz9rYdhAz+7CNlVE6ykgHceMFOg2HLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1UIN4ta; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b785a69454so2880033f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754412717; x=1755017517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdp2THZ+E1qrWvs/TZoDbRRKtgHUJqw+d2seDNABwpY=;
        b=H1UIN4taqdSD/MbvAOsX7xQ53g4YfIVi88bDBVbvVx1VLO0tE7HGOc0rVybZYljAB1
         wb9kUnNlP0E02irXTKZjxH7dWQt65vGxzFYF+GX4ZDrDLSY6zF4UPBqHeeR0IJrG0oWt
         Q/KsLloTjQxmW492ypsNBcPJoCWbJtRcDI+SEB/tSMoL0OB4hRHQajfTb7pvt5H00YTR
         DDsT0xoG7ZKezVqfPHonW8NzAf5yYNoA4lLByMTZCITDKGTqR0E0I8e/mCn6dGG+K3nk
         RZDWTsUNbeh4hQzDvxmgEGc5BCg2WmdRNOTXxIV6Bh0rJpSHxPJYC3VbNT4Zxd+F5kaW
         XdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754412717; x=1755017517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdp2THZ+E1qrWvs/TZoDbRRKtgHUJqw+d2seDNABwpY=;
        b=hCNhQYNNwiYCn9LcGR1DfO14cy+UfLhtxU2KzXr4spTDyYXf5ah89fHCe0cuZAMNzC
         kli7wRbnUlbrL9GtLgLOC+POdtFlCp7rB87Bdl3IivPgP/iv8sZAGZh5apyMcxh12fwv
         iH0pCr+hWKzlTLE6caxDhFCUtOOB4ZHIsMIm+dkuvd77cadrLBLO8ZdSq+4TiNQKPwLY
         2HPxrQ+AIPsiyLJNIdEOI29Vzy2P74QdFIEpesGjeFZCRBhWSIcwAdQ/ptXD/n8yVIdF
         BK8mG4N0sr796aqsI0Adt1j2t01HgpDQYdzxYrotswUgea5NFP60bZUV/kQ3iStDBoVW
         6gKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVAJmgz0AC1GYrlzRGfjSla2S5PdBOroLNl9sqynvIscWpdEv6UYEqX8cHBla1uFN6Mg18q7iSmTFMHHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLR4x7Tsc1Mb9ht9sq5pmPqerqDmt+PmbJwO+8Ge6ae7UtVs3k
	ompg8YNSqyQB1NopOWhIbf+oieNqh3anfP9A+D5FvRhu4xIzKYqoqBKNaCMRkz++dV55r16HTH9
	D+CjWaOn+FrXKBUFVsVd4fXXzc7GJVEz8CTT1idCm
X-Gm-Gg: ASbGncvmBIVMVtmzs8uKDfc/BfKkq96BmRht3Qp/qdAsrV5DCDjQb479JxxTYn0dLlo
	HOj7L8zlWdtDMzTeoIrEYANbt+Erzu0df6f8wBzpdWk9+Iz3wQfA8607a6in42c7UG32dMp4pQY
	JwCy21APMdZW6WYCHWd7/XKOy/j1I6iU1CgGZJTKBYgqjcOfv5wAQp8trrq7NJi8cpaUtkXiuZf
	TgIpg/Y
X-Google-Smtp-Source: AGHT+IGCJi6AAfzPaIlWNF5t//K43GKbKBI8wrg/kqvHP0TtvUzS781NSDVS2jaYJIrQrznLTHRuQGhHzTOhedemSVQ=
X-Received: by 2002:a05:6000:18a6:b0:3b8:f356:a2a9 with SMTP id
 ffacd0b85a97d-3b8f356a2demr395048f8f.46.1754412716960; Tue, 05 Aug 2025
 09:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805013629.47629-1-sudarsanm@google.com> <24bbd9df-efa7-4090-a696-1eb40904ad85@redhat.com>
In-Reply-To: <24bbd9df-efa7-4090-a696-1eb40904ad85@redhat.com>
From: Sudarsan Mahendran <sudarsanm@google.com>
Date: Tue, 5 Aug 2025 09:51:19 -0700
X-Gm-Features: Ac12FXxbwVDLUIinZ5AcPHR32UCRbFB-2WNiOt5M-pCIiVirC4bpkJyI48QVUN0
Message-ID: <CAA9mObD9zr8Y8Z4F7OZGi_NiPfSZxUu3gKNWPQYRAeBFQBO=SQ@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/mm: pass filename as input param to
 VM_PFNMAP tests
To: David Hildenbrand <david@redhat.com>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks David for your insightful review comments.


On Tue, Aug 5, 2025 at 1:47=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.08.25 03:36, Sudarsan Mahendran wrote:
> > Enable these tests to be run on other pfnmap'ed memory like
> > NVIDIA's EGM.
> >
> > Add '--' as a separator to pass in file path. This allows
> > passing of cmd line arguments to kselftest_harness.
> > Use '/dev/mem' as default filename.
> >
> > Existing test passes:
> >       pfnmap
> >       TAP version 13
> >       1..6
> >       # Starting 6 tests from 1 test cases.
> >       # PASSED: 6 / 6 tests passed.
> >       # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> >
> > Pass params to kselftest_harness:
> >       pfnmap -r pfnmap:mremap_fixed
> >       TAP version 13
> >       1..1
> >       # Starting 1 tests from 1 test cases.
> >       #  RUN           pfnmap.mremap_fixed ...
> >       #            OK  pfnmap.mremap_fixed
> >       ok 1 pfnmap.mremap_fixed
> >       # PASSED: 1 / 1 tests passed.
> >       # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> >
> > Pass non-existent file name as input:
> >       pfnmap -- /dev/blah
> >       TAP version 13
> >       1..6
> >       # Starting 6 tests from 1 test cases.
> >       #  RUN           pfnmap.madvise_disallowed ...
> >       #      SKIP      Cannot open '/dev/blah'
> >
> > Pass non pfnmap'ed file as input:
> >       pfnmap -r pfnmap.madvise_disallowed -- randfile.txt
> >       TAP version 13
> >       1..1
> >       # Starting 1 tests from 1 test cases.
> >       #  RUN           pfnmap.madvise_disallowed ...
> >       #      SKIP      Invalid file: 'randfile.txt'. Not pfnmap'ed
> >
> > Signed-off-by: Sudarsan Mahendran <sudarsanm@google.com>
> > ---
>
> Thanks!
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> --
> Cheers,
>
> David / dhildenb
>

