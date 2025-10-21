Return-Path: <linux-kernel+bounces-862898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870A6BF67A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A41404E65
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9B232ED21;
	Tue, 21 Oct 2025 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VoL5Saxv"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC41F956
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050183; cv=none; b=tx4iHXdqGXSnhP9nhoGLhtWc4KmuJLgEGVPKNTLnJs2fe6xTcpxWSnlnQwG3O/GbYQfRbbZr2cXx0mZ0cZnELc1wJfPUp3GZR7syD4x7kAdEN+G8hQLBRMCPxMC8ZotjRX42O1CwkEY8wh7vybDkiX4i8/3HTCi3epFqSrc1RLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050183; c=relaxed/simple;
	bh=IuvVYLP4TD5FVjAFF7R1GuTDvgwa7BCbt7d39eu17rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9w0rKgRWG90yFP4bqVcT82tyV9hHWwNsdFt1ZAGnPSyOOfyr/y1VtsOPiPgwkwkf2TW/QOFuW/C6o/xgg06cSyfezQu+NkCBaUncmUTTwbbVsOGVD8mQhw3Ci083Q0fWPzdELySNEyRLi1h3WuLoHQShQchCaP359gdCYD8diw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VoL5Saxv; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c27665ce3eso2861888a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761050179; x=1761654979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BscMy2QJPNp/+d50tHKif/o+NtFK8tk0LmkoZ49Inww=;
        b=VoL5SaxvXL/a4r+2CKPBWnk7l57IaPRhdBrkyy2OJwKbTzKSlYbjEsTLOLPvwQ6zku
         q/c9aN2Mx1TIKN99CN/le44y5iussV6GNx27KwO0YifMB87g4CKB5UWwdzHBLSg0lg3B
         go00prnFgNsKS8iUhHbaYJL6vEHGaj/Cpfp6bgccWEn9/lQwwEB2p+kod2vx28fRe368
         MbFZrSXL+BUsEMTp8+3mKpmlriCmha1q3C1rBK+/5Q2Fx2OnVUUYZJhdTuDzxbtiGGGn
         26yxPegL8L7LgVZ8WqSad7Je+9grP1mBaA/NmuvZ85WxdmUZyR1ycSGX1vhuJ0wQSxrO
         Da7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761050179; x=1761654979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BscMy2QJPNp/+d50tHKif/o+NtFK8tk0LmkoZ49Inww=;
        b=DH7PLsE253V+0kA5WRKysrqejHy9WNlNdgMK+uwJEGRU9zxXwIanY33nnsroLFhDlO
         bZB3zY1/rE9M5X5kxTZoxmsQYWXDoX05O4H5rKZSiWkWNwtmsw5ijlZr6Bzvfznkv4RY
         l6kYGXyrlDZq5m4W61ea7D040EarfLUCKbr2/FZiGX6iMSIDrGOHMAoFRpAfXWiSwX4z
         LM0QIDbEl/2zn05U8lqkaqeMWhpIJiMjdE1CiJHDNa9cYBXHDnVqlolBoTiCqvfcA+Jk
         9iCG1Z0MOSFbkxYhdIA3U8HCz7yJttaTXtOgxh4k8U5H8RujKAus5VWq7KA+2YJN8a8B
         POXg==
X-Forwarded-Encrypted: i=1; AJvYcCV0HCyB9QKTGhlpjpfzkve3l/ro1gEXfCJBtg7rT1L+ELTKeJRRQ5kdLSp8E9j89GcjYEIZ2N+XkPmjaRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9T+9GNLprU0sruDKUfTIUYxGbyf+Oy3EGsPDXuoQO+KW7bkbI
	jhoKKi1mSmdrMiC/p2BgUKsO+7Ocsw7S3pclPl80GyeRaChEhv/2LyLeUzCIqxCv4Tw=
X-Gm-Gg: ASbGncsb1kRWcu+wbTNgbSBVbK7dk28lrEG2c/cOt7N6aA4XTVn9RiSbuFnjynCZsqu
	bjV9VWQy16ZicEqPVROoDuiJ1N1lvlZR2rClc+97xAzTexGdKXpJgtX1BCTWl40r7idByPTQAkF
	z/NkqyF9gTXsPGppjrPTGNJNv8jlB3hE1E6j9YX5Ppvyl/wQOX9RiWuq4r0B4kgXf/V/sgkkIls
	Ixv2sFOar/tArTtusJ5xx/a9RhD+e654WMqiUW8vr9ms9tuA2g5/Wk8wKGmoG44l/e0840prP7e
	PH7BBQ7Fx9RKCJGzQF97IsZYUc9/ahoNP3/ART/MXKxxqXKpDlc+EOHe00x5IMzhkUaAJh4htfL
	PeLp7jYjPD0O6iD5k2SE4/3QYXzBVzBlRxqmcz1hhOgKR0uh8Ch/rHSlieoDz
X-Google-Smtp-Source: AGHT+IE4uTkSED8b/A/idZtW99ihUnHUqwxK7WWbd6AGSBlCRqAodEvAD8ghVSbFuqK4NuJu0j2F+Q==
X-Received: by 2002:a05:6830:6585:b0:7ad:a421:c655 with SMTP id 46e09a7af769-7c27cb45e2emr7263619a34.19.1761050179263;
        Tue, 21 Oct 2025 05:36:19 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c288935ed5sm3631744a34.32.2025.10.21.05.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:36:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vBBb7-00000002w2p-0naJ;
	Tue, 21 Oct 2025 09:36:17 -0300
Date: Tue, 21 Oct 2025 09:36:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] vfio: handle DMA map/unmap up to the addressable
 limit
Message-ID: <20251021123617.GT3938986@ziepe.ca>
References: <20251012-fix-unmap-v4-0-9eefc90ed14c@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012-fix-unmap-v4-0-9eefc90ed14c@fb.com>

On Sun, Oct 12, 2025 at 10:32:23PM -0700, Alex Mastro wrote:
> This patch series aims to fix vfio_iommu_type.c to support 
> VFIO_IOMMU_MAP_DMA and VFIO_IOMMU_UNMAP_DMA operations targeting IOVA
> ranges which lie against the addressable limit. i.e. ranges where
> iova_start + iova_size would overflow to exactly zero.

I didn't try to look through all the math changes but it looks like
the right thing to do to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

