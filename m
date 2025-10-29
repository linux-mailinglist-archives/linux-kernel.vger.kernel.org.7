Return-Path: <linux-kernel+bounces-874951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85985C17B75
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B484218980EB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF182D7D2F;
	Wed, 29 Oct 2025 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OijO5ShB"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3151FE47B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699664; cv=none; b=dEl88/lhwii7AafGgwOc+WC8vhmPgtKFAIhc0HTzQ7lOK1/YEwkoE0CE2bcdpAP1/HldsDLWO5kIVarGHDQE2XMW2OH7XrIilJktlNiAGqyIadZVRfVFWMSxG2Iuu2YYS1b7UNBkqzXybBaAF28FNK47NyGvnObV7e8//7rBh18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699664; c=relaxed/simple;
	bh=uTnDRKOlvzmL7s/ezFOD6tLmfxhtqIVOOmhIkAE8y/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4ywGquSMNUKvNybUnd3Nsywk5UR0ObommnLMTad1cXP+my0ftbFr2oUvadekP4dEGzmDs/inq/QCD0Kfl6uLdcKj3Xyr8P7tHyaeinqrntBJOOi5pB7RksHKboRqf0bcuIkG5XRCpOeKZmBSz7QNN1hxMN5hZnxJ7dGOdxbH2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OijO5ShB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a27053843bso9157150b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761699661; x=1762304461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EOFIBRmcwlFaN9bXxhzQe/4jdraVkcYuslQKkiUSHs4=;
        b=OijO5ShBtwVjynG12Z/cGAYPQAK4ZsUGsdY8YlydIx1OV7aO5xYBgllvk+N4roNQg7
         U+UreZ7QqQ0c4km7EH//LbR8gjnf93NUJbH6s/Lwi+GftkYGdYf9gqMRul8IxLIat+up
         zbzoskAKKAsVTk+dldwvvW16LL9HY3EIl2Jsat62RrVVs31H2g8BuIfaTfdSf9Oh1Bqx
         hWTtNDUq6K8UTNjGlsrOq92OaPZNJU1lULDQQmp/cRDr0/E9XrT5tAyKPbXdjXaAojv1
         cmqjeXggGEPLoruEenCuywr3otRJXGFLnTjhGQmRR/t32h5YrU9WiFmujzjHQ4Kd9hxz
         sBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761699661; x=1762304461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOFIBRmcwlFaN9bXxhzQe/4jdraVkcYuslQKkiUSHs4=;
        b=ZX2q71WtFNOh2PFkzr0k6wEyJcaHUf8Kzfu9ChBu4brCVjhE0RkYrosI77t2G6o1ee
         6hDPNAh1pEPWh7OAaLlu9Usg8HDCrOxfOEJ3DC5tU4oUEfQlDQb5Ok4p+zYO7FIb8px0
         /UKCazu2ocWWWLJCaVirKNkdJCTo0ybt7PKFf935xGtkDMC6Do+prz4Vp+5QUoc93u9f
         IaTc4L5T82ISLbBbI78DEvnJy7aIO45Oa1NUyqVExiW8Z350KoIXtzEHuE4EvjaWv4IF
         KSNszTNdNlW56bEKU7+yk/eygArvo6t2rFKZG8Z0/3/B+EdwFPp31bzvTF8Pm5jUAPhZ
         TrXA==
X-Forwarded-Encrypted: i=1; AJvYcCUUYyXXfwYDl//jeOBBUi8bLKIlHyRY9FIlKEwEWaCM4fNBl0YPnEL6pK2389tQ7XU4NE+6j4OPEc2UFos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwORU3/dxy/5rl76BbF1/5DRuFM+dSLpRY7ogY2X7F9MVRedrqS
	yXHK88yVI1c2ijGbuAFItyJ3gXjOVH2TJaM2lgLSohPtAMfaUj8CSbdn
X-Gm-Gg: ASbGncu3Mv8604IBfsSDxflzc2TU8WzV3pT8zVEIoH7S8zvz2wdr515Qdl70ZLtHyIF
	hFY9A9O0UsU330/ZViNWXfICvBBSrCq4ltBHuxVysbrJp8WhsNKhHIQS/Bf6lPSngxc3mdpDDss
	cjd0Juf0OMtNG7j0nplpNd3Xo55RJj8/Xo9ugGI1u0825FqYVRFaijw6DTo/ZNbGRTU0q6+/YKo
	wMPiqnqSF5vt+lPAX/cZQm/5d/A0Xh6ccZLCZB0BMT7eZn2NYmuv4yd/dSHctgC2zVFbMPs1uXE
	NoamEAqbiPBbRYBO/L4Ihd42Ru/QKjQhwJXctJUCiJpwhWjm51XZzyCPK8mAnx5DxFhNxwnH3/5
	DrqGyuufYH+glFsaftE/A6hWPkwt6aYOx2xWoFmD1nt1o33zK03o5V4UkfgdHtOl8dCjPEefL/D
	HrLqjHXI6R9g==
X-Google-Smtp-Source: AGHT+IEMe32xqVGqKCj2DGI+hZvdmpFIC/0PTrMJHiFO3ihM2p5pLrA2hxJkIMoSwNxbQFCypenenQ==
X-Received: by 2002:a05:6a20:914a:b0:2f1:302d:1285 with SMTP id adf61e73a8af0-34657f5b873mr1069767637.17.1761699660885;
        Tue, 28 Oct 2025 18:01:00 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414015724sm13039315b3a.14.2025.10.28.18.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 18:01:00 -0700 (PDT)
Date: Wed, 29 Oct 2025 09:00:52 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>, Han Gao <rabenda.cn@gmail.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, conor+dt@kernel.org, krzk+dt@kernel.org, 
	mani@kernel.org, liujingqi@lanxincomputing.com, palmer@dabbelt.com, 
	pjw@kernel.org, robh@kernel.org, tglx@linutronix.de, sycamoremoon376@gmail.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	sophgo@lists.linux.dev, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
	fengchun.li@sophgo.com
Subject: Re: [PATCH 0/4] Add PCIe support in DTS for Sophgo SG2042 SoC
Message-ID: <ilkog5axxgj2vexc2wegkpyyysrrcjhejamnpc2wmb3ilakbwq@f25veozfglr6>
References: <cover.1760929111.git.unicorn_wang@outlook.com>
 <PN6PR01MB1171791524E2BC1C227E342F6FEF5A@PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM>
 <CAAT7Ki_4nkKM1-D_8ybwusxTTsR=Lf09v8Cx6QDWfuy8KLtbBg@mail.gmail.com>
 <PN6PR01MB1171739409EDE88BC4453D09AFEFFA@PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN6PR01MB1171739409EDE88BC4453D09AFEFFA@PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM>

On Sun, Oct 26, 2025 at 08:31:49AM +0800, Chen Wang wrote:
> 
> On 10/25/2025 7:58 PM, Han Gao wrote:
> [......]
> > > > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > EVB1.X/2.0 can be started normally.
> 
> Thank you, Han.
> 
> Inochi, please add "Tested-by: Han Gao <rabenda.cn@gmail.com>" when you pick
> this patchset for next.
> 

Just add the tag is fine and no quote, I can collect the tag with b4.

Like this.

Tested-by: Han Gao <rabenda.cn@gmail.com>

Regards,
Inochi

