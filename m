Return-Path: <linux-kernel+bounces-851714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17A6BD71EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94E7420C39
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81AA3054FA;
	Tue, 14 Oct 2025 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ryx0Sqr+"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75B304BA6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760409980; cv=none; b=cuBXF7xMFH2tY7oU9AhCFmUCGQPOml6Ew0mX3LMdyrdgNTNpNVa1mywvUrjjpGYGrq/VpcWgmbRMrQUovgwqQ503Sq723+PZ7hSdtnEj6D94NyFt8TEnmBgHltBVE1kWc16KDPbbkXusGxGDA99mKrqYAc+I5+UtuYXEgM7WK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760409980; c=relaxed/simple;
	bh=VjlKnt+fZVo3N7p1DHHgkMdCCLtNZYHYXQ6W4bXDUr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i47b0nBnLwylwiNw+w8zTaM0wfhIncoxs3xvZgkUL6TJSqRUsh3uV3Ofp/Dp8PyMW1mDk99oXRwXvDi659+RY/0shOfQHG3t8uFpnSTXwOzijCji13MYM93SsDFRXmqV/kFvK2Pv8lHznUzNB9ncPOupidIvbdUHS2ZpDsPXdoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ryx0Sqr+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33082aed31dso5017757a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760409977; x=1761014777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jrmu7grANyWKY0RDn5IlCKkm9AdM4oT1qjUuGdu3tUk=;
        b=Ryx0Sqr+KRTBzMMVkoD1zJ5tgCjeoW4CYfUQ4v2m5VfTWUq0kcsB0RjvOFYL3yRB8b
         YgIY4i3MtZXJBymkodA8zWZmIHYVJKVZG62MPMBCH27RPFWn/8LZeYpB0bd9lNUeycTd
         q2oG16qMy2uK2FIb1YsA0V0XzIbWGlHE2SDzdKbkSBKBHqULcsnhyHfat57ru9OJS8eq
         QnDDhGx/+QIps89zXopYgVN6nGed4HvIV/jhOCLlAn6iuUOko42Vzkk9jn5gAqSITnIw
         hyKTVMTEMxGxYpEyjw3hAJUnBhB9i8NWy7J2mR1rGKLRbUcsqN7Uj6zHO4bj7XuH1PX+
         yYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760409977; x=1761014777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrmu7grANyWKY0RDn5IlCKkm9AdM4oT1qjUuGdu3tUk=;
        b=eepWcSqQD9Oar7jhqs9PvWbsAPlMfpMTdtPHGV8ueA1j6W+j0oReke8jt8EqzvTiDV
         6i+4TAf5alQVCpFKx22SZXgcauULONxu8Mcn9kHGd3yjN7Cy5YUoE5DDjK4Xc7ld4aJU
         BLojLapaFWyBLEbisJv2w38QJX0xzh7AaUyqWXdbkjs3VUHupC9nRFbNhgtJfFyXASyF
         3Ikc4y6Qa14Gc6+/1GaqVz6798D2Z+ej1a1ysu7PYziM3anXTv0c0s5oeTpeVCwOvVeW
         m17HRuCQiL8VltH/UrMY2JJzcRgmcK2U16ql92cMrtk4AG3f8V/F2vzl/zpfdZbz6Qyn
         IFzg==
X-Forwarded-Encrypted: i=1; AJvYcCUnt7erJqh/+y4rm54XwlAFPwLn6pnSB3aOQdMAunErTyQmEwyuYRerq3VhcmxkrBu92VFp9LyWQQ53lU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU/64FOSFXAHmkeaAfI+vsh9ky6xjKmGeKvLD8B+sqMh/KaN1h
	DfDjuHzqTKxWhqu4m6lqicbxoeMdwK8G7rsvuM0SG5uIujQGWrf28l81
X-Gm-Gg: ASbGncswF0CeH4KG0Yc+Zbl3ajGC2JK+r8KODW7v/QGFoczU2CZSAsX6RfeXvjL88Tq
	ulVjRreNsn3cM+vNfCtYixnQy3qVhE1b3R3pxeMxqrMOYV6sStMokqxqZ8+mXdxgIa5NRltjXGU
	eJfRESWD8y8qSl1S2EPcS4GkGxyjuEx44ZQUsT/NEvT//7epf17p69mjvoO3y1Y7MUC6bdufcut
	34279QdLO0FpuzLlJI+DefnR4of9oppP1iUn14c1u8Gdp4n1hFnsR76PEbNJbCgfybJ7U9n/Z04
	O1Kcf1LKewKuAvsfpTEab4bN1rvOJ1ElIguH6r5Wb4OTPTL59EsL0MG5mA/BJv1iJlcMdpJmH6/
	qTEw7cBR8NVF5RqdgKk/fiXDv8AStKi8cU+NyaMjL4aSw0fSlty8Grad7Z+FUp/R4Ab0ds/si+e
	Uf9Q==
X-Google-Smtp-Source: AGHT+IEDL3uz9npcqeh6sedCwhV/tcZU3zwDosN41rb17ZNPeKEi9HTfTRTJU5kAj/2Llv6h5Ylzng==
X-Received: by 2002:a17:90b:180d:b0:32e:3686:830e with SMTP id 98e67ed59e1d1-33b5137586emr32921823a91.23.1760409977067;
        Mon, 13 Oct 2025 19:46:17 -0700 (PDT)
Received: from [10.0.2.15] ([152.57.140.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d7e4sm14208195a91.3.2025.10.13.19.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 19:46:16 -0700 (PDT)
Message-ID: <097fcbe3-2433-4010-a247-6e1960ca15ac@gmail.com>
Date: Tue, 14 Oct 2025 08:16:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-test: Fix sleeping function
 being called from atomic context
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
 bhelgaas@google.com, cassel@kernel.org, Frank.Li@nxp.com,
 dlemoal@kernel.org, christian.bruel@foss.st.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013214033.GA865945@bhelgaas>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <20251013214033.GA865945@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/25 03:10, Bjorn Helgaas wrote:
> Thanks for the fix!  It looks like you posted it during the v6.18
> merge window, so it was a little bit too late to be included in the
> v6.18 changes, but it looks like good v6.19 material.
> 
> Can you please:
> 
>   - Rebase to pci/main (v6.18-rc1)
>   - Add a space before each "("
>   - Remove the timestamps because they're unnecessary distraction
>   - Add "()" after function names in commit log
>   - s/irq/IRQ/
>   - Rewrap the commit log to fit in 75 columns
>   - Rewrap the code below to fit in 78 columns because most of the
>     rest of the file does
>   - Carry Niklas' Reviewed-by when you post the v3
> 

Hi,

Thanks for the helpful review. I sent a v3 patch to address above review points.

Link to v3: https://lore.kernel.org/all/20251014024109.42287-1-bhanuseshukumar@gmail.com/

Regards,
Bhanu Seshu Kumar Valluri


