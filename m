Return-Path: <linux-kernel+bounces-764876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC33DB22844
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0011888355
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B318279346;
	Tue, 12 Aug 2025 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CTrNUvy7"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDAB263C90
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004531; cv=none; b=RVG3UlJrnO7PZA0QNHkML3YMyuWTCv/Pjl9+9Ot82mDpZG6txc4+mcM2hd/CIU4ClggG2lfp5aVlNuyRezUH4ZKWlMdLY3KwTJGaNfEb+zrlqAApO2NfdTrApyHZUqr5lu5exkHjxOg61iwwL2wp7Nc+OL8vlxg516uhcvjOE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004531; c=relaxed/simple;
	bh=KLnmQ4Q2BktvwUYMgm4VPtBXX+pAFSd/TT/FrW29OQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHTWNh4hUoqmKzq/Rzx3jj3RCef9rer50NbIYDSi3QNChxPHlzSEGPlTa2s/IlUI2gSdZCHc3/zPpgQ0X5C7O8lFKh9zzEEn1mw9pDnn3FIdxDf06KXrjRLnDRO4QJPfqoiGmWIIRlOvnX7TUGPNeHRR4lXg78CPX6AwT6qzZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CTrNUvy7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23aeac7d77aso46304425ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755004530; x=1755609330; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CIZ+4Wv9ojpY1/fI9C11E1ch7d9wvWodMXJMaf6VoBs=;
        b=CTrNUvy7c/JbL4eUkp7lSZP/tbgsepeD/c0Gj0BrwsTlmtSFYTw55A/SnPwYFMmk4C
         YbkSe8GIp/p5ujWqZ94c44XazTJOYKqkEdaRVYrM0MKY815KpO0LQWfMTRjKS1htc0di
         vd3ptWQLVz/oQ+eg5tmup2PlvHrTJuWefN5iH6XvAwQp4zSN3YliEnDYJXpJy6f8vMhO
         GpHso91NWpF7uJ3+kAFVDs916du7Rrtrh/FYforTp7SzZeN0G3By/uZc5v+CC0DsT1d4
         wpxajMrx2mxfSp6zVfvztF31YeSWpFU2+FCUc/GXkuoGHw0OoExrS/ZoCCEcuyRPo69W
         G41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755004530; x=1755609330;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIZ+4Wv9ojpY1/fI9C11E1ch7d9wvWodMXJMaf6VoBs=;
        b=ayai1tHrY3jW/kXUIOQt5pt9JcbyTni4fGer1QhocqcVT+OH+8qKjs2vHLwhm07aqq
         StcT2HBm0/xt5KpqJhDPMLMsJvl8W8SCoCrmG5BEBcl+5F8Yqc2MlvpQRNSlYyT+0nzg
         eRsylKR856pXUw/Vq5C09/2FSrh/rypMUiZyDraE5ntsJsoBcmZ8KnvGCiLiCJahmkHf
         RkFABDI6SkgIYR7ylxLQ5ZQE5yOrtrMydFnZ5Y/IBDOMUGrEws7wTQKdMQVsjzgx+zQs
         a3O1QGC7wQphXugANkx6Nh4X0vmLtWNYXH/0J/6idwmz/JI1oyvmwp8VgYHl4K9gx+ya
         4GXg==
X-Forwarded-Encrypted: i=1; AJvYcCXsru66iPDwl/YefFEiq6fUdc6O1WAw1NtghIbzWp3Ccus4YTgGCWR+WGHztmWX9s3w1qH00/mGGX0o0qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKtV4VgFNffiOPl0sFAbe51L9VXLlRXjLyUmihmJNPokb9HTrd
	fbEM4TCREL0xCr+VKqVh2jtIPDAaza2gU3yDXF9vM7P13V8OvOq9zlqlcbR3ycbDHjk=
X-Gm-Gg: ASbGncvCS/qqu5j2KZb/LrCOVZAdXNB4Jcml/qTqUUuYhKymZ2gBRQO6C5OWFLcWLmy
	jCdkx+69Oz0EIOp4sQXrRCHmijV/kCOKd6N7TGE+Woheh2g7YcbeBY+ykQ88ybZ3xu+UPcErfXt
	xALnceo8hMuRExa3M90cZZvWk3H5Jj1mjjdruimnc77rcCpI8q0mVyZC4W2kmSMV1bUyl/Mz0dL
	Da/STULJXhyKosBoNRcvFjUgUrFP6fGxub1LjjXB/vzg+qToo1J790HE3EltFvR6UpMLi5EN3Nh
	0P67HQUd9ComZmdUU8PbKvde3WQ63KFNdm4zh1KaTqpW0nr9B57FaQt3wePx5ov3mziCyyYeSpq
	/c33VLkw61tJDeFWv2fYnuaf2Z6g=
X-Google-Smtp-Source: AGHT+IFryvq0NSXrxuldQjBSYbOlN7Rlx50CKMnuKseVMjAVcE6lnBOuAaWxNGVUjJ4OlINPVdOdDQ==
X-Received: by 2002:a17:903:41d1:b0:237:e696:3d56 with SMTP id d9443c01a7336-242fc316303mr60853235ad.32.1755004529704;
        Tue, 12 Aug 2025 06:15:29 -0700 (PDT)
Received: from sunil-laptop ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1efe8sm297489915ad.69.2025.08.12.06.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:15:29 -0700 (PDT)
Date: Tue, 12 Aug 2025 18:45:20 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>
Subject: Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
Message-ID: <aJs-aPH32OxpzR3G@sunil-laptop>
References: <20250515094301.40016-1-cuiyunhui@bytedance.com>
 <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com>

On Tue, Aug 12, 2025 at 07:25:44PM +0800, yunhui cui wrote:
> Hi Sunil,
> 
> On Thu, May 15, 2025 at 5:44 PM Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> >
> > Add the read of CSR_CYCLE to cppc_ffh_csr_read() to fix the
> > warning message: "CPPC Cpufreq: cppc_scale_freq_wokrfn: failed
> > to read perf counters".
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  drivers/acpi/riscv/cppc.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> > index 4cdff387deff6..c1acaeb18eac3 100644
> > --- a/drivers/acpi/riscv/cppc.c
> > +++ b/drivers/acpi/riscv/cppc.c
> > @@ -69,11 +69,14 @@ static void cppc_ffh_csr_read(void *read_data)
> >         struct sbi_cppc_data *data = (struct sbi_cppc_data *)read_data;
> >
> >         switch (data->reg) {
> > -       /* Support only TIME CSR for now */
> >         case CSR_TIME:
> >                 data->ret.value = csr_read(CSR_TIME);
> >                 data->ret.error = 0;
> >                 break;
> > +       case CSR_CYCLE:
> > +               data->ret.value = csr_read(CSR_CYCLE);
> > +               data->ret.error = 0;
> > +               break;
> >         default:
> >                 data->ret.error = -EINVAL;
> >                 break;
> > --
> > 2.39.2
> >
> 
> The purpose of cppc_ffh_csr_read() is to calculate the actual
> frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_XXX.
> 
> CSR_XXX should be a reference clock and does not count during WFI
> (Wait For Interrupt).
> 
> Similar solutions include: x86's aperf/mperf, and ARM64's AMU with
> registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.
> 
> However, we know that CSR_TIME in the current code does count during
> WFI. So, is this design unreasonable?
> 
> Should we consider proposing an extension to support such a dedicated
> counter (a reference clock that does not count during WFI)? This way,
> the value can be obtained directly in S-mode without trapping to
> M-mode, especially since reading this counter is very frequent.
> 
Hi Yunhui,

Yes, but we anticipated that vendors might define their own custom CSRs.
So, we introduced FFH encoding to accommodate such cases.

Thanks,
Sunil

