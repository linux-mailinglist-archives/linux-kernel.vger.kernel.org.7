Return-Path: <linux-kernel+bounces-782279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0A0B31E42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB2E64397B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532A022154B;
	Fri, 22 Aug 2025 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaqKAvtg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEAA213E90
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875683; cv=none; b=mhQ7XB/QybT6cpCSFckcCbPCfoMIOAbNV939zS4w/lBbBnKtCTVqRkr78Z7xnRsf+pp3yGxtIOcKROKyWSXAZIFEUFMWj5jp3oB0li5XOteLCqwc5QT22UezhsIWWdb/1lyrXbKKhg+yB4cepC5lgFUiOi5abntk3kpX6AT2hOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875683; c=relaxed/simple;
	bh=ndBXV56/JnMZbVFfLRfT/MDSgZjGQBT+W627PMLsVgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxPDNIB5d9ullaD4sVPCHvpsEM1txQ4GF1X+9XTGMKIkFa+lTvI+AcwP3OclYBRevmk13p3nJCgZ7yhXukPDJGzvz0Pjhkx4p8ufy4CZUWQNaUl5HI12k2tNabGzre/AGzOO0EImYVI2NH0Fj4Z7CekEMKmGtlOrrYcqQ2lSITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaqKAvtg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755875680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ls7O/lm/BXfNQorgLuw/zloVau5V617RIU+p8Fz6rMQ=;
	b=OaqKAvtgRs0VQhzu1rzoDPtd2Pc6A2KkYHuh021QmcshT8aqQlqjrd2hcRkx3IfZ/NPA7Z
	DzYEEbKx9hpFo1i5Am2GsrFyybCIORa+kOIJBTM/FFQ7BlMPEkKnOKk7pnFOpmtx9QHRgB
	VTmDaYM2Rf1A4Io1axGJJkBgqO7YXqU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-dU4SYOBLO863wRNOB1Tb0g-1; Fri, 22 Aug 2025 11:14:38 -0400
X-MC-Unique: dU4SYOBLO863wRNOB1Tb0g-1
X-Mimecast-MFC-AGG-ID: dU4SYOBLO863wRNOB1Tb0g_1755875678
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b1292b00cfso24160611cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755875677; x=1756480477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ls7O/lm/BXfNQorgLuw/zloVau5V617RIU+p8Fz6rMQ=;
        b=d8ABVmQDNA+b3E+D2pfHN6BGH9u6aOx+DC/3anGZVB1dEvcy3A2HQ3o9WaOW534fl/
         qLEZwutHiGNoEpCXJJ+MWkCNAO7/T++vYijQaYeIuBE8YJCXxhaQw1rMcMTDCzqOlmTW
         xG+5SnJsY4jTx3xoOSBfrWcIUZmmIHe50ZDLmPaA1kXUPpfQD0t/QXBwpF77UD7zTI06
         r10dqILaMzosLFEW/gkpmGIvZIb86edrvDRWxkQ0ok2FHW/+AUCMhnRVC3e1d3DdNFPG
         LzSv5BhBBtCOdaloLK96dfNmF32CA0r5U/yh4tbq7sSrFNE9FB4fqncuGS8DejN1/9KC
         3QfA==
X-Forwarded-Encrypted: i=1; AJvYcCXiQAgR0WjL1x1oc1d5UBuCP8JZt50rlwAURq2usIn5Gwaq8dqByCkAFXfi/Dvv+TQOA9aWuVeef0FPW2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ZaGZvPa/2YNIWAvAmDozictvM8/k+Mb9Qlgrd7mEkS/5Esfx
	ewGpG9NTfm3E0OTJLFcaqXDVmwuLUoHYD61JLFRUHF3KgT/s0c98MKbX+upS/FyojrPovAR3KhD
	5qDyHCxm1J9PwJeRMNiAQ2UbcpTwoTuqvmn2LM7YNB1qKq6M9laIhWEIg3QznOHBHu4luigyvKK
	vhlXbHE8RAscM+AWkIjF9v4NBeYc1jtFhKV7jZRhOrGvDUWDfyMoDEWA==
X-Gm-Gg: ASbGncsCjXmm7CBJ8nAchGsY73jYlU7wrdL1PNaEwmjikcv8EKkTW93V5DPnJnB3BLZ
	GP2EaFroddOmuVpN86IeoI7EzG5Sk6fXnmzIv9CpHsFY3sn32jfGpeRNOLhQ4FFWZNXW/pSZFGi
	YwMwAmzaDEMpRsJYw9Zz+7
X-Received: by 2002:a05:622a:1a12:b0:4b0:d8b9:22f3 with SMTP id d75a77b69052e-4b2aab20c15mr37601531cf.53.1755875677322;
        Fri, 22 Aug 2025 08:14:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9pCoWT0fl3h1MYiljbbJnSV+E4QG5CKKQDL1sCUg2hKHFDf8FMcARafsNBHxsZ0N4vIPiCdEaiaedG1Hp69c=
X-Received: by 2002:a05:622a:1a12:b0:4b0:d8b9:22f3 with SMTP id
 d75a77b69052e-4b2aab20c15mr37601001cf.53.1755875676765; Fri, 22 Aug 2025
 08:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821170419.70668-1-gpaoloni@redhat.com> <2025082126-sulfite-unwired-c58c@gregkh>
In-Reply-To: <2025082126-sulfite-unwired-c58c@gregkh>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Fri, 22 Aug 2025 17:14:25 +0200
X-Gm-Features: Ac12FXzjYP8h8ovwaEi3kjcSdlJTSvNY0SEARIvYtMMMGKzQdEQ170iKGAeXVmo
Message-ID: <CA+wEVJZaJEXMwQ3E0WKqQCMUR4Fsa=83PuarT+72c6nA1qSKAQ@mail.gmail.com>
Subject: Re: [RFC PATCH] /dev/mem: Add initial documentation of memory_open()
 and mem_fops
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, 
	safety-architecture@lists.elisa.tech
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 7:35=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Aug 21, 2025 at 07:04:19PM +0200, Gabriele Paoloni wrote:
> > This patch proposes initial kernel-doc documentation for memory_open()
> > and most of the functions in the mem_fops structure.
> > The format used for the **Description** intends to define testable
> > function's expectations and Assumptions of Use to be met by the
> > user of the function.
> >
> > Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> > ---
> > I have a couple of comments from this documentation activity:
> > 1) Shouldn't the check in read_mem() <<if (p !=3D *ppos)>> return
> >    -EFBIG (as done in write_mem())?
>
> I think that check implies you don't want to read any more memory,
> right?  Try changing it and see what happens :)

Right I see, 0 is better to gracefully terminate a read routine of
a program that may have read the whole physical range..

>
> > 2) There is a note in memory_lseek() that states the return value
> >    to be (0) for negative addresses, however I cannot see how that
> >    would happen in the current implementation...
>
> How that you could have a negative address, or how you would return 0?

Today the note above memory_lseek() states

 * The memory devices use the full 32/64 bits of the offset, and so we cann=
ot
 * check against negative addresses: they are ok. The return value is weird=
,
 * though, in that case (0).

I interpret this as "if offset and orig lead to an f_pos that is
negative the function
returns 0"....however I cannot see where this happen...

>
> Also, you should cc: the mm developers, they touch this file all the
> time and know it quite well (recent changes to /dev/zero just got added
> in the past few days from them.)

Sorry, I just used the addresses returned by get_maintainers...
would adding linux-mm@kvack.org work ok?

Thanks
Gab

> thanks,
>
> greg k-h
>


