Return-Path: <linux-kernel+bounces-778109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA24B2E178
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD1C4E5D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9118320CC9;
	Wed, 20 Aug 2025 15:47:00 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90F320CCC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704820; cv=none; b=H2Nh1p58KiT50h6raXLKyg7tXKpBpCQQhsK/Qvh4Y9XIR9l6TaleVQgRm8V3dN5ksfu4sPObeSfMo1zn7x6Y8FNnQ11jrF2XlZUMeFiI7t10BsolaUejsWopQti4AROuTFziJXsdgz6oXP7Mr/Ugm9/91RgR4j0QoyEkZKhrTZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704820; c=relaxed/simple;
	bh=JTruldCoV4J+Ptr7PjIs0lu8HHUQJEhSB+j+XrhMtxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmMWZC4gZAmk8cmuYL8My1bML2MUM1irDxQzRftGf/KcaxwTs5QSzuFY6uoCUSOnZyN0y0qFr57MoV1HhYQ1m/zzlPMPLW+3Aqa0qg7ao33xgzpyk8VF+kUtDnsHs3WNoNrdit0CQ3W0niexTO2xo3ojAMW4bIdAnPYDy/2VmBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb73394b4so4239966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755704817; x=1756309617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+uYWrcMCXTgY9LDw0CpEJNd4/G4LXFK4CU2Fhr0lbU=;
        b=SaZoBSLKuZO/nN1EtZ4Mt+Cga+IN/1f+Yu3c9nPtW0pJG3YBR4h4VqH1HMT25IbSCA
         mona+EGaEhLNOqljm6HwosESq3ruasjZKAnFBaogyLVmVxjY7mf4MZQR3sCiI3ywub5Z
         pF/bIEAusdHfzzdlXlbCZDEQJA5wSVx/EGDsxiBvy0L/b4ZOdAUh8vKwnoNp3EmM2dFX
         5YJYBpRRIc+qzBbzW7i3mhoWcLh8xTlO7FRAuH2MACT+tRy1upZFmjFof9tlwyDzw8f3
         PVjC1d+ARu07i2wrOaKtSNyL7e/FUHrlKZlTA35vXjkGznpZulptX42y3on8S0mkp+Cj
         jA7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7wg+b1WYd0Q1n1FBnRab1UdZrT4s4pi6b1RgYh2i7mDcBkD6ZsPyKbvIkL0N/4wM5FIhf7+nl2lhLYso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3OzDOMjVBLNIKCKeYsaWPNVSkysEAvJf2quNVOWAJPh9BL8r6
	uDrpFqurAJDSj+Fj3vGFSu6a5pfQPsWxo49r8RHzB0P8/2KEHngqDNV7
X-Gm-Gg: ASbGncvdsHG+Qcn/xZyjLpDmdCl9qQ6mK5zPfm4hEY0ervwjqmGC4xEFNhN3WYPk6kG
	fsq57+Wsc31/Seq7fcySP8qXOy7foJh7EBRzojWdpNQ8SlPewzjUa2eXIJtKSkS/jRbbxueYX3l
	whsaK+AdLGLddqJtWG5jRagKR7AJtll6SqpJl14i8Yz60FuRocLN5z4QVlyfF8s61TwI4W/vRVZ
	9w1fh19/Z3Fzbb6c8lEDQ1s9EICdiE4SiXms92G9GDzZReRBvCw5dxAefXFUEKAixGnLyOzzK9U
	hMcIXQqd514IH+Bo54DXpV9CPcLET9zSaYlqwJkh/YsfjQ5OFBDSQOBWY2Xhpgxs4rXAvgeRHix
	aHhrg25eLxMQQcInx02HOrGI=
X-Google-Smtp-Source: AGHT+IGqDePInE+FdHH3PXlDYhmz7QfHMPnmOwbFEVlI4JdpGkqM0RyEB5qSwINorbSbzPMyVphfqA==
X-Received: by 2002:a17:907:6e89:b0:afa:1453:6630 with SMTP id a640c23a62f3a-afdf01a7a53mr314562666b.32.1755704816703;
        Wed, 20 Aug 2025 08:46:56 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2bad79sm199429866b.9.2025.08.20.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:46:56 -0700 (PDT)
Date: Wed, 20 Aug 2025 08:46:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Jiri Bohac <jbohac@suse.cz>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, akpm@linux-foundation.org, 
	Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>, 
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org, 
	David Hildenbrand <dhildenb@redhat.com>, Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
Message-ID: <airxp44zdyxskfwrhhveis7gd2vsz5m4f3ipidsghi2x55h64c@s37v5rkuoega>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEqnxxfLZMllMC8I@dwarf.suse.cz>

Hello Jiri,

On Thu, Jun 12, 2025 at 12:11:19PM +0200, Jiri Bohac wrote:
> The fifth patch enables the functionality for x86 as a proof of
> concept. There are just three things every arch needs to do:
> - call reserve_crashkernel_cma()
> - include the CMA-reserved ranges in the physical memory map
> - exclude the CMA-reserved ranges from the memory available
>   through /proc/vmcore by excluding them from the vmcoreinfo
>   PT_LOAD ranges.

First, thank you for making this change; it’s very helpful.
I haven’t come across anything regarding arm64 support. Is this on
anyone’s to-do list?

--breno

