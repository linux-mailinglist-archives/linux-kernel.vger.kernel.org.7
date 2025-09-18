Return-Path: <linux-kernel+bounces-771327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EA0B28587
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66805C08CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC618225A35;
	Fri, 15 Aug 2025 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rawF6wLW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AE8256C88;
	Fri, 15 Aug 2025 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281271; cv=none; b=TTb2VqI29CjCuYw/F/6MvZaEA7PwJROo7pmD9GLPpPvmLUj49lEl9lrgBcqsJDADQAEniYdfK53zuAkRvJpDeK4BCNb+o04BRv8xw7xAZ0oIRvmMlP4stJVBmm7CUMt/67vtPTMGHlHBhczvzrFbZszW1aZ1sUGwSXt06Gq0J6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281271; c=relaxed/simple;
	bh=MxlgQuGwyZk8QbcUKbfz0YUWxyR0dInwsN6Js2PxzWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pG999PRwIp71A1rLIOso+yFDjnJHDx2xvPChcIIX94990OgRfMKz/qFk46FFk/s1RBe+O8yCrK406ol6LHKVs3ln+ARdr1TkBex2wODOj5BkzYCV5mCWZoz7SVjOy2k+NRExK47ObgfI4DH1GxdVd19+NUccfQr1p8zTGj5PGaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rawF6wLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96276C4CEEB;
	Fri, 15 Aug 2025 18:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755281270;
	bh=MxlgQuGwyZk8QbcUKbfz0YUWxyR0dInwsN6Js2PxzWw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rawF6wLWD9Ev8c8wzM1CbhmZ61vO7QC9HSxvDTYZybGx7Om1w32RCYws3MXjOjd4W
	 Ek8zURlCmJ0nSjfgqosmvrTjWZEm2SWpdAex/iRIRB5yYhhO0GH6q+Sy01Kk4vXJrM
	 MSrDUaAqTTC1wC8oxy2tGnz2wwk0/jKR6oL5+6BSHE36dkddDHMLoUPIbg91sa8nsg
	 2bVMSITDKlAePRNYpf1HF+3bu5zySptTsoAbrjGoWlXmWIrIwA5z2BluzmQziPlqm4
	 gnOWgoCuxztxifDd8hPona/lOq8rM/7ulonDG5VWu0sMaZ5mTB3HVrVVG4n1dpjqvW
	 Lu/DizFLjD0/w==
Message-ID: <bd2d3077-7855-4195-a34b-a9b1688b75dc@kernel.org>
Date: Fri, 15 Aug 2025 20:07:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] rust: pci: use c_* types via kernel prelude
To: herculoxz <abhinav.ogl@gmail.com>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250812033101.5257-1-abhinav.ogl@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250812033101.5257-1-abhinav.ogl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 5:31 AM, herculoxz wrote:
> From: Abhinav Ananthu <abhinav.ogl@gmail.com>
> 
> Update PCI FFI callback signatures to use `c_` from the prelude,
> instead of accessing it via `kernel::ffi::`.
> 
> Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>

Applied to driver-core-testing, thanks!

