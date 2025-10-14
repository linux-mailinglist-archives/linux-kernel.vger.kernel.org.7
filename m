Return-Path: <linux-kernel+bounces-852442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E896BD8FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB1C3A7F23
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0169330C341;
	Tue, 14 Oct 2025 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxsuC7im"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D414B27F01E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441155; cv=none; b=HkqjuUOa7NKKN2pYULFllfD3i9qNUXZh6iuDcJA1uvVg/uVHk6J9uhaGh0FlBafkkwbLGonZ8qeb/gUuAKDaIQGK9tgRAFplstZ7MM2yKnCwCOvBJtogmMds+6N+IppeptU9oTa674bZCyyhkr40/bPhn3/DGLzTTOY8K0LgfKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441155; c=relaxed/simple;
	bh=XVuiIrau97qjpcYS/102JQpRxXMYJ1qlunE5ky/iKeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBd7GjMJTtmFmUPgydKu3IqhcLFF7aNlZZfANEWh1iIJHWui0v8+XQlpWBq8yoLZiH2kYDo9PMYtlYhVMXRU0+sRPLruy5Wf8MLHOfFRHewQNXryLFVe0lmTgap9z3+0/55bXwP0IwblaZb+pGdUTysMdVp9UAXF9cZ9EJ4dROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxsuC7im; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-743ba48eb71so79730477b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441153; x=1761045953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XVuiIrau97qjpcYS/102JQpRxXMYJ1qlunE5ky/iKeQ=;
        b=XxsuC7imI7JmUX7Vosr5jwcuY6/+u4mxAhtuaxzCHTVVXoazqthl+SmfE10RgcWVSi
         Boztsqt4ZG40TNGLGHTZ6UTBTOkLOnaMPqHtFDBBkczhi5HSnxkcJwF0BBzYb2z3V7dL
         7NFKTYeeEHP79Vx3cMrC0YdpO7brJgLVBhp9pDSNv2bKQGG0UxbnMW0jGF+Neok8nHP8
         PhQ+lwC4JTQhv3GYj+goAFmQp6TVCgaLcoXGEju+EnjWVWbrmxn0jKoKhjdJ+HSClljg
         ZTvKktdOCfAAXbgrCgL0miM8d3rH+wRvTPkNpQrz9zUx+nl70h24uTdmH1bNV+7EpBBQ
         RJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441153; x=1761045953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVuiIrau97qjpcYS/102JQpRxXMYJ1qlunE5ky/iKeQ=;
        b=HEqWsC3FuVMa4iqceOmCHSiqP7P4L2DqoqM3rBpYwZn+vzIx3cvbkxPrsWmW9L7Vs7
         uYP2U6CjY4MdP3h6ptNCuJfnmOZUg0j3ZyC37sZoU4t/82tvil4V1WGGW5dnzkX8K1Zq
         8QdqMkBB46IR+Lflay/DcI95BhgDQZtZjXIbpoj1xknCs+3Y8fdHiEgAlMB/M7O54ziB
         nL/FSJM2/es32h71G5o9yOnMdxt4/HdNO0THECxg1j+EZUMLHmWNEV+5dVMwAaRh5rl5
         z/qcLFInJ9pMmQA+fs38RCqiLT5JQaVMHhGlKNnkutdYnqU3/Iuf2WcYH+rdj0YFhI4v
         vCEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7brDZnHk8gUOVD1oa30ThB4bTGq3IWgNZHBExyS1UywjXnw0I13y5qsbSe9Y5F5sKZVc9J3FDfLKp2go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk+bTpnFXli5Kizvhu6i/ffRjP9tRVF6wktyqHnDWxkM/cEnKs
	D5LITjf+3/9KSfQFnbiIG7934+Aii1Kg0Po2QNJfkXDGkOgEgv6acDgyyWCuddEsRhZuPq3WImI
	wEzSUC9IEmhyhyrjOLltriETVULo9u7k=
X-Gm-Gg: ASbGnctYEpUnQPtmCenN1l4rfBaETEbJ5hFQrFMpusFdzUiLFHU8aRoMUx3Pq/X0qC2
	u1IyPPEFp8w9xwxRsU4HNgpvDc0hd0zimdksweA3jPazJi9U+GaVxh9JfrhPkFyMgR7IzKZZYpk
	yu2eVlVe9U5Zo0YLzm048yE0Uk9w6osQc9+ssYz9+8aLfpzgdeDvhmpwzsPLXissGXFWhp/SZ2l
	dX/L7wxbNVQAafkMAT/r3fxVTdAVhWKmnsTmB9Y1s8cdXPwcWZbZcyeMsQOB9HcGWQtc77YvbpV
	EJ9tr1IO0jyZW2LZ7NiBrmOmmg==
X-Google-Smtp-Source: AGHT+IG/TDprzS6OG3Gn0DVpuSUmx9MXD7CS5+6MCCRpdRxXQxD8wLaVu7wXm7e/LRg2/prxvED50OPG2W6DCb8Dt9U=
X-Received: by 2002:a05:690e:1555:20b0:63c:f5a6:f30a with SMTP id
 956f58d0204a3-63cf5a70840mr10000269d50.33.1760441152685; Tue, 14 Oct 2025
 04:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014112256.18793-1-kartikey406@gmail.com>
In-Reply-To: <20251014112256.18793-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 14 Oct 2025 16:55:41 +0530
X-Gm-Features: AS18NWCx4hH1KxgcNMUNXomJCt-IsbF6ux9Dw_tk-C4GO0AWePvGcEHUjSQcr-U
Message-ID: <CADhLXY4WPxzvzuiZPJmhS-9xMqRZ_qf7ZcFf5MXPgXbgB3_Xzg@mail.gmail.com>
Subject: Re: [PATCH v7] hugetlbfs: move lock assertions after early returns in huge_pmd_unshare()
To: muchun.song@linux.dev, osalvador@suse.de, david@redhat.com, 
	akpm@linux-foundation.org, broonie@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Please disregard this patch

