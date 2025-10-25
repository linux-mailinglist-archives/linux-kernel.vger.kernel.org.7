Return-Path: <linux-kernel+bounces-869701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2DAC0888A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 04:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 632454E50BA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B4523B632;
	Sat, 25 Oct 2025 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPmj2kBK"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE523ABA9
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761358222; cv=none; b=XtlsckqDMRUDyEzFYLZ77Y7IG7c0ro3/hXrLfYdiRYL6Um2GDS2zCGHs6XqaiLrvSWYsfrB5NBSGLSp1w6UKMZfN3bnM44m8Y8QyGT9AOSXR3C3U/G8VcZs6R8XWOYPujx1iWZiYVSpXaLyL2DgE5oo45FgIMW1OXpzGwBhdO6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761358222; c=relaxed/simple;
	bh=HUS9244ysl59Vq36eIRjlnVv6M6CDzfdg6dsmbE9H9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayWK/gMD6rc3BL0kLSeOkjVQPkJvO3IAVzu8QzFxlIN/ih0mMz0KGn9m1RadjjuclJ1zHbyBH/gJD8xTtxT3Z34DAwN3T2Xzt5FdQzwLzIiKB7pqoBKToz/cK5nsOfRqCT51uFESfwfRRYk+PAav9hgW/O3W3u+3xAvtlh2KPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPmj2kBK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a26b04bfc8so2987203b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761358221; x=1761963021; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9/FBYChVgWVnYtUmsOY0fMq3eM8ZJMPYKb26HoqCuHQ=;
        b=HPmj2kBK2M4ZdD1oerKh2XVl+Oqb6U5pk/SqNzH9TPT9a9voYVxBjmpGdYsrvVEiYe
         h4RbqmI09Ve2QXwzGo27s31navzcWuuqPvATj5dnCH3WDMal5P9sjZoF3Jq5PqsMjz+K
         bIawK+9huB1VdvqkNssH3600F3jwsGRrD/HpGS4qxD1iA5rJQoce47cie5lAcgsSURNU
         iOlFEdaXHPxEAlTfVa8IF8zEdgDPpWT40wyu1PE5FWJxjKWszINt8+VDSnqUmSATEXGq
         NIQVQAr++yB1Oqr2usOTm9LduswOr0Kk+ubA/ttsfMywLb6XasF5HkUO/SAfSJO77J2T
         L1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761358221; x=1761963021;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/FBYChVgWVnYtUmsOY0fMq3eM8ZJMPYKb26HoqCuHQ=;
        b=t0YR2SgvK3I/qMVQ2/s/bl2F6IHTgQhCa6EXpeKolUSmjJDJmGv/XC+sB48px/gJpw
         vudUvN/zaxyhdcLy1fHbQEKyPMMmdiDXTJ4uhxEr26pmHauDLEO5J76/c8BIT4STqklZ
         1VRQGKBhi2h7zXiOI+jmJLXgsfa5353D8o26L3LvS6FqBy33fbF8ZWOXqmaS2mDrLVsz
         6qx8wZlRMI3gX5QDDtFRbUXzRMhTnbH83kU1yqbFo/VS7NEQjIvYKLiYcOubqaEg23wa
         dtoeMMnNT3UNyL2vBWHkH1vQdBHt3m3PHlwMF9fYoz2K+nLCPZGVI1J4E1cTfLpBnQw/
         s7HA==
X-Forwarded-Encrypted: i=1; AJvYcCXL6lRIRQcS3opoUEpWmWYpsE0k0koahUg1Z/kf4QpzW7BJf3pQipSnaZI214xU6qCqxbRGVPv3H8rkHyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWrIUC4obYZXT/q0o+7GJRw0CQ1a482HhWQbNhzZw4YeJ4KAXr
	Z4teRYMBUQyesMarGawm3e8oXkx2ZbnMgzXgpbSow+eHW+Bxnpm5a31A
X-Gm-Gg: ASbGncv5Yo6d9uMtJfVGiBlPTVqkFWuLDDSgrTmBNSHbQ7xzV3bWk7fPeGnDAqnRw+1
	8CLZNf1QbV5ppBb3YSPmKAtnj498/p2R0IzarNRabMgdjzBuWArtxJRpdtG5GVD9BMx7VkcMIkq
	BBwBCyA8o6t066cg18AI+UqFeNayvztrgv3H3OWNSB6KoMQMPYkOydXRADRhNi4p2kBUCWcZ0eC
	veAUD3XMGl4ZefBTFDnCjPAXPQvFL3yUlLk7hPXhvLonOPc+/26KuLVK4qBt+HxMSrGK+i0ykSn
	E9bMKZIaDLjknggu1rKoZ+p/KBIPvr1M2L2aBQZHzCkRiEALaoQs6yfavYWSxxCRPmsey5a/77e
	UBMoawjg2tw5hXxx2qG+HPlIN8eL6RQ25nGtzbXlj1vPvhXVeXIEUOMPBJWUmEzLvPL/iBqGoEy
	LQ
X-Google-Smtp-Source: AGHT+IGxdF3j6/BMru43Wtt8roJ9EkCuO4V8hWSOev8tC8y9D9Mkhnf7FOrlQlXfV5+SHKSZlrr6MA==
X-Received: by 2002:a05:6a00:94d5:b0:780:7eaa:938 with SMTP id d2e1a72fcca58-7a220a7f285mr39262909b3a.12.1761358220535;
        Fri, 24 Oct 2025 19:10:20 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414068cdcsm639966b3a.47.2025.10.24.19.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 19:10:20 -0700 (PDT)
Date: Sat, 25 Oct 2025 10:10:17 +0800
From: Longbin Li <looong.bin@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Yu Yuan <yu.yuan@sjtu.edu.cn>, Ze Huang <huangze@whut.edu.cn>, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: soc: sophgo: add TOP syscon for
 CV18XX/SG200X series SoC
Message-ID: <3pyukscivyj6iarozoll3jmavjleyqe44fu7xhimot4xorm3tw@rjybzefmfkui>
References: <20251024030528.25511-1-looong.bin@gmail.com>
 <20251024030528.25511-2-looong.bin@gmail.com>
 <20251024-hangout-designing-33e96c0d35fc@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024-hangout-designing-33e96c0d35fc@spud>

On Fri, Oct 24, 2025 at 05:46:03PM +0100, Conor Dooley wrote:
> On Fri, Oct 24, 2025 at 11:05:14AM +0800, Longbin Li wrote:
> > The Sophgo CV1800/SG2000 SoC top misc system controller provides register
> 
> Please remind me how it works, sg2000 is just a rebadge and really this
> just refers to one device?
>

SG2000 and CV1800 belong to the same SoC series.
So it's more accurate to describe as “CV18XX/SG200X”.
 
> > access to configure related modules. It includes a usb2 phy and a dma
> > multiplexer.
> >
> > ....
> > 
> > +
> > +description:
> > +  The Sophgo CV18XX/SG200X SoC top misc system controller provides
> > +  register access to configure related modules.
> 
> Here and in the title you have Xs, are those placeholder or is this
> going into cv180x.dtsi and going to be used on multiple devices?
> 

Yes, the “XX” is going to be used in the whole CV18XX/SG200X SoC series.

