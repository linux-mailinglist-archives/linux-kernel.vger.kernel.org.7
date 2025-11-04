Return-Path: <linux-kernel+bounces-884425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A9BC301CC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DAE8C347F9B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63148260588;
	Tue,  4 Nov 2025 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HqGZde9F"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8F86323
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246781; cv=none; b=Klc+AdacNovCu5W1bCgeNrW8n+/NB9HKmGN/pk3R0IA7ZTO2vJ2bVxSxzryca2VdwfxH0tKLzCvH07L0yA+HU943625X3GJSi21aToKE7rIAAEcY/0NzmIh8hzdDWrFMBbU/6GaJYwPGAGAuIs1rf/d/G4qLeDP3ZpZ3slsBe9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246781; c=relaxed/simple;
	bh=UxkusRXVNJvyT+UehTNAwsc2HHL0Trxxus4bsQMBt+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCmDXpYGENNlHBY8czyKJlwCIJKKYrRa3bq1EDV3Z8Eg40nLfMbErm3tu53mGBv05ScdMA5+L80ztzXEmdJXCaall8l8Tv4tymGvMMk7MFj3ZpLH0+BE9DiIFqOx0VgoWW6QINg5Kwj1QsDWpUJT6/qblAM/zXtQvKD7P7AoE3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HqGZde9F; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59390875930so6233649e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762246778; x=1762851578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxkusRXVNJvyT+UehTNAwsc2HHL0Trxxus4bsQMBt+0=;
        b=HqGZde9Fy1PaHcjpeu5QteVadx83rr7KV16SytqVy4mj5i4H06Nw8LLU8zpLhJ7CX/
         M8l/JOAYsaRgThJA+rVCTTeVEB0y76KeCX0xqQ8OK0o61eWkC9uaIvrtcxQdhVOOB30b
         JtHEpkTX+u62KM9DiB1DgOy2E0GZmORn31/GQDWj3ytwcBaahV/k2a+XJvCJC6pRtU3P
         v5mO/WcszmRMAE9MAAJIhLaSPH9N3vsacG9T2wAJTdYil7Ujn4dU5KV63z0+QFcXuItQ
         8iTYdh07aVQdcxDqLzhjVnsfw6C6KS1gTQRXKKSLRXBj6eBkrlhU6r3JIbJjWCO9Tcp6
         wp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762246778; x=1762851578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxkusRXVNJvyT+UehTNAwsc2HHL0Trxxus4bsQMBt+0=;
        b=q0ySRBBRz0WSRPt98uJPLrlaEEL6BWHpS7kCXoppTu8LpyGGQq5hOo59D6jTJlaNTO
         VUdw8+369gRKLv7b3t8DUZrhgrzZUvoyMJcB0C/lTisefJrqlFoX46R3TfjP2P3xQdu7
         i0mhXHOSN0rYxVml52zdONdUOC5WmjZK58/j0aoElxCZafgkLRmtsJuF4QYJ7lv7dNAZ
         INasHxlhpmF20c8veJnBvY0N554JUIHlI0R8I+Yfs8jOACOAFfrJTMZDOa+QELlgWxWZ
         sJBWQhUL5fZo0SNgyPKd1HGcGIBn4MHNHz6gTmbkkxRrt2gaCLgeu2Qlhq1k/xnxDi6d
         XbeA==
X-Gm-Message-State: AOJu0YwbYEVwXsSZgGxYxooNUO3q+q1QnsGNdQfshv7hZGJWwBhSiydY
	O0tetPgmw2PO2nY7ct7XxW0A/uvLUoG7A6TAFPdQ+fg5QrN7AehXiSmlNFcb4cFIq2ZGlyzcnf6
	gNxqmYCghsqGHdDDJOaYiQYAi79p9c49d+3yUoEd66w==
X-Gm-Gg: ASbGncuYqThivAvQsiHpsdEnaKqC1sK5fH6OAbPIhr/z9cZUqeemfYRwLNoYvIR4mWm
	TBvH4riYPkf+LMmz59kJ4SIVwRFaTXRjsW8UsHAIbnOHsvVkDIA3C1gX+1furEJ1/zBsMlTHuSc
	FT6LzYYV77FxQKYqT1VTh4sHX/76hdxlJ5czZgG7jZynOYJSxKCq+gAvjr/m7NXLPm+B9n3FV15
	I37e9u7V84vTtjRhLoS8FMw5F/qihZeYWjJm1v/TqC3apOLHBqKmg2neHXEifS7XuWFDteFFlF2
	GyxeROI+WU0ze5GbyQ==
X-Google-Smtp-Source: AGHT+IGjk1SAjYkuiQ7qycG+PgZZ5SAGtlLaKEvEytUgoQ6BsXQzZeq96mRxtvmS863uKW1GFE6sCVKI432dNQaI1ks=
X-Received: by 2002:a05:6512:3c92:b0:594:1957:a36b with SMTP id
 2adb3069b0e04-5941d50ced0mr5077478e87.2.1762246777907; Tue, 04 Nov 2025
 00:59:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030163839.307752-1-marco.crivellari@suse.com> <ce2f5f34-8855-41eb-9f4e-6bdaaaae90b4@intel.com>
In-Reply-To: <ce2f5f34-8855-41eb-9f4e-6bdaaaae90b4@intel.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 4 Nov 2025 09:59:26 +0100
X-Gm-Features: AWmQ_bkwe7q6tEVvGqave46mFQeHk4xgGvAOwza9vHqA3CoFvmblPyoEwhYxTeo
Message-ID: <CAAofZF6fhO=9WaUYdOEEmbKe+kSw8Ycky+kWf-FikwbHuC0ysw@mail.gmail.com>
Subject: Re: [PATCH] cxl/pci: replace use of system_wq with system_percpu_wq
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 12:44=E2=80=AFAM Dave Jiang <dave.jiang@intel.com> w=
rote:
>[...]
> Applied to cxl/next
> 952e9057e66c17a9718232664368ffdaca468f93

Many thanks Dave!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

