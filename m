Return-Path: <linux-kernel+bounces-835130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DDFBA656F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43B2189AF71
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 01:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70919244677;
	Sun, 28 Sep 2025 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIVwkNXb"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AB81B4F08
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759023168; cv=none; b=EdVLdcCUqiBt5wm5ljDg4AzOw0NnXHN6DVQGDlYvEb2g2SvzLHPy+oaJoZeQzPaUxX9uA8O9axhcYbd+XxppS4WeBHgB/27WCi/M+07t0deE26sVXqBjikzGi2+4yg8SJnBMlfYhQLzh5y0qEYmwXD8MyuFde8wD6wH6pK4bgWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759023168; c=relaxed/simple;
	bh=J2TTnFGHwlZXfKtZqoNE+8YvNpdccY0n6u/tPimgIPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubSpMlMzD3KOnhnLDLVDOsLKCZuinkeEmgbZNNGEV3y/G1j/1jZQBsrrc/g+/p7ZhGuK34lcyIs9Eo/vNEViwtzeDROPLpyoyHMtIdV926pgqlT/eMarZThCWxudNIefzt4WjNJhQoFRrUEDlYCOW5FKzGM5eZC/AZ6IxhDRJhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIVwkNXb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3b27b50090so119763066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 18:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759023165; x=1759627965; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNO5RZIiIrulzG4VB12ipNMyH0eEypFH/dltlbXSWN4=;
        b=OIVwkNXbBFRfDcopoRnoNN7ztwYnMnxytg8HeGB8XeAnabwQCKrYWPFdwWmKs6l/HS
         RUP+jZd/p1G3CczUFsosoY49SWX0R19mxu1rZH+FzGGF8v6FJe4u8MpCEPzU2mwVBfcw
         fqfIsKpzTCoVKsvJ2odb4WH47m17k8EFWH65+Ehya06EO19N768395zyNV8VXL/8BaDQ
         duoroMnYG11GjDJ99ehXNlfhoZEVKHasO3CYjXFOgwZVjkyqgWU1ooP942ePxobb54+1
         nkCNTsl2GFFcexXKu1wh/pywVZb/PXetGuDnNDK+21Cd1cNScFuDuYqDqqqE8VYBp2Se
         Cttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759023165; x=1759627965;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BNO5RZIiIrulzG4VB12ipNMyH0eEypFH/dltlbXSWN4=;
        b=UDVR0I4u9LR4UIDpv6xUPA+UQpfv2sH5CHN5mbRsYUvXHA82ha+svwnCEmbfIoObUA
         CzbZco2GAHVBnjIr8xtnuJTDeO/waVfkun7qkz7l5mxKnCtszpqXaM0Kezb0m/to0DYL
         yNnl+hqvUVeOkLC7ynR6Ixz1R9iuioTtM+gwAO0kViVeaT3Mcy2G7JN2hHagcsbAceG3
         L7oLvt7Jy4E9/BHPRQZoa5pz8CfziinfLSOR5C8HTSdLnyfQ0K87P3gYXa0pi/geEf8j
         KT/Wf/Yb89Xv7QMcorkg0yvTotSk1s6XSCXrwgxjVGiMZayeSSaPghtF2b+tcop6wGjO
         5HWw==
X-Forwarded-Encrypted: i=1; AJvYcCWP9ni5MsX+YfxFs3otuqdcLnfallfA0UN8L6uRxEOIZoIKITuFc4OeHG3WT7/zp8ypG8RdvQGTDKjYEPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySe4y3aTA8UZQ/iKgoJvWqsaZmB5ipr1iywQ2LT5w389Xtxh4A
	2KTSAa91EfuzbDCf4Vjae8rZFzbxjCy4XsDt1TTd66uaic1aUZvXsINd
X-Gm-Gg: ASbGncsRRY2qeyK40dv+QaTAnz9sbSx2LHKwBhtv90d2wg/C2jlOuptnlkzbHncn0Ht
	WTp8mAlPn10YfSdkcY3iEkZH8vr2Wnus9nXlpdG5VYtKqMzLgZ8IiMGZzGAtRoVjQ5WLo37MKH/
	8d1o81otEBQaqYYAiu/G2WAY3HEHIrBq4PTkJ/dmHX0DXJusApgezt2cn2BTbEyrelKaHBA3BaP
	c8o3yxWeEDFvNmXYh0lSFqs2vzFtpHrn0v8m4srmGrtbRzTWhiseaEIXW/vJ59PTgS/+xJNIl/4
	8FRvo93OwU/WQ/+GZ+H+kkNAUCl43N6F2zwnH5dsJtLcW/JuWIJqPUiggjLg5WfI5MuGjl7EKSM
	Cl4rc7b7yotzeFB9Jen8lHtRwQA==
X-Google-Smtp-Source: AGHT+IF+0HY03khXHDHlsMivMc7NYqE4StkORboEozoeR1pyX7fRDWSjBmKKhZE6NSjOa1T9ZS12Sg==
X-Received: by 2002:a17:907:3f10:b0:b10:4355:2e63 with SMTP id a640c23a62f3a-b34bc67ad82mr1406794766b.46.1759023165482;
        Sat, 27 Sep 2025 18:32:45 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f5c36sm657584166b.54.2025.09.27.18.32.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Sep 2025 18:32:45 -0700 (PDT)
Date: Sun, 28 Sep 2025 01:32:44 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "jianyun.gao" <jianyungao89@gmail.com>
Cc: linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hugetlb: Fix some typos in hugetlb module
Message-ID: <20250928013244.qzevjut7gbxdbyli@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250927064926.1496579-1-jianyungao89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927064926.1496579-1-jianyungao89@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Sep 27, 2025 at 02:49:26PM +0800, jianyun.gao wrote:
>There are som typos in the code comments as follows:
>
>  differenciate ==> differentiate
>  refernece ==> reference
>  permissons ==> permissions
>  indepdenent ==> independent
>  Spliting ==> Splitting
>
>Just fix it.
>
>Signed-off-by: jianyun.gao <jianyungao89@gmail.com>

The change looks good.

But maybe we can merge it with the next one you sent? They both belongs to mm.

-- 
Wei Yang
Help you, Help me

