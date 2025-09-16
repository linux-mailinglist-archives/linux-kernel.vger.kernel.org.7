Return-Path: <linux-kernel+bounces-818174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC3EB58DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA331888162
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5C4286D53;
	Tue, 16 Sep 2025 05:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+JIRmUT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE32397BF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758000271; cv=none; b=oOiKWYpxmGTM+Edv5yFaT4H5AkhTHi+uzoXEV10K9fW+McYx1z1SlihVEGg+5at2KMtZjL/hb3rLT93iFJ3EkllL9y+qLxra/rDSo1zlBNN3+QgAdQZlDJeZIbN74RgR4E4f0vseolDrYniz1R2bjvfS8S4JI+uZ5e425+pPZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758000271; c=relaxed/simple;
	bh=fSDgE0WwIFXT6uHfPLpNlUzATNd/U7upEU3qgEAh4yw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=s42vohlbXNcSNHtHas8uPdgKcAj0NN/svnxSAxdnRMmMzQCJPAASFrPM2j+Z/VFMasvCnqH3sRyCXGcciXk8+T5htf1UxWf1h/0lv8Dwhf/lL3Uy/H9md8PaJKs//6J8n2qEEO5scrZBBL60cVj4YBk9zA6rQ9zsokhNnvwtrf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+JIRmUT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758000267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSDgE0WwIFXT6uHfPLpNlUzATNd/U7upEU3qgEAh4yw=;
	b=W+JIRmUTRSHJ1K2MrXUFJRrL7kn4r7aGL81X/+8MVbRO2hC8/u+rtjHflCOB69uHqid6/T
	wzE6vSX3w2lQqLB1v+g7fW9VIjBj9fJzY+vyUuBS7sCyz6m971qWL2QAJhhopgS9aQnqcB
	VefC2A3ttd1Ar1ZnVjCpu9O6JdV204I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-BTsqkgIzNKqgbPSSuSxSEg-1; Tue, 16 Sep 2025 01:24:20 -0400
X-MC-Unique: BTsqkgIzNKqgbPSSuSxSEg-1
X-Mimecast-MFC-AGG-ID: BTsqkgIzNKqgbPSSuSxSEg_1758000259
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b0787ffa053so462742766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758000259; x=1758605059;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fSDgE0WwIFXT6uHfPLpNlUzATNd/U7upEU3qgEAh4yw=;
        b=qNKM7uFHvNM26OoblApJ6WDvuFiqVX0JHlgvm77gizX2h27gehOVSNnXct9Kty0bho
         nUcaQA9/sBvjsjLHFwDgQsg2TjrFju2wJQ8AeiVSCj7MAWFYyOrZYebB+Nw04lWoHKX8
         ww3ac1nPZbL1W+vpZDuIaPXXe3QQ27Z+DEvbwUqk2f4fyIPwfEm+w7ee4U4Q4MELDdf8
         yzsod5kRuVFsllgRZM25d6BaK4K7HDjrjyJxBSDbR4R1gImDC1pkji5I6tMhqiW12ykt
         +6Zj65RjM1aV4xupWdBB7sn1JfexJFobi6M+Ydj1sO+GuUzCNJSg0DHPbGx9pBWza8Rs
         eF2g==
X-Gm-Message-State: AOJu0YxbZF30CCZs3iwm/VQIclzPNISQ9Rixoyf+LHwYdLhy2a3pspo4
	Vu3xpypinp8ZJjCkwJm3pMHm5m2xONNP1erxio/dfpUemJvUMG1HOT5S0PrLKkrbgGhoTx8N0Qx
	n5c4CWksSZb/48IiuLFueZRpmBOzAgLiFXO4fqPUHSS0d2t6hQMMTl1dleZ9MeAOLJg==
X-Gm-Gg: ASbGncubKPnFVry8KcY9mznJX9zNkbvDkFizkfb9DrzKDdPmlD5h4JyicIQ1GIRQ0ja
	t9FpNQGV2n72UrfBMSeK3zUgRkQDM9B+Akqj5Ggns6b2gAtJe5ZbPLKFjN+sRkQVB8LydmrFJ4h
	+EyQygIxE+yZC6nBxzkY+GEaNaBjNjCfIDGop8326UPuI2XDd4960CFc6GjVZoYArmUcUsiagDh
	Nc1hHlG+Kna4BjTO4EaCrvDdVgPun9t24i+oKYsC4tRNPA4Pm9F9xeOy7b1XWNGACQPdg94E87o
	TRH9f2i9z23/gDfnN9C2QbUpij1mJenI4nut
X-Received: by 2002:a17:907:5c2:b0:b07:de92:5d30 with SMTP id a640c23a62f3a-b16816eb043mr116859466b.29.1758000258850;
        Mon, 15 Sep 2025 22:24:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpRJXLmwDygmuTRxR8/qr1WcCiqAA8xXb+LglZycV/TDvFGuWlK07fmfIigTm3wKNUnW7clA==
X-Received: by 2002:a17:907:5c2:b0:b07:de92:5d30 with SMTP id a640c23a62f3a-b16816eb043mr116856866b.29.1758000258362;
        Mon, 15 Sep 2025 22:24:18 -0700 (PDT)
Received: from [127.0.0.1] ([195.174.132.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd413sm1099376966b.71.2025.09.15.22.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 22:24:18 -0700 (PDT)
Date: Tue, 16 Sep 2025 05:24:16 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Akhilesh Patil <akhilesh@ee.iitb.ac.in>,
	Nam Cao <namcao@linutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>,
	Zhen Ni <zhen.ni@easystack.cn>
Message-ID: <a3563dcd-80e1-4091-87ae-f1ce1e22bf6e@redhat.com>
In-Reply-To: <20250915192527.38f80056@gandalf.local.home>
References: <20250915073529.20364-2-gmonaco@redhat.com> <20250915192527.38f80056@gandalf.local.home>
Subject: Re: [GIT PULL] rv fixes for 6.17-rc7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <a3563dcd-80e1-4091-87ae-f1ce1e22bf6e@redhat.com>

2025-09-15T23:24:35Z Steven Rostedt <rostedt@goodmis.org>:

> On Mon, 15 Sep 2025 09:35:30 +0200
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>
>> Steve,
>>
>
> Hi Gabriele,
>
>> The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25=
c6c:
>>
>> =C2=A0 Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)
>>
>> are available in the Git repository at:
>>
>> =C2=A0 git@gitlab.com:glemco/linux tags/rv-6.17-rc7
>
> Note, the above git path requires having a git account and permission to
> your repo. Is your repo public? I can't even see it on:
>
> =C2=A0 https://github.com/glemco?tab=3Drepositories
>

Hi Steve,

note the link above is gitLab:

https://gitlab.com/glemco/linux/-/tree/rv-6.17-rc7?ref_type=3Dtags

and yes it's public.
But sure I'll switch to kernel.org as soon as I get an account.

> Also, it shouldn't be "tags/", just show the tag itself.

Mmh, I used the git request-pull [1] command and that's what it produces. I=
 guess I'll go back to a hand crafted message, then.

Thanks,
Gabriele

[1] - https://git-scm.com/docs/git-request-pull


