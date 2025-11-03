Return-Path: <linux-kernel+bounces-883567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCAAC2DC57
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA7D44E2EEB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7BE31D73F;
	Mon,  3 Nov 2025 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwFVrgac"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725386352
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196368; cv=none; b=Fnj97jfQhRVhOkXMPyx1AZBtG17sydGqNmfqOikOaSizXrXjOM1s/W5S6H4vYwDyPONWZa5QqVoQfbZBEhrWQzASDb+qnEA/6qgHZRCT5FNpLIRHDZQ4W6WJwoI+L9jUhjAUBBWdQRx2eFJ35/a3sDGHqozBog9ZtTq5qjyD8L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196368; c=relaxed/simple;
	bh=qGYPtH1DKKO7bv/UCrb6DNfTj/ArCEMFV9JX+yeip4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JO26orzxtB3lq9l+jQrm4DSWc5868jaIBibCAYtQJxAh5ZU3aGNyf73kwfoG8NJuUhvTb7hUITVD4agRilm8QT6yAW4DIPl3v0Xi/7lNdxGROHbJrIz/U2UWOrcKeO+vsRGwY9u5N+0COZT34/RV2YnrTSOyHx1VK/k4bHeNFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwFVrgac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFEBC4CEE7;
	Mon,  3 Nov 2025 18:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762196368;
	bh=qGYPtH1DKKO7bv/UCrb6DNfTj/ArCEMFV9JX+yeip4g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FwFVrgacCwZJs1pZK+sgHZpaAUp1hY3Fm0urov475+B7JhziE5wPGRZj2murizz80
	 WIFbL4q2uA4dxAnf+YupHn64z7czwGHYI4hV1J2xq8NsuFfgXHrf4JNxAAXtpCo2wM
	 eqfzbGzIa4WKiyi9279iOfZgPE8Y1uww4ZRb4mVAkrwKNT2qIv8osItG5ncV9uZiBI
	 7sdVJOUJholq/A7Uar5/AZ7SarSaKlHKCKc/wySV0nA8NDUKZOJbslgkSP28naN4Js
	 m+w1g3xxx9z8TxSfHaH9G4dw10YvPY9zGxOPaChIJTTQDYxn5y3YUqza1dhLVuliK9
	 IhaKlgOODdqrw==
Message-ID: <2c414360-c621-4869-9d61-0e91efdf46b6@kernel.org>
Date: Mon, 3 Nov 2025 19:59:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] regmap: i3c: Use ARRAY_SIZE()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20251103180946.604127-1-andriy.shevchenko@linux.intel.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251103180946.604127-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 7:09 PM, Andy Shevchenko wrote:
> Use ARRAY_SIZE() instead of hard coded numbers to show the intention
> and make code robust against potential changes.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

