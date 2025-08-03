Return-Path: <linux-kernel+bounces-754372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61497B19392
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 12:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC2F171E13
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 10:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0681256C76;
	Sun,  3 Aug 2025 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b="NDggLRkN"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497354774
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754218778; cv=none; b=pGeoMTsziOGbTpP5wWTDyCmersvrUJibwCeH1qK1SxuoPcAtFrfaF4XPycshQYXoY3dEgVAB/9TFcleXr2S5vPDWL4YCLeszhc94IiypvOW7c/053RTN3t2AF34AchcWkECLWysbp1oamJLfMpWFA1XVcGDEywH35BhcGG20ITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754218778; c=relaxed/simple;
	bh=8qGh5+VS2OHUxroiuOZuE0lXrzfIziOPyv+nXa3cCA8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=F2/wTHDqxIlgGtfmPrMYiryxqlE0uwoNE5fFF7a763q1IFtD+EcA9+yi8NMbf0ynBFS2Z58OX1oeU06WDpAA04XiAdtN2c9oLA0o/rK85TEFwHDe9x4WJW5poggFU9rwQg1HzGsAvdW+2z7lpz5IRmnX+Sf9cDiA1QR0B+n3Sgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com; spf=pass smtp.mailfrom=infinidat.com; dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b=NDggLRkN; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinidat.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70740598a9dso22180046d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat.com; s=google; t=1754218775; x=1754823575; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5d1Ty/OC9652uUgpaiAgn5uJnzmBBRdn461onxQuzqM=;
        b=NDggLRkNaP4Nkyj39GbroeQIhvNeZ4ufaua7q8ULizRpAYfbqq19ttnjYKaQNx5EWQ
         QCVb4jGmDjyelCBTaXcSlSqk8ZRmJCKuC89seays49brN02cO9H+qO8C0kMS8MGahtRA
         ftyOa4VRNZfB+dtHdjdv5/m8SXobQffc9/wGv7hMApNJONbLMqLwb38eLluVyho+6j/u
         0eqRb8fiCGdg9m7PimEKO9YLqNUFQ/0eWhLzuDdMv1oIUme4lEjq8duV0qF01VgJVLHq
         5eopvj4ZSQS59md0HbKTr30875TfyZfeN4oL9O+vtR8Y+sNgYMMNSDgFgI+YhpDdLUgT
         bP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754218775; x=1754823575;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5d1Ty/OC9652uUgpaiAgn5uJnzmBBRdn461onxQuzqM=;
        b=NsWSQm/UbPXYdDOFtsINQcJsOuTTYtEQZbsOxzomDzoZSwLPRKiEiLkmzhBaKR9ms0
         5FL29XZjP7/AzZgJq6+A6Wzx6ItRlUKbkRYBJbXjv/e4wXBuKTbY9eyErOBYBbPppBnN
         XtfVdQU6IegLvGvXCO3EvG5dXQTpH1IqlBWst4WO9VJlM5tZR+knAd+QQLgfQ9n45wCF
         vWabQfyGa5a7TekcGBWRCKj70ped8uk9Qn7lzhfij7KroF5cT+DEFhKoEM2NczjfpXAV
         vZbgBJIzndv948py14+Irh9xJEk5eoz4oOe7Mu77pQaz84nGPCvrVUe625U59jW4zkD0
         5e4g==
X-Gm-Message-State: AOJu0Yz+f4Dn/pGereuY9mY3L26VAgIZH+OxfXt0Cfaqyu7zUXGxafGM
	Q1HQteSSQ9b/CAkBZyiXr0ye97IZSBrCWIiTcb1Ohvrq2lquhiDo76ivpaqvugLjU5qnQU3S5X0
	t7n42fLPzVMhYbVMrihK5NurzPoHcHDxPDL1A+ChoRFggPHwmCqeBlaU=
X-Gm-Gg: ASbGncuPxXJOzUanBjxRV9d6pgYtr9cxVZILAMLFuHEqqF138WsIXmwi/qo1SMrentE
	KuiLozTNzB9D7GruzO3UT+XPaUfIgcbD/hfeccw07GuvHERIWKnNseBaqMduJz7ffRrXYRD0pw1
	rO0goZoJRmVGAcJUeQrh6bCOJkBXhz5ql07CtHJrGp8x/FpcAFYwt7wD6XuFhPSbYbkTjVp+C1O
	XLqMgDFpw==
X-Google-Smtp-Source: AGHT+IGt6W1C3etzatTk+DvHHR29hoZFX+9vcXrQgy+SxsY4eo3JROncv3wBlR+V1hQ2RnTpJXWmFgE4U3qVLSQKcgs=
X-Received: by 2002:ad4:5b8d:0:b0:707:75cb:60b4 with SMTP id
 6a1803df08f44-7093631987dmr77957396d6.41.1754218774911; Sun, 03 Aug 2025
 03:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Constantine Gavrilov <cgavrilov@infinidat.com>
Date: Sun, 3 Aug 2025 13:59:24 +0300
X-Gm-Features: Ac12FXzclI2ppn0KBABkur-RWnTOIL3Ys4pDILyGyuz5uO41_4IKbSmQPo8juL0
Message-ID: <CAEHaoC2BWe+0Ps2oU-0xPDLFYYKG-o9+_ynFgh7u3qqyRDtrTg@mail.gmail.com>
Subject: Large DMA alloc
To: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I have been working on a set of kernel changes to facilitate IOMMU registrations
of large memory regions. The context of this work is working with PCIe devices
that have very large PCIe memory BARs (multi-terabyte sizes are possible) from
user-space. Large memory registrations happen in this context when the PCIe
memory BARs are registered for access by other devices (like DMA engines), and
when the application memory buffers are registered for access by the
PCIe devices.
Working from user-space typically involves a single registration of large areas
(application buffers and memory BARs) to avoid run-time performance penalty of
dynamic small registrations per IO.

The full list of patches is provided below:

[PATCH 0/8] Large DMA alloc/skip 32-bit alloc if size > 32-bit
[PATCH 1/8] Large DMA alloc/extend alloc APIs to use alignment
[PATCH 2/8] Large DMA alloc/do not align allocations to size
[PATCH 3/8] Large DMA alloc/add busy_regions sysfs attribute
[PATCH 4/8] Large DMA alloc/add APIs to query available range
[PATCH 5/8] Large DMA alloc/remove max32_alloc_size field
[PATCH 6/8] Large DMA alloc/alloc DMA addresses from the top
[PATCH 7/8] Large DMA alloc/low address limit in alloc funcs
[PATCH 8/8] Large DMA alloc/add min_dma_addr to device struct

Entire work is available at the master branch of the git repository
git@github.com:cgavrilov/linux.git, with the purpose of sharing the code for a
possible kernel merge.

The following messages will provide individual patches.


-- 
----------------------------------------
Constantine Gavrilov
System Architect and Platform Engineer
Infinidat
----------------------------------------

