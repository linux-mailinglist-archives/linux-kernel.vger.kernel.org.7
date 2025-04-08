Return-Path: <linux-kernel+bounces-593831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D7AA80407
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 14:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6FE425B8E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 11:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093BB26A1A4;
	Tue,  8 Apr 2025 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LW0MlNZS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11BB26988E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113259; cv=none; b=OK72wa33iJyBy7LQcHKd2SX3LeiFkvIDNpQpT3dSaObdDy/naUvoX/AS1NiJHvzPrA7oIscfVgrwWAgvmzxJ6b1sBPmE5HPPqxZ/XKWI/xPqwrE3MNR/5N1SPxRFYzClFHziPJxznr/NMkmqOJxh5mV7+z+AQDf/v6HzIn4JCpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113259; c=relaxed/simple;
	bh=ofPYs6O/D31jfLG0JAc5s7o+o56RtFffcyvSz8UayLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZDEY+TstIE6t5olFuNwA3f289EHnOejhX3wEAXtuLXW0ZWirePDgdHBNowpXahQcBHtstRlaPdLsI+qz+LP8ThyvTFvClB/oI3WvPxcF+GbINI208P99s6aZ8Rtzfc//UQhBEDyBeYh9yaDYX7Jjzsukn780aJLLOeQbCDZj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LW0MlNZS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744113256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6P87msgsabneZYPN6rB+5xYdoyhBToIEhxgNQC92Q0c=;
	b=LW0MlNZSfo0Aoh5GjSfQ3nq19zCKaibtI/D0T8H/gGtafmLilgI4QhwrDlaufzfFrFDZvp
	bN6tRViYLstxIQSJ6WBnfbcxE7q3v5tpfNQQ4X5PvULP60WSatmjprkczgq8i2x4+F4903
	QJkGf1PnGswblySXpySucnQtigeQlxo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-bZezIaHGN7-k0Rnng0NEbw-1; Tue, 08 Apr 2025 07:54:15 -0400
X-MC-Unique: bZezIaHGN7-k0Rnng0NEbw-1
X-Mimecast-MFC-AGG-ID: bZezIaHGN7-k0Rnng0NEbw_1744113254
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43947a0919aso39059635e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 04:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744113254; x=1744718054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P87msgsabneZYPN6rB+5xYdoyhBToIEhxgNQC92Q0c=;
        b=qbo6q0gxWAr9laGEZbc0zFhwoG8iOxmIRqI9DsuJmDiCaa96/EWGEMmcR89vq3nH8j
         aBYGgT6oYmmmPFhVIqDZuYZ7U3upO5IqAkBiW4kLYXWmwIFGGUsceFhnVrsdNmAWQfWH
         pHRFPaOku64MokbSz8VFydexw6fiRcSeAn6lo9Wr2tfhtVP5qW6t7xr1AsYwzvecRrw1
         3bmD/y77m4711gaP4JHgm/A1dyY0ioJgWxTQcRObma130Bjp/vacPXqRxyCmZvmgAGrn
         Ge5h4oFm3x1E8pjDc5RAH0sOOSUoMio/F1/Fo86zF6esb/JP50u7kdfkMHa6SaMGJO0h
         lu6g==
X-Forwarded-Encrypted: i=1; AJvYcCUDXO72c4K6uFlE/cGg7zPQyAJU3gHEsvbO11QzMkTQGf5wzziyzrX9c5+5j8Q+EI3rHVMZ2JBU6Z/SA2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPt4G8Pnlg8+I211VMkHU3IFOtZdjxCqa+/Nhl8TempfaUkheH
	Fwab5HdFb4S7h6CL6wdylJjpwpHKv3M+pUv6jtM4hZ9h8IYGxcyy3QUEtr5TEioKc/4gl5wWZ+H
	bmaFno4iJcSB01vDeNCrSdO+fU8NxtMT5X0qJ/P+STQ28LFHXx1kIk+OMUz2XXg==
X-Gm-Gg: ASbGncs7Cpj1f7YyZ16D1pYTfnag54uoUOzmiPrcQ4XsY8cSe2ihGET5kDzZNsfryjB
	+Es1w6ZjK41wPqk3d/3tKm25D6x13ls0UVT/HrFhXbzXL+44t71fzCett+bMnYSZIe9K195Zlzz
	wXlqSc8f85eCbOvR2RoSliIT1h52QV6KxKYjUCoD8FPeh1vIRHT6F4O4TG93iqZiNWDgpFGucZL
	eVmnXISqyBHYQNmZKNe8dCqgmGGMuIrp11USYzxMoibbOCd/rG9ledBJfFk60HNfq0LlbwjRK/6
	401EEv5SrHetKKFUCgSvrswClU7lox3vYXJ6T76G0kvOIM+xtVpQ8fLtq2RRhLoi
X-Received: by 2002:a05:600c:444b:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-43ecf8f2a65mr147387215e9.15.1744113254078;
        Tue, 08 Apr 2025 04:54:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEazQZYy/ewEWuBTBgdQvEiXuTOqwdRTF+asTjWk+ZHtpNHgb+bGQ0L75gwnYyXxYjdFSFI4w==
X-Received: by 2002:a05:600c:444b:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-43ecf8f2a65mr147387035e9.15.1744113253632;
        Tue, 08 Apr 2025 04:54:13 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec3174cf0sm164679105e9.0.2025.04.08.04.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 04:54:12 -0700 (PDT)
Date: Tue, 8 Apr 2025 13:54:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Joerg Roedel <jroedel@suse.de>, Dionna Glaze <dionnaglaze@google.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 4/4] x86/sev: register tpm-svsm platform device
Message-ID: <o2u7p3wb64lcc4sziunr274hyubkgmspzdjcvihbpzkw6mkvpo@sjq3vi4y2qfl>
References: <20250403100943.120738-1-sgarzare@redhat.com>
 <20250403100943.120738-5-sgarzare@redhat.com>
 <20250408110012.GFZ_UBvOcEfEcIM4mI@fat_crate.local>
 <eqtiiphs6rtjo7nirkw7zcicew75wnl4ydenrt5vl6jdpqdgj6@2brjlyjbqhoq>
 <20250408112820.GBZ_UIVPp-LuIiVrIV@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250408112820.GBZ_UIVPp-LuIiVrIV@fat_crate.local>

On Tue, Apr 08, 2025 at 01:28:20PM +0200, Borislav Petkov wrote:
>On Tue, Apr 08, 2025 at 01:08:36PM +0200, Stefano Garzarella wrote:
>> We discussed a bit on v3, but I'm open to change it:
>> https://lore.kernel.org/linux-integrity/nrn4ur66lz2ocbkkjl2bgiex3xbp552szerfhalsaefunqxf7p@ki7xf66zrf6u/
>>
>>  I tried to keep the logic of whether or not the driver is needed all in
>> the tpm_svsm_probe()/snp_svsm_vtpm_probe() (where I check for SVSM).
>>  If you prefer to move some pieces here, though, I'm open.
>
>Yes please.
>
>It doesn't make a whole lotta sense right now to register a TPM platform
>driver at one place without even knowing you're running with an SVSM inside
>the guest blob or not.
>
>The usual approach is to register upon a successful detection.

I see, so IIUC I can just apply the following change to this patch and 
avoid to export snp_svsm_vtpm_probe() at all, right?

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index acbd9bc526b1..fa83e6c7f990 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2702,8 +2702,10 @@ static int __init snp_init_platform_device(void)
         if (platform_device_register(&sev_guest_device))
                 return -ENODEV;
  
-       if (platform_device_register(&tpm_svsm_device))
-               return -ENODEV;
+       if (snp_svsm_vtpm_probe()) {
+               if (platform_device_register(&tpm_svsm_device))
+                       return -ENODEV;
+       }
  
         pr_info("SNP guest platform device initialized.\n");
         return 0;

Thanks,
Stefano


