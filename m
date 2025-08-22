Return-Path: <linux-kernel+bounces-781163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B13B30E56
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B43FCB608CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72E1273D8D;
	Fri, 22 Aug 2025 05:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHnbbGFB"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4962E2EEA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842035; cv=none; b=LAYqlgtyWPrBqcRJCuNFm7J2P8jyObcwcYuhOhsmzqfcSbuLsSp+yTdo1+exZDTmLl4DIOxKicP9n3bC50ZcRh+gratiAYDa8rlcxOutGVdqLtS2NCKKQxUtMpOTvDVkVKs+gvynsntW8B1EEQJ39yCXSpzbe9vl5qoLBPVdZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842035; c=relaxed/simple;
	bh=4wc7/VqmVDfbilpC+4CI5l9qIomR32O2gKFjfvsNibE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3/W3NBDa7Vvhb9B3I7T82wGvfAWHicUo/zJdEFEjKWdfbZC4MYG68FOp2Ppn9RbaHjn4S0i/EPE1zW6fhLNb9gaPaYfFa2pFDtzx+51G7E0pldi2AnPeIyCt20y56EkYT1mKMNwIrcgzkPdu0sSQuxiZ3QnAdKJ7IadypMFqdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NHnbbGFB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b476c67c5easo1207082a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755842033; x=1756446833; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lRfMPsVFFjc7ryDHEvdpPmW3OI/EuSPBqar4AEujing=;
        b=NHnbbGFBgQIZrMexdm3Z4j+W+4QwNcCd/G32h07PtVrBS2ffFgtJa2FOCy84oXI9sM
         +jAldJjA6bAuNTJxc5J3B9xiKrYV4DRt7oegzLz+k+BbnQQXEqblyqOx5uOngtyIu8K9
         YZ2531sH2I0DEqTk/CWAPpk4DIqc/ij641PI+WOEseouwcyf/EU1nAwrKQLIRXI4es0F
         0XpXQUetUGxAjCitGp0a+ZZPKvsTBVvw9dP6NWsVLlIBk5vnGca4b5fr/rTAebBZhesi
         Z511LgOVKS2CjISXrNH40I9iiMqyf3nVkHVQVGmHPbKiloBC+BL7FezIEXd/i64pAZfz
         9ZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755842033; x=1756446833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRfMPsVFFjc7ryDHEvdpPmW3OI/EuSPBqar4AEujing=;
        b=ge4u8Y0k6YVUTehtzghWxFZkJTp2x5439SntgxUQfefuouZXLJQOgUxps9dZBHKql7
         3354tg2v2WC4sGSflHnizKPgBymiIbG6YqkBN7GQzoSDbVujaSEsgRG8KM6fFUezI+YA
         PP0IShSYOKgKfSyTL4zR0W1sxFKAyFF3X425EF2CRUNkMH5ECUcWwFooCWrAA9dLXjb5
         TBjG3DKyaU47+Y3HaPpJOzcm4Nb10bSPpdXJvmEIifK8Hys8GbDO2ZhBfs105w3Kst6r
         rlDn8yqIvlpvbt1L6v8XMRSsv5VZjYQBe/Zuyhbo0PFTvHLdho/VjeLyqV/tFBfQ7TTm
         M9yw==
X-Forwarded-Encrypted: i=1; AJvYcCX+zPe3HS4G/9tYDCgdBwBdi21dRJ5X7OiL1jpu4zcoRGNYid8qbDkqKoeDkDXFmwcNYPcULHK3TVnbWfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuckOl/5UjE/tuq36zpGJJBeQ8WfMxY0T0W9j6NpWm+6g1QX5E
	5tX2b2A1hWrow0F2TKkFk2uRgOBlgqfzETCxRrKMAeUycpTaZpQNvLw4Cjmz4vRDIpY=
X-Gm-Gg: ASbGnctGheYrWlqIQqreVcxncvKjqfjkIRHIEEXTbbvygph36brFazXYQ+O2jHJ6KLJ
	bdfqEP5T13iMKMSHLb8Emdf2MaTJhTQW2OFbIt9GFODuMIHeCKVQ0U4CJV22O0YnOjx/Sx9eOBu
	wiO+z97BjVl8E/8HLKpcWEvNBZ/MfmRT6gN3zOfNAYF2ktqQf2S6KzAAgnnthU0veTctgVjWNMW
	PHATnubi1C7FmYfYiudzOjZtP1u8GOec+FzROHrmpZRAV6D6AUHtud4bjL6P4YB3w37DbwFkX6w
	6H9Y16CkA/yQ5n6ZsSJCtowBt4hLlNx4PYKseQ7fUqLF/Hu3VgIVtEQSORxyQtzBPJLjFfcxLml
	ZWdEBearp8eeD9ddbzI/XY0XM
X-Google-Smtp-Source: AGHT+IGDUhRl59xu9W6ouXglnOGMNfVPExl8Z8m2MHMr5khzXc/sDm3TLhU4hJY5umoiXpIgj2VCDw==
X-Received: by 2002:a17:902:e888:b0:240:4d19:8774 with SMTP id d9443c01a7336-24633d6a31amr21624495ad.24.1755842033049;
        Thu, 21 Aug 2025 22:53:53 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51b3d3sm72222245ad.147.2025.08.21.22.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 22:53:52 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:23:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, vireshk@kernel.org, nm@ti.com,
	sboyd@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: opp: use to_result for error handling
Message-ID: <20250822055349.6brvcxtljkz2k6p7@vireshk-i7>
References: <20250821091606.7470-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821091606.7470-1-work@onurozkan.dev>

On 21-08-25, 12:16, Onur Özkan wrote:
> Simplifies error handling by replacing the manual check
> of the return value with the `to_result` helper.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---
>  rust/kernel/opp.rs | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)

Applied. Thanks.

-- 
viresh

