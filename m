Return-Path: <linux-kernel+bounces-818848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32983B5971E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0BC162575
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFE92DC32C;
	Tue, 16 Sep 2025 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PngJuDT/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589421FF2A;
	Tue, 16 Sep 2025 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028360; cv=none; b=EjhPqC4sPjL7NNhAkwPKO3fiLB50nwU5XBBUqdlwbaVnzSDZ89rs31PS8lQINBmq87l7n3HwTK28u+pr3y/ecJc9iZXZxUIE9Yeo5b3Yhl2WUgNpz9rzRffir5XGBbdcAkSIEqq+wsh2yABpaUNPA4uPNvcKd5oZrz4r6gZOEb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028360; c=relaxed/simple;
	bh=yBY0d4Ct6jbMm6HpvRcfZQ1Ynt4h6d31F0ra2LRbV+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz/HJAqP2haZj5XOpdjfQhURNhEsQF3ahHMqOsorm+gq3bEAed8AWJidI7hGBlDWsn4T13vawTFO0Rib/O4sHxCv1Mwpdo/m/8nkNkxdblDP6dhkccaO6C/sr8Ds05VihstY7rduG3hIjRvtGbpZIbg3uNeT+CJk7gtGY8ntBbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PngJuDT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD74AC4CEEB;
	Tue, 16 Sep 2025 13:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758028359;
	bh=yBY0d4Ct6jbMm6HpvRcfZQ1Ynt4h6d31F0ra2LRbV+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PngJuDT/3fD1jC8z1TYxDvJBunqeCJc8qbTBYW2Ixf7QmWFeGr/UeSw6gAs5Xcio3
	 /KLFtSS3AJHNby/pFeInTSiGdvbwz5gKgsk4vKTKvS5EeoJtJ0bOGXGag/xYB1u9JJ
	 zUDt53JfvCvMpIePQcwiI5xPnu9uDfiMqLi7cguc=
Date: Tue, 16 Sep 2025 15:12:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: JaimeF <jaimefine6@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, onur-ozkan <work@onurozkan.dev>
Subject: Re: [PATCH v2] rust: auxiliary: fix "initialialized" typo
Message-ID: <2025091621-atrocious-unaired-0b9a@gregkh>
References: <20250916130103.22946-1-jaimefine6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916130103.22946-1-jaimefine6@gmail.com>

On Tue, Sep 16, 2025 at 01:01:03PM +0000, JaimeF wrote:
> From: Jaime Fan <jaimefine6@gmail.com>
> 
> Fixes a spelling mistake in a comment: "initialialized" → "initialized".
> This improves clarity in the documentation and avoids confusion for readers.
> 
> Suggested-by: onur-ozkan <work@onurozkan.dev>
> Link: https://github.com/Rust-for-Linux/linux/issues/1187
> Signed-off-by: Jaime Fan <jaimefine6@gmail.com>
> ---
> v2:
>   - Fixed Signed-off-by name to match From: line
>   - Added explanatory changelog paragraph before tags

There has been way more than just 1 previous version of this patch
submitted :(

