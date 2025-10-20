Return-Path: <linux-kernel+bounces-861941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7E8BF415F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79C07351381
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B357335078;
	Mon, 20 Oct 2025 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKJDhg31"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844D42ED165
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761004561; cv=none; b=P5EqOcylUs3EUDfkrEmtySfak13M2lp+Qo+gRV08fWdtpX1gTHj5ACaNxpynuq/EBulph7uO21DJcVK4BTvTsl39vlFHnFiCKaBWwbBM/AU+F+/zOhEEUWz9WziqQE4FUHox+pQA57Aj4QtSR3a2jRSzOYrJ8X+HfCTA/7dclno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761004561; c=relaxed/simple;
	bh=mcUKfYrdQSpgEynl2UwsrQ2Hve4TuJQzk8+mUSe+wHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6OHJdlEN8s3jvQh55TE5Lvykw1dELGZuM7BThseN697RiAqbnieNguQnKAbxs/3SG4ek1ictYzluejDXlPHGbng2F1QXQBm9aL02vMqVu+BAWvNStycVBTj/VECA30CUFYAqOxe3ZAoPDG4OXH5ZFv7cSWp0niI7QmYHnDrd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKJDhg31; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27d67abd215so97585ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761004559; x=1761609359; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u0nnZ8bRb5CyQ3D4M/BOIhfpk20sndQZa2pgDITOBD8=;
        b=wKJDhg31+uMG8tNCOQ6dOFikOV8xNjjHTlI0dheKwrNLRKSZyfyIwpHDwsvlHsAgCP
         Vic2x+oWGa9lJpAhMELz3u46qNSngEypjDZ8WfPCe3geqdgnLPYHuO7kwVCnQSwpOTMN
         46c8HkTYok5k8qTzt9sOUIhyfqAdN74wbZsgl9DVbO5BeD1CTSb9osW84mGcO76iTlX9
         toldUfnk5kGkqgXsA09dN5Bc81m9f1lPeywv/2lUSeK7tJN7kH5MJo5pmkIwypdkpqHs
         /G4itnMUYSxFrSvkRJw+VOWpKUpg/5lqDPg47V2r4xwbuioQVXgV86GQUK25w9+m3fZB
         mtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761004559; x=1761609359;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0nnZ8bRb5CyQ3D4M/BOIhfpk20sndQZa2pgDITOBD8=;
        b=dg3VtJoimsEK1xJWdP+susNO2Mq9U9l0415q4qgsGel+k5Euk0wZtm3tPEQA5CCb3l
         tIXRiOC4iuKi8GMQjxTvgcay02pWnsy8hH47TIWuCEOp0savEO5V5y+UfvQvo697f7Cx
         4gaZbNPFNhNdy7aoL3QunVlyqLZ+4BDDx6I2xJIVL4p0WMi9I3QEL2D319vY3DI3y2qS
         E8iz93XV3rcRSdDSpQBcMJe+CgOsG2LdLFemBttOwNvRSCH59EbCJyMdEadUawwZCDWK
         KGNwd7sEEfYWW2wbRJm1IPcdZAx4Ue+LQ7KeNz2j4yj4nyxSK7ysy1dIQ4CdabiGPhcs
         ExfA==
X-Forwarded-Encrypted: i=1; AJvYcCV76cotE5OYr0k/ITlEBwPCyZGenyk3Stft83XmRyIbCVhXLPwMpJdj5oS361pPDuWd+Aj/LoVEKegj69Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAERXRGmyT7PWIvxP1omEiFxiWki8hGvqE3O0zrk6F/V2Ha2rr
	8f0c7CLXm+CIC7AEJxwUfoJWnkMH2DRDz5U2dIiYzbZ3WPjWpREncHSSbHqDK5LohQ==
X-Gm-Gg: ASbGncvMfHjNMH0YpOmcrLi/HLOgECcWQYslLaQyhW8F2x4Gh/n184ZMQlVpD6N4+ML
	rF2SUnRL/eLOgzCvbAdRvc85AS8yYiXXUb3FC3vFS7Y5RdjHTGMXhJ4zGam/JY8ltuGCyIksAdZ
	zibxIO/VjCYIWYuNq+NKuwt42TqL1JYtJze5BPHTl4DSTxCIbDU77h+nmDWSV4fbs/LuXOhb/RB
	6h4Cwk4ymDBAfwLw52TJxVNYBsvOLrJV66lDF1Nv1vCHKeu0jxHjeklwCfdXrtcyPCpWmAdApoY
	JaQ89bq/RkAdGMLKCRn8axJRB9i1Yl5TiEZB10wxnc0FvnIRtmq65M6dj/GHKopanw7CAh7CHBX
	YzL/pRafX6+HkIQJeEtqro3m42xUXsEtB1C+jtLpaT/nr59vrGsYLePxaMDpza+yRLl2NR0/ngI
	pcwFXyT12AGZ8Hsjdr3CwRJpV6ajTWc3Nv/mypuJ2/gqtt
X-Google-Smtp-Source: AGHT+IG32aKEvMqQdCicoH1rwzi9rTqB/3kzHLOxoWRLdvRJmMsuPKuV9j72408kyB6QWaxlgj5D/A==
X-Received: by 2002:a17:902:e547:b0:25b:ce96:7109 with SMTP id d9443c01a7336-292de616a3bmr863795ad.3.1761004558570;
        Mon, 20 Oct 2025 16:55:58 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de8090csm9243673a91.18.2025.10.20.16.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:55:57 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:55:53 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, jgg@ziepe.ca, graf@amazon.com,
	pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 18/21] vfio: selftests: Build liveupdate library in
 VFIO selftests
Message-ID: <20251020235553.GD648579.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-19-vipinsh@google.com>
 <CALzav=cD4WLKX0roP8mvWEO1dhLGLtopeLTmH=f-DeV2Z3mAJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=cD4WLKX0roP8mvWEO1dhLGLtopeLTmH=f-DeV2Z3mAJA@mail.gmail.com>

On 2025-10-20 13:50:45, David Matlack wrote:
> On Fri, Oct 17, 2025 at 5:07 PM Vipin Sharma <vipinsh@google.com> wrote:
> 
> > +TEST_GEN_ALL_PROGS := $(TEST_GEN_PROGS)
> > +TEST_GEN_ALL_PROGS += $(TEST_GEN_PROGS_EXTENDED)
> 
> The TEST_GEN_PROGS_EXTENDED support should go in the commit that first
> needs them, or in their own commit.

Yeah, this can be extracted out from this commit.

