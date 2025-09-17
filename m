Return-Path: <linux-kernel+bounces-821042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5D7B802BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29263521801
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ACA30CB33;
	Wed, 17 Sep 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KkGncdiJ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCA8303A29
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120279; cv=none; b=qSG/4UDGBnD5pLC2wNh8gJPj9DHtfIvI0QlXwPzZHSCygHLvgA31z5DdXCcMwl3zdhRh4kc6J1tj5BttxAWWlY38XV3wQhJYuXgFA19GYoXR0ozBWkzB7s4baWytPqEFI2wj8IY2JIZAkXOC37lqdKzDrIcArCqntRIqU+u32aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120279; c=relaxed/simple;
	bh=HnJnkot1+rn4s3cdxJNe0XcEndPrzF+uQQTDlNWewzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5iQl/BoqXDKzd1iwhTjIQbytIbEMRKkKyde+8ElxjR8FHfnYC5+D1mwJ2Ij3UDO76amoWruzP9spNIdh4JfOdGtKi5TeVNm2NmZzV+0cjnqsmnvU7y7RaVS5qm9KrvdvFppXTUAYUMdtDZkzotAIKEcjoTWQOUCkMWwemepEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KkGncdiJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso486021b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758120277; x=1758725077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HnJnkot1+rn4s3cdxJNe0XcEndPrzF+uQQTDlNWewzk=;
        b=KkGncdiJ7p+6H4I+/Zj7FL2euAXKFR3eeEvnFsnHwIYAGAsctmLnH42XZ61WOW5MFi
         1u2Hq8jbKYhWArlw7MEABTsYP5hBquudjojBM7a3QdNbyIqZAdaFlDihW6dC88T20DKx
         81Qgs7MfRr+hUwr4VC47ftlv0WB2eV8Ulqac1susNEGhidNidI96gPDe2kYYG+Z5kQhz
         QcYO8rbOnvcIn5EepHcDf61FUaaeeupdIJWsKEVIVUYXn+ZTk7Lb689MACVfCp83tC5i
         GffU3RLsPI3DUEsgmpGhpGUVCD0D+PdKN0FA3/EEeegr3lC4523u4SNxlfeiR4wDSUrj
         Nstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758120277; x=1758725077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnJnkot1+rn4s3cdxJNe0XcEndPrzF+uQQTDlNWewzk=;
        b=MIW+U5QKBbGGVIP4y9L7vyTOE3nWwk1mG0h+SJNvltEvkh9BVhBpMoknL9IogBekx9
         vifd2E8+dhtPHobUA63pI6R6hzUqLDrnM2raqaVRwfXIiCt9iD5FQbkSOonggorofMB7
         quoKVOpRwxPipMwnjVy7BBPnhHTeoTIZSclrNfC3uaBN/N/JHzp0kxNzZ4wRrtU6NM12
         e2/UNkGZdFqFWJlD8z6AGitUeh1OQO55Ps2ea9n6vPgojjt6hrvTEBFvzw4fBkVGtUUS
         fXJq+qGUQYgO/Ok+feVBTos7gSWryisgW6/0r0yDrrAPabiwprfvdp/ho1/o7rLFW/Vu
         EgBg==
X-Forwarded-Encrypted: i=1; AJvYcCV5Con3hgXmrhoSJqc0yvBpEDt2yAqXtJ3rIKfxTh+Zl70ZMt+zmvRAX0so+cKY4j7wbQOB1GWp7BAhVtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv6AKfEpan9Ns6vKwbVj/Ci23bCcLfvPphf8K9E4whPn3nTORn
	uxQkkiqd9F8JIs2cuEQ/V5xV7JulYkRHCW1793RG9FZaBHA9eqxOuCWEx0uVmTls/mU=
X-Gm-Gg: ASbGnctIJGVWp6VE5u5a0rz1XDtJQVciHrPvWVa80SdsnJrFSjOkk7fNxPCsBzXuKww
	fvoVogaFXFIryoIjp8czxkS7IlzO9BQsF2UCwSExpKCs+brgaUZ0DFNUPc1Ot5T6V9Z9gM5MZTD
	NF6av1H/1RGPtnQrvurU6IfmO6nj+rY8NlVX55mlQURnPFRkTPmnWqQtnHfGccqxqD7P+iCnNPR
	kcKAOi6qBLi68aMs4KWnJaecn0M4Q4S5+yw/lYyiL7oMBALAKtvsi4GVC+V+0QkiQE6eoEPGaDb
	mOOPg0fKcPp7btYvarO/xIICUxcKxDoAt+64T/rt5/jJgwq6T2zy25MSlYTGya8BW2XtSaMOSzE
	sTLOLyI4=
X-Google-Smtp-Source: AGHT+IGxxIJHN/EMwPyG7Tm3jmmOepTSVr4yhyZOluH1XV/4YRxZqqt3gswoEzoCKIkgz4edkbVgoQ==
X-Received: by 2002:a05:6a00:8d1:b0:771:e2f7:5a12 with SMTP id d2e1a72fcca58-77bf6dce4eamr3307903b3a.6.1758120277565;
        Wed, 17 Sep 2025 07:44:37 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a47acasm19051666b3a.38.2025.09.17.07.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:44:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uytOd-00000008NTr-49fM;
	Wed, 17 Sep 2025 11:44:35 -0300
Date: Wed, 17 Sep 2025 11:44:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH 0/2] Move io-pgtable-arm selftest to KUnit
Message-ID: <20250917144435.GE1326709@ziepe.ca>
References: <20250917140216.2199055-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917140216.2199055-1-smostafa@google.com>

On Wed, Sep 17, 2025 at 02:02:01PM +0000, Mostafa Saleh wrote:
> Instead, we can remove the __init constraint, and be able to run the tests
> on-demand, and possibly compile it as a module.

I think you can just put the kunit in a module to avoid all this?

alloc_io_pgtable_ops() is always exported, and I didn't notice any
symbols crossing from io-pgtable-arm-selftests.c to io-pgtable-arm??

Jason

