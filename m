Return-Path: <linux-kernel+bounces-792546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEEAB3C569
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC5117C3E6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E909D2D877F;
	Fri, 29 Aug 2025 22:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz5s9t3s"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127238F48
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756508197; cv=none; b=e57Yry9ulw50OBb9EPQDreDNXWVV+2lOuHa/FksmQzrY7/WqFsoc/K09dEBPojwoy0jyJ04rctwTdhZs2ZWRR8LnrRMFecuBE/JjdZ6ek1hDxWutYBRgHFBKMEPsj8fxrLa+LxQxelMH65dR+/7h8l00WK3D5d9BqqXJBVovP6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756508197; c=relaxed/simple;
	bh=346Y82SdRbR60F7oMOMrqEs4pNXOu+/FWMzlr3aq/oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BybXCORNEVr7nmIYKIXwy3aW+4eO5g4OIiKyKd0OmJa/VUTnL0oDFEeIhFuAJY2yOcLTiCjt7hMQf6EZw8Qj4bcTaVBQvSKozgHgSk3+lMY/bJRYm18cRvKln+yIbpaIPLc3Mm1xXL7WgB6sV/aBBPsHwXSDoUdgMWPsoc0UysA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hz5s9t3s; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7722d6cc437so1113037b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756508195; x=1757112995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=moy+v062wTa6PMGyjHux9KlOsyFyasxsckZuNnnWIm0=;
        b=hz5s9t3sg1hbzVbw/5nayiBA/DVbl/Zo5qsVr6DAkgSzatXhnaIoy/0BIGkwtaQKeq
         W2X/awN23e+Lh0Pijg/hODUys3VLF5vXJEDm0EWNNTO2Q13Cs0S+qWTP6t6vvGslWy2q
         dqLOiY31T9P67B17bePcWY9EczzzdP0aPsWnPP4KxmmnOns+0ByFwLiAZbB4t4eguAZ3
         TpoELd8nQK6t5xBtUA8HcZhPy/O1q0/LN7WuRxBvanUlSfU9y2U0A7AO4KtczIb+HVvN
         PgyEiSv/Hu/XfLUw/KpAIImceJVWOG+nZHJmgJ8sdgj39HjsL1HLRROynzxTeKLaSzzs
         F3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756508195; x=1757112995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moy+v062wTa6PMGyjHux9KlOsyFyasxsckZuNnnWIm0=;
        b=uCHIGd3fw7sL3s+tEQJWKRFjQo3+hWTD082FjyEb8B06p86Bil0Jjy2reu8IteZwWB
         21N9Q+r5WqvVwXsMKDwLLXqDLEQF/n/yov6fqFMYNLby7ckyUSW3VNo/rdkFU7kCz4jB
         I87KS7wiLpbLDtQBRJT6vz46cA937982dmAQ7/VGumj5y3cv/+JIn3K2QACkIdlE69gL
         4d6F+Y0coIHV17EW4EWEBpdlhIkGflyA3Xzj69mPoIXA4vr36KF/+Gtjy+jXL7fmJiVv
         yeM0kPr9YdMxzqqwG9loDxDv8GTczTMeHL7iNBJzXsLgzysr9TQONNVXHCH0R+hoghw3
         4+og==
X-Forwarded-Encrypted: i=1; AJvYcCXxzaqbUm2KJm6b/i0iqrxsE2FNXX3EEM38SUJNxOs4XFTB3rOdFtuQw8rWQ+wl3LUDX6bhFjPFRXBkBV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8LWvIreWP/w4qtrF3zGs9IsNlWP2YctuhLvzXYLUNGVlqgckx
	NzxEVHzVGaLWtViwbvCtW9bcKJ7Tzz2fd9VbHDy/JIppzCoKEAFxhwpN
X-Gm-Gg: ASbGncte0XNvTpfWcFON8NW+eRoNMnhrv/eGYO0vOPDDMXhCV9r12bKyrIgKeIGmsrn
	XVt4cnCnxeajtjY6yGOSUbW8DL4c+b9Xj1KCKrWUFVwNJoEGnv67iBONEwH3xff4BP9+KSxoJ2M
	mquzr5XY+vCVri46z01fESxgtEZZkGn0MiFmhEvDGtLIetABwkazRKuK8QpvKNe9qOjcfiq4aRO
	y5Jhz3ujD9aqirW237uXZxLbQX791sZ4tXarhLw6fiYPCMvRFtse6/gFxX2Zvgl8zauF31n8wEr
	+mbm7MHt+cAaYg+KwfQqieX9Cb3KWc8X+tGj2LUuTPhiDWk9aOQKd0l80EFSadGlDsPkDz4bUvt
	rsewad68z+rWmXAm9XaSu1h8ehGKfr9LlLYrUQoqBbjikOXhzHAylsMsoKohD5EcS
X-Google-Smtp-Source: AGHT+IHX87XDPNTiE0CXbUrwygn+u5VjX14aKgc0q9EfZb/nWd1682f2jDIgn80m50UlWboVrtal9g==
X-Received: by 2002:a05:6a00:85a4:b0:770:580d:87fe with SMTP id d2e1a72fcca58-7723c445dbbmr914071b3a.7.1756508195163;
        Fri, 29 Aug 2025 15:56:35 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2aaeb9sm3312343b3a.29.2025.08.29.15.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 15:56:34 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:56:31 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
	yuanchu@google.com, willy@infradead.org, hughd@google.com,
	mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com
Subject: Re: [PATCH 03/12] include/mmzone.h: add `const` to lots of pointer
 parameters
Message-ID: <aLIwH38S7A9h78iY@fedora>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
 <20250829183159.2223948-4-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829183159.2223948-4-max.kellermann@ionos.com>

On Fri, Aug 29, 2025 at 08:31:50PM +0200, Max Kellermann wrote:
> For improved const-correctness.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

