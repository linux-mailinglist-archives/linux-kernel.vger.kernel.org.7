Return-Path: <linux-kernel+bounces-846991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D32CBC99A4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419CB3A6521
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76392EB873;
	Thu,  9 Oct 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/skoLTt"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19542EB5C9
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021173; cv=none; b=V3EMfPXGSaa1dfpdM9So4AJiVHUs6w1kJpIF6hkSK1dBUBYiLsCf//Z894nTQoekGXL4bzv/ZPzhl0Y5IyFa7/SHToHKYC1XmeW5c/f+PC81JeJn0e1ekS1SniHqODotxE5PQTVJkqfkn7grxCtzUG5iU6zViVUmmx1rfT0E4u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021173; c=relaxed/simple;
	bh=1YF/kfrhlYkqcLi1GXYGGuwKlO6FjjUxn/YQCxguAYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eu0lmnPYPMtoN3+PgBhJ91gf7O4vPFDZX4J1tGp2lVgskdrXDJEzy8zpmXgpKMUoOw8AtORS+y2KJCPBS5RBtkpxPi1rsyycciiaDN1fN6On6Bm84727OfIZJ78IZZj03QhxJHskvh/nJ6FvzOEWoxqanL9l/VRIe5pu2aezPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/skoLTt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so708912f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760021170; x=1760625970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YF/kfrhlYkqcLi1GXYGGuwKlO6FjjUxn/YQCxguAYc=;
        b=l/skoLTtsSA/UucDQVOiNHWgsEYQRCcS8ZWkc1mASOSqv71aYtwFAo6ksTccoWzYug
         amOJ1P/8mPT4NyxzR+gFcl8iqWBPsb6zDsNDOB+nKSoSLuu46i/FKa+M3Hx8eSc1AT+4
         ilRN2Zl4DapRlxp8w9Sp0fRsuf7gnEddd893M38CXJs4Jv4QzOP+5vG1ELbSepxF30nM
         7jmTEnGX7MwTA/03p/IRive3bLnAKvwF++uv9k/p9b1yK3Bk0S2OT39SzpMywoq956G/
         TfN4GFfC/3AWg3AU3QSdrl/XCYKSog+STmZWpEajdH5E7lFh+FwgfjoAd8yW499Xifjb
         LZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021170; x=1760625970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YF/kfrhlYkqcLi1GXYGGuwKlO6FjjUxn/YQCxguAYc=;
        b=PZBPqEDuzS+LCDpoiC01Cz5Kf4An7QSFpwoVHgPkVO2Oj/9tbEEiEl30nbkZSpGb9u
         OB6gFwRDCkXonUGaI3Y/nqbtWyXj8nDNx6Yfe4Bv6x+ucgzgghHqJFt9DeOQMDbl+Vqp
         TrmIINfBFszv0ZzwE8nYKtlCiEeSftvPFTRqhnrPW6XpK/kGgXHmka3qshlMJQ/Ylbs4
         GRW2G82V8C1E4UslWSjsry8X1vra3q3y3PONCLL657Ia/biMCHJ9QSn7XAnGuN1+boZr
         PrNr7v35RHq5SNUAwbriBYCfGPDiyzlAnSWDigdhAxTip7AHloDGYlhenFOcLUTnU+d4
         gm+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXU312F/0W0yk6b0LPFhJNZR/0rR1MjgzpGOHyIGPa/IxEVBLYP7y4rBFSS7XvapdQV7gwj5PWEjh4DM3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeuXfWfh14vXZsgYzbI3nzRlKNG8Jjn0tC+Q4RZpI7gOZKEjyR
	KIL/2+BQarwD+pPahqqxVRNm7zbiVFc85Y8P9jQEwor+nameQyjM9BwcR/0frewy7IHEXxM8RVr
	bCN3twp6J4r/d3FGHbPoGEcTKaBuV/M8=
X-Gm-Gg: ASbGncvvwaB5KCJM/WzqfX+WQXSil1cOEBaYlzU4Al5lwjjGRi2R1kCp58f8UfbO7mQ
	3Gdr6ODlfzLmhBFsfUns0uh7f5zcl1e3RIH95E5fKEQYN+83il9odu+4I577rcf0u5KSg5QDzQl
	Mp2AXTp5QkH5FMyT0maB8ueEWtfZ5dRmSEZ4KGtVQT+6PoEXhOm6ekLr/gut7tnoiJf8MjPZCzi
	FtZZeBgn8rLHKZRP2ibVit6Mab6Wui9K2ZuvMIdB4ERNX9PZwpJ7epRLRoqdlBziydliJ2Shmw=
X-Google-Smtp-Source: AGHT+IECWjhaZNmV1ojdHkxqbAFOmHEINNvUEgcQdI2hfmscAMsefgN2+U5CxgJIIoAua19jxGu56fLuuqU2fY9/gjg=
X-Received: by 2002:a05:6000:26cc:b0:425:7590:6a1f with SMTP id
 ffacd0b85a97d-4266e8d9301mr5195008f8f.49.1760021169790; Thu, 09 Oct 2025
 07:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927061210.194502-1-menglong.dong@linux.dev>
 <20250927061210.194502-2-menglong.dong@linux.dev> <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
 <3571660.QJadu78ljV@7950hx> <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
 <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com> <405caf71-315d-46a4-af35-c1fd53470b91@gmail.com>
In-Reply-To: <405caf71-315d-46a4-af35-c1fd53470b91@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Oct 2025 07:45:58 -0700
X-Gm-Features: AS18NWBEI8kqkZPKzG96GE2ZCLB20iemRBfaDjOtbeNUARLINqO3dUs7B56pY3o
Message-ID: <CAADnVQK8Rw19Z6ib0CfK0cMHUsYBuhEv8_464knZ4qFZ6Gfv2g@mail.gmail.com>
Subject: Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault
 to BPF stderr
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Menglong Dong <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 7:15=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wro=
te:
>
>
> The verifier can rewrite 'bpf_reg_aux()' into the following instructions:
>
> dst_reg =3D BPF_REG_AUX;
> BPF_REG_AUX =3D 0; /* clear BPF_REG_AUX */
>
> As for the architecture-specific implementation, BPF_REG_AUX can be
> mapped to an appropriate register per arch =E2=80=94 for example, r11 on =
x86_64.

it's taken. There are no free registers.

