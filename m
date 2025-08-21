Return-Path: <linux-kernel+bounces-780527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87238B30311
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BA016DAC9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643FE34DCC0;
	Thu, 21 Aug 2025 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWGObK2V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDDB2DFA2A;
	Thu, 21 Aug 2025 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805167; cv=none; b=CMCpwWWI0iaSXcgxVgUBtf3x6e0BpJNCoiS8+pGEPxNfBovxX1N1DCOKTHQ6fvXG1wKjQFFKf+GCLx6CYfXrDhihZs23YupQCymKTji0uiK8o7tWNqkPFqZGJL2l3SO4NyUc0FTFJvtPR3Df2VQMPdNbmw5zwud9Hvliz3n4GUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805167; c=relaxed/simple;
	bh=LaB+1YXPeYAEKWifKqdPsPK2syI1t4wJ/ha/VnX1fLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etGZHrEjp+PHQksqFW7U8/rbc6mxUmgGY4/Zjgru30hcZxCmsWeXS4dHM0mq9R0kYTqH7iN035eyIMWxafvaKjvj7xwRfBkQ97vWyd1BdOQ1vfKE/3TwpKct1YfmWDbOLsjcXGW6+t5W+Z/oaZGPicYSWFojXtjrOhjUTPqbUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWGObK2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF1EC4CEEB;
	Thu, 21 Aug 2025 19:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755805167;
	bh=LaB+1YXPeYAEKWifKqdPsPK2syI1t4wJ/ha/VnX1fLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NWGObK2VYjwYNetU1jj2k/PX5F71WrToAzI3FMjpOJfPYBBV/4E0pW+PLsX7yAHNx
	 OvXkiE1fG93UPWcmynZz2xx0ubAGvo1klzbFh5Upo5FMA0jwiPKCoSCpSAF3vmZxrq
	 F9UxpgXZ4lC1vCM6yZhw5kVuoYN2P7q+QuiJ5fC3hAnWTTdLvVmrZZQPQ8N+GgdGtc
	 nfm2ETxDxFAezRcYI2kCkDCtLOsOPFwxv50INAsUsHN7hv2bZhlTQMxF51rFA7jRot
	 9KAgdFeMFqghWsH9hz1kJWKoyWel0SzSbdfZbpAzlI6tFoIkW8IUfEb6Ya64yU0Kai
	 S7lI/guFGFhfg==
Message-ID: <55255353-11bc-4096-8dc1-4beaec89f44f@kernel.org>
Date: Thu, 21 Aug 2025 21:39:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] rust: Add read_poll_timeout
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, ojeda@kernel.org,
 aliceryhl@google.com, anna-maria@linutronix.de, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, frederic@kernel.org, gary@garyguo.net,
 jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org,
 lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org,
 tglx@linutronix.de, tmgross@umich.edu, acourbot@nvidia.com,
 daniel.almeida@collabora.com
References: <20250821002055.3654160-1-fujita.tomonori@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250821002055.3654160-1-fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/25 2:20 AM, FUJITA Tomonori wrote:
> FUJITA Tomonori (2):

Applied to driver-core-testing, thanks!

>    rust: Add cpu_relax() helper
>    rust: Add read_poll_timeout function

     [ Fix a minor typo and add missing backticks. - Danilo ]

