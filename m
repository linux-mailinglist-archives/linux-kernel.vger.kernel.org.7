Return-Path: <linux-kernel+bounces-794345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FF4B3E055
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2AF0189F1EA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A50311958;
	Mon,  1 Sep 2025 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3zyxOqO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD688311592;
	Mon,  1 Sep 2025 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723061; cv=none; b=sxrBxHYPSZsp6hbsCT2nBOZ1PMICWhQ6n4THB56sbsUc0+QybvXA2CO85VFZdNxUc9y6Lt00o5WBWtsb5B6712fFq26A4eJ2NuncoP8+eYhS1Hzmok2EADmB7VUlksufYltvwTEtXWlolRBntTc7RexsA7QDZF+NcP/uI/ZPiB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723061; c=relaxed/simple;
	bh=WFGY4iWVgdB0iqOWCIEY4oE+1wGv78wpSjqVqokCbuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiMP6Gt7SEgmYuuoiaV3v7rj2N4V3xNlBs7PtdppJ1l0XKwAMy2JcCb5K4DQ72gijb7ZDIyOhCbvV7tru98Ex95ZD8AVlVkoBu3wJRA6J5c0A8JLDJa65aWVVvW06ka0b4y2j4xyuQEWbHaivzvGqf9FsXET6g901EBJP7UZ7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3zyxOqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6184EC4CEF8;
	Mon,  1 Sep 2025 10:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756723061;
	bh=WFGY4iWVgdB0iqOWCIEY4oE+1wGv78wpSjqVqokCbuo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e3zyxOqOGo97AMIfSE8iO5OAdozg7aZA4I7FsayqEiBT0GpqjXY+pkT0Oq+U63i13
	 TJVxYN33NSTyQKhljy+IPaWL1Cy46Flti9bLUHGFcirWTc9GJLlUbukVyO50Zy+3WX
	 8ZbBU+zRH6ZPqEr0GrPzWeWdMOOmiowrOocStGLHG4Dn4FYrcrqGU5IXOcNsCylZLg
	 JHnPZWOv3ZPyt9Q4yQzhy0NQhkxCE6zjPaWLduDE10rWC9HSPDN7sRZ2OSn+Hif1ow
	 F3P2/4yLIKJ1GebTU4wbwmludSNN6nJs0gJVcifdqlk4xTth+izx4wlw53JgX2Pzaf
	 WAG+NffUzySNw==
Message-ID: <fc15c557-623b-40b5-8254-53888c847da6@kernel.org>
Date: Mon, 1 Sep 2025 12:37:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] gpu: nova-core: vbios: simplify device use
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Fernandes <joelagnelf@nvidia.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250808-vbios_device-v1-0-834bbbab6471@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250808-vbios_device-v1-0-834bbbab6471@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/25 4:46 AM, Alexandre Courbot wrote:
> This small cleanup series simplifies the use of `Device` in vbios
> methods.
> 
> The device is used for logging purposes only; thus we don't need a
> pci::Device, neither do we need it to be bound. This latter property
> allows us to store an `ARef` to it into structures that require logging
> instead of having all their methods take an extra `dev` argument.
> Removing this argument streamlines the code a bit.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

