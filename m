Return-Path: <linux-kernel+bounces-868279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CE3C04C38
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 908C04FA2F5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6101F2EA724;
	Fri, 24 Oct 2025 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Co/YAEkY"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B222E8DED
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291539; cv=none; b=qC3PYjUeHOLxiuax4X8fxKC2Szp+VuRBk+ftd65MBXPyndRIRFywLsVxcs/IIhsrifJSSwkPRN1lMl+3HI4DH4zkAL7u9j5IM1hGYwWBkuYUHn2P2DBUTvCpQfePerM5DYE5kj+AYoJB72ZomB3/JL6Vaxm8CkleBgOS9C6rVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291539; c=relaxed/simple;
	bh=89SYl2KZOwWJxK1wAp2kwiWohj5iMOt2aLgrdRztCfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjofgEBg4x2Mrh7vWpra9UyKPapwkO3zdayRI0ZO2yTedAOBtKiqsynxoxqgkJmpMmXZmP3C8jFwVUiDMA9yrnarXX05qeY2diV687qV6w5rk21neuiVGMr9R0/1h1h3F2sCIOcGhmg2/ttmqKjxmmAl2ECt0rVj459C2UKSIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Co/YAEkY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso1688858f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761291536; x=1761896336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWjiXjrqyzK/iXD4R/873eykQlEHswHIXOchBtrT4ts=;
        b=Co/YAEkYIbd43MNkMCGvCk6xtfIPFEu7jSbqvvjbIaDrZlwSQcTwGQT3bc8cNZtloo
         87oskySGeELbkBOlVoQ/H/gc2ddvJErEe8FFjuxEHcWKXzI54Kw1VssEdz3Qs1xuxwtV
         fIefbr8pzjeKrWl6dDXwR03hzTD3m3YUraiUyzFXngquAqoZOgHupEI8iTL8olVqdFTu
         loSoakG7oYZ2bxZ9dsLcmnDqaC0kHLgKzfZ+zAhzAHPRWx6PqIg22Qpe9BaE1fqKGyAD
         dqnp+2AylFoOOGVn8448wLKRLCSYq0wB+lIsoWOIWbJvljuE7pcerN+eqbRMHtbtWuoM
         ibHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291536; x=1761896336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWjiXjrqyzK/iXD4R/873eykQlEHswHIXOchBtrT4ts=;
        b=CkXZgvqMcMn3i7CAJzMXGxD/8gkc1k5HrbaTBf5MFYLXLFme90AtrtyVqWlDy5Qndd
         UdsM1Bw6LInOdTWzZHCC216dI86+pBvYn3QGHYr7FbhALdeV/TfkVCfSopxa2tm5tRJ1
         2a0Y6xRqCZ6lLrvdmKWCW83Wdjyu1BUnSr0jAMPk13KtHl3Le4wkLy8se3Rn4GyXyHBi
         RMiv7pCOmxgt8EjZ0eV+v1eKIiknjdvsMmMPc9wxb6/yxNbW4MLfotlokPyWKzMayvdz
         sUiCdMCOZlE28izJqAYfdobzQCLIiAwewqg8uxbbYRDU9bGLk8fij8AcsboESF03soQ4
         9YkA==
X-Forwarded-Encrypted: i=1; AJvYcCUvxollheBm9yOvQU6K3dyQN1eSMXLHwu8Gxmvg4VlQgYOiCxKb6tePlK+WFz4fv0l835nGEleJVPpJbZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9HpoUIUeyN2qeOCeg/HeFlgbL9iid/q01fY69aRRM1laCBrR
	TpOL2PKIF4Nhg2Jqx4NuugKqnJsQ+TNUH3rJMrUKDehB6zpxEiNF46acaFf2Uy7ujoU=
X-Gm-Gg: ASbGnctZdEW2Vm3Cf4LLS3p73Nm/f2mDVRVnMq5CjW7E3J3FFzuJagH99obMNehEcEp
	/JFxfjDipDF2mjH3Ssrhh+2zk42lwJdfPuQiubffJjdVyCMA2cHygjwT2R33Ut07p7bTJOETypN
	yLSvF99uO3K+k1v5LMUDfhaDCJtqWamI6s7xOSljFehVXthexH+aRRdEdEctlUemApkEkR81Xb7
	LjpoO9JtH6pO4VIunaxOLdKqpOVngzcp0q/xVlC0MSd/WH4BjNlYp5uSlEbYuB6ZUyGg51A+gta
	Ub8KEmxdIs9EyLNXBJV8FOdIwwq6l++o7NFp+YCCzbsugxvHFjkVVTAkLcssyN/NofjUUzW8gGh
	lUjmTpPim53SAUIigr7hWVvJSB6s0QdPEEOt1mqrJIQpXjVmf6/K0/sFXyIjEVuOVQoyfpZVF5R
	rsCW10W8iS1i/PhikjJRNWJPxs5rqiqLVk
X-Google-Smtp-Source: AGHT+IHMbLAdC/xuB+rLLbFga5DXcsyo5YyU6+vhemg24zckk0wkyGy5nZsG6GH1Suc+bZEQLCrrkQ==
X-Received: by 2002:a05:6000:1861:b0:427:809:eff0 with SMTP id ffacd0b85a97d-4299074fef0mr918259f8f.36.1761291535892;
        Fri, 24 Oct 2025 00:38:55 -0700 (PDT)
Received: from localhost (109-81-19-73.rct.o2.cz. [109.81.19.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898acc63sm7914006f8f.27.2025.10.24.00.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 00:38:55 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:38:53 +0200
From: Michal Hocko <mhocko@suse.com>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: shmem/tmpfs hugepage defaults config choice
Message-ID: <aPstDXRerYqi1O2X@tiehlicka>
References: <aPpv8sAa2sYgNu3L@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPpv8sAa2sYgNu3L@shell.ilvokhin.com>

On Thu 23-10-25 18:12:02, Dmitry Ilvokhin wrote:
> Allow to override defaults for shemem and tmpfs at config time. This is
> consistent with how transparent hugepages can be configured.
> 
> Same results can be achieved with the existing
> 'transparent_hugepage_shmem' and 'transparent_hugepage_tmpfs' settings
> in the kernel command line, but it is more convenient to define basic
> settings at config time instead of changing kernel command line later.

Being consistent is usually nice but you are not telling us _who_ is
going to benefit from this. Increasing the config space is not really
free. So please focus on Why do we need it rather than it is consistent
argument.

-- 
Michal Hocko
SUSE Labs

