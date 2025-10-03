Return-Path: <linux-kernel+bounces-841464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C9BBB7651
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 17:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6E93B47C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41908286409;
	Fri,  3 Oct 2025 15:51:55 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA5D13AD05
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506714; cv=none; b=UKkpvF3pXa+4ZT5FnYzhEEoUksyoC4Opc3mrkDE5BsKNIrQoTI4X8uGFq/F6phI5hRnXiEJdxpZY8kagwmVTK5S1rxKS56jFl2AMb61wFRXDdLr6rQpIMZKQ6A2aqYEZ2pq13vIUhsqLorKUaBYs+z/FDnahK3nMPc49SLGp744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506714; c=relaxed/simple;
	bh=dxjhxSBanEjcS6nFKordX0fU2ntdIOAb/pU9S6rprtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGQdGWlVcxaTCDPUBL+CKnsnzoj5uyVSdpMBpfk87mYxnakNt1USEeZiJSb15X/CXI2cyj32p7STDgELwRFMx8y7Y+kz5pql5ld1SyyejDFA3MuWj3ruVV/55JjJLlu7QRfWn7dwMTBsKEoAgGHTZtFgtWATIQiklvA4sb6ZKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so442442066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 08:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759506711; x=1760111511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxjhxSBanEjcS6nFKordX0fU2ntdIOAb/pU9S6rprtc=;
        b=oe+eJvRV9g7iVKkNxtgK+IeDs1YEBNP9jlMGkvhHf9+j84IlnLrVu56LUwbRn2OuwX
         m0nrzoR5LB01bTo1CZJH7NLNL1B9EMzfgEPCIYcuFRSnhy76hRJgz2TTJB0qRSFL9p4b
         8+AVuDXLmpqptLeJMGC+qe2CVPlnRvpqrJRh37Mni4KQvLE5h4fDTPzqM9Rpk7TzNmkB
         F1fzpEWIWG4Knp3DOthFJ89CII/+cD+POsQOvtFQDUYT1nNUH0+FFOQChFbVUJ5YeOdb
         zRmz7oFoh9VLtAbyN2tcLN73P2NRWCarwgx7FDz0qS//7z5WzLrgUMnLijooxerYIfin
         +IgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbjFA/q2DXmalKGef1q08fFfqOjf/YQksAqQ9JBpoDn1mN0mcgzQKAO+Ym+X1+p02kJgRKPMtnHE64/ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw337zZuSPX05tSQQl4CBF6DWGUpg+ltt2hRWQ1iE1kTXfXS/HA
	yTLd8rvtGaeFUZsOWUV+HJushZNdGiIxIu0FIIpreOfhumYxh9xl9M/g
X-Gm-Gg: ASbGncs2H94YQ17P3Mr7Z5D86HG2pNacEPw/nFxBCcteXpLZyWLujizwOuUYRpJg8zW
	UmmSSsa4fLUsovmNNBorpThypDpj5Ccq9akKQNYX0t4tRbXhb5T5dW2jesJgLca/pPy6XW2OuMi
	FhzmNZBTAVZXA5SCnWPECWoQ7k2KTGeoqLhSMYm3fqXghejLHFZ+CzFsH+K7k9cTTdEZa2L8p82
	bV3VDBLQ0VMDcYE2MT54sya7q13oGJDCveY1k03h/HNXLrz2rSabjnHhpfdYZbRWEuPQoyahlop
	RFKrpOp89bPGK4Q9ZZwvrCSBf1iHpDFHpMk5OinJ9ca7HQGM4nIHqwed1T3DxFeg/eGfDKdNv1c
	TWVHoSO3k78Yd3qHxFQLv3dNKFAS5pPvL8EWyZBUM1H1Fwos=
X-Google-Smtp-Source: AGHT+IEAAFtAVWxH3Q7eTKnhQH5+J3Vh/LAGNAUrm/EAT4l6g5ZdiMiOqAiVz2iXzCYcbw7ulviPKQ==
X-Received: by 2002:a17:907:cd0e:b0:b30:ea06:af06 with SMTP id a640c23a62f3a-b49c1f53946mr378075566b.24.1759506711073;
        Fri, 03 Oct 2025 08:51:51 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9f50sm461408666b.9.2025.10.03.08.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:51:50 -0700 (PDT)
Date: Fri, 3 Oct 2025 08:51:47 -0700
From: Breno Leitao <leitao@debian.org>
To: Jiri Bohac <jbohac@suse.cz>
Cc: riel@surriel.com, vbabka@suse.cz, nphamcs@gmail.com, 
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	kexec@lists.infradead.org, akpm@linux-foundation.org, Philipp Rudo <prudo@redhat.com>, 
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>, 
	linux-kernel@vger.kernel.org, David Hildenbrand <dhildenb@redhat.com>, 
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
Message-ID: <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
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

> Currently this is only the case for memory ballooning and zswap. Such movable
> memory will be missing from the vmcore. User data is typically not dumped by
> makedumpfile.

For zswap and zsmalloc pages, I'm wondering whether these pages will be missing
from the vmcore, or if there's a possibility they might be present but
corrupted—especially since they could reside in the CMA region, which may be
overwritten by the kdump environment.

My main question is: Do we need to explicitly teach makedumpfile to ignore the
CMA area in the vmcore, since it is already being overwritten and thus
unreliable? Or does makedumpfile already have mechanisms in place to
automatically ignore these special zswap/zsmalloc pages that may have been
overwritten if they were located in the CMA region?

