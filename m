Return-Path: <linux-kernel+bounces-761111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA814B1F485
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 14:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3B718C2E5F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 12:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DF727FB27;
	Sat,  9 Aug 2025 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhxG4HX6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459B2459D7
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754740842; cv=none; b=NYzilqjqCXxzFl5BNmppCofacPucGovK2rvuemU1lY0tyFi6V7N9ruLZ95sDmxJ53ilDRJk93AtY2vfp5jN2spaEZmGPafKR/zHF+Puzmya8/UIQbNjW8y4YgukzlGdUDz9N7oUy/grZyXbg4d5cV4dWwDS9r2YFiVzeBCuk95E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754740842; c=relaxed/simple;
	bh=b1HvrEb561Jsz2wV3a/DN0hWDTp3a+adcs+a8JqHV8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9pEfT/pPVJ2EZEKE6OZAqF1uUtwX3D9YgmjqFr+JKCClaGQt/UL8VA4eP7NGXPpltjxr6TowPeZB6IPxGmylmesYwg5ED1Jc/aWhtx3J39bdBcy8jI7NsCkpSfC6UKzvduDmwnlr2Patnr696ZhHx6/ru3Rz4luq7GWDUS8fwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhxG4HX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D750BC4CEE7;
	Sat,  9 Aug 2025 12:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754740841;
	bh=b1HvrEb561Jsz2wV3a/DN0hWDTp3a+adcs+a8JqHV8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YhxG4HX6Uc0gYbFCOogW/OLTazlNMsMjO1eVi1aWGNq9ClErv2YgSwOMP/lIAiXKg
	 1/MQVQVPsfHoez7UX2kWbs+pMHCJcBan/bAovoXjjMewbippBv3CwIaKGDdf9fgefS
	 yfI3zAPJ8L5bmjzrsroM4HvZW5Jiy1LJ7GQwRrbomjn8CMVyHlBL5wdH3YRTqAvF0/
	 7MIQ/UduVFqEznGXLKaqM3MHmddxq+yfNyssUvD5D4SNRxBDsBMGLGpHWQ02f58KNa
	 zY4JgB1aaaLtLasXxnV/MhfuBi+rHfOt0njB51KL5quqlTyqVQ2gmi4MQwDUH3E5Kc
	 Ubfj1bhUyFtBw==
Message-ID: <409c30fa-5f82-4da5-95f1-765399b16add@kernel.org>
Date: Sat, 9 Aug 2025 14:00:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: Remove surplus struct member
To: Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250801074531.79237-2-phasta@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250801074531.79237-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/25 9:45 AM, Philipp Stanner wrote:
> struct nouveau_channel contains the member 'accel_done' and a forgotten
> TODO which hints at that mechanism being removed in the "near future".
> Since that variable is read nowhere anymore, this "near future" is now.
> 
> Remove the variable and the TODO.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Applied to drm-misc-next, thanks!

