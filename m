Return-Path: <linux-kernel+bounces-842270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA55BB9628
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 14:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 243634E1337
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 12:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3BE2877E3;
	Sun,  5 Oct 2025 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0J61QKu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D448726F296
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759666950; cv=none; b=sLxx9dB7aO11cksEVQrKugQpeYOnZPC6RNyoYGy5RYJu/n9t5DCt0/Z+NMuIo/nQWkZwg3KtRpoKsaTNPWy7C4i68lm3vygBEi/j5G9gU7Oi2WWtSYwT7eJaGZ1vuq227zDhDjElz5idZp0wQtQ5uWcpZSaQsPHrEQ0xWnxcVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759666950; c=relaxed/simple;
	bh=3z/GRSEK7dwA4hEe9wEHL8kx6txPAp1WRnuCyTWYK/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J25ciebjSIFIBIblQSMUfo95EjFFkasgCaQg3Jjo5BVvkO8J33/AIIdjcORz35u3u2H+aNm6kLQ05oCAHJ/b7yrM0kTVDIYLmnkL+F7JNBRtD77FdkZS2AQR8Db8fA5s8/HDss5RUTuZcd/ozm+iskr++X1gGzPGGWI+V5wIPzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0J61QKu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759666947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3uH/GB8TaEG7yh514K08ygSmxD+EPnFiaGKf1haB0Uc=;
	b=f0J61QKuGq0bptbyEL7pmWGHo2ybZHsRdJGXOVPmbcOpAnM3LRvErfIEZ1V0A8uZiHuKLP
	qx6+nY7XfWR5ORfVBa/cGPXDR7qihyVSocxBaf/2+Rfx1D5cafr1tYzReh//2rgJRFAplu
	0ICV68AQQzNHpmQSfTfLOQZOYw+xEOg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-17lmrh_MMSeaCBC9Ve4KcA-1; Sun, 05 Oct 2025 08:22:26 -0400
X-MC-Unique: 17lmrh_MMSeaCBC9Ve4KcA-1
X-Mimecast-MFC-AGG-ID: 17lmrh_MMSeaCBC9Ve4KcA_1759666945
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so2514025f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 05:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759666945; x=1760271745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uH/GB8TaEG7yh514K08ygSmxD+EPnFiaGKf1haB0Uc=;
        b=vMHfRLosQPZLHFJAuADu4wRgGxRSxJeuZLbHvavZkXawFJNa6AW3KBOE5ts02ftM0i
         qM61C1sUa7huWcmVy0Zzi5uTnv6WJKiBXjCcV2/nq1TBylafzyIKIpGd5cC43KnPnNBj
         7f8Onln6jtvdPR7ru9y+qLipS8l10unysznkpVXFIZ5u5XeLZmk4Paj4L1kAyrj+X9Dh
         Jh+vdVUU9vL6G0rwjYOgGt4LhH6jffPf3GSx0iyyCGHzW2qSeuBWrSdPdlyOXD1tNiXd
         p3cQagxGQvMhHRrjBHYLy/jNETKCSjAiLDvQXdc+XFjKdH2a/Y+NgN413XMhDNvpzgf2
         uUBg==
X-Forwarded-Encrypted: i=1; AJvYcCVgUOg20AdLMh06rVq4R0pBFJi5U/RVwSZNEesAns4wqYqCnQBR5LDSmjOSWqkPMZxsh+VlEuQ4v64cPs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO+ws4x2zIII0sui/de7C30kNbuF4lppB+PyATNOmbHSnLlJtz
	pHahryq7BlNOioI4HNrSebzXvlUViMm8VXBrRXdVH8GPgbs7C1YexP6HqpakDt8VhBTwlU/tqWS
	nWVjClI6T3n2a8P2bzMewQoK93KzyY+yvzCMbft7cUxM+Kd53CCxx1DeYPds+cd2uMQ==
X-Gm-Gg: ASbGncuArE75fYnOFUVQfNvB70egCFTVHeDp9AI5YKys4aXQbj8mjwgKxQMDYdXFx3V
	yOhojCiXD1TKoph4DJqug8C2+H5QTMbjPn81dOLZeaRcc0uUqJCuaGvso7mD7fFoHca7pd4+3rR
	WzfPaiJTPGj7vNX6AEmS8REMdG9I8i8/WF/JcjbWw3B16GOlFbSCLZytAcCMo9DOpH2Of6yUfVm
	hRpgxzsZ72j04PW78nzWuBxHXsRMQ4vT30grT6bwMgeaYzA/Ab/7fIJJswcHxJcDCn6rXIjBPO6
	qSaLpOJxng7JmUgiH+vf6QHXZfP/knYzA1Uq9CE=
X-Received: by 2002:a5d:5d13:0:b0:3f7:b7ac:f3aa with SMTP id ffacd0b85a97d-425671a9021mr5205855f8f.29.1759666945421;
        Sun, 05 Oct 2025 05:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG1keuMZu665iO+IbiJSlMHjR2azOMigBt5fMWxeSQ4NRIhAMCkxk2rk3nz8YU5tZ4uo9RPQ==
X-Received: by 2002:a5d:5d13:0:b0:3f7:b7ac:f3aa with SMTP id ffacd0b85a97d-425671a9021mr5205842f8f.29.1759666944911;
        Sun, 05 Oct 2025 05:22:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f017esm16660799f8f.47.2025.10.05.05.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 05:22:24 -0700 (PDT)
Date: Sun, 5 Oct 2025 08:22:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
	John Snow <jsnow@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 17/17] scripts/ghes_inject: add a script to generate
 GHES error inject
Message-ID: <20251005082027-mutt-send-email-mst@kernel.org>
References: <cover.1758610789.git.mchehab+huawei@kernel.org>
 <5ea174638e33d23635332fa6d4ae9d751355f127.1758610789.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea174638e33d23635332fa6d4ae9d751355f127.1758610789.git.mchehab+huawei@kernel.org>

On Tue, Sep 23, 2025 at 09:04:11AM +0200, Mauro Carvalho Chehab wrote:
> +        # UEFI N.17 Integer values
> +        g_pei.add_argument("-m", "--multiple-error", nargs="+",
> +                        help="Number of errors: 0: Single error, 1: Multiple errors, 2-65535: Error count if known")


While I'm merging this as is, I ask that you please address these
unreasonably long lines in this patch by a patch on top please.

-- 
MST


