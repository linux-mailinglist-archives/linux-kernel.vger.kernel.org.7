Return-Path: <linux-kernel+bounces-824191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6558B8850C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703AE526D80
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F912D028A;
	Fri, 19 Sep 2025 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Js4kz5gX"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C90A24EA81
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758268895; cv=none; b=eM7Y2pIkS6CQ3zohsHp0lElP87Jc4V4F+P+SOKW4E+So3imXDvOsUfntyezkVtG+uotGZsT2l5/JlXrScCZvAL3dZTqGgAfKvYAtWy9whRj9f9T2hkYtD5uCvXrWOsNJRb54PPDvok+q0Y539m0QL4QKHAwRouoI1Wc/gPj0Rlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758268895; c=relaxed/simple;
	bh=G9EfOedZLRlrPC3wZ2bKvgfY479PkPvphVW71kg52sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kipVpwNCKq+B17eQ+El+9MLgsIsPU15PljkAuKP3E+z6oxpnhPQp5Rt9vqwl9rXO8dSOXTOr03nyuFVbmJzVfWQl5iZyJ1KbxsZxTbREm+MzLiqR2Na85VGMoTKPJzWpySqrSDdigY1KoleYHb7VHMavKZzytoetZj3b+Zjftzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Js4kz5gX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso16197795e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758268892; x=1758873692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a22LDubTXvHim9B6ODtrijf0DgwZwF84jacr83hWucA=;
        b=Js4kz5gXeIH0bKYm4Fzu5lOClwyzJYfEwsxXPb6ObhFTIxoHR55F7MgMO2tMxqs7FI
         vB7EGVBG2Yz7emp9UiG8JkJiChAR70ti2gcE+72C3BMGxr/zXc9KRZGMg9PbiyLlvBfA
         3LHKB/i/FOY/zA+vfWJ7l9sFwJiiWXG0l25bEiwmyvgKdsoQGjogze76MzU7uQkGUm5u
         6JkVO+rULX0fSNyvNueHR3craDCeuoElzwVzbbQGGca3gHJe8bZzDuG6JvoC1oKaO92h
         OYKoCaQpnVgit2Hj8ffLbtA43OCd4m5hr6r6PXwwRejOVbH8aiqkxZCoXzciBfp5GFXk
         xvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758268892; x=1758873692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a22LDubTXvHim9B6ODtrijf0DgwZwF84jacr83hWucA=;
        b=s5frrp5Xv2/qJRv6uCMLJlI5Vw/TpgvrBAkmbupO1N/879E4NQzeX97d4Za83kxD53
         IMfM/77UfnhhoHJHRzHGQmDwSMBvoyK++DDKUaLxsirB0nArE+gki6LNehSLTPE8NJ8+
         Rrf9qqqZL1BuhnnaRr4Ja63ciV3MpBmFHGHBI/J3ShaUdCyrhrIFmndcCA+VjvJ55xba
         WRVs18CZa6+DiodpFJeceKtr9stg9VoU0N3Z3HQpb6X8ghKWgBDFUklBjluoRlpWYIiw
         sN+8GMrBRn5u8SpZiSPeP2Qv/8qFxyTFtrMvI/WJiroRK91Lj6km0wMix1fz4UhbIRXZ
         Vb3w==
X-Forwarded-Encrypted: i=1; AJvYcCUFMg4YiUmzF8MkD2hLbrSJbPP+MWADo947GDEyJe04V8W0HhaPS8EmwHkPFSUebcgKT4W9M//mjYLQ29o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhNR4PL2u2+KF2eBKprxx52WFz6nMKe+u4oxCcvLOOwVIRrGU7
	mMawjUcsnJFFx5ODA7w+nKZFA/41OYl3kpReOVmrsPs3TX8f7WugKOTX2tqJPVN9ArM=
X-Gm-Gg: ASbGncvsiCECuX1b7OVUv9JyNBFBbnRNZuZchbNRRGWUcEhhC4lwogAtsawXcnRnQyE
	jO5CANk4ShbcLdgaGI8b6P5pgbVtNe/t7dy1zVefFy2fygmyBSXEdIZm3inJ7ATTXxvwCCasTY4
	GnpsHRX7rntNY8Ldbk3k5ng2o8hNlliZQyhaxvtZtqsKGnBbVAM0Ukirc+Q6+5UvnpH6e4chnbw
	yZHPPDM0bSPpZ1AxUgEmFgR/FJ+bZI7PDvixbLU6/7oAM2H2BlVmOidpExcbzwIb6Zgm9E/qQPP
	oDPkzPACoQHoyJEOfgRr1nsgtZT23VHhMiGxIQKY9CLrTgs540DFz3t1brvVnJBFjoGbbQb63QY
	f4ESpfOvUN/PFesl+bTZJRhE7nrXd
X-Google-Smtp-Source: AGHT+IHAUphO53ZLkTrQ8X9O84Iq88RKjwPXCUorXJ1SdYoKX4xMrjbq4DzBe4qxbr0QGAkpfmeJPQ==
X-Received: by 2002:a05:600c:c04b:20b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-46886e0de83mr8273625e9.4.1758268888777;
        Fri, 19 Sep 2025 01:01:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-464f4f9f4e4sm84977755e9.13.2025.09.19.01.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:01:28 -0700 (PDT)
Date: Fri, 19 Sep 2025 11:01:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Soumya Ranjan Patnaik <soumyaranjan1812@gmail.com>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: enclose macro values in parentheses
Message-ID: <aM0N1aZYErdXsOAc@stanley.mountain>
References: <20250919070351.586981-1-soumyaranjan1812@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919070351.586981-1-soumyaranjan1812@gmail.com>

On Fri, Sep 19, 2025 at 12:33:48PM +0530, Soumya Ranjan Patnaik wrote:
> Macros with complex values should be enclosed in parentheses to avoid
> unexpected behavior due to operator precedence or macro expansion issues.
> This change wraps the LINVAL macro values in parentheses to comply with
> kernel coding style and improve code safety.
> 
> Signed-off-by: Soumya Ranjan Patnaik <soumyaranjan1812@gmail.com>

That's going to break the build.

https://lore.kernel.org/all/?q=LINVAL

regards,
dan carpenter


