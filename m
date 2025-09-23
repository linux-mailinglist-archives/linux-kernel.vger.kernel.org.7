Return-Path: <linux-kernel+bounces-829052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2586B962B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDA51890B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6D1231827;
	Tue, 23 Sep 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KN175lqR"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369401A01BF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637002; cv=none; b=Ps7pgTfzvZ6683HpmgwHGcyAoP86c5j8nv7hP02M1Qxmg2V6gfNDPdEVXF6wf4oodFhF6bvzfFUxItL9uyUy8v8YZuppExrMgRWiJVPAccCdUvQ2r1WBKdjF5Aya5vwax32t9wthXwUCg+pe2VSTivblfgD+xRxiSiSDsb4ETFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637002; c=relaxed/simple;
	bh=dc0LTmBu+dOpA+A+NZjK2VnTaiUPLbi5QPaHxg/XqmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VD9BPkIqjcuPrmKMhk2HW7yL1Wr+MdiY9/PGEJd4/azzdO44cb49QEYfOsSGme/R9nt5iYMAQKuwQnKWrlA7y+DeNRDazwcSjmF+k/pTVS0uepXM7iwEjkmCG+fdE/69Pz6Mt37gjNMZq/gqlTkmgVHmx6764Nu8IKL2ASV1DcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KN175lqR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3194020e86so50243466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758636998; x=1759241798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZb80l+O1E6xQBvd+VRgbjxn94X8U/j59tKSQYo1uxw=;
        b=KN175lqRjx4eQP6T58FgKuTwjDr7oHD9QnbPl7291jq/XjHfTlGSkOQHhLJU0hof3a
         1EzxkeyIiYS5L6BCpDtRUe3yhuWcDVhOBYDowhn1fm2+YNVl0tW2/OsrCSV0foTvjZVP
         TDybNUhmzUI9EZkFs5lRIlIaflUNlHHYLRLaCcqjLkBUXRQxwAod96uQJAybqpuCI4ti
         4b/LxDZkVpIUieU9skzTQg7/iLHnMVS+1fkZN3f2UICzKzcyz0Vjurc4eoe9JsfSIHYQ
         I1tn+mCtNsvD3ZJKckXvRixMfFI0CFSZm2vGZKOqdqp1XAjYSadPiulz/Cee/2i5PTUn
         CjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758636998; x=1759241798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZb80l+O1E6xQBvd+VRgbjxn94X8U/j59tKSQYo1uxw=;
        b=hbsvRCR/8wNrxf80BeX1GHCebIO3bM/pgH2RDut1eygVRVc4DxTs+KfSsWi9vdpbPM
         +mlsM+a+H3KyvNzFYeBZdQ0NXawxm1xE9J58sBhYA80XT+mvaEAJnfethqbX++oNdLNC
         e1QPT45LaWd5YAT1JHaNCd+c6eoyd/fXQcjjVFa5G2jJzUZR44qS10Tdo73pvsosBRe3
         5TL/mFh02S6QI/4DcQUyFuPXW7PU/UKbqk4k8AdKeb61sa7BF7V+4XppuAP1HqNVUOM5
         JVTJXE5+vJ+SEJ4x2ivC/XwMiJolUTaCryFKkF2xCPi4HQ/VN6bjyVFmOTrEloFryapD
         xBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsWaGPPW6jV6UOM4ma8OTk2IIP7OTVUW8GdrmeklPrl3Kx4x/6yRwXUMytXx0fxwrn0YqzELxSirYKa3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMmkBnjNAUDLNkTroK0tODZoktQwokuzHKJFHFnnQ/m3rYG2Lb
	543p3DXpeAQYcHAC+6C5djedH4JdP29ZuBw7sx9wYuxhpv8cRUTeMi0uN+SZIYaqYNE=
X-Gm-Gg: ASbGnctp0T2FpWcH25g8FfYLiizw38WKhfliAnf9x1uj747ZhtXE3E5PGo1JqogYDhf
	SOv4uGKuBKz1Dx9s2gi/gnkXPnlDc6dazfRmMv0t6lC6tAwJbr9Syqj3cwBCaPgHMO4e6Wf1n5a
	bvATDmSvbFYcjw0Fcl6Bo29YOlDw/9mHVuSkShuafXlfrw8WA3zgmCYkUVMZoo5Tnp6Ey3f3SSy
	Jf41+QcponMX6iAzIJZ4uBwYSrp3gwRUhLkplQJPdhVXYOaROixst14CwT7KZjclGVxDtjdGKJI
	i44C/bIynkAIcIkiWu6FveptJbhUe/kxeMN8HSREdhl+DoaKLlkV6brW8/lnbHxY4Z/UIvxsCP8
	Y3zEYyBdu7n4sAAYFEAo+3EqIu/R2yXZpXVIzmjXYwDiU55N9O3HU2iXdcXubMWZA
X-Google-Smtp-Source: AGHT+IEBzQ2i1Adt3iCXJ4XnxKAN2NtFXYdtXtl8S+XU9JKg1rsZ+VFiaHRRKP8LO02MhtH+JmPQOg==
X-Received: by 2002:a17:906:c10e:b0:b07:e207:152a with SMTP id a640c23a62f3a-b302764dbafmr282212266b.19.1758636998268;
        Tue, 23 Sep 2025 07:16:38 -0700 (PDT)
Received: from ?IPV6:2001:a61:136c:1301:bd1:21a5:4846:e6d8? ([2001:a61:136c:1301:bd1:21a5:4846:e6d8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b27217f616esm944449166b.72.2025.09.23.07.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 07:16:37 -0700 (PDT)
Message-ID: <f5a802a4-ac9b-4b45-8d1c-871e2e06d7ac@suse.com>
Date: Tue, 23 Sep 2025 16:16:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: usb: add basic USB abstractions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>
 <DD07LUJXNZN9.3RHH9NJNRFVNN@kernel.org>
 <2025092356-rounding-eligibly-c4b7@gregkh>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <2025092356-rounding-eligibly-c4b7@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.25 16:13, Greg Kroah-Hartman wrote:

> Functions like usb_fill_bulk_urb() takes a pointer to a usb_device, not
> an interface.  Yes, we should fix that, but that "mistake" dates way way
> way back to the original USB api decades ago.  So much so that I didn't
> even remember that we used that pointer there :)

How would we do that? We need to be able to send at least control
request to devices before we have established which configurations
or interfaces the device has.

	Regards
		Oliver


