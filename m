Return-Path: <linux-kernel+bounces-766995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E25EB24D94
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36BE3A6BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCBD264609;
	Wed, 13 Aug 2025 15:32:47 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3891CEEBE;
	Wed, 13 Aug 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099167; cv=none; b=dhVMRPtUz7rO5eePH7jnpL7jI/q9xzRzDTGn1tDFywe4jrF493mut92fUmhh/q6pW6g84WHlT49vkdaOjH4Jr7JNsSylIhB+Kwhfn6hOov7TgIXhe2zgwn61Ocz79F4Lul8tdAH8Np8UoOTlsGPr9hcYTcf+fcWcCISJkbVUXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099167; c=relaxed/simple;
	bh=D/uvKpo6QWrljkkhIfUFoaMPZb+JGNXElpWPMpHscq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=op5AcbRd9fMsagukSrGg4Lum638ueZSK/VQFzNg+XwS7Bj0PyZ0CuRZ2/wRyCLETwB6meBc1NT1Jxxg92QbsTu4kVzdhIG2Wpf/FcfbroFTKo+82R/qorly2ImnzaPK9eU/89asuECODtFh+Ze/bdZPD+LISkDGuKTsJCz89mZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [192.168.12.24] (54-240-197-224.amazon.com [54.240.197.224])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id D7B93400AA;
	Wed, 13 Aug 2025 15:32:41 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 54.240.197.224) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[192.168.12.24]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <ade03ed8-e815-4135-9b75-ac7f58c5693a@arnaud-lcm.com>
Date: Wed, 13 Aug 2025 16:32:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] checkpatch.pl: Add warning for // comments on private
 Rust items
To: joe@perches.com
Cc: apw@canonical.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20250729195615.34707-1-contact@arnaud-lcm.com>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <20250729195615.34707-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <175509916269.4108.369360240532251769@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Hi !
Just checking in on this patch series. Is there anything I can clarify 
or improve to help move this forward ?

Cheers,
Arnaud

On 29/07/2025 20:56, Arnaud Lecomte wrote:
> Hi,
>
> Background
> ----------
>
> The Rust-for-Linux project currently lacks enforcement of documentation for private Rust items,
> as highlighted in https://github.com/Rust-for-Linux/linux/issues/1157.
> While rustc already lints missing documentation for public items, private items remain unchecked.
> This patch series aims to close that gap by ensuring proper documentation practices
> for private Rust items in the kernel as mentioned in the coding
> guidelines for the Rust linux kernel: Documentation/rust/coding-guidelines.rst.
>
> The actual solution comes in several parts
> ------------------------------------------
>
>   1) Patch 1 : Implements detection logic to emit warnings for improperly
>   documented private Rust items (e.g., // comments instead of ///)
>   through a set of heuristics.
>   2) Patch 2 : Adds an auto-fix mechanism via the --fix option to help
>   developers correct documentation issues.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1157
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> --
> 2.43.0

