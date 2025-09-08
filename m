Return-Path: <linux-kernel+bounces-805778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA91DB48D43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F8E189E258
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C032FE566;
	Mon,  8 Sep 2025 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/4XPl0G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3331E51FB;
	Mon,  8 Sep 2025 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334040; cv=none; b=QaaRfigfdD/lSKpToGHoUf1zhsqgfIjBXnlrJG5RFse2qFb3RI/iL8nZBXWeu60xTRb8adaskx8d7xduhkt+J2mx5bZk4pgYSByUwufFFNcoRBBuJhamRCg/K1DFuEQo5O2837ugB/XvsXqzgRdVql5KevnvgdHzboE8Piztdd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334040; c=relaxed/simple;
	bh=MQo3B3xE2J4C5YV7vElpRMlKdfQxIsL88C+y00Of4+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqaJ1Eo79QnxcBVPkkSYpC0ey2qi9qdbxVo9hqizjwgscxxN+lTJhKJOfsUiZ5TvmAhKvXHDNKIPoh1yJQG3kV7AzmXb2mLYtjkpRJSaRxuXrtqrqYAklLEo/Su89QEtrAQOK8qTCOt8PcavrWdBihBSoOrU7mIMEZZBjcmpu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/4XPl0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F356C4CEF1;
	Mon,  8 Sep 2025 12:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757334040;
	bh=MQo3B3xE2J4C5YV7vElpRMlKdfQxIsL88C+y00Of4+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r/4XPl0GYAWlfqhdbB985JBAGviphT2ad3keuexy0YcdL0QHKSGRFk+e0/0SxfvpN
	 kkZjHjr2OlGe4afVhWrU3fYSOcoilCKTHSXwvTFzY4RybxPUpEdf/MbAy4/dj9zrd2
	 39Nq+y52Qd92QWCsAic348DIwvrUpy57UaaQFzGXvAggLPQO3yCc4vi+gZ2ryV6KhJ
	 ZWj2V/z1P4jKD1dNZSGVUEGg8SHdic/VHMlxaLQIL/ddrLCWueHPx0fYta/VL4q85Y
	 nnNa435SG5pXsx2UwsFF2ciyLprv0k1QFHcgAbimegJzU08iH8r9h6MIDaWbRilw5h
	 BhmSwT7egKKaQ==
Message-ID: <7aa3f464-a3d0-47a0-b044-d8db93f45918@kernel.org>
Date: Mon, 8 Sep 2025 14:20:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/gpuvm: add deferred vm_bo cleanup
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Matthew Brost
 <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Steven Price <steven.price@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20250905-vmbo-defer-v1-0-7ae1a382b674@google.com>
 <20250905-vmbo-defer-v1-1-7ae1a382b674@google.com>
 <20250905152505.005a610d@fedora>
 <CAH5fLghgqv0mNYf8r-rdeBaCGxYsdkBouqgo_ohx3DYHwpcZRQ@mail.gmail.com>
 <DCL8DQV23FIZ.KJ74UQ9YOFZV@kernel.org> <aL1pSFB9iBsfHFM_@google.com>
 <DCMJ6K06T63T.2UBTM1RL4YJ0A@kernel.org> <aL1u_YxOkuj1kIq6@google.com>
 <20250908091140.44856fde@fedora> <aL6TJYRmWIkQXujj@google.com>
 <DCNAE3CJMEJ0.JH1F0MJABXQI@kernel.org> <20250908122002.2c80dd3a@fedora>
 <DCNDGFE7RR5Q.X3PCDW0KIX89@kernel.org> <20250908141156.3dbdea0b@fedora>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250908141156.3dbdea0b@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/25 2:11 PM, Boris Brezillon wrote:
> On Mon, 08 Sep 2025 13:11:32 +0200
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>> I'm saying exactly what you say: "has to be a special unlink function" ->
>> drm_gpuva_unlink_defer_put(). :)
> 
> I don't see how calling drm_gpuva_unlink() instead of
> drm_gpuva_unlink_defer_put() would leak the vm_bo though.

Initially (i.e. a few mails back), it sounded to me as if you'd propose to drop
the drm_gpuva's vm_bo reference only when it is freed.

>> No, drivers can't iterate the evict/extobj lists directly; or at least this is
>> not intended by GPUVM's API and if drivers do so, this is considered peeking
>> into GPUVM internals, so drivers are on their own anyways.
>>
>> Iterators, such as for_each_vm_bo_in_list() are not exposed to drivers.
> 
> Okay, that's a good thing. I thought Xe was doing some funky stuff with
> the list...

Maybe, I don't know. If they do so, the should send patches adding the
corresponding iterators and provide a rationale why drivers need to access those
lists directly and why we can't provide an API that handles the overall
use-case, such as drm_gpuvm_prepare_objects(), etc.

