Return-Path: <linux-kernel+bounces-862001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DF9BF438C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B7B44EEDA2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D070F214807;
	Tue, 21 Oct 2025 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K10jsOlW"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E214086347
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761008780; cv=none; b=NeUPY96XUxMrW3i0vLIKvLxTbO5UGlc+64X+zQ3jBF7dOJ45RcBsFcSAwl8k9IRMT3SGYmzq0xuPp4sh8vKGk8WOgpAGkAPhkwAXgvO32WPby5SVIOo2917KHCVwTAkHeelRK3+Cjpsh18+B5eTAYEonDu9iomqb4MNJkDvhW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761008780; c=relaxed/simple;
	bh=xUuHHljOFEdYCvkkVUcG2yNKYjdPagL7eq358zZ15x4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RW1CYDxlroskKmlG8El0PoyORBhaqiCQyvLbwIYmVbjuS6MvMswkfcGXf6cKcRXy26T9bPHpNFF67DcM6lhamUhIUzK0r29rCJ85eFUDzr1kxGMY31fP5Wad1XL0wvdEPAdkQquWFvD5bDpoXwpfVW4mzXEXFt4BXsvJa5HWNEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K10jsOlW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781001e3846so4614584b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761008778; x=1761613578; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+63y6nXBzztYrhoSW6YELYnT99ah/4Fb8gojWvD1Sa8=;
        b=K10jsOlWY7XRHq2Ed/vHvjparvIAlgN1kmlb/p8NO8WFbJ3W9a94zrbAOHXHlOTWzq
         8JfkB/v2vuOlj6GgIcp9ZaZsibfnalLH17k7u/DPvV2KOv9QNtSJrFCxeMIZXEFLeoQB
         +tbdANtxgbyk6OENqOd9maCgKHUokfjmHLiX/sQfgbVNyn/C8nEMtlQ7IudRny+ILtlj
         ANaZYDS9RLRpeudAwXEjePaFcM8cAiMOPrMxI/deqaoQgz9S9sOAR3orxmutwWHbyYvm
         w1qUs9sijBptGa/25o5DR6hgtXM9hN8elU5i3IBcxDwP8WNeWDxzJfWv7cNbJbMHgFua
         jJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761008778; x=1761613578;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+63y6nXBzztYrhoSW6YELYnT99ah/4Fb8gojWvD1Sa8=;
        b=BW7kZfK3yuNQ0C0owN3omea1pdgc0lbB+LQfonOOac0zLhVrGxDV+AG4Gbq/ow5xh0
         hL0E+cPVYIjj5b9Kx4taKvUdMqUvjZcFWHc/313KC8RWMfhvkCrjKydTyWhuQDlU0q6S
         0Zpj4yXbGgBJYX0lLXidZU9LeuPL53m79M4NZ00dpxR6YrngByo9UchyAfnsVLx/nhUJ
         RCYRtkjtpjbew/d/u/gDJOd6jbojuWAm6vU7AfkZxoEWsRjgymjUx+IoGcYiaqdpH87K
         cDXAebgQcyLvbeOZGRFQCnxK5l+uk5N86fRdpmTsMk4D07EcTj8uurBMgckUKAiNXrb8
         7SzA==
X-Gm-Message-State: AOJu0YxpX/KE7xmEtNba8Ajw2umB+MusRJtcRVEfS5C8UPZCNChgM2vw
	fkxPuOxP88ZNZs2jcerkiEES76ZVNejQ6XhARdleiC9rufeW8EsP4SVn
X-Gm-Gg: ASbGnctcWWJi9G4fVtopMlTxDiNZiPlDR6flB+o9PseKMDbVy7MEJP48Isc+fe7J+V2
	/5micvSNvicjTyWVawV5ZbrAvgHrc3tXzuCrJ40rC7/GBSBOQjWwFnMs9KaaWIgMEONEJfFIiH0
	X65R9l3V6rcPyDnx8+Dcz6+VddbVHYubOTM0xpt1ZGoe0r9RHlu5tmUc8xhjYTPLY6Qt/lnM84F
	ZaakhLDjmp67saNJZbDIwCxqFt6yLMRUWwOV4Gtz+z+azFTgR4G5AZYe6vSqB4lTAH6Ln1r6PJo
	4PsbIeFtoAPFHUtHjcp/urdJSTW0uE12szgRv4RFISEbyatd2YccnrQuP/CjvY/RoqZKU3k9x7a
	gaDhCmvrdYBFZibUrxH++hroqYjaBSH31ncEfm1W5Slv7seLqNicckBmRyOfEABvy4Ru294vL8y
	U5oHMbhJC3K2NUhkyvR7GRs8ujcw==
X-Google-Smtp-Source: AGHT+IFHp3nJbq1iBMXBd1/3CdZaGtu/ESeFDqoXznrwJB5IngEJkzQth+ImAUyhapBjqU5QVG7c1A==
X-Received: by 2002:a17:902:eccb:b0:28e:80d7:662d with SMTP id d9443c01a7336-290cbb483demr195431325ad.58.1761008778137;
        Mon, 20 Oct 2025 18:06:18 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:badb:b2de:62b2:f20c? ([2620:10d:c090:500::4:1637])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebd215sm93327565ad.14.2025.10.20.18.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 18:06:17 -0700 (PDT)
Message-ID: <76e2860403e1bed66f76688132ffe71316f28445.camel@gmail.com>
Subject: Re: [RFC PATCH v2 1/5] btf: search local BTF before base BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song
 Liu	 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Date: Mon, 20 Oct 2025 18:06:16 -0700
In-Reply-To: <20251020093941.548058-2-dolinux.peng@gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
	 <20251020093941.548058-2-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> Change btf_find_by_name_kind() to search the local BTF first,
> then fall back to the base BTF. This can skip traversing the large
> vmlinux BTF when the target type resides in a kernel module's BTF,
> thereby significantly improving lookup performance.
>=20
> In a test searching for the btf_type of function ext2_new_inode
> located in the ext2 kernel module:
>=20
> Before: 408631 ns
> After:     499 ns
>=20
> Performance improvement: ~819x faster

[...]

> ---

The flip makes sense, but are we sure that there are no implicit
expectations to return base type in case of a name conflict?

E.g. kernel/bpf/btf.c:btf_parse_struct_metas() takes a pointer to
`btf` instance and looks for types in alloc_obj_fields array by name
(e.g. "bpf_spin_lock"). This will get confused if module declares a
type with the same name. Probably not a problem in this particular
case, but did you inspect other uses?

