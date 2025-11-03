Return-Path: <linux-kernel+bounces-882960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD20C2C05D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A0A189A147
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8924B30DED1;
	Mon,  3 Nov 2025 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbCN4s9y"
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4897C309DB4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175689; cv=none; b=MQ99KvRdNR5qYeysGEJarUawr8YTdLkN0XYEbPvkFOIRKjqqArzYjSGflvNtR703rzXz4oF7rsXYdB9Sjk7AJGn1nKW1N8PjOGOy08yGGeTVz7c2gtMa3ODwnjpXjf0sKjudEgk9CbidoSt1M9jjNB7uUCl3y49xsPPsjrKvgaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175689; c=relaxed/simple;
	bh=Siug+06jX3i4GnzQ5QzhPzthl4ECdvKKGbHXxfZkFkU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qu6cqlnFLtC2at2flrkugxgSyAHgwz+ZZTg7uWBAavhYMTITejMhCBhjJypLx1wgGMGz0Gj6QamWe6NOJ1BReDjgzyuJbtqD/i2KG3ZdRm/PH3MsH5WokNzjZFwZYKnhxg8MI60yFlTkR+QOWtrtY1VsySSHYIHfCBr68qcDX0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbCN4s9y; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-429c7e438a8so1636592f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762175686; x=1762780486; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rQAGurkDPR4RcdDesOFdVCugIU+WZRmXA3XBpTTF4co=;
        b=jbCN4s9yoj69r1m9/x5/5VntVyWyUdwRY1WKdjCYn6IkqZvwJ7tu0M+m8iNHB3SBpd
         L2siROR0UjQIQd9azoIui2htcn7vCbfkGBlrZsM3eKAj+gumhprqQPkD3IZlqA2EFW4c
         +iqQYetAPxYsQyxWcerqj34b04pGHn9tkDn7S29TZJ/9gQ+J1j9hHk5u8JzPWl5j49O+
         bKkBd7/408HzJC5jQChqI8ljAgQMDgtPiMG/hp7Fk4lSCZCL66uUx7m5V67dJ7bVZOyR
         9WTEaXOcVbyOuK7PIr5CJVJMTH8K4bAyE5SGCB+Kktjfq4FZxIyL74fZJ30ukXc8cg1Y
         77Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762175686; x=1762780486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rQAGurkDPR4RcdDesOFdVCugIU+WZRmXA3XBpTTF4co=;
        b=RytHFG69r8rylqSk2BWvReZcuPWycJa09fLwsW6eAyCtjjSw2bA0rmK3lYRm7anu/K
         uCO1WdWjSAeOuyUZjpBArlYBSMBeRT4AHmV+J7aI0cfv8eDO2jSNMn24IlWp+0KxrY5w
         Zf4o9fNGWTgF0SbtOTY7inHCQuCCe+1Um3LHtcqJSQUsXBW1OlZMf/Ge0E+h0bwPHaDn
         OmHu0ZInOjjGXOzb1Vyeaj8m3CT0RjNzPmYV5XWnGzxFSujQFTOjHAWSpjVMn1ZXRE56
         gIlaWyS6gpKlSeqgl02eqq6qBfMAM5QHiTdz3eZjgv5YBYBmqEeeVJVjbBKqqLkJbcnu
         P0LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXixxpS/+yaFljr2KW91cxFCDoaJYirBHBEZSf9F5RCOhwtSGecEst9DMgNaVKKMZnXrDbsOeDW6ariTRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf8raPeKyZWt44yeY6mr435PluKvBFBAb3JtT4L21Uhz/30G65
	C8CD636aQOm1pFj/ZgiXwViPWWw4j/9TiZmYfZpS1HXmXbmwYdzsBR4PcxrP1rrQMqAk4w==
X-Gm-Gg: ASbGncusLpDyccY6CAH0EwrB646tPO0fPu4a/06PQ0KPBF1dagFPsrf2PZ16K4+DRP/
	6Bz90Xq2TJH2jlyWVQ45txyAb0GrQU/lqXHDftXNLEuC5DD5hZHbnJa36PWT9xOUD8zhBeiGWnZ
	6rAXa3VRdGE+6PU8V/hY067xMKK5oKVt4verkjnLdZAWQ7SQwf1OGdZKvv5ChYsXdsX+H0WmcLd
	Vn3nHSTw6aiMIIPAaR1Eh+rjuOWGbNi5ytmFEWkNxF2oAWHA6Nj7xkPgP/ZuJUcIVu6RHoLkhAK
	pDXZbIIkz6ws508T76pr4V8PuVlzj956TSKmDM+IQU6Wh0BnftZyie8t5zh/QEN9zux18vY6PAn
	ad4D5cPxnK39yB1ZZVSUgKoPj64e5CYTyvxXu4cvKrsIzfmtmNn310lpJJ3OKJksmfzkiTiq0PR
	tm/u5Q+NC/Y16JgESAmv3u7wR1CBWquCuWWxK+
X-Google-Smtp-Source: AGHT+IGd/En4l/nwtIiEacs97yG94DizzI61g7kS/dAbXkBEHMMIpZN5vZiuOsRccq8nGuUTHj4Irg==
X-Received: by 2002:a05:6000:2889:b0:429:d66b:50ae with SMTP id ffacd0b85a97d-429d66b52fdmr1818837f8f.57.1762175686428;
        Mon, 03 Nov 2025 05:14:46 -0800 (PST)
Received: from workstation (ip7-114-231-195.pool-bba.aruba.it. [195.231.114.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ca375a1dsm13565997f8f.27.2025.11.03.05.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 05:14:46 -0800 (PST)
From: francesco <francescopompo2@gmail.com>
X-Google-Original-From: francesco <francesco@workstation>
Date: Mon, 3 Nov 2025 14:14:43 +0100
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Francesco =?iso-8859-1?Q?Pomp=F2?= <francescopompo2@gmail.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efistub/smbios: Add fallback for SMBIOS record lookup
Message-ID: <aQiqw1kX8br_KBnT@workstation>
References: <20251102001411.108385-1-francescopompo2@gmail.com>
 <CAMj1kXEUL-Uv4tCx5NLVHDRo-BdEK1xJdee-UYs-ymE-mLxv0Q@mail.gmail.com>
 <CADr=TJdTcss14P43_jAj4tsEYukt=Z18SnjUNqMD95O_5KkNVA@mail.gmail.com>
 <CAMj1kXEP=nByL5+R2Ch-PLSKnziEyyK_rLZL=wcvKRNcBPTJbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXEP=nByL5+R2Ch-PLSKnziEyyK_rLZL=wcvKRNcBPTJbg@mail.gmail.com>

On Mon, Nov 03, 2025 at 02:11:31PM +0100, Ard Biesheuvel wrote:
> On Mon, 3 Nov 2025 at 11:15, Francesco Pompò <francescopompo2@gmail.com> wrote:
> >
> > Il giorno lun 3 nov 2025 alle ore 09:19 Ard Biesheuvel
> > <ardb@kernel.org> ha scritto:
> > >
> > > Hello Francesco,
> > >
> > > On Sun, 2 Nov 2025 at 01:14, Francesco Pompo <francescopompo2@gmail.com> wrote:
> > > >
> > > > Some UEFI firmware implementations do not provide the SMBIOS Protocol,
> > > > causing efi_get_smbios_record() to fail. This prevents retrieval of
> > > > system information such as product name, which is needed by
> > > > apple_set_os() to enable the integrated GPU on dual-graphics Intel
> > > > MacBooks.
> > > >
> > > > Add a fallback that directly parses the SMBIOS entry point table when
> > > > the protocol is unavailable. Log when the fallback is used.
> > > >
> > > > Signed-off-by: Francesco Pompo <francescopompo2@gmail.com>
> > > > ---
> > > >  drivers/firmware/efi/libstub/efistub.h | 17 +++++
> > > >  drivers/firmware/efi/libstub/smbios.c  | 99 +++++++++++++++++++++++++-
> > > >  2 files changed, 113 insertions(+), 3 deletions(-)
> > > >
> > >
> > > On which platform does this fix an actual existing issue?
> >
> > Hello Ard,
> >
> > My Macbook Pro Late 2013, product name Macbook11,3 is affected.
> 
> You meant MacbookPro11,3, right?

Yes sorry. Anyway I sent a PATCH v2 email.

-- 
Francesco Pompo'

