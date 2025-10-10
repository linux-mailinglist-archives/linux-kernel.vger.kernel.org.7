Return-Path: <linux-kernel+bounces-847640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A886BBCB536
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 504C74ED402
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD3220013A;
	Fri, 10 Oct 2025 01:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im8wzDSk"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2FF19E97B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059110; cv=none; b=Q96p2QEYUNeUplKie/xEhFXgctvXEvbnO6Mag2h4bHuiah1HbThdVFfTvcP+vl5BkvFgBECHNj3Dgj+FBep9agM4y1z9o3uyDFP/WzS5tuRUC8cnL2maChCGhj4JDIDc6WE7UPoKPPRexm3cjBOTcI9Sa17W6zwSZBscF+OEqdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059110; c=relaxed/simple;
	bh=dz7U3Xlz9VpD0eCDezRr9jzjFI/meWpiQJM8lO9zSvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUu0xYq2fY3LBIAz5f/UKckVPLIVg3+ec4SstKZq8OvdM0/FepGjpY+MqcZCe5vloiwq1ZRnLcYYmXbWYnfL2CNJJrywQLg1WvT4Ck7CBUkzggROnwM+zWDM4xhjAZO5LIrEMq8Ot0uFShB6G7kGu8hiC+Tu4MVe/hahGIE+d+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im8wzDSk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b40f11a1027so275265766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 18:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760059107; x=1760663907; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuuNyQUeQERuEHORqqgvkbAzAvdv3OChPVUcQyJiiVo=;
        b=Im8wzDSkVa9TviVYdV4SIpDbXfOQQKmslaFxdU7KBD0Nn8nsfKela+0pC60mO1FtRr
         xB3+fNFXTOACqk/MZesYqQWaIIJOa7vOd6gGPeWErwcICeJcJDT/jZ9Ho9vazZ0xN9im
         V/cqcgtd3P7JDgDkwuLsJHu3UFAK8OXsVimvJlvIfkP2ZKzoz08CMGcpdis4Us/OEy6b
         ZqFQjTeyF8BEsEuk79oUwpupFME2cCvI9rfpzXR9crNYhtU2s0vfK6W+tLIOivwE6dkm
         6NiueKF1eSqJB0v/jmfolXL5pIyCXk1VoEViXPGdnYb5WDWvFh6ayJKQTElJ/foTp30F
         fzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760059107; x=1760663907;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HuuNyQUeQERuEHORqqgvkbAzAvdv3OChPVUcQyJiiVo=;
        b=bHcSijTpot3lrZpmkKGoCqKitSw7s4BiQkhI9XX8Y10gaYRz5ilsdTsnHzoKsAhRQJ
         Y/awcviXm04j6nYdE83iMrCrY/IoNU9E303oALEjQDYTg57O6VuEsnDXqffuYk2shwmv
         VA9ZNrGwA9P57iQKeCsVgbuKEQpXePObuMpZFwa7q58YYZjwiRfWmsznpmnjv2Z7Gu5g
         3OkrNcdN0ZYrL/taiZbX5vgcFw2j2BRTV5bmJculIEfRBiF2LSYV/5djN3YkaHz2dw6v
         fYfROA1H7rwtAnx+ejqFXEbFrp+ORF8BIuayS9YXw4ecIVPk8Snq7yg4+3jA8b7ZkJ2A
         jB8w==
X-Forwarded-Encrypted: i=1; AJvYcCXZhJB0jP6c6CqRYKX1y1zJX1tw3OiA0wsBiyA07+a8qrPdBDnfphf8ansOIxHVEf72r5FL17FfxUrKm9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLPxyf1PZ1H2j4i1zC4P52e4a84R+tipHc2XtLw2iGqrFTJw1a
	Hwpj4vA8nAVkc/SfgECwh2zGAIA/n/4xPs8R3DiS/hzNIeBF8i+u/HpV
X-Gm-Gg: ASbGnctCuGDNtD5lGCh/emUQ78sp++XF1wtRxebOKslOR+IpIwuR7NWBUs5p2nMmYZr
	+GGY7lZHzNQtGTN2YzL6j1J87O1VqcmTM6XHmcrMaQ0XVSkLU6iNEUmLf2+aYvMQUqfJMlo2g5M
	fKVx71Ej40GVsdI8ghPnMykoKHI8krh3pQY+G65HnOwl85QAZN+RkG6gYQaWDzCD8QqvbnwrJUg
	websF+qGTRCYfNMp/PRJl3VWEqLELE3OrkE9OUTEJiZhbPF4MGImEGW4c+vQr3mQJKaKnGtqyWo
	vNcOjl+6mwB81o3OLefPL6zTiZUAtXniBU9V5mbb3EqaiC+LBa4Nhb45o1BCYhvDl+49UHMeB0V
	e7Pwtm0fnkQeBUzaOIGVwgybkV/3EfHdoAM+gSOKTQBe5yA==
X-Google-Smtp-Source: AGHT+IHWcmsznp9PDr/fojGUBUEOr4Rw6hfIt6/AHC2pNuXs/i+8fxKhoUZc0yew5l7JtAhQWD9juw==
X-Received: by 2002:a17:906:b118:b0:b54:981c:4072 with SMTP id a640c23a62f3a-b54981c4627mr476068166b.11.1760059107197;
        Thu, 09 Oct 2025 18:18:27 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d971ec69sm97255066b.85.2025.10.09.18.18.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Oct 2025 18:18:26 -0700 (PDT)
Date: Fri, 10 Oct 2025 01:18:26 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Replace READ_ONCE() with standard page table
 accessors
Message-ID: <20251010011826.4wv6sb4z3sedpabu@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251007063100.2396936-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007063100.2396936-1-anshuman.khandual@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Oct 07, 2025 at 07:31:00AM +0100, Anshuman Khandual wrote:
>Replace all READ_ONCE() with a standard page table accessors i.e pxdp_get()
>that defaults into READ_ONCE() in cases where platform does not override.
>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: David Hildenbrand <david@redhat.com>
>Cc: linux-mm@kvack.org
>Cc: linux-kernel@vger.kernel.org
>Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

