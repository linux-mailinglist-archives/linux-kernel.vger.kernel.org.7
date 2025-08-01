Return-Path: <linux-kernel+bounces-752761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A765B17A91
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16387B02DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE24BA4A;
	Fri,  1 Aug 2025 00:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XTI220zo"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7382581
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007634; cv=none; b=VwYhTn866BqUjscU178s54tcC9Wgbj7w3PWEm4RVVKCj2DLMGe1Wyp/+Qg57Ma/g2sfyAmQc3jEObV0hAHOhtuzWpLVRA+l3cBw3YBw0EPcea7DvYdH8N0QHTOGs+FGz5OrmSg278SCRH4AMcF6qTc8BsvMb4AVdbWM6lDxXnXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007634; c=relaxed/simple;
	bh=pNB7Jz1zScMDFfs0rZoZMRdIEP+98i95rIMN/mYlt4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCVIbvsPOj9xqAHW1k3kgV1t9kb8DLBwTBHIIb8yf43Sav7duO8LHuX7xtHIF1Jxq9A6KJRu4hxiU1abtbWSWRxaZqw2euCRa5+nn2bg8qR5Xd35sSqgXoR6B27xoVn5a21zcYr2na8X5gdbCaTQPUQXqVugDVuP6+g5/egvtLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XTI220zo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24070ef9e2eso71595ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754007633; x=1754612433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNB7Jz1zScMDFfs0rZoZMRdIEP+98i95rIMN/mYlt4g=;
        b=XTI220zohvGiCsLMvom+pMEsfPFrOGPhjbsg0BFC3RCtvfC4pIEMERXKfdPDaZvST/
         vmFRe/pCuoCgYTZ5MZqcFgQrqv7/plOGlM8ENnFQRpwxULRZMozd/fts2xq7oRZOGbts
         jawNHQG65bToWkcRr2DYS8io0/v1E5MJwnCTSc2I81V2hLMGPlUGFXLOtwMfnZOASZVa
         VXnZuMzzQclRgJ8JbZ+tZIIghHWzDozvALCQpNVHgCYgOWPY3Z8hqyVuzlK7/Zvq4ehV
         VWFhwPTvZjI+4/jkeqToM4EgXCQgPJBLV50g4VCfSfCiF9Ul0X/Xa3D/d5RTdjZqNI6x
         W1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754007633; x=1754612433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNB7Jz1zScMDFfs0rZoZMRdIEP+98i95rIMN/mYlt4g=;
        b=s0F+TUyUZsd6sIbq8kMtKf+EMEKsVEL8rTLq8I8s0Bsp3UgO3MsHhR/Rum02GeAZKZ
         LFdpq61HjmWl/FrXK7zUVcXBvWntkgi8emwCxZlaW+HzSQG8Poo9fwKFpx1Va11b6Aol
         zJClJbUgN9OD0y0Vz1gYX4ftzZXWOqQ5nDHKo4xgJSsWuKzGevhgStIdrVoBIhWIuGLL
         ZFubGygMnP3EL1/NKjy/aGpjkwWXFLRP0uKJPUbmkl05phYgLue99bmYQKDCGiLmrUgT
         MxkrbblHwnY3H9j8C65CD8Q1XqcyRnlxTyH9+YJtJYrd5FaRyVlV/THaaTDiD+t/hoNI
         yZ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhUcVRMpCqkHWkGocMUVqfML2WqStlYIKZhP5G42NOM17sRo8S9et5uhCkXTgFD/po6ZrKxas9r5aI3Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/luLZMIwplJzX6WZRUTbXBQqwu/wEk48wmYcuUdHAxXXKrjI
	3wO77wtVbpL/c6+cfQ8ih4eHqW+aSV7zyaw8UgurH0ntDzZX8lglZ+2vFKYmjSmXJDrjtLYFt2w
	Zsps8bHAQq0ArYOOw6mDgmbpgqdDzqhzMgG2fMZI8
X-Gm-Gg: ASbGnctxbtx7hTzrGuNriAy8YIuVR/nbIsZ2yJ0nXHHnGpg5M4PN4pzL+6jO3stfcq+
	RR6HPJ4sRyNbLOyYNMnXJYKOLbPtB6amhVandli1FGQ+bv6zsTs3GGGjUnXQSAITFS+BS3HM1Wa
	5EWTVkFNEdrGU76VHUrOheb8uZOY/NpJf25jktbC0XJ1teE48Y7aAXfs2AtIZbFNZvd21Ehnbfs
	tI6
X-Google-Smtp-Source: AGHT+IGDNTpuGVYj629USNLNeLL0siDgIzRTNjyg8lKmShUIJzDxKbLaciUPqUZUh7MiGlrWcRaOPFqL3XPjnpsCEO0=
X-Received: by 2002:a17:902:f689:b0:234:bfa1:da3e with SMTP id
 d9443c01a7336-2422a3269f5mr903815ad.5.1754007632274; Thu, 31 Jul 2025
 17:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722205357.3347626-5-samitolvanen@google.com>
 <20250722205357.3347626-8-samitolvanen@google.com> <CAADnVQ+FeGjNAJFyvpF_POB8tZUMXDN3cz_oBFNZZS_jOMXSAQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+FeGjNAJFyvpF_POB8tZUMXDN3cz_oBFNZZS_jOMXSAQ@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 31 Jul 2025 17:19:55 -0700
X-Gm-Features: Ac12FXxGz4A0byvVJth-oygtQdLKvl3dv5m_3xt8Zj3SIwF40d5KdT8i3auolbs
Message-ID: <CABCJKudX80K5VazPgHAmVd7yBFVeNY7hRm_xF-i1JKaWs-4RXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v13 3/3] arm64/cfi,bpf: Support kCFI + BPF on arm64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Maxwell Bland <mbland@motorola.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	Dao Huang <huangdao1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 31, 2025 at 11:39=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Unfortunately there is a conflict. Please respin.

Rebased: https://lore.kernel.org/bpf/20250801001004.1859976-5-samitolvanen@=
google.com/

Sami

