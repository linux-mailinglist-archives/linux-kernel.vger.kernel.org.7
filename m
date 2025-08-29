Return-Path: <linux-kernel+bounces-791278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D395DB3B486
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2696D1B277B0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39D627A916;
	Fri, 29 Aug 2025 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRcbM9vk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC1E27587E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453218; cv=none; b=sI2tcBO8epl3C4W6OREq9KT8JBGsUQAMvfXAIZhr3KQYznKmMiTC7VMklEpr+bCEOxclc7i+rAwLNExrE5Dl7X6E4YR16+w1NsX46exr2bDTYUMX1vBw/lr4hQg0C4dlpunxq05wjjvm4a7069eJ+obqUHQlBoylv8WJxcASbUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453218; c=relaxed/simple;
	bh=Z94i9gHZhK9qlGBUPoapzmHdUDOpAXEMUEdUsunkD08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQUah7vD6aByHyvIRtQTgywfcM4BlfmT+BgOgmOPqTGq6SC2WSqlyPAH3JkOhdTJ2wtLi+YcIpucJSjZHWiVHXo/ZbZEIIqoHNvge/w3AhWecbDfvERvPvz1qeTF0eBqVDnCMJTl7BPxL1JwPw/iV9LXlzy6ueN8kQbL6r4OL9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRcbM9vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87859C4CEF0;
	Fri, 29 Aug 2025 07:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756453217;
	bh=Z94i9gHZhK9qlGBUPoapzmHdUDOpAXEMUEdUsunkD08=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SRcbM9vkSelOwSq6IZP2PMazztxRZDnSUI06RLcqTPbFfwmwKHXmmeFWSHRrIGTGD
	 1ME9fJNxk4TcpvmyX8AJL6vGE8TzvwgRJoKt3QKn4YJh5/qPk+jWiwxjSf6FhL7X/w
	 WSKs+i7C2OhJzVNWclwpoU3abXHOM/8lCPKrBADgcElIUTyCGCE4IYzpAM+Uxob7TQ
	 uOMDkV1NBZq72uDieKHsWCMKEl73SH8uTEAwcJSol9U9sb4cuUV5PcOSpoWKcItyoJ
	 uWAVHWnEXqIPEvWH+bLjDPXYhJXUh8z5FcuJmss7EhD/PD2xXy3Wf1rT44vlr8NmC/
	 0lmo796T1dE5g==
Message-ID: <6f32c400-1f8c-4367-8be9-f7082ea87626@kernel.org>
Date: Fri, 29 Aug 2025 09:40:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] gpu: nova-core: Boot GSP to RISC-V active
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, apopple@nvidia.com,
 a.hindborg@kernel.org, airlied@gmail.com, alex.gaynor@gmail.com,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 dri-devel@lists.freedesktop.org, gary@garyguo.net, jhubbard@nvidia.com,
 joelagnelf@nvidia.com, linux-kernel@vger.kernel.org, lossin@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, simona@ffwll.ch, tmgross@umich.edu,
 ttabi@nvidia.com, tzimmermann@suse.de,
 Nouveau <nouveau-bounces@lists.freedesktop.org>
References: <20250827082015.959430-1-apopple@nvidia.com>
 <20250828083737.22214-1-ojeda@kernel.org>
 <DCEKTF8CP2GF.ED9G9ECQMBHM@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DCEKTF8CP2GF.ED9G9ECQMBHM@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/25 5:03 AM, Alexandre Courbot wrote:
> On Thu Aug 28, 2025 at 5:37 PM JST, Miguel Ojeda wrote:
>> On Wed, 27 Aug 2025 18:19:57 +1000 Alistair Popple <apopple@nvidia.com> wrote:
>>>
>>> This series builds on top of Alex's series[1] to continue initialising the GSP
>>> into a state where it becomes active and it starts communicating with the host.
>>
>> No big deal, but in case it helps since probably it was not intentional given
>> the rest of the people is there: the rust-for-linux Cc is missing.
> 
> This did happen to me once as well - should we add the rust-for-linux
> list to the Nova MAINTAINERS entry to protect against this?

I'm happy about every potential additional reviewer for Nova, but I'm not sure
it scales very well for the rust-for-linux if we get more drivers. :)

