Return-Path: <linux-kernel+bounces-771328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25C4B2858A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7A6601F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD0F2F9C23;
	Fri, 15 Aug 2025 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/LumEHA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A0C3176FB;
	Fri, 15 Aug 2025 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281309; cv=none; b=Q1NhX/jBnv+aCO5+f/mBME48KZJeTv8kEa2k4558lyoDs5fKAxMtjIpmZFkF8IwX2qiwuyWwPj4qWpJjyrhV3v/8yKfOn2cHsp2PrmPdeGCMuz5WcoXJ0J9JMOx+uNmpmxWrPpQo/qEOGka8cnA8/IOfNsUtT5gl7jEkXu3VNpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281309; c=relaxed/simple;
	bh=tISLtfMkGFV/6RGVfJtcWtFw5ZZyQis1cwaEUXqsakQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MH0P52v8IK+DZhAtD2RWXXFUJFgjDH2C1ArmkSplO/NAVhfIEWfOBFuqtGbKTgUJsT17amCHaEQ1468Z87G5gsStWHo5ZXEGR7vPbdQxmuIw8I0gSetF87ociekuz7TVwiSH5iXPs9HwagstbCniG6QtPih06QiUu1Kvrq+jC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/LumEHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DD6C4CEEB;
	Fri, 15 Aug 2025 18:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755281309;
	bh=tISLtfMkGFV/6RGVfJtcWtFw5ZZyQis1cwaEUXqsakQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L/LumEHANlSXN23uShZOeep3CRTsmsHFWRd/PD/M7ptb91tJnHKWPVRtwkuxnnu0h
	 LBhKFoeoG0BgnJ8qbTy41HGrJrOHS8FcO4CbwwokYt42h2gJm4RJuKFQs+0rGkimJJ
	 lF49AvgmZU2RQrdVR85ZMMzLnT9EyQ59DwwFlbhFOSr6vY6XWV89/Q2NTNeR7q3rxN
	 G+VUwBgI4SjKqDsPca5eSEpxsI0qipWTsKbFdEWTULIF6pdxxmXKI/b8nBbBmxs6y3
	 UGZeiD2Wc9C8eqYcHI8E9E/Z7ValUpkcMhdZV1UpEx/FU883LiedcJ5tz7SwtPTEnX
	 whcBYNJOumH8Q==
Message-ID: <a034c26f-b3f2-4fe6-91ca-b738d2a2dcf0@kernel.org>
Date: Fri, 15 Aug 2025 20:08:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: auxiliary: Use `c_` types from prelude instead of
To: Abhinav Ananthu <abhinav.ogl@gmail.com>
Cc: gregkh@linuxfoundation.org, david.m.ertman@intel.com,
 ira.weiny@intel.com, leon@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250812075109.4099-1-abhinav.ogl@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250812075109.4099-1-abhinav.ogl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 9:51 AM, Abhinav Ananthu wrote:
> Update auxiliary FFI callback signatures to reference the `c_` types
> provided by the kernel prelude, rather than accessing them via
> `kernel::ffi::`.
> 
> Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>

Applied to driver-core-testing, thanks!

