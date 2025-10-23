Return-Path: <linux-kernel+bounces-866444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6A4BFFC55
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66B11A041A9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF082EAB70;
	Thu, 23 Oct 2025 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGLCupcQ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663A2EA726
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206712; cv=none; b=JWcpIhqEVlSQRdq+PP2eP0dxzQnp0Vw9WEj8d+4N8bKkMIqvxOSBPPyE6PQm2yVR57bBWWr0Vt0myB8DKBDRsfX9K0Gm8AIz4cQbBBB3ld9KqKTpO6AVhZXD77lZT73iz3TPsVBKzyv8jNTZ12TSvmC/Zv9RxEt+XTLMMWRvBjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206712; c=relaxed/simple;
	bh=uenJqlf3e66UMXFExS48wtCY8JhRvrFAkCESiVUPJRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VRyqCJLxeFajPE5K07d/vnzrw/bpaYEduzaS/7mTuOa0km/yRb/joku9KfVwalwjsdEEZ1kL/XmV1n7K0XMAUxv19cWaxi+TgGXRh8qvXYxciVSm1JCKJWxvG/zNrKfVqm++quRrIM/BZmist0oh3EbXUAaUBBBFQsygAsm22Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGLCupcQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29476dc9860so2155875ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761206709; x=1761811509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCHm0KACniTLvgb3gmE8HVU4+2SySgaz3x9BwsInbnE=;
        b=MGLCupcQYNru3F1CTgOBZerGa/BF3siZX+3IBxIE5jdG+XLnOBBBdSjfb70xp8zonE
         PK8X3+mKSiCnWSaPqBHdrz9kOP2X8g8iZwfAfLCk4FLNRezAjgh1Mcu14DFfsu2rlQGC
         fAa97XQQKZ9y+UjAIs55BDDxaNGnoKjqG8+lYJpheCa9sVUoAA+oxBy093P120B1PPMy
         nExFFT9NG4hSZg9LL8JSZTDKDvR9xad6RZyCQ1lfqiVZI9RWPXoYCTKY9Zi0IQwHYDW4
         wD2Tb8UhQwFG4AkfHi9/Ix1lWgeW2BuGhzwYK8JYU+YO/vPPs6I2C+KynUzPDmWZPZEo
         jvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206709; x=1761811509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCHm0KACniTLvgb3gmE8HVU4+2SySgaz3x9BwsInbnE=;
        b=QPRCZagkyKGc9bAcVD2o6ZyeNvBvr5twdK1f6icKunp6+7nSIx9zYS5V43+lzqyh5k
         a4D/fnvN6k52G9lHkDr/wiU/6H5qev4sBF3nX4OQxnjuA4IHbkoq6Ye/D8XgcUehA4vm
         fp4rXObdArOtwCy5rqhHYE3kgRMp1LHkKt0U6ZkhIMwuJV6xrWXIr70YgGlBLqymEhcB
         NvWNae6k6owGJQy0iRmcSyajAjjpr6FdsoSEx8cyFEZ/3UsS0CCLReXCmEWvkvfo/oPv
         7WFLK91Ig4Qqt6dZf3zM7ajWc0BWU6vwcprH3N/Hw/pNrX3NkYzRjxwystMU+FVkg4vC
         2WMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhC6LirsvT19KRmqU6qWz9ynW2XKcTBZcJLqhr8U/f09XsxmsjnI1AlcbGj1WasIOormVddrHtWiWDo+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKy5KoTIqHdBI0ET3uavJRs9BeOKQHJto15Ju2NEnQJ8OCLvxU
	BHMZZhNsur2ewA/+e+8ei6hyDocq3aGofIk7CBDxGfb1rv1HIIQZTSy9
X-Gm-Gg: ASbGnctFH3Q5YcrPEETr1uKKrkUZ7dDwaVMee2ZKENao3x3K2drB8dDqLwpQjKg9IL0
	9hAnSjB0E3wW23feDC1mUD3ErWUSsqBdqL2nGHHC/tdb056xKdQIhMa7W8FE+hWPT9V0AY91Q3F
	kQL7s1sDQTJkJAtBBBMBRZhG0tguhM2fW1HN5ydxy85GicV7nUUJtOQLRq3FpC4CQbtjXGNUaIC
	Uo8lAbA/MauiWLx/LRsr9QHaj07I4UUJfsU0KtyN7oHkMeiVTk7omHXP3utsho8BBaFF58WS9Th
	TtR3Ie2sEfxD4s18JTfuTq1bE1IpAvlrpzdFSvhJlCohX9+FQ8iMHbuj4VPDsn03vIOD+JNTWuj
	trH7JAjF6kbJ0KrkfH74pdPWaRTjJ1paZ2Dorh6VLzdrfTVxVnSikq7EJbGegOlQ+mI2l91Ra78
	UYaCwY/vgqKg4QZ/Oc1UqMwxgdXkwchtA=
X-Google-Smtp-Source: AGHT+IFJyW9aI17Ds63F5UcnrXm3r8U1d5XlNzVC7elX6HGJ4SlBhTj6fZB7wMcrSTEKSIld0vVEmg==
X-Received: by 2002:a17:903:1a70:b0:274:5030:2906 with SMTP id d9443c01a7336-290cb27bcc3mr325069665ad.46.1761206708791;
        Thu, 23 Oct 2025 01:05:08 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfc1c8asm14952315ad.71.2025.10.23.01.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:05:08 -0700 (PDT)
From: Szuying Chen <chensiying21@gmail.com>
X-Google-Original-From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
To: akpm@linux-foundation.org,
	andriy.shevchenko@linux.intel.com,
	dan.j.williams@intel.com,
	gourry@gourry.net,
	jhubbard@nvidia.com,
	akinobu.mita@gmail.com,
	sumanthk@linux.ibm.com,
	peterz@infradead.org,
	huang.ying.caritas@gmail.com,
	linux-kernel@vger.kernel.org
Cc: Andrew_Su@asmedia.com.tw,
	Yd_Tseng@asmedia.com.tw,
	Ed_Huang@asmedia.com.tw,
	Cindy1_Hsu@asmedia.com.tw,
	Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw,
	Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH] kernel: resourse: Add conditional handling for ACPI device
Date: Thu, 23 Oct 2025 16:04:55 +0800
Message-Id: <20251023080455.19443-1-Chloe_Chen@asmedia.com.tw>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <aPPlVmJXKcMYmjXp@ashevche-desk.local>
References: <aPPlVmJXKcMYmjXp@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 19, 2025 at 03:07AM, Andy Shevchenko wrote:
> On Fri, Oct 17, 2025 at 10:35:31AM +0800, Szuying Chen wrote:
> > To avoid address conflicts and related errors, specific checks for
> > the ACPI device "AMDIF031" should be bypassed.
> 
> TL;DR: NAK.
> 
> No, this is not how we should do the quirks (besides the use of CamelCase).
> Also, please provide more info why firmware may not be fixed properly at
> the same time, so we won't need this on an updated version?
> 
> -- 
> With Best Regards,
> Andy Shevchenko

The ACPI device AMDIF031 is a virtual (non-PCI) device located on the PCI
upstream port. Its memory resource is assigned by the BIOS within the bridge
windows of the PCI upstream port.

When the kernel creates ACPI/AMDIF031 and verifies memory resources, it may
detect an address conflict between AMDIF031 and the PCI upstream port. The
kernel then attempts to reassign resources for the PCI upstream port tree,
causing AMDIF031's memory resource to fall outside the bridge windows. This
makes the device inaccessible.

To prevent this and allow AMDIF031 to use the BIOS-assigned memory range,
skip resource reallocation when an address conflict is detected for this 
device.

Thanks
Chloe


