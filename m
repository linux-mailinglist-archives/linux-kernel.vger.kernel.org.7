Return-Path: <linux-kernel+bounces-806434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E609B496C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4171116A77C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA91312811;
	Mon,  8 Sep 2025 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BogypYvH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CBBC8E6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351657; cv=none; b=kX3FaW5gsSAzUUKk7SaN593D9P7Q7UPRI/1942K4ehBGFSteoy9l/NwbeaVaAgId22yyM3MNJsPXmgNYlMRU9iTQnapYg6nnhokVYdKGKFrHSVZ0P8mm4verWX79bUCX55O6ONbEkWnGNh5/jIdOlnaTmJHT0pWzAldV2iC5sgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351657; c=relaxed/simple;
	bh=XAyaXExBHHyEnvOLdcbX1YFf9QB8u/bLAjINL6U04o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyoqjqayJ4HQ6lIjidAP+VKeTDDhHYxtlQmvwNOkzD2V01/wqq67Z5/Mz3O/9jJbECdd6XTCoC8A+as0h+6+KCTE+2I3ngrCW/kRh7SCSL0p1XdgCeY/40/ThfVSrdcYv8xv1MzI+jpJ2vI0J3VJPFCpPBXMpaXJAw4bUr/52PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BogypYvH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757351654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XAyaXExBHHyEnvOLdcbX1YFf9QB8u/bLAjINL6U04o0=;
	b=BogypYvH6jauuOfrKwbyK07w1hZrRvXn3bMPqUBVpbeCxC+BhHc5XM83aq9y1a66V5tXDN
	5eX7/0HvZIkvhwPKQi8gc0qUxCjo0XnRgGU5266h9cdjG2tbuf0LyVx/qSg7iN4TVXkVcv
	PijHHo0MRKWpHqZG/5WB1rQJfItNBzk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-ha4PX_OfNYqlGgl3KLSMfw-1; Mon, 08 Sep 2025 13:14:13 -0400
X-MC-Unique: ha4PX_OfNYqlGgl3KLSMfw-1
X-Mimecast-MFC-AGG-ID: ha4PX_OfNYqlGgl3KLSMfw_1757351653
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7222232859fso91860676d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 10:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757351653; x=1757956453;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAyaXExBHHyEnvOLdcbX1YFf9QB8u/bLAjINL6U04o0=;
        b=N3bagHb4eTGiRKZABGmTwcNYf4kei5tRgegG8GSiOJrW9sr4n305OdpeDCkEpDFn6a
         meJz4x2WnaJV0xIVBOXZ1AubsPrEmiGtt1JivHwN233l3rHAmBQWA1ktFspIIxLO6oTQ
         58y7jZDO/ya+Yo5QHqshpzMkvv1TAYKVSCDfKFknJSU17jzlS28wBIb5UsQ4EoAALFIe
         IOy68uwcPkUs+FOH0ryvCyV8nw68knHeLqbP+JjiGu1kSjqcLfV1BLhJXPy3pKjgwpX1
         wWTg1QfZPgIG69GzciZ8+yE3nJ4g9IOsLawK7zYRydsJY8GuCFVHUHHBmxOANfWfMuG6
         N+eg==
X-Forwarded-Encrypted: i=1; AJvYcCVFbPPM8EEatGvUd3lc2C016fUUqmRgjrViMil4SmaKvv2bIMH3OGYyhCFNWN3XhVjagjZGjOAh3zGXvIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFalDA4FOyQz5BS2R2mmqZA9MTOXDgmy9OVu9pNYRI/u31Ajz3
	JVBNy0FkOBwV7v4lCj6NI6ASIrHSo+fgBldmYf/pteawrR5ZZvdg+54ncsKfV9ZgFZsUbiBh25k
	Z/rvJaxIiR9QvZXrmVL7v3me5fxX07Fi7O2TUSSx0Uou2y8+nPHTgg6JV5JTUtyuzZA==
X-Gm-Gg: ASbGncvHqJBJJ+vNpnqovD+7NomlFDIVj4ciGdSmLjCoWgyPNwlL/6mEZP+EdWU4+Dx
	ogO9t5JSZPMR1G9QWNKgJJgTNvikb108mfxTJEa/TWXFhSnzDphfHPtc3cDr5za7yrNfygZF4Qi
	LnDiRdmygsbawyIgy09zWk1P0kS8ENCAKtPJLNLuxtjZqjPVmOrqdpzlSQW1Af9QJt76u/sCOz8
	jdsgugMHLQlS11X3A3Fu4067+MmcrED1ojrl6tVJtqKjoHDn1+taA8ZwAJb+LBOZoVSwkyWT92w
	lm6odBRpKCvxPlGNGnZInVH2eZjR9X0lLy+OFGMljiDlifV/ImQ7B/KuFns=
X-Received: by 2002:a05:6214:20aa:b0:722:2301:2ee with SMTP id 6a1803df08f44-738f96e2caamr80296696d6.0.1757351652877;
        Mon, 08 Sep 2025 10:14:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/UTbWr2hlWmDxJPVRufiEbt8Dyg8jyOvQQrGKw1mgRo0M+bnVYnjj3OE05uOoCLpdPB1ImA==
X-Received: by 2002:a05:6214:20aa:b0:722:2301:2ee with SMTP id 6a1803df08f44-738f96e2caamr80296366d6.0.1757351652329;
        Mon, 08 Sep 2025 10:14:12 -0700 (PDT)
Received: from x1 ([2600:382:8507:870e:b6f8:ee72:4f09:a16a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7426533bdeasm44952456d6.39.2025.09.08.10.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:14:10 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:14:08 -0400
From: Brian Masney <bmasney@redhat.com>
To: Peter De Schrijver <pdeschrijver@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] clk: tegra: convert from clk round_rate() to
 determine_rate()
Message-ID: <aL8O4HeQWm9b8FUn@x1>
References: <20250903-clk-tegra-round-rate-v2-v2-0-3126d321d4e4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-clk-tegra-round-rate-v2-v2-0-3126d321d4e4@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Wed, Sep 03, 2025 at 11:15:01AM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated in the clk framework in favor
> of the determine_rate() clk ops, so let's go ahead and convert the
> drivers in the clk/tegra subsystem using the Coccinelle semantic patch
> posted below. I did a few minor cosmetic cleanups of the code in a
> few cases.

I included this series in this pull request to Stephen:
https://lore.kernel.org/linux-clk/aL8MXYrR5uoBa4cB@x1/T/#u

Brian



