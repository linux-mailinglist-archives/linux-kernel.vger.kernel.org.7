Return-Path: <linux-kernel+bounces-895937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4881BC4F506
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E843B2AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6D73A1CF3;
	Tue, 11 Nov 2025 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9N7wtio"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356B3366567
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883414; cv=none; b=QkiHGAbJTN2IVnKy8QLFaBThwYfKVGYYfG9lsMSu3ttnwx0qXTHAwN/ztc/LVPRCCiwpOx3sRmjUxhInJvp6DjXhVG9V2/iw0T9+0e5yxE1o/4fFdQnns6bDEwmZ7Zfgjuzr5xMbrb5pPcwsikFGMq8bdTWmlapFabcbgm9P3VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883414; c=relaxed/simple;
	bh=hIPVTkR2pbZBkmPWapN1AZOJSBeQpLh6MMgTnPaEnDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSVclf4lZuNm+oGCBXshN58QDYxwd0p4scrgatv0mcah7unziqeaBytnuu0VC9cRV2X/PKec/FMP01USuGWsEavgrq2XFZpZAdvXQon03wf/2+s3OJsXwSWRzNHx2HvydojHIuSrgohN0ZStaQCf4DmuUyAUeimR1eawsDjD2dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9N7wtio; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b0246b27b2so4768674b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762883412; x=1763488212; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hIPVTkR2pbZBkmPWapN1AZOJSBeQpLh6MMgTnPaEnDU=;
        b=l9N7wtio8AUzLmwN8wSh7OcLkQ46rmOau7vEP+5EfWfyJ9n1zO+MtH2m4R6veJrIf/
         PziNMu3zo3JORe/bcECwbVV7QspYWNmW4f0smqH/FUVDT4GVdh7iw36FKo5AIpzMqz3v
         mw3o2Q/y9z19VoJuDc65wcr4ZLrQ8FOum6BMJrA6qnBf26iH7e/g41WlLSRhgSon6Edt
         3WxkfiPfjAEYoifj4wt/DFCXCZWvK7Pc71yKy+Rh33wvxRUUFNLEvz29a1uH7cPG2pQj
         JrbnLO5LhDLOl9lkKze09hHyOof0zPdVhrrIW3/ck12qzBoZ5VR40HOWNy0kxUKmgmwF
         wEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762883412; x=1763488212;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIPVTkR2pbZBkmPWapN1AZOJSBeQpLh6MMgTnPaEnDU=;
        b=Q8l3lCmrhrXCwIKOHiSWexp1yQhgnSLjmYgngT1oroiZx4t5j1hG+c07KARahZjKNh
         xqEdGULXK0nst5NH7qLfgZ2+MwZtfUXwLYqEzziufndCxgO0LEzt2y7ZvBR7d7H+Fi3L
         /XETIVdsmdacR3cbZ8nj/uvDyN3WmN65wGKkDlZUK+ve/gyPrwp5IXzD1NxGqSlTtbbH
         sfSk3H/SLcaSkRdc9Cw8wgiDn07ySi4HqB2bjRoWIDOZWk28Hhk5oB10yP0vuy2XW037
         q206gJ9BHPQLQOfKg93kg9q03xRIK65TalSB4fcWpfhjHJvOidjYAnICHz1+XFIbjUof
         0NpQ==
X-Forwarded-Encrypted: i=1; AJvYcCULFIAH0YQWjLx239w7B22dcnMEIMa0w1MbKH1d2Yaru1JfGdiaoGKBEe8uNIxVhmnfdOIYec4CMUXplhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1wf1dXgZiuEigJvpv6ceJ6xXnkfCQhXXw4xucaOl/XRQK8/bq
	+LZkiM1pLWupgZ1HkcoNNtDT8j20y+CtYJ8Qkc6xnRU1d9aj3B9Xc00W
X-Gm-Gg: ASbGncvy2bRtbMCCIhwhkFFXo3w+17dgpQyU4VIoVAr+9JTInwQwMeMO15h9Pauin6Z
	suxI0TDfFSZI0NO1MwaDhQWNftnXRjKnu6FKi7cHXkkItaMT/nj8095hJputM7ecxjWL89eO+Uq
	E74KxEurZIRiTsnQxaJQ5TBH51Q1FFcBFGG/bHnhgJnhL93cr6xP70njT+FdZpJDE5jrL0rHeS6
	YN+q1nbefQa4cDzUVP7L3CU30ulsv/cR/u0l/M2UwquFRzxkHZf+nE/eGAsZo1aBUd8s8Y+JALY
	ZEPsibCA7s9UOL8uS0FaX6f/Zye9dVAsKVeIetT7UjkP9ro8bT+vPANyZVWIAZh/TZkdCQyq2V7
	JC9OyKoeEZ9CWPth6vYOn/eH3q+1BI6QHyBzJrDoBF0huMOJu1ysy5J1ws19O18OqaGLFVc8U8o
	rPXFgREpnbOFnLjfdOIHjVhNr9CiecdFef
X-Google-Smtp-Source: AGHT+IG2wLRt+FHVuVKrFyDk6D87jUa6ulKsRTc4ElvGIUi+Ps48OV5Tavonxqr9dChaqkEyGsQG4w==
X-Received: by 2002:a05:6a20:e210:b0:34e:b034:a5e5 with SMTP id adf61e73a8af0-353a385ab2cmr18505176637.51.1762883412297;
        Tue, 11 Nov 2025 09:50:12 -0800 (PST)
Received: from joaog-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf165f99f1sm230491a12.23.2025.11.11.09.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:50:11 -0800 (PST)
Date: Tue, 11 Nov 2025 14:50:06 -0300
From: 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Kishon Vijay Abraham I <kishon@ti.com>, Swapnil Jakhade <sjakhade@cadence.com>, 
	Andrew Davis <afd@ti.com>, Francesco Dolcini <francesco@dolcini.it>, 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: TI K3 AM69 Kernel Panic when PCIe Controller is Enabled
Message-ID: <lky7ocqazucnh3xhwswvs4idjtljt5ixp3ibwwa45524pvxzrs@kmkml6td7vju>
References: <pod3anzbqdwl3l2zldz4sd47rtbruep72ehaf7kwcuh2bgflb2@y4ox65e66mkj>
 <cf751cf7-53a5-438b-9903-903bd8c39b23@ti.com>
 <oawjd2mscz2untz6zc5mqn6ak2oxdul6pnaexiohe6ae3bow2r@afkvpu4izrvt>
 <ddc4e2df0a5593d4a6051057c6406db338f4c0ba.camel@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddc4e2df0a5593d4a6051057c6406db338f4c0ba.camel@ti.com>

Hi Siddharth,

> I have two suggestions:
> 1. Disable ASPM using the Linux commandline option:
> pcie_aspm=off
> If the bootloader that you are using is U-Boot, you could run:
> setenv optargs pcie_aspm=off
> at U-Boot prompt before booting Linux.
> 2. I had seen an ASPM issue long back in 2022 and had narrowed it down to
> the Data Link Layer being inactive when the PCIe Core in Linux accesses the
> Configuration Space of the PCIe Endpoint:
> https://lore.kernel.org/r/faa13ac2-27b6-94f3-ecde-60256bbbda1b@ti.com/
> The fix for it is the patch to which I have replied above. Direct link to
> the patch is:
> https://lore.kernel.org/r/20220602065544.2552771-1-nathan@nathanrossi.com/
> and it modifies the ASPM driver to wait for sufficient time if the PCIe
> Controller doesn't have the
> ability to report the Data Link Layer state (this is the case for the PCIe
> Controller on the AM69 and other K3 SoCs from TI).
>

Thanks for the suggestions.

I tested both of them and still have the same issue.

One thing I noticed is that if I keep resetting the board, sometimes the
issue doesn't happen, and I can access the SSD (this is independent of
having any of the fixes you suggested).

Best Regards,
João Paulo Gonçalves

