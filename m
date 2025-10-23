Return-Path: <linux-kernel+bounces-867447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72880C02AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3392954909E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1084340A74;
	Thu, 23 Oct 2025 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kScwt8Sb"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFC133EB1D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239214; cv=none; b=er3hY5PVIhJdECf5rUqIMqopxZHc9vKz5hUCoB/sy/vDVHIXDiR5KAAK0a+CiLfVovDAYqkV81/GcAT34JAbwdcdUipdcaz9FkhamjeQeJwS7ZtfLagotqsDDANG3DZQUeoWVGLVe47V5YPNnYjrn/tRD/JnXwqRXm7+zcFASvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239214; c=relaxed/simple;
	bh=PECSIW3krhGuJb11E3crJdvrNsJtWevjN0kDoXCOJas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIstXRwczrbbZX+PB9tIw6OBXLBIgghIMFJi2gq0dCqDeGXZzfV4Y6HRvDaHqAXRFvKE3s45ln9afZAy2tbpX1JrIfYrtjXJD5ZRmUcyY/DGvpCpogDHZVK7mGdSuJuN+L+LIxESToBfEwCqQBvzfZOhQjYTN4ctsfwf5E+Twl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kScwt8Sb; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3737d09d123so14408591fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761239211; x=1761844011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay+42qhIEPdXa+n4WvORTn6I3PLfhdqjaHkfndYAfck=;
        b=kScwt8SbKBHth+fbMFKTAwrZmBaPQi32DE8oVyRXdmtndtBygPbSVKIVG4BGdWpzom
         C0jlAMxfYNiBr283VsYgFqPWUzfp/0pE8goq33CLTHWLWMFbvsMTxjmVI7LdxupjM6XB
         dbBDWm16aDJj9S92TftoFATwLNSANvJjcx/WjFoHu1zo9FObY63vd6+PVeWiltKa6WK8
         z+ZFHd83aSE3UGycQwhBGl9VGYI/GHW0pQh07Na7rV9FwlbqdwWaGwc8wFFtegMC4Cle
         rIkiiDtxqWfecqv4luWCfFKJGCWajd6qtA4NdfFl331fjQtsXTGlsN8FnslemrBk/Mmm
         A0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761239211; x=1761844011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay+42qhIEPdXa+n4WvORTn6I3PLfhdqjaHkfndYAfck=;
        b=A8Yl3StSxgefkNNCtGaw3wP4b/VRgEzU1J/Ziuc+/oxebpOd8Ja8joTQeVPF1cYpnk
         LOY8DFbZOhBYJv8WBX6rg4Gbq8Yyv2ovwRMm0gJHMtaqwoaLNy6AOGvbzSRfshM1feGT
         6wgRD3bvXyklcbKgm9+ufqDAGe39w4tbuW9mVZhGiDD/tU5Q1fIfsojKIqSSxcD+OvqC
         khf9TE+peVegpIU5fs3d8dkYUc5G+QfL0LiXUXz502YZLvgJ4Cze7rXVIVWjciSh5bkx
         qOld/6xyIpGS1mxpqkdfNCAMXrMwFsEacgGYAqt7EMXyCiFtOnPAYVzlxyE0d3/BDzsZ
         2EyA==
X-Forwarded-Encrypted: i=1; AJvYcCVc4D0vIGht9AXIbUnsD4e2gEkACgTmpvDhLkF2ncV6A8wWQxZnlDYlZaErRnjUOacgIVckAygjK+2hh9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YymSFm+RPvuTJtG6cnCifvhJL4HZUjEh5LGymRly2P1kI4I9hFe
	x8PhDdCIXK1qPePwOV1UbSyF5koCPI+TSWs5jLerkkGmMHJDgSSsuWmx
X-Gm-Gg: ASbGncuHw4yLKPGiVwNzj83r7qoahJaFiA+nRI9acHiCewIb+c9U22veq/2NGvdvvON
	EGanzBRaazNm7CSdjCvNHt+HWHfUc2Iy9d4AJePcO5lFtKXr0xnLFnt6qZ10X3ZNdUz11GY3ODy
	SpD93Bp7jBaIc9wCIPgUAbCnPX8JZ5ky6uheyEoG0TAPlFGx7N/t0WXxn7pEuR0GLW57irvNU+K
	7LmbWmFIVJXh8oT5seih18mNMQrTxAPAtsmr8JYv22EO5+2/hkKkCeonCoumsI4unmSg/kXoULH
	2/K400L4i2i7R70wKDNWjhd/V3OBHfXUzGiugZu/UW0l0EIhK4UdpiAkOEjN5/TLWOPv41+pMwr
	DIg72KphUIxYoPKrQgDyNpgDVOpOgu4XsUMkxFiX9ODLkcLSgm43DI+Xpv7cYneWCi6/cff45lk
	r7niiYxE7wI++8tYCE9vjahMk9PNE=
X-Google-Smtp-Source: AGHT+IFCU+4vgavCbFNLb+Mo4lZ6B2eZuRjKspgl3MEMe+pg4okffP3jDGlOShhYfpkKT3xoeWgSbw==
X-Received: by 2002:a05:651c:199e:b0:36c:ebb0:821c with SMTP id 38308e7fff4ca-37797831bfbmr72598861fa.7.1761239210349;
        Thu, 23 Oct 2025 10:06:50 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378d67dc50csm5770731fa.41.2025.10.23.10.06.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Oct 2025 10:06:50 -0700 (PDT)
Date: Thu, 23 Oct 2025 19:06:44 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Shyam-sundar.S-k@amd.com,
 bhelgaas@google.com, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 jdelvare@suse.com, linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux@roeck-us.net, naveenkrishna.chatradhi@amd.com,
 platform-driver-x86@vger.kernel.org, suma.hegde@amd.com,
 tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
Message-ID: <20251023190644.114bf9f8.michal.pecio@gmail.com>
In-Reply-To: <5764e711-4c3f-4476-9ecb-1f7643e3b60d@amd.com>
References: <20250107222847.3300430-7-yazen.ghannam@amd.com>
	<20251022011610.60d0ba6e.michal.pecio@gmail.com>
	<20251022133901.GB7243@yaz-khff2.amd.com>
	<20251022173831.671843f4.michal.pecio@gmail.com>
	<20251022160904.GA174761@yaz-khff2.amd.com>
	<20251022181856.0e3cfc92.michal.pecio@gmail.com>
	<20251023135935.GA619807@yaz-khff2.amd.com>
	<20251023170107.0cc70bad.michal.pecio@gmail.com>
	<20251023160906.GA730672@yaz-khff2.amd.com>
	<5764e711-4c3f-4476-9ecb-1f7643e3b60d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 11:22:29 -0500, Mario Limonciello wrote:
> As this is an ancient BIOS this reminds me of some related commits:
> 
> aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")
> a74fabfbd1b70 ("x86/ACPI/boot: Use FADT version to check support for 
> online capable")
> 
> Does reverting that second one help?

Not sure if it's worth trying? My BIOS predates the ACPI 6.3 spec by
several years and (if I understand correctly) MADT revision is 1.

It seems Yazen guessed right: they list 6 APICs and mark absent ones
as not enabled. But I don't think we can assume any ACPI 6.3 flags to
be valid here.

I wonder if some quick check could recognize those consumer CPUs and
simply ignore hotplug there? AFAIK it was never a thing on AM3.

Michal

