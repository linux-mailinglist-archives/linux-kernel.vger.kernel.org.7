Return-Path: <linux-kernel+bounces-810282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A341EB5183A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4295E4BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CE821A44C;
	Wed, 10 Sep 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="osTs61rA"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067A201278;
	Wed, 10 Sep 2025 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511979; cv=none; b=nu4zlHZ3AnryoDUfwwe55zxRLhrrQhDNwMwY4z273WNr1y+umaeBdrTw0oAfBhAd3gqvSk0+LgJX42MeOeDRJr/eFI/Au02fjglwfsZYi1ZWQSk8bTfdCbUDGEvv4Q5ogERoFi1myjezrTSGPmPoPD2qoT/wnZShr8eqkJ/xo7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511979; c=relaxed/simple;
	bh=3rU7hZdzei42Lc3xVobYk15fOkmf2I77X9n+u0OVfw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i8kK+V7qAeZ/iUSs+8EGk4yEhs4cnnQNp5f6qo8GmVZ+o3XFxJ+JZ9xHInnifK00nyCzm78de2Ur6zvcY8LBrUZq0q5reV/VvFUPCuNbPog1ZYXXm6LVqo7/2Rt6/+a4dzLwEOoVSSSQRji1RXE4epBngFvpc4HvxHKJungoJeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=osTs61rA; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6713C40ACB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757511977; bh=Rk00fT0CnwEcT1hPEit/apVB9S7eFZYoFHTVDCTrJA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=osTs61rAFdGlPNdJy1YMKDmK3FEcto4eVZUDMGsZPCO0awdUVyA8ipCjWsSfoXmAc
	 eNT/yV3s8uL5aDnX0aG+iWUIlfcfw9PTYWwr+JS9Mkosi89KYUzVmyMw846TKOCmy9
	 wlOPRGsrF35zybY1cGpRgdxO2DpSMeV417DCWzO0+8RYxDhtN/ygEOqpqIqzRAQlsQ
	 DbxJ/aWyHaj+wMoyPsDRhp3FIw9SJdrJK90mlyCdHozIhsKtGYvxAvxNF2DZJwm2bB
	 WLmUrBc9ogUNUKQPQizjvOWlhpeo8MyTKeB0pPi1zOKy7EN5BoNs0dWVkUYSXfy+Z/
	 Fswwa4/Zah+1A==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6713C40ACB;
	Wed, 10 Sep 2025 13:46:17 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 13/13] docs: kdoc: a few more dump_typedef() tweaks
In-Reply-To: <8ff91be7-7cb7-492b-b1be-2d03516c8386@gmail.com>
References: <20250909204349.123680-1-corbet@lwn.net>
 <20250909204349.123680-14-corbet@lwn.net>
 <8ff91be7-7cb7-492b-b1be-2d03516c8386@gmail.com>
Date: Wed, 10 Sep 2025 07:46:16 -0600
Message-ID: <87segus9nb.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akira Yokosawa <akiyks@gmail.com> writes:

> Hi Jon,
>
> A quick report on minor regression. Please see below.
>
> On Tue,  9 Sep 2025 14:43:49 -0600, Jonathan Corbet wrote:
>> Merge "typedef" into the typedef_type pattern rather than repeating it
>> later, and add some comments.
>
> I'm seeing new warnings after applying 13/13:
>
> WARNING: kernel-doc './scripts/kernel-doc.py -rst -enable-lineno ./include/media/demux.h' processing failed with: NameError("name '_type' is not defined")
> WARNING: kernel-doc './scripts/kernel-doc.py -rst -enable-lineno ./include/media/v4l2-ioctl.h' processing failed with: NameError("name '_type' is not defined")
> WARNING: kernel-doc './scripts/kernel-doc.py -rst -enable-lineno ./include/media/v4l2-ctrls.h' processing failed with: NameError("name '_type' is not defined")
> WARNING: kernel-doc './scripts/kernel-doc.py -rst -enable-lineno ./include/media/v4l2-dv-timings.h' processing failed with: NameError("name '_type' is not defined")
> WARNING: kernel-doc './scripts/kernel-doc.py -rst -enable-lineno ./include/media/videobuf2-core.h' processing failed with: NameError("name '_type' is not defined")
> WARNING: kernel-doc './scripts/kernel-doc.py -rst -enable-lineno ./include/linux/hte.h' processing failed with: NameError("name '_type' is not defined")
> WARNING: kernel-doc './scripts/kernel-doc.py -rst -enable-lineno ./include/linux/xarray.h' processing failed with: NameError("name '_type' is not defined")
> WARNING: kernel-doc './scripts/kernel-doc.py -rst -enable-lineno -function gen_pool_add ./include/linux/genalloc.h' processing failed with: NameError("name '_type' is not defined")
> WARNING: kernel-doc './scripts/kernel-doc.py -rst -enable-lineno -function gen_pool_alloc ./include/linux/genalloc.h' processing failed with: NameError("name '_type' is not defined")
> WARNING: kernel-doc './scripts/kernel-doc.py -rst -enable-lineno -function vdso_sgx_enter_enclave_t ./arch/x86/include/uapi/asm/sgx.h' processing failed with: NameError("name '_type' is not defined")

OK, that is embarrassing, not sure how that got through.  My apologies.

An add-on fix is appended if you have the patience to try it; I'll
update the series before too long in any case.

Thanks for testing!

jon

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 8215948dd548..2376f180b1fa 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -1050,7 +1050,7 @@ class KernelDoc:
                               f"expecting prototype for typedef {self.entry.identifier}. Prototype was for typedef {declaration_name} instead\n")
                 return
 
-            self.create_parameter_list(ln, 'function',_type, args, ',', declaration_name)
+            self.create_parameter_list(ln, 'function', args, ',', declaration_name)
 
             self.output_declaration('function', declaration_name,
                                     typedef=True,

