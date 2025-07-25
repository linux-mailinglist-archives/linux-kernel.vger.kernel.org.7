Return-Path: <linux-kernel+bounces-745957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D015AB120F1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8F61CE64A1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CE52EF296;
	Fri, 25 Jul 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ypyytbRu"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F42EF282
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457273; cv=none; b=cm5XVReGXe7o2siASGKVYHT7Fb/SZLzeId+RTL2mVuT8YNjmmpjDhSX8sZYpoE+MzGRYLwAEX8xiHO9Apr94uiyNrEhRs82TrBNoyac6Eh2IyS6ptONd+5cfhys7Sn/hKF+DHVX53DhCRrIMMiB3gxU+57CoQ+W1verTZgy+jJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457273; c=relaxed/simple;
	bh=qHHRDqKCIypk5v8SMgVuwGgQI5uVL5DFcbylQ6k7pPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6LhzP+Qo86ZVM9UEk8STIEQRKthMl7C1dmEN6d0UcLYcgU7twEQ/JhGmOhWP1kr6aNtSro1yGJOT3h7kstoCpZwzQRWeFiBrTAIoQfJ7UUFzf66Fsmz23le8SbMD9XnDkU3XXCL4bu2/FBLOvssjElyRWb0xS+3wH4JXLXk8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ypyytbRu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235e389599fso223625ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753457271; x=1754062071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rYghJYglv5xycj6lEIeN8UVfDvdCip7qw6RMPEir5D4=;
        b=ypyytbRurIVozhfbBo8qAdoHXn/a+WU06h/Pm8LnByJs3j3xbrf7nsLLScdrGQ4z0Y
         WKYIhZd9tXgzszbalbwFtNUux/KCgJy/Eybuhrq6cYMUxntlSkJQa5Gd/Ze8FXUauKUo
         AUmyHBk5qSePA2R4bASLhNGd+D/IBVbBs9SYy+TR/okLiO43us94aX/SFYYCfeFdtOHB
         2bceUXH2LU8/zLYDDV+fFs2PXoXDxEMYgo6vIEyyGbFgoQaeAU+rB6x1M1nEnSat5QzT
         5Y2mP+8tqjnC6WkPu2/lDj4km7rrHc8p38KOxyvrzwg5rALOAuoWug9LUuUoQPFVGKJt
         9Syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753457271; x=1754062071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYghJYglv5xycj6lEIeN8UVfDvdCip7qw6RMPEir5D4=;
        b=sRPya3JcMnRozqbi4DEwRcEGHU5nNiJjQNHqg/qxMR0Tb14hli0lB+vVWjgNr2FQNU
         zGXAoB36etKqooVpKrMVeonWJtfp2tjzTYUR7p0/UEfh8rP3PGLRiTM8m2Up+El1khDV
         jowE9WN57m94eiF37Gjn88s5vTO+UU7X+F1gT3sf/AqFq1nbnCwnch7PVbWGJEJfga1o
         XkzJnoKXbDJ+2r4tgX8BzckvIlUw0P9X6b5xI2gEk1Dl1LYoBrhhD3hqfkf5DF5SG4YN
         V2n9uLEvUSvGkZThgAHpndabOgwuNlw+qCpbrlTZccxDVHddNRAeRdYEaALow/udekez
         C42Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+mikSFS7tAqHJexMVnSGOkkBY1j9oI566L0F2+8rYKfdwjfXQVoFniUogsT3qqydMQnVa1Sdx2uOAmP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1pMfHl4IReHYaRgF5Pky+wfL8Qjsfkh8bqZ2LYF+1lzn9jwfH
	dld2iDko7z+I47pJ9ALuN4CbUSllYWHtm9VJdpMK1hcC34VmiHveU9Aayvn8unub4g==
X-Gm-Gg: ASbGnct//uYg/uA4eB+xPZN7rtmrZbmQEpUCs6S6lz9vzfA88ijjfWIfvCJPot/Eq58
	w4Mgwl/xtfccM33AlTUXk08YoIE8H5DKGWMe9sR3f47LWN1dmkespZgGn7UstEilZAN6XhjVxQ7
	zJoLAIV55rFESGJfIU1/eke4zm7Gy3spbNwyvvalEISUmo09C+heWK0ZVjofboZtv5M9xLqFCN9
	07+aEg9I9qRRHm8sQEmvGcI7Kp3Ywi+7VwQtQvkP1IQZv/YZ5615d+eixq2ElWkd+1RWHa/b7nb
	2Aitm+KZ+eft/tjkPSL4Pqpc6j1NnjVxu6YkcLnZXnCfBVjEB/tMCWLAvvmuzKVkyAGJKf89g+m
	aS+17N93cLswEfBbSXbBHa321abKPZmQTIstZwQMlHrGhsFQ0qTRV3WS7bpjfo6e7sZZ5EbS3Hd
	nnyPnWmQ==
X-Google-Smtp-Source: AGHT+IECUS4ICPT72rez061zYucyKAEQSZl/Vqzwhl1r3oHDO13mDG6PFiHjVXy9pYhZCAlwaMGg8w==
X-Received: by 2002:a17:903:1a2b:b0:215:7152:36e4 with SMTP id d9443c01a7336-23fb044e610mr2864835ad.27.1753457271064;
        Fri, 25 Jul 2025 08:27:51 -0700 (PDT)
Received: from google.com (106.81.125.34.bc.googleusercontent.com. [34.125.81.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30ae0bsm225725ad.18.2025.07.25.08.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 08:27:50 -0700 (PDT)
Date: Fri, 25 Jul 2025 15:27:45 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Monk Chiang <monk.chiang@sifive.com>,
	Kito Cheng <kito.cheng@sifive.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-mm@kvack.org,
	llvm@lists.linux.dev, rick.p.edgecombe@intel.com,
	broonie@kernel.org, cleger@rivosinc.com, apatel@ventanamicro.com,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	charlie@rivosinc.com, samuel.holland@sifive.com, bjorn@rivosinc.com,
	fweimer@redhat.com, jeffreyalaw@gmail.com,
	heinrich.schuchardt@canonical.com, andrew@sifive.com,
	ved@rivosinc.com
Subject: Re: [PATCH 01/11] riscv: add landing pad for asm routines.
Message-ID: <20250725152745.GA1724026@google.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
 <20250724-riscv_kcfi-v1-1-04b8fa44c98c@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-riscv_kcfi-v1-1-04b8fa44c98c@rivosinc.com>

On Thu, Jul 24, 2025 at 04:36:54PM -0700, Deepak Gupta wrote:
> SYM_* macros are used to define assembly routines. In this patch series,
> re-define those macros in risc-v arch specific include file to include
> a landing pad instruction at the beginning. This is done only when the
> compiler flag for landing pad is enabled (i.e. __riscv_zicfilp).
> 
> TODO: Update `lpad 0` with `lpad %lpad_hash(name)` after toolchain
> support.

I glanced through the proposed signature based landing pad labeling
scheme, but didn't see any mentions of lpad_hash for labeling assembly
functions. Is there more information somewhere about how this is going
to be implemented?

Sami

