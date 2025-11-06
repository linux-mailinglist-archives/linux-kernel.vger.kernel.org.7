Return-Path: <linux-kernel+bounces-889425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EEFC3D853
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4EA3A3FF1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AAD306D3E;
	Thu,  6 Nov 2025 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDW3A3Jq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83CE2153E7;
	Thu,  6 Nov 2025 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762465326; cv=none; b=PENh8v+J0E4R90xnsUA5cDTeCZ/9Umw/Z++3gkF8PegSWhm2NtUoxlOdyXjToPoS6lgl2C5bAJ+hVHKzG/6PVZQ5gIgh80T9/RNpVLeESp+UkChM2M/99rpEqA3+i2+WdBAAcrvLzuUnH8J2JcQb6bOOU+NVbxmLKRGuHo9MHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762465326; c=relaxed/simple;
	bh=HBOXIy/p5V/ZxzeiuRMeak4MAcNhX6QDmMzw4cwz5F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UK32K8BHlW4mDWAIh3Exdvgek0qnrNFy6qKTW3tIF4e06EBiq80L+Oec/q+2SMtnDcFQhzYOJx2dHFB188MyNUDtOoiXPEO94zcKPxTCaaoOjeMT9t3FJzdH8H8LtD/0fp1CfZeSo7NDsmYlTJ4DqgBAImR3gSgEN+ON9GimPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDW3A3Jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CB6C4CEFB;
	Thu,  6 Nov 2025 21:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762465326;
	bh=HBOXIy/p5V/ZxzeiuRMeak4MAcNhX6QDmMzw4cwz5F4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jDW3A3Jq30LBdpxs0FpnswBnEhjdl+I6G+uilY2I8mNNWtN04l7vn1tBOsnsuJrCe
	 UqnZcmxitkCDDT0rcq4QjEUGn0O8wgVH9k19AsdKVQSMJ8DL+PmhVOH7AQ/8bVhr2T
	 eWDAeMa9Co9xg+4cmFuByJpw92NSJM3r6NH+dDrLCg57BDpTo7z5Og30JJ5xaxvOim
	 zRFunfhIECox9QUAyFChYj4vkgcIrNEO5pOlEL30QOZGrx1kgoKhZEwKcHTdL+h1gl
	 qsTL4eYTrDGkxEAgMu0C8ThQa1UIygqq+LeS5xwZXSuKBj8rIT5bL+aPuVTnCKclMS
	 ycQB0z1YJIhiA==
Message-ID: <1c86eda2-b9ca-426c-8813-f91ddcd22085@kernel.org>
Date: Thu, 6 Nov 2025 22:42:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] gpu: nova-core: use gpu::Architecture instead of long
 lists of GPUs
To: Timur Tabi <ttabi@nvidia.com>, John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 "lossin@kernel.org" <lossin@kernel.org>,
 "a.hindborg@kernel.org" <a.hindborg@kernel.org>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "aliceryhl@google.com" <aliceryhl@google.com>, Zhi Wang <zhiw@nvidia.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
 "ojeda@kernel.org" <ojeda@kernel.org>, "tmgross@umich.edu"
 <tmgross@umich.edu>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
 Edwin Peer <epeer@nvidia.com>, "airlied@gmail.com" <airlied@gmail.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "gary@garyguo.net" <gary@garyguo.net>, Alistair Popple <apopple@nvidia.com>
References: <20251106035435.619949-1-jhubbard@nvidia.com>
 <20251106035435.619949-7-jhubbard@nvidia.com>
 <fc6616d404d8fd04a62bd90fa0f79e2c9d2a17da.camel@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <fc6616d404d8fd04a62bd90fa0f79e2c9d2a17da.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/6/25 3:41 PM, Timur Tabi wrote:
> On Wed, 2025-11-05 at 19:54 -0800, John Hubbard wrote:
>> -use crate::gpu::{Architecture, Chipset};
>> +use crate::gpu::{
>> +    Architecture,
>> +    Chipset, //
>> +};
> 
> I don't think this change should be part of this patch.  

I think it would be good to send a patch converting nova-core (and nova-drm) to
kernel vertical import style at once and then rebase other patches on top of that.

