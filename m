Return-Path: <linux-kernel+bounces-855812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0E1BE268F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AF73E0D57
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAA631815D;
	Thu, 16 Oct 2025 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dji1B5hC"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B083E3168FD
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607195; cv=none; b=Nz3DTUGIJFfJs85QGUTXMobZu2ujfZ5qBluOe5arhBuSSL3z3HcZcHxPeuDO3asfF+ZCwfuuoX5pJ/gAOoItGsoM3O54PKYxItYFZ7g7H/uehBuvDJ11Yph3mMuLmyNfaEWCMBKQU4oZw0UwVzXz/mSiOT11MmXHR3UMUFoyQYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607195; c=relaxed/simple;
	bh=x5XlyHp4qZ8YuHSOjiM2sfd2xNaQ4YQKX9ltLMZZgKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwUnZTaIr1vK93V0hoDgOVwgwv4bsf5KNHz3xTUUZHPTYrN5aGwMHa1vIH0vhEmzoL16LlwzyLmNp6JBqEsKfcssYKolPv646APbYnzid2bcon/xCIhxGl/kwvliylKQwm3TQZMHfeHN3HpBe6LMXPWfWo6Rj5ZFT0JfKXBfhlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dji1B5hC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3e9d633b78so119516366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760607192; x=1761211992; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHMRuj/15syb74fDu1791nFi8BMeOt6zd/hpHr/6Rq4=;
        b=Dji1B5hCdBleYoLUDKwVdZzPkc7HtOlggGUA/ycNXmFd0RrpnCpA2gPXoU4zSpthbV
         bPHMmtBdzQKfUqIYfxBqAd6WKHOEyQq/CmB4sYykmemG8UDJlwdKKnOhKcd6Lvp9UMdb
         Dxu9YhcjWDpdFceUD95C82T88y2DwJj4cYDkSCECGYwwAjRPZ8LUlKJl7D85sOVoUUGu
         MhkFhO7vQFviKhn32MfBXRf57U0KzBsDvVSONUt1wyvtU6X8WORLqf7eTGvhTUMpk8fx
         oT5EFG8A0nXaLD9gaingrv/iquqZ6sz8rkr6u5HpWFOm8IWKoe8X+mSzxzYjXrYDPa4r
         VLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760607192; x=1761211992;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pHMRuj/15syb74fDu1791nFi8BMeOt6zd/hpHr/6Rq4=;
        b=UmkfGc9jis1Yx9Cxi7sGXjXOvXhkiH8tjDLbzQ1RojSaIqVYnC4dKYYdfYSYX7EWxH
         iHWudUKV9F3CVOJtP7/z8kpt5UsBomQmN9ePCIbqK/Si+WhXZJrB2E/Mye41X2iTPI54
         T5LANXo7WL36qDRoNHJhS9FyoLkUQt/Zt4qMWHLDAIvFQ8wB1+GqpzSTaHeuNZFWSnRw
         3Z/QRe9yr/wGafaMO91jEyWY6NI1IHz8VhpCUalqUXuWAnlsPzlMThL+GvdV+m1B9v0u
         bbuwhTckz19DUEGRhHGSP45t3dR4gnvyhO8SXBKW2pZA+WwVm1TTbNFiHFSfWw9NacaY
         YiBg==
X-Forwarded-Encrypted: i=1; AJvYcCWcb+pvPndiTJ0bDBCgWnhOPdb+n/vKs/lSzGFFdk9C+KzBffXiEW/GBO1c2Kj1ooV0a5dinkmGE+RxelQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaEsHbzy3+Jb5EJt0p/jfQnm00qmHU66sN+VVPZSk7y+XvSpwE
	rZ9jEPC7T8Vm3oifjPeNRsTtkZLMxDp9V1sMjCqlsV/spzdnOwJp1MwI
X-Gm-Gg: ASbGncsUyXAD05I8gjH6DL/CwvuMRroifg2FeNGR+rwSvANSy1fS+/XTJIaiEaNGRVf
	g/SHTIS+kVovf8vP0SlcGTaIN24mwtjtAnxhGw0ntHQCGCQ7cyiooDBppNZPF/OW5Mv5O0WHo68
	XkMHYa4gYI0AW1y4lq/WW2AJeRC/aB0qqfrGGM0pb1zWG6tDfXgbWgggmnbER9JRkDDuFKeyh1l
	PA70LkiUWirXrBYADvjRm8I/nP/MF3MDn1iQitXXj1k79OYUPney0BDwrGy/fJczuwxODQupLgu
	G5G44roKk+V0bH/BOWEURsHsIVwib25p4oAXRbxSBtM2OBVW1je0zlaJruA6mwoVBmmcm+fByf2
	jPDubxpaZRdjCOF2UbUdeHZsVYAE2vyVWWNxuD6xgXyOdlGVERMMGOVJTQfDGmstenEdtb3J8Qk
	wj9Mb7SQ53wQ==
X-Google-Smtp-Source: AGHT+IEYm86dPzeRxAUlI721i6XxvlHj7KPkjjQbYDNxh+Ekxpv1GeqtK7/vX/7AtTiWdLiudoge7g==
X-Received: by 2002:a17:907:c718:b0:b53:f93f:bf59 with SMTP id a640c23a62f3a-b60552bdca5mr370747366b.29.1760607191779;
        Thu, 16 Oct 2025 02:33:11 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cb965dde9sm475741266b.4.2025.10.16.02.33.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Oct 2025 02:33:11 -0700 (PDT)
Date: Thu, 16 Oct 2025 09:33:10 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: guard is_zero_pfn() calls with
 pte_present()
Message-ID: <20251016093310.rilvenglgnr65ojq@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251016033643.10848-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016033643.10848-1-lance.yang@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Oct 16, 2025 at 11:36:43AM +0800, Lance Yang wrote:
>From: Lance Yang <lance.yang@linux.dev>
>
>A non-present entry, like a swap PTE, contains completely different data
>(swap type and offset). pte_pfn() doesn't know this, so if we feed it a
>non-present entry, it will spit out a junk PFN.
>
>What if that junk PFN happens to match the zeropage's PFN by sheer
>chance? While really unlikely, this would be really bad if it did.
>
>So, let's fix this potential bug by ensuring all calls to is_zero_pfn()
>in khugepaged.c are properly guarded by a pte_present() check.
>

Does it more like to guard pte_pfn() with pte_present()?

-- 
Wei Yang
Help you, Help me

