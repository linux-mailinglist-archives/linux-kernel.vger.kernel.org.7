Return-Path: <linux-kernel+bounces-844190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00487BC1425
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B1C74F51BA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2191B2DBF78;
	Tue,  7 Oct 2025 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Vfb8TQOV"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9EC1A0728
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837694; cv=none; b=Cil6bJjrdyYC0t5YCdaWIHYVMe6q0VDOT3hJpVUKHZwXzgNjNNXoAZwlhooL4gaFKEE1WgGBOtVZI9CEcRkHcwLD4nEiqLOLsHHxRihqqraXBaVPQARf5nn42pCVXee4NOCOa4z1cbU+jS1wCcAGgh52iOq367g4y9zp8O+HZoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837694; c=relaxed/simple;
	bh=Cfm0WYr8Ng4oruI3YpfhVZo2vD6dTrg04ktsJe+eN2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuFUslqR30wT99qbXlMLMnR//dzJLKNoIkiIxpmAYZrtS7gnsG4gAMi4lZzMuobSEZgTSwsBs8A7ZEh3Np/M8rkutfQBOfHnsOMcJ1ZY2BWaoZNmK/yEx85Y5TSBaOb/EtoLziY8mSlaeDxPWMVXKx67csLIfxBi0GngRws+EaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Vfb8TQOV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33067909400so4597010a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759837691; x=1760442491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cfm0WYr8Ng4oruI3YpfhVZo2vD6dTrg04ktsJe+eN2w=;
        b=Vfb8TQOVage4MS24aGtTxPUG4QSRvPzeLd+Xz5iys4JrsIqvEKwl4YRsbmlJf77vXT
         D3ijBOUH9XgYMzHdzdZrQLZo5BesWwJ2NHgc/F0qczmb6aDQtGWfd8KSY/G3JTJPftF7
         jf1RrSniemalWYxt2WJVA4rOLYXvec8UlvS1b3cpXqOekkvu0MI4OzEpbHngNOY2WW4l
         ceSN2+1RYLM5VrqPfUO/dKPA4vSnm9r+svSBAjQl2/EwQ+Uq6vUZa3gg8KTjyRnj/VJp
         H0H6flhFCqXaWIxmPOPN9C53Ru1DAAu3ytNRrfRWBXpxLbNZ0k4572/KuIj/LlLDJh2j
         tyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759837691; x=1760442491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cfm0WYr8Ng4oruI3YpfhVZo2vD6dTrg04ktsJe+eN2w=;
        b=dNZjplDMWZLGEwNMIpcwJKjxIefE1c2a4R1XTkzibYdoeaEo/gGlfrAnS2o0mUJtEh
         q7RqEkP7Smtwz1+AubavbbtLlBZzyE5ryEeH8vfMOw5q/808+2hVQYw/mmimMJFfeWsB
         Gowwt9S2SuJbMoo8I0rnQSJAuky/nigGSnjOGlBaLD9FBMOHFhJnp4KyR1WqAaWBRzM9
         8i+bRvEPQwZOpkyT/Zgspw0wnl4BxNQLfo6ZgFLajmDHhWPQqGrV9JAk1/SJ+xr5LIU1
         yQuE2lv/9l40+fm3vVIBwYiDS5P+ikyok1yJTaPEhskedkM3WXBi8T7RFPShEXcuimDk
         yZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMSKht8MiiGc8DIzuMci3YbYCtzzdcN5IpntutSUj3IdjKCQihGumMGLMlAv8DvkJXXNlXLtOxuLQj3js=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkhoXrycHECh3XpQrfM6nr1dz3StMD0/tC5O9qSq6DpJX9zew
	MMJfkqzVbBVR41u75zFxV5jenwsL4GIM7AqstL5EcU7fN6emK9tj8M7I7uPX6hOace4=
X-Gm-Gg: ASbGncuybIxGU2D5CI19E2GPU/Ufy0SRQYMIkRTJaPKLHG0YVooNzPvWganSskOkaMp
	apljlQiNV1MkwPMwEvxy9icRTBDWcbOgUI9xA/LJPf7s9varj1xaHX1b/a3QxP0JyjRk6pN4ort
	Ylys/nVcty8vGpgG6pPTfYjc34vdsljg5SXnp5hMMZf27Wyss/VYCLL+niY0Mtnj6kb2d3FV1N/
	M50Hs2loYuIwgXAOBM0cdKn/7SNkYB55z+lwpPEeFhFKooFn8L9KVNV0zx1I+G/7BQmS6H1LyER
	tk+hd3x+TzSbmqJUkbg4kIptYjtjrIeiDZPZ9jpaD2GHfZQYrudgDxAptosYkN+1HBMhN4dgBFH
	NJvSUyYDClm+JOFerv/0C
X-Google-Smtp-Source: AGHT+IH9C0ODecpmYcfGoFScv9nIiYXXP7Mcn3Pwmy09XE0SD778RhgDgy365QXsjNRHns1dfmApLA==
X-Received: by 2002:a17:90b:4f4c:b0:32e:a54a:be53 with SMTP id 98e67ed59e1d1-339c27348f6mr20344760a91.16.1759837690580;
        Tue, 07 Oct 2025 04:48:10 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f7ab4fsm14844825a12.44.2025.10.07.04.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:48:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v66Aq-0000000EZWx-3Cfy;
	Tue, 07 Oct 2025 08:48:08 -0300
Date: Tue, 7 Oct 2025 08:48:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Alex Mastro <amastro@fb.com>,
	Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: fix VFIO_IOMMU_UNMAP_DMA when end of range would
 overflow u64
Message-ID: <20251007114808.GB3441843@ziepe.ca>
References: <20251005-fix-unmap-v1-1-6687732ed44e@fb.com>
 <20251006121618.GA3365647@ziepe.ca>
 <aOPuU0O6PlOjd/Xs@devgpu015.cco6.facebook.com>
 <20251006225039.GA3441843@ziepe.ca>
 <aORhMMOU5p3j69ld@devgpu015.cco6.facebook.com>
 <68e18f2c-79ad-45ec-99b9-99ff68ba5438@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68e18f2c-79ad-45ec-99b9-99ff68ba5438@oracle.com>

On Mon, Oct 06, 2025 at 09:23:56PM -0400, Alejandro Jimenez wrote:

> I mentioned this issue on the cover letter for:
> https://lore.kernel.org/qemu-devel/20250919213515.917111-1-alejandro.j.jimenez@oracle.com/

Use iommufd for this kind of work?

> I mentioned in the notes for the patch above why I chose a slightly more
> complex method than the '- 1' approach, since there is a chance that
> iova+size could also go beyond the end of the address space and actually
> wrap around.

At the uapi boundary it should check that size != 0 and
!check_add_overflow(iova+size). It is much easier to understand if the
input from userspace is validated immediately at userspace.

Then the rest of the code safely computes the last with 'iova+size-1'
and does range logic based on last not end.

Jason

