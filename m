Return-Path: <linux-kernel+bounces-833981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86552BA37D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42AEE7A8051
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1B52DC77A;
	Fri, 26 Sep 2025 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTkv3tQx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB47B272814;
	Fri, 26 Sep 2025 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758886123; cv=none; b=XRTS56/LoQBZrTtRw3JFDEzbC3fy9ofEmu3oePrdFkuWDiipfZUDCuCQ5Nw6b958LEhM33BLQKCElXmb1hSFQ8JhXmSnFqhA3xfYx27/Fbti//6icIGFsUSFWpklcEy3Yfe0iKHk7ZObxj6s1jbue8YDGzGwWMd4KbGOZsYWMgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758886123; c=relaxed/simple;
	bh=3Nyy3MLwVUE/jttrn2yTqB+9QvKaNL2/XNV9ReR+Rb0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CqugfzVKhTFLfnjabqzwBFNMowkkeUJVbEhZ4PUAJZBFYsp/97LYfzhhlbxvGc+L6MjG4ZmlqoNQZJO4vw26fnFDT3DcqOEYScB88E58QZsWicbQvGDCPGJzVbsdPYun9KTbzBilBk3yviQ1Mg/Gy7XRdsyNWOa+K/o4o9BYUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTkv3tQx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758886121; x=1790422121;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3Nyy3MLwVUE/jttrn2yTqB+9QvKaNL2/XNV9ReR+Rb0=;
  b=gTkv3tQxgyBnBEr0ARR8roJmM69+FJynxH2oOq9dmwQX0JP13g/dChNz
   mKq7Dtni+BDq4A1Dub48ZhADnxp4hwYeMQXcAVf+4+eRyevnj+X5Q0DA+
   7G9poxN/MH2448vJ+ljJ8I+q53H9C7sIj3mu2YMRChfFRkKsVXWhUQsYE
   HIzUNJSxDWAqxN/O9egj4wWvZwBRYf+6EbvB9RD7j+G1gBYy4mZfle5Cg
   uMhSShsnQuFyB7D+Ad6wTQusashyAetj0Ew3ag9qfyWfeqH0CcUhriqnM
   MymS0uT7GMflF1ug48J5TYSLLOL+OEqOG/O4c0/lD7UBvrgi6qYsOyZyr
   Q==;
X-CSE-ConnectionGUID: +/xQ+vufRVqBBiujf5pRxg==
X-CSE-MsgGUID: q0jQAgoQQnSlyrLw6ILpsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="71465957"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="71465957"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 04:28:41 -0700
X-CSE-ConnectionGUID: A1DwKmqISTKXyICpOznUCA==
X-CSE-MsgGUID: EXahYd8MSiWhYvhae86StA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="177522293"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.23])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 04:28:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 26 Sep 2025 14:28:33 +0300 (EEST)
To: Lukas Bulwahn <lbulwahn@redhat.com>
cc: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
    platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in THINKPAD T14S EMBEDDED
 CONTROLLER DRIVER
In-Reply-To: <20250926071859.138396-1-lukas.bulwahn@redhat.com>
Message-ID: <df7a869f-3ea9-d127-5fce-b62be9a2de63@linux.intel.com>
References: <20250926071859.138396-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 26 Sep 2025, Lukas Bulwahn wrote:

> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> In the activity of revising the patch series "platform: arm64:
> thinkpad-t14s-ec: new driver" from v1 to v2, the location of the dt-binding
> for lenovo,thinkpad-t14s-ec.yaml was changed, but the change of that
> location was not reflected in the corresponding MAINTAINERS section.
> 
> So, commit bee278e18e64 ("dt-bindings: embedded-controller: Add Lenovo
> Thinkpad T14s EC") adds the file lenovo,thinkpad-t14s-ec.yaml in the
> embedded-controller subdirectory, whereas commit 27221f91b83f ("platform:
> arm64: thinkpad-t14s-ec: new driver") refers for this file to the
> non-existing platform subdirectory.
> 
> Adjust the file entry to refer to the right location.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8fcf4e34eaa5..b641b5e60bf5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25466,7 +25466,7 @@ F:	drivers/platform/x86/lenovo/thinkpad_acpi.c
>  THINKPAD T14S EMBEDDED CONTROLLER DRIVER
>  M:	Sebastian Reichel <sre@kernel.org>
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/platform/lenovo,thinkpad-t14s-ec.yaml
> +F:	Documentation/devicetree/bindings/embedded-controller/lenovo,thinkpad-t14s-ec.yaml
>  F:	drivers/platform/arm64/lenovo-thinkpad-t14s.c
>  
>  THINKPAD LMI DRIVER

Thanks a lot, I've folded this into the original commit.

-- 
 i.


